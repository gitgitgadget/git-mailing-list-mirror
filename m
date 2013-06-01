From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 11/11] t6035: use test_ln_s_add to remove SYMLINKS prerequisite
Date: Sat,  1 Jun 2013 11:34:30 +0200
Message-ID: <8a25465341d7607f41292f43bf65aac04f7f8920.1370076477.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 01 11:35:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiiDK-0002Bb-Rc
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 11:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910Ab3FAJex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 05:34:53 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:34557 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755965Ab3FAJef (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 05:34:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B808610013
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:33 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id DBDFE19F5E0
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:32 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226112>

All tests in t6035 are protected by SYMLINKS. But that is not necessary,
because a lot of the functionality can be tested provided symbolic link
entries enter the index and object data base. Use test_ln_s_add for this
purpose.

Some test cases do test the presence of symbolic links on the file system.
Move these tests into separate test cases that remain protected by
SYMLINKS.

There is one instance of expect_failure. There is a possibility that this
test case fails differently depending on whether SYMLINKS is present or
not; but this is not the case.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t6035-merge-dir-to-symlink.sh | 73 ++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index 2599ae5..9324ea4 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -3,7 +3,7 @@
 test_description='merging when a directory was replaced with a symlink'
 . ./test-lib.sh
 
-test_expect_success SYMLINKS 'create a commit where dir a/b changed to symlink' '
+test_expect_success 'create a commit where dir a/b changed to symlink' '
 	mkdir -p a/b/c a/b-2/c &&
 	> a/b/c/d &&
 	> a/b-2/c/d &&
@@ -12,12 +12,12 @@ test_expect_success SYMLINKS 'create a commit where dir a/b changed to symlink'
 	git commit -m base &&
 	git tag start &&
 	rm -rf a/b &&
-	ln -s b-2 a/b &&
 	git add -A &&
+	test_ln_s_add b-2 a/b &&
 	git commit -m "dir to symlink"
 '
 
-test_expect_success SYMLINKS 'checkout does not clobber untracked symlink' '
+test_expect_success 'checkout does not clobber untracked symlink' '
 	git checkout HEAD^0 &&
 	git reset --hard master &&
 	git rm --cached a/b &&
@@ -25,7 +25,7 @@ test_expect_success SYMLINKS 'checkout does not clobber untracked symlink' '
 	test_must_fail git checkout start^0
 '
 
-test_expect_success SYMLINKS 'a/b-2/c/d is kept when clobbering symlink b' '
+test_expect_success 'a/b-2/c/d is kept when clobbering symlink b' '
 	git checkout HEAD^0 &&
 	git reset --hard master &&
 	git rm --cached a/b &&
@@ -34,14 +34,14 @@ test_expect_success SYMLINKS 'a/b-2/c/d is kept when clobbering symlink b' '
 	test -f a/b-2/c/d
 '
 
-test_expect_success SYMLINKS 'checkout should not have deleted a/b-2/c/d' '
+test_expect_success 'checkout should not have deleted a/b-2/c/d' '
 	git checkout HEAD^0 &&
 	git reset --hard master &&
 	 git checkout start^0 &&
 	 test -f a/b-2/c/d
 '
 
-test_expect_success SYMLINKS 'setup for merge test' '
+test_expect_success 'setup for merge test' '
 	git reset --hard &&
 	test -f a/b-2/c/d &&
 	echo x > a/x &&
@@ -50,39 +50,51 @@ test_expect_success SYMLINKS 'setup for merge test' '
 	git tag baseline
 '
 
-test_expect_success SYMLINKS 'Handle D/F conflict, do not lose a/b-2/c/d in merge (resolve)' '
+test_expect_success 'Handle D/F conflict, do not lose a/b-2/c/d in merge (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s resolve master &&
-	test -h a/b &&
 	test -f a/b-2/c/d
 '
 
-test_expect_success SYMLINKS 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recursive)' '
+test_expect_success SYMLINKS 'a/b was resolved as symlink' '
+	test -h a/b
+'
+
+test_expect_success 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s recursive master &&
-	test -h a/b &&
 	test -f a/b-2/c/d
 '
 
-test_expect_success SYMLINKS 'Handle F/D conflict, do not lose a/b-2/c/d in merge (resolve)' '
+test_expect_success SYMLINKS 'a/b was resolved as symlink' '
+	test -h a/b
+'
+
+test_expect_success 'Handle F/D conflict, do not lose a/b-2/c/d in merge (resolve)' '
 	git reset --hard &&
 	git checkout master^0 &&
 	git merge -s resolve baseline^0 &&
-	test -h a/b &&
 	test -f a/b-2/c/d
 '
 
-test_expect_success SYMLINKS 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
+test_expect_success SYMLINKS 'a/b was resolved as symlink' '
+	test -h a/b
+'
+
+test_expect_success 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
 	git reset --hard &&
 	git checkout master^0 &&
 	git merge -s recursive baseline^0 &&
-	test -h a/b &&
 	test -f a/b-2/c/d
 '
 
-test_expect_failure SYMLINKS 'do not lose untracked in merge (resolve)' '
+test_expect_success SYMLINKS 'a/b was resolved as symlink' '
+	test -h a/b
+'
+
+test_expect_failure 'do not lose untracked in merge (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	>a/b/c/e &&
@@ -91,7 +103,7 @@ test_expect_failure SYMLINKS 'do not lose untracked in merge (resolve)' '
 	test -f a/b-2/c/d
 '
 
-test_expect_success SYMLINKS 'do not lose untracked in merge (recursive)' '
+test_expect_success 'do not lose untracked in merge (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	>a/b/c/e &&
@@ -100,52 +112,61 @@ test_expect_success SYMLINKS 'do not lose untracked in merge (recursive)' '
 	test -f a/b-2/c/d
 '
 
-test_expect_success SYMLINKS 'do not lose modifications in merge (resolve)' '
+test_expect_success 'do not lose modifications in merge (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	echo more content >>a/b/c/d &&
 	test_must_fail git merge -s resolve master
 '
 
-test_expect_success SYMLINKS 'do not lose modifications in merge (recursive)' '
+test_expect_success 'do not lose modifications in merge (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	echo more content >>a/b/c/d &&
 	test_must_fail git merge -s recursive master
 '
 
-test_expect_success SYMLINKS 'setup a merge where dir a/b-2 changed to symlink' '
+test_expect_success 'setup a merge where dir a/b-2 changed to symlink' '
 	git reset --hard &&
 	git checkout start^0 &&
 	rm -rf a/b-2 &&
-	ln -s b a/b-2 &&
 	git add -A &&
+	test_ln_s_add b a/b-2 &&
 	git commit -m "dir a/b-2 to symlink" &&
 	git tag test2
 '
 
-test_expect_success SYMLINKS 'merge should not have D/F conflicts (resolve)' '
+test_expect_success 'merge should not have D/F conflicts (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s resolve test2 &&
-	test -h a/b-2 &&
 	test -f a/b/c/d
 '
 
-test_expect_success SYMLINKS 'merge should not have D/F conflicts (recursive)' '
+test_expect_success SYMLINKS 'a/b-2 was resolved as symlink' '
+	test -h a/b-2
+'
+
+test_expect_success 'merge should not have D/F conflicts (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s recursive test2 &&
-	test -h a/b-2 &&
 	test -f a/b/c/d
 '
 
-test_expect_success SYMLINKS 'merge should not have F/D conflicts (recursive)' '
+test_expect_success SYMLINKS 'a/b-2 was resolved as symlink' '
+	test -h a/b-2
+'
+
+test_expect_success 'merge should not have F/D conflicts (recursive)' '
 	git reset --hard &&
 	git checkout -b foo test2 &&
 	git merge -s recursive baseline^0 &&
-	test -h a/b-2 &&
 	test -f a/b/c/d
 '
 
+test_expect_success SYMLINKS 'a/b-2 was resolved as symlink' '
+	test -h a/b-2
+'
+
 test_done
-- 
1.8.3.rc1.32.g8b61cbb
