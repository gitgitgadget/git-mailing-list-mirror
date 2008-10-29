From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 8/9] extend test coverage for latest pack corruption resilience
 improvements
Date: Wed, 29 Oct 2008 19:02:51 -0400
Message-ID: <1225321372-6570-9-git-send-email-nico@cam.org>
References: <1225321372-6570-1-git-send-email-nico@cam.org>
 <1225321372-6570-2-git-send-email-nico@cam.org>
 <1225321372-6570-3-git-send-email-nico@cam.org>
 <1225321372-6570-4-git-send-email-nico@cam.org>
 <1225321372-6570-5-git-send-email-nico@cam.org>
 <1225321372-6570-6-git-send-email-nico@cam.org>
 <1225321372-6570-7-git-send-email-nico@cam.org>
 <1225321372-6570-8-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:06:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvK6y-0004tU-Df
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205AbYJ2XD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758218AbYJ2XD6
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:03:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39112 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898AbYJ2XDx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:03:53 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9I00DV4W0SZRE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Oct 2008 19:02:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.3.757.g01be.dirty
In-reply-to: <1225321372-6570-8-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99430>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 t/t5303-pack-corruption-resilience.sh |   96 ++++++++++++++++++++++++++++++---
 1 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 31b20b2..ac181ea 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -41,11 +41,17 @@ create_new_pack() {
     git verify-pack -v ${pack}.pack
 }
 
+do_repack() {
+    pack=`printf "$blob_1\n$blob_2\n$blob_3\n" |
+          git pack-objects $@ .git/objects/pack/pack` &&
+    pack=".git/objects/pack/pack-${pack}"
+}
+
 do_corrupt_object() {
     ofs=`git show-index < ${pack}.idx | grep $1 | cut -f1 -d" "` &&
     ofs=$(($ofs + $2)) &&
     chmod +w ${pack}.pack &&
-    dd if=/dev/zero of=${pack}.pack count=1 bs=1 conv=notrunc seek=$ofs &&
+    dd of=${pack}.pack count=1 bs=1 conv=notrunc seek=$ofs &&
     test_must_fail git verify-pack ${pack}.pack
 }
 
@@ -60,7 +66,7 @@ test_expect_success \
 
 test_expect_success \
     'create corruption in header of first object' \
-    'do_corrupt_object $blob_1 0 &&
+    'do_corrupt_object $blob_1 0 < /dev/zero &&
      test_must_fail git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
@@ -119,7 +125,7 @@ test_expect_success \
     'create corruption in header of first delta' \
     'create_new_pack &&
      git prune-packed &&
-     do_corrupt_object $blob_2 0 &&
+     do_corrupt_object $blob_2 0 < /dev/zero &&
      git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
@@ -134,6 +140,15 @@ test_expect_success \
      git cat-file blob $blob_3 > /dev/null'
 
 test_expect_success \
+    '... and then a repack "clears" the corruption' \
+    'do_repack &&
+     git prune-packed &&
+     git verify-pack ${pack}.pack &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
     'create corruption in data of first delta' \
     'create_new_pack &&
      git prune-packed &&
@@ -153,10 +168,19 @@ test_expect_success \
      git cat-file blob $blob_3 > /dev/null'
 
 test_expect_success \
+    '... and then a repack "clears" the corruption' \
+    'do_repack &&
+     git prune-packed &&
+     git verify-pack ${pack}.pack &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
     'corruption in delta base reference of first delta (OBJ_REF_DELTA)' \
     'create_new_pack &&
      git prune-packed &&
-     do_corrupt_object $blob_2 2 &&
+     do_corrupt_object $blob_2 2 < /dev/zero &&
      git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
@@ -171,17 +195,75 @@ test_expect_success \
      git cat-file blob $blob_3 > /dev/null'
 
 test_expect_success \
-    'corruption in delta base reference of first delta (OBJ_OFS_DELTA)' \
+    '... and then a repack "clears" the corruption' \
+    'do_repack &&
+     git prune-packed &&
+     git verify-pack ${pack}.pack &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    'corruption #0 in delta base reference of first delta (OBJ_OFS_DELTA)' \
     'create_new_pack --delta-base-offset &&
      git prune-packed &&
-     do_corrupt_object $blob_2 2 &&
+     do_corrupt_object $blob_2 2 < /dev/zero &&
      git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
 
 test_expect_success \
-    '... and a redundant pack allows for full recovery too' \
+    '... but having a loose copy allows for full recovery' \
     'mv ${pack}.idx tmp &&
+     git hash-object -t blob -w file_2 &&
+     mv tmp ${pack}.idx &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    '... and then a repack "clears" the corruption' \
+    'do_repack --delta-base-offset &&
+     git prune-packed &&
+     git verify-pack ${pack}.pack &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    'corruption #1 in delta base reference of first delta (OBJ_OFS_DELTA)' \
+    'create_new_pack --delta-base-offset &&
+     git prune-packed &&
+     printf "\x01" | do_corrupt_object $blob_2 2 &&
+     git cat-file blob $blob_1 > /dev/null &&
+     test_must_fail git cat-file blob $blob_2 > /dev/null &&
+     test_must_fail git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    '... but having a loose copy allows for full recovery' \
+    'mv ${pack}.idx tmp &&
+     git hash-object -t blob -w file_2 &&
+     mv tmp ${pack}.idx &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    '... and then a repack "clears" the corruption' \
+    'do_repack --delta-base-offset &&
+     git prune-packed &&
+     git verify-pack ${pack}.pack &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    '... and a redundant pack allows for full recovery too' \
+    'do_corrupt_object $blob_2 2 < /dev/zero &&
+     git cat-file blob $blob_1 > /dev/null &&
+     test_must_fail git cat-file blob $blob_2 > /dev/null &&
+     test_must_fail git cat-file blob $blob_3 > /dev/null &&
+     mv ${pack}.idx tmp &&
      git hash-object -t blob -w file_1 &&
      git hash-object -t blob -w file_2 &&
      printf "$blob_1\n$blob_2\n" | git pack-objects .git/objects/pack/pack &&
-- 
1.6.0.3.757.g01be.dirty
