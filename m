From: larsxschneider@gmail.com
Subject: [PATCH v2 2/2] git-p4: handle "Translation of file content failed"
Date: Mon, 14 Sep 2015 18:55:28 +0200
Message-ID: <1442249728-89494-3-git-send-email-larsxschneider@gmail.com>
References: <1442249728-89494-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 18:55:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbX2Y-00073B-Gu
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 18:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001AbbINQzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 12:55:36 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38190 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbbINQze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 12:55:34 -0400
Received: by wiclk2 with SMTP id lk2so141324944wic.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g+vJyYUGKNsKoEbFiMsUOhrZTZKDLHD2GNOyRFFdqjs=;
        b=Ccs2z9zaQWfx/37FM7oe+D5dU5HwtUFKhq/Db//dhmD7uT0648+y2dLuAHgrEXkP91
         6JgIzIp6eOSEJsCBsngE934Fs9lxzpJPyDsw5RpcotxZcgwIVigV3lIAftiBQyhqFVIr
         G+wh52VTFswLgyRNexBlkOPx8JO/9Go2Gp6tkD/iKBnJ/BI028hUKBiPeMxb8/y4raAp
         4UyxA9xyPIHFjLGMC9Wg3/WFi6IFWGzOXv9SLay5Lz6plIMDgWzp5O1s2IVl7ovW+mfX
         aQcFcgy9VDEKM8127UdvPMRFJCIKN4N7hE5/0xVfR0oYT5ShUVDz9RBtZHj2NU9DIUZM
         1Sug==
X-Received: by 10.180.20.166 with SMTP id o6mr26871667wie.48.1442249732955;
        Mon, 14 Sep 2015 09:55:32 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id lh11sm15264784wic.18.2015.09.14.09.55.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Sep 2015 09:55:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442249728-89494-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277836>

From: Lars Schneider <larsxschneider@gmail.com>

A P4 repository can get into a state where it contains a file with
type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
attempts to retrieve the file then the process crashes with a
"Translation of file content failed" error.

Fix this by detecting this error and retrieving the file as binary
instead. The result in Git is the same.

Known issue: This works only if git-p4 is executed in verbose mode.
In normal mode no exceptions are thrown and git-p4 just exits.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 073f87b..5ae25a6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -134,13 +134,11 @@ def read_pipe(c, ignore_error=False):
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
     expand = isinstance(c,basestring)
-    p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
-    pipe = p.stdout
-    val = pipe.read()
-    if p.wait() and not ignore_error:
-        die('Command failed: %s' % str(c))
-
-    return val
+    p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
+    (out, err) = p.communicate()
+    if p.returncode != 0 and not ignore_error:
+        die('Command failed: %s\nError: %s' % (str(c), err))
+    return out
 
 def p4_read_pipe(c, ignore_error=False):
     real_cmd = p4_build_cmd(c)
@@ -2186,10 +2184,17 @@ class P4Sync(Command, P4UserMap):
             # them back too.  This is not needed to the cygwin windows version,
             # just the native "NT" type.
             #
-            text = p4_read_pipe(['print', '-q', '-o', '-', "%s@%s" % (file['depotFile'], file['change']) ])
-            if p4_version_string().find("/NT") >= 0:
-                text = text.replace("\r\n", "\n")
-            contents = [ text ]
+            try:
+                text = p4_read_pipe(['print', '-q', '-o', '-', '%s@%s' % (file['depotFile'], file['change'])])
+            except Exception as e:
+                if 'Translation of file content failed' in str(e):
+                    type_base = 'binary'
+                else:
+                    raise e
+            else:
+                if p4_version_string().find('/NT') >= 0:
+                    text = text.replace('\r\n', '\n')
+                contents = [ text ]
 
         if type_base == "apple":
             # Apple filetype files will be streamed as a concatenation of
-- 
2.5.1
