From: James Farwell <jfarwell@vmware.com>
Subject: Bug: git-p4 can skip changes when syncing large from multiple depot
 paths
Date: Sat, 12 Dec 2015 02:52:51 +0000
Message-ID: <1449888770698.39553@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 12 03:53:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7aIx-00076F-7S
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 03:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbbLLCwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 21:52:55 -0500
Received: from smtp-outbound-1.vmware.com ([208.91.2.12]:48132 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751571AbbLLCwx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 21:52:53 -0500
Received: from sc9-mailhost1.vmware.com (sc9-mailhost1.vmware.com [10.113.161.71])
	by smtp-outbound-1.vmware.com (Postfix) with ESMTP id 10FD628BF9
	for <git@vger.kernel.org>; Fri, 11 Dec 2015 18:52:52 -0800 (PST)
Received: from EX13-CAS-009.vmware.com (ex13-cas-009.vmware.com [10.113.191.61])
	by sc9-mailhost1.vmware.com (Postfix) with ESMTP id D91CF184E9
	for <git@vger.kernel.org>; Fri, 11 Dec 2015 18:52:51 -0800 (PST)
Received: from EX13-MBX-031.vmware.com (10.113.191.71) by
 EX13-MBX-008.vmware.com (10.113.191.28) with Microsoft SMTP Server (TLS) id
 15.0.1076.9; Fri, 11 Dec 2015 18:52:51 -0800
Received: from EX13-MBX-017.vmware.com (10.113.191.37) by
 EX13-MBX-031.vmware.com (10.113.191.71) with Microsoft SMTP Server (TLS) id
 15.0.1076.9; Fri, 11 Dec 2015 18:52:51 -0800
Received: from EX13-MBX-017.vmware.com ([fe80::f930:f6a8:dfb:ff54]) by
 EX13-MBX-017.vmware.com ([fe80::f930:f6a8:dfb:ff54%15]) with mapi id
 15.00.1076.010; Fri, 11 Dec 2015 18:52:51 -0800
Thread-Topic: git-p4 can skip changes when syncing large from multiple depot
 paths
Thread-Index: AQHRNIedmI4htV4mRk2xAvUDfpX0NQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.113.170.11]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282297>


Reproduction Steps:

1. Have a git repo cloned from a perforce repo using multiple depot paths (e.g. //depot/foo/ and //depot/bar/).
2. Add changes to the perforce repo in both depot paths. (e.g. 5 changes in each)
2. Do a "git p4 sync --changes_block_size n" where n is smaller than the number of changes applied to each depot path. (e.g. 2)


Expected Behavior:

All changes should sync and become commits in the git repo.


Actual Behavior:

All changes from the first depot path (if any) sync. After that only a small subset of changes from the remaining depot paths sync, causing some changes to be skipped entirely.


Best Guess:

I believe this was introduced in commit 1051ef00636357061d72bcf673da86054fb14a12. The important code in question is the p4ChangesForPaths function, which contains a for loop that iterates over the depot paths, which then contains a while loop which iterates over the blocks. This change modified the inner while loop so that with every iteration it modifies changeStart, which causes the original value of changeStart to be lost. The first iteration of the for loop will correctly iterate across all the blocks until changeStart is within one block of the last change number, but then all subsequent iterations of the for loop will use that final changeStart value, causing any changes in those depot paths in earlier blocks to be skipped.

This can probably be easily remedied by using a temporary "start" variable for the block iteration, much like there is already a temporary "end" variable, and resetting it to the value of changeStart at the top of the for loop. (Note: this appears to be how the code prior to 1051ef00636357061d72bcf673da86054fb14a12 functioned).


Thanks!
- James