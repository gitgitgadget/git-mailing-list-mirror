From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 08/16] remote-hg: add compat for hg-git author fixes
Date: Sun,  4 Nov 2012 03:13:30 +0100
Message-ID: <1351995218-19889-9-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:14:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpjT-0002Xh-2x
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab2KDCOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:14:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab2KDCOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:14:19 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5N6NXb1MMka1VlEHMvU9aQLvOghrqCpjVExEqg9PX48=;
        b=I5K2cpe6CgvpA5y9SFVCBxC5ja9DY1JjBKN4UlC6mZZXIf98TS6nTNsP6+Swk1LpOO
         MMAU8x+h3Q34oYXsqdJjS+Tts5kjwIZSOxY4FdMLhOO05yKc9QXc7Dgn/tFn0qLfHCVQ
         zzLUuNr4DsWLtHG2EnVh2LeU8kEHH87w3a0NrKtXC/H8ELyegPN0ClEQVlTkCw/yy2KI
         pW4sqQ54JY8I3BxkTXJBqsOLT5rHmE5zZE0ltgiVzceho9plXfvLWTRyaqIt/6CEfIIq
         6x0kg8PNF50dGfgY6AqZwqS+fdCG8335yGL5+xFfjIVazz45AKBQMu8MrS1ZDIRdWuca
         7yww==
Received: by 10.204.11.210 with SMTP id u18mr1446692bku.123.1351995258879;
        Sat, 03 Nov 2012 19:14:18 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id e3sm7941099bks.7.2012.11.03.19.14.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:14:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208995>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 59 ++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index d585756..9db4b7e 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -17,6 +17,7 @@ import os
 import json
 import shutil
 import subprocess
+import urllib
 
 #
 # If you want to switch to hg-git compatibility mode:
@@ -35,6 +36,7 @@ import subprocess
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]+)>$')
+AUTHOR_HG_RE = re.compile('^(.*?) ?<(.+?)(?:>(.+)?)?$')
 RAW_AUTHOR_RE = re.compile('^(\w+) (?:(.+)? )?<(.+)> (\d+) ([+-]\d+)')
 
 def die(msg, *args):
@@ -152,12 +154,20 @@ class Parser:
         return sys.stdin.read(size)
 
     def get_author(self):
+        global bad_mail
+
+        ex = None
         m = RAW_AUTHOR_RE.match(self.line)
         if not m:
             return None
         _, name, email, date, tz = m.groups()
+        if name and 'ext:' in name:
+            m = re.match('^(.+?) ext:\((.+)\)$', name)
+            if m:
+                name = m.group(1)
+                ex = urllib.unquote(m.group(2))
 
-        if email != 'unknown':
+        if email != bad_mail:
             if name:
                 user = '%s <%s>' % (name, email)
             else:
@@ -165,6 +175,9 @@ class Parser:
         else:
             user = name
 
+        if ex:
+            user += ex
+
         tz = int(tz)
         tz = ((tz / 100) * 3600) + ((tz % 100) * 60)
         return (user, int(date), -tz)
@@ -194,9 +207,9 @@ def get_filechanges(repo, ctx, parent):
 
     return added | modified, removed
 
-def fixup_user(user):
-    user = user.replace('"', '')
+def fixup_user_git(user):
     name = mail = None
+    user = user.replace('"', '')
     m = AUTHOR_RE.match(user)
     if m:
         name = m.group(1)
@@ -205,11 +218,41 @@ def fixup_user(user):
         m = NAME_RE.match(user)
         if m:
             name = m.group(1).strip()
+    return (name, mail)
+
+def fixup_user_hg(user):
+    def sanitize(name):
+        # stole this from hg-git
+        return re.sub('[<>\n]', '?', name.lstrip('< ').rstrip('> '))
+
+    m = AUTHOR_HG_RE.match(user)
+    if m:
+        name = sanitize(m.group(1))
+        mail = sanitize(m.group(2))
+        ex = m.group(3)
+        if ex:
+            name += ' ext:(' + urllib.quote(ex) + ')'
+    else:
+        name = sanitize(user)
+        if '@' in user:
+            mail = name
+        else:
+            mail = None
+
+    return (name, mail)
+
+def fixup_user(user):
+    global mode, bad_mail
+
+    if mode == 'git':
+        name, mail = fixup_user_git(user)
+    else:
+        name, mail = fixup_user_hg(user)
 
     if not name:
-        name = 'Unknown'
+        name = bad_name
     if not mail:
-        mail = 'unknown'
+        mail = bad_mail
 
     return '%s <%s>' % (name, mail)
 
@@ -660,7 +703,7 @@ def do_export(parser):
 def main(args):
     global prefix, dirname, branches, bmarks
     global marks, blob_marks, parsed_refs
-    global peer, mode
+    global peer, mode, bad_mail, bad_name
 
     alias = args[1]
     url = args[2]
@@ -676,8 +719,12 @@ def main(args):
 
     if hg_git_compat:
         mode = 'hg'
+        bad_mail = 'none@none'
+        bad_name = ''
     else:
         mode = 'git'
+        bad_mail = 'unknown'
+        bad_name = 'Unknown'
 
     if alias[4:] == url:
         is_tmp = True
-- 
1.8.0
