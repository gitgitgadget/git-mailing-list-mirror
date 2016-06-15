From: Pete Wyckoff <pw@padd.com>
Subject: [RFC PATCH 3/3] git p4: use "git p4" directly in tests
Date: Sun, 12 Feb 2012 13:13:43 -0500
Message-ID: <1329070423-23761-4-git-send-email-pw@padd.com>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 19:15:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwdwu-0004tW-MH
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 19:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710Ab2BLSOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 13:14:51 -0500
Received: from honk.padd.com ([74.3.171.149]:39192 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab2BLSOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 13:14:50 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 570CEE8B;
	Sun, 12 Feb 2012 10:14:46 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3AF66313C6; Sun, 12 Feb 2012 13:14:44 -0500 (EST)
X-Mailer: git-send-email 1.7.9.193.g1d4a5
In-Reply-To: <1329070423-23761-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190587>

Drop the $GITP4 variable that was used to specify the script in
contrib/fast-import/.  The command is called "git p4" now, not
"git-p4".  Variables will remain in a section called "git-p4".

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh                    |    8 +--
 t/t9800-git-p4-basic.sh            |   84 ++++++++++++++++++------------------
 t/t9801-git-p4-branch.sh           |   32 +++++++-------
 t/t9802-git-p4-filetype.sh         |   10 ++--
 t/t9803-git-p4-shell-metachars.sh  |   12 +++---
 t/t9804-git-p4-label.sh            |    6 +-
 t/t9805-git-p4-skip-submit-edit.sh |   22 +++++-----
 t/t9806-git-p4-options.sh          |   28 ++++++------
 t/t9807-git-p4-submit.sh           |   22 +++++-----
 t/t9808-git-p4-chdir.sh            |    6 +-
 t/t9809-git-p4-client-view.sh      |   64 ++++++++++++++--------------
 11 files changed, 146 insertions(+), 148 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 49edaae..b90986c 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -1,20 +1,18 @@
 #
-# Library code for git-p4 tests
+# Library code for git p4 tests
 #
 
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON; then
-	skip_all='skipping git-p4 tests; python not available'
+	skip_all='skipping git p4 tests; python not available'
 	test_done
 fi
 ( p4 -h && p4d -h ) >/dev/null 2>&1 || {
-	skip_all='skipping git-p4 tests; no p4 or p4d'
+	skip_all='skipping git p4 tests; no p4 or p4d'
 	test_done
 }
 
-GITP4="$GIT_BUILD_DIR/git-p4"
-
 # Try to pick a unique port: guess a large number, then hope
 # no more than one of each test is running.
 #
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 04ee20e..36a7603 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-p4 tests'
+test_description='git p4 tests'
 
 . ./lib-git-p4.sh
 
@@ -20,8 +20,8 @@ test_expect_success 'add p4 files' '
 	)
 '
 
-test_expect_success 'basic git-p4 clone' '
-	"$GITP4" clone --dest="$git" //depot &&
+test_expect_success 'basic git p4 clone' '
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -30,8 +30,8 @@ test_expect_success 'basic git-p4 clone' '
 	)
 '
 
-test_expect_success 'git-p4 clone @all' '
-	"$GITP4" clone --dest="$git" //depot@all &&
+test_expect_success 'git p4 clone @all' '
+	git p4 clone --dest="$git" //depot@all &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -40,12 +40,12 @@ test_expect_success 'git-p4 clone @all' '
 	)
 '
 
-test_expect_success 'git-p4 sync uninitialized repo' '
+test_expect_success 'git p4 sync uninitialized repo' '
 	test_create_repo "$git" &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		test_must_fail "$GITP4" sync
+		test_must_fail git p4 sync
 	)
 '
 
@@ -53,13 +53,13 @@ test_expect_success 'git-p4 sync uninitialized repo' '
 # Create a git repo by hand.  Add a commit so that HEAD is valid.
 # Test imports a new p4 repository into a new git branch.
 #
-test_expect_success 'git-p4 sync new branch' '
+test_expect_success 'git p4 sync new branch' '
 	test_create_repo "$git" &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
 		test_commit head &&
-		"$GITP4" sync --branch=refs/remotes/p4/depot //depot@all &&
+		git p4 sync --branch=refs/remotes/p4/depot //depot@all &&
 		git log --oneline p4/depot >lines &&
 		test_line_count = 2 lines
 	)
@@ -76,7 +76,7 @@ test_expect_success 'clone two dirs' '
 		p4 add sub2/f2 &&
 		p4 submit -d "sub2/f2"
 	) &&
-	"$GITP4" clone --dest="$git" //depot/sub1 //depot/sub2 &&
+	git p4 clone --dest="$git" //depot/sub1 //depot/sub2 &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -94,7 +94,7 @@ test_expect_success 'clone two dirs, @all' '
 		p4 add sub1/f3 &&
 		p4 submit -d "sub1/f3"
 	) &&
-	"$GITP4" clone --dest="$git" //depot/sub1@all //depot/sub2@all &&
+	git p4 clone --dest="$git" //depot/sub1@all //depot/sub2@all &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -112,7 +112,7 @@ test_expect_success 'clone two dirs, @all, conflicting files' '
 		p4 add sub2/f3 &&
 		p4 submit -d "sub2/f3"
 	) &&
-	"$GITP4" clone --dest="$git" //depot/sub1@all //depot/sub2@all &&
+	git p4 clone --dest="$git" //depot/sub1@all //depot/sub2@all &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -134,7 +134,7 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
 	exit 1
 	EOF
 	chmod 755 "$badp4dir"/p4 &&
-	PATH="$badp4dir:$PATH" "$GITP4" clone --dest="$git" //depot >errs 2>&1 ; retval=$? &&
+	PATH="$badp4dir:$PATH" git p4 clone --dest="$git" //depot >errs 2>&1 ; retval=$? &&
 	test $retval -eq 1 &&
 	test_must_fail grep -q Traceback errs
 '
@@ -151,8 +151,8 @@ test_expect_success 'add p4 files with wildcards in the names' '
 	)
 '
 
-test_expect_success 'wildcard files git-p4 clone' '
-	"$GITP4" clone --dest="$git" //depot &&
+test_expect_success 'wildcard files git p4 clone' '
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -164,7 +164,7 @@ test_expect_success 'wildcard files git-p4 clone' '
 '
 
 test_expect_success 'clone bare' '
-	"$GITP4" clone --dest="$git" --bare //depot &&
+	git p4 clone --dest="$git" --bare //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -209,7 +209,7 @@ test_expect_success 'preserve users' '
 	p4_add_user alice Alice &&
 	p4_add_user bob Bob &&
 	p4_grant_admin alice &&
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -218,7 +218,7 @@ test_expect_success 'preserve users' '
 		git commit --author "Alice <alice@localhost>" -m "a change by alice" file1 &&
 		git commit --author "Bob <bob@localhost>" -m "a change by bob" file2 &&
 		git config git-p4.skipSubmitEditCheck true &&
-		P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user &&
+		P4EDITOR=touch P4USER=alice P4PASSWD=secret git p4 commit --preserve-user &&
 		p4_check_commit_author file1 alice &&
 		p4_check_commit_author file2 bob
 	)
@@ -227,21 +227,21 @@ test_expect_success 'preserve users' '
 # Test username support, submitting as bob, who lacks admin rights. Should
 # not submit change to p4 (git diff should show deltas).
 test_expect_success 'refuse to preserve users without perms' '
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
 		git config git-p4.skipSubmitEditCheck true &&
 		echo "username-noperms: a change by alice" >>file1 &&
 		git commit --author "Alice <alice@localhost>" -m "perms: a change by alice" file1 &&
-		P4EDITOR=touch P4USER=bob P4PASSWD=secret test_must_fail "$GITP4" commit --preserve-user &&
+		P4EDITOR=touch P4USER=bob P4PASSWD=secret test_must_fail git p4 commit --preserve-user &&
 		test_must_fail git diff --exit-code HEAD..p4/master
 	)
 '
 
 # What happens with unknown author? Without allowMissingP4Users it should fail.
 test_expect_success 'preserve user where author is unknown to p4' '
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -250,24 +250,24 @@ test_expect_success 'preserve user where author is unknown to p4' '
 		git commit --author "Bob <bob@localhost>" -m "preserve: a change by bob" file1 &&
 		echo "username-unknown: a change by charlie" >>file1 &&
 		git commit --author "Charlie <charlie@localhost>" -m "preserve: a change by charlie" file1 &&
-		P4EDITOR=touch P4USER=alice P4PASSWD=secret test_must_fail "$GITP4" commit --preserve-user &&
+		P4EDITOR=touch P4USER=alice P4PASSWD=secret test_must_fail git p4 commit --preserve-user &&
 		test_must_fail git diff --exit-code HEAD..p4/master &&
 
 		echo "$0: repeat with allowMissingP4Users enabled" &&
 		git config git-p4.allowMissingP4Users true &&
 		git config git-p4.preserveUser true &&
-		P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit &&
+		P4EDITOR=touch P4USER=alice P4PASSWD=secret git p4 commit &&
 		git diff --exit-code HEAD..p4/master &&
 		p4_check_commit_author file1 alice
 	)
 '
 
-# If we're *not* using --preserve-user, git-p4 should warn if we're submitting
+# If we're *not* using --preserve-user, git p4 should warn if we're submitting
 # changes that are not all ours.
 # Test: user in p4 and user unknown to p4.
 # Test: warning disabled and user is the same.
 test_expect_success 'not preserving user with mixed authorship' '
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -275,20 +275,20 @@ test_expect_success 'not preserving user with mixed authorship' '
 		p4_add_user derek Derek &&
 
 		make_change_by_user usernamefile3 Derek derek@localhost &&
-		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |\
+		P4EDITOR=cat P4USER=alice P4PASSWD=secret git p4 commit |\
 		grep "git author derek@localhost does not match" &&
 
 		make_change_by_user usernamefile3 Charlie charlie@localhost &&
-		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |\
+		P4EDITOR=cat P4USER=alice P4PASSWD=secret git p4 commit |\
 		grep "git author charlie@localhost does not match" &&
 
 		make_change_by_user usernamefile3 alice alice@localhost &&
-		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" |\
+		P4EDITOR=cat P4USER=alice P4PASSWD=secret git p4 |\
 		test_must_fail grep "git author.*does not match" &&
 
 		git config git-p4.skipUserNameCheck true &&
 		make_change_by_user usernamefile3 Charlie charlie@localhost &&
-		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |\
+		P4EDITOR=cat P4USER=alice P4PASSWD=secret git p4 commit |\
 		test_must_fail grep "git author.*does not match" &&
 
 		p4_check_commit_author usernamefile3 alice
@@ -307,7 +307,7 @@ test_expect_success 'initial import time from top change time' '
 	p4change=$(p4 -G changes -m 1 //depot/... | marshal_dump change) &&
 	p4time=$(p4 -G changes -m 1 //depot/... | marshal_dump time) &&
 	sleep 3 &&
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -325,7 +325,7 @@ test_expect_success 'initial import time from top change time' '
 # Repeat, this time with a smaller threshold and confirm that the rename is
 # detected in P4.
 test_expect_success 'detect renames' '
-	"$GITP4" clone --dest="$git" //depot@all &&
+	git p4 clone --dest="$git" //depot@all &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -334,7 +334,7 @@ test_expect_success 'detect renames' '
 		git mv file1 file4 &&
 		git commit -a -m "Rename file1 to file4" &&
 		git diff-tree -r -M HEAD &&
-		"$GITP4" submit &&
+		git p4 submit &&
 		p4 filelog //depot/file4 &&
 		p4 filelog //depot/file4 | test_must_fail grep -q "branch from" &&
 
@@ -342,7 +342,7 @@ test_expect_success 'detect renames' '
 		git commit -a -m "Rename file4 to file5" &&
 		git diff-tree -r -M HEAD &&
 		git config git-p4.detectRenames true &&
-		"$GITP4" submit &&
+		git p4 submit &&
 		p4 filelog //depot/file5 &&
 		p4 filelog //depot/file5 | grep -q "branch from //depot/file4" &&
 
@@ -354,7 +354,7 @@ test_expect_success 'detect renames' '
 		level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
 		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
 		git config git-p4.detectRenames $(($level + 2)) &&
-		"$GITP4" submit &&
+		git p4 submit &&
 		p4 filelog //depot/file6 &&
 		p4 filelog //depot/file6 | test_must_fail grep -q "branch from" &&
 
@@ -366,7 +366,7 @@ test_expect_success 'detect renames' '
 		level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
 		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
 		git config git-p4.detectRenames $(($level - 2)) &&
-		"$GITP4" submit &&
+		git p4 submit &&
 		p4 filelog //depot/file7 &&
 		p4 filelog //depot/file7 | grep -q "branch from //depot/file6"
 	)
@@ -384,7 +384,7 @@ test_expect_success 'detect renames' '
 # Modify and copy a file, configure a smaller threshold in detectCopies and
 # confirm that copy is detected in P4.
 test_expect_success 'detect copies' '
-	"$GITP4" clone --dest="$git" //depot@all &&
+	git p4 clone --dest="$git" //depot@all &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -394,7 +394,7 @@ test_expect_success 'detect copies' '
 		git add file8 &&
 		git commit -a -m "Copy file2 to file8" &&
 		git diff-tree -r -C HEAD &&
-		"$GITP4" submit &&
+		git p4 submit &&
 		p4 filelog //depot/file8 &&
 		p4 filelog //depot/file8 | test_must_fail grep -q "branch from" &&
 
@@ -403,7 +403,7 @@ test_expect_success 'detect copies' '
 		git commit -a -m "Copy file2 to file9" &&
 		git diff-tree -r -C HEAD &&
 		git config git-p4.detectCopies true &&
-		"$GITP4" submit &&
+		git p4 submit &&
 		p4 filelog //depot/file9 &&
 		p4 filelog //depot/file9 | test_must_fail grep -q "branch from" &&
 
@@ -412,7 +412,7 @@ test_expect_success 'detect copies' '
 		git add file2 file10 &&
 		git commit -a -m "Modify and copy file2 to file10" &&
 		git diff-tree -r -C HEAD &&
-		"$GITP4" submit &&
+		git p4 submit &&
 		p4 filelog //depot/file10 &&
 		p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
 
@@ -423,7 +423,7 @@ test_expect_success 'detect copies' '
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
 		test "$src" = file10 &&
 		git config git-p4.detectCopiesHarder true &&
-		"$GITP4" submit &&
+		git p4 submit &&
 		p4 filelog //depot/file11 &&
 		p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
 
@@ -437,7 +437,7 @@ test_expect_success 'detect copies' '
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
 		test "$src" = file10 &&
 		git config git-p4.detectCopies $(($level + 2)) &&
-		"$GITP4" submit &&
+		git p4 submit &&
 		p4 filelog //depot/file12 &&
 		p4 filelog //depot/file12 | test_must_fail grep -q "branch from" &&
 
@@ -451,7 +451,7 @@ test_expect_success 'detect copies' '
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
 		test "$src" = file10 &&
 		git config git-p4.detectCopies $(($level - 2)) &&
-		"$GITP4" submit &&
+		git p4 submit &&
 		p4 filelog //depot/file13 &&
 		p4 filelog //depot/file13 | grep -q "branch from //depot/file"
 	)
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index d414705..2859256 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-p4 p4 branching tests'
+test_description='git p4 tests for p4 branches'
 
 . ./lib-git-p4.sh
 
@@ -63,7 +63,7 @@ test_expect_success 'basic p4 branches' '
 
 test_expect_success 'import main, no branch detection' '
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" //depot/main@all &&
+	git p4 clone --dest="$git" //depot/main@all &&
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
@@ -74,7 +74,7 @@ test_expect_success 'import main, no branch detection' '
 
 test_expect_success 'import branch1, no branch detection' '
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" //depot/branch1@all &&
+	git p4 clone --dest="$git" //depot/branch1@all &&
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
@@ -85,7 +85,7 @@ test_expect_success 'import branch1, no branch detection' '
 
 test_expect_success 'import branch2, no branch detection' '
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" //depot/branch2@all &&
+	git p4 clone --dest="$git" //depot/branch2@all &&
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
@@ -96,7 +96,7 @@ test_expect_success 'import branch2, no branch detection' '
 
 test_expect_success 'import depot, no branch detection' '
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" //depot@all &&
+	git p4 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
@@ -107,7 +107,7 @@ test_expect_success 'import depot, no branch detection' '
 
 test_expect_success 'import depot, branch detection' '
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" --detect-branches //depot@all &&
+	git p4 clone --dest="$git" --detect-branches //depot@all &&
 	(
 		cd "$git" &&
 
@@ -132,7 +132,7 @@ test_expect_success 'import depot, branch detection, branchList branch definitio
 	(
 		cd "$git" &&
 		git config git-p4.branchList main:branch1 &&
-		"$GITP4" clone --dest=. --detect-branches //depot@all &&
+		git p4 clone --dest=. --detect-branches //depot@all &&
 
 		git log --oneline --graph --decorate --all &&
 
@@ -189,15 +189,15 @@ test_expect_success 'add simple p4 branches' '
 # Configure branches through git-config and clone them.
 # All files are tested to make sure branches were cloned correctly.
 # Finally, make an update to branch1 on P4 side to check if it is imported
-# correctly by git-p4.
-test_expect_success 'git-p4 clone simple branches' '
+# correctly by git p4.
+test_expect_success 'git p4 clone simple branches' '
 	test_when_finished cleanup_git &&
 	test_create_repo "$git" &&
 	(
 		cd "$git" &&
 		git config git-p4.branchList branch1:branch2 &&
 		git config --add git-p4.branchList branch1:branch3 &&
-		"$GITP4" clone --dest=. --detect-branches //depot@all &&
+		git p4 clone --dest=. --detect-branches //depot@all &&
 		git log --all --graph --decorate --stat &&
 		git reset --hard p4/depot/branch1 &&
 		test -f file1 &&
@@ -221,13 +221,13 @@ test_expect_success 'git-p4 clone simple branches' '
 		p4 submit -d "update file2 in branch3" &&
 		cd "$git" &&
 		git reset --hard p4/depot/branch1 &&
-		"$GITP4" rebase &&
+		git p4 rebase &&
 		grep file2_ file2
 	)
 '
 
 # Create a complex branch structure in P4 depot to check if they are correctly
-# cloned. The branches are created from older changelists to check if git-p4 is
+# cloned. The branches are created from older changelists to check if git p4 is
 # able to correctly detect them.
 # The final expected structure is:
 # `branch1
@@ -248,7 +248,7 @@ test_expect_success 'git-p4 clone simple branches' '
 #   `- file1
 #   `- file2
 #   `- file3
-test_expect_success 'git-p4 add complex branches' '
+test_expect_success 'git p4 add complex branches' '
 	test_when_finished cleanup_git &&
 	test_create_repo "$git" &&
 	(
@@ -263,10 +263,10 @@ test_expect_success 'git-p4 add complex branches' '
 	)
 '
 
-# Configure branches through git-config and clone them. git-p4 will only be able
+# Configure branches through git-config and clone them. git p4 will only be able
 # to clone the original structure if it is able to detect the origin changelist
 # of each branch.
-test_expect_success 'git-p4 clone complex branches' '
+test_expect_success 'git p4 clone complex branches' '
 	test_when_finished cleanup_git &&
 	test_create_repo "$git" &&
 	(
@@ -275,7 +275,7 @@ test_expect_success 'git-p4 clone complex branches' '
 		git config --add git-p4.branchList branch1:branch3 &&
 		git config --add git-p4.branchList branch1:branch4 &&
 		git config --add git-p4.branchList branch1:branch5 &&
-		"$GITP4" clone --dest=. --detect-branches //depot@all &&
+		git p4 clone --dest=. --detect-branches //depot@all &&
 		git log --all --graph --decorate --stat &&
 		git reset --hard p4/depot/branch1 &&
 		test_path_is_file file1 &&
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 992bb8c..21924df 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-p4 p4 filetype tests'
+test_description='git p4 filetype tests'
 
 . ./lib-git-p4.sh
 
@@ -37,7 +37,7 @@ test_expect_success 'utf-16 file create' '
 
 test_expect_success 'utf-16 file test' '
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" //depot@all &&
+	git p4 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 
@@ -84,7 +84,7 @@ test_expect_success 'keyword file test' '
 	build_smush &&
 	test_when_finished rm -f k_smush.py ko_smush.py &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" //depot@all &&
+	git p4 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 
@@ -94,7 +94,7 @@ test_expect_success 'keyword file test' '
 		"$PYTHON_PATH" "$TRASH_DIRECTORY/ko_smush.py" <"$cli/k-text-ko" >cli-k-text-ko-smush &&
 		test_cmp cli-k-text-ko-smush k-text-ko &&
 
-		# utf16, even though p4 expands keywords, git-p4 does not
+		# utf16, even though p4 expands keywords, git p4 does not
 		# try to undo that
 		test_cmp "$cli/k-utf16-k" k-utf16-k &&
 		test_cmp "$cli/k-utf16-ko" k-utf16-ko
@@ -125,7 +125,7 @@ test_expect_success 'ignore apple' '
 		p4 submit -d appledouble
 	) &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" //depot@all &&
+	git p4 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		test ! -f double.png
diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
index db67020..fbacff3 100755
--- a/t/t9803-git-p4-shell-metachars.sh
+++ b/t/t9803-git-p4-shell-metachars.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-p4 transparency to shell metachars in filenames'
+test_description='git p4 transparency to shell metachars in filenames'
 
 . ./lib-git-p4.sh
 
@@ -18,7 +18,7 @@ test_expect_success 'init depot' '
 '
 
 test_expect_success 'shell metachars in filenames' '
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -28,7 +28,7 @@ test_expect_success 'shell metachars in filenames' '
 		echo f2 >"file with spaces" &&
 		git add "file with spaces" &&
 		git commit -m "add files" &&
-		P4EDITOR=touch "$GITP4" submit
+		P4EDITOR=touch git p4 submit
 	) &&
 	(
 		cd "$cli" &&
@@ -39,7 +39,7 @@ test_expect_success 'shell metachars in filenames' '
 '
 
 test_expect_success 'deleting with shell metachars' '
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -47,7 +47,7 @@ test_expect_success 'deleting with shell metachars' '
 		git rm foo\$bar &&
 		git rm file\ with\ spaces &&
 		git commit -m "remove files" &&
-		P4EDITOR=touch "$GITP4" submit
+		P4EDITOR=touch git p4 submit
 	) &&
 	(
 		cd "$cli" &&
@@ -97,7 +97,7 @@ test_expect_success 'branch with shell char' '
 		cd "$git" &&
 
 		git config git-p4.branchList main:branch\$3 &&
-		"$GITP4" clone --dest=. --detect-branches //depot@all &&
+		git p4 clone --dest=. --detect-branches //depot@all &&
 		git log --all --graph --decorate --stat &&
 		git reset --hard p4/depot/branch\$3 &&
 		test -f shell_char_branch_file &&
diff --git a/t/t9804-git-p4-label.sh b/t/t9804-git-p4-label.sh
index 80d01ea..c8eec0e 100755
--- a/t/t9804-git-p4-label.sh
+++ b/t/t9804-git-p4-label.sh
@@ -1,4 +1,4 @@
-test_description='git-p4 p4 label tests'
+test_description='git p4 label tests'
 
 . ./lib-git-p4.sh
 
@@ -48,7 +48,7 @@ test_expect_success 'basic p4 labels' '
 
 		p4 labels ... &&
 
-		"$GITP4" clone --dest="$git" --detect-labels //depot@all &&
+		git p4 clone --dest="$git" --detect-labels //depot@all &&
 		cd "$git" &&
 
 		git tag &&
@@ -87,7 +87,7 @@ test_expect_failure 'two labels on the same changelist' '
 
 		p4 labels ... &&
 
-		"$GITP4" clone --dest="$git" --detect-labels //depot@all &&
+		git p4 clone --dest="$git" --detect-labels //depot@all &&
 		cd "$git" &&
 
 		git tag | grep tag_f1 &&
diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
index df929e0..4a72f79 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-p4 skipSubmitEdit config variables'
+test_description='git p4 skipSubmitEdit config variables'
 
 . ./lib-git-p4.sh
 
@@ -19,33 +19,33 @@ test_expect_success 'init depot' '
 
 # this works because EDITOR is set to :
 test_expect_success 'no config, unedited, say yes' '
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
 		echo line >>file1 &&
 		git commit -a -m "change 2" &&
-		echo y | "$GITP4" submit &&
+		echo y | git p4 submit &&
 		p4 changes //depot/... >wc &&
 		test_line_count = 2 wc
 	)
 '
 
 test_expect_success 'no config, unedited, say no' '
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
 		echo line >>file1 &&
 		git commit -a -m "change 3 (not really)" &&
-		printf "bad response\nn\n" | "$GITP4" submit &&
+		printf "bad response\nn\n" | git p4 submit &&
 		p4 changes //depot/... >wc &&
 		test_line_count = 2 wc
 	)
 '
 
 test_expect_success 'skipSubmitEdit' '
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -54,21 +54,21 @@ test_expect_success 'skipSubmitEdit' '
 		git config core.editor /bin/false &&
 		echo line >>file1 &&
 		git commit -a -m "change 3" &&
-		"$GITP4" submit &&
+		git p4 submit &&
 		p4 changes //depot/... >wc &&
 		test_line_count = 3 wc
 	)
 '
 
 test_expect_success 'skipSubmitEditCheck' '
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
 		git config git-p4.skipSubmitEditCheck true &&
 		echo line >>file1 &&
 		git commit -a -m "change 4" &&
-		"$GITP4" submit &&
+		git p4 submit &&
 		p4 changes //depot/... >wc &&
 		test_line_count = 4 wc
 	)
@@ -76,7 +76,7 @@ test_expect_success 'skipSubmitEditCheck' '
 
 # check the normal case, where the template really is edited
 test_expect_success 'no config, edited' '
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	ed="$TRASH_DIRECTORY/ed.sh" &&
 	test_when_finished "rm \"$ed\"" &&
@@ -91,7 +91,7 @@ test_expect_success 'no config, edited' '
 		cd "$git" &&
 		echo line >>file1 &&
 		git commit -a -m "change 5" &&
-		EDITOR="\"$ed\"" "$GITP4" submit &&
+		EDITOR="\"$ed\"" git p4 submit &&
 		p4 changes //depot/... >wc &&
 		test_line_count = 5 wc
 	)
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 0571602..2892367 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-p4 options'
+test_description='git p4 options'
 
 . ./lib-git-p4.sh
 
@@ -24,11 +24,11 @@ test_expect_success 'init depot' '
 '
 
 test_expect_success 'clone no --git-dir' '
-	test_must_fail "$GITP4" clone --git-dir=xx //depot
+	test_must_fail git p4 clone --git-dir=xx //depot
 '
 
 test_expect_success 'clone --branch' '
-	"$GITP4" clone --branch=refs/remotes/p4/sb --dest="$git" //depot &&
+	git p4 clone --branch=refs/remotes/p4/sb --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -42,7 +42,7 @@ test_expect_success 'clone --changesfile' '
 	cf="$TRASH_DIRECTORY/cf" &&
 	test_when_finished "rm \"$cf\"" &&
 	printf "1\n3\n" >"$cf" &&
-	"$GITP4" clone --changesfile="$cf" --dest="$git" //depot &&
+	git p4 clone --changesfile="$cf" --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -58,14 +58,14 @@ test_expect_success 'clone --changesfile, @all' '
 	cf="$TRASH_DIRECTORY/cf" &&
 	test_when_finished "rm \"$cf\"" &&
 	printf "1\n3\n" >"$cf" &&
-	test_must_fail "$GITP4" clone --changesfile="$cf" --dest="$git" //depot@all
+	test_must_fail git p4 clone --changesfile="$cf" --dest="$git" //depot@all
 '
 
 # imports both master and p4/master in refs/heads
 # requires --import-local on sync to find p4 refs/heads
 # does not update master on sync, just p4/master
 test_expect_success 'clone/sync --import-local' '
-	"$GITP4" clone --import-local --dest="$git" //depot@1,2 &&
+	git p4 clone --import-local --dest="$git" //depot@1,2 &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -73,9 +73,9 @@ test_expect_success 'clone/sync --import-local' '
 		test_line_count = 2 lines &&
 		git log --oneline refs/heads/p4/master >lines &&
 		test_line_count = 2 lines &&
-		test_must_fail "$GITP4" sync &&
+		test_must_fail git p4 sync &&
 
-		"$GITP4" sync --import-local &&
+		git p4 sync --import-local &&
 		git log --oneline refs/heads/master >lines &&
 		test_line_count = 2 lines &&
 		git log --oneline refs/heads/p4/master >lines &&
@@ -84,7 +84,7 @@ test_expect_success 'clone/sync --import-local' '
 '
 
 test_expect_success 'clone --max-changes' '
-	"$GITP4" clone --dest="$git" --max-changes 2 //depot@all &&
+	git p4 clone --dest="$git" --max-changes 2 //depot@all &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -101,7 +101,7 @@ test_expect_success 'clone --keep-path' '
 		p4 add sub/dir/f4 &&
 		p4 submit -d "change 4"
 	) &&
-	"$GITP4" clone --dest="$git" --keep-path //depot/sub/dir@all &&
+	git p4 clone --dest="$git" --keep-path //depot/sub/dir@all &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -109,7 +109,7 @@ test_expect_success 'clone --keep-path' '
 		test_path_is_file sub/dir/f4
 	) &&
 	cleanup_git &&
-	"$GITP4" clone --dest="$git" //depot/sub/dir@all &&
+	git p4 clone --dest="$git" //depot/sub/dir@all &&
 	(
 		cd "$git" &&
 		test_path_is_file f4 &&
@@ -126,7 +126,7 @@ test_expect_success 'clone --use-client-spec' '
 	(
 		# big usage message
 		exec >/dev/null &&
-		test_must_fail "$GITP4" clone --dest="$git" --use-client-spec
+		test_must_fail git p4 clone --dest="$git" --use-client-spec
 	) &&
 	cli2="$TRASH_DIRECTORY/cli2" &&
 	mkdir -p "$cli2" &&
@@ -142,7 +142,7 @@ test_expect_success 'clone --use-client-spec' '
 	) &&
 	P4CLIENT=client2 &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" --use-client-spec //depot/... &&
+	git p4 clone --dest="$git" --use-client-spec //depot/... &&
 	(
 		cd "$git" &&
 		test_path_is_file bus/dir/f4 &&
@@ -156,7 +156,7 @@ test_expect_success 'clone --use-client-spec' '
 		cd "$git" &&
 		git init &&
 		git config git-p4.useClientSpec true &&
-		"$GITP4" sync //depot/... &&
+		git p4 sync //depot/... &&
 		git checkout -b master p4/master &&
 		test_path_is_file bus/dir/f4 &&
 		test_path_is_missing file1
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index b1f61e3..1541716 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-p4 submit'
+test_description='git p4 submit'
 
 . ./lib-git-p4.sh
 
@@ -19,7 +19,7 @@ test_expect_success 'init depot' '
 
 test_expect_success 'submit with no client dir' '
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	(
 		cd "$git" &&
 		echo file2 >file2 &&
@@ -27,20 +27,20 @@ test_expect_success 'submit with no client dir' '
 		git commit -m "git commit 2" &&
 		rm -rf "$cli" &&
 		git config git-p4.skipSubmitEdit true &&
-		"$GITP4" submit
+		git p4 submit
 	)
 '
 
 # make two commits, but tell it to apply only from HEAD^
 test_expect_success 'submit --origin' '
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	(
 		cd "$git" &&
 		test_commit "file3" &&
 		test_commit "file4" &&
 		git config git-p4.skipSubmitEdit true &&
-		"$GITP4" submit --origin=HEAD^
+		git p4 submit --origin=HEAD^
 	) &&
 	(
 		cd "$cli" &&
@@ -52,30 +52,30 @@ test_expect_success 'submit --origin' '
 
 test_expect_success 'submit with allowSubmit' '
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	(
 		cd "$git" &&
 		test_commit "file5" &&
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.allowSubmit "nobranch" &&
-		test_must_fail "$GITP4" submit &&
+		test_must_fail git p4 submit &&
 		git config git-p4.allowSubmit "nobranch,master" &&
-		"$GITP4" submit
+		git p4 submit
 	)
 '
 
 test_expect_success 'submit with master branch name from argv' '
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --dest="$git" //depot &&
+	git p4 clone --dest="$git" //depot &&
 	(
 		cd "$git" &&
 		test_commit "file6" &&
 		git config git-p4.skipSubmitEdit true &&
-		test_must_fail "$GITP4" submit nobranch &&
+		test_must_fail git p4 submit nobranch &&
 		git branch otherbranch &&
 		git reset --hard HEAD^ &&
 		test_commit "file7" &&
-		"$GITP4" submit otherbranch
+		git p4 submit otherbranch
 	) &&
 	(
 		cd "$cli" &&
diff --git a/t/t9808-git-p4-chdir.sh b/t/t9808-git-p4-chdir.sh
index eb8cc95..73c0902 100755
--- a/t/t9808-git-p4-chdir.sh
+++ b/t/t9808-git-p4-chdir.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-p4 relative chdir'
+test_description='git p4 relative chdir'
 
 . ./lib-git-p4.sh
 
@@ -26,7 +26,7 @@ test_expect_success 'P4CONFIG and absolute dir clone' '
 	(
 		P4CONFIG=p4config && export P4CONFIG &&
 		unset P4PORT P4CLIENT &&
-		"$GITP4" clone --verbose --dest="$git" //depot
+		git p4 clone --verbose --dest="$git" //depot
 	)
 '
 
@@ -38,7 +38,7 @@ test_expect_success 'P4CONFIG and relative dir clone' '
 	(
 		P4CONFIG=p4config && export P4CONFIG &&
 		unset P4PORT P4CLIENT &&
-		"$GITP4" clone --verbose --dest="git" //depot
+		git p4 clone --verbose --dest="git" //depot
 	)
 '
 
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index ae9145e..d86bffd 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-p4 client view'
+test_description='git p4 client view'
 
 . ./lib-git-p4.sh
 
@@ -92,25 +92,25 @@ test_expect_success 'init depot' '
 test_expect_success 'unsupported view wildcard %%n' '
 	client_view "//depot/%%%%1/sub/... //client/sub/%%%%1/..." &&
 	test_when_finished cleanup_git &&
-	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
+	test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
 '
 
 test_expect_success 'unsupported view wildcard *' '
 	client_view "//depot/*/bar/... //client/*/bar/..." &&
 	test_when_finished cleanup_git &&
-	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
+	test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
 '
 
 test_expect_success 'wildcard ... only supported at end of spec 1' '
 	client_view "//depot/.../file11 //client/.../file11" &&
 	test_when_finished cleanup_git &&
-	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
+	test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
 '
 
 test_expect_success 'wildcard ... only supported at end of spec 2' '
 	client_view "//depot/.../a/... //client/.../a/..." &&
 	test_when_finished cleanup_git &&
-	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
+	test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
 '
 
 test_expect_success 'basic map' '
@@ -118,7 +118,7 @@ test_expect_success 'basic map' '
 	files="cli1/file11 cli1/file12" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files
 '
 
@@ -126,7 +126,7 @@ test_expect_success 'client view with no mappings' '
 	client_view &&
 	client_verify &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify
 '
 
@@ -135,7 +135,7 @@ test_expect_success 'single file map' '
 	files="file11" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files
 '
 
@@ -146,7 +146,7 @@ test_expect_success 'later mapping takes precedence (entire repo)' '
 	       cli2/dir2/file21 cli2/dir2/file22" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files
 '
 
@@ -156,7 +156,7 @@ test_expect_success 'later mapping takes precedence (partial repo)' '
 	files="file21 file22" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files
 '
 
@@ -172,7 +172,7 @@ test_expect_success 'depot path matching rejected client path' '
 	files="cli12/file21 cli12/file22" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files
 '
 
@@ -183,7 +183,7 @@ test_expect_success 'exclusion wildcard, client rhs same (odd)' '
 		    "-//depot/dir2/... //client/..." &&
 	client_verify &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify
 '
 
@@ -193,7 +193,7 @@ test_expect_success 'exclusion wildcard, client rhs different (normal)' '
 	files="dir1/file11 dir1/file12" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files
 '
 
@@ -203,7 +203,7 @@ test_expect_success 'exclusion single file' '
 	files="dir1/file11 dir1/file12 dir2/file21" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files
 '
 
@@ -213,7 +213,7 @@ test_expect_success 'overlay wildcard' '
 	files="cli/file11 cli/file12 cli/file21 cli/file22" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files
 '
 
@@ -223,7 +223,7 @@ test_expect_success 'overlay single file' '
 	files="cli/file11 cli/file12 cli/file21" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files
 '
 
@@ -234,7 +234,7 @@ test_expect_success 'exclusion with later inclusion' '
 	files="dir1/file11 dir1/file12 dir2incl/file21 dir2incl/file22" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files
 '
 
@@ -242,7 +242,7 @@ test_expect_success 'quotes on rhs only' '
 	client_view "//depot/dir1/... \"//client/cdir 1/...\"" &&
 	client_verify "cdir 1/file11" "cdir 1/file12" &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify "cdir 1/file11" "cdir 1/file12"
 '
 
@@ -282,7 +282,7 @@ test_expect_success 'overlay collision 1 to 2' '
 	client_verify $files &&
 	test_cmp actual "$cli"/filecollide &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files &&
 	test_cmp actual "$git"/filecollide
 '
@@ -295,7 +295,7 @@ test_expect_failure 'overlay collision 2 to 1' '
 	client_verify $files &&
 	test_cmp actual "$cli"/filecollide &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files &&
 	test_cmp actual "$git"/filecollide
 '
@@ -317,7 +317,7 @@ test_expect_failure 'overlay collision 1 to 2, but 2 deleted' '
 	files="file11 file12 file21 file22" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files
 '
 
@@ -340,7 +340,7 @@ test_expect_failure 'overlay collision 1 to 2, but 2 deleted, then 1 updated' '
 	files="file11 file12 file21 file22" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files
 '
 
@@ -396,7 +396,7 @@ test_expect_success 'overlay sync: initial git checkout' '
 	echo dir1/colA >actual &&
 	client_verify $files &&
 	test_cmp actual "$cli"/colA &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files &&
 	test_cmp actual "$git"/colA
 '
@@ -421,7 +421,7 @@ test_expect_success 'overlay sync: colA content switch' '
 	test_cmp actual "$cli"/colA &&
 	(
 		cd "$git" &&
-		"$GITP4" sync --use-client-spec &&
+		git p4 sync --use-client-spec &&
 		git merge --ff-only p4/master
 	) &&
 	git_verify $files &&
@@ -448,7 +448,7 @@ test_expect_success 'overlay sync: colB appears' '
 	test_cmp actual "$cli"/colB &&
 	(
 		cd "$git" &&
-		"$GITP4" sync --use-client-spec &&
+		git p4 sync --use-client-spec &&
 		git merge --ff-only p4/master
 	) &&
 	git_verify $files &&
@@ -476,7 +476,7 @@ test_expect_success 'overlay sync: colB disappears' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		"$GITP4" sync --use-client-spec &&
+		git p4 sync --use-client-spec &&
 		git merge --ff-only p4/master
 	) &&
 	git_verify $files
@@ -534,7 +534,7 @@ test_expect_success 'overlay sync swap: initial git checkout' '
 	echo dir1/colA >actual &&
 	client_verify $files &&
 	test_cmp actual "$cli"/colA &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify $files &&
 	test_cmp actual "$git"/colA
 '
@@ -559,7 +559,7 @@ test_expect_failure 'overlay sync swap: colA no content switch' '
 	test_cmp actual "$cli"/colA &&
 	(
 		cd "$git" &&
-		"$GITP4" sync --use-client-spec &&
+		git p4 sync --use-client-spec &&
 		git merge --ff-only p4/master
 	) &&
 	git_verify $files &&
@@ -586,7 +586,7 @@ test_expect_success 'overlay sync swap: colB appears' '
 	test_cmp actual "$cli"/colB &&
 	(
 		cd "$git" &&
-		"$GITP4" sync --use-client-spec &&
+		git p4 sync --use-client-spec &&
 		git merge --ff-only p4/master
 	) &&
 	git_verify $files &&
@@ -616,7 +616,7 @@ test_expect_failure 'overlay sync swap: colB no change' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		"$GITP4" sync --use-client-spec &&
+		git p4 sync --use-client-spec &&
 		git merge --ff-only p4/master
 	) &&
 	git_verify $files &&
@@ -664,7 +664,7 @@ test_expect_success 'quotes on lhs only' '
 	files="cdir1/file11 cdir1/file12" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	client_verify $files
 '
 
@@ -672,7 +672,7 @@ test_expect_success 'quotes on both sides' '
 	client_view "\"//depot/dir 1/...\" \"//client/cdir 1/...\"" &&
 	client_verify "cdir 1/file11" "cdir 1/file12" &&
 	test_when_finished cleanup_git &&
-	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
 	git_verify "cdir 1/file11" "cdir 1/file12"
 '
 
-- 
1.7.9.192.ga1d4b
