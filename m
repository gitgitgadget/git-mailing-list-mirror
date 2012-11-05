From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/5] remote-bzr: add support for remote repositories
Date: Mon,  5 Nov 2012 16:56:19 +0100
Message-ID: <1352130980-3998-5-git-send-email-felipe.contreras@gmail.com>
References: <1352130980-3998-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 16:57:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVP37-0007Ns-19
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 16:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702Ab2KEP44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 10:56:56 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38101 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab2KEP4y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 10:56:54 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2063229bkc.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 07:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HZemr+wjk4NLRME2lCJXWroXNYK9bENU7uxbx9PlHOg=;
        b=ZajGEBppKhfOovCWWsXQfKIjJE6Pz7IQtuGVDcPVr5MpcLHTrULleQ7L16P23t4YU2
         7DpdCxvcc+YtxbgX9cBy+l+OxPvg45UVLR7c1iDjV6V0yaGPa16YbrF/hHNEGRQ7zeDO
         kCrBfBb5nQUyr70ZDGaFJT1pd/xRdlQUk4T4H+XBRgqnMGNZT16L0T4awH1ctkSX7eIY
         gTZcDpuspigMvZ3VAaX2HdSSl9kIIe6jL1fLSPj+QF+51kRl/8GRLz6tFRUB/JEgabEG
         WobU8z1ZBZAQh05i9zddPKw9fa1oZyp9ha6eUGHjzPnaNivwBwdnQ86kT3CJrDpyVlmI
         M8UA==
Received: by 10.204.148.214 with SMTP id q22mr2323970bkv.128.1352131013783;
        Mon, 05 Nov 2012 07:56:53 -0800 (PST)
Received: from localhost (ip-109-43-0-76.web.vodafone.de. [109.43.0.76])
        by mx.google.com with ESMTPS id 1sm10139723bks.3.2012.11.05.07.56.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 07:56:53 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352130980-3998-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209071>

Strictly speaking bzr doesn't need any changes to interact with remote
repositories, but it's dead slow.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 9e0062f..c981fda 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -547,7 +547,7 @@ def parse_reset(parser):
     parsed_refs[ref] = mark_to_rev(from_mark)
 
 def do_export(parser):
-    global parsed_refs, dirname
+    global parsed_refs, dirname, peer
 
     parser.next()
 
@@ -570,6 +570,8 @@ def do_export(parser):
     for ref, revid in parsed_refs.iteritems():
         if ref == 'refs/heads/master':
             repo.generate_revision_history(revid, marks.get_tip('master'))
+            revno, revid = repo.last_revision_info()
+            peer.import_last_revision_info_and_tags(repo, revno, revid)
         print "ok %s" % ref
     print
 
@@ -598,8 +600,28 @@ def do_list(parser):
     print
 
 def get_repo(url, alias):
+    global dirname, peer
+
+    clone_path = os.path.join(dirname, 'clone')
     origin = bzrlib.controldir.ControlDir.open(url)
-    return origin.open_branch()
+    remote_branch = origin.open_branch()
+
+    if os.path.exists(clone_path):
+        # pull
+        d = bzrlib.controldir.ControlDir.open(clone_path)
+        branch = d.open_branch()
+        result = branch.pull(remote_branch, [], None, False)
+    else:
+        # clone
+        d = origin.sprout(clone_path, None,
+                hardlink=True, create_tree_if_local=False,
+                source_branch=remote_branch)
+        branch = d.open_branch()
+        branch.bind(remote_branch)
+
+    peer = remote_branch
+
+    return branch
 
 def main(args):
     global marks, prefix, dirname
-- 
1.8.0
