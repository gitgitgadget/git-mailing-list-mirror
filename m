From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 05/10] t0000: use test_ln_s_add to remove SYMLINKS prerequisite
Date: Fri,  7 Jun 2013 22:53:29 +0200
Message-ID: <798651d401ecb522aee41a4dddd80ff5701508f6.1370636706.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 22:53:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3fT-0006qZ-Ak
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757238Ab3FGUxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:53:46 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:10107 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756177Ab3FGUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:53:37 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9A5EB10013;
	Fri,  7 Jun 2013 22:53:35 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id D95D019F5EC;
	Fri,  7 Jun 2013 22:53:34 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
In-Reply-To: <cover.1370636706.git.j6t@kdbg.org>
References: <cover.1370636706.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226709>

t0000-basic hard-codes many object IDs. To cater to file systems that do
not support symbolic links, different IDs are used depending on the
SYMLINKS prerequisite. But we can observe the symbolic links are only
needed to generate index entries. Use test_ln_s_add to generate the
index entries and get rid of explicit SYMLINKS checks.

This undoes the special casing introduced in this test by 704a3143
(Use prerequisite tags to skip tests that depend on symbolic links,
2009-03-04).

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0000-basic.sh | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index cefe33d..0f13180 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -367,22 +367,6 @@ test_expect_success 'validate object ID of a known tree' '
 
 # Various types of objects
 
-# Some filesystems do not support symblic links; on such systems
-# some expected values are different
-if test_have_prereq SYMLINKS
-then
-	expectfilter=cat
-	expectedtree=087704a96baf1c2d1c869a8b084481e121c88b5b
-	expectedptree1=21ae8269cacbe57ae09138dcc3a2887f904d02b3
-	expectedptree2=3c5e5399f3a333eddecce7a9b9465b63f65f51e2
-else
-	expectfilter='grep -v sym'
-	expectedtree=8e18edf7d7edcf4371a3ac6ae5f07c2641db7c46
-	expectedptree1=cfb8591b2f65de8b8cc1020cd7d9e67e7793b325
-	expectedptree2=ce580448f0148b985a513b693fdf7d802cacb44f
-fi
-
-
 test_expect_success 'adding various types of objects with git update-index --add' '
 	mkdir path2 path3 path3/subp3 &&
 	paths="path0 path2/file2 path3/file3 path3/subp3/file3" &&
@@ -390,10 +374,7 @@ test_expect_success 'adding various types of objects with git update-index --add
 		for p in $paths
 		do
 			echo "hello $p" >$p || exit 1
-			if test_have_prereq SYMLINKS
-			then
-				ln -s "hello $p" ${p}sym || exit 1
-			fi
+			test_ln_s_add "hello $p" ${p}sym || exit 1
 		done
 	) &&
 	find path* ! -type d -print | xargs git update-index --add
@@ -405,7 +386,7 @@ test_expect_success 'showing stage with git ls-files --stage' '
 '
 
 test_expect_success 'validate git ls-files output for a known tree' '
-	$expectfilter >expected <<-\EOF &&
+	cat >expected <<-\EOF &&
 	100644 f87290f8eb2cbbea7857214459a0739927eab154 0	path0
 	120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0	path0sym
 	100644 3feff949ed00a62d9f7af97c15cd8a30595e7ac7 0	path2/file2
@@ -423,14 +404,14 @@ test_expect_success 'writing tree out with git write-tree' '
 '
 
 test_expect_success 'validate object ID for a known tree' '
-	test "$tree" = "$expectedtree"
+	test "$tree" = 087704a96baf1c2d1c869a8b084481e121c88b5b
 '
 
 test_expect_success 'showing tree with git ls-tree' '
     git ls-tree $tree >current
 '
 
-test_expect_success SYMLINKS 'git ls-tree output for a known tree' '
+test_expect_success 'git ls-tree output for a known tree' '
 	cat >expected <<-\EOF &&
 	100644 blob f87290f8eb2cbbea7857214459a0739927eab154	path0
 	120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
@@ -447,7 +428,7 @@ test_expect_success 'showing tree with git ls-tree -r' '
 '
 
 test_expect_success 'git ls-tree -r output for a known tree' '
-	$expectfilter >expected <<-\EOF &&
+	cat >expected <<-\EOF &&
 	100644 blob f87290f8eb2cbbea7857214459a0739927eab154	path0
 	120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
 	100644 blob 3feff949ed00a62d9f7af97c15cd8a30595e7ac7	path2/file2
@@ -465,7 +446,7 @@ test_expect_success 'showing tree with git ls-tree -r -t' '
 	git ls-tree -r -t $tree >current
 '
 
-test_expect_success SYMLINKS 'git ls-tree -r output for a known tree' '
+test_expect_success 'git ls-tree -r output for a known tree' '
 	cat >expected <<-\EOF &&
 	100644 blob f87290f8eb2cbbea7857214459a0739927eab154	path0
 	120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
@@ -487,7 +468,7 @@ test_expect_success 'writing partial tree out with git write-tree --prefix' '
 '
 
 test_expect_success 'validate object ID for a known tree' '
-	test "$ptree" = "$expectedptree1"
+	test "$ptree" = 21ae8269cacbe57ae09138dcc3a2887f904d02b3
 '
 
 test_expect_success 'writing partial tree out with git write-tree --prefix' '
@@ -495,7 +476,7 @@ test_expect_success 'writing partial tree out with git write-tree --prefix' '
 '
 
 test_expect_success 'validate object ID for a known tree' '
-	test "$ptree" = "$expectedptree2"
+	test "$ptree" = 3c5e5399f3a333eddecce7a9b9465b63f65f51e2
 '
 
 test_expect_success 'put invalid objects into the index' '
@@ -529,7 +510,7 @@ test_expect_success 'git read-tree followed by write-tree should be idempotent'
 '
 
 test_expect_success 'validate git diff-files output for a know cache/work tree state' '
-	$expectfilter >expected <<\EOF &&
+	cat >expected <<\EOF &&
 :100644 100644 f87290f8eb2cbbea7857214459a0739927eab154 0000000000000000000000000000000000000000 M	path0
 :120000 120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0000000000000000000000000000000000000000 M	path0sym
 :100644 100644 3feff949ed00a62d9f7af97c15cd8a30595e7ac7 0000000000000000000000000000000000000000 M	path2/file2
@@ -553,7 +534,7 @@ test_expect_success 'no diff after checkout and git update-index --refresh' '
 '
 
 ################################################################
-P=$expectedtree
+P=087704a96baf1c2d1c869a8b084481e121c88b5b
 
 test_expect_success 'git commit-tree records the correct tree in a commit' '
 	commit0=$(echo NO | git commit-tree $P) &&
-- 
1.8.3.rc1.32.g8b61cbb
