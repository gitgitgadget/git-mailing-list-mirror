From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 33/48] remote-hg: implement custom push()
Date: Fri, 24 May 2013 21:29:49 -0500
Message-ID: <1369449004-17981-34-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Ia-0002do-D6
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642Ab3EYCdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:31 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:53178 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524Ab3EYCdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:25 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so7022778oag.18
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JuQyAjVRvqz0mVs1PyrR00WV7NjLTtkr6GEGXzgTvy8=;
        b=XZwJCRw5JiE5Fu2M2dpoPkIknLbhTHKMup9r8MacZ9jaqwa3RGJLUg4SlvfUM1h1Ph
         iQ4mZ8dxjqbk9S9p1Q+4J/qPkvUKRFTizlPdXxFxWyk0jozBNd1WVlpX445z9Bc/DzTk
         moETThOrrK7Ncwl38DRXUsEv3gUikhl3zvXEiHzjiG/c5Iu0uTI4vwGBAubm0h6/8kUN
         OumgKoStNtwTs79sK0L1EwAjC5zIp7LaFE+gn0abfLH6QHifXGP2QTdtPuADTlLnWveL
         souXWhFnTQmUBfId+/9lPcYmAs6wpnYVY8XO4GNRskC62AusP4NIyFaT53EPsW9jjyMz
         UUBQ==
X-Received: by 10.182.225.199 with SMTP id rm7mr13721774obc.20.1369449204589;
        Fri, 24 May 2013 19:33:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm20597057oep.1.2013.05.24.19.33.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225448>

The one from mercurial does a ton of things we are not interested in,
and we need some special modifications which are impossible otherwise.

Most of the code is borrowed from Mercurial, and cleaned up, but should
be functionally the same for our purposes, except that multiple heads
are not detected.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 44 ++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 7added3..c2c1cb8 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -12,7 +12,7 @@
 # For remote repositories a local clone is stored in
 # "$GIT_DIR/hg/origin/clone/.hg/".
 
-from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions
+from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions, discovery
 
 import re
 import sys
@@ -854,6 +854,46 @@ def write_tag(repo, tag, node, msg, author):
 
     return tagnode
 
+def push_unsafe(repo, remote, parsed_refs, p_revs):
+
+    force = force_push
+
+    fci = discovery.findcommonincoming
+    commoninc = fci(repo, remote, force=force)
+    common, _, remoteheads = commoninc
+
+    # TODO checkheads
+
+    cg = repo.getbundle('push', heads=list(p_revs), common=common)
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
+    if hasattr(remote, 'canpush') and not remote.canpush():
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
 
@@ -919,7 +959,7 @@ def do_export(parser):
             continue
 
     if peer:
-        parser.repo.push(peer, force=force_push, newbranch=True, revs=list(p_revs))
+        push(parser.repo, peer, parsed_refs, p_revs)
 
         # update remote bookmarks
         remote_bmarks = peer.listkeys('bookmarks')
-- 
1.8.3.rc3.312.g47657de
