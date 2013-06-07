From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 10/10] t4011: remove SYMLINKS prerequisite
Date: Fri,  7 Jun 2013 22:53:34 +0200
Message-ID: <984a1c896f016201a614eeaeea700d35a82f2e32.1370636706.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 22:54:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3fj-00075o-T0
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201Ab3FGUxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:53:45 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:33346 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756247Ab3FGUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:53:37 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1B9B213004E;
	Fri,  7 Jun 2013 22:53:36 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7DE3B19F5E8;
	Fri,  7 Jun 2013 22:53:35 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
In-Reply-To: <cover.1370636706.git.j6t@kdbg.org>
References: <cover.1370636706.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226710>

The part of the test that is about symbolic links in the index does not
require that the corresponding file system entry is actually a symbolic
link. Use test_ln_s_add to insert a symbolic link in the index. When
the file system does not support symbolic links, we actually have a
regular file in the worktree, which  we can update as if it were a
symbolic link. diff-index picks up the symbolic link property from the
index.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4011-diff-symlink.sh | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index f0d5041..13e7f62 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -9,7 +9,7 @@ test_description='Test diff of symlinks.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
-test_expect_success SYMLINKS 'diff new symlink and file' '
+test_expect_success 'diff new symlink and file' '
 	cat >expected <<-\EOF &&
 	diff --git a/frotz b/frotz
 	new file mode 120000
@@ -27,22 +27,25 @@ test_expect_success SYMLINKS 'diff new symlink and file' '
 	@@ -0,0 +1 @@
 	+xyzzy
 	EOF
-	ln -s xyzzy frotz &&
-	echo xyzzy >nitfol &&
+
+	# the empty tree
 	git update-index &&
 	tree=$(git write-tree) &&
-	git update-index --add frotz nitfol &&
+
+	test_ln_s_add xyzzy frotz &&
+	echo xyzzy >nitfol &&
+	git update-index --add nitfol &&
 	GIT_DIFF_OPTS=--unified=0 git diff-index -M -p $tree >current &&
 	compare_diff_patch expected current
 '
 
-test_expect_success SYMLINKS 'diff unchanged symlink and file'  '
+test_expect_success 'diff unchanged symlink and file'  '
 	tree=$(git write-tree) &&
 	git update-index frotz nitfol &&
 	test -z "$(git diff-index --name-only $tree)"
 '
 
-test_expect_success SYMLINKS 'diff removed symlink and file' '
+test_expect_success 'diff removed symlink and file' '
 	cat >expected <<-\EOF &&
 	diff --git a/frotz b/frotz
 	deleted file mode 120000
@@ -66,12 +69,18 @@ test_expect_success SYMLINKS 'diff removed symlink and file' '
 	compare_diff_patch expected current
 '
 
-test_expect_success SYMLINKS 'diff identical, but newly created symlink and file' '
+test_expect_success 'diff identical, but newly created symlink and file' '
 	>expected &&
 	rm -f frotz nitfol &&
 	echo xyzzy >nitfol &&
 	test-chmtime +10 nitfol &&
-	ln -s xyzzy frotz &&
+	if test_have_prereq SYMLINKS
+	then
+		ln -s xyzzy frotz
+	else
+		printf xyzzy >frotz
+		# the symlink property propagates from the index
+	fi &&
 	git diff-index -M -p $tree >current &&
 	compare_diff_patch expected current &&
 
@@ -80,7 +89,7 @@ test_expect_success SYMLINKS 'diff identical, but newly created symlink and file
 	compare_diff_patch expected current
 '
 
-test_expect_success SYMLINKS 'diff different symlink and file' '
+test_expect_success 'diff different symlink and file' '
 	cat >expected <<-\EOF &&
 	diff --git a/frotz b/frotz
 	index 7c465af..df1db54 120000
@@ -100,7 +109,13 @@ test_expect_success SYMLINKS 'diff different symlink and file' '
 	+yxyyz
 	EOF
 	rm -f frotz &&
-	ln -s yxyyz frotz &&
+	if test_have_prereq SYMLINKS
+	then
+		ln -s yxyyz frotz
+	else
+		printf yxyyz >frotz
+		# the symlink property propagates from the index
+	fi &&
 	echo yxyyz >nitfol &&
 	git diff-index -M -p $tree >current &&
 	compare_diff_patch expected current
-- 
1.8.3.rc1.32.g8b61cbb
