From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 12/14] git p4: fix sync --branch when no master branch
Date: Mon, 14 Jan 2013 19:47:06 -0500
Message-ID: <1358210828-2369-13-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:51:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuukW-0003V6-Sp
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266Ab3AOAvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:51:13 -0500
Received: from honk.padd.com ([74.3.171.149]:40009 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756762Ab3AOAvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:51:12 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id E1EF52F3F;
	Mon, 14 Jan 2013 16:51:11 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7766D28EC2; Mon, 14 Jan 2013 19:51:09 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213563>

It is legal to sync a branch with a different name than
refs/remotes/p4/master, and to do so even when master does
not exist.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt  |  5 +++++
 git-p4.py                 | 14 +++++++++++---
 t/t9806-git-p4-options.sh |  8 ++++----
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 7bd5c29..e79d046 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -112,6 +112,11 @@ will be fetched and consulted first during a 'git p4 sync'.  Since
 importing directly from p4 is considerably slower than pulling changes
 from a git remote, this can be useful in a multi-developer environment.
 
+If there are multiple branches, doing 'git p4 sync' will automatically
+use the "BRANCH DETECTION" algorithm to try to partition new changes
+into the right branch.  This can be overridden with the '--branch'
+option to specify just a single branch to update.
+
 
 Rebase
 ~~~~~~
diff --git a/git-p4.py b/git-p4.py
index 390d3f1..77bde59 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2810,14 +2810,22 @@ class P4Sync(Command, P4UserMap):
 
             # branches holds mapping from branch name to sha1
             branches = p4BranchesInGit(self.importIntoRemotes)
-            self.p4BranchesInGit = branches.keys()
-            for branch in branches.keys():
-                self.initialParents[self.refPrefix + branch] = branches[branch]
+
+            # restrict to just this one, disabling detect-branches
+            if branch_arg_given:
+                short = self.branch.split("/")[-1]
+                if short in branches:
+                    self.p4BranchesInGit = [ short ]
+            else:
+                self.p4BranchesInGit = branches.keys()
 
             if len(self.p4BranchesInGit) > 1:
                 if not self.silent:
                     print "Importing from/into multiple branches"
                 self.detectBranches = True
+                for branch in branches.keys():
+                    self.initialParents[self.refPrefix + branch] = \
+                        branches[branch]
 
             if self.verbose:
                 print "branches: %s" % self.p4BranchesInGit
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index a51f122..3b0000f 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -88,14 +88,14 @@ test_expect_success 'sync when two branches but no master should noop' '
 	)
 '
 
-test_expect_failure 'sync --branch updates specified branch' '
+test_expect_success 'sync --branch updates specific branch, no detection' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
 		git init &&
-		git p4 sync --branch=refs/remotes/p4/b1 //depot@2 &&
-		git p4 sync --branch=refs/remotes/p4/b2 //depot@2 &&
-		git p4 sync --branch=refs/remotes/p4/b2 &&
+		git p4 sync --branch=b1 //depot@2 &&
+		git p4 sync --branch=b2 //depot@2 &&
+		git p4 sync --branch=b2 &&
 		git show -s --format=%s refs/remotes/p4/b1 >show &&
 		grep "Initial import" show &&
 		git show -s --format=%s refs/remotes/p4/b2 >show &&
-- 
1.8.1.350.gdbf6fd0
