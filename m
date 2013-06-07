From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 06/10] t3030: use test_ln_s_add to remove SYMLINKS prerequisite
Date: Fri,  7 Jun 2013 22:53:30 +0200
Message-ID: <a367d65ac4c2209bab241d2bb05bbc7d257644e1.1370636706.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 22:53:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3fS-0006qZ-Ay
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756998Ab3FGUxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:53:38 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:40472 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752999Ab3FGUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:53:37 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B13AE13004A;
	Fri,  7 Jun 2013 22:53:35 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0164819F5EE;
	Fri,  7 Jun 2013 22:53:35 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
In-Reply-To: <cover.1370636706.git.j6t@kdbg.org>
References: <cover.1370636706.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226707>

The test cases include many corner-cases of merge-recursive's behavior,
some of them involve type changes and symbolic links. All cases, including
those that are protected by SYMLINKS check only whether the result of
merge-recursive is correctly stored in the database and the index; the
file system is not investigated. Use test_ln_s_add to enter a symbolic
link in the index in the test setup and run the tests without the
SYMLINKS prerequisite.

Notice that one test that has the SYMLINKS protection removed is an
expect_failure. There is a possibility that the test fails differently
depending on whether SYMLINKS is present or not; but this is not the case
presently.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3030-merge-recursive.sh | 62 +++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index a5e3da7..2f96100 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -25,10 +25,7 @@ test_expect_success 'setup 1' '
 	git branch submod &&
 	git branch copy &&
 	git branch rename &&
-	if test_have_prereq SYMLINKS
-	then
-		git branch rename-ln
-	fi &&
+	git branch rename-ln &&
 
 	echo hello >>a &&
 	cp a d/e &&
@@ -260,16 +257,12 @@ test_expect_success 'setup 8' '
 	git add e &&
 	test_tick &&
 	git commit -m "rename a->e" &&
-	if test_have_prereq SYMLINKS
-	then
-		git checkout rename-ln &&
-		git mv a e &&
-		ln -s e a &&
-		git add a e &&
-		test_tick &&
-		git commit -m "rename a->e, symlink a->e" &&
-		oln=`printf e | git hash-object --stdin`
-	fi
+	git checkout rename-ln &&
+	git mv a e &&
+	test_ln_s_add e a &&
+	test_tick &&
+	git commit -m "rename a->e, symlink a->e" &&
+	oln=`printf e | git hash-object --stdin`
 '
 
 test_expect_success 'setup 9' '
@@ -569,28 +562,25 @@ test_expect_success 'merge-recursive copy vs. rename' '
 	test_cmp expected actual
 '
 
-if test_have_prereq SYMLINKS
-then
-	test_expect_failure 'merge-recursive rename vs. rename/symlink' '
-
-		git checkout -f rename &&
-		git merge rename-ln &&
-		( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
-		(
-			echo "120000 blob $oln	a"
-			echo "100644 blob $o0	b"
-			echo "100644 blob $o0	c"
-			echo "100644 blob $o0	d/e"
-			echo "100644 blob $o0	e"
-			echo "120000 $oln 0	a"
-			echo "100644 $o0 0	b"
-			echo "100644 $o0 0	c"
-			echo "100644 $o0 0	d/e"
-			echo "100644 $o0 0	e"
-		) >expected &&
-		test_cmp expected actual
-	'
-fi
+test_expect_failure 'merge-recursive rename vs. rename/symlink' '
+
+	git checkout -f rename &&
+	git merge rename-ln &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "120000 blob $oln	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
+		echo "100644 blob $o0	d/e"
+		echo "100644 blob $o0	e"
+		echo "120000 $oln 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
+		echo "100644 $o0 0	d/e"
+		echo "100644 $o0 0	e"
+	) >expected &&
+	test_cmp expected actual
+'
 
 
 test_done
-- 
1.8.3.rc1.32.g8b61cbb
