From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 10/11] t3509, t4023, t4114: use test_ln_s_add to remove SYMLINKS prerequisite
Date: Sat,  1 Jun 2013 11:34:29 +0200
Message-ID: <984288047a44d58c55009c32a96d92104d7988c6.1370076477.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 01 11:35:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiiDL-0002Bb-UD
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 11:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974Ab3FAJe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 05:34:57 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:48408 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756047Ab3FAJef (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 05:34:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 904831000F
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:33 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id C8BD319F480
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:32 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226115>

In t4023 and t4114, we have to remove the entries using 'git rm' because
otherwise the entries that must turn from symbolic links to regular files
would stay symbolic links in the index. For the same reason, we have to
use 'git mv' instead of plain 'mv' in t3509.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3509-cherry-pick-merge-df.sh   | 12 +++++-------
 t/t4023-diff-rename-typechange.sh | 28 ++++++++++++++--------------
 t/t4114-apply-typechange.sh       | 29 ++++++++++++++---------------
 3 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index df921d1..a5b6a5f 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -10,17 +10,15 @@ test_expect_success 'Initialize repository' '
 	git commit -m a
 '
 
-test_expect_success SYMLINKS 'Setup rename across paths each below D/F conflicts' '
+test_expect_success 'Setup rename across paths each below D/F conflicts' '
 	mkdir b &&
-	ln -s ../a b/a &&
-	git add b &&
+	test_ln_s_add ../a b/a &&
 	git commit -m b &&
 
 	git checkout -b branch &&
 	rm b/a &&
-	mv a b/a &&
-	ln -s b/a a &&
-	git add . &&
+	git mv a b/a &&
+	test_ln_s_add b/a a &&
 	git commit -m swap &&
 
 	>f1 &&
@@ -28,7 +26,7 @@ test_expect_success SYMLINKS 'Setup rename across paths each below D/F conflicts
 	git commit -m f1
 '
 
-test_expect_success SYMLINKS 'Cherry-pick succeeds with rename across D/F conflicts' '
+test_expect_success 'Cherry-pick succeeds with rename across D/F conflicts' '
 	git reset --hard &&
 	git checkout master^0 &&
 	git cherry-pick branch
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index 5d20acf..55d549f 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -4,44 +4,44 @@ test_description='typechange rename detection'
 
 . ./test-lib.sh
 
-test_expect_success SYMLINKS setup '
+test_expect_success setup '
 
 	rm -f foo bar &&
 	cat "$TEST_DIRECTORY"/../COPYING >foo &&
-	ln -s linklink bar &&
-	git add foo bar &&
+	test_ln_s_add linklink bar &&
+	git add foo &&
 	git commit -a -m Initial &&
 	git tag one &&
 
-	rm -f foo bar &&
+	git rm -f foo bar &&
 	cat "$TEST_DIRECTORY"/../COPYING >bar &&
-	ln -s linklink foo &&
-	git add foo bar &&
+	test_ln_s_add linklink foo &&
+	git add bar &&
 	git commit -a -m Second &&
 	git tag two &&
 
-	rm -f foo bar &&
+	git rm -f foo bar &&
 	cat "$TEST_DIRECTORY"/../COPYING >foo &&
 	git add foo &&
 	git commit -a -m Third &&
 	git tag three &&
 
 	mv foo bar &&
-	ln -s linklink foo &&
-	git add foo bar &&
+	test_ln_s_add linklink foo &&
+	git add bar &&
 	git commit -a -m Fourth &&
 	git tag four &&
 
 	# This is purely for sanity check
 
-	rm -f foo bar &&
+	git rm -f foo bar &&
 	cat "$TEST_DIRECTORY"/../COPYING >foo &&
 	cat "$TEST_DIRECTORY"/../Makefile >bar &&
 	git add foo bar &&
 	git commit -a -m Fifth &&
 	git tag five &&
 
-	rm -f foo bar &&
+	git rm -f foo bar &&
 	cat "$TEST_DIRECTORY"/../Makefile >foo &&
 	cat "$TEST_DIRECTORY"/../COPYING >bar &&
 	git add foo bar &&
@@ -50,7 +50,7 @@ test_expect_success SYMLINKS setup '
 
 '
 
-test_expect_success SYMLINKS 'cross renames to be detected for regular files' '
+test_expect_success 'cross renames to be detected for regular files' '
 
 	git diff-tree five six -r --name-status -B -M | sort >actual &&
 	{
@@ -61,7 +61,7 @@ test_expect_success SYMLINKS 'cross renames to be detected for regular files' '
 
 '
 
-test_expect_success SYMLINKS 'cross renames to be detected for typechange' '
+test_expect_success 'cross renames to be detected for typechange' '
 
 	git diff-tree one two -r --name-status -B -M | sort >actual &&
 	{
@@ -72,7 +72,7 @@ test_expect_success SYMLINKS 'cross renames to be detected for typechange' '
 
 '
 
-test_expect_success SYMLINKS 'moves and renames' '
+test_expect_success 'moves and renames' '
 
 	git diff-tree three four -r --name-status -B -M | sort >actual &&
 	{
diff --git a/t/t4114-apply-typechange.sh b/t/t4114-apply-typechange.sh
index f12826f..ebadbc3 100755
--- a/t/t4114-apply-typechange.sh
+++ b/t/t4114-apply-typechange.sh
@@ -9,20 +9,19 @@ test_description='git apply should not get confused with type changes.
 
 . ./test-lib.sh
 
-test_expect_success SYMLINKS 'setup repository and commits' '
+test_expect_success 'setup repository and commits' '
 	echo "hello world" > foo &&
 	echo "hi planet" > bar &&
 	git update-index --add foo bar &&
 	git commit -m initial &&
 	git branch initial &&
 	rm -f foo &&
-	ln -s bar foo &&
-	git update-index foo &&
+	test_ln_s_add bar foo &&
 	git commit -m "foo symlinked to bar" &&
 	git branch foo-symlinked-to-bar &&
-	rm -f foo &&
+	git rm -f foo &&
 	echo "how far is the sun?" > foo &&
-	git update-index foo &&
+	git update-index --add foo &&
 	git commit -m "foo back to file" &&
 	git branch foo-back-to-file &&
 	printf "\0" > foo &&
@@ -42,7 +41,7 @@ test_expect_success SYMLINKS 'setup repository and commits' '
 	git branch foo-baz-renamed-from-foo
 	'
 
-test_expect_success SYMLINKS 'file renamed from foo to foo/baz' '
+test_expect_success 'file renamed from foo to foo/baz' '
 	git checkout -f initial &&
 	git diff-tree -M -p HEAD foo-baz-renamed-from-foo > patch &&
 	git apply --index < patch
@@ -50,7 +49,7 @@ test_expect_success SYMLINKS 'file renamed from foo to foo/baz' '
 test_debug 'cat patch'
 
 
-test_expect_success SYMLINKS 'file renamed from foo/baz to foo' '
+test_expect_success 'file renamed from foo/baz to foo' '
 	git checkout -f foo-baz-renamed-from-foo &&
 	git diff-tree -M -p HEAD initial > patch &&
 	git apply --index < patch
@@ -58,7 +57,7 @@ test_expect_success SYMLINKS 'file renamed from foo/baz to foo' '
 test_debug 'cat patch'
 
 
-test_expect_success SYMLINKS 'directory becomes file' '
+test_expect_success 'directory becomes file' '
 	git checkout -f foo-becomes-a-directory &&
 	git diff-tree -p HEAD initial > patch &&
 	git apply --index < patch
@@ -66,7 +65,7 @@ test_expect_success SYMLINKS 'directory becomes file' '
 test_debug 'cat patch'
 
 
-test_expect_success SYMLINKS 'file becomes directory' '
+test_expect_success 'file becomes directory' '
 	git checkout -f initial &&
 	git diff-tree -p HEAD foo-becomes-a-directory > patch &&
 	git apply --index < patch
@@ -74,7 +73,7 @@ test_expect_success SYMLINKS 'file becomes directory' '
 test_debug 'cat patch'
 
 
-test_expect_success SYMLINKS 'file becomes symlink' '
+test_expect_success 'file becomes symlink' '
 	git checkout -f initial &&
 	git diff-tree -p HEAD foo-symlinked-to-bar > patch &&
 	git apply --index < patch
@@ -82,21 +81,21 @@ test_expect_success SYMLINKS 'file becomes symlink' '
 test_debug 'cat patch'
 
 
-test_expect_success SYMLINKS 'symlink becomes file' '
+test_expect_success 'symlink becomes file' '
 	git checkout -f foo-symlinked-to-bar &&
 	git diff-tree -p HEAD foo-back-to-file > patch &&
 	git apply --index < patch
 	'
 test_debug 'cat patch'
 
-test_expect_success SYMLINKS 'binary file becomes symlink' '
+test_expect_success 'binary file becomes symlink' '
 	git checkout -f foo-becomes-binary &&
 	git diff-tree -p --binary HEAD foo-symlinked-to-bar > patch &&
 	git apply --index < patch
 	'
 test_debug 'cat patch'
 
-test_expect_success SYMLINKS 'symlink becomes binary file' '
+test_expect_success 'symlink becomes binary file' '
 	git checkout -f foo-symlinked-to-bar &&
 	git diff-tree -p --binary HEAD foo-becomes-binary > patch &&
 	git apply --index < patch
@@ -104,7 +103,7 @@ test_expect_success SYMLINKS 'symlink becomes binary file' '
 test_debug 'cat patch'
 
 
-test_expect_success SYMLINKS 'symlink becomes directory' '
+test_expect_success 'symlink becomes directory' '
 	git checkout -f foo-symlinked-to-bar &&
 	git diff-tree -p HEAD foo-becomes-a-directory > patch &&
 	git apply --index < patch
@@ -112,7 +111,7 @@ test_expect_success SYMLINKS 'symlink becomes directory' '
 test_debug 'cat patch'
 
 
-test_expect_success SYMLINKS 'directory becomes symlink' '
+test_expect_success 'directory becomes symlink' '
 	git checkout -f foo-becomes-a-directory &&
 	git diff-tree -p HEAD foo-symlinked-to-bar > patch &&
 	git apply --index < patch
-- 
1.8.3.rc1.32.g8b61cbb
