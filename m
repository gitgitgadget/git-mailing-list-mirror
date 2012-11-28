From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] remote-bzr: add support for older versions of bzr
Date: Wed, 28 Nov 2012 02:01:34 +0100
Message-ID: <1354064495-23171-4-git-send-email-felipe.contreras@gmail.com>
References: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 02:02:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdW2h-0001wc-Sr
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab2K1BCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:02:04 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54402 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab2K1BCC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:02:02 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5441611bkw.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 17:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XXztn3Wj6uee0/vGEU3w6k+Gvynygf8HYlC25QvDSlo=;
        b=uCIJP8B0vFC7zeN8LuElPX6yrQFmJDEkWJ+wn2Ef7dEHOKkSwLXKshbdpDhcEwsNIK
         Flh9ptzt7iL/pO+gsU66UT1mS5xeJoDSSULdhh+2RfY1SBresiiE95fflMI+SekLQkD/
         fS5FxTOQqpfwRjKLto+OOkx9vY3nJMCPIpTf3yLivPBHUjotVtBSUJo/JFVRXKOoSVOK
         hKdEpiu07B+HtpI6o5xH3R98UqZBf2diDFGiBRxluGUTJyZJeWNvXvquaAsrcv7JKFYo
         +V2SK3P/SBWQMriYpP/NeMMBel/phCioRGSCuh1HRoFVpN6iB+mmiXyuRFIOMd11pOSB
         ZP5w==
Received: by 10.204.136.209 with SMTP id s17mr5006807bkt.13.1354064522176;
        Tue, 27 Nov 2012 17:02:02 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id d16sm11483298bkw.2.2012.11.27.17.02.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 17:02:01 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210651>

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
