From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/7] remote-bzr: add support for remote repositories
Date: Sun, 11 Nov 2012 15:19:54 +0100
Message-ID: <1352643598-8500-4-git-send-email-felipe.contreras@gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:20:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYOx-0007nI-PR
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706Ab2KKOU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:20:27 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47320 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab2KKOUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:20:25 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2064575bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Vp6E+uGKp7SVRMq+9mG43ABgJ4NHPd4oTIop9xn1jCY=;
        b=r11x9l78LlfwUkwARsDWrs3zkvQ0UUCy5DBLh5rLRitg2gSFVH4SwgrcvhE6wdfK/N
         4B2Xmvqqx/Tcbp5vn9TE73MyFMmkgN3Pk2AVlSP1Zhzm95hlFY60ts2U4AUOP7sKVhmf
         4B3ncTFpSg4xn+mHgGTDGMKvbCFecs/PnhDlcidmSzEes3TrDu9tRkSENR+Qo3x9+md3
         c2G+1nnI2K1xGL4h0Aka+Cwe97hBmKW9KfqPwdniNObVQNuQ41KozHeilIEYMtaXS5Zk
         qxxynqxR3iNbVLnxa5KPr2tPlUgIZ2UaxRahshupA/G2CXTVSka5WTi/h/gtYtLArjZL
         IA7w==
Received: by 10.204.146.13 with SMTP id f13mr5994965bkv.29.1352643624398;
        Sun, 11 Nov 2012 06:20:24 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id ia2sm1503322bkc.11.2012.11.11.06.20.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:20:23 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209375>

Strictly speaking bzr doesn't need any changes to interact with remote
repositories, but it's dead slow.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 8366234..2c05f35 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -546,7 +546,7 @@ def parse_reset(parser):
     parsed_refs[ref] = mark_to_rev(from_mark)
 
 def do_export(parser):
-    global parsed_refs, dirname
+    global parsed_refs, dirname, peer
 
     parser.next()
 
@@ -569,6 +569,8 @@ def do_export(parser):
     for ref, revid in parsed_refs.iteritems():
         if ref == 'refs/heads/master':
             repo.generate_revision_history(revid, marks.get_tip('master'))
+            revno, revid = repo.last_revision_info()
+            peer.import_last_revision_info_and_tags(repo, revno, revid)
         print "ok %s" % ref
     print
 
@@ -597,8 +599,28 @@ def do_list(parser):
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
