From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 09/13] remote-hg: add compat for hg-git author fixes
Date: Sun, 28 Oct 2012 04:54:09 +0100
Message-ID: <1351396453-29042-10-git-send-email-felipe.contreras@gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 04:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSJyN-0003Uz-Ig
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab2J1Dz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 23:55:26 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38829 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2J1DzY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:55:24 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1585004eek.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=886uGyzAbpbobM+DGt7aFH0c9QP//L4tPB26xHIvYe4=;
        b=L6OJaDFVg1jUmLre7ARNWOzTaOH1tDQPJhAa2v5MMTNHuibhgLABwGva5qINJYko8T
         FLAU9S0NHIotGhHvfMrsuTRv5r9Nu22K+e7DbhCFLzOWGfXCbZLnyYpAV+X6zOotFnuC
         WjZUSOtWn8wuSPi2XZ36Ve/QuKENmmwO9Ry9QEXQiTvQTD+1hv7BgTSaHcQkNa1vkZXe
         j2dE0oyyNi5lKb0OmI1ONnWQ3C9vjw4QXhTS1ZrNAaikmaycFXpbvM8er8wV8uwj/qoQ
         bS31oYiAvL1unXDumlgpFQMgG0GwCwMweJTxCi6SLn9QP4PHIosUQC6vsJxHy17T1MaZ
         xPew==
Received: by 10.14.179.136 with SMTP id h8mr35771281eem.7.1351396523580;
        Sat, 27 Oct 2012 20:55:23 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id e1sm13235219eem.3.2012.10.27.20.55.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:55:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208526>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 59 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index 47bb7c1..3bb3192 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -14,6 +14,7 @@ import os
 import json
 import shutil
 import subprocess
+import urllib
 
 #
 # If you want to switch to hg-git compatibility mode:
@@ -32,6 +33,7 @@ import subprocess
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]+)>$')
+AUTHOR_HG_RE = re.compile('^(.*?) ?<(.+?)(?:>(.+)?)?$')
 RAW_AUTHOR_RE = re.compile('^(\w+) (?:(.+)? )?<(.+)> (\d+) ([+-]\d+)')
 
 def die(msg, *args):
@@ -149,12 +151,20 @@ class Parser:
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
@@ -162,6 +172,9 @@ class Parser:
         else:
             user = name
 
+        if ex:
+            user += ex
+
         tz = int(tz)
         tz = ((tz / 100) * 3600) + ((tz % 100) * 60)
         return (user, int(date), -tz)
@@ -177,9 +190,9 @@ def get_filechanges(repo, ctx, parents):
     changed, added, removed = [set(sum(e, [])) for e in zip(*l)]
     return added | changed, removed
 
-def fixup_user(user):
-    user = user.replace('"', '')
+def fixup_user_git(user):
     name = mail = None
+    user = user.replace('"', '')
     m = AUTHOR_RE.match(user)
     if m:
         name = m.group(1)
@@ -188,11 +201,41 @@ def fixup_user(user):
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
 
@@ -646,7 +689,7 @@ def do_export(parser):
 def main(args):
     global prefix, dirname, branches, bmarks
     global marks, blob_marks, parsed_refs
-    global peer, mode
+    global peer, mode, bad_mail, bad_name
 
     alias = args[1]
     url = args[2]
@@ -662,8 +705,12 @@ def main(args):
 
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
