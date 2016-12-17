Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919531FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 01:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762296AbcLQBBH (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 20:01:07 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36628 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762227AbcLQBA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 20:00:58 -0500
Received: by mail-pf0-f194.google.com with SMTP id c4so5035595pfb.3
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 17:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27zdukAixz3vRYjRNOZX9pmt5mo0IkcW+L3x7CljVGQ=;
        b=LKAuf93zOTalPOl2ciaeFTBTneqnUwmtf5mBIT8qpnhnV74iSNisEwExIqKsqgBLlr
         0tg1NgmVBMNEC+oSSHXQbPaz+ZVzSY+T4wwHWK0tooJVCLUgkVfuf2mgKRLioD53Kb5w
         /xiAPNYotZ/mgddkupGo6ySVXIumQRnRX+uOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27zdukAixz3vRYjRNOZX9pmt5mo0IkcW+L3x7CljVGQ=;
        b=TQbE9BIN90rMxztNJJbLqtuAPjNvKVu4ZYQomneOdIJKDIIxtpGaYmYXCqF6QAFEbc
         JbKw6qM6o8hWTmBRBS3bme30aQIBZHXAMtXSNVMzfQo+IsayzT7R8HkkSXJ704JNkcU7
         yutFwO0Hkg/valY3nd9+VewlDQiQMW9L0dQieH2w5EXolp2LHB1MkJtcRoadyxZSy6zq
         xEQEbVfOJ9fBh2FykyCBnT3/yBcelOcsW3Ji6Eut1U8CZnx5k5tudW5ToJO1OgMJrrop
         UbD3YFiDR6bfjuHS7FB6doTrfq4Plou5GyNU4DwF32bbmntlAqO/4o74o1rZS2igF2SE
         /86Q==
X-Gm-Message-State: AKaTC02pJQCaVqQvM3bHHuuEwXD7BNOOBWUD8blaJkn+e6/rYUbxw01Biq+2fH+Nswd3+w==
X-Received: by 10.98.50.67 with SMTP id y64mr5745579pfy.98.1481936452233;
        Fri, 16 Dec 2016 17:00:52 -0800 (PST)
Received: from ethel.corp.roku (cpc108967-cmbg20-2-0-cust367.5-4.cable.virginm.net. [81.101.7.112])
        by smtp.gmail.com with ESMTPSA id h185sm14341306pfg.90.2016.12.16.17.00.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Dec 2016 17:00:51 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        viniciusalexandre@gmail.com, aoakley@roku.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2] git-p4: avoid crash adding symlinked directory
Date:   Sat, 17 Dec 2016 01:00:40 +0000
Message-Id: <20161217010040.1399-2-luke@diamand.org>
X-Mailer: git-send-email 2.8.2.703.g78b384c.dirty
In-Reply-To: <20161217010040.1399-1-luke@diamand.org>
References: <20161217010040.1399-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When submitting to P4, if git-p4 came across a symlinked
directory, then during the generation of the submit diff, it would
try to open it as a normal file and fail.

Spot symlinks (of any type) and output a description of the symlink
instead.

Add a test case.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py                     | 26 ++++++++++++++++++++------
 t/t9830-git-p4-symlink-dir.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 6 deletions(-)
 create mode 100755 t/t9830-git-p4-symlink-dir.sh

diff --git a/git-p4.py b/git-p4.py
index fd5ca52..16d0b8a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -25,6 +25,7 @@ import stat
 import zipfile
 import zlib
 import ctypes
+import errno
 
 try:
     from subprocess import CalledProcessError
@@ -1538,7 +1539,7 @@ class P4Submit(Command, P4UserMap):
             if response == 'n':
                 return False
 
-    def get_diff_description(self, editedFiles, filesToAdd):
+    def get_diff_description(self, editedFiles, filesToAdd, symlinks):
         # diff
         if os.environ.has_key("P4DIFF"):
             del(os.environ["P4DIFF"])
@@ -1553,10 +1554,17 @@ class P4Submit(Command, P4UserMap):
             newdiff += "==== new file ====\n"
             newdiff += "--- /dev/null\n"
             newdiff += "+++ %s\n" % newFile
-            f = open(newFile, "r")
-            for line in f.readlines():
-                newdiff += "+" + line
-            f.close()
+
+            is_link = os.path.islink(newFile)
+            expect_link = newFile in symlinks
+
+            if is_link and expect_link:
+                newdiff += "+%s\n" % os.readlink(newFile)
+            else:
+                f = open(newFile, "r")
+                for line in f.readlines():
+                    newdiff += "+" + line
+                f.close()
 
         return (diff + newdiff).replace('\r\n', '\n')
 
@@ -1574,6 +1582,7 @@ class P4Submit(Command, P4UserMap):
         filesToDelete = set()
         editedFiles = set()
         pureRenameCopy = set()
+        symlinks = set()
         filesToChangeExecBit = {}
 
         for line in diff:
@@ -1590,6 +1599,11 @@ class P4Submit(Command, P4UserMap):
                 filesToChangeExecBit[path] = diff['dst_mode']
                 if path in filesToDelete:
                     filesToDelete.remove(path)
+
+                dst_mode = int(diff['dst_mode'], 8)
+                if dst_mode == 0120000:
+                    symlinks.add(path)
+
             elif modifier == "D":
                 filesToDelete.add(path)
                 if path in filesToAdd:
@@ -1727,7 +1741,7 @@ class P4Submit(Command, P4UserMap):
         separatorLine = "######## everything below this line is just the diff #######\n"
         if not self.prepare_p4_only:
             submitTemplate += separatorLine
-            submitTemplate += self.get_diff_description(editedFiles, filesToAdd)
+            submitTemplate += self.get_diff_description(editedFiles, filesToAdd, symlinks)
 
         (handle, fileName) = tempfile.mkstemp()
         tmpFile = os.fdopen(handle, "w+b")
diff --git a/t/t9830-git-p4-symlink-dir.sh b/t/t9830-git-p4-symlink-dir.sh
new file mode 100755
index 0000000..3dc528b
--- /dev/null
+++ b/t/t9830-git-p4-symlink-dir.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='git p4 symlinked directories'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'symlinked directory' '
+	(
+		cd "$cli" &&
+		: >first_file.t &&
+		p4 add first_file.t &&
+		p4 submit -d "first change"
+	) &&
+	git p4 clone --dest "$git" //depot &&
+	(
+		cd "$git" &&
+		mkdir -p some/sub/directory &&
+		mkdir -p other/subdir2 &&
+		: > other/subdir2/file.t &&
+		(cd some/sub/directory && ln -s ../../../other/subdir2 .) &&
+		git add some other &&
+		git commit -m "symlinks" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit -v
+	) &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		test -L some/sub/directory/subdir2
+		test_path_is_file some/sub/directory/subdir2/file.t
+	)
+
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.8.2.703.g78b384c.dirty

