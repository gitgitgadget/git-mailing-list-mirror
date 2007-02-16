From: Bill Lear <rael@zopyra.com>
Subject: Full disk behavior of git
Date: Fri, 16 Feb 2007 10:33:49 -0600
Message-ID: <17877.56557.546383.815806@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 17:34:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI62m-0006vV-18
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 17:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945994AbXBPQeN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 11:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945993AbXBPQeM
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 11:34:12 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61403 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945991AbXBPQeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 11:34:10 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1GGY9620840;
	Fri, 16 Feb 2007 10:34:09 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39927>

I wanted to report an error we belatedly uncovered while using 1.4.4.1
to pull into a repo on a disk that filled up.  We run a nightly script
to build our code base and we did not notice these errors in the build
until a few days later.

The build scripts continued to run each evening after this write
failure happened, and a subsequent pull showed this:

% git pull
remote: Generating pack...
remote: Done counting 369 objects.
remote: Result has 246 objects.
remote: Deltifying 246 objects.
[...]
remote: Total 246, written 246 (delta 150), reused 190 (delta 95)
error: Could not read 828c0a0649d2d6b43ed13853bba33f7764f034fa
* refs/heads/origin: fast forward to branch 'master' of
ssh+git://source/repos/git/fus
   old..new: ebeb03b..b7e8cd6
error: Could not read 828c0a0649d2d6b43ed13853bba33f7764f034fa
Updating ebeb03b..b7e8cd6
Fast forward
  src/cp/tu.cc                                 |    3 +-
  src/cp/tu.flw.cc                             |   81 +-
  src/cp/tu.plt.cc                             |    3 +-
[...]

and the pull seemed to complete ok.

We checked the repo:

% git-fsck-objects --full
error: 08b4bc0910b3e945312e3d0ed3aea77287b61ebf: object not found
error: 828c0a0649d2d6b43ed13853bba33f7764f034fa: object not found
error: 93edcb9bcaacb3e7caddbcc4188dd5b96ee5c8b2: object not found
error: ecf4705ae985133dabdc207d81bd2d9c5a4f1402: object not found
dangling commit a7ccd43df37e8c2551358bc32e7341be6a21cb16
dangling tree 2f54a7d7980dac6bb6c4f54e54793e24ef0ac892
dangling tree 9a35dfe6020c361e3fe15bddd2c80d7cbcd665fe
dangling tree 0056712d4f15f5bce79743512ec30d8360789a71
dangling tree 899b33309b5a5530e331841eb82d64882b577181

I'm obviously unsure as to what exactly happened, but I did want to
point this out in case git should be cleaning up these objects on a
failed pull --- not that I think it necessarily should, but I did want
to take this as an opportunity to share what is probably a rare
failure scenario and let others ponder.

As a final point, our "build master" now informs me that he has
been trapping error status from git pull, e.g.:

  git pull || { echo "pull failed"; exit 1; }

however, it appears that the pull read errors above are not resulting
in an error status being returned.


Bill
