Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55CD61F453
	for <e@80x24.org>; Tue, 23 Oct 2018 03:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJWMPM (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 08:15:12 -0400
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:54176 "EHLO
        fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbeJWMPL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 08:15:11 -0400
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181023035342.VQEW4167.fed1rmfepo201.cox.net@fed1rmimpo110.cox.net>
          for <git@vger.kernel.org>; Mon, 22 Oct 2018 23:53:42 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo110.cox.net with cox
        id qrth1y00E59yGBo01rthmS; Mon, 22 Oct 2018 23:53:42 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020E.5BCE9B46.0013,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=f4j8+96M c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=smKx5t2vBNcA:10 a=WDhBSedXqNQA:10 a=kviXuzpPAAAA:8 a=mT0H8sz4yFLrZazhjN8A:9
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 8DE0429A0207
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 20:53:41 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] t2000: rename and combine checkout clash tests
Date:   Mon, 22 Oct 2018 20:53:37 -0700
Message-Id: <20181023035341.15398-2-ischis2@cox.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <xmqqwos19nr5.fsf@gitster-ct.c.googlers.com>
References: <xmqqwos19nr5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an earlier patch some tests scripts were renamed and a naming
convention was documented. [1]

Merge t2000-checkout-cache-clash.sh and t2001-checkout-cache-clash.sh into
t2000-conflict-when-checking-files-out.sh.

[1] f50c9f76c ("Rename some test scripts and describe the naming convention", 2005-05-15)

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 t/t2000-checkout-cache-clash.sh             |  60 ---------
 t/t2000-conflict-when-checking-files-out.sh | 135 ++++++++++++++++++++
 t/t2001-checkout-cache-clash.sh             |  85 ------------
 3 files changed, 135 insertions(+), 145 deletions(-)
 delete mode 100755 t/t2000-checkout-cache-clash.sh
 create mode 100755 t/t2000-conflict-when-checking-files-out.sh
 delete mode 100755 t/t2001-checkout-cache-clash.sh

diff --git a/t/t2000-checkout-cache-clash.sh b/t/t2000-checkout-cache-clash.sh
deleted file mode 100755
index de3edb5d57..0000000000
--- a/t/t2000-checkout-cache-clash.sh
+++ /dev/null
@@ -1,60 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano
-#
-
-test_description='git checkout-index test.
-
-This test registers the following filesystem structure in the
-cache:
-
-    path0       - a file
-    path1/file1 - a file in a directory
-
-And then tries to checkout in a work tree that has the following:
-
-    path0/file0 - a file in a directory
-    path1       - a file
-
-The git checkout-index command should fail when attempting to checkout
-path0, finding it is occupied by a directory, and path1/file1, finding
-path1 is occupied by a non-directory.  With "-f" flag, it should remove
-the conflicting paths and succeed.
-'
-. ./test-lib.sh
-
-date >path0
-mkdir path1
-date >path1/file1
-
-test_expect_success \
-    'git update-index --add various paths.' \
-    'git update-index --add path0 path1/file1'
-
-rm -fr path0 path1
-mkdir path0
-date >path0/file0
-date >path1
-
-test_expect_success \
-    'git checkout-index without -f should fail on conflicting work tree.' \
-    'test_must_fail git checkout-index -a'
-
-test_expect_success \
-    'git checkout-index with -f should succeed.' \
-    'git checkout-index -f -a'
-
-test_expect_success \
-    'git checkout-index conflicting paths.' \
-    'test -f path0 && test -d path1 && test -f path1/file1'
-
-test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
-	mkdir -p tar/get &&
-	ln -s tar/get there &&
-	echo first &&
-	git checkout-index -a -f --prefix=there/ &&
-	echo second &&
-	git checkout-index -a -f --prefix=there/
-'
-
-test_done
diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
new file mode 100755
index 0000000000..f18616ad2b
--- /dev/null
+++ b/t/t2000-conflict-when-checking-files-out.sh
@@ -0,0 +1,135 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git conflicts when checking files out test.'
+
+# The first test registers the following filesystem structure in the
+# cache:
+#
+#     path0       - a file
+#     path1/file1 - a file in a directory
+#
+# And then tries to checkout in a work tree that has the following:
+#
+#     path0/file0 - a file in a directory
+#     path1       - a file
+#
+# The git checkout-index command should fail when attempting to checkout
+# path0, finding it is occupied by a directory, and path1/file1, finding
+# path1 is occupied by a non-directory.  With "-f" flag, it should remove
+# the conflicting paths and succeed.
+
+. ./test-lib.sh
+
+show_files() {
+	# show filesystem files, just [-dl] for type and name
+	find path? -ls |
+	sed -e 's/^[0-9]* * [0-9]* * \([-bcdl]\)[^ ]* *[0-9]* *[^ ]* *[^ ]* *[0-9]* [A-Z][a-z][a-z] [0-9][0-9] [^ ]* /fs: \1 /'
+	# what's in the cache, just mode and name
+	git ls-files --stage |
+	sed -e 's/^\([0-9]*\) [0-9a-f]* [0-3] /ca: \1 /'
+	# what's in the tree, just mode and name.
+	git ls-tree -r "$1" |
+	sed -e 's/^\([0-9]*\)	[^ ]*	[0-9a-f]*	/tr: \1 /'
+}
+
+date >path0
+mkdir path1
+date >path1/file1
+
+test_expect_success \
+    'git update-index --add various paths.' \
+    'git update-index --add path0 path1/file1'
+
+rm -fr path0 path1
+mkdir path0
+date >path0/file0
+date >path1
+
+test_expect_success \
+    'git checkout-index without -f should fail on conflicting work tree.' \
+    'test_must_fail git checkout-index -a'
+
+test_expect_success \
+    'git checkout-index with -f should succeed.' \
+    'git checkout-index -f -a'
+
+test_expect_success \
+    'git checkout-index conflicting paths.' \
+    'test -f path0 && test -d path1 && test -f path1/file1'
+
+test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
+	mkdir -p tar/get &&
+	ln -s tar/get there &&
+	echo first &&
+	git checkout-index -a -f --prefix=there/ &&
+	echo second &&
+	git checkout-index -a -f --prefix=there/
+'
+
+# The second test registers the following filesystem structure in the cache:
+#
+#     path2/file0	- a file in a directory
+#     path3/file1 - a file in a directory
+#
+# and attempts to check it out when the work tree has:
+#
+#     path2/file0 - a file in a directory
+#     path3       - a symlink pointing at "path2"
+#
+# Checkout cache should fail to extract path3/file1 because the leading
+# path path3 is occupied by a non-directory.  With "-f" it should remove
+# the symlink path3 and create directory path3 and file path3/file1.
+
+mkdir path2
+date >path2/file0
+test_expect_success \
+    'git update-index --add path2/file0' \
+    'git update-index --add path2/file0'
+test_expect_success \
+    'writing tree out with git write-tree' \
+    'tree1=$(git write-tree)'
+test_debug 'show_files $tree1'
+
+mkdir path3
+date >path3/file1
+test_expect_success \
+    'git update-index --add path3/file1' \
+    'git update-index --add path3/file1'
+test_expect_success \
+    'writing tree out with git write-tree' \
+    'tree2=$(git write-tree)'
+test_debug 'show_files $tree2'
+
+rm -fr path3
+test_expect_success \
+    'read previously written tree and checkout.' \
+    'git read-tree -m $tree1 && git checkout-index -f -a'
+test_debug 'show_files $tree1'
+
+test_expect_success \
+    'add a symlink' \
+    'test_ln_s_add path2 path3'
+test_expect_success \
+    'writing tree out with git write-tree' \
+    'tree3=$(git write-tree)'
+test_debug 'show_files $tree3'
+
+# Morten says "Got that?" here.
+# Test begins.
+
+test_expect_success \
+    'read previously written tree and checkout.' \
+    'git read-tree $tree2 && git checkout-index -f -a'
+test_debug 'show_files $tree2'
+
+test_expect_success \
+    'checking out conflicting path with -f' \
+    'test ! -h path2 && test -d path2 &&
+     test ! -h path3 && test -d path3 &&
+     test ! -h path2/file0 && test -f path2/file0 &&
+     test ! -h path3/file1 && test -f path3/file1'
+
+test_done
diff --git a/t/t2001-checkout-cache-clash.sh b/t/t2001-checkout-cache-clash.sh
deleted file mode 100755
index 1fc8e634b7..0000000000
--- a/t/t2001-checkout-cache-clash.sh
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano
-#
-
-test_description='git checkout-index test.
-
-This test registers the following filesystem structure in the cache:
-
-    path0/file0	- a file in a directory
-    path1/file1 - a file in a directory
-
-and attempts to check it out when the work tree has:
-
-    path0/file0 - a file in a directory
-    path1       - a symlink pointing at "path0"
-
-Checkout cache should fail to extract path1/file1 because the leading
-path path1 is occupied by a non-directory.  With "-f" it should remove
-the symlink path1 and create directory path1 and file path1/file1.
-'
-. ./test-lib.sh
-
-show_files() {
-	# show filesystem files, just [-dl] for type and name
-	find path? -ls |
-	sed -e 's/^[0-9]* * [0-9]* * \([-bcdl]\)[^ ]* *[0-9]* *[^ ]* *[^ ]* *[0-9]* [A-Z][a-z][a-z] [0-9][0-9] [^ ]* /fs: \1 /'
-	# what's in the cache, just mode and name
-	git ls-files --stage |
-	sed -e 's/^\([0-9]*\) [0-9a-f]* [0-3] /ca: \1 /'
-	# what's in the tree, just mode and name.
-	git ls-tree -r "$1" |
-	sed -e 's/^\([0-9]*\)	[^ ]*	[0-9a-f]*	/tr: \1 /'
-}
-
-mkdir path0
-date >path0/file0
-test_expect_success \
-    'git update-index --add path0/file0' \
-    'git update-index --add path0/file0'
-test_expect_success \
-    'writing tree out with git write-tree' \
-    'tree1=$(git write-tree)'
-test_debug 'show_files $tree1'
-
-mkdir path1
-date >path1/file1
-test_expect_success \
-    'git update-index --add path1/file1' \
-    'git update-index --add path1/file1'
-test_expect_success \
-    'writing tree out with git write-tree' \
-    'tree2=$(git write-tree)'
-test_debug 'show_files $tree2'
-
-rm -fr path1
-test_expect_success \
-    'read previously written tree and checkout.' \
-    'git read-tree -m $tree1 && git checkout-index -f -a'
-test_debug 'show_files $tree1'
-
-test_expect_success \
-    'add a symlink' \
-    'test_ln_s_add path0 path1'
-test_expect_success \
-    'writing tree out with git write-tree' \
-    'tree3=$(git write-tree)'
-test_debug 'show_files $tree3'
-
-# Morten says "Got that?" here.
-# Test begins.
-
-test_expect_success \
-    'read previously written tree and checkout.' \
-    'git read-tree $tree2 && git checkout-index -f -a'
-test_debug 'show_files $tree2'
-
-test_expect_success \
-    'checking out conflicting path with -f' \
-    'test ! -h path0 && test -d path0 &&
-     test ! -h path1 && test -d path1 &&
-     test ! -h path0/file0 && test -f path0/file0 &&
-     test ! -h path1/file1 && test -f path1/file1'
-
-test_done
-- 
2.19.0

