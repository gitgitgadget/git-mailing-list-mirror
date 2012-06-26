From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 9/9] git p4 test: split up big t9800 test
Date: Mon, 25 Jun 2012 21:18:25 -0400
Message-ID: <1340673505-10551-10-git-send-email-pw@padd.com>
References: <1340673505-10551-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 03:23:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjKVJ-0004Kg-Ir
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 03:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009Ab2FZBVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 21:21:30 -0400
Received: from honk.padd.com ([74.3.171.149]:45542 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757794Ab2FZBV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 21:21:29 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id EF1C62E87;
	Mon, 25 Jun 2012 18:21:28 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A1CD431383; Mon, 25 Jun 2012 21:21:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.72.gebb7ee5
In-Reply-To: <1340673505-10551-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200617>

The original t9800 test code has a mix of assorted topics, some
of which are big enough to deserve their own homes.
Interdependencies between the topics make it confusing when
trying to study one in isolation.  And it takes so long to run
that debugging an individual test is difficult.

Split out three big chunks of tests into their own files:

    t9812-git-p4-wildcards.sh gets the 8 p4 wildcard tests

    t9813-git-p4-preserve-users.sh gets the 4 --preserve-user tests

    t9814-git-p4-rename.sh gets the 2 copy and rename tests

Test 9800 execution time drops from 29 sec to 9 sec.  The
sequential time to run all tests is a slower due to the three
extra p4d startup/shutdown sequences, but the overall parallel
execution time is about the same, at 52 sec.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4-basic.sh          | 397 ---------------------------------------
 t/t9812-git-p4-wildcards.sh      | 147 +++++++++++++++
 t/t9813-git-p4-preserve-users.sh | 153 +++++++++++++++
 t/t9814-git-p4-rename.sh         | 206 ++++++++++++++++++++
 4 files changed, 506 insertions(+), 397 deletions(-)
 create mode 100755 t/t9812-git-p4-wildcards.sh
 create mode 100755 t/t9813-git-p4-preserve-users.sh
 create mode 100755 t/t9814-git-p4-rename.sh

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 234f727..befd823 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -139,136 +139,6 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
 	test_must_fail grep -q Traceback errs
 '
 
-test_expect_success 'add p4 files with wildcards in the names' '
-	(
-		cd "$cli" &&
-		echo file-wild-hash >file-wild#hash &&
-		echo file-wild-star >file-wild\*star &&
-		echo file-wild-at >file-wild@at &&
-		echo file-wild-percent >file-wild%percent &&
-		p4 add -f file-wild* &&
-		p4 submit -d "file wildcards"
-	)
-'
-
-test_expect_success 'wildcard files git p4 clone' '
-	git p4 clone --dest="$git" //depot &&
-	test_when_finished cleanup_git &&
-	(
-		cd "$git" &&
-		test -f file-wild#hash &&
-		test -f file-wild\*star &&
-		test -f file-wild@at &&
-		test -f file-wild%percent
-	)
-'
-
-test_expect_success 'wildcard files submit back to p4, add' '
-	test_when_finished cleanup_git &&
-	git p4 clone --dest="$git" //depot &&
-	(
-		cd "$git" &&
-		echo git-wild-hash >git-wild#hash &&
-		echo git-wild-star >git-wild\*star &&
-		echo git-wild-at >git-wild@at &&
-		echo git-wild-percent >git-wild%percent &&
-		git add git-wild* &&
-		git commit -m "add some wildcard filenames" &&
-		git config git-p4.skipSubmitEdit true &&
-		git p4 submit
-	) &&
-	(
-		cd "$cli" &&
-		test_path_is_file git-wild#hash &&
-		test_path_is_file git-wild\*star &&
-		test_path_is_file git-wild@at &&
-		test_path_is_file git-wild%percent
-	)
-'
-
-test_expect_success 'wildcard files submit back to p4, modify' '
-	test_when_finished cleanup_git &&
-	git p4 clone --dest="$git" //depot &&
-	(
-		cd "$git" &&
-		echo new-line >>git-wild#hash &&
-		echo new-line >>git-wild\*star &&
-		echo new-line >>git-wild@at &&
-		echo new-line >>git-wild%percent &&
-		git add git-wild* &&
-		git commit -m "modify the wildcard files" &&
-		git config git-p4.skipSubmitEdit true &&
-		git p4 submit
-	) &&
-	(
-		cd "$cli" &&
-		test_line_count = 2 git-wild#hash &&
-		test_line_count = 2 git-wild\*star &&
-		test_line_count = 2 git-wild@at &&
-		test_line_count = 2 git-wild%percent
-	)
-'
-
-test_expect_success 'wildcard files submit back to p4, copy' '
-	test_when_finished cleanup_git &&
-	git p4 clone --dest="$git" //depot &&
-	(
-		cd "$git" &&
-		cp file2 git-wild-cp#hash &&
-		git add git-wild-cp#hash &&
-		cp git-wild\*star file-wild-3 &&
-		git add file-wild-3 &&
-		git commit -m "wildcard copies" &&
-		git config git-p4.detectCopies true &&
-		git config git-p4.detectCopiesHarder true &&
-		git config git-p4.skipSubmitEdit true &&
-		git p4 submit
-	) &&
-	(
-		cd "$cli" &&
-		test_path_is_file git-wild-cp#hash &&
-		test_path_is_file file-wild-3
-	)
-'
-
-test_expect_success 'wildcard files submit back to p4, rename' '
-	test_when_finished cleanup_git &&
-	git p4 clone --dest="$git" //depot &&
-	(
-		cd "$git" &&
-		git mv git-wild@at file-wild-4 &&
-		git mv file-wild-3 git-wild-cp%percent &&
-		git commit -m "wildcard renames" &&
-		git config git-p4.detectRenames true &&
-		git config git-p4.skipSubmitEdit true &&
-		git p4 submit
-	) &&
-	(
-		cd "$cli" &&
-		test_path_is_missing git-wild@at &&
-		test_path_is_file git-wild-cp%percent
-	)
-'
-
-test_expect_success 'wildcard files submit back to p4, delete' '
-	test_when_finished cleanup_git &&
-	git p4 clone --dest="$git" //depot &&
-	(
-		cd "$git" &&
-		git rm git-wild* &&
-		git commit -m "delete the wildcard files" &&
-		git config git-p4.skipSubmitEdit true &&
-		git p4 submit
-	) &&
-	(
-		cd "$cli" &&
-		test_path_is_missing git-wild#hash &&
-		test_path_is_missing git-wild\*star &&
-		test_path_is_missing git-wild@at &&
-		test_path_is_missing git-wild%percent
-	)
-'
-
 test_expect_success 'clone bare' '
 	rm -rf "$git" &&
 	git p4 clone --dest="$git" --bare //depot &&
@@ -281,133 +151,6 @@ test_expect_success 'clone bare' '
 	)
 '
 
-p4_add_user() {
-	name=$1 fullname=$2 &&
-	p4 user -f -i <<-EOF &&
-	User: $name
-	Email: $name@localhost
-	FullName: $fullname
-	EOF
-	p4 passwd -P secret $name
-}
-
-p4_grant_admin() {
-	name=$1 &&
-	{
-		p4 protect -o &&
-		echo "    admin user $name * //depot/..."
-	} | p4 protect -i
-}
-
-p4_check_commit_author() {
-	file=$1 user=$2 &&
-	p4 changes -m 1 //depot/$file | grep -q $user
-}
-
-make_change_by_user() {
-	file=$1 name=$2 email=$3 &&
-	echo "username: a change by $name" >>"$file" &&
-	git add "$file" &&
-	git commit --author "$name <$email>" -m "a change by $name"
-}
-
-# Test username support, submitting as user 'alice'
-test_expect_success 'preserve users' '
-	p4_add_user alice Alice &&
-	p4_add_user bob Bob &&
-	p4_grant_admin alice &&
-	git p4 clone --dest="$git" //depot &&
-	test_when_finished cleanup_git &&
-	(
-		cd "$git" &&
-		echo "username: a change by alice" >>file1 &&
-		echo "username: a change by bob" >>file2 &&
-		git commit --author "Alice <alice@localhost>" -m "a change by alice" file1 &&
-		git commit --author "Bob <bob@localhost>" -m "a change by bob" file2 &&
-		git config git-p4.skipSubmitEditCheck true &&
-		P4EDITOR=touch P4USER=alice P4PASSWD=secret git p4 commit --preserve-user &&
-		p4_check_commit_author file1 alice &&
-		p4_check_commit_author file2 bob
-	)
-'
-
-# Test username support, submitting as bob, who lacks admin rights. Should
-# not submit change to p4 (git diff should show deltas).
-test_expect_success 'refuse to preserve users without perms' '
-	git p4 clone --dest="$git" //depot &&
-	test_when_finished cleanup_git &&
-	(
-		cd "$git" &&
-		git config git-p4.skipSubmitEditCheck true &&
-		echo "username-noperms: a change by alice" >>file1 &&
-		git commit --author "Alice <alice@localhost>" -m "perms: a change by alice" file1 &&
-		P4EDITOR=touch P4USER=bob P4PASSWD=secret &&
-		export P4EDITOR P4USER P4PASSWD &&
-		test_must_fail git p4 commit --preserve-user &&
-		! git diff --exit-code HEAD..p4/master
-	)
-'
-
-# What happens with unknown author? Without allowMissingP4Users it should fail.
-test_expect_success 'preserve user where author is unknown to p4' '
-	git p4 clone --dest="$git" //depot &&
-	test_when_finished cleanup_git &&
-	(
-		cd "$git" &&
-		git config git-p4.skipSubmitEditCheck true &&
-		echo "username-bob: a change by bob" >>file1 &&
-		git commit --author "Bob <bob@localhost>" -m "preserve: a change by bob" file1 &&
-		echo "username-unknown: a change by charlie" >>file1 &&
-		git commit --author "Charlie <charlie@localhost>" -m "preserve: a change by charlie" file1 &&
-		P4EDITOR=touch P4USER=alice P4PASSWD=secret &&
-		export P4EDITOR P4USER P4PASSWD &&
-		test_must_fail git p4 commit --preserve-user &&
-		! git diff --exit-code HEAD..p4/master &&
-
-		echo "$0: repeat with allowMissingP4Users enabled" &&
-		git config git-p4.allowMissingP4Users true &&
-		git config git-p4.preserveUser true &&
-		git p4 commit &&
-		git diff --exit-code HEAD..p4/master &&
-		p4_check_commit_author file1 alice
-	)
-'
-
-# If we're *not* using --preserve-user, git p4 should warn if we're submitting
-# changes that are not all ours.
-# Test: user in p4 and user unknown to p4.
-# Test: warning disabled and user is the same.
-test_expect_success 'not preserving user with mixed authorship' '
-	git p4 clone --dest="$git" //depot &&
-	test_when_finished cleanup_git &&
-	(
-		cd "$git" &&
-		git config git-p4.skipSubmitEditCheck true &&
-		p4_add_user derek Derek &&
-
-		make_change_by_user usernamefile3 Derek derek@localhost &&
-		P4EDITOR=cat P4USER=alice P4PASSWD=secret &&
-		export P4EDITOR P4USER P4PASSWD &&
-		git p4 commit |\
-		grep "git author derek@localhost does not match" &&
-
-		make_change_by_user usernamefile3 Charlie charlie@localhost &&
-		git p4 commit |\
-		grep "git author charlie@localhost does not match" &&
-
-		make_change_by_user usernamefile3 alice alice@localhost &&
-		git p4 commit |\
-		test_must_fail grep "git author.*does not match" &&
-
-		git config git-p4.skipUserNameCheck true &&
-		make_change_by_user usernamefile3 Charlie charlie@localhost &&
-		git p4 commit |\
-		test_must_fail grep "git author.*does not match" &&
-
-		p4_check_commit_author usernamefile3 alice
-	)
-'
-
 marshal_dump() {
 	what=$1
 	"$PYTHON_PATH" -c 'import marshal, sys; d = marshal.load(sys.stdin); print d["'$what'"]'
@@ -430,146 +173,6 @@ test_expect_success 'initial import time from top change time' '
 	)
 '
 
-# Rename a file and confirm that rename is not detected in P4.
-# Rename the new file again with detectRenames option enabled and confirm that
-# this is detected in P4.
-# Rename the new file again adding an extra line, configure a big threshold in
-# detectRenames and confirm that rename is not detected in P4.
-# Repeat, this time with a smaller threshold and confirm that the rename is
-# detected in P4.
-test_expect_success 'detect renames' '
-	git p4 clone --dest="$git" //depot@all &&
-	test_when_finished cleanup_git &&
-	(
-		cd "$git" &&
-		git config git-p4.skipSubmitEdit true &&
-
-		git mv file1 file4 &&
-		git commit -a -m "Rename file1 to file4" &&
-		git diff-tree -r -M HEAD &&
-		git p4 submit &&
-		p4 filelog //depot/file4 &&
-		p4 filelog //depot/file4 | test_must_fail grep -q "branch from" &&
-
-		git mv file4 file5 &&
-		git commit -a -m "Rename file4 to file5" &&
-		git diff-tree -r -M HEAD &&
-		git config git-p4.detectRenames true &&
-		git p4 submit &&
-		p4 filelog //depot/file5 &&
-		p4 filelog //depot/file5 | grep -q "branch from //depot/file4" &&
-
-		git mv file5 file6 &&
-		echo update >>file6 &&
-		git add file6 &&
-		git commit -a -m "Rename file5 to file6 with changes" &&
-		git diff-tree -r -M HEAD &&
-		level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
-		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
-		git config git-p4.detectRenames $(($level + 2)) &&
-		git p4 submit &&
-		p4 filelog //depot/file6 &&
-		p4 filelog //depot/file6 | test_must_fail grep -q "branch from" &&
-
-		git mv file6 file7 &&
-		echo update >>file7 &&
-		git add file7 &&
-		git commit -a -m "Rename file6 to file7 with changes" &&
-		git diff-tree -r -M HEAD &&
-		level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
-		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
-		git config git-p4.detectRenames $(($level - 2)) &&
-		git p4 submit &&
-		p4 filelog //depot/file7 &&
-		p4 filelog //depot/file7 | grep -q "branch from //depot/file6"
-	)
-'
-
-# Copy a file and confirm that copy is not detected in P4.
-# Copy a file with detectCopies option enabled and confirm that copy is not
-# detected in P4.
-# Modify and copy a file with detectCopies option enabled and confirm that copy
-# is detected in P4.
-# Copy a file with detectCopies and detectCopiesHarder options enabled and
-# confirm that copy is detected in P4.
-# Modify and copy a file, configure a bigger threshold in detectCopies and
-# confirm that copy is not detected in P4.
-# Modify and copy a file, configure a smaller threshold in detectCopies and
-# confirm that copy is detected in P4.
-test_expect_success 'detect copies' '
-	git p4 clone --dest="$git" //depot@all &&
-	test_when_finished cleanup_git &&
-	(
-		cd "$git" &&
-		git config git-p4.skipSubmitEdit true &&
-
-		cp file2 file8 &&
-		git add file8 &&
-		git commit -a -m "Copy file2 to file8" &&
-		git diff-tree -r -C HEAD &&
-		git p4 submit &&
-		p4 filelog //depot/file8 &&
-		p4 filelog //depot/file8 | test_must_fail grep -q "branch from" &&
-
-		cp file2 file9 &&
-		git add file9 &&
-		git commit -a -m "Copy file2 to file9" &&
-		git diff-tree -r -C HEAD &&
-		git config git-p4.detectCopies true &&
-		git p4 submit &&
-		p4 filelog //depot/file9 &&
-		p4 filelog //depot/file9 | test_must_fail grep -q "branch from" &&
-
-		echo "file2" >>file2 &&
-		cp file2 file10 &&
-		git add file2 file10 &&
-		git commit -a -m "Modify and copy file2 to file10" &&
-		git diff-tree -r -C HEAD &&
-		git p4 submit &&
-		p4 filelog //depot/file10 &&
-		p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
-
-		cp file2 file11 &&
-		git add file11 &&
-		git commit -a -m "Copy file2 to file11" &&
-		git diff-tree -r -C --find-copies-harder HEAD &&
-		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 &&
-		git config git-p4.detectCopiesHarder true &&
-		git p4 submit &&
-		p4 filelog //depot/file11 &&
-		p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
-
-		cp file2 file12 &&
-		echo "some text" >>file12 &&
-		git add file12 &&
-		git commit -a -m "Copy file2 to file12 with changes" &&
-		git diff-tree -r -C --find-copies-harder HEAD &&
-		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
-		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
-		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 -o "$src" = file11 &&
-		git config git-p4.detectCopies $(($level + 2)) &&
-		git p4 submit &&
-		p4 filelog //depot/file12 &&
-		p4 filelog //depot/file12 | test_must_fail grep -q "branch from" &&
-
-		cp file2 file13 &&
-		echo "different text" >>file13 &&
-		git add file13 &&
-		git commit -a -m "Copy file2 to file13 with changes" &&
-		git diff-tree -r -C --find-copies-harder HEAD &&
-		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
-		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
-		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 -o "$src" = file11 -o "$src" = file12 &&
-		git config git-p4.detectCopies $(($level - 2)) &&
-		git p4 submit &&
-		p4 filelog //depot/file13 &&
-		p4 filelog //depot/file13 | grep -q "branch from //depot/file"
-	)
-'
-
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
diff --git a/t/t9812-git-p4-wildcards.sh b/t/t9812-git-p4-wildcards.sh
new file mode 100755
index 0000000..143d413
--- /dev/null
+++ b/t/t9812-git-p4-wildcards.sh
@@ -0,0 +1,147 @@
+#!/bin/sh
+
+test_description='git p4 wildcards'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'add p4 files with wildcards in the names' '
+	(
+		cd "$cli" &&
+		printf "file2\nhas\nsome\nrandom\ntext\n" >file2 &&
+		p4 add file2 &&
+		echo file-wild-hash >file-wild#hash &&
+		echo file-wild-star >file-wild\*star &&
+		echo file-wild-at >file-wild@at &&
+		echo file-wild-percent >file-wild%percent &&
+		p4 add -f file-wild* &&
+		p4 submit -d "file wildcards"
+	)
+'
+
+test_expect_success 'wildcard files git p4 clone' '
+	git p4 clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		test -f file-wild#hash &&
+		test -f file-wild\*star &&
+		test -f file-wild@at &&
+		test -f file-wild%percent
+	)
+'
+
+test_expect_success 'wildcard files submit back to p4, add' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo git-wild-hash >git-wild#hash &&
+		echo git-wild-star >git-wild\*star &&
+		echo git-wild-at >git-wild@at &&
+		echo git-wild-percent >git-wild%percent &&
+		git add git-wild* &&
+		git commit -m "add some wildcard filenames" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file git-wild#hash &&
+		test_path_is_file git-wild\*star &&
+		test_path_is_file git-wild@at &&
+		test_path_is_file git-wild%percent
+	)
+'
+
+test_expect_success 'wildcard files submit back to p4, modify' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo new-line >>git-wild#hash &&
+		echo new-line >>git-wild\*star &&
+		echo new-line >>git-wild@at &&
+		echo new-line >>git-wild%percent &&
+		git add git-wild* &&
+		git commit -m "modify the wildcard files" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_line_count = 2 git-wild#hash &&
+		test_line_count = 2 git-wild\*star &&
+		test_line_count = 2 git-wild@at &&
+		test_line_count = 2 git-wild%percent
+	)
+'
+
+test_expect_success 'wildcard files submit back to p4, copy' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		cp file2 git-wild-cp#hash &&
+		git add git-wild-cp#hash &&
+		cp git-wild\*star file-wild-3 &&
+		git add file-wild-3 &&
+		git commit -m "wildcard copies" &&
+		git config git-p4.detectCopies true &&
+		git config git-p4.detectCopiesHarder true &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file git-wild-cp#hash &&
+		test_path_is_file file-wild-3
+	)
+'
+
+test_expect_success 'wildcard files submit back to p4, rename' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git mv git-wild@at file-wild-4 &&
+		git mv file-wild-3 git-wild-cp%percent &&
+		git commit -m "wildcard renames" &&
+		git config git-p4.detectRenames true &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing git-wild@at &&
+		test_path_is_file git-wild-cp%percent
+	)
+'
+
+test_expect_success 'wildcard files submit back to p4, delete' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git rm git-wild* &&
+		git commit -m "delete the wildcard files" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing git-wild#hash &&
+		test_path_is_missing git-wild\*star &&
+		test_path_is_missing git-wild@at &&
+		test_path_is_missing git-wild%percent
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
new file mode 100755
index 0000000..f2e85e5
--- /dev/null
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -0,0 +1,153 @@
+#!/bin/sh
+
+test_description='git p4 preserve users'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'create files' '
+	(
+		cd "$cli" &&
+		p4 client -o | sed "/LineEnd/s/:.*/:unix/" | p4 client -i &&
+		echo file1 >file1 &&
+		echo file2 >file2 &&
+		p4 add file1 file2 &&
+		p4 submit -d "add files"
+	)
+'
+
+p4_add_user() {
+	name=$1 fullname=$2 &&
+	p4 user -f -i <<-EOF &&
+	User: $name
+	Email: $name@localhost
+	FullName: $fullname
+	EOF
+	p4 passwd -P secret $name
+}
+
+p4_grant_admin() {
+	name=$1 &&
+	{
+		p4 protect -o &&
+		echo "    admin user $name * //depot/..."
+	} | p4 protect -i
+}
+
+p4_check_commit_author() {
+	file=$1 user=$2 &&
+	p4 changes -m 1 //depot/$file | grep -q $user
+}
+
+make_change_by_user() {
+	file=$1 name=$2 email=$3 &&
+	echo "username: a change by $name" >>"$file" &&
+	git add "$file" &&
+	git commit --author "$name <$email>" -m "a change by $name"
+}
+
+# Test username support, submitting as user 'alice'
+test_expect_success 'preserve users' '
+	p4_add_user alice Alice &&
+	p4_add_user bob Bob &&
+	p4_grant_admin alice &&
+	git p4 clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		echo "username: a change by alice" >>file1 &&
+		echo "username: a change by bob" >>file2 &&
+		git commit --author "Alice <alice@localhost>" -m "a change by alice" file1 &&
+		git commit --author "Bob <bob@localhost>" -m "a change by bob" file2 &&
+		git config git-p4.skipSubmitEditCheck true &&
+		P4EDITOR=touch P4USER=alice P4PASSWD=secret git p4 commit --preserve-user &&
+		p4_check_commit_author file1 alice &&
+		p4_check_commit_author file2 bob
+	)
+'
+
+# Test username support, submitting as bob, who lacks admin rights. Should
+# not submit change to p4 (git diff should show deltas).
+test_expect_success 'refuse to preserve users without perms' '
+	git p4 clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEditCheck true &&
+		echo "username-noperms: a change by alice" >>file1 &&
+		git commit --author "Alice <alice@localhost>" -m "perms: a change by alice" file1 &&
+		P4EDITOR=touch P4USER=bob P4PASSWD=secret &&
+		export P4EDITOR P4USER P4PASSWD &&
+		test_must_fail git p4 commit --preserve-user &&
+		! git diff --exit-code HEAD..p4/master
+	)
+'
+
+# What happens with unknown author? Without allowMissingP4Users it should fail.
+test_expect_success 'preserve user where author is unknown to p4' '
+	git p4 clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEditCheck true &&
+		echo "username-bob: a change by bob" >>file1 &&
+		git commit --author "Bob <bob@localhost>" -m "preserve: a change by bob" file1 &&
+		echo "username-unknown: a change by charlie" >>file1 &&
+		git commit --author "Charlie <charlie@localhost>" -m "preserve: a change by charlie" file1 &&
+		P4EDITOR=touch P4USER=alice P4PASSWD=secret &&
+		export P4EDITOR P4USER P4PASSWD &&
+		test_must_fail git p4 commit --preserve-user &&
+		! git diff --exit-code HEAD..p4/master &&
+
+		echo "$0: repeat with allowMissingP4Users enabled" &&
+		git config git-p4.allowMissingP4Users true &&
+		git config git-p4.preserveUser true &&
+		git p4 commit &&
+		git diff --exit-code HEAD..p4/master &&
+		p4_check_commit_author file1 alice
+	)
+'
+
+# If we're *not* using --preserve-user, git-p4 should warn if we're submitting
+# changes that are not all ours.
+# Test: user in p4 and user unknown to p4.
+# Test: warning disabled and user is the same.
+test_expect_success 'not preserving user with mixed authorship' '
+	git p4 clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEditCheck true &&
+		p4_add_user derek Derek &&
+
+		make_change_by_user usernamefile3 Derek derek@localhost &&
+		P4EDITOR=cat P4USER=alice P4PASSWD=secret &&
+		export P4EDITOR P4USER P4PASSWD &&
+		git p4 commit |\
+		grep "git author derek@localhost does not match" &&
+
+		make_change_by_user usernamefile3 Charlie charlie@localhost &&
+		git p4 commit |\
+		grep "git author charlie@localhost does not match" &&
+
+		make_change_by_user usernamefile3 alice alice@localhost &&
+		git p4 commit |\
+		test_must_fail grep "git author.*does not match" &&
+
+		git config git-p4.skipUserNameCheck true &&
+		make_change_by_user usernamefile3 Charlie charlie@localhost &&
+		git p4 commit |\
+		test_must_fail grep "git author.*does not match" &&
+
+		p4_check_commit_author usernamefile3 alice
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
new file mode 100755
index 0000000..84fffb3
--- /dev/null
+++ b/t/t9814-git-p4-rename.sh
@@ -0,0 +1,206 @@
+#!/bin/sh
+
+test_description='git p4 rename'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+# We rely on this behavior to detect for p4 move availability.
+test_expect_success 'p4 help unknown returns 1' '
+	(
+		cd "$cli" &&
+		(
+			p4 help client >errs 2>&1
+			echo $? >retval
+		)
+		echo 0 >expected &&
+		test_cmp expected retval &&
+		rm retval &&
+		(
+			p4 help nosuchcommand >errs 2>&1
+			echo $? >retval
+		)
+		echo 1 >expected &&
+		test_cmp expected retval &&
+		rm retval
+	)
+'
+
+test_expect_success 'create files' '
+	(
+		cd "$cli" &&
+		p4 client -o | sed "/LineEnd/s/:.*/:unix/" | p4 client -i &&
+		cat >file1 <<-EOF &&
+		A large block of text
+		in file1 that will generate
+		enough context so that rename
+		and copy detection will find
+		something interesting to do.
+		EOF
+		cat >file2 <<-EOF &&
+		/*
+		 * This blob looks a bit
+		 * different.
+		 */
+		int main(int argc, char **argv)
+		{
+			char text[200];
+
+			strcpy(text, "copy/rename this");
+			printf("text is %s\n", text);
+			return 0;
+		}
+		EOF
+		p4 add file1 file2 &&
+		p4 submit -d "add files"
+	)
+'
+
+# Rename a file and confirm that rename is not detected in P4.
+# Rename the new file again with detectRenames option enabled and confirm that
+# this is detected in P4.
+# Rename the new file again adding an extra line, configure a big threshold in
+# detectRenames and confirm that rename is not detected in P4.
+# Repeat, this time with a smaller threshold and confirm that the rename is
+# detected in P4.
+test_expect_success 'detect renames' '
+	git p4 clone --dest="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+
+		git mv file1 file4 &&
+		git commit -a -m "Rename file1 to file4" &&
+		git diff-tree -r -M HEAD &&
+		git p4 submit &&
+		p4 filelog //depot/file4 &&
+		p4 filelog //depot/file4 | test_must_fail grep -q "branch from" &&
+
+		git mv file4 file5 &&
+		git commit -a -m "Rename file4 to file5" &&
+		git diff-tree -r -M HEAD &&
+		git config git-p4.detectRenames true &&
+		git p4 submit &&
+		p4 filelog //depot/file5 &&
+		p4 filelog //depot/file5 | grep -q "branch from //depot/file4" &&
+
+		git mv file5 file6 &&
+		echo update >>file6 &&
+		git add file6 &&
+		git commit -a -m "Rename file5 to file6 with changes" &&
+		git diff-tree -r -M HEAD &&
+		level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
+		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
+		git config git-p4.detectRenames $(($level + 2)) &&
+		git p4 submit &&
+		p4 filelog //depot/file6 &&
+		p4 filelog //depot/file6 | test_must_fail grep -q "branch from" &&
+
+		git mv file6 file7 &&
+		echo update >>file7 &&
+		git add file7 &&
+		git commit -a -m "Rename file6 to file7 with changes" &&
+		git diff-tree -r -M HEAD &&
+		level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
+		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
+		git config git-p4.detectRenames $(($level - 2)) &&
+		git p4 submit &&
+		p4 filelog //depot/file7 &&
+		p4 filelog //depot/file7 | grep -q "branch from //depot/file6"
+	)
+'
+
+# Copy a file and confirm that copy is not detected in P4.
+# Copy a file with detectCopies option enabled and confirm that copy is not
+# detected in P4.
+# Modify and copy a file with detectCopies option enabled and confirm that copy
+# is detected in P4.
+# Copy a file with detectCopies and detectCopiesHarder options enabled and
+# confirm that copy is detected in P4.
+# Modify and copy a file, configure a bigger threshold in detectCopies and
+# confirm that copy is not detected in P4.
+# Modify and copy a file, configure a smaller threshold in detectCopies and
+# confirm that copy is detected in P4.
+test_expect_success 'detect copies' '
+	git p4 clone --dest="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+
+		cp file2 file8 &&
+		git add file8 &&
+		git commit -a -m "Copy file2 to file8" &&
+		git diff-tree -r -C HEAD &&
+		git p4 submit &&
+		p4 filelog //depot/file8 &&
+		p4 filelog //depot/file8 | test_must_fail grep -q "branch from" &&
+
+		cp file2 file9 &&
+		git add file9 &&
+		git commit -a -m "Copy file2 to file9" &&
+		git diff-tree -r -C HEAD &&
+		git config git-p4.detectCopies true &&
+		git p4 submit &&
+		p4 filelog //depot/file9 &&
+		p4 filelog //depot/file9 | test_must_fail grep -q "branch from" &&
+
+		echo "file2" >>file2 &&
+		cp file2 file10 &&
+		git add file2 file10 &&
+		git commit -a -m "Modify and copy file2 to file10" &&
+		git diff-tree -r -C HEAD &&
+		git p4 submit &&
+		p4 filelog //depot/file10 &&
+		p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
+
+		cp file2 file11 &&
+		git add file11 &&
+		git commit -a -m "Copy file2 to file11" &&
+		git diff-tree -r -C --find-copies-harder HEAD &&
+		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
+		test "$src" = file10 &&
+		git config git-p4.detectCopiesHarder true &&
+		git p4 submit &&
+		p4 filelog //depot/file11 &&
+		p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
+
+		cp file2 file12 &&
+		echo "some text" >>file12 &&
+		git add file12 &&
+		git commit -a -m "Copy file2 to file12 with changes" &&
+		git diff-tree -r -C --find-copies-harder HEAD &&
+		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
+		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
+		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
+		test "$src" = file10 -o "$src" = file11 &&
+		git config git-p4.detectCopies $(($level + 2)) &&
+		git p4 submit &&
+		p4 filelog //depot/file12 &&
+		p4 filelog //depot/file12 | test_must_fail grep -q "branch from" &&
+
+		cp file2 file13 &&
+		echo "different text" >>file13 &&
+		git add file13 &&
+		git commit -a -m "Copy file2 to file13 with changes" &&
+		git diff-tree -r -C --find-copies-harder HEAD &&
+		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
+		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
+		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
+		test "$src" = file10 -o "$src" = file11 -o "$src" = file12 &&
+		git config git-p4.detectCopies $(($level - 2)) &&
+		git p4 submit &&
+		p4 filelog //depot/file13 &&
+		p4 filelog //depot/file13 | grep -q "branch from //depot/file"
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.11.rc2.72.gebb7ee5
