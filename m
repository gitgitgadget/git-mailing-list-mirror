From: larsxschneider@gmail.com
Subject: [PATCH v4 2/2] git-p4: handle "Translation of file content failed"
Date: Mon, 21 Sep 2015 12:01:41 +0200
Message-ID: <1442829701-2347-3-git-send-email-larsxschneider@gmail.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 12:02:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdxv7-0004Wd-6z
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 12:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756299AbbIUKB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 06:01:58 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34932 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbbIUKB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 06:01:57 -0400
Received: by wicge5 with SMTP id ge5so108155690wic.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I5pW7qJTNHbhkUeIMnUNelXVgjS9zUGnWkuZEggtzqo=;
        b=OA64ewdzM52FZ+H4uTCs0XFhtmTKBQL4KBeDvBN1urq7yxo940hcdG7dygaJSxPGvj
         rc/LEd1jRfkl3/X2/Qtw0zzrrzZ2HHxLd147TQIDzR+GDGSm11EGhjBFyIlQvyTqAstH
         ztRestBr+P/xCuy9dz06C1w2jXC68EM9yJtyW8Zej42MtNecHkhQehZw0mRcIsFrb/Rl
         Jlq7PfcivyZFeBSx3geWalX/Ov16qA6JtEDCogL87LGNRGeR7DDwWSk+bhaSlHFxkcN+
         H1hIVz/a1bWuiBaGXjt7b1YpDzj6EpDz10IkKezlJ6UKio6Sjr9H5CjM1rXgCF9XPt6v
         IoCw==
X-Received: by 10.180.90.33 with SMTP id bt1mr11977454wib.59.1442829715952;
        Mon, 21 Sep 2015 03:01:55 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id kb9sm23192082wjb.49.2015.09.21.03.01.54
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2015 03:01:55 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278297>

From: Lars Schneider <larsxschneider@gmail.com>

A P4 repository can get into a state where it contains a file with
type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
attempts to retrieve the file then the process crashes with a
"Translation of file content failed" error.

More info here: http://answers.perforce.com/articles/KB/3117

Fix this by detecting this error and retrieving the file as binary
instead. The result in Git is the same.

Known issue: This works only if git-p4 is executed in verbose mode.
In normal mode no exceptions are thrown and git-p4 just exits.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py                                  | 27 ++++++++++++++++-----------
 t/t9825-git-p4-handle-utf16-without-bom.sh |  2 +-
 2 files changed, 17 insertions(+), 12 deletions(-)

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
diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh b/t/t9825-git-p4-handle-utf16-without-bom.sh
index 65c3c4e..fd2edce 100755
--- a/t/t9825-git-p4-handle-utf16-without-bom.sh
+++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
@@ -29,7 +29,7 @@ test_expect_success 'init depot with UTF-16 encoded file and artificially remove
 	)
 '
 
-test_expect_failure 'clone depot with invalid UTF-16 file in verbose mode' '
+test_expect_success 'clone depot with invalid UTF-16 file in verbose mode' '
 	git p4 clone --dest="$git" --verbose //depot &&
 	test_when_finished cleanup_git &&
 	(
-- 
2.5.1
