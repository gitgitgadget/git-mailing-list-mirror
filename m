From: bshOriginal <mindplayintricks@gmx.de>
Subject: Git range merge (cherry-pick a range)
Date: Thu, 16 Jul 2009 01:11:23 -0700 (PDT)
Message-ID: <24512201.post@talk.nabble.com>
References: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:11:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRM41-0003gZ-1X
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 10:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbZGPIL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 04:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbZGPIL0
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 04:11:26 -0400
Received: from kuber.nabble.com ([216.139.236.158]:56956 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbZGPILY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 04:11:24 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1MRM3n-0000QJ-Mx
	for git@vger.kernel.org; Thu, 16 Jul 2009 01:11:23 -0700
In-Reply-To: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil>
X-Nabble-From: mindplayintricks@gmx.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123384>


Playing around with GIT, we encountered the following strange situation for
which we would
like to have an answer:

Scenario
========

We want to merge the range B to D from branch B1 to master

Master:       o-
                  \
Branch B1:      A-B-C-D-E


Commit B:
---------
FluidSolver::FluidSolver(int argc, char* argv[]) {
    init(argc, argv);
    // test edit 1: a + b
}

Commit C:
--------
FluidSolver::FluidSolver(int argc, char* argv[]) {
    init(argc, argv);
    // test edit 1: a + b
    // test edit 2: a - b
}

Commit D:
--------
FluidSolver::FluidSolver(int argc, char* argv[]) {
    init(argc, argv);
    // test edit 1: a + b
    // test edit 2: a - b
    // test edit 3: a * b
}

Commit E:
--------
FluidSolver::FluidSolver(int argc, char* argv[]) {
    init(argc, argv);
    // test edit 1: a + b
    // test edit 2: a - b
    // test edit 3: a * b
    // test edit 4: a / b
}


Range merge (the GIT way):
=========================

1) Switch to Branch B1

2) Create a temporary branch which does not contain anything beyond commit D

   $ git checkout -b volatileBranch D

    Master:                 o-
                                \
    Branch B1:                A-B-C-D-E
                                                \
    Branch volatileBranch:              (A)-(B)-(C)-(D)

3) Rebase volatile branch to master from commit (B) to master's HEAD
   git rebase --onto master (A) 


    Branch volatileBranch:   (B)-(C)-(D)
                                     /
    Master:                      o-
                                     \
    Branch B1:                   A-B-C-D-E
                                       

Rebasing output:
----------------

First, rewinding head to replay your work on top of it...
Applying: test edit 2: a - b
error: patch failed: fluidsolver.cpp:28
error: fluidsolver.cpp: patch does not apply
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging fluidsolver.cpp
CONFLICT (content): Merge conflict in fluidsolver.cpp
Failed to merge in the changes.
Patch failed at 0001 test edit 2: a - b


When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".


Conflicts:
----------
FluidSolver::FluidSolver(int argc, char* argv[]) {
    init(argc, argv);
<<<<<<< HEAD:fluidsolver.cpp
=======
    // test edit 1: a + b
    // test edit 2: a - b
>>>>>>> test edit 2: a - b:fluidsolver.cpp
}


After manually resolving the conflict and continuing the rebasing 
with git rebase --continue, we are finally finished.

Since we only had updates in branch 1, it is astonishing that we get a
conflict at all.
Same situation works like a charme in subversion.
We would be happy to get an explanation for this merge bahaviour, since 
many edits in large projects could as a matter of principle result a lot of
merge conflicts
which all have to be treated manually.

We believe that GIT's interface for range merges needs to get more user
friendly.
Since steps 1) - 3) use already developed components of GIT, there should be
a layer above 'em
which performs a range merge by internally calling 1) - 3).

Example: git cherry-pick $from_branch@startCommitHash
$to_branch@endCommitHash 



Greetings,

Babak Sayyid Hosseini






-- 
View this message in context: http://www.nabble.com/cherry-pick---since---tp10105685p24512201.html
Sent from the git mailing list archive at Nabble.com.
