From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/20] remote-bzr: use branch variable when appropriate
Date: Thu, 25 Apr 2013 20:07:56 -0500
Message-ID: <1366938488-25425-9-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:09:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAg-0003jO-83
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746Ab3DZBJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:09:50 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56031 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932672Ab3DZBJq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:46 -0400
Received: by mail-ob0-f169.google.com with SMTP id tb18so3072629obb.28
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=QDXTfpEGjC8p0KAodoIzQEP1FKdgrjA9eMQDO6qYKts=;
        b=T8eC9Pa+ta9CT+ewQVeM+U1WScC/p9DM2nVjJGS2FYxuB4CNYEVgHC6C1eW0ZsKL4v
         m3ox8ZA0k0LMmRc6jpdd4StxuDCxiXXQei8kKtnU7y1+m3Iz1bZIFeLv9IzzAFUbEBgy
         N3IL9wwgyxzD+uba6tPUsRtCRQ2WyPvIpL2bhMNl+5qzhvg//0rrapMToh+eVmfyyT6x
         MjKMnjUuwA0t9M6svfOuOAb0b+m2a01ar6rMylAJci6EEWNA1k4ftBG73DGeYAW5fpge
         AlLbL105QhMxyuhod/k/AgsvZKeBWkStm8vYnDerj1/D7kzOtW0pmzBqGI2/ggQXQ/3R
         /nsg==
X-Received: by 10.60.121.104 with SMTP id lj8mr17809747oeb.83.1366938586091;
        Thu, 25 Apr 2013 18:09:46 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id rn6sm2567472oeb.0.2013.04.25.18.09.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222489>

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
1.8.2.1.884.g3532a8d
