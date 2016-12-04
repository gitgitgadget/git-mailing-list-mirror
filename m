Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6251FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 16:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbcLDQDg (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 11:03:36 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33855 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbcLDQDf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 11:03:35 -0500
Received: by mail-wj0-f194.google.com with SMTP id xy5so36046307wjc.1
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 08:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xzBNs4gQx5R8E2GCl424v+J8G7EKjNaY6YkaO73pVJU=;
        b=LTCYGKiVYVJkXHLtjCUjXemROWnzE9NtL75nnZTVjwcx0MsWhRb0EiLBywVw8N2ANu
         7ZLEQaH8KAH+vbu6zS+uOUVCYMEeIKhSlRADzBP2yQKliqfBc7h77EYjr5g1Ub9Rzy0h
         2B5amyzbJ7LTHkIeQx7xaKXVnXqgbbeLTkOFM1RLJfngd2elIUOAMVwWdjHEKNvkhN55
         7Icb3j+JRvZ1BDpieTf+67A6JlwDVcKfbMjwSSlUClR/PvfAtnylmTG3ir8WvjKBpS0q
         VNMjyunPGie8xhM63CLJrvCofc7KkSkyTFJFeLmJl7SYGA5Na0rPAvu504i6xt4sTzdQ
         OvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xzBNs4gQx5R8E2GCl424v+J8G7EKjNaY6YkaO73pVJU=;
        b=YkZZN71c4p/Z3Md6NICa3rtM/qJhm+667e/NdpofUSCLbeEShWjOxxXqjp/fPSPImA
         ajrIdF7jTpNkKacG19bbGoek7OIKNUFQg9ZEo6aTsgKuUoDBYydrnG1r07BDjbgFuwC5
         07Lx/9ctTjIiiKPySTrdF/FdVLBrW+oT/XH4xbzxdnF5VsisfTy8g43YqmuUr3yny6Na
         GKB/FtPYonfCqP5ZFXuHi1r6YuVS+Zv9CMSWeajlk4PmQavxJ9dqKc2Whp3oxNU/dJPT
         3uEOf9lEoTqqdy+QVds7bXhEYXEy5g4exZb7197Rk1HIbLYZVFKsLLfsltNtHAWUfyLb
         V2Sg==
X-Gm-Message-State: AKaTC03GXGsUrPm+Kvlq4pvveSnWcWjzb3Uri+A1zQe7yWojgmkwnWPcxLbbepZjWmAOtg==
X-Received: by 10.194.85.137 with SMTP id h9mr44577840wjz.23.1480867413666;
        Sun, 04 Dec 2016 08:03:33 -0800 (PST)
Received: from slxBook4.fritz.box.fritz.box (p508BA0CE.dip0.t-ipconnect.de. [80.139.160.206])
        by smtp.gmail.com with ESMTPSA id x5sm15931046wje.36.2016.12.04.08.03.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 04 Dec 2016 08:03:33 -0800 (PST)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     luke@diamand.org, Lars Schneider <lars.schneider@autodesk.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] git-p4: fix empty file processing for large file system backend GitLFS
Date:   Sun,  4 Dec 2016 17:03:37 +0100
Message-Id: <20161204160337.41493-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <lars.schneider@autodesk.com>

If git-p4 tried to store an empty file in GitLFS then it crashed while
parsing the pointer file:

  oid = re.search(r'^oid \w+:(\w+)', pointerFile, re.MULTILINE).group(1)
  AttributeError: 'NoneType' object has no attribute 'group'

This happens because GitLFS does not create a pointer file for an empty
file. Teach git-p4 this behavior to fix the problem and add a test case.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Commit: 454cb6b (v2.11.0)
    Diff on Web: https://github.com/git/git/compare/454cb6b...larsxschneider:b717fde
    Checkout:    git fetch https://github.com/larsxschneider/git git-p4/empty-files-v1 && git checkout b717fde

 git-p4.py                 | 29 +++++++++++++++++------------
 t/t9824-git-p4-git-lfs.sh |  2 ++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index fd5ca52462..ccfb68105f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1005,18 +1005,20 @@ class LargeFileSystem(object):
            steps."""
         if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
             contentTempFile = self.generateTempFile(contents)
-            (git_mode, contents, localLargeFile) = self.generatePointer(contentTempFile)
-
-            # Move temp file to final location in large file system
-            largeFileDir = os.path.dirname(localLargeFile)
-            if not os.path.isdir(largeFileDir):
-                os.makedirs(largeFileDir)
-            shutil.move(contentTempFile, localLargeFile)
-            self.addLargeFile(relPath)
-            if gitConfigBool('git-p4.largeFilePush'):
-                self.pushFile(localLargeFile)
-            if verbose:
-                sys.stderr.write("%s moved to large file system (%s)\n" % (relPath, localLargeFile))
+            (pointer_git_mode, contents, localLargeFile) = self.generatePointer(contentTempFile)
+            if pointer_git_mode:
+                git_mode = pointer_git_mode
+            if localLargeFile:
+                # Move temp file to final location in large file system
+                largeFileDir = os.path.dirname(localLargeFile)
+                if not os.path.isdir(largeFileDir):
+                    os.makedirs(largeFileDir)
+                shutil.move(contentTempFile, localLargeFile)
+                self.addLargeFile(relPath)
+                if gitConfigBool('git-p4.largeFilePush'):
+                    self.pushFile(localLargeFile)
+                if verbose:
+                    sys.stderr.write("%s moved to large file system (%s)\n" % (relPath, localLargeFile))
         return (git_mode, contents)
 
 class MockLFS(LargeFileSystem):
@@ -1056,6 +1058,9 @@ class GitLFS(LargeFileSystem):
            the actual content. Return also the new location of the actual
            content.
            """
+        if os.path.getsize(contentFile) == 0:
+            return (None, '', None)
+
         pointerProcess = subprocess.Popen(
             ['git', 'lfs', 'pointer', '--file=' + contentFile],
             stdout=subprocess.PIPE
diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
index 110a7e7924..734b8db4cb 100755
--- a/t/t9824-git-p4-git-lfs.sh
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -42,6 +42,8 @@ test_expect_success 'Create repo with binary files' '
 	(
 		cd "$cli" &&
 
+		>file0.dat &&
+		p4 add file0.dat &&
 		echo "content 1 txt 23 bytes" >file1.txt &&
 		p4 add file1.txt &&
 		echo "content 2-3 bin 25 bytes" >file2.dat &&
-- 
2.11.0

