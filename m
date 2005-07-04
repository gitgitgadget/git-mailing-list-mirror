From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Fixup t/t5300 unit tests broken by 5f3de58ff85c49620ae2a1722d8d4d37c881a054
Date: Mon, 04 Jul 2005 23:15:36 +1000
Message-ID: <20050704131536.2214.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 04 15:18:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpQpu-0000up-Ej
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 15:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVGDNRj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 09:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVGDNRi
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 09:17:38 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:46209 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261705AbVGDNPo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 09:15:44 -0400
Received: (qmail 2225 invoked by uid 500); 4 Jul 2005 13:15:36 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch fixes up the t/t5300 unit tests which were broken by the changes in:

	Make the name of a pack-file depend on the objects packed there-in.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 t/t5300-pack-object.sh |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

1bd90884e1a91e2f2e84898703c79cb9c8db0572
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -35,18 +35,18 @@ test_expect_success \
 
 test_expect_success \
     'pack without delta' \
-    'git-pack-objects --window=0 test-1 <obj-list'
+    'packname_1=$(git-pack-objects --window=0 test-1 <obj-list)'
 
 rm -fr .git2
 mkdir .git2
 
 test_expect_success \
     'unpack without delta' \
-    'GIT_OBJECT_DIRECTORY=.git2/objects &&
+    "GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      git-init-db &&
-     git-unpack-objects -n <test-1.pack &&
-     git-unpack-objects <test-1.pack'
+     git-unpack-objects -n <test-1-${packname_1}.pack &&
+     git-unpack-objects <test-1-${packname_1}.pack"
 
 unset GIT_OBJECT_DIRECTORY
 cd $TRASH/.git2
@@ -66,7 +66,7 @@ cd $TRASH
 test_expect_success \
     'pack with delta' \
     'pwd &&
-     git-pack-objects test-2 <obj-list'
+     packname_2=$(git-pack-objects test-2 <obj-list)'
 
 rm -fr .git2
 mkdir .git2
@@ -76,8 +76,8 @@ test_expect_success \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      git-init-db &&
-     git-unpack-objects -n <test-2.pack &&
-     git-unpack-objects <test-2.pack'
+     git-unpack-objects -n <test-2-${packname_2}.pack &&
+     git-unpack-objects <test-2-${packname_2}.pack'
 
 unset GIT_OBJECT_DIRECTORY
 cd $TRASH/.git2
@@ -101,7 +101,7 @@ test_expect_success \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      git-init-db &&
-     cp test-1.pack test-1.idx .git2/objects/pack && {
+     cp test-1-${packname_1}.pack test-1-${packname_1}.idx .git2/objects/pack && {
 	 git-diff-tree --root -p $commit &&
 	 while read object
 	 do
@@ -117,7 +117,7 @@ test_expect_success \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      rm -f .git2/objects/pack/test-?.idx &&
-     cp test-2.pack test-2.idx .git2/objects/pack && {
+     cp test-2-${packname_2}.pack test-2-${packname_2}.idx .git2/objects/pack && {
 	 git-diff-tree --root -p $commit &&
 	 while read object
 	 do
@@ -131,32 +131,32 @@ unset GIT_OBJECT_DIRECTORY
 
 test_expect_success \
     'verify pack' \
-    'git-verify-pack test-1.idx test-2.idx'
+    'git-verify-pack test-1-${packname_1}.idx test-2-${packname_2}.idx'
 
 test_expect_success \
     'corrupt a pack and see if verify catches' \
-    'cp test-1.idx test-3.idx &&
-     cp test-2.pack test-3.pack &&
+    'cp test-1-${packname_1}.idx test-3.idx &&
+     cp test-2-${packname_2}.pack test-3.pack &&
      if git-verify-pack test-3.idx
      then false
      else :;
      fi &&
 
-     cp test-1.pack test-3.pack &&
+     cp test-1-${packname_1}.pack test-3.pack &&
      dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=2 &&
      if git-verify-pack test-3.idx
      then false
      else :;
      fi &&
 
-     cp test-1.pack test-3.pack &&
+     cp test-1-${packname_1}.pack test-3.pack &&
      dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=7 &&
      if git-verify-pack test-3.idx
      then false
      else :;
      fi &&
 
-     cp test-1.pack test-3.pack &&
+     cp test-1-${packname_1}.pack test-3.pack &&
      dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=12 &&
      if git-verify-pack test-3.idx
      then false
------------
