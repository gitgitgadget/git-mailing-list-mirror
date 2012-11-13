From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] remote-bzr: detect local repositories
Date: Tue, 13 Nov 2012 02:03:28 +0100
Message-ID: <1352768608-20703-3-git-send-email-felipe.contreras@gmail.com>
References: <1352768608-20703-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 02:04:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY4v4-0002Vn-Au
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 02:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177Ab2KMBDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 20:03:50 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41372 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab2KMBDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 20:03:48 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so320111bkw.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 17:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9Wc8ibSxU2FblSKRdgHtm8bdkvwGS9l6IDx7trL4Pu0=;
        b=iOCIbXXA82W0fFu6YormTmaUA7eu5LZvXEPlFXBL+6WCnxe7QXEpv3edtGOVv3PCzs
         SfF9HTxjkd3DJMXJBzaHDmZaeQslH6uGut3Nl/a154nXLDQc5X1dE/5y1OuJv6YexgB8
         vw5ilwr9N1Yej+QT8tczq2y1VvmFORb5/ob4+r3qserrzCsABGqndyFH9HNW0vw+kBab
         yCyf13zNIqXDe9FqKldX3yfz32DISEpUdxRT+EhzkNAJMedI7ht8jAtNmguD2HQiE7Nb
         qq6vRbwSgif78gbSFu/hcvjWWWQsYtw3TYRiUZxx85WK1xCSsIhvPZM/Rj6hu52Om9t7
         7Crw==
Received: by 10.204.10.74 with SMTP id o10mr7834713bko.9.1352768628113;
        Mon, 12 Nov 2012 17:03:48 -0800 (PST)
Received: from localhost (ip-109-43-0-114.web.vodafone.de. [109.43.0.114])
        by mx.google.com with ESMTPS id 9sm4373512bkq.13.2012.11.12.17.03.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 17:03:47 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352768608-20703-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209560>

So we don't create a clone  unnecessarily.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 48 ++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 6cdfac6..c5822e4 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -24,6 +24,7 @@ import bzrlib.plugin
 bzrlib.plugin.load_plugins()
 
 import bzrlib.generate_ids
+import bzrlib.transport
 
 import sys
 import os
@@ -613,11 +614,14 @@ def do_export(parser):
         if ref == 'refs/heads/master':
             repo.generate_revision_history(revid, marks.get_tip('master'))
             revno, revid = repo.last_revision_info()
-            if hasattr(peer, "import_last_revision_info_and_tags"):
-                peer.import_last_revision_info_and_tags(repo, revno, revid)
+            if peer:
+                if hasattr(peer, "import_last_revision_info_and_tags"):
+                    peer.import_last_revision_info_and_tags(repo, revno, revid)
+                else:
+                    peer.import_last_revision_info(repo.repository, revno, revid)
+                wt = peer.bzrdir.open_workingtree()
             else:
-                peer.import_last_revision_info(repo.repository, revno, revid)
-            wt = peer.bzrdir.open_workingtree()
+                wt = repo.bzrdir.open_workingtree()
             wt.update()
         print "ok %s" % ref
     print
@@ -649,24 +653,28 @@ def do_list(parser):
 def get_repo(url, alias):
     global dirname, peer
 
-    clone_path = os.path.join(dirname, 'clone')
     origin = bzrlib.bzrdir.BzrDir.open(url)
-    remote_branch = origin.open_branch()
-
-    if os.path.exists(clone_path):
-        # pull
-        d = bzrlib.bzrdir.BzrDir.open(clone_path)
-        branch = d.open_branch()
-        result = branch.pull(remote_branch, [], None, False)
+    branch = origin.open_branch()
+
+    if not isinstance(origin.transport, bzrlib.transport.local.LocalTransport):
+        clone_path = os.path.join(dirname, 'clone')
+        remote_branch = branch
+        if os.path.exists(clone_path):
+            # pull
+            d = bzrlib.bzrdir.BzrDir.open(clone_path)
+            branch = d.open_branch()
+            result = branch.pull(remote_branch, [], None, False)
+        else:
+            # clone
+            d = origin.sprout(clone_path, None,
+                    hardlink=True, create_tree_if_local=False,
+                    source_branch=remote_branch)
+            branch = d.open_branch()
+            branch.bind(remote_branch)
+
+        peer = remote_branch
     else:
-        # clone
-        d = origin.sprout(clone_path, None,
-                hardlink=True, create_tree_if_local=False,
-                source_branch=remote_branch)
-        branch = d.open_branch()
-        branch.bind(remote_branch)
-
-    peer = remote_branch
+        peer = None
 
     return branch
 
-- 
1.8.0
