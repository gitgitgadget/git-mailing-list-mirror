From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] remote-bzr: add support for older versions of bzr
Date: Tue, 13 Nov 2012 02:03:27 +0100
Message-ID: <1352768608-20703-2-git-send-email-felipe.contreras@gmail.com>
References: <1352768608-20703-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 02:04:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY4v3-0002Vn-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 02:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab2KMBDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 20:03:46 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41372 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab2KMBDp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 20:03:45 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so320111bkw.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 17:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XXztn3Wj6uee0/vGEU3w6k+Gvynygf8HYlC25QvDSlo=;
        b=Yp3gcNBSVsuPOdxLt9rLRAJmfWKTiqZ8NFrCiWZcUXbzhb37RyOP8eh+U92AbxgFtJ
         7goxwa69gSvnT2bgwmNgk+yygGFG2WdrOVR+JpT5zuvvqWLx/ucoWQolCxx5u4j0yJk8
         g2n0WadEVYj0enq4U61rt1hyJsdTfWuEJD5yhVueZPhf9lwWwWBNcxpY/CNyVuqJcgi7
         ZGTw9bYuet2OH2OgwFOYHHUgnEGeu4mxgYpsjACq4fCiOBBzNgcMa+IZRCKogYk13Qml
         tJQ5iiYbgsfidk27YtLyRs06gGbojIWKnRyD1D5kgIUr6lWMu0gTmabCoRQ67rgBGqQq
         krmw==
Received: by 10.204.147.207 with SMTP id m15mr2518548bkv.54.1352768624500;
        Mon, 12 Nov 2012 17:03:44 -0800 (PST)
Received: from localhost (ip-109-43-0-114.web.vodafone.de. [109.43.0.114])
        by mx.google.com with ESMTPS id 9sm4373533bkq.13.2012.11.12.17.03.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 17:03:43 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352768608-20703-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209559>

At least as old as 2.0.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index f8919f4..6cdfac6 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -17,7 +17,8 @@
 import sys
 
 import bzrlib
-bzrlib.initialize()
+if hasattr(bzrlib, "initialize"):
+    bzrlib.initialize()
 
 import bzrlib.plugin
 bzrlib.plugin.load_plugins()
@@ -553,7 +554,7 @@ def parse_commit(parser):
 
     repo.lock_write()
     try:
-        builder = repo.get_commit_builder(parents, None, date, tz, committer, props, revid, False)
+        builder = repo.get_commit_builder(parents, None, date, tz, committer, props, revid)
         try:
             list(builder.record_iter_changes(mtree, mtree.last_revision(), changes))
             builder.finish_inventory()
@@ -612,7 +613,10 @@ def do_export(parser):
         if ref == 'refs/heads/master':
             repo.generate_revision_history(revid, marks.get_tip('master'))
             revno, revid = repo.last_revision_info()
-            peer.import_last_revision_info_and_tags(repo, revno, revid)
+            if hasattr(peer, "import_last_revision_info_and_tags"):
+                peer.import_last_revision_info_and_tags(repo, revno, revid)
+            else:
+                peer.import_last_revision_info(repo.repository, revno, revid)
             wt = peer.bzrdir.open_workingtree()
             wt.update()
         print "ok %s" % ref
@@ -646,12 +650,12 @@ def get_repo(url, alias):
     global dirname, peer
 
     clone_path = os.path.join(dirname, 'clone')
-    origin = bzrlib.controldir.ControlDir.open(url)
+    origin = bzrlib.bzrdir.BzrDir.open(url)
     remote_branch = origin.open_branch()
 
     if os.path.exists(clone_path):
         # pull
-        d = bzrlib.controldir.ControlDir.open(clone_path)
+        d = bzrlib.bzrdir.BzrDir.open(clone_path)
         branch = d.open_branch()
         result = branch.pull(remote_branch, [], None, False)
     else:
-- 
1.8.0
