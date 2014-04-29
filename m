From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/8] remote-hg: update to 'public' phase when pushing
Date: Tue, 29 Apr 2014 04:04:29 -0500
Message-ID: <1398762275-346-3-git-send-email-felipe.contreras@gmail.com>
References: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 11:15:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf48Q-0008MK-DN
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058AbaD2JPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:15:21 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:48039 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756300AbaD2JPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:15:18 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so8658413obc.28
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 02:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WCS/7/AVPNm+oQeJccIdPQcek9pGm+YFxUEhfTqvhrw=;
        b=ewycRgeWgjEx2syjdHdjDI6EPz8Odpefv+giO3TnYfJCuL/GV8DLMiYeLtoC+Rr11w
         fo2I9zKzGtyDOQZGuUiwgg2+u9aitDfQ40MJJJwobhKV8MNga6HJavkFb8YnUwgROLdH
         nSzyWRb1A4JKi4tbcquNIxdfD1Q6iV9X6GZkPtxZrs1CctZdIZB2NIM+lNfSlMPBVp8q
         JtZszPhCsyiuSfiA9TNEsC89lUeKdtL6GacoCqDLiXi9uY7RFLukWkzRyR8ONHijsaxb
         MnCF51U+sHwncMUPe5y5qkZiIx1QS+k/nJpJsS8QD8F973BmZqtN6TZvZAZ35u3Wp7n7
         I3KA==
X-Received: by 10.182.24.226 with SMTP id x2mr27145833obf.13.1398762917761;
        Tue, 29 Apr 2014 02:15:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm85326239oec.0.2014.04.29.02.15.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 02:15:15 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247548>

This is what Mercurial does.

Reported-by: Nathan Palmer
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-hg.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-remote-hg.py b/git-remote-hg.py
index c849abb..204ceeb 100755
--- a/git-remote-hg.py
+++ b/git-remote-hg.py
@@ -995,9 +995,17 @@ def push_unsafe(repo, remote, parsed_refs, p_revs):
     if unbundle:
         if force:
             remoteheads = ['force']
-        return remote.unbundle(cg, remoteheads, 'push')
+        ret = remote.unbundle(cg, remoteheads, 'push')
     else:
-        return remote.addchangegroup(cg, 'push', repo.url())
+        ret = remote.addchangegroup(cg, 'push', repo.url())
+
+    phases = remote.listkeys('phases')
+    if phases:
+        for head in p_revs:
+            # update to public
+            remote.pushkey('phases', hghex(head), '1', '0')
+
+    return ret
 
 def push(repo, remote, parsed_refs, p_revs):
     if hasattr(remote, 'canpush') and not remote.canpush():
-- 
1.9.2+fc1.3.gade8541
