From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 09/14] remote-hg: add compat for hg-git author fixes
Date: Tue, 30 Oct 2012 05:35:31 +0100
Message-ID: <1351571736-4682-10-git-send-email-felipe.contreras@gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3ZG-0006M0-2H
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab2J3Egc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:36:32 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab2J3Egb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:36:31 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xedG4IHFukkbLPHat8MG19pwZtTseJqmsChi8cjnxJg=;
        b=Nr68ooBMitbylYlC9KKm4Xj+9v/YtZga2Xlh60VQPmoO3sKBvGkPK6yjAhjEfZgELY
         zsdGy8R705t5EAFuBKeQojUKJylxoNtw7HDjnNFo2W5OUKM8XWGuU5YOUxuUYF2YDUEF
         iRE68hnxTgogNOxb+J/xJ1ZMKB7sYeIbGPx+nnXEweEGdz+pDoLeRkz+YgddvwfoVjco
         vs850zvjTa/63p75R5Fad3/dGJ40As4FQyKcN24aKYkNkH/d6DT5uE9nyyI0nSRDz6Za
         nSVokPZ2yUUuyFJ6tT9/5Xcfxph27KxxDOWkvwqWY83N/7C0eMkQF596Q84pHGodO2Vn
         vJUw==
Received: by 10.205.128.148 with SMTP id he20mr9665109bkc.99.1351571790373;
        Mon, 29 Oct 2012 21:36:30 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id z13sm5164465bkv.8.2012.10.29.21.36.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:36:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208672>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 59 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index e49f9ed..c2efadf 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
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
@@ -180,9 +193,9 @@ def get_filechanges(repo, ctx, parents):
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
@@ -191,11 +204,41 @@ def fixup_user(user):
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
 
@@ -649,7 +692,7 @@ def do_export(parser):
 def main(args):
     global prefix, dirname, branches, bmarks
     global marks, blob_marks, parsed_refs
-    global peer, mode
+    global peer, mode, bad_mail, bad_name
 
     alias = args[1]
     url = args[2]
@@ -665,8 +708,12 @@ def main(args):
 
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
