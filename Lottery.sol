// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract Lottery {
    address payable public owner;
    address payable[] public participants;
    

    constructor() {
        owner = payable (msg.sender);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function  getPlayers() public view returns (address payable[] memory) {
        return participants;
    }

    function enter() public payable {
        require(msg.value >= 1 ether);
        participants.push(payable(msg.sender));
        

    }

    function getRandomNumber() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function pickWinner() public payable onlyOwner {
        uint index = getRandomNumber() % participants.length;
        participants[index].transfer(address(this).balance);

        participants = new address payable[](0); 
    }
    modifier onlyOwner() {
        require (msg.sender == owner);
        _;
    }
}