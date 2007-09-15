From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] rev-list --bisect: Bisection "distance" clean up.
Date: Sat, 15 Sep 2007 13:00:16 +0200
Message-ID: <20070915130016.eac885f4.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Sep 15 12:53:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWVH1-0003hY-Ac
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 12:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893AbXIOKxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 06:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755860AbXIOKxK
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 06:53:10 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:55329 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755387AbXIOKxI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 06:53:08 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 298C11AB2E4;
	Sat, 15 Sep 2007 12:53:07 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id EE7D91AB2C7;
	Sat, 15 Sep 2007 12:53:06 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58235>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index c2ce1fc..6ade3b7 100644
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
@@ -322,7 +321,7 @@ static struct commit_list *find_bisection(struct commit_list *list,
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights)
 {
-	int n, counted, distance;
+	int n, counted;
 	struct commit_list *p;
 
 	counted = 0;
@@ -373,15 +372,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
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
@@ -419,8 +416,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				weight_set(p, weight(q));
 
 			/* Does it happen to be at exactly half-way? */
-			distance = weight(p);
-			if (halfway(p, distance, nr))
+			if (halfway(p, nr))
 				return p;
 		}
 	}
-- 
1.5.3.1.20.g2a16-dirty
