From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 09/16] remote-hg: fake bookmark when there's none
Date: Sun,  4 Nov 2012 03:13:31 +0100
Message-ID: <1351995218-19889-10-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:14:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpjT-0002Xh-JC
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591Ab2KDCO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:14:27 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab2KDCOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:14:23 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hXI18Exk9tBRIxQwHdt5OblmESiOGj3PQGh4wpUUUnc=;
        b=B8rJjBGnsGKEuLqj9pwRmHpRUlJ885cO6sNwg8u6h7nwkn8e+1JGa7KZP09f6unsjM
         NAt0v+gMpZ4VWTupQBrsG5BewoCMjJXzJrTwhO2yM/ECO4Ns6HuiHLA0A45iq0cEaGfp
         FHtqbegooCcboi7h9ROzPDEpnXSIqgbp1F/ilIXPiwvCEqs/PxnkQa0nd7BlevT7tRTo
         0hYhmuVBmbId/jjbIIrHmNOifrw67NumVh0WmoEICp4+8i/dOoCgmXp9+kyoKJYdDBFC
         HstUzynjDH+ewA70Xb9raHLIOVHwCxlNyoz0u9rtsd8w1q2MY464QKOQdU+UW/VQMUzf
         AFHQ==
Received: by 10.204.4.75 with SMTP id 11mr1414895bkq.96.1351995262764;
        Sat, 03 Nov 2012 19:14:22 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id j24sm7939560bkv.0.2012.11.03.19.14.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:14:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208996>

Or at least no current bookmark.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 9db4b7e..dbe309a 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -26,7 +26,7 @@ import urllib
 # git:
 # Sensible defaults for git.
 # hg bookmarks are exported as git branches, hg branches are prefixed
-# with 'branches/'.
+# with 'branches/', HEAD is a special case.
 #
 # hg:
 # Emulate hg-git.
@@ -430,12 +430,21 @@ def get_branch_tip(repo, branch):
     return heads[0]
 
 def list_head(repo, cur):
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
+        node = repo['.']
+        if not node:
+            return
+        if head == 'default':
+            head = 'master'
+        bmarks[head] = node
+
     print "@refs/heads/%s HEAD" % head
     g_head = (head, node)
 
-- 
1.8.0
