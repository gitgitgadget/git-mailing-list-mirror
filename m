From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] remote-bzr: detect local repositories
Date: Wed, 28 Nov 2012 02:01:35 +0100
Message-ID: <1354064495-23171-5-git-send-email-felipe.contreras@gmail.com>
References: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 02:02:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdW2i-0001wc-Be
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab2K1BCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:02:07 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54402 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab2K1BCG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:02:06 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5441611bkw.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 17:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9Wc8ibSxU2FblSKRdgHtm8bdkvwGS9l6IDx7trL4Pu0=;
        b=qeJ79UvTwQKQQS4KzDvK56+T/HMUhJlXJfukB3oUeBGfPsxlPKTsZtlcMXcy91EImk
         I2znpqHtpkqNSesmxAqj4RbPDZxTKr3RUsbUBuoQYPE7rz7O2yKt6pE1+0eD7PkhX67+
         efx9QymN56bsEXdmvcgflkH7xyVIHkMYGyT2rt3wx+JeDqCYSVCzVL6lZxirfv3pfJWw
         GhVJbWtirZXfi+kXvs5pDJrEeOkDR/cfwM1PzuGoYgHJ7MfBELUGg7jzYzUruGGyqG+2
         U5mSjMhRb0MEet5SUTBpbXpY0z8x98xF2HHN/MeCNVd4NvDcyi9cFBvrRelkF9HHThBg
         ddEg==
Received: by 10.204.156.81 with SMTP id v17mr5045995bkw.18.1354064525772;
        Tue, 27 Nov 2012 17:02:05 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id 1sm11483241bks.3.2012.11.27.17.02.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 17:02:04 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210650>

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
