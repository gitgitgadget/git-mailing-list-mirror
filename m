From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 10/14] remote-hg: fake bookmark when there's none
Date: Tue, 30 Oct 2012 05:35:32 +0100
Message-ID: <1351571736-4682-11-git-send-email-felipe.contreras@gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:36:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3ZL-0006S1-Oj
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab2J3Egh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:36:37 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab2J3Egg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:36:36 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=485XYqnpeAlNLra5DSgpFwMnDayk6niLxrQnTdxdTrk=;
        b=enI4roDX1+vUFYZvS2xW73kP5L6th3CBlgYlzqap9I8odyWL2oxSAhGLFkY7G3XhiW
         tN21Ddw0aRGwNHZVr7KPQcJV3O/ze5Ar1rl4a8a95Lry0YS+NElL09i0OOnV2Yj9jzvq
         oUvoimAJKCLFy8TlzoxN6si+t/Y0hzCXcCSM+26eh9yHthZVWYccMqY1AV+sfBhtuJBm
         8RFgxnF6v3BNwPsIB1NDuVXc3pcmI133aXQdD8YqBmdnKKZKKXCUILsAmLTJxzAL8ibY
         b+WissB5zPnYg4dRIfDriXXtitIcNgLN1eujFsgk2+GGyOCWQZMWckriuYi9qSybY+vy
         WTDA==
Received: by 10.204.128.89 with SMTP id j25mr9919489bks.23.1351571795535;
        Mon, 29 Oct 2012 21:36:35 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id g8sm5163518bkv.6.2012.10.29.21.36.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:36:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208674>

Or at least no current bookmark.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index c2efadf..c41ec95 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -422,12 +422,20 @@ def list_branch_head(repo, cur):
     g_head = (head, 'branches', repo[tip])
 
 def list_bookmark_head(repo, cur):
-    global g_head
+    global g_head, bmarks
 
     head = bookmarks.readcurrent(repo)
-    if not head:
-        return
-    node = repo[head]
+    if head:
+        node = repo[head]
+    else:
+        # fake bookmark from current branch
+        head = cur
+        tip = get_branch_tip(repo, head)
+        if not tip:
+            return
+        node = repo[tip]
+        bmarks[head] = node
+
     print "@refs/heads/%s HEAD" % head
     g_head = (head, 'bookmarks', node)
 
-- 
1.8.0
