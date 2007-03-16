From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] add test for OFS_DELTA objects
Date: Fri, 16 Mar 2007 13:50:18 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703161346560.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 18:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSGZM-0001Rf-7G
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 18:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965792AbXCPRuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 13:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965795AbXCPRuV
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 13:50:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25322 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965792AbXCPRuU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 13:50:20 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF00062PC7UP6I0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Mar 2007 13:50:19 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42386>

Make sure pack-objects with --delta-base-offset works fine, and that
it actually produces smaller packs as expected.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 17befde..eacb1e9 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -64,7 +64,7 @@ test_expect_success \
 cd "$TRASH"
 
 test_expect_success \
-    'pack with delta' \
+    'pack with REF_DELTA' \
     'pwd &&
      packname_2=$(git-pack-objects test-2 <obj-list)'
 
@@ -72,7 +72,7 @@ rm -fr .git2
 mkdir .git2
 
 test_expect_success \
-    'unpack with delta' \
+    'unpack with REF_DELTA' \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      git-init &&
@@ -82,7 +82,7 @@ test_expect_success \
 unset GIT_OBJECT_DIRECTORY
 cd "$TRASH/.git2"
 test_expect_success \
-    'check unpack with delta' \
+    'check unpack with REF_DELTA' \
     '(cd ../.git && find objects -type f -print) |
      while read path
      do
@@ -93,6 +93,42 @@ test_expect_success \
      done'
 cd "$TRASH"
 
+test_expect_success \
+    'pack with OFS_DELTA' \
+    'pwd &&
+     packname_3=$(git-pack-objects --delta-base-offset test-3 <obj-list)'
+
+rm -fr .git2
+mkdir .git2
+
+test_expect_success \
+    'unpack with OFS_DELTA' \
+    'GIT_OBJECT_DIRECTORY=.git2/objects &&
+     export GIT_OBJECT_DIRECTORY &&
+     git-init &&
+     git-unpack-objects -n <test-3-${packname_3}.pack &&
+     git-unpack-objects <test-3-${packname_3}.pack'
+
+unset GIT_OBJECT_DIRECTORY
+cd "$TRASH/.git2"
+test_expect_success \
+    'check unpack with OFS_DELTA' \
+    '(cd ../.git && find objects -type f -print) |
+     while read path
+     do
+         cmp $path ../.git/$path || {
+	     echo $path differs.
+	     return 1
+	 }
+     done'
+cd "$TRASH"
+
+test_expect_success \
+    'compare delta flavors' \
+    'size_2=`stat -c "%s" test-2-${packname_2}.pack` &&
+     size_3=`stat -c "%s" test-3-${packname_3}.pack` &&
+     test $size_2 -gt $size_3'
+
 rm -fr .git2
 mkdir .git2
 
@@ -111,9 +147,8 @@ test_expect_success \
     } >current &&
     diff expect current'
 
-
 test_expect_success \
-    'use packed deltified objects' \
+    'use packed deltified (REF_DELTA) objects' \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      rm .git2/objects/pack/test-* &&
@@ -127,11 +162,28 @@ test_expect_success \
     } >current &&
     diff expect current'
 
+test_expect_success \
+    'use packed deltified (OFS_DELTA) objects' \
+    'GIT_OBJECT_DIRECTORY=.git2/objects &&
+     export GIT_OBJECT_DIRECTORY &&
+     rm .git2/objects/pack/test-* &&
+     cp test-3-${packname_3}.pack test-3-${packname_3}.idx .git2/objects/pack && {
+	 git-diff-tree --root -p $commit &&
+	 while read object
+	 do
+	    t=`git-cat-file -t $object` &&
+	    git-cat-file $t $object || return 1
+	 done <obj-list
+    } >current &&
+    diff expect current'
+
 unset GIT_OBJECT_DIRECTORY
 
 test_expect_success \
     'verify pack' \
-    'git-verify-pack test-1-${packname_1}.idx test-2-${packname_2}.idx'
+    'git-verify-pack	test-1-${packname_1}.idx \
+			test-2-${packname_2}.idx \
+			test-3-${packname_3}.idx'
 
 test_expect_success \
     'corrupt a pack and see if verify catches' \
@@ -194,6 +246,13 @@ test_expect_success \
      git-index-pack test-3.pack &&
      cmp test-3.idx test-2-${packname_2}.idx &&
 
+     cp test-3-${packname_3}.pack test-3.pack &&
+     git-index-pack -o tmp.idx test-3-${packname_3}.pack &&
+     cmp tmp.idx test-3-${packname_3}.idx &&
+
+     git-index-pack test-3.pack &&
+     cmp test-3.idx test-3-${packname_3}.idx &&
+
      :'
 
 test_done
