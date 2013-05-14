From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 40/47] remote-hg: implement custom checkheads()
Date: Mon, 13 May 2013 23:37:03 -0500
Message-ID: <1368506230-19614-41-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc732-000504-3W
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012Ab3ENEky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:54 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:55010 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab3ENEkv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:51 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so99795obc.12
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ba5ELiXETlLRnp70WQErYDvtd6YGLJaZbyYiSGtkz+M=;
        b=fwZJgYWGmTbzU5Y/sgMyqlRQDtyBrnC3efdoq/wLiM5lE7l8P+ZuLjHYUCL/Nx1AXL
         DoSAt3D0KFxUvTvirtw9TlCPtX2SFkKJgZyavHgRTtOPOLLDLirkwtLSiMDMxm5WxClG
         wJt7wHtKdcVopjj1RZ4b7HkyewO+vWVKaWzWDuf/FCi1zhjaHEw/lN2vY70GdiZXLLO6
         7A/trt+my8UyaV8G3ZqCjA0/m+1bxFhyO9ewj18SJGrKMqsdA1Cx7w8KdhcCh1ekwdrL
         k9eGCi69977OvQgFYjGcpVIX1CwQhRk0Se66jzoB8Z0UPiCIGmiBOeGKPNseeVcbzPU7
         UKeQ==
X-Received: by 10.60.96.105 with SMTP id dr9mr15346483oeb.59.1368506451523;
        Mon, 13 May 2013 21:40:51 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ri8sm20550602oeb.0.2013.05.13.21.40.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224272>

The version from Mercurial is extremely inefficient and convoluted, this
version achieves basically the same, at least for our purposes.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 37 ++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index b064a3c..abc0738 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -839,6 +839,39 @@ def write_tag(repo, tag, node, msg, author):
 
     return tagnode
 
+def checkheads(repo, remote, p_revs):
+
+    remotemap = remote.branchmap()
+    if not remotemap:
+        # empty repo
+        return
+
+    new = {}
+
+    for node in p_revs:
+        ctx = repo[node]
+        branch = ctx.branch()
+        if not branch in remotemap:
+            # new branch
+            continue
+        new.setdefault(branch, []).append(ctx.rev())
+
+    for branch, heads in new.iteritems():
+        old = [repo.changelog.rev(x) for x in remotemap[branch]]
+        for rev in heads:
+            ancestors = repo.changelog.ancestors([rev], stoprev=min(old))
+            found = False
+
+            for x in old:
+                if x in ancestors:
+                    found = True
+                    break
+
+            if found:
+                continue
+
+            raise Exception("non-fast-forward")
+
 def push_unsafe(repo, remote, parsed_refs, p_revs):
 
     unfi = repo.unfiltered()
@@ -846,7 +879,7 @@ def push_unsafe(repo, remote, parsed_refs, p_revs):
 
     fci = discovery.findcommonincoming
     commoninc = fci(unfi, remote, force=force)
-    common, inc, remoteheads = commoninc
+    common, _, remoteheads = commoninc
     fco = discovery.findcommonoutgoing
     outgoing = fco(unfi, remote, onlyheads=list(p_revs), commoninc=commoninc, force=force)
 
@@ -855,7 +888,7 @@ def push_unsafe(repo, remote, parsed_refs, p_revs):
         return None
 
     if not force:
-        discovery.checkheads(unfi, remote, outgoing, remoteheads, True, bool(inc))
+        checkheads(unfi, remote, p_revs)
 
     cg = repo.getlocalbundle('push', outgoing)
 
-- 
1.8.3.rc1.579.g184e698
