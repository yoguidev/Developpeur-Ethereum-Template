// SPDX-License-Identifier: GPL-3.0
// Exercice de creation d'un system de vote
// */

// Désolé j'étais de mariage ce week end, il me manque donc une dizaine d'heures de travail ! :(

pragma solidity 0.8.14;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol';




contract Voting {

    uint winningProposalId;

    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint votedProposalId;
    }
    

    enum WorkflowStatus {
        RegisteringVoters,
        ProposalsRegistrationStarted,
        ProposalsRegistrationEnded,
        VotingSessionStarted,
        VotingSessionEnded,
        VotesTallied
    }

    event VoterRegistered(address voterAddress); 
    event WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus newStatus);
    event ProposalRegistered(uint proposalId);
    event Voted (address voter, uint proposalId);



// Début Creation de la liste blanche des votants

    // Adresse ETH du propriétaire du contrat
    address owner; 

    constructor() {
        owner = msg.sender; // On initialise l'adresse du propriétaire du contrat
    }

    // Seul le proprietaire du contrat peut ajouter des adresses d'electeurs dans la liste blanche
    modifier onlyOwner() {
    require(msg.sender == owner, "Vous n'etes pas autorise a ajouter des votants");
    _;
    }

    mapping(address => bool) whitelistedAddresses;

    function addUser(address _addressToWhitelist) public onlyOwner {
    whitelistedAddresses[_addressToWhitelist] = true;
    }   

    function verifyUser(address _whitelistedAddress) public view returns(bool) {
    bool userIsWhitelisted = whitelistedAddresses[_whitelistedAddress];
    return userIsWhitelisted;
    }

// Fin de la creation liste blanche des votants




// L administrateur commence la session d enregistrement des propositions

    struct Proposition {
        string description;
        uint voteCount;
    }

    mapping(address => string) public propositions;

    // Fonction d'ajout des propositions
    function newPropaOwner(string memory propa) public onlyOwner {

        propositions[msg.sender] = propa;
    }

   
// Les électeurs inscrits sont autorisés à enregistrer leurs propositions

function newPropaAll(string memory propa) public {

        propositions[msg.sender] = propa;
    }


}


// Désolé j'étais de mariage ce week end, il me manque donc une dizaine d'heures de travail ! :(
// J'ai donc fait ce que j'ai pu ...