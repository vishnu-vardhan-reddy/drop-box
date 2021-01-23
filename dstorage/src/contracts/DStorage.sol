pragma solidity ^0.6.0;

contract DStorage {
    // Name
    string public constant name = "Dstorage";
    // Number of files
    uint256 public fileCounter = 1;
    // Mapping fileId=>Struct
    mapping(uint256 => File) public files;

    // Struct
    struct File {
        uint256 fileId;
        string fileHash;
        uint256 fileSize;
        string fileType;
        string fileName;
        string fileDescription;
        uint256 uploadTime;
        address payable uploader;
    }

    // Event
    event FileUploaded(
        string fileHash,
        string fileName,
        uint256 uploadTime,
        address uploader
    );

    constructor() public {}

    // Upload File function
    function uploadFile(
        string memory _fileHash,
        uint256 _fileSize,
        string memory _fileType,
        string memory _fileName,
        string memory _fileDescription
    ) public {
        // Make sure the file hash exists
        require(
            bytes(_fileHash).length > 0,
            "DStorage/uploadFile -> no file Hash"
        );
        // Make sure file type exists
        require(
            bytes(_fileType).length > 0,
            "DStorage/uploadFile -> no file type"
        );

        // Make sure file description exists
        require(
            bytes(_fileDescription).length > 0,
            "DStorage/UploadFile -> no file name"
        );

        // Make sure file fileName exists
        require(
            bytes(_fileName).length > 0,
            "DStorage/uploadFile -> no file Name"
        );

        // Make sure uploader address exists
        require(
            msg.sender != address(0),
            "DStorage/uploadFile -> invalid uploader address"
        );

        // Make sure file size is more than 0
        require(_fileSize > 0, "DStorage/ uploadFile -> zero file size");

        // Add File to the contract
        files[fileCounter] = File(
            fileCounter,
            _fileHash,
            _fileSize,
            _fileType,
            _fileName,
            _fileDescription,
            now,
            msg.sender
        );

        // Increment file id
        fileCounter++;

        // Trigger an event
        emit FileUploaded(_fileHash, _fileName, now, msg.sender);
    }
}
