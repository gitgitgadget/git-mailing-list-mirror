From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 39/47] remote-hg: implement custom push()
Date: Mon, 13 May 2013 23:37:02 -0500
Message-ID: <1368506230-19614-40-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72l-0004oJ-KS
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab3ENEku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:50 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:50928 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab3ENEks (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:48 -0400
Received: by mail-ob0-f179.google.com with SMTP id xn12so95077obc.38
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UzXQ+pcLb4bAi6kTgm+zfZVBNig0mSqPDWfHqjk7tqg=;
        b=JcTEyluJmiG2ZZqXT2iiliNopdpAnm6Y8sMmzEQJd0znqwX2vpziroa4B7lKPt1GS0
         kv7KbMbp8vtrv8D41hyQAstg/sNSJeCBrxmi++QcvPpTpZw4RBB95+l5xxycpIsqr0mO
         LuJPW/A51r21VBnwRJVKC49m3JFldEWsdnvFMcNSZY94XNlvYEng/7ASUM7wUY3hxwCs
         MJpSQjRkid1VbLcRLioI4xFLHHlH+tlU60d0dFgnpAxsOeQDLBi0SZjM1rC+eO0IIYnO
         oE+Do4eorH/+7GU0QPyITQc6CBYjohvcRBce7H4TYoRiY/ORm6JwAOHRaVM2OsP8Em1/
         L2QQ==
X-Received: by 10.60.23.9 with SMTP id i9mr6530329oef.109.1368506447971;
        Mon, 13 May 2013 21:40:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id dt3sm19946917obb.12.2013.05.13.21.40.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224268>

The one from mercurial does a ton of things we are not interested in,
and we need some special modifications which are impossible otherwise.

Most of the code is borrowed from Mercurial, and cleaned up, but should
be functionally the same for our purposes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 52 ++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index c814188..b064a3c 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -12,7 +12,7 @@
 # For remote repositories a local clone is stored in
 # "$GIT_DIR/hg/origin/clone/.hg/".
 
-from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions
+from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions, discovery
 
 import re
 import sys
@@ -839,6 +839,54 @@ def write_tag(repo, tag, node, msg, author):
 
     return tagnode
 
+def push_unsafe(repo, remote, parsed_refs, p_revs):
+
+    unfi = repo.unfiltered()
+    force = force_push
+
+    fci = discovery.findcommonincoming
+    commoninc = fci(unfi, remote, force=force)
+    common, inc, remoteheads = commoninc
+    fco = discovery.findcommonoutgoing
+    outgoing = fco(unfi, remote, onlyheads=list(p_revs), commoninc=commoninc, force=force)
+
+    if not outgoing.missing:
+        # nothing to push
+        return None
+
+    if not force:
+        discovery.checkheads(unfi, remote, outgoing, remoteheads, True, bool(inc))
+
+    cg = repo.getlocalbundle('push', outgoing)
+
+    unbundle = remote.capable('unbundle')
+    if unbundle:
+        if force:
+            remoteheads = ['force']
+        return remote.unbundle(cg, remoteheads, 'push')
+    else:
+        return remote.addchangegroup(cg, 'push', repo.url())
+
+def push(repo, remote, parsed_refs, p_revs):
+    if not remote.canpush():
+        print "error cannot push"
+
+    if not p_revs:
+        # nothing to push
+        return
+
+    lock = None
+    unbundle = remote.capable('unbundle')
+    if not unbundle:
+        lock = remote.lock()
+    try:
+        ret = push_unsafe(repo, remote, parsed_refs, p_revs)
+    finally:
+        if lock is not None:
+            lock.release()
+
+    return ret
+
 def do_export(parser):
     global parsed_refs, bmarks, peer
 
@@ -906,7 +954,7 @@ def do_export(parser):
             continue
 
     if peer:
-        parser.repo.push(peer, force=force_push, newbranch=True, revs=list(p_revs))
+        push(parser.repo, peer, parsed_refs, p_revs)
 
         # update remote bookmarks
         remote_bmarks = peer.listkeys('bookmarks')
-- 
1.8.3.rc1.579.g184e698
