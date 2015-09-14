From: larsxschneider@gmail.com
Subject: [PATCH v5 5/7] git-p4: check free space during streaming
Date: Mon, 14 Sep 2015 15:26:32 +0200
Message-ID: <1442237194-49624-6-git-send-email-larsxschneider@gmail.com>
References: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 15:27:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbTn7-0003A2-WC
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 15:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbbINN1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 09:27:25 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36389 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886AbbINN1W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 09:27:22 -0400
Received: by wicgb1 with SMTP id gb1so141879664wic.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+nBrk21Ifwh38cLi/3QoLAP76+j5mwjJ5sukByflmiM=;
        b=B9ltToq6vLPAWyw2Yki/k8rsu716L6/k0MA6tSmCgVEcYS2GdfRWhGbvrwcA9Kh0M7
         /pbITWgO0GDMib7hDZgH9AJMbpSDPxfe6vqH8z7/Nl9qxKQf46dnJPKGFLUVCIMQ4aaU
         wjyrV8hs/vPT0oUYPc6uQ7z8YVMPChtVgtM2kKR0tGwGrLGL0cC+I/4KbQH8sJaiacpD
         yOl1KFmJyw5uew2+/ud4fX4h8bSqS+imJ/XkpaTwVME5uODtflWYXkPeTfnzaOEnGMVx
         tTkbLHjIaESpgj2P8WdNwDm55//J34mwhzDu9P0i4qmPMFwEi7uFYe241mZMxnEkxQP3
         KSTA==
X-Received: by 10.180.8.132 with SMTP id r4mr27243871wia.70.1442237241699;
        Mon, 14 Sep 2015 06:27:21 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id xt1sm12578013wjb.32.2015.09.14.06.27.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Sep 2015 06:27:20 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277822>

From: Lars Schneider <larsxschneider@gmail.com>

git-p4 will just halt if there is not enough disk space while
streaming content from P4 to Git. Add a check to ensure at least
4 times (arbitrarily chosen) the size of a streamed file is available.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index e7a7ea4..b465356 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -104,6 +104,16 @@ def chdir(path, is_client_path=False):
         path = os.getcwd()
     os.environ['PWD'] = path
 
+def calcDiskFree(dirname):
+    """Return free space in bytes on the disk of the given dirname."""
+    if platform.system() == 'Windows':
+        free_bytes = ctypes.c_ulonglong(0)
+        ctypes.windll.kernel32.GetDiskFreeSpaceExW(ctypes.c_wchar_p(dirname), None, None, ctypes.pointer(free_bytes))
+        return free_bytes.value
+    else:
+        st = os.statvfs(dirname)
+        return st.f_bavail * st.f_frsize
+
 def die(msg):
     if verbose:
         raise Exception(msg)
@@ -2038,6 +2048,14 @@ class P4Sync(Command, P4UserMap):
         self.clientSpecDirs = None
         self.tempBranches = []
         self.tempBranchLocation = "git-p4-tmp"
+        self.largeFileSystem = None
+        self.cloneDestination = None
+
+        if gitConfig('git-p4.largeFileSystem'):
+            largeFileSystemConstructor = globals()[gitConfig('git-p4.largeFileSystem')]
+            self.largeFileSystem = largeFileSystemConstructor(
+                lambda git_mode, relPath, contents: self.writeToGitStream(git_mode, relPath, contents)
+            )
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
@@ -2256,6 +2274,14 @@ class P4Sync(Command, P4UserMap):
             if marshalled["code"] == "error":
                 if "data" in marshalled:
                     err = marshalled["data"].rstrip()
+
+        if not err and self.cloneDestination and 'fileSize' in self.stream_file:
+            required_bytes = int((4 * int(self.stream_file["fileSize"])) - calcDiskFree(self.cloneDestination))
+            if required_bytes > 0:
+                err = 'Not enough space left on %s! Free at least %i MB.' % (
+                    os.path.abspath(self.cloneDestination), required_bytes/1024/1024
+                )
+
         if err:
             f = None
             if self.stream_have_file_info:
@@ -3218,7 +3244,6 @@ class P4Clone(P4Sync):
             optparse.make_option("--bare", dest="cloneBare",
                                  action="store_true", default=False),
         ]
-        self.cloneDestination = None
         self.needsGit = False
         self.cloneBare = False
 
-- 
2.5.1
