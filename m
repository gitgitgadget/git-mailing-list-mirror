From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 07/10] t3100: use test_ln_s_add to remove SYMLINKS prerequisite
Date: Fri,  7 Jun 2013 22:53:31 +0200
Message-ID: <ef63a9a666043849a4db98486b6886be2878c52b.1370636706.git.j6t@kdbg.org>
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
	id 1Ul3fS-0006qZ-R5
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213Ab3FGUxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:53:46 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:40476 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756185Ab3FGUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:53:37 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E6F2BA7EB3;
	Fri,  7 Jun 2013 22:53:35 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3716A19F5EF;
	Fri,  7 Jun 2013 22:53:35 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
In-Reply-To: <cover.1370636706.git.j6t@kdbg.org>
References: <cover.1370636706.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226708>

This undoes the special casing introduced in this test by 704a3143
(Use prerequisite tags to skip tests that depend on symbolic links,
2009-03-04).

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3100-ls-tree-restrict.sh | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index 81d90b6..eb73c06 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -22,20 +22,8 @@ test_expect_success \
     'setup' \
     'mkdir path2 path2/baz &&
      echo Hi >path0 &&
-     if test_have_prereq SYMLINKS
-     then
-	ln -s path0 path1 &&
-	ln -s ../path1 path2/bazbo
-	make_expected () {
-		cat >expected
-	}
-     else
-	printf path0 > path1 &&
-	printf ../path1 > path2/bazbo
-	make_expected () {
-		sed -e "s/120000 /100644 /" >expected
-	}
-     fi &&
+     test_ln_s_add path0 path1 &&
+     test_ln_s_add ../path1 path2/bazbo &&
      echo Lo >path2/foo &&
      echo Mi >path2/baz/b &&
      find path? \( -type f -o -type l \) -print |
@@ -51,7 +39,7 @@ test_output () {
 test_expect_success \
     'ls-tree plain' \
     'git ls-tree $tree >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 100644 blob X	path0
 120000 blob X	path1
 040000 tree X	path2
@@ -61,7 +49,7 @@ EOF
 test_expect_success \
     'ls-tree recursive' \
     'git ls-tree -r $tree >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 100644 blob X	path0
 120000 blob X	path1
 100644 blob X	path2/baz/b
@@ -73,7 +61,7 @@ EOF
 test_expect_success \
     'ls-tree recursive with -t' \
     'git ls-tree -r -t $tree >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 100644 blob X	path0
 120000 blob X	path1
 040000 tree X	path2
@@ -87,7 +75,7 @@ EOF
 test_expect_success \
     'ls-tree recursive with -d' \
     'git ls-tree -r -d $tree >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 040000 tree X	path2
 040000 tree X	path2/baz
 EOF
@@ -96,7 +84,7 @@ EOF
 test_expect_success \
     'ls-tree filtered with path' \
     'git ls-tree $tree path >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 EOF
      test_output'
 
@@ -106,7 +94,7 @@ EOF
 test_expect_success \
     'ls-tree filtered with path1 path0' \
     'git ls-tree $tree path1 path0 >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 100644 blob X	path0
 120000 blob X	path1
 EOF
@@ -115,7 +103,7 @@ EOF
 test_expect_success \
     'ls-tree filtered with path0/' \
     'git ls-tree $tree path0/ >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 EOF
      test_output'
 
@@ -124,7 +112,7 @@ EOF
 test_expect_success \
     'ls-tree filtered with path2' \
     'git ls-tree $tree path2 >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 040000 tree X	path2
 EOF
      test_output'
@@ -133,7 +121,7 @@ EOF
 test_expect_success \
     'ls-tree filtered with path2/' \
     'git ls-tree $tree path2/ >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 040000 tree X	path2/baz
 120000 blob X	path2/bazbo
 100644 blob X	path2/foo
@@ -145,7 +133,7 @@ EOF
 test_expect_success \
     'ls-tree filtered with path2/baz' \
     'git ls-tree $tree path2/baz >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 040000 tree X	path2/baz
 EOF
      test_output'
@@ -153,14 +141,14 @@ EOF
 test_expect_success \
     'ls-tree filtered with path2/bak' \
     'git ls-tree $tree path2/bak >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 EOF
      test_output'
 
 test_expect_success \
     'ls-tree -t filtered with path2/bak' \
     'git ls-tree -t $tree path2/bak >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 040000 tree X	path2
 EOF
      test_output'
@@ -168,7 +156,7 @@ EOF
 test_expect_success \
     'ls-tree with one path a prefix of the other' \
     'git ls-tree $tree path2/baz path2/bazbo >current &&
-     make_expected <<\EOF &&
+     cat >expected <<\EOF &&
 040000 tree X	path2/baz
 120000 blob X	path2/bazbo
 EOF
-- 
1.8.3.rc1.32.g8b61cbb
