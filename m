Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D1A209E6
	for <e@80x24.org>; Wed, 14 Dec 2016 08:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755067AbcLNIRg (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 03:17:36 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36052 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755060AbcLNIRf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 03:17:35 -0500
Received: by mail-lf0-f67.google.com with SMTP id o20so1005192lfg.3
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 00:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fBhCH8jcNl/gfwsswIIzJDBoDTaOmYhEdups/LlPois=;
        b=bSWwq1yoDG4CYJ4kASL4ABQ3GZ1nCUqd+rOaLMsnkqe4LtZx4HxkfLyKqODb0AWKxK
         JZMAAaf3yvGLWIv9oq+z37qW0XQXobec5H0/uMqvYh0IPSKsxQZLM+3jkfZKb6fYPwnu
         /PSJes0M2Ec+of2EMc4IYL4+UzJo5oRdQsIWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fBhCH8jcNl/gfwsswIIzJDBoDTaOmYhEdups/LlPois=;
        b=IoWLscEAFur8jdBBp4WJ1uwR+tiHWKCIcgXq8HdJ1CqnR0dSxrkvX2iG0hgt5SS3ze
         rJA0guBy3YRZjKvjV6072kwBVj0OLPSAseu33b5nuUhvHCFo+yaEQUlogqEv2ArdpGnD
         5AO91bewOICetrYIQiGjIU8CT/qJurfJ0i6pGbfx4pHDZ3JdVBZcLSvQfVSoG9Qpg/yW
         Hzm1tz8h2zQs0EBcibhEDqd49kll6YwrNin7cAG/vTr0Pm5e6N4aw58Dh8X3k5U86nDB
         eEf98dcCGXVZK0qhLEaBr08zTv30ixeb+9GTc2g60LhIsmUFu7sUbbkaH8uFKRncMII9
         xCIA==
X-Gm-Message-State: AKaTC00wtI5gZ/WyrghU2dnxKzc5vb7QQwWBI5+mBD0VJcSKvYz8GEiQWLYJzGqu8r8j8w==
X-Received: by 10.28.21.1 with SMTP id 1mr6413957wmv.133.1481703452915;
        Wed, 14 Dec 2016 00:17:32 -0800 (PST)
Received: from lgd-kipper.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id c133sm6381484wme.12.2016.12.14.00.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2016 00:17:32 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, aoakley@roku.com,
        Duy Nguyen <pclouds@gmail.com>, Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 1/1] git-p4: avoid crash adding symlinked directory
Date:   Wed, 14 Dec 2016 08:17:24 +0000
Message-Id: <20161214081724.16663-2-luke@diamand.org>
X-Mailer: git-send-email 2.11.0.274.g0ea315c
In-Reply-To: <20161214081724.16663-1-luke@diamand.org>
References: <20161214081724.16663-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When submitting to P4, if git-p4 came across a symlinked
directory, then during the generation of the submit diff, it would
try to open it as a normal file and fail.

Spot this case, and instead output the target of the symlink in
the submit diff.

Add a test case.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py                     | 26 ++++++++++++++++++++------
 t/t9830-git-p4-symlink-dir.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 6 deletions(-)
 create mode 100755 t/t9830-git-p4-symlink-dir.sh

diff --git a/git-p4.py b/git-p4.py
index fd5ca5246..d2f59bd91 100755
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
+            try:
+                f = open(newFile, "r")
+                for line in f.readlines():
+                    newdiff += "+" + line
+                f.close()
+            except IOError as e:
+                if e.errno == errno.EISDIR and newFile in symlinks:
+                    newdiff += "+%s\n" % os.readlink(newFile)
+                else:
+                    raise
 
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
index 000000000..3dc528bb1
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
2.11.0.274.g0ea315c

