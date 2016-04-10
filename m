From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 16/21] bisect: make total number of commits global
Date: Sun, 10 Apr 2016 15:19:09 +0200
Message-ID: <1460294354-7031-17-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:21:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFId-0000Tk-WA
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbcDJNUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:49390 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbcDJNUV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:21 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MHMRr-1b2BSX1Sqp-00E3u5; Sun, 10 Apr 2016 15:20:06
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:svLlE6EYLIoAznRtOdl4V5Wah3V+TFsmOagcmC9eikQUhWalUF7
 YHhNnUYFtLg/glvjyT6kVeewf8i2WW7UaPe/FhDvgLQ20QxQz6eT2YW+FgUZI0wEkD4qdQw
 xwP1vSeUPOZrvsb9le+sxZcuCJcyPsQuee1RtuYyaTDT3WgxIH9gs5ra+3+np11e0pwMsgt
 zcFesep06irOtcBYoZAIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qyvIRnkjZtY=:s5JlQmp9ggkg29ga5/zM9O
 +v6BhgfK8+AorvkvTTPYB+Xe2EFYbwh7JFsue+k91jIVo2G60QU6svfSQsIY/sC0TWJXye6sD
 yXAelJGMbnhfpDStnrsfZV/ev9T/v5QhoB/2seKvJvGRolnvLaaM/Ky75HCGUNYdJccrfm67V
 6rpw8Efn17V3slI1t9eiG+nd0b3tmaLDwYsZGJ/IlBriw41+Jid7Q2WpqcXWdUe6X18Kedg+d
 I3ttFaagi8WzXoriYowbEb6O0NjIfozMFOkjXls+GoI22Ui0Qe1nZhsxfOrJKYCFT5ba6kgC7
 DhYgdakCO0P82DONQQHK7B6V0NlLnt6zWwMgEfgubPqMJVEqXUA991eZJNU89+5jPnRuDtx3U
 21zF/S3+Zr8AWkJDs9hKGT+Shd8D4BCmdNLPvLKhyLsHfmLaHYHZM5Ov8HXMdOPmGDISPI/OA
 wsJcLYLKwR/vTK1AzxH6vLoCncDgRkMHgDgxgEa6gTNy/ddyzv00Pv5WObIJIgcLXNRAszW3L
 TjZVJQM86YbkHJl+DBrb9rZOr4L91Nmr+qS0/uxEe3OBYR38PjOu2m5Wq/gQo8dthzvqZumnB
 opHhH2ci2Cs6BGgvP0+U+WPHAoBiRM7Fb4MUq+92qxIzMIaCejujiEbbtwe/Lkx94yjiASeZA
 gQzTPMiVlWMbKml9yHcATUE6Yv4Gq773hfUINxTSOtTSZ52YTtr1hpTFYS7FyAOpRcUOPbZ9c
 LzONzL00BnX+nKjPAq+R2ALq/KpqlPmuChSNCahRbVrQvTamLOrloU/6mCQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291156>

The total number of commits in a bisect process is a property of
the bisect process. Making this property global helps to make the code
clearer.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 74 ++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/bisect.c b/bisect.c
index f737ce7..2b415ad 100644
--- a/bisect.c
+++ b/bisect.c
@@ -23,6 +23,8 @@ static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 static const char *term_bad;
 static const char *term_good;
 
+static int total;
+
 static unsigned marker;
 
 struct node_data {
@@ -38,7 +40,7 @@ static inline struct node_data *node_data(struct commit *elem)
 	return (struct node_data *)elem->util;
 }
 
-static inline int get_distance(struct commit *commit, int total)
+static inline int get_distance(struct commit *commit)
 {
 	int distance = node_data(commit)->weight;
 	if (total - distance < distance)
@@ -54,7 +56,7 @@ static inline int get_distance(struct commit *commit, int total)
  * Return 0 if the distance is halfway.
  * Return 1 if the distance is rising.
  */
-static inline int distance_direction(struct commit *commit, int total)
+static inline int distance_direction(struct commit *commit)
 {
 	int doubled_diff = 2 * node_data(commit)->weight - total;
 	if (doubled_diff < -1)
@@ -107,25 +109,25 @@ static int count_interesting_parents(struct commit *commit)
 	return count;
 }
 
-static inline int halfway(struct commit *commit, int nr)
+static inline int halfway(struct commit *commit)
 {
 	/*
 	 * Don't short-cut something we are not going to return!
 	 */
 	if (commit->object.flags & TREESAME)
 		return 0;
-	return !distance_direction(commit, nr);
+	return !distance_direction(commit);
 }
 
 #if !DEBUG_BISECT
-#define show_list(a,b,c,d) do { ; } while (0)
+#define show_list(a,b,c) do { ; } while (0)
 #else
-static void show_list(const char *debug, int counted, int nr,
+static void show_list(const char *debug, int counted,
 		      struct commit_list *list)
 {
 	struct commit_list *p;
 
-	fprintf(stderr, "%s (%d/%d)\n", debug, counted, nr);
+	fprintf(stderr, "%s (%d/%d)\n", debug, counted, total);
 
 	for (p = list; p; p = p->next) {
 		struct commit_list *pp;
@@ -157,7 +159,7 @@ static void show_list(const char *debug, int counted, int nr,
 }
 #endif /* DEBUG_BISECT */
 
-static struct commit_list *best_bisection(struct commit_list *list, int nr)
+static struct commit_list *best_bisection(struct commit_list *list)
 {
 	struct commit_list *p, *best;
 	int best_distance = -1;
@@ -169,7 +171,7 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
 
 		if (flags & TREESAME)
 			continue;
-		distance = get_distance(p->item, nr);
+		distance = get_distance(p->item);
 		if (distance > best_distance) {
 			best = p;
 			best_distance = distance;
@@ -195,10 +197,10 @@ static int compare_commit_dist(const void *a_, const void *b_)
 	return oidcmp(&a->commit->object.oid, &b->commit->object.oid);
 }
 
-static struct commit_list *best_bisection_sorted(struct commit_list *list, int nr)
+static struct commit_list *best_bisection_sorted(struct commit_list *list)
 {
 	struct commit_list *p;
-	struct commit_dist *array = xcalloc(nr, sizeof(*array));
+	struct commit_dist *array = xcalloc(total, sizeof(*array));
 	int cnt, i;
 
 	for (p = list, cnt = 0; p; p = p->next) {
@@ -207,7 +209,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 
 		if (flags & TREESAME)
 			continue;
-		distance = get_distance(p->item, nr);
+		distance = get_distance(p->item);
 		array[cnt].commit = p->item;
 		array[cnt].distance = distance;
 		cnt++;
@@ -243,7 +245,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  * or positive distance.
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
-					     int nr, struct node_data *weights,
+					     struct node_data *weights,
 					     int find_all)
 {
 	int n, counted;
@@ -262,7 +264,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				node_data(commit)->weight = 1;
 				counted++;
 				show_list("bisection 2 count one",
-					  counted, nr, list);
+					  counted, list);
 			}
 			/*
 			 * otherwise, it is known not to reach any
@@ -278,7 +280,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		}
 	}
 
-	show_list("bisection 2 initialize", counted, nr, list);
+	show_list("bisection 2 initialize", counted, list);
 
 	/*
 	 * If you have only one parent in the resulting set
@@ -300,15 +302,15 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			node_data(p->item)->weight = count_distance(p->item);
 
 			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p->item, nr))
+			if (!find_all && halfway(p->item))
 				return p;
 			counted++;
 		}
 	}
 
-	show_list("bisection 2 count_distance", counted, nr, list);
+	show_list("bisection 2 count_distance", counted, list);
 
-	while (counted < nr) {
+	while (counted < total) {
 		for (p = list; p; p = p->next) {
 			struct commit_list *q;
 			unsigned flags = p->item->object.flags;
@@ -334,40 +336,41 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				node_data(p->item)->weight++;
 				counted++;
 				show_list("bisection 2 count one",
-					  counted, nr, list);
+					  counted, list);
 			}
 
 			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p->item, nr))
+			if (!find_all && halfway(p->item))
 				return p;
 		}
 	}
 
-	show_list("bisection 2 counted all", counted, nr, list);
+	show_list("bisection 2 counted all", counted, list);
 
 	if (!find_all)
-		return best_bisection(list, nr);
+		return best_bisection(list);
 	else
-		return best_bisection_sorted(list, nr);
+		return best_bisection_sorted(list);
 }
 
 struct commit_list *find_bisection(struct commit_list *list,
 					  int *reaches, int *all,
 					  int find_all)
 {
-	int nr, on_list;
+	int on_list;
 	struct commit_list *p, *best, *next, *last;
 	struct node_data *weights;
 
+	total = 0;
 	marker = 0;
 
-	show_list("bisection 2 entry", 0, 0, list);
+	show_list("bisection 2 entry", 0, list);
 
 	/*
 	 * Count the number of total and tree-changing items on the
 	 * list, while reversing the list.
 	 */
-	for (nr = on_list = 0, last = NULL, p = list;
+	for (on_list = 0, last = NULL, p = list;
 	     p;
 	     p = next) {
 		unsigned flags = p->item->object.flags;
@@ -378,23 +381,24 @@ struct commit_list *find_bisection(struct commit_list *list,
 		p->next = last;
 		last = p;
 		if (!(flags & TREESAME))
-			nr++;
+			total++;
 		on_list++;
 	}
 	list = last;
-	show_list("bisection 2 sorted", 0, nr, list);
+	show_list("bisection 2 sorted", 0, list);
 
-	*all = nr;
+	*all = total;
 	weights = (struct node_data *)xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all);
+	best = do_find_bisection(list, weights, find_all);
 	if (best) {
 		if (!find_all)
 			best->next = NULL;
 		*reaches = node_data(best->item)->weight;
 	}
 	free(weights);
+
 	return best;
 }
 
@@ -931,7 +935,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
-	int reaches = 0, all = 0, nr, steps;
+	int reaches = 0, nr, steps;
 	const unsigned char *bisect_rev;
 
 	read_bisect_terms(&term_bad, &term_good);
@@ -945,7 +949,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	bisect_common(&revs);
 
-	revs.commits = find_bisection(revs.commits, &reaches, &all,
+	revs.commits = find_bisection(revs.commits, &reaches, &total,
 				       !!skipped_revs.nr);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
@@ -963,7 +967,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		exit(1);
 	}
 
-	if (!all) {
+	if (!total) {
 		fprintf(stderr, "No testable commit found.\n"
 			"Maybe you started with bad path parameters?\n");
 		exit(4);
@@ -982,8 +986,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	free_commit_list(revs.commits);
 
-	nr = all - reaches - 1;
-	steps = estimate_bisect_steps(all);
+	nr = total - reaches - 1;
+	steps = estimate_bisect_steps(total);
 	printf("Bisecting: %d revision%s left to test after this "
 	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
 	       steps, (steps == 1 ? "" : "s"));
-- 
2.8.1.137.g522756c
