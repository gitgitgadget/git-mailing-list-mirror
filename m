From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] --stat: ensure at least one '-' for deletions, and one '+'
 for additions
Date: Thu, 28 Sep 2006 17:37:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609281735040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 28 17:37:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSxxJ-0001NU-3D
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 17:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWI1Phm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 11:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWI1Phm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 11:37:42 -0400
Received: from mail.gmx.de ([213.165.64.20]:27784 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965057AbWI1Phl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 11:37:41 -0400
Received: (qmail invoked by alias); 28 Sep 2006 15:37:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 28 Sep 2006 17:37:40 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28007>


The number of '-' and '+' is still linear. The idea is that
scaled-length := floor(a * length + b) with the following constraints: if 
length == 1, scaled-length == 1, and the combined length of plusses 
and minusses should not be larger than the width by a small margin. Thus,

	a + b == 1

and
	a * max_plusses + b + a * max_minusses + b = width + 1

The solution is

	a * x + b = ((width - 1) * (x - 1) + max_change - 1)
		 / (max_change - 1)

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	While testing this, I hit a bug which was hard to squash: commit
	v1.3.3~14 _always_ showed no minusses and plusses in the diffstat.

	Until I realized that the offending diffstat was in the commit
	_message_ :-)

 diff.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 98c29bf..53c30bd 100644
--- a/diff.c
+++ b/diff.c
@@ -640,9 +640,12 @@ const char mime_boundary_leader[] = "---
 static int scale_linear(int it, int width, int max_change)
 {
 	/*
-	 * round(width * it / max_change);
+	 * make sure that at least one '-' is printed if there were deletions,
+	 * and likewise for '+'.
 	 */
-	return (it * width * 2 + max_change) / (max_change * 2);
+	if (max_change < 2)
+		return it;
+	return ((it - 1) * (width - 1) + max_change - 1) / (max_change - 1);
 }
 
 static void show_name(const char *prefix, const char *name, int len,
@@ -774,9 +777,9 @@ static void show_stats(struct diffstat_t
 		dels += del;
 
 		if (width <= max_change) {
-			total = scale_linear(total, width, max_change);
 			add = scale_linear(add, width, max_change);
-			del = total - add;
+			del = scale_linear(del, width, max_change);
+			total = add + del;
 		}
 		show_name(prefix, name, len, reset, set);
 		printf("%5d ", added + deleted);
-- 
1.4.2.1.g89d5d-dirty
