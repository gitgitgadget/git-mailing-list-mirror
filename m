From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 15/16] bisect: compute best bisection in compute_relevant_weights()
Date: Fri, 26 Feb 2016 03:04:41 +0100
Message-ID: <1456452282-10325-16-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:06:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7nK-0007bG-R7
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbcBZCGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:06:00 -0500
Received: from mout.gmx.net ([212.227.15.18]:56069 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbcBZCFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:48 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MKYsh-1aXCe51SyN-001xSd; Fri, 26 Feb 2016 03:05:46
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:jeDJsON97h4yZ2QjHKErUwbOjWRE1CZS2/bryst0Z35Uyrg2wCd
 fWdmVD1KnfdmBQ0JlmW1C6b/t+6GTSd97+WWKjRmgF3Uz3ia8htP81PhNoMbuCP3i3obUJ0
 0eGNez6UG2CL1H7tJo7fUXjgyBU8/+ZQ2pZ5wZ00fxyRxuwJtK4YK+9SGdkVzoaAYdl1XjT
 n2/ydZa8iCWgOTiv/vGfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mfspHD9gxfI=:/GGRuBUnrKh8GrldTjCc3D
 Jo0NFhH5QK9hXPfoiKin5/xdOSLodC5ddw1D8fXjpcqWrpNHokFPHT0Gt28+hFdi/E32Lsvxb
 7rMEjJeqyYSV3eg78hXXG4iWT8HMeQ8Lwj2PkoVRfu2U2H6NJJrYzsKq2pgLuBz1RyG5fkwpY
 6x4GxEBg154rm0mEzsLl03MOhA4OfnF8uXQ/imKpRwULH7XBxbLHNYa85Wo3kX+5k8CQm+YVH
 j2B9dNR5lRmQPTwmLRhkW2bAwFTXj69o9TLifbG9SiOJkaPCA3kKv3+Xi/4quD9DZ0iFiAx2a
 eATUk/v60QQgwCwdjEBFn9IdGMlY51Wea255vfiI7DWlJbTAfj8tGPpcLL5giND50weFbg1M2
 6yW3NHpT3h6CaUkQ2sGv436045eBF6k8DrlFqs3gImDywPJBfbGcXNGIaVqzv/F4FeIakg+va
 kYi3D3HqAzLpUg/MlhTBtgsO3I9rl2KoLQqOJGgIdD9wC0OFV/p+9Y79pfmsySDyb1vkVnT0u
 h4UN6BzxBMlE7uMUQhGMRQX1SAl2EQLNvam4CedtxguhPuAbXPEy8dgq2MAhi4NpKM3EXcCiR
 9M8zrWXmZA5uk4SWxvNMxHu+zDDbYfffXWK6gKzbTSSCDgn1DoxMivEVpiC7afDolsyD5hlVv
 9yNzQGdqTd827mnXPdmK1DECzDdEd2Qd4k2yhT2Bo255H8tck5totBJRCcI9+2cHI2qTKUM3j
 mYYBOx//NThOoh9YtrxP6/kVIBMJ4HEwN/PHBEnC25s3xk4mahLJ2jGUY1k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287522>

This commit gets rid of the O(#commits) extra overhead of
the best_bisection() function.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/bisect.c b/bisect.c
index 827a82a..185a3cf 100644
--- a/bisect.c
+++ b/bisect.c
@@ -27,6 +27,8 @@ static int total;
 
 static unsigned marker;
 
+static struct commit_list best_bisection;
+
 struct node_data {
 	int weight;
 	unsigned marked;
@@ -73,6 +75,14 @@ static inline int distance_direction(struct commit *commit)
 	return 0;
 }
 
+static inline void update_best_bisection(struct commit *commit)
+{
+	if (distance_direction(commit) >= 0
+	 && node_data(commit)->weight > node_data(best_bisection.item)->weight) {
+		best_bisection.item = commit;
+	}
+}
+
 static int compute_weight(struct commit *entry)
 {
 	int nr = 0;
@@ -153,29 +163,6 @@ static void show_list(const char *debug, int counted,
 }
 #endif /* DEBUG_BISECT */
 
-static struct commit_list *best_bisection(struct commit_list *list)
-{
-	struct commit_list *p, *best;
-	int best_distance = -1;
-
-	best = list;
-	for (p = list; p; p = p->next) {
-		int distance;
-		unsigned flags = p->item->object.flags;
-
-		if (flags & TREESAME)
-			continue;
-		distance = get_distance(p->item);
-		if (distance > best_distance) {
-			best = p;
-			best_distance = distance;
-		}
-	}
-
-	best->next = NULL;
-	return best;
-}
-
 struct commit_dist {
 	struct commit *commit;
 	int distance;
@@ -403,6 +390,7 @@ static void bfs_up_to_merges(struct commit_list *queue,
 			}
 		}
 
+		update_best_bisection(top);
 		pop_commit(&queue);
 	}
 }
@@ -459,8 +447,10 @@ static int find_new_queue_from_merges(struct commit_list **queue,
 static void compute_merge_weights(struct commit_list *merges)
 {
 	struct commit_list *p;
-	for (p = merges; p; p = p->next)
+	for (p = merges; p; p = p->next) {
 		compute_weight(p->item);
+		update_best_bisection(p->item);
+	}
 }
 
 static void modified_bfs(struct commit_list *queue)
@@ -489,6 +479,9 @@ static void compute_relevant_weights(struct commit_list *list,
 	struct commit_list *p;
 	struct commit_list *sources = build_reversed_dag(list, weights);
 
+	best_bisection.item = sources->item;
+	best_bisection.next = NULL;
+
 	for (p = sources; p; p = p->next)
 		node_data(p->item)->weight = 1;
 	modified_bfs(sources);
@@ -541,7 +534,7 @@ struct commit_list *find_bisection(struct commit_list *list,
 		best = best_bisection_sorted(list);
 	} else {
 		compute_relevant_weights(list, weights);
-		best = best_bisection(list);
+		best = &best_bisection;
 	}
 	assert(best);
 	*reaches = node_data(best->item)->weight;
-- 
2.7.1.354.gd492730.dirty
