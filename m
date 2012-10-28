From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 02/13] remote-hg: add support for bookmarks
Date: Sun, 28 Oct 2012 04:54:02 +0100
Message-ID: <1351396453-29042-3-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Oct 28 04:54:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSJxa-0002qk-8H
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab2J1Dyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 23:54:32 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38829 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2J1Dyb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:54:31 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1585004eek.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9rOWuvGfBJC4zjfOOtNMpn9CryUpMn8v+EAuO9vcZFA=;
        b=BXjL0SnWuHwjqTTKbLuYw2nsJu6LoWI1xiI/DXkv+8n0grcn9YJe/9Ys2sqm9n+Z2+
         +uT3yz0D5sExxp6kEcbQyKeD1t2wWvhj4/i2DlSVHdc0d07Q5DKg19DMPsr/4+0yMr6F
         VRz1R//gC4jnHXT21CqVsP302rnA7g2aCenVqmPOAngXoBZ6VKPHQxLdSUp8reflBou8
         nk1tgIrxv67J/wlDuyFzFvkbsYMNUN7nZZUgaWUBWN4CcCSzC7Xc2QaecEE/oMzE9QPm
         ruZjbua70P0l2ZDpwqDLm2yQBIj82s4dDVgd2u+3qFvdULBYlLc5kuc+snKqTr13ol1+
         E2xQ==
Received: by 10.14.0.198 with SMTP id 46mr48267552eeb.21.1351396471104;
        Sat, 27 Oct 2012 20:54:31 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id k2sm13222157eep.15.2012.10.27.20.54.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:54:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208521>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index c771182..4ba9ee6 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -6,7 +6,7 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui
+from mercurial import hg, ui, bookmarks
 
 import re
 import sys
@@ -229,6 +229,10 @@ def export_ref(repo, name, kind, head):
 def export_tag(repo, tag):
     export_ref(repo, tag, 'tags', repo[tag])
 
+def export_bookmark(repo, bmark):
+    head = bmarks[bmark]
+    export_ref(repo, bmark, 'bookmarks', head)
+
 def export_branch(repo, branch):
     tip = get_branch_tip(repo, branch)
     head = repo[tip]
@@ -243,6 +247,7 @@ def do_capabilities(parser):
 
     print "import"
     print "refspec refs/heads/branches/*:%s/branches/*" % prefix
+    print "refspec refs/heads/*:%s/bookmarks/*" % prefix
     print "refspec refs/tags/*:%s/tags/*" % prefix
     print
 
@@ -269,7 +274,7 @@ def list_branch_head(repo, cur):
     g_head = (head, 'branches', repo[tip])
 
 def do_list(parser):
-    global branches
+    global branches, bmarks
 
     repo = parser.repo
     for branch in repo.branchmap():
@@ -277,11 +282,16 @@ def do_list(parser):
         if len(heads):
             branches[branch] = heads
 
+    for bmark, node in bookmarks.listbookmarks(repo).iteritems():
+        bmarks[bmark] = repo[node]
+
     cur = repo.dirstate.branch()
 
     list_branch_head(repo, cur)
     for branch in branches:
         print "? refs/heads/branches/%s" % branch
+    for bmark in bmarks:
+        print "? refs/heads/%s" % bmark
 
     for tag, node in repo.tagslist():
         if tag == 'tip':
@@ -310,6 +320,9 @@ def do_import(parser):
         elif ref.startswith('refs/heads/branches/'):
             branch = ref[len('refs/heads/branches/'):]
             export_branch(repo, branch)
+        elif ref.startswith('refs/heads/'):
+            bmark = ref[len('refs/heads/'):]
+            export_bookmark(repo, bmark)
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             export_tag(repo, tag)
@@ -319,7 +332,7 @@ def do_import(parser):
     print 'done'
 
 def main(args):
-    global prefix, dirname, marks, branches
+    global prefix, dirname, marks, branches, bmarks
 
     alias = args[1]
     url = args[2]
@@ -327,6 +340,7 @@ def main(args):
     gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'hg', alias)
     branches = {}
+    bmarks = {}
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
-- 
1.8.0
