From: larsxschneider@gmail.com
Subject: [PATCH v6 5/7] git-p4: check free space during streaming
Date: Sun, 20 Sep 2015 22:26:25 +0200
Message-ID: <1442780787-65166-6-git-send-email-larsxschneider@gmail.com>
References: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 22:27:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdlCc-0003tB-OR
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 22:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbbITU1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 16:27:00 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:32821 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399AbbITU0g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 16:26:36 -0400
Received: by wiclk2 with SMTP id lk2so121688221wic.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+nBrk21Ifwh38cLi/3QoLAP76+j5mwjJ5sukByflmiM=;
        b=PVoQXPG9V+OboRJEgl9qXTtI0wPm0Qjqpj8F16Y1KXNgn4mV3DdtOSkHozr3O0MnVI
         nJbKCcWtE8FaRggRWPLUIUPloEWaYKI0FTIbyfCyEqkzfxbx4Hg1OxjIEqxzOPMydZb2
         C1flJI7enHaJwBW/VUIh+KTjQf/2T0IEWB0N94g/YigemYi8WCoJ+OC++a/Ugo/aW5Ih
         Mvf8QK7FmUbRByWkYdCmOUyUSDh/vR53yCbcgs0J2UEMm8cAYDsGyjmBp7oiDbM8Cy5H
         8Y6ApISetkM5jqT18STRZrvTXtjfCorSCQ6PlmgTEy0Ykizn1MZ+oPwBOOF5vcNNJTA4
         o5Jg==
X-Received: by 10.194.185.100 with SMTP id fb4mr18274239wjc.19.1442780795617;
        Sun, 20 Sep 2015 13:26:35 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-188-106-098-135.188.106.pools.vodafone-ip.de. [188.106.98.135])
        by smtp.gmail.com with ESMTPSA id go2sm9869879wib.20.2015.09.20.13.26.34
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 13:26:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278265>

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
