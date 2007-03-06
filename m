From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] revision walker --boundary: show boundaries again
Date: Tue, 6 Mar 2007 12:54:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703061252110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Mar 06 12:54:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOYFC-0006bZ-Rn
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 12:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965871AbXCFLyN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 06:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965872AbXCFLyN
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 06:54:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:37608 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965871AbXCFLyM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 06:54:12 -0500
Received: (qmail invoked by alias); 06 Mar 2007 11:54:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 06 Mar 2007 12:54:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ZSSMf3u+ZEUBq+rr290vUgKu+tPvxxGwz85aBYX
	YZXlyhf9Y0h9BW
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41580>


Without this patch, "git rev-list --boundary master^..master" shows
only master's object name, and nothing else.

It is mainly an indentation patch, because it delays exit in 
get_revision() until after revs->boundary was checked.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	Sorry, I don't have time to write a test case, as I have to run.

 revision.c |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/revision.c b/revision.c
index 35a1711..b6b9fc0 100644
--- a/revision.c
+++ b/revision.c
@@ -1301,31 +1301,31 @@ struct commit *get_revision(struct rev_info *revs)
 	/*
 	 * Now pick up what they want to give us
 	 */
-	if (!(c = get_revision_1(revs)))
-		return NULL;
-	while (0 < revs->skip_count) {
-		revs->skip_count--;
-		c = get_revision_1(revs);
-		if (!c)
-			break;
-	}
+	if ((c = get_revision_1(revs))) {
+		while (0 < revs->skip_count) {
+			revs->skip_count--;
+			c = get_revision_1(revs);
+			if (!c)
+				break;
+		}
 
-	/*
-	 * Check the max_count.
-	 */
-	switch (revs->max_count) {
-	case -1:
-		break;
-	case 0:
-		/* Although we grabbed it, it is not shown. */
-		c = NULL;
-		break;
-	default:
-		revs->max_count--;
-	}
+		/*
+		 * Check the max_count.
+		 */
+		switch (revs->max_count) {
+			case -1:
+				break;
+			case 0:
+				/* Although we grabbed it, it is not shown. */
+				c = NULL;
+				break;
+			default:
+				revs->max_count--;
+		}
 
-	if (c)
-		c->object.flags |= SHOWN;
+		if (c)
+			c->object.flags |= SHOWN;
+	}
 
 	if (!revs->boundary) {
 		return c;
-- 
1.5.0.3.2551.gf95a-dirty
