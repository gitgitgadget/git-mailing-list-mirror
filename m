From: larsxschneider@gmail.com
Subject: [PATCH v3 2/2] git-p4: handle "Translation of file content failed"
Date: Sun, 20 Sep 2015 18:22:11 +0200
Message-ID: <1442766131-45017-3-git-send-email-larsxschneider@gmail.com>
References: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 18:22:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdhNc-0000Zt-G8
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 18:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbbITQWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 12:22:17 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35757 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbbITQWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 12:22:16 -0400
Received: by wicge5 with SMTP id ge5so87015096wic.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PDmreyUGRXK9jOg4m35KFKPtS6Rva4EKCP5UAxiF/aI=;
        b=kNHjXAucn9vKuUdEVMPINWSXDQYo/ynnOeprFJH1DnAU4CGBKacIPUeePhMiRq7crX
         wbfzY7LHj8IVYaFDs9qLW3vUj64qAtvcwPyIvYZkfCSqVXE/Zp5746kzTTCu0WnW3pPA
         SBzJFVmQkwqVUbQB67G4SEqrU7UcywYebZkLCHtgtJh0nUNhqLscccKbYE08D4MYDMPe
         jRQlUI8k0NLXDKyPEOvSvcgqS/twihoWLG95/uUO7SmvdfO4AB5cVtFcQ8MT82V66T/I
         bBUMAqeqEYPVwF5ThkHSlokONTCOmG2C7pkBs4a0IPPJRSqBc3lh1JxjBGm1OwDKJlW8
         uQIQ==
X-Received: by 10.194.58.177 with SMTP id s17mr21145813wjq.102.1442766135593;
        Sun, 20 Sep 2015 09:22:15 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-188-106-098-135.188.106.pools.vodafone-ip.de. [188.106.98.135])
        by smtp.gmail.com with ESMTPSA id nf15sm9018570wic.22.2015.09.20.09.22.14
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 09:22:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278244>

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
