From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 40/48] remote-hg: improve lightweight tag author
Date: Fri, 24 May 2013 21:29:56 -0500
Message-ID: <1369449004-17981-41-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:34:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Ix-0002wk-Jt
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825Ab3EYCds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:48 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:39727 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab3EYCdq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:46 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so6928383oah.26
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2KSLKcShYJFjLxoIcbfiwFCm1/9xX8Y8XUzQlK/kypU=;
        b=vxvWvM3RL8rX+GhK0hto9CB/CY29y9dgpXSSGE3YmCJxZWcsWRs1vNiLfa/5CF0vU+
         xEu4GK2vFrtFayRJ3Kcuvc7Lwcgt2P+T/MJuEpxRUZre2JBUIsVcX+pG7YsktxKemDW9
         eftgGQOP4DsP4rL8wOahjb7227C6jlRIwUCD8ABhrQI1/teOURdosQyssHn5Ya6Yr+iE
         rpVC7bxJnw4z9/3g/vKz6LKDhHut/YyfOH9WIwR2EYI47GWPeR0a85bCet2vgeIOpXCG
         933whZjwTC0bzOxGtKKRqwdUuGNTsp0ojqIxcq5za77RUSaJy5ESn4209sJXSQQIQZlM
         PPbA==
X-Received: by 10.182.19.168 with SMTP id g8mr13717526obe.21.1369449225941;
        Fri, 24 May 2013 19:33:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ku7sm20081680obc.6.2013.05.24.19.33.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225457>

Use git's committer.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index a1b22f7..fa76b3f 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -840,13 +840,23 @@ def write_tag(repo, tag, node, msg, author):
 
     p1 = tip.hex()
     p2 = '0' * 40
-    if not author:
-        author = (None, 0, 0)
-    user, date, tz = author
+    if author:
+        user, date, tz = author
+        date_tz = (date, tz)
+    else:
+        cmd = ['git', 'var', 'GIT_COMMITTER_IDENT']
+        process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
+        output, _ = process.communicate()
+        m = re.match('^.* <.*>', output)
+        if m:
+            user = m.group(0)
+        else:
+            user = repo.ui.username()
+        date_tz = None
 
     ctx = context.memctx(repo, (p1, p2), msg,
             ['.hgtags'], getfilectx,
-            user, (date, tz), {'branch' : branch})
+            user, date_tz, {'branch' : branch})
 
     tmp = encoding.encoding
     encoding.encoding = 'utf-8'
-- 
1.8.3.rc3.312.g47657de
