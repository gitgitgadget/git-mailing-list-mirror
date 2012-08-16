From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 03/12] git p4: gracefully fail if some commits could not be applied
Date: Thu, 16 Aug 2012 19:35:05 -0400
Message-ID: <1345160114-27654-4-git-send-email-pw@padd.com>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:36:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29c0-0003L5-V3
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414Ab2HPXgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:36:19 -0400
Received: from honk.padd.com ([74.3.171.149]:47759 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479Ab2HPXgS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:36:18 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 298AED27;
	Thu, 16 Aug 2012 16:36:17 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id EA0E7313FD; Thu, 16 Aug 2012 19:36:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc2.111.g96f7c73
In-Reply-To: <1345160114-27654-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a commit fails to apply cleanly to the p4 tree, an interactive
prompt asks what to do next.  In all cases (skip, apply, write),
the behavior after the prompt had a few problems.

Change it so that it does not claim erroneously that all commits
were applied.  Instead list the set of the patches under
consideration, and mark with an asterisk those that were
applied successfully.  Like this example:

    Applying 592f1f9 line5 in file1 will conflict
    ...
    Unfortunately applying the change failed!
    What do you want to do?
    [s]kip this patch / [a]pply the patch forcibly and with .rej files / [w]rite the patch to a file (patch.txt) s
    Skipping! Good luck with the next patches...
    //depot/file1#4 - was edit, reverted
    Applying b8db1c6 okay_commit_after_skip
    ...
    Change 6 submitted.
    Applied only the commits marked with '*':
      592f1f9 line5 in file1 will conflict
    * b8db1c6 okay_commit_after_skip

Do not try to sync and rebase unless all patches were applied.
If there was a conflict during the submit, there is sure to be one
at the rebase.  Let the user to do the sync and rebase manually.

This changes how a couple tets in t9810-git-p4-rcs.sh behave:

    - git p4 now does not leave files open and edited in the
      client

    - If a git commit contains a change to a file that was
      deleted in p4, the test used to check that the sync/rebase
      loop happened after the failure to apply the change.  Since
      now sync/rebase does not happen after failure, do not test
      this.  Normal rebase machinery, outside of git p4, will let
      rebase --skip work.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                     | 42 ++++++++++++++-----
 t/t9810-git-p4-rcs.sh         | 50 ++---------------------
 t/t9815-git-p4-submit-fail.sh | 93 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 56 deletions(-)
 create mode 100755 t/t9815-git-p4-submit-fail.sh

diff --git a/git-p4.py b/git-p4.py
index e67d37d..2405f38 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1088,7 +1088,10 @@ class P4Submit(Command, P4UserMap):
                 return False
 
     def applyCommit(self, id):
-        print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
+        """Apply one commit, return True if it succeeded."""
+
+        print "Applying", read_pipe(["git", "show", "-s",
+                                     "--format=format:%h %s", id])
 
         (p4User, gitEmail) = self.p4UserForCommit(id)
 
@@ -1206,7 +1209,7 @@ class P4Submit(Command, P4UserMap):
                     p4_revert(f)
                 for f in filesToAdd:
                     os.remove(f)
-                return
+                return False
             elif response == "a":
                 os.system(applyPatchCmd)
                 if len(filesToAdd) > 0:
@@ -1312,6 +1315,7 @@ class P4Submit(Command, P4UserMap):
                 os.remove(f)
 
         os.remove(fileName)
+        return True  # success
 
     # Export git tags as p4 labels. Create a p4 label and then tag
     # with that.
@@ -1487,14 +1491,16 @@ class P4Submit(Command, P4UserMap):
         if gitConfig("git-p4.detectCopiesHarder", "--bool") == "true":
             self.diffOpts += " --find-copies-harder"
 
-        while len(commits) > 0:
-            commit = commits[0]
-            commits = commits[1:]
-            self.applyCommit(commit)
+        applied = []
+        for commit in commits:
+            ok = self.applyCommit(commit)
+            if ok:
+                applied.append(commit)
 
-        if len(commits) == 0:
-            print "All changes applied!"
-            chdir(self.oldWorkingDirectory)
+        chdir(self.oldWorkingDirectory)
+
+        if len(commits) == len(applied):
+            print "All commits applied!"
 
             sync = P4Sync()
             sync.run([])
@@ -1502,6 +1508,20 @@ class P4Submit(Command, P4UserMap):
             rebase = P4Rebase()
             rebase.rebase()
 
+        else:
+            if len(applied) == 0:
+                print "No commits applied."
+            else:
+                print "Applied only the commits marked with '*':"
+                for c in commits:
+                    if c in applied:
+                        star = "*"
+                    else:
+                        star = " "
+                    print star, read_pipe(["git", "show", "-s",
+                                           "--format=format:%h %s",  c])
+                print "You will have to do 'git p4 sync' and rebase."
+
         if gitConfig("git-p4.exportLabels", "--bool") == "true":
             self.exportLabels = True
 
@@ -1512,6 +1532,10 @@ class P4Submit(Command, P4UserMap):
             missingGitTags = gitTags - p4Labels
             self.exportGitTags(missingGitTags)
 
+        # exit with error unless everything applied perfecly
+        if len(commits) != len(applied):
+                sys.exit(1)
+
         return True
 
 class View(object):
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index e9daa9c..fe30ad8 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -160,9 +160,6 @@ test_expect_success 'cleanup after failure' '
 # the cli file so that submit will get a conflict.  Make sure that
 # scrubbing doesn't make a mess of things.
 #
-# Assumes that git-p4 exits leaving the p4 file open, with the
-# conflict-generating patch unapplied.
-#
 # This might happen only if the git repo is behind the p4 repo at
 # submit time, and there is a conflict.
 #
@@ -181,14 +178,11 @@ test_expect_success 'do not scrub plain text' '
 			sed -i "s/^line5/line5 p4 edit/" file_text &&
 			p4 submit -d "file5 p4 edit"
 		) &&
-		! git p4 submit &&
+		echo s | test_expect_code 1 git p4 submit &&
 		(
-			# exepct something like:
-			#    file_text - file(s) not opened on this client
-			# but not copious diff output
+			# make sure the file is not left open
 			cd "$cli" &&
-			p4 diff file_text >wc &&
-			test_line_count = 1 wc
+			! p4 fstat -T action file_text
 		)
 	)
 '
@@ -343,44 +337,6 @@ test_expect_failure 'Add keywords in git which do not match the default p4 value
 	)
 '
 
-# Check that the existing merge conflict handling still works.
-# Modify kwfile1.c in git, and delete in p4. We should be able
-# to skip the git commit.
-#
-test_expect_success 'merge conflict handling still works' '
-	test_when_finished cleanup_git &&
-	(
-		cd "$cli" &&
-		echo "Hello:\$Id\$" >merge2.c &&
-		echo "World" >>merge2.c &&
-		p4 add -t ktext merge2.c &&
-		p4 submit -d "add merge test file"
-	) &&
-	git p4 clone --dest="$git" //depot &&
-	(
-		cd "$git" &&
-		sed -e "/Hello/d" merge2.c >merge2.c.tmp &&
-		mv merge2.c.tmp merge2.c &&
-		git add merge2.c &&
-		git commit -m "Modifying merge2.c"
-	) &&
-	(
-		cd "$cli" &&
-		p4 delete merge2.c &&
-		p4 submit -d "remove merge test file"
-	) &&
-	(
-		cd "$git" &&
-		test -f merge2.c &&
-		git config git-p4.skipSubmitEdit true &&
-		git config git-p4.attemptRCSCleanup true &&
-		!(echo "s" | git p4 submit) &&
-		git rebase --skip &&
-		! test -f merge2.c
-	)
-'
-
-
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
new file mode 100755
index 0000000..8a02c3b
--- /dev/null
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -0,0 +1,93 @@
+
+#!/bin/sh
+
+test_description='git p4 submit failure handling'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		p4 client -o | sed "/LineEnd/s/:.*/:unix/" | p4 client -i &&
+		echo line1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "line1 in file1"
+	)
+'
+
+test_expect_success 'conflict on one commit, skip' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$cli" &&
+		p4 open file1 &&
+		echo line2 >>file1 &&
+		p4 submit -d "line2 in file1"
+	) &&
+	(
+		# now this commit should cause a conflict
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		echo line3 >>file1 &&
+		git add file1 &&
+		git commit -m "line3 in file1 will conflict" &&
+		echo s | test_expect_code 1 git p4 submit >out &&
+		test_i18ngrep "No commits applied" out
+	)
+'
+
+test_expect_success 'conflict on second of two commits, skip' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$cli" &&
+		p4 open file1 &&
+		echo line3 >>file1 &&
+		p4 submit -d "line3 in file1"
+	) &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		# this commit is okay
+		test_commit "first_commit_okay" &&
+		# now this submit should cause a conflict
+		echo line4 >>file1 &&
+		git add file1 &&
+		git commit -m "line4 in file1 will conflict" &&
+		echo s | test_expect_code 1 git p4 submit >out &&
+		test_i18ngrep "Applied only the commits" out
+	)
+'
+
+test_expect_success 'conflict on first of two commits, skip' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$cli" &&
+		p4 open file1 &&
+		echo line4 >>file1 &&
+		p4 submit -d "line4 in file1"
+	) &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		# this submit should cause a conflict
+		echo line5 >>file1 &&
+		git add file1 &&
+		git commit -m "line5 in file1 will conflict" &&
+		# but this commit is okay
+		test_commit "okay_commit_after_skip" &&
+		echo s | test_expect_code 1 git p4 submit >out &&
+		test_i18ngrep "Applied only the commits" out
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.11.4
