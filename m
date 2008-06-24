From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/3] test case for pack resilience against corruptions
Date: Mon, 23 Jun 2008 21:24:28 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806232123420.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 03:25:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAxHj-0004WT-2t
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 03:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbYFXBYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 21:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbYFXBYa
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 21:24:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53300 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbYFXBY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 21:24:29 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2Y008H11859240@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Jun 2008 21:24:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85960>


Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 t/t5303-pack-corruption-resilience.sh |  194 +++++++++++++++++++++++++++++++++
 1 files changed, 194 insertions(+), 0 deletions(-)
 create mode 100755 t/t5303-pack-corruption-resilience.sh

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
new file mode 100755
index 0000000..b0f5693
--- /dev/null
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -0,0 +1,194 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Nicolas Pitre
+#
+
+test_description='resilience to pack corruptions with redundant objects'
+. ./test-lib.sh
+
+# Note: the test objects are created with knowledge of their pack encoding
+# to ensure good code path coverage, and to facilitate direct alteration
+# later on.  The assumed characteristics are:
+#
+# 1) blob_2 is a delta with blob_1 for base and blob_3 is a delta with blob2
+#    for base, such that blob_3 delta depth is 2;
+#
+# 2) the bulk of object data is uncompressible so the text part remains
+#    visible;
+#
+# 3) object header is always 2 bytes.
+
+create_test_files() {
+    test-genrandom "foo" 2000 > file_1 &&
+    test-genrandom "foo" 1800 > file_2 &&
+    test-genrandom "foo" 1800 > file_3 &&
+    echo " base " >> file_1 &&
+    echo " delta1 " >> file_2 &&
+    echo " delta delta2 " >> file_3 &&
+    test-genrandom "bar" 150 >> file_2 &&
+    test-genrandom "baz" 100 >> file_3
+}
+
+create_new_pack() {
+    rm -rf .git &&
+    git init &&
+    blob_1=`git hash-object -t blob -w file_1` &&
+    blob_2=`git hash-object -t blob -w file_2` &&
+    blob_3=`git hash-object -t blob -w file_3` &&
+    pack=`printf "$blob_1\n$blob_2\n$blob_3\n" |
+          git pack-objects $@ .git/objects/pack/pack` &&
+    pack=".git/objects/pack/pack-${pack}" &&
+    git verify-pack -v ${pack}.pack
+}
+
+do_corrupt_object() {
+    ofs=`git show-index < ${pack}.idx | grep $1 | cut -f1 -d" "` &&
+    ofs=$(($ofs + $2)) &&
+    chmod +w ${pack}.pack &&
+    dd if=/dev/zero of=${pack}.pack count=1 bs=1 conv=notrunc seek=$ofs &&
+    test_must_fail git verify-pack ${pack}.pack
+}
+
+test_expect_success \
+    'initial setup validation' \
+    'create_test_files &&
+     create_new_pack &&
+     git prune-packed &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    'create corruption in header of first object' \
+    'do_corrupt_object $blob_1 0 &&
+     test_must_fail git cat-file blob $blob_1 > /dev/null &&
+     test_must_fail git cat-file blob $blob_2 > /dev/null &&
+     test_must_fail git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    '... but having a loose copy allows for full recovery' \
+    'mv ${pack}.idx tmp &&
+     git hash-object -t blob -w file_1 &&
+     mv tmp ${pack}.idx &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    '... and loose copy of first delta allows for partial recovery' \
+    'git prune-packed &&
+     test_must_fail git cat-file blob $blob_2 > /dev/null &&
+     mv ${pack}.idx tmp &&
+     git hash-object -t blob -w file_2 &&
+     mv tmp ${pack}.idx &&
+     test_must_fail git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    'create corruption in data of first object' \
+    'create_new_pack &&
+     git prune-packed &&
+     chmod +w ${pack}.pack &&
+     perl -i -pe "s/ base /abcdef/" ${pack}.pack &&
+     test_must_fail git cat-file blob $blob_1 > /dev/null &&
+     test_must_fail git cat-file blob $blob_2 > /dev/null &&
+     test_must_fail git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    '... but having a loose copy allows for full recovery' \
+    'mv ${pack}.idx tmp &&
+     git hash-object -t blob -w file_1 &&
+     mv tmp ${pack}.idx &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    '... and loose copy of second object allows for partial recovery' \
+    'git prune-packed &&
+     test_must_fail git cat-file blob $blob_2 > /dev/null &&
+     mv ${pack}.idx tmp &&
+     git hash-object -t blob -w file_2 &&
+     mv tmp ${pack}.idx &&
+     test_must_fail git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    'create corruption in header of first delta' \
+    'create_new_pack &&
+     git prune-packed &&
+     do_corrupt_object $blob_2 0 &&
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
+    'create corruption in data of first delta' \
+    'create_new_pack &&
+     git prune-packed &&
+     chmod +w ${pack}.pack &&
+     perl -i -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
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
+    'corruption in delta base reference of first delta (OBJ_REF_DELTA)' \
+    'create_new_pack &&
+     git prune-packed &&
+     do_corrupt_object $blob_2 2 &&
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
+    'corruption in delta base reference of first delta (OBJ_OFS_DELTA)' \
+    'create_new_pack --delta-base-offset &&
+     git prune-packed &&
+     do_corrupt_object $blob_2 2 &&
+     git cat-file blob $blob_1 > /dev/null &&
+     test_must_fail git cat-file blob $blob_2 > /dev/null &&
+     test_must_fail git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    '... and a redundant pack allows for full recovery too' \
+    'mv ${pack}.idx tmp &&
+     git hash-object -t blob -w file_1 &&
+     git hash-object -t blob -w file_2 &&
+     printf "$blob_1\n$blob_2\n" | git pack-objects .git/objects/pack/pack &&
+     git prune-packed &&
+     mv tmp ${pack}.idx &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_done
-- 
1.5.6.GIT
