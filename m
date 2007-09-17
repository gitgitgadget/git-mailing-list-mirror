From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] rev-list --bisect: Move some bisection code into
 best_bisection.
Date: Mon, 17 Sep 2007 05:28:29 +0200
Message-ID: <20070917052829.8fa67cf5.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 05:21:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX7At-0001tw-99
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 05:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXIQDVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 23:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbXIQDVW
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 23:21:22 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:58927 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbXIQDVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 23:21:20 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3781A1AB2B9;
	Mon, 17 Sep 2007 05:21:20 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 0A3561AB2B4;
	Mon, 17 Sep 2007 05:21:20 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58379>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |   43 ++++++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 2dae287..8c9635a 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -255,6 +255,30 @@ static void show_list(const char *debug, int counted, int nr,
 }
 #endif /* DEBUG_BISECT */
 
+static struct commit_list *best_bisection(struct commit_list *list, int nr)
+{
+	struct commit_list *p, *best;
+	int best_distance = -1;
+
+	best = list;
+	for (p = list; p; p = p->next) {
+		int distance;
+		unsigned flags = p->item->object.flags;
+
+		if (revs.prune_fn && !(flags & TREECHANGE))
+			continue;
+		distance = weight(p);
+		if (nr - distance < distance)
+			distance = nr - distance;
+		if (distance > best_distance) {
+			best = p;
+			best_distance = distance;
+		}
+	}
+
+	return best;
+}
+
 /*
  * zero or positive weight is the number of interesting commits it can
  * reach, including itself.  Especially, weight = 0 means it does not
@@ -272,7 +296,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights)
 {
 	int n, counted, distance;
-	struct commit_list *p, *best;
+	struct commit_list *p;
 
 	counted = 0;
 
@@ -377,22 +401,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	show_list("bisection 2 counted all", counted, nr, list);
 
 	/* Then find the best one */
-	counted = -1;
-	best = list;
-	for (p = list; p; p = p->next) {
-		unsigned flags = p->item->object.flags;
-
-		if (revs.prune_fn && !(flags & TREECHANGE))
-			continue;
-		distance = weight(p);
-		if (nr - distance < distance)
-			distance = nr - distance;
-		if (distance > counted) {
-			best = p;
-			counted = distance;
-		}
-	}
-	return best;
+	return best_bisection(list, nr);
 }
 
 static struct commit_list *find_bisection(struct commit_list *list,
-- 
1.5.3.1.59.g93705
