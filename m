From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 20/21] bisect: compute best bisection in compute_relevant_weights()
Date: Sun, 10 Apr 2016 15:24:51 +0200
Message-ID: <1460294692-7402-1-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:25:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFMn-0002Eq-4W
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbcDJNZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:25:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:49883 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845AbcDJNZK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:25:10 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LbA4j-1bVV7o2ewD-00kg0a; Sun, 10 Apr 2016 15:25:05
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:LX97IFexdZDTQQocsHQ0Mnk8D8ztsLmowQfzNq9h0Y26rrgvBcl
 SpTYomg/X/VF7djk8CkHa6olEjMZrKaxdxU8VbgYbiyFCtSfNMoFQvOGIDOA5ecmEGWurx4
 wX11mcy+ftHWDXSuELXQUJ77u9466TNH3f8RZABpk7mhBt9cldqRo5FnFnFIX9Gmq9UQEOZ
 1hRV0XA6WV74hBdG9VN5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PMNWysbRUqk=:KtqN97hSA7rH9wyOtiIeGL
 3QmuxWgvvUvLgLqkUtlTo1DwHH+yh0JWA57AM1vBj6ZZ9COfGxlqigDAm0l7JTZtrdA6Jg9Y5
 mgpkC6CvGhgH+V6NbPlssnYal0hHy1j+vTQdrfDha9ZzFxBXQwV7hhOPMi8gxZ1/5V1qUYN8z
 FqshZlyMxtKQSE9kFDgv6V8NMQrjTLm2Zxpyk/o5etWjop1UpNkHUY2TlHg11fCYHgqRWJXmt
 4yQl5inD8QH2GL+ftSvCV6gNIW/FNt+muQq+KpyXvOS/SnWnjD8Z2o89r3d6pDsPHauunaSy0
 zJbfplkzXP9TZSS/hdSJSJQYIqpVXRZrxQ0mu6DM2YeMlaQMjidzTkA1N61K7zagEoXn1ZHFb
 SS2P17gr9M94wfuXB1C/Lmbyx3hr1b6Fb0mBoPJ7eX5UZPvpimFwlXtZi05RszSKe6s3zOAs5
 ITx+u/sBOoqbaBgztdVDN3ngJ/+kh33yOrR7aOwmPtekupeha9vT75DgSd5ODgE4Bd+k7IVUb
 K7KpTpc++eOVZZGAxdwbcCD/GmlaQ6sJJLXtEzZHV0Emv6NleKUYlZDS0nbDV4pXRzVXWfk0b
 wP/GVMhk5tmPGR9/Pe6Vr/oYBAXUg5vhOGE7xj4Iv0MePgrQa5qlM6CE8R+0RDG3okn1BT/Z7
 O9ZNEX0kT3WkDmWDAdzuB5GimhhKVTF27OOp/u/F/eng8iRFabx3vwej/CbshVzQ2o8CeG0ZA
 ZLY31aEJgAWAAVKlKZMyFi0HNHlThggPmyVWbsHdCsbm/gGzKYl8TW9ud08=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291167>

This commit gets rid of the O(#commits) extra overhead of
the best_bisection() function.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Notes:
    I made the best_bisection structure be allocated on the heap
    because it will get free()d when the code is invoked by
    git rev-list --bisect ... The old code crashed in this case.

 bisect.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/bisect.c b/bisect.c
index 9487ba9..9f51d73 100644
--- a/bisect.c
+++ b/bisect.c
@@ -27,6 +27,8 @@ static int total;
 
 static unsigned marker;
 
+static struct commit_list *best_bisection;
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
+	 && node_data(commit)->weight > node_data(best_bisection->item)->weight) {
+		best_bisection->item = commit;
+	}
+}
+
 static int compute_weight(struct commit *elem)
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
@@ -402,6 +389,8 @@ static void traversal_up_to_merges(struct commit_list *queue,
 				}
 			}
 		}
+
+		update_best_bisection(top);
 	}
 }
 
@@ -457,8 +446,10 @@ static inline int find_new_queue_from_merges(struct commit_list **queue,
 static inline void compute_merge_weights(struct commit_list *merges)
 {
 	struct commit_list *p;
-	for (p = merges; p; p = p->next)
+	for (p = merges; p; p = p->next) {
 		compute_weight(p->item);
+		update_best_bisection(p->item);
+	}
 }
 
 static void bottom_up_traversal(struct commit_list *queue)
@@ -490,6 +481,9 @@ static void compute_relevant_weights(struct commit_list *list,
 	struct commit_list *p;
 	struct commit_list *sources = build_reversed_dag(list, weights);
 
+	best_bisection = (struct commit_list *)xcalloc(1, sizeof(*best_bisection));
+	best_bisection->item = sources->item;
+
 	for (p = sources; p; p = p->next)
 		node_data(p->item)->weight = 1;
 	bottom_up_traversal(sources);
@@ -543,7 +537,7 @@ struct commit_list *find_bisection(struct commit_list *list,
 	} else {
 		int i;
 		compute_relevant_weights(list, weights);
-		best = best_bisection(list);
+		best = best_bisection;
 		for (i = 0; i < on_list; i++) /* cleanup */
 			free_commit_list(weights[i].children);
 	}
-- 
2.8.1.137.g522756c
