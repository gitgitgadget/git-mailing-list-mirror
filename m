From: larsxschneider@gmail.com
Subject: [PATCH v7 5/7] git-p4: check free space during streaming
Date: Tue, 22 Sep 2015 00:41:11 +0200
Message-ID: <1442875273-48610-6-git-send-email-larsxschneider@gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:41:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9m5-0000PZ-TC
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932997AbbIUWl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:41:27 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38384 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932869AbbIUWlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:41:25 -0400
Received: by wiclk2 with SMTP id lk2so132508396wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CGEcmY3p5XZjD1zrlFo83YGawDWzHQ3Ku7NknWULmyc=;
        b=eT2WXzIN620d9BAHZQj69ZcY1t8YhtdaWoSFq9JghbOlrjOjELRAPevnGFk6/FFW9j
         z+xZp4EneeaxXnip7CHWXSBLn2i/jE5V8zv+j5lpKh0FeEKdpcyiFVZ6PKfWiknZEa+9
         yzxCEMrIDJDj5gPH8NuqVzUQZ1NK8e2pb+klrROVaeUJ47P3yamDtQ7w4OsugMn9Z1bh
         NT+G14Nywfe2rJQpiSJs0AK0FARZiTqKGA07De/yZmQ2XgPglPRnFoaJHZ80ZoI4VRzb
         hAOSElzP8JloXIxSIUV0mbcsNSek4Y/wqdkXuqwYqJ7RAkN7+kazEL3i1HA2ZLiGfek+
         nKnQ==
X-Received: by 10.180.75.38 with SMTP id z6mr11528682wiv.36.1442875284340;
        Mon, 21 Sep 2015 15:41:24 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id s16sm121516wik.13.2015.09.21.15.41.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2015 15:41:23 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278349>

From: Lars Schneider <larsxschneider@gmail.com>

git-p4 will just halt if there is not enough disk space while
streaming content from P4 to Git. Add a check to ensure at least
4 times (arbitrarily chosen) the size of a streamed file is available.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index fabc900..3931989 100755
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
@@ -2045,6 +2055,14 @@ class P4Sync(Command, P4UserMap):
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
@@ -2273,6 +2291,14 @@ class P4Sync(Command, P4UserMap):
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
@@ -3244,7 +3270,6 @@ class P4Clone(P4Sync):
             optparse.make_option("--bare", dest="cloneBare",
                                  action="store_true", default=False),
         ]
-        self.cloneDestination = None
         self.needsGit = False
         self.cloneBare = False
 
-- 
2.5.1
