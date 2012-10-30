From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 02/14] remote-hg: add support for bookmarks
Date: Tue, 30 Oct 2012 05:35:24 +0100
Message-ID: <1351571736-4682-3-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Oct 30 05:36:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3Ye-0005ey-89
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab2J3Ef6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:35:58 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab2J3Ef5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:35:57 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=W1XcUTig2ksK5OVmYuNGJbhpBo3tcIimmzzRu6eIFRE=;
        b=IiWUNnrP9lAOw1DP4S+L0g17m2jV/qi0T2ocivUccbZEIfezLZKvytil427h8bc+5k
         N8+uEB26q/+OE6uS0mJCW4cmRuXzloeNfMsQ+0rt7Y6LtV4SsMV14Hsh+Y1K5AcpOO1n
         nyS62LlTMN2jVZSImx6qCu8HJhL8IH9PCLQDTYtG9XlrlQ/3N+NXuGwaiBzINu9spI6d
         kNoyPjgLvFZPZ7DEF7w8FdgQHlUnWE52JuMeW389x/FKAhJ4+EQvKg/UqHCxqb39uPEo
         yYvLgk1sENSv57o239ulw3jdk0hH8ecvE1g3rwiQugmGvEMMiva7W+f8DYLQIf/v+C+f
         xPNw==
Received: by 10.204.146.13 with SMTP id f13mr9813510bkv.29.1351571756504;
        Mon, 29 Oct 2012 21:35:56 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id j24sm5159280bkv.0.2012.10.29.21.35.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:35:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208664>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index 67d39fa..9e29daa 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -9,7 +9,7 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui
+from mercurial import hg, ui, bookmarks
 
 import re
 import sys
@@ -232,6 +232,10 @@ def export_ref(repo, name, kind, head):
 def export_tag(repo, tag):
     export_ref(repo, tag, 'tags', repo[tag])
 
+def export_bookmark(repo, bmark):
+    head = bmarks[bmark]
+    export_ref(repo, bmark, 'bookmarks', head)
+
 def export_branch(repo, branch):
     tip = get_branch_tip(repo, branch)
     head = repo[tip]
@@ -246,6 +250,7 @@ def do_capabilities(parser):
 
     print "import"
     print "refspec refs/heads/branches/*:%s/branches/*" % prefix
+    print "refspec refs/heads/*:%s/bookmarks/*" % prefix
     print "refspec refs/tags/*:%s/tags/*" % prefix
     print
 
@@ -272,7 +277,7 @@ def list_branch_head(repo, cur):
     g_head = (head, 'branches', repo[tip])
 
 def do_list(parser):
-    global branches
+    global branches, bmarks
 
     repo = parser.repo
     for branch in repo.branchmap():
@@ -280,11 +285,16 @@ def do_list(parser):
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
@@ -313,6 +323,9 @@ def do_import(parser):
         elif ref.startswith('refs/heads/branches/'):
             branch = ref[len('refs/heads/branches/'):]
             export_branch(repo, branch)
+        elif ref.startswith('refs/heads/'):
+            bmark = ref[len('refs/heads/'):]
+            export_bookmark(repo, bmark)
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             export_tag(repo, tag)
@@ -322,7 +335,7 @@ def do_import(parser):
     print 'done'
 
 def main(args):
-    global prefix, dirname, marks, branches
+    global prefix, dirname, marks, branches, bmarks
 
     alias = args[1]
     url = args[2]
@@ -330,6 +343,7 @@ def main(args):
     gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'hg', alias)
     branches = {}
+    bmarks = {}
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
-- 
1.8.0
