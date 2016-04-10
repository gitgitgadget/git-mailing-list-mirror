From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 11/21] bisect: use struct node_data array instead of int array
Date: Sun, 10 Apr 2016 15:19:04 +0200
Message-ID: <1460294354-7031-12-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:20:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFI2-0000Af-Pp
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbcDJNUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:50811 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbcDJNUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:09 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MVJze-1bILxy1LsU-00YlBc; Sun, 10 Apr 2016 15:20:04
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:FdEBQhuWHRiIgMvwSky036kLv57xmULICqSPn8OV4eyCWwV1W6Y
 M4lvHzCNXl12mRndVqW42EmF+VmCi9F6lJlcxf3DO2HtY5fNLeuLKSczEnv7YNgNAqJMFmY
 fHcOSRnIOshcZ9xs07NQWxb8DzQ2yVbjCZ2K8HWQOP+JLt5DsQA26ok5Y/9Ex0mUkZCsxGu
 BFfaL4hfH/sBc4arH5Xfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PVcSnMj5xqE=:4joRCOLTToulqMexZpbMEl
 QdorIkyXlIRU4XLUxOeROX9TUEzr4IGnFdJG7qbZmi9WyS4hO+wL8hLbOh1yzlXiyTFBDapnU
 mXM7TkTOb/Fd3BCvwnCa1KjqpzpCmSaaQaFL6DDFMYOFav4kSDR84UFTB4iyQW+N3WooUvkWL
 olwgtdC5kdqi5ffhhafChmmi0FaOiiiMnRNCkC061F3cQ5uDCbJGgv5/9GCHTgoF7lEJzenKk
 wkTZGe6WAAZUTsnkZIqS9ytPL95irgA6h/5s1t/33du/f0VTkQi0Am33GidXYpEUKXnxYgnMs
 /p+E8meh4qddLe6y/9He05OQVasWnQp2SAmGXTSTww6/7Xad5R8yUC4UmwImm+HDrmfGUanid
 bJ9gIsTcKHom/rCj4AppzgNlIcm6b5ambj5JlNE97F7mLkyZGTZPPPSaRcxbUPA14OS/HQ7qh
 PA7/mOwvrysPl0/QvYfFhZEiCJfsSEockD65gd+QpwUOBD19J5UZ4xSa9QxRUgmNl7I5XS0k6
 eMG0ZrLV4yxYB7ASHBcr5QSCK9CLEGMchwnZeQTUzYmSG2z6JldtTOWJjm1yiQ8XHaqMTTOVu
 Nb5YrihyZphxEgdjvOfX6Um4ogfd8+pxuXu8EEKxxJ07uoVrTrY3YPRUhsWMN9TAxyIYdvKJL
 RFKLYC/Yi2GIUSiFn/YEFuNt581jAEmDncpqGYtv2gcxuYIIzOqb+wKnAvYoiCztOWFS7WOf8
 OSQVEJklfsjnRP8xenOSbe5yg10IVMu6gBdnjkNaygibeRnULEFmAz22sY4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291154>

This is a preparation for subsequent changes.
During a bisection process, we want to augment commits with
further information to improve speed.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 61 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/bisect.c b/bisect.c
index 16bbfa6..bc1bfbd 100644
--- a/bisect.c
+++ b/bisect.c
@@ -23,9 +23,21 @@ static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 static const char *term_bad;
 static const char *term_good;
 
+struct node_data {
+	int weight;
+};
+
 /* Remember to update object flag allocation in object.h */
 #define COUNTED		(1u<<16)
 
+#define DEBUG_BISECT 0
+
+static inline struct node_data *node_data(struct commit *elem)
+{
+	assert(elem->util);
+	return (struct node_data *)elem->util;
+}
+
 static int count_distance(struct commit_list *entry)
 {
 	int nr = 0;
@@ -59,18 +71,6 @@ static void clear_distance(struct commit_list *list)
 	}
 }
 
-#define DEBUG_BISECT 0
-
-static inline int weight(struct commit_list *elem)
-{
-	return *((int*)(elem->item->util));
-}
-
-static inline void weight_set(struct commit_list *elem, int weight)
-{
-	*((int*)(elem->item->util)) = weight;
-}
-
 static int count_interesting_parents(struct commit *commit)
 {
 	struct commit_list *p;
@@ -95,7 +95,7 @@ static inline int halfway(struct commit_list *p, int nr)
 	 * 2 and 3 are halfway of 5.
 	 * 3 is halfway of 6 but 2 and 4 are not.
 	 */
-	switch (2 * weight(p) - nr) {
+	switch (2 * node_data(p->item)->weight - nr) {
 	case -1: case 0: case 1:
 		return 1;
 	default:
@@ -128,7 +128,7 @@ static void show_list(const char *debug, int counted, int nr,
 			(flags & UNINTERESTING) ? 'U' : ' ',
 			(flags & COUNTED) ? 'C' : ' ');
 		if (commit->util)
-			fprintf(stderr, "%3d", weight(p));
+			fprintf(stderr, "%3d", node_data(commit)->weight);
 		else
 			fprintf(stderr, "---");
 		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.oid.hash));
@@ -156,7 +156,7 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
 
 		if (flags & TREESAME)
 			continue;
-		distance = weight(p);
+		distance = node_data(p->item)->weight;
 		if (nr - distance < distance)
 			distance = nr - distance;
 		if (distance > best_distance) {
@@ -196,7 +196,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 
 		if (flags & TREESAME)
 			continue;
-		distance = weight(p);
+		distance = node_data(p->item)->weight;
 		if (nr - distance < distance)
 			distance = nr - distance;
 		array[cnt].commit = p->item;
@@ -234,7 +234,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  * or positive distance.
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
-					     int nr, int *weights,
+					     int nr, struct node_data *weights,
 					     int find_all)
 {
 	int n, counted;
@@ -246,11 +246,11 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		struct commit *commit = p->item;
 		unsigned flags = commit->object.flags;
 
-		p->item->util = &weights[n++];
+		commit->util = &weights[n++];
 		switch (count_interesting_parents(commit)) {
 		case 0:
 			if (!(flags & TREESAME)) {
-				weight_set(p, 1);
+				node_data(commit)->weight = 1;
 				counted++;
 				show_list("bisection 2 count one",
 					  counted, nr, list);
@@ -261,10 +261,10 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			 */
 			break;
 		case 1:
-			weight_set(p, -1);
+			node_data(commit)->weight = -1;
 			break;
 		default:
-			weight_set(p, -2);
+			node_data(commit)->weight = -2;
 			break;
 		}
 	}
@@ -287,8 +287,8 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	 */
 	for (p = list; p; p = p->next) {
 		if (!(p->item->object.flags & UNINTERESTING)
-		 && (weight(p) == -2)) {
-			weight_set(p, count_distance(p));
+		 && (node_data(p->item)->weight == -2)) {
+			node_data(p->item)->weight = count_distance(p);
 			clear_distance(list);
 
 			/* Does it happen to be at exactly half-way? */
@@ -305,12 +305,12 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			struct commit_list *q;
 			unsigned flags = p->item->object.flags;
 
-			if (0 <= weight(p))
+			if (0 <= node_data(p->item)->weight)
 				continue;
 			for (q = p->item->parents; q; q = q->next) {
 				if (q->item->object.flags & UNINTERESTING)
 					continue;
-				if (0 <= weight(q))
+				if (0 <= node_data(q->item)->weight)
 					break;
 			}
 			if (!q)
@@ -321,14 +321,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			 * add one for p itself if p is to be counted,
 			 * otherwise inherit it from q directly.
 			 */
+			node_data(p->item)->weight = node_data(q->item)->weight;
 			if (!(flags & TREESAME)) {
-				weight_set(p, weight(q)+1);
+				node_data(p->item)->weight++;
 				counted++;
 				show_list("bisection 2 count one",
 					  counted, nr, list);
 			}
-			else
-				weight_set(p, weight(q));
 
 			/* Does it happen to be at exactly half-way? */
 			if (!find_all && halfway(p, nr))
@@ -350,7 +349,7 @@ struct commit_list *find_bisection(struct commit_list *list,
 {
 	int nr, on_list;
 	struct commit_list *p, *best, *next, *last;
-	int *weights;
+	struct node_data *weights;
 
 	show_list("bisection 2 entry", 0, 0, list);
 
@@ -376,14 +375,14 @@ struct commit_list *find_bisection(struct commit_list *list,
 	show_list("bisection 2 sorted", 0, nr, list);
 
 	*all = nr;
-	weights = xcalloc(on_list, sizeof(*weights));
+	weights = (struct node_data *)xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
 	best = do_find_bisection(list, nr, weights, find_all);
 	if (best) {
 		if (!find_all)
 			best->next = NULL;
-		*reaches = weight(best);
+		*reaches = node_data(best->item)->weight;
 	}
 	free(weights);
 	return best;
-- 
2.8.1.137.g522756c
