From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 11/14] git p4: fail gracefully on sync with no master branch
Date: Mon, 14 Jan 2013 19:47:05 -0500
Message-ID: <1358210828-2369-12-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:51:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuukF-0003EX-Ep
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757261Ab3AOAuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:50:55 -0500
Received: from honk.padd.com ([74.3.171.149]:40006 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757024Ab3AOAuz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:50:55 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id 662AF2F3F;
	Mon, 14 Jan 2013 16:50:54 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6D7E528EC2; Mon, 14 Jan 2013 19:50:49 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213562>

If --branch was used to build a repository with no
refs/remotes/p4/master, future syncs will not know
which branch to sync.  Notice this situation and
print a helpful error message.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                 | 29 +++++++++++++++++++++++++++--
 t/t9806-git-p4-options.sh |  9 ++++-----
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 9b07ddd..390d3f1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -585,6 +585,17 @@ def p4BranchesInGit(branchesAreInRemotes=True):
 
     return branches
 
+def branch_exists(branch):
+    """Make sure that the given ref name really exists."""
+
+    cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
+    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    out, _ = p.communicate()
+    if p.returncode:
+        return False
+    # expect exactly one line of output: the branch name
+    return out.rstrip() == branch
+
 def findUpstreamBranchPoint(head = "HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
@@ -2774,6 +2785,7 @@ class P4Sync(Command, P4UserMap):
                     print 'Syncing with origin first, using "git fetch origin"'
                 system("git fetch origin")
 
+        branch_arg_given = bool(self.branch)
         if len(self.branch) == 0:
             self.branch = self.refPrefix + "master"
             if gitBranchExists("refs/heads/p4") and self.importIntoRemotes:
@@ -2967,8 +2979,21 @@ class P4Sync(Command, P4UserMap):
             else:
                 # catch "git p4 sync" with no new branches, in a repo that
                 # does not have any existing p4 branches
-                if len(args) == 0 and not self.p4BranchesInGit:
-                    die("No remote p4 branches.  Perhaps you never did \"git p4 clone\" in here.");
+                if len(args) == 0:
+                    if not self.p4BranchesInGit:
+                        die("No remote p4 branches.  Perhaps you never did \"git p4 clone\" in here.")
+
+                    # The default branch is master, unless --branch is used to
+                    # specify something else.  Make sure it exists, or complain
+                    # nicely about how to use --branch.
+                    if not self.detectBranches:
+                        if not branch_exists(self.branch):
+                            if branch_arg_given:
+                                die("Error: branch %s does not exist." % self.branch)
+                            else:
+                                die("Error: no branch %s; perhaps specify one with --branch." %
+                                    self.branch)
+
                 if self.verbose:
                     print "Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
                                                               self.changeRange)
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index c0d4433..a51f122 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -40,14 +40,13 @@ test_expect_success 'clone --branch should checkout master' '
 	)
 '
 
-test_expect_failure 'sync when branch is not called master should work' '
-	git p4 clone --branch=refs/remotes/p4/sb --dest="$git" //depot@2 &&
+test_expect_success 'sync when no master branch prints a nice error' '
 	test_when_finished cleanup_git &&
+	git p4 clone --branch=refs/remotes/p4/sb --dest="$git" //depot@2 &&
 	(
 		cd "$git" &&
-		git p4 sync &&
-		git show -s --format=%s refs/remotes/p4/sb >show &&
-		grep "change 3" show
+		test_must_fail git p4 sync 2>err &&
+		grep "Error: no branch refs/remotes/p4/master" err
 	)
 '
 
-- 
1.8.1.350.gdbf6fd0
