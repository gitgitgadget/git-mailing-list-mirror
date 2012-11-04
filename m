From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 07/16] remote-hg: add support for hg-git compat mode
Date: Sun,  4 Nov 2012 03:13:29 +0100
Message-ID: <1351995218-19889-8-git-send-email-felipe.contreras@gmail.com>
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
	id 1TUpjS-0002Xh-K6
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab2KDCOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:14:19 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab2KDCOP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:14:15 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZbDHj29NSjxn+vKWQgmCtccAQVaTI+liiaQWszDhrCw=;
        b=nmkqOh8KLMg0nPuCh96LNp+E7qllXA/aaFb5bXf9qqjhPLb9R3cdU32k37j3HhwMg/
         wTBCO/WHPRl5VGCk6bYTB+R+YR1EEZV+kGO9ijFeUZKGSFSYBBsEru5KQwZkkGFQfBUz
         bPGmcg+KaYFqvXCamEcjg6CeFrSChql8QTcXo1woLePN7LGdXVDiQmuuWwXhVU43QRpr
         o1kMKdhcKvhvGrmifeJeCgEWnpQ6uaViCusCY27PLyn/2ElrUpqFN3Q3Wflw1MCLftUP
         tdECuB4aypYW+8lUbbo5AyYRK0zhAMVeW3eWHAWJuoUNQUTzvSe4sZPeWpTil/7j1fE5
         7Vug==
Received: by 10.205.136.2 with SMTP id ii2mr1391170bkc.114.1351995254968;
        Sat, 03 Nov 2012 19:14:14 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id z13sm7940472bkv.8.2012.11.03.19.14.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:14:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208994>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 89 +++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 6 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 247b7cb..d585756 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -16,6 +16,22 @@ import sys
 import os
 import json
 import shutil
+import subprocess
+
+#
+# If you want to switch to hg-git compatibility mode:
+# git config --global remote-hg.hg-git-compat true
+#
+# git:
+# Sensible defaults for git.
+# hg bookmarks are exported as git branches, hg branches are prefixed
+# with 'branches/'.
+#
+# hg:
+# Emulate hg-git.
+# Only hg bookmarks are exported as git branches.
+# Commits are modified to preserve hg information and allow biridectionality.
+#
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]+)>$')
@@ -226,7 +242,7 @@ def mark_to_rev(mark):
     return marks.to_rev(mark)
 
 def export_ref(repo, name, kind, head):
-    global prefix, marks
+    global prefix, marks, mode
 
     ename = '%s/%s' % (kind, name)
     tip = marks.get_tip(ename)
@@ -261,6 +277,33 @@ def export_ref(repo, name, kind, head):
         else:
             modified, removed = get_filechanges(repo, c, parents[0])
 
+        if mode == 'hg':
+            extra_msg = ''
+
+            if rev_branch != 'default':
+                extra_msg += 'branch : %s\n' % rev_branch
+
+            renames = []
+            for f in c.files():
+                if f not in c.manifest():
+                    continue
+                rename = c.filectx(f).renamed()
+                if rename:
+                    renames.append((rename[0], f))
+
+            for e in renames:
+                extra_msg += "rename : %s => %s\n" % e
+
+            for key, value in extra.iteritems():
+                if key in ('author', 'committer', 'encoding', 'message', 'branch', 'hg-git'):
+                    continue
+                else:
+                    extra_msg += "extra : %s : %s\n" % (key, urllib.quote(value))
+
+            desc += '\n'
+            if extra_msg:
+                desc += '\n--HG--\n' + extra_msg
+
         if len(parents) == 0 and rev:
             print 'reset %s/%s' % (prefix, ename)
 
@@ -354,7 +397,7 @@ def list_head(repo, cur):
     g_head = (head, node)
 
 def do_list(parser):
-    global branches, bmarks
+    global branches, bmarks, mode
 
     repo = parser.repo
     for branch in repo.branchmap():
@@ -368,8 +411,11 @@ def do_list(parser):
     cur = repo.dirstate.branch()
 
     list_head(repo, cur)
-    for branch in branches:
-        print "? refs/heads/branches/%s" % branch
+
+    if mode != 'hg':
+        for branch in branches:
+            print "? refs/heads/branches/%s" % branch
+
     for bmark in bmarks:
         print "? refs/heads/%s" % bmark
 
@@ -437,6 +483,7 @@ def get_merge_files(repo, p1, p2, files):
 
 def parse_commit(parser):
     global marks, blob_marks, bmarks, parsed_refs
+    global mode
 
     from_mark = merge_mark = None
 
@@ -482,7 +529,9 @@ def parse_commit(parser):
             return of['ctx']
         is_exec = of['mode'] == 'x'
         is_link = of['mode'] == 'l'
-        return context.memfilectx(f, of['data'], is_link, is_exec, None)
+        rename = of.get('rename', None)
+        return context.memfilectx(f, of['data'],
+                is_link, is_exec, rename)
 
     repo = parser.repo
 
@@ -509,6 +558,21 @@ def parse_commit(parser):
     if merge_mark:
         get_merge_files(repo, p1, p2, files)
 
+    if mode == 'hg':
+        i = data.find('\n--HG--\n')
+        if i >= 0:
+            tmp = data[i + len('\n--HG--\n'):].strip()
+            for k, v in [e.split(' : ') for e in tmp.split('\n')]:
+                if k == 'rename':
+                    old, new = v.split(' => ', 1)
+                    files[new]['rename'] = old
+                elif k == 'branch':
+                    extra[k] = v
+                elif k == 'extra':
+                    ek, ev = v.split(' : ', 1)
+                    extra[ek] = urllib.unquote(ev)
+            data = data[:i]
+
     ctx = context.memctx(repo, (p1, p2), data,
             files.keys(), getfilectx,
             user, (date, tz), extra)
@@ -596,12 +660,25 @@ def do_export(parser):
 def main(args):
     global prefix, dirname, branches, bmarks
     global marks, blob_marks, parsed_refs
-    global peer
+    global peer, mode
 
     alias = args[1]
     url = args[2]
     peer = None
 
+    cmd = ['git', 'config', '--get', 'remote-hg.hg-git-compat']
+    hg_git_compat = False
+    try:
+        if subprocess.check_output(cmd) == 'true\n':
+            hg_git_compat = True
+    except subprocess.CalledProcessError:
+        pass
+
+    if hg_git_compat:
+        mode = 'hg'
+    else:
+        mode = 'git'
+
     if alias[4:] == url:
         is_tmp = True
         alias = util.sha1(alias).hexdigest()
-- 
1.8.0
