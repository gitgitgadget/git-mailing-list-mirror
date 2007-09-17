From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] rev-list --bisect: Bisection "distance" clean up.
Date: Mon, 17 Sep 2007 05:28:36 +0200
Message-ID: <20070917052836.d49c16d3.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 05:21:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX7B0-0001vE-Fc
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 05:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbXIQDV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 23:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbXIQDV3
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 23:21:29 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:58940 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbXIQDV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 23:21:28 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0DC361AB2B9;
	Mon, 17 Sep 2007 05:21:28 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id D2CA41AB2A9;
	Mon, 17 Sep 2007 05:21:27 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58380>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 8c9635a..899a31d 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -189,7 +189,7 @@ static int count_interesting_parents(struct commit *commit)
 	return count;
 }
 
-static inline int halfway(struct commit_list *p, int distance, int nr)
+static inline int halfway(struct commit_list *p, int nr)
 {
 	/*
 	 * Don't short-cut something we are not going to return!
@@ -202,8 +202,7 @@ static inline int halfway(struct commit_list *p, int distance, int nr)
 	 * 2 and 3 are halfway of 5.
 	 * 3 is halfway of 6 but 2 and 4 are not.
 	 */
-	distance *= 2;
-	switch (distance - nr) {
+	switch (2 * weight(p) - nr) {
 	case -1: case 0: case 1:
 		return 1;
 	default:
@@ -295,7 +294,7 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights)
 {
-	int n, counted, distance;
+	int n, counted;
 	struct commit_list *p;
 
 	counted = 0;
@@ -346,15 +345,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	for (p = list; p; p = p->next) {
 		if (p->item->object.flags & UNINTERESTING)
 			continue;
-		n = weight(p);
-		if (n != -2)
+		if (weight(p) != -2)
 			continue;
-		distance = count_distance(p);
+		weight_set(p, count_distance(p));
 		clear_distance(list);
-		weight_set(p, distance);
 
 		/* Does it happen to be at exactly half-way? */
-		if (halfway(p, distance, nr))
+		if (halfway(p, nr))
 			return p;
 		counted++;
 	}
@@ -392,8 +389,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				weight_set(p, weight(q));
 
 			/* Does it happen to be at exactly half-way? */
-			distance = weight(p);
-			if (halfway(p, distance, nr))
+			if (halfway(p, nr))
 				return p;
 		}
 	}
-- 
1.5.3.1.59.g93705
