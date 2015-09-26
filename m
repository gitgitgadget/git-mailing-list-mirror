From: larsxschneider@gmail.com
Subject: [PATCH v8 5/7] git-p4: check free space during streaming
Date: Sat, 26 Sep 2015 09:55:02 +0200
Message-ID: <1443254104-14966-6-git-send-email-larsxschneider@gmail.com>
References: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 09:55:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfkKn-0007RZ-7X
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 09:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbbIZHzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2015 03:55:48 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34958 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbbIZHzi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2015 03:55:38 -0400
Received: by wicge5 with SMTP id ge5so46643610wic.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2015 00:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=75ACHKEvdztKhfm4sf1cCJwk/oqtmDQTex0poIGKKhs=;
        b=U/5My7PfuBzCF3eS57psdo00vw3D7MASzjl+6D7ENLYYJRMxNzqGbBcWquWWlDSdI6
         CzaDRANymEje6qCgoghAeixib8gXeqJdaCLRkWvmPKJR9xv2RFqDKHZJya0fdqGDpHOe
         2FjAMaE0YFSvWdDa/sJotqXIuvG7AcG/1NHGDhILYnyw4H8rGZCAG9MfGw3shgTXQojH
         j/XOhPExq9bd2tkSsrbzZIhKmsLRe7CjMTNdtN8XZAsdFYkBi1uk9HBlhCk0ZqxjiG78
         zHOBawAj6tAwRZBvZO4bSLFvqmhZidnfn2B7RJf4Ifbx5Nd16fFL9aIpggf1A7clJYKR
         uSvQ==
X-Received: by 10.194.205.68 with SMTP id le4mr12616261wjc.74.1443254137216;
        Sat, 26 Sep 2015 00:55:37 -0700 (PDT)
Received: from localhost.localdomain (tmo-102-235.customers.d1-online.com. [80.187.102.235])
        by smtp.gmail.com with ESMTPSA id it4sm7176613wjb.0.2015.09.26.00.55.33
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 26 Sep 2015 00:55:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278689>

From: Lars Schneider <larsxschneider@gmail.com>

git-p4 will just halt if there is not enough disk space while
streaming content from P4 to Git. Add a check to ensure at least
4 times (arbitrarily chosen) the size of a streamed file is available.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index e7a7ea4..6b1e395 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -104,6 +104,16 @@ def chdir(path, is_client_path=False):
         path = os.getcwd()
     os.environ['PWD'] = path
 
+def calcDiskFree():
+    """Return free space in bytes on the disk of the given dirname."""
+    if platform.system() == 'Windows':
+        free_bytes = ctypes.c_ulonglong(0)
+        ctypes.windll.kernel32.GetDiskFreeSpaceExW(ctypes.c_wchar_p(os.getcwd()), None, None, ctypes.pointer(free_bytes))
+        return free_bytes.value
+    else:
+        st = os.statvfs(os.getcwd())
+        return st.f_bavail * st.f_frsize
+
 def die(msg):
     if verbose:
         raise Exception(msg)
@@ -2256,6 +2266,14 @@ class P4Sync(Command, P4UserMap):
             if marshalled["code"] == "error":
                 if "data" in marshalled:
                     err = marshalled["data"].rstrip()
+
+        if not err and 'fileSize' in self.stream_file:
+            required_bytes = int((4 * int(self.stream_file["fileSize"])) - calcDiskFree())
+            if required_bytes > 0:
+                err = 'Not enough space left on %s! Free at least %i MB.' % (
+                    os.getcwd(), required_bytes/1024/1024
+                )
+
         if err:
             f = None
             if self.stream_have_file_info:
-- 
2.5.1
