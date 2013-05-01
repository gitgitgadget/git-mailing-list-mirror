From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/18] remote-bzr: use branch variable when appropriate
Date: Tue, 30 Apr 2013 20:10:00 -0500
Message-ID: <1367370610-14250-9-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLap-0007RF-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934088Ab3EABMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:18 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:51128 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934086Ab3EABMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:15 -0400
Received: by mail-yh0-f45.google.com with SMTP id f43so208088yha.4
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ZVio1/T+H98i2ly1QrKnWA08SfbXS/2CVfRd2xJtaCU=;
        b=kB+xfi3WXa80tp/9DjYTlSQPCy/4GFrfSEimsnIgxC2OtpUI3XArJpOVZ5P9wxCEmU
         B+Ohi3Wv4dmlTZL633gGXy1UNK3ant1t56nloA5awT7EfeaVFjEaOZMtLzCmQPdMCiPI
         vBIfeQGoRcxlmh0yAUr+X622Hq9x1OEf0xHXo9csUmVDdO3F9WXEIrDOXhuCnBrVUnew
         UgSQna9RL4hyG1BLIcoV20zTzmoByMqluRdRLRFpZ3hRya0Cesk+meAYJQeV3g8mKTKp
         RJZjbkjJ/dqiEwHjFY3hgwWmA7uBu5mBMfVNrnMvYmOERUPB1J6enzi/82PmNCusbfOK
         sRyQ==
X-Received: by 10.236.150.141 with SMTP id z13mr588721yhj.156.1367370735186;
        Tue, 30 Apr 2013 18:12:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id t41sm1606598yhh.11.2013.04.30.18.12.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:12:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223052>

There should be no functional changes. Basically we want to reserve the
'repo' variable.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index fdead31..0c67236 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -257,7 +257,8 @@ def export_branch(branch, name):
     tip = marks.get_tip(name)
 
     repo = branch.repository
-    repo.lock_read()
+
+    branch.lock_read()
     revs = branch.iter_merge_sorted_revisions(None, tip, 'exclude', 'forward')
     count = 0
 
@@ -325,7 +326,7 @@ def export_branch(branch, name):
             print "progress revision %s (%d/%d)" % (revid, count, len(revs))
             print "#############################################################"
 
-    repo.unlock()
+    branch.unlock()
 
     revid = branch.last_revision()
 
@@ -383,21 +384,21 @@ def parse_blob(parser):
 
 class CustomTree():
 
-    def __init__(self, repo, revid, parents, files):
+    def __init__(self, branch, revid, parents, files):
         global files_cache
 
         self.updates = {}
-        self.branch = repo
+        self.branch = branch
 
         def copy_tree(revid):
             files = files_cache[revid] = {}
-            repo.lock_read()
-            tree = repo.repository.revision_tree(revid)
+            branch.lock_read()
+            tree = branch.repository.revision_tree(revid)
             try:
                 for path, entry in tree.iter_entries_by_dir():
                     files[path] = [entry.file_id, None]
             finally:
-                repo.unlock()
+                branch.unlock()
             return files
 
         if len(parents) == 0:
@@ -587,20 +588,20 @@ def parse_commit(parser):
         path = c_style_unescape(path).decode('utf-8')
         files[path] = f
 
-    repo = parser.repo
+    branch = parser.repo
 
     committer, date, tz = committer
     parents = [str(mark_to_rev(p)) for p in parents]
     revid = bzrlib.generate_ids.gen_revision_id(committer, date)
     props = {}
-    props['branch-nick'] = repo.nick
+    props['branch-nick'] = branch.nick
 
-    mtree = CustomTree(repo, revid, parents, files)
+    mtree = CustomTree(branch, revid, parents, files)
     changes = mtree.iter_changes()
 
-    repo.lock_write()
+    branch.lock_write()
     try:
-        builder = repo.get_commit_builder(parents, None, date, tz, committer, props, revid)
+        builder = branch.get_commit_builder(parents, None, date, tz, committer, props, revid)
         try:
             list(builder.record_iter_changes(mtree, mtree.last_revision(), changes))
             builder.finish_inventory()
@@ -609,7 +610,7 @@ def parse_commit(parser):
             builder.abort()
             raise
     finally:
-        repo.unlock()
+        branch.unlock()
 
     parsed_refs[ref] = revid
     marks.new_mark(revid, commit_mark)
@@ -653,20 +654,20 @@ def do_export(parser):
         else:
             die('unhandled export command: %s' % line)
 
-    repo = parser.repo
+    branch = parser.repo
 
     for ref, revid in parsed_refs.iteritems():
         if ref == 'refs/heads/master':
-            repo.generate_revision_history(revid, marks.get_tip('master'))
+            branch.generate_revision_history(revid, marks.get_tip('master'))
             if peer:
                 try:
-                    repo.push(peer, stop_revision=revid)
+                    branch.push(peer, stop_revision=revid)
                 except bzrlib.errors.DivergedBranches:
                     print "error %s non-fast forward" % ref
                     continue
 
             try:
-                wt = repo.bzrdir.open_workingtree()
+                wt = branch.bzrdir.open_workingtree()
                 wt.update()
             except bzrlib.errors.NoWorkingTree:
                 pass
-- 
1.8.3.rc0.399.gc96a135
