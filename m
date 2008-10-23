From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] improve index-pack tests
Date: Wed, 22 Oct 2008 20:59:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810222045490.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 03:01:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsoZj-0006i0-F0
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 03:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbYJWA7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 20:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757825AbYJWA7f
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 20:59:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34022 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757248AbYJWA7e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 20:59:34 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9600J1B2PWZH20@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Oct 2008 20:58:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98933>

Commit 9441b61dc5 introduced serious bugs in index-pack which are
described and fixed by commit ce3f6dc655.  However, despite the
boldness of those bugs, the test suite still passed.

This improves t5302-pack-index.sh so to ensure a much better code
path coverage.  With commit ce3f6dc655 reverted, 17 of the 26 tests
do fail now.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 344ab25..b0b0fda 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -11,13 +11,18 @@ test_expect_success \
     'rm -rf .git
      git init &&
      i=1 &&
-	 while test $i -le 100
+     while test $i -le 100
      do
-		 i=`printf '%03i' $i`
-         echo $i >file_$i &&
-         test-genrandom "$i" 8192 >>file_$i &&
-         git update-index --add file_$i &&
-		 i=`expr $i + 1` || return 1
+         iii=`printf '%03i' $i`
+         test-genrandom "bar" 200 > wide_delta_$iii &&
+         test-genrandom "baz $iii" 50 >> wide_delta_$iii &&
+         test-genrandom "foo"$i 100 > deep_delta_$iii &&
+         test-genrandom "foo"`expr $i + 1` 100 >> deep_delta_$iii &&
+         test-genrandom "foo"`expr $i + 2` 100 >> deep_delta_$iii &&
+         echo $iii >file_$iii &&
+         test-genrandom "$iii" 8192 >>file_$iii &&
+         git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
+         i=`expr $i + 1` || return 1
      done &&
      { echo 101 && test-genrandom 100 8192; } >file_101 &&
      git update-index --add file_101 &&
@@ -92,6 +97,31 @@ test_expect_success \
     '64-bit offsets: index-pack result should match pack-objects one' \
     'cmp "test-3-${pack3}.idx" "3.idx"'
 
+# returns the object number for given object in given pack index
+index_obj_nr()
+{
+    idx_file=$1
+    object_sha1=$2
+    nr=0
+    git show-index < $idx_file |
+    while read offs sha1 extra
+    do
+      nr=$(($nr + 1))
+      test "$sha1" = "$object_sha1" || continue
+      echo "$(($nr - 1))"
+      break
+    done
+}
+
+# returns the pack offset for given object as found in given pack index
+index_obj_offset()
+{
+    idx_file=$1
+    object_sha1=$2
+    git show-index < $idx_file | grep $object_sha1 |
+    ( read offs extra && echo "$offs" )
+}
+
 test_expect_success \
     '[index v1] 1) stream pack to repository' \
     'git index-pack --index-version=1 --stdin < "test-1-${pack1}.pack" &&
@@ -102,19 +132,22 @@ test_expect_success \
 
 test_expect_success \
     '[index v1] 2) create a stealth corruption in a delta base reference' \
-    '# this test assumes a delta smaller than 16 bytes at the end of the pack
-     git show-index <1.idx | sort -n | sed -ne \$p | (
-       read delta_offs delta_sha1 &&
-       git cat-file blob "$delta_sha1" > blob_1 &&
-       chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
-       dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($delta_offs + 1)) \
-	  if=".git/objects/pack/pack-${pack1}.idx" skip=$((256 * 4 + 4)) \
-	  bs=1 count=20 conv=notrunc &&
-       git cat-file blob "$delta_sha1" > blob_2 )'
+    '# This test assumes file_101 is a delta smaller than 16 bytes.
+     # It should be against file_100 but we substitute its base for file_099
+     sha1_101=`git hash-object file_101` &&
+     sha1_099=`git hash-object file_099` &&
+     offs_101=`index_obj_offset 1.idx $sha1_101` &&
+     nr_099=`index_obj_nr 1.idx $sha1_099` &&
+     chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
+     dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
+        if=".git/objects/pack/pack-${pack1}.idx" \
+        skip=$((4 + 256 * 4 + $nr_099 * 24)) \
+        bs=1 count=20 conv=notrunc &&
+     git cat-file blob $sha1_101 > file_101_foo1'
 
 test_expect_success \
     '[index v1] 3) corrupted delta happily returned wrong data' \
-    '! cmp blob_1 blob_2'
+    'test -f file_101_foo1 && ! cmp file_101 file_101_foo1'
 
 test_expect_success \
     '[index v1] 4) confirm that the pack is actually corrupted' \
@@ -140,19 +173,22 @@ test_expect_success \
 
 test_expect_success \
     '[index v2] 2) create a stealth corruption in a delta base reference' \
-    '# this test assumes a delta smaller than 16 bytes at the end of the pack
-     git show-index <1.idx | sort -n | sed -ne \$p | (
-       read delta_offs delta_sha1 delta_crc &&
-       git cat-file blob "$delta_sha1" > blob_3 &&
-       chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
-       dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($delta_offs + 1)) \
-	  if=".git/objects/pack/pack-${pack1}.idx" skip=$((8 + 256 * 4)) \
-	  bs=1 count=20 conv=notrunc &&
-       git cat-file blob "$delta_sha1" > blob_4 )'
+    '# This test assumes file_101 is a delta smaller than 16 bytes.
+     # It should be against file_100 but we substitute its base for file_099
+     sha1_101=`git hash-object file_101` &&
+     sha1_099=`git hash-object file_099` &&
+     offs_101=`index_obj_offset 1.idx $sha1_101` &&
+     nr_099=`index_obj_nr 1.idx $sha1_099` &&
+     chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
+     dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
+        if=".git/objects/pack/pack-${pack1}.idx" \
+        skip=$((8 + 256 * 4 + $nr_099 * 20)) \
+        bs=1 count=20 conv=notrunc &&
+     git cat-file blob $sha1_101 > file_101_foo2'
 
 test_expect_success \
     '[index v2] 3) corrupted delta happily returned wrong data' \
-    '! cmp blob_3 blob_4'
+    'test -f file_101_foo2 && ! cmp file_101 file_101_foo2'
 
 test_expect_success \
     '[index v2] 4) confirm that the pack is actually corrupted' \
@@ -167,9 +203,11 @@ test_expect_success \
     'rm -f .git/objects/pack/* &&
      git index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
      git verify-pack ".git/objects/pack/pack-${pack1}.pack" &&
+     obj=`git hash-object file_001` &&
+     nr=`index_obj_nr ".git/objects/pack/pack-${pack1}.idx" $obj` &&
      chmod +w ".git/objects/pack/pack-${pack1}.idx" &&
      dd if=/dev/zero of=".git/objects/pack/pack-${pack1}.idx" conv=notrunc \
-        bs=1 count=4 seek=$((8 + 256 * 4 + `wc -l <obj-list` * 20 + 0)) &&
+        bs=1 count=4 seek=$((8 + 256 * 4 + `wc -l <obj-list` * 20 + $nr * 4)) &&
      ( while read obj
        do git cat-file -p $obj >/dev/null || exit 1
        done <obj-list ) &&
