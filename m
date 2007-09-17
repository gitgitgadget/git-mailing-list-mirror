From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] rev-list --bisect: Move finding bisection into
 do_find_bisection.
Date: Mon, 17 Sep 2007 05:28:20 +0200
Message-ID: <20070917052820.e83f31d5.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 05:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX7Ai-0001sR-Uo
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 05:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbXIQDVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 23:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbXIQDVN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 23:21:13 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:58918 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbXIQDVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 23:21:12 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9A2F41AB2B9;
	Mon, 17 Sep 2007 05:21:11 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 67AB31AB2B4;
	Mon, 17 Sep 2007 05:21:11 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58378>

This factorises some code and make a big function smaller.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |   90 +++++++++++++++++++++++++++------------------------
 1 files changed, 48 insertions(+), 42 deletions(-)

	This patch series is a resend with the changes Junio asked for. 

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index ac551d5..2dae287 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -268,39 +268,12 @@ static void show_list(const char *debug, int counted, int nr,
  * unknown.  After running count_distance() first, they will get zero
  * or positive distance.
  */
-
-static struct commit_list *find_bisection(struct commit_list *list,
-					  int *reaches, int *all)
+static struct commit_list *do_find_bisection(struct commit_list *list,
+					     int nr, int *weights)
 {
-	int n, nr, on_list, counted, distance;
-	struct commit_list *p, *best, *next, *last;
-	int *weights;
-
-	show_list("bisection 2 entry", 0, 0, list);
-
-	/*
-	 * Count the number of total and tree-changing items on the
-	 * list, while reversing the list.
-	 */
-	for (nr = on_list = 0, last = NULL, p = list;
-	     p;
-	     p = next) {
-		unsigned flags = p->item->object.flags;
+	int n, counted, distance;
+	struct commit_list *p, *best;
 
-		next = p->next;
-		if (flags & UNINTERESTING)
-			continue;
-		p->next = last;
-		last = p;
-		if (!revs.prune_fn || (flags & TREECHANGE))
-			nr++;
-		on_list++;
-	}
-	list = last;
-	show_list("bisection 2 sorted", 0, nr, list);
-
-	*all = nr;
-	weights = xcalloc(on_list, sizeof(*weights));
 	counted = 0;
 
 	for (n = 0, p = list; p; p = p->next) {
@@ -357,12 +330,8 @@ static struct commit_list *find_bisection(struct commit_list *list,
 		weight_set(p, distance);
 
 		/* Does it happen to be at exactly half-way? */
-		if (halfway(p, distance, nr)) {
-			p->next = NULL;
-			*reaches = distance;
-			free(weights);
+		if (halfway(p, distance, nr))
 			return p;
-		}
 		counted++;
 	}
 
@@ -400,12 +369,8 @@ static struct commit_list *find_bisection(struct commit_list *list,
 
 			/* Does it happen to be at exactly half-way? */
 			distance = weight(p);
-			if (halfway(p, distance, nr)) {
-				p->next = NULL;
-				*reaches = distance;
-				free(weights);
+			if (halfway(p, distance, nr))
 				return p;
-			}
 		}
 	}
 
@@ -425,12 +390,53 @@ static struct commit_list *find_bisection(struct commit_list *list,
 		if (distance > counted) {
 			best = p;
 			counted = distance;
-			*reaches = weight(p);
 		}
 	}
+	return best;
+}
+
+static struct commit_list *find_bisection(struct commit_list *list,
+					  int *reaches, int *all)
+{
+	int nr, on_list;
+	struct commit_list *p, *best, *next, *last;
+	int *weights;
+
+	show_list("bisection 2 entry", 0, 0, list);
+
+	/*
+	 * Count the number of total and tree-changing items on the
+	 * list, while reversing the list.
+	 */
+	for (nr = on_list = 0, last = NULL, p = list;
+	     p;
+	     p = next) {
+		unsigned flags = p->item->object.flags;
+
+		next = p->next;
+		if (flags & UNINTERESTING)
+			continue;
+		p->next = last;
+		last = p;
+		if (!revs.prune_fn || (flags & TREECHANGE))
+			nr++;
+		on_list++;
+	}
+	list = last;
+	show_list("bisection 2 sorted", 0, nr, list);
+
+	*all = nr;
+	weights = xcalloc(on_list, sizeof(*weights));
+
+	/* Do the real work of finding bisection commit. */
+	best = do_find_bisection(list, nr, weights);
+
 	if (best)
 		best->next = NULL;
+
+	*reaches = weight(best);
 	free(weights);
+
 	return best;
 }
 
-- 
1.5.3.1.59.g93705
