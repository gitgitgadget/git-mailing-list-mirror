From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] merge-recursive: fix rename handling
Date: Fri, 4 Aug 2006 18:21:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608041821040.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Aug 04 18:22:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G92Qm-0004XY-Ot
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 18:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161277AbWHDQVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 12:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbWHDQVp
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 12:21:45 -0400
Received: from mail.gmx.de ([213.165.64.20]:30918 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161277AbWHDQVp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 12:21:45 -0400
Received: (qmail invoked by alias); 04 Aug 2006 16:21:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 04 Aug 2006 18:21:41 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24803>


To handle renames properly, we iterate through all file names of both
heads, the current one, and the one to be merged.

Only that there was a bug, where it was checked if the file name was present
in both heads, but the result of the check was never used. Instead, the
merge proceeded as if both heads contained that file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 10bce70..1e176ca 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -808,8 +808,10 @@ static int process_renames(struct path_l
 		} else {
 			compare = strcmp(a_renames->items[i].path,
 					b_renames->items[j].path);
-			ren1 = a_renames->items[i++].util;
-			ren2 = b_renames->items[j++].util;
+			if (compare <= 0)
+				ren1 = a_renames->items[i++].util;
+			if (compare >= 0)
+				ren2 = b_renames->items[j++].util;
 		}
 
 		/* TODO: refactor, so that 1/2 are not needed */
-- 
1.4.2.rc2.ga8a2
