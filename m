From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 10/13] remote-hg: fake bookmark when there's none
Date: Sun, 28 Oct 2012 04:54:10 +0100
Message-ID: <1351396453-29042-11-git-send-email-felipe.contreras@gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 04:55:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSJyU-0003XG-9W
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab2J1Dza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 23:55:30 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38829 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927Ab2J1Dz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:55:28 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1585004eek.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Gz1hQtqRtMkbDoebxbIlyfJRnAPHdzhHokbzMqEKyZU=;
        b=CGWKPE72WSzGnsQN+ymbMzPCDb5M8Mk6cdR9Pb32+8q7gXRsubZUV+6SwVOfghSJfs
         Ub2FEdqu+X/Rp8S9qO+o60Bi819Mn8Zg2d7aep71IlKa39eMOhMbJZL7Qh0J0C6E09pr
         itX/Qc8Vsbn/0D7x75FIU1l0m/90Qg5q06G9qxP+3FCnhHwI2XUMIrrzDTEbTJ5d3C9O
         IjbeISTbonsjQxml1PvlaA1xKUMj65GtWu3t0YLiYyuP+xHbwEb7NJDRnl8JcC7yuADv
         9dMtaasJzI9CvgzhPMNtQP2zKv/Gne13y3S4FgIdYOw4POf4dP6fkV8Ej1mGxVkHoHaq
         9O1A==
Received: by 10.14.223.199 with SMTP id v47mr48230158eep.45.1351396527767;
        Sat, 27 Oct 2012 20:55:27 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id o47sm13226219eem.11.2012.10.27.20.55.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:55:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208528>

Or at least no current bookmark.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index 3bb3192..e8e3791 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -419,12 +419,20 @@ def list_branch_head(repo, cur):
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
