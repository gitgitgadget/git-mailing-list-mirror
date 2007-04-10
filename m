From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 13/10] tests for various pack index features
Date: Tue, 10 Apr 2007 16:26:10 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704101607390.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 05:58:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbMuu-0001U4-9X
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 22:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbXDJU0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 16:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbXDJU0N
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 16:26:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38087 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030572AbXDJU0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 16:26:12 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGA00IHMU3M88D0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Apr 2007 16:26:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44177>

This is a fairly complete list of tests for various aspects of pack 
index versions 1 and  2.

Tests on index v2 include 32-bit and 64-bit offsets, as well as a nice 
demonstration of the flawed repacking integrity checks that index 
version 2 intend to solve over index version 1 with the per object CRC.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

OK this should really be the last patch for this topic.

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
new file mode 100755
index 0000000..3371964
--- /dev/null
+++ b/t/t5302-pack-index.sh
@@ -0,0 +1,147 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Nicolas Pitre
+#
+
+test_description='pack index with 64-bit offsets and object CRC'
+. ./test-lib.sh
+
+test_expect_success \
+    'setup' \
+    'rm -rf .git
+     git-init &&
+     for i in `seq -w 100`
+     do
+         echo $i >file_$i &&
+         dd if=/dev/urandom bs=8k count=1 >>file_$i &&
+         git-update-index --add file_$i || return 1
+     done &&
+     echo 101 >file_101 && tail -c 8k file_100 >>file_101 &&
+     git-update-index --add file_101 &&
+     tree=`git-write-tree` &&
+     commit=`git-commit-tree $tree </dev/null` && {
+	 echo $tree &&
+	 echo $commit &&
+	 git-ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+     } >obj-list &&
+     git-update-ref HEAD $commit'
+
+test_expect_success \
+    'pack-objects with index version 1' \
+    'pack1=$(git-pack-objects --index-version=1 test-1 <obj-list) &&
+     git-verify-pack -v "test-1-${pack1}.pack"'
+
+test_expect_success \
+    'pack-objects with index version 2' \
+    'pack2=$(git-pack-objects --index-version=2 test-2 <obj-list) &&
+     git-verify-pack -v "test-2-${pack2}.pack"'
+
+test_expect_success \
+    'both packs should be identical' \
+    'cmp "test-1-${pack1}.pack" "test-2-${pack2}.pack"'
+
+test_expect_failure \
+    'index v1 and index v2 should be different' \
+    'cmp "test-1-${pack1}.idx" "test-2-${pack2}.idx"'
+
+test_expect_success \
+    'index-pack with index version 1' \
+    'git-index-pack --index-version=1 -o 1.idx "test-1-${pack1}.pack"'
+
+test_expect_success \
+    'index-pack with index version 2' \
+    'git-index-pack --index-version=2 -o 2.idx "test-1-${pack1}.pack"'
+
+test_expect_success \
+    'index-pack results should match pack-objects ones' \
+    'cmp "test-1-${pack1}.idx" "1.idx" &&
+     cmp "test-2-${pack2}.idx" "2.idx"'
+
+test_expect_success \
+    'index v2: force some 64-bit offsets with pack-objects' \
+    'pack3=$(git-pack-objects --index-version=2,0x40000 test-3 <obj-list) &&
+     git-verify-pack -v "test-3-${pack3}.pack"'
+     
+test_expect_failure \
+    '64-bit offsets: should be different from previous index v2 results' \
+    'cmp "test-2-${pack2}.idx" "test-3-${pack3}.idx"'
+
+test_expect_success \
+    'index v2: force some 64-bit offsets with index-pack' \
+    'git-index-pack --index-version=2,0x40000 -o 3.idx "test-1-${pack1}.pack"'
+
+test_expect_success \
+    '64-bit offsets: index-pack result should match pack-objects one' \
+    'cmp "test-3-${pack3}.idx" "3.idx"'
+
+test_expect_success \
+    '[index v1] 1) stream pack to repository' \
+    'git-index-pack --index-version=1 --stdin < "test-1-${pack1}.pack" &&
+     git-prune-packed &&
+     test "`git-count-objects`" = "0 objects, 0 kilobytes" &&
+     cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
+     cmp "test-1-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
+
+test_expect_success \
+    '[index v1] 2) create a stealth corruption in a delta base reference' \
+    '# this test assumes a delta smaller than 16 bytes at the end of the pack
+     git-show-index <1.idx | sort -n | tail -n 1 | (
+       read delta_offs delta_sha1 &&
+       git-cat-file blob "$delta_sha1" > blob_1 &&
+       chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
+       dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($delta_offs + 1)) \
+	  if=".git/objects/pack/pack-${pack1}.idx" skip=$((256 * 4 + 4)) \
+	  bs=1 count=20 conv=notrunc &&
+       git-cat-file blob "$delta_sha1" > blob_2 )'
+
+test_expect_failure \
+    '[index v1] 3) corrupted delta happily returned wrong data' \
+    'cmp blob_1 blob_2'
+
+test_expect_failure \
+    '[index v1] 4) confirm that the pack is actually corrupted' \
+    'git-fsck --full $commit'
+
+test_expect_success \
+    '[index v1] 5) pack-objects happily reuses corrupted data' \
+    'pack4=$(git-pack-objects test-4 <obj-list) &&
+     test -f "test-4-${pack1}.pack"'
+
+test_expect_failure \
+    '[index v1] 6) newly created pack is BAD !' \
+    'git-verify-pack -v "test-4-${pack1}.pack"'
+
+test_expect_success \
+    '[index v2] 1) stream pack to repository' \
+    'rm -f .git/objects/pack/* &&
+     git-index-pack --index-version=2,0x40000 --stdin < "test-1-${pack1}.pack" &&
+     git-prune-packed &&
+     test "`git-count-objects`" = "0 objects, 0 kilobytes" &&
+     cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
+     cmp "test-3-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
+
+test_expect_success \
+    '[index v2] 2) create a stealth corruption in a delta base reference' \
+    '# this test assumes a delta smaller than 16 bytes at the end of the pack
+     git-show-index <1.idx | sort -n | tail -n 1 | (
+       read delta_offs delta_sha1 delta_crc &&
+       git-cat-file blob "$delta_sha1" > blob_3 &&
+       chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
+       dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($delta_offs + 1)) \
+	  if=".git/objects/pack/pack-${pack1}.idx" skip=$((8 + 256 * 4)) \
+	  bs=1 count=20 conv=notrunc &&
+       git-cat-file blob "$delta_sha1" > blob_4 )'
+
+test_expect_failure \
+    '[index v2] 3) corrupted delta happily returned wrong data' \
+    'cmp blob_3 blob_4'
+
+test_expect_failure \
+    '[index v2] 4) confirm that the pack is actually corrupted' \
+    'git-fsck --full $commit'
+
+test_expect_failure \
+    '[index v2] 5) pack-objects refuses to reuse corrupted data' \
+    'git-pack-objects test-5 <obj-list'
+
+test_done
