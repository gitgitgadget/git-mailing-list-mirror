From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 09/10] t5300, t5302, t5303: Do not use /dev/zero
Date: Wed, 18 Mar 2009 22:27:11 +0100
Message-ID: <d5e7f18c786db8d1739c42403f8b366746854d66.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:30:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3Kq-000574-T9
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbZCRV1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754291AbZCRV1g
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:27:36 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46795 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbZCRV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:27:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 86E1310026;
	Wed, 18 Mar 2009 22:27:18 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 27912426B4;
	Wed, 18 Mar 2009 22:27:18 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113679>

We do not have /dev/zero on Windows. This replaces it by data generated
with printf, perl, or echo. Most of the cases do not depend on that the
data is a stream of zero bytes, so we use something printable; nor is an
unlimited stream of data needed, so we produce only as many bytes as the
test cases need.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5300-pack-object.sh                |   17 ++++++++---------
 t/t5302-pack-index.sh                 |    2 +-
 t/t5303-pack-corruption-resilience.sh |   12 +++++++-----
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index ccfc64c..e2aa254 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -13,11 +13,10 @@ TRASH=`pwd`
 test_expect_success \
     'setup' \
     'rm -f .git/index*
-     for i in a b c
-     do
-	     dd if=/dev/zero bs=4k count=1 | perl -pe "y/\\000/$i/" >$i &&
-	     git update-index --add $i || return 1
-     done &&
+     perl -e "print \"a\" x 4096;" > a &&
+     perl -e "print \"b\" x 4096;" > b &&
+     perl -e "print \"c\" x 4096;" > c &&
+     git update-index --add a b c &&
      cat c >d && echo foo >>d && git update-index --add d &&
      tree=`git write-tree` &&
      commit=`git commit-tree $tree </dev/null` && {
@@ -221,7 +220,7 @@ test_expect_success \
 test_expect_success \
     'verify-pack catches a corrupted pack signature' \
     'cat test-1-${packname_1}.pack >test-3.pack &&
-     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=2 &&
+     echo | dd of=test-3.pack count=1 bs=1 conv=notrunc seek=2 &&
      if git verify-pack test-3.idx
      then false
      else :;
@@ -230,7 +229,7 @@ test_expect_success \
 test_expect_success \
     'verify-pack catches a corrupted pack version' \
     'cat test-1-${packname_1}.pack >test-3.pack &&
-     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=7 &&
+     echo | dd of=test-3.pack count=1 bs=1 conv=notrunc seek=7 &&
      if git verify-pack test-3.idx
      then false
      else :;
@@ -239,7 +238,7 @@ test_expect_success \
 test_expect_success \
     'verify-pack catches a corrupted type/size of the 1st packed object data' \
     'cat test-1-${packname_1}.pack >test-3.pack &&
-     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=12 &&
+     echo | dd of=test-3.pack count=1 bs=1 conv=notrunc seek=12 &&
      if git verify-pack test-3.idx
      then false
      else :;
@@ -250,7 +249,7 @@ test_expect_success \
     'l=`wc -c <test-3.idx` &&
      l=`expr $l - 20` &&
      cat test-1-${packname_1}.pack >test-3.pack &&
-     dd if=/dev/zero of=test-3.idx count=20 bs=1 conv=notrunc seek=$l &&
+     printf "%20s" "" | dd of=test-3.idx count=20 bs=1 conv=notrunc seek=$l &&
      if git verify-pack test-3.pack
      then false
      else :;
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index e6f70d4..77982cd 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -208,7 +208,7 @@ test_expect_success \
      obj=`git hash-object file_001` &&
      nr=`index_obj_nr ".git/objects/pack/pack-${pack1}.idx" $obj` &&
      chmod +w ".git/objects/pack/pack-${pack1}.idx" &&
-     dd if=/dev/zero of=".git/objects/pack/pack-${pack1}.idx" conv=notrunc \
+     printf xxxx | dd of=".git/objects/pack/pack-${pack1}.idx" conv=notrunc \
         bs=1 count=4 seek=$((8 + 256 * 4 + `wc -l <obj-list` * 20 + $nr * 4)) &&
      ( while read obj
        do git cat-file -p $obj >/dev/null || exit 1
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index d4e30fc..5132d41 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -55,6 +55,8 @@ do_corrupt_object() {
     test_must_fail git verify-pack ${pack}.pack
 }
 
+printf '\0' > zero
+
 test_expect_success \
     'initial setup validation' \
     'create_test_files &&
@@ -66,7 +68,7 @@ test_expect_success \
 
 test_expect_success \
     'create corruption in header of first object' \
-    'do_corrupt_object $blob_1 0 < /dev/zero &&
+    'do_corrupt_object $blob_1 0 < zero &&
      test_must_fail git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
@@ -125,7 +127,7 @@ test_expect_success \
     'create corruption in header of first delta' \
     'create_new_pack &&
      git prune-packed &&
-     do_corrupt_object $blob_2 0 < /dev/zero &&
+     do_corrupt_object $blob_2 0 < zero &&
      git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
@@ -180,7 +182,7 @@ test_expect_success \
     'corruption in delta base reference of first delta (OBJ_REF_DELTA)' \
     'create_new_pack &&
      git prune-packed &&
-     do_corrupt_object $blob_2 2 < /dev/zero &&
+     do_corrupt_object $blob_2 2 < zero &&
      git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
@@ -207,7 +209,7 @@ test_expect_success \
     'corruption #0 in delta base reference of first delta (OBJ_OFS_DELTA)' \
     'create_new_pack --delta-base-offset &&
      git prune-packed &&
-     do_corrupt_object $blob_2 2 < /dev/zero &&
+     do_corrupt_object $blob_2 2 < zero &&
      git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
@@ -259,7 +261,7 @@ test_expect_success \
 
 test_expect_success \
     '... and a redundant pack allows for full recovery too' \
-    'do_corrupt_object $blob_2 2 < /dev/zero &&
+    'do_corrupt_object $blob_2 2 < zero &&
      git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null &&
-- 
1.6.2.1.224.g2225f
