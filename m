From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 12/16] bisect: rename count_distance() to compute_weight()
Date: Fri, 26 Feb 2016 03:04:38 +0100
Message-ID: <1456452282-10325-13-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:06:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7nb-0007k9-8P
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbcBZCGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:06:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:62364 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbcBZCFr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:47 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0M6jIK-1ZlXrx0gHE-00wVxA; Fri, 26 Feb 2016 03:05:45
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:h6FSNn5rgYhiTWQUcDXNnyeFdtNHtY8eBSeSRrsQSKDl48ulXZM
 psO0W73XvR2ZbuihDSRp9BW5fJ+UsxzR3LZeE7K27zliBaT6NBYoAAGaoEGI9YqmMjB7OZ8
 bW5uLmZTyut8HfKPUcjYFw8fHbEkh8X4VpR3X/PsnFDImIp+8HHZFP9ZKv5hOd9e6+0FL/P
 P9t/IG0VcHNmwEX2VMhEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hFd/luIdVDg=:Xc9IV3/IIm0RlNisqHJ406
 rEptf5t8E5b78g1xIutl7FFhz5AxecKFYNSQ4EGxlOAp3xlMfdF703D9M61BTFxBaFe6S8Ba5
 9MZyH2oMOY3uxnw2tJYTidITbkzhFy8jxhD3GsHD9HRrG80oGmGKnEkGo6a4g8r1FORFhQ57A
 xTVxgs0XfZ4tMMBrjvUgc2uCwFOh3D/4WE64VajBDR7rGE1CCuG6zT0P17qwsVgce/Ksm+4cK
 3x3+VTG+4PEp50u+UZ/lA2c7Mkj4el4bL12CyQwz+v73B4BF6XZRK2TtXMRv7pozr8ux3pOxI
 m9+P8RHKfVEgs0zoUgTy90flT2QASmJnTphT9fsEcArerrnSa7MrW+2uml/UB4JymNOZi1xgx
 +uYLXW+kl5Xsbm+/zTOpzgBivtJjlCt2WrJaSOLqHfN0Y2/8Y/ACPuIOMHtUgyHZ1b+Wk0pUr
 6XxslOAQ+pxfXdB7n0B5aOoIudZPb6IzRcF3X5VzRPmuiYxi+v+zpoLMno43dWI8To9CtEPLA
 X7OXnpfrDjfzSoseOWSFIbAJEaHbzAMm+azkWjcGsfAhGZyWlA3nHUDg53ydNX2NEQcikGzcf
 SGeKnHE/u5IUxPPJlhBJ4Jyfv1jbfrwsaJvxo4QYM6MJfrPgi4b3YN3oGNgipyRkvt+FRRyT4
 DHoNy0PMc/bcGHrSS57VfwGt+69XuHpI++oBgA3VbQzbOzKXunnBvt/y3Zj8FoW9VgL/fWXEk
 AzNJ3F3PNbCVUyz8M/dTywzf0kNXKn9PEvBULVyJsnhAfwj05vagBZuFWX4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287526>

Let us use the term "weight" for the number of ancestors
of each commit, and "distance" for the number
min{weight, #commits - weight}. (Bisect finds the commit
with maximum distance.)

In these terms, "count_distance()" is the wrong name of
the function. So it is renamed to "compute_weight()",
and it also directly sets the computed weight.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index 3a3a728..a9387a7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -70,7 +70,7 @@ static inline int distance_direction(struct commit *commit)
 	return 0;
 }
 
-static int count_distance(struct commit *entry)
+static int compute_weight(struct commit *entry)
 {
 	int nr = 0;
 	struct commit_list *todo = NULL;
@@ -93,6 +93,7 @@ static int count_distance(struct commit *entry)
 		}
 	}
 
+	node_data(entry)->weight = nr;
 	return nr;
 }
 
@@ -241,7 +242,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list)
  * be computed.
  *
  * weight = -2 means it has more than one parent and its distance is
- * unknown.  After running count_distance() first, they will get zero
+ * unknown.  After running compute_weight() first, they will get zero
  * or positive distance.
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
@@ -286,7 +287,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	 * If you have only one parent in the resulting set
 	 * then you can reach one commit more than that parent
 	 * can reach.  So we do not have to run the expensive
-	 * count_distance() for single strand of pearls.
+	 * compute_weight() for single strand of pearls.
 	 *
 	 * However, if you have more than one parent, you cannot
 	 * just add their distance and one for yourself, since
@@ -299,7 +300,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	for (p = list; p; p = p->next) {
 		if (!(p->item->object.flags & UNINTERESTING)
 		 && (node_data(p->item)->weight == -2)) {
-			node_data(p->item)->weight = count_distance(p->item);
+			compute_weight(p->item);
 
 			/* Does it happen to be at exactly half-way? */
 			if (!find_all && halfway(p->item))
@@ -308,7 +309,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		}
 	}
 
-	show_list("bisection 2 count_distance", counted, list);
+	show_list("bisection 2 compute_weight", counted, list);
 
 	while (counted < total) {
 		for (p = list; p; p = p->next) {
-- 
2.7.1.354.gd492730.dirty
