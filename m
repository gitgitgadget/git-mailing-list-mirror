From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 08/14] remote-hg: add support for hg-git compat mode
Date: Tue, 30 Oct 2012 05:35:30 +0100
Message-ID: <1351571736-4682-9-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Oct 30 05:36:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3Z7-0006Bb-JF
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573Ab2J3Eg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:36:27 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab2J3Eg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:36:26 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=flwLWLCXWGiLmgKC8U6GtXstAWXiE5EXnu8xDfGJnwQ=;
        b=fcRk5B1tesowycm+16z+a3xhEvGt1NSy3WomA1NjfpnhDX4RuumOG0F+cWuGAusMl9
         mA2Fu+4qhzqNZZaBle86M8lsZYX5AS6A1fxL3TpftivUy42SWvjTb0v0fN+5pRXDCQi2
         rT24UVBgCyFfzLPyvbpL8RgsTpHRObg6S5qsRewRyhELUpVjO6kLveJYYHB8ELBx4tMZ
         T3htiI5N38/x1SDJZ80grqY12jFBsyCREC7HhYlQDuTNHLXgYE+o4MUgE2W5MYEaQOhL
         fAKteIQ4/370/GFc7CDfB6YjBhXRTeWi00Lg8EDnrEaIkZY78au8PC8OU2CDl/rrk0WW
         Ay2A==
Received: by 10.204.147.148 with SMTP id l20mr10109410bkv.112.1351571785636;
        Mon, 29 Oct 2012 21:36:25 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id x13sm5181884bkv.16.2012.10.29.21.36.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:36:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208671>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 102 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 7 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index c28f4b4..e49f9ed 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
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
@@ -212,7 +228,7 @@ def mark_to_rev(mark):
     return marks.to_rev(mark)
 
 def export_ref(repo, name, kind, head):
-    global prefix, marks
+    global prefix, marks, mode
 
     ename = '%s/%s' % (kind, name)
     tip = marks.get_tip(ename)
@@ -247,6 +263,33 @@ def export_ref(repo, name, kind, head):
         else:
             modified, removed = get_filechanges(repo, c, parents)
 
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
 
@@ -335,8 +378,18 @@ def list_branch_head(repo, cur):
     print "@refs/heads/%s HEAD" % head
     g_head = (head, 'branches', repo[tip])
 
+def list_bookmark_head(repo, cur):
+    global g_head
+
+    head = bookmarks.readcurrent(repo)
+    if not head:
+        return
+    node = repo[head]
+    print "@refs/heads/%s HEAD" % head
+    g_head = (head, 'bookmarks', node)
+
 def do_list(parser):
-    global branches, bmarks
+    global branches, bmarks, mode
 
     repo = parser.repo
     for branch in repo.branchmap():
@@ -349,9 +402,13 @@ def do_list(parser):
 
     cur = repo.dirstate.branch()
 
-    list_branch_head(repo, cur)
-    for branch in branches:
-        print "? refs/heads/branches/%s" % branch
+    if mode != 'hg':
+        list_branch_head(repo, cur)
+        for branch in branches:
+            print "? refs/heads/branches/%s" % branch
+    else:
+        list_bookmark_head(repo, cur)
+
     for bmark in bmarks:
         print "? refs/heads/%s" % bmark
 
@@ -417,6 +474,7 @@ def get_merge_files(repo, p1, p2, files):
 
 def parse_commit(parser):
     global marks, blob_marks, bmarks, parsed_refs
+    global mode
 
     from_mark = merge_mark = None
 
@@ -463,7 +521,9 @@ def parse_commit(parser):
             return of['ctx']
         is_exec = of['mode'] == 'x'
         is_link = of['mode'] == 'l'
-        return context.memfilectx(f, of['data'], is_link, is_exec, None)
+        rename = of.get('rename', None)
+        return context.memfilectx(f, of['data'],
+                is_link, is_exec, rename)
 
     repo = parser.repo
 
@@ -490,6 +550,21 @@ def parse_commit(parser):
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
@@ -574,12 +649,25 @@ def do_export(parser):
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
