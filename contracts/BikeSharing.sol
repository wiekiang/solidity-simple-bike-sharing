//SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

contract BikeSharing {
    
    enum Statuses { Available, Rented }
    
    Statuses currentStatus;
    address payable public owner;
    
    event Transaction(address _occupant, uint _value);
    
    constructor() {
        // owner = msg.sender;
        currentStatus = Statuses.Available;
    }
    
    modifier onlyWhileAvailable {
        require(currentStatus == Statuses.Available, "Currently Rented!");
        _;
    }
    
    modifier cost(uint _amount) {
        require(msg.value >= _amount, "Not enough ether provided!");
        _;
    }
    
    receive() external payable onlyWhileAvailable cost(1.5 ether) {
        currentStatus = Statuses.Rented;
        owner.transfer(msg.value);
        emit Transaction(msg.sender, msg.value);
    }
    
}