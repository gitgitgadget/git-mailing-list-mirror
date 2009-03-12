From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/7] rev-list: move bisect related code into its own file
Date: Thu, 12 Mar 2009 08:51:17 +0100
Message-ID: <20090312085117.1a48ec1a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 08:54:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhfkj-0007QV-CS
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 08:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbZCLHwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 03:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZCLHwS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 03:52:18 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:33232 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753847AbZCLHwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 03:52:15 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 667EF4C812B;
	Thu, 12 Mar 2009 08:52:04 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with SMTP id 18DED4C8034;
	Thu, 12 Mar 2009 08:52:02 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113014>

This patch creates new "bisect.c" and "bisect.h" files and move
bisect related code into these files.

While at it, we also remove some include directives that are not
needed any more from the beginning of "builtin-rev-list.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile           |    1 +
 bisect.c           |  388 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 bisect.h           |    8 +
 builtin-rev-list.c |  388 +---------------------------------------------------
 4 files changed, 398 insertions(+), 387 deletions(-)
 create mode 100644 bisect.c
 create mode 100644 bisect.h

diff --git a/Makefile b/Makefile
index 0675c43..9500c5e 100644
--- a/Makefile
+++ b/Makefile
@@ -414,6 +414,7 @@ LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
+LIB_OBJS += bisect.o
 LIB_OBJS += blob.o
 LIB_OBJS += branch.o
 LIB_OBJS += bundle.o
diff --git a/bisect.c b/bisect.c
new file mode 100644
index 0000000..27def7d
--- /dev/null
+++ b/bisect.c
@@ -0,0 +1,388 @@
+#include "cache.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+#include "bisect.h"
+
+/* bits #0-15 in revision.h */
+
+#define COUNTED		(1u<<16)
+
+/*
+ * This is a truly stupid algorithm, but it's only
+ * used for bisection, and we just don't care enough.
+ *
+ * We care just barely enough to avoid recursing for
+ * non-merge entries.
+ */
+static int count_distance(struct commit_list *entry)
+{
+	int nr = 0;
+
+	while (entry) {
+		struct commit *commit = entry->item;
+		struct commit_list *p;
+
+		if (commit->object.flags & (UNINTERESTING | COUNTED))
+			break;
+		if (!(commit->object.flags & TREESAME))
+			nr++;
+		commit->object.flags |= COUNTED;
+		p = commit->parents;
+		entry = p;
+		if (p) {
+			p = p->next;
+			while (p) {
+				nr += count_distance(p);
+				p = p->next;
+			}
+		}
+	}
+
+	return nr;
+}
+
+static void clear_distance(struct commit_list *list)
+{
+	while (list) {
+		struct commit *commit = list->item;
+		commit->object.flags &= ~COUNTED;
+		list = list->next;
+	}
+}
+
+#define DEBUG_BISECT 0
+
+static inline int weight(struct commit_list *elem)
+{
+	return *((int*)(elem->item->util));
+}
+
+static inline void weight_set(struct commit_list *elem, int weight)
+{
+	*((int*)(elem->item->util)) = weight;
+}
+
+static int count_interesting_parents(struct commit *commit)
+{
+	struct commit_list *p;
+	int count;
+
+	for (count = 0, p = commit->parents; p; p = p->next) {
+		if (p->item->object.flags & UNINTERESTING)
+			continue;
+		count++;
+	}
+	return count;
+}
+
+static inline int halfway(struct commit_list *p, int nr)
+{
+	/*
+	 * Don't short-cut something we are not going to return!
+	 */
+	if (p->item->object.flags & TREESAME)
+		return 0;
+	if (DEBUG_BISECT)
+		return 0;
+	/*
+	 * 2 and 3 are halfway of 5.
+	 * 3 is halfway of 6 but 2 and 4 are not.
+	 */
+	switch (2 * weight(p) - nr) {
+	case -1: case 0: case 1:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+#if !DEBUG_BISECT
+#define show_list(a,b,c,d) do { ; } while (0)
+#else
+static void show_list(const char *debug, int counted, int nr,
+		      struct commit_list *list)
+{
+	struct commit_list *p;
+
+	fprintf(stderr, "%s (%d/%d)\n", debug, counted, nr);
+
+	for (p = list; p; p = p->next) {
+		struct commit_list *pp;
+		struct commit *commit = p->item;
+		unsigned flags = commit->object.flags;
+		enum object_type type;
+		unsigned long size;
+		char *buf = read_sha1_file(commit->object.sha1, &type, &size);
+		char *ep, *sp;
+
+		fprintf(stderr, "%c%c%c ",
+			(flags & TREESAME) ? ' ' : 'T',
+			(flags & UNINTERESTING) ? 'U' : ' ',
+			(flags & COUNTED) ? 'C' : ' ');
+		if (commit->util)
+			fprintf(stderr, "%3d", weight(p));
+		else
+			fprintf(stderr, "---");
+		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.sha1));
+		for (pp = commit->parents; pp; pp = pp->next)
+			fprintf(stderr, " %.*s", 8,
+				sha1_to_hex(pp->item->object.sha1));
+
+		sp = strstr(buf, "\n\n");
+		if (sp) {
+			sp += 2;
+			for (ep = sp; *ep && *ep != '\n'; ep++)
+				;
+			fprintf(stderr, " %.*s", (int)(ep - sp), sp);
+		}
+		fprintf(stderr, "\n");
+	}
+}
+#endif /* DEBUG_BISECT */
+
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
+		if (flags & TREESAME)
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
+struct commit_dist {
+	struct commit *commit;
+	int distance;
+};
+
+static int compare_commit_dist(const void *a_, const void *b_)
+{
+	struct commit_dist *a, *b;
+
+	a = (struct commit_dist *)a_;
+	b = (struct commit_dist *)b_;
+	if (a->distance != b->distance)
+		return b->distance - a->distance; /* desc sort */
+	return hashcmp(a->commit->object.sha1, b->commit->object.sha1);
+}
+
+static struct commit_list *best_bisection_sorted(struct commit_list *list, int nr)
+{
+	struct commit_list *p;
+	struct commit_dist *array = xcalloc(nr, sizeof(*array));
+	int cnt, i;
+
+	for (p = list, cnt = 0; p; p = p->next) {
+		int distance;
+		unsigned flags = p->item->object.flags;
+
+		if (flags & TREESAME)
+			continue;
+		distance = weight(p);
+		if (nr - distance < distance)
+			distance = nr - distance;
+		array[cnt].commit = p->item;
+		array[cnt].distance = distance;
+		cnt++;
+	}
+	qsort(array, cnt, sizeof(*array), compare_commit_dist);
+	for (p = list, i = 0; i < cnt; i++) {
+		struct name_decoration *r = xmalloc(sizeof(*r) + 100);
+		struct object *obj = &(array[i].commit->object);
+
+		sprintf(r->name, "dist=%d", array[i].distance);
+		r->next = add_decoration(&name_decoration, obj, r);
+		p->item = array[i].commit;
+		p = p->next;
+	}
+	if (p)
+		p->next = NULL;
+	free(array);
+	return list;
+}
+
+/*
+ * zero or positive weight is the number of interesting commits it can
+ * reach, including itself.  Especially, weight = 0 means it does not
+ * reach any tree-changing commits (e.g. just above uninteresting one
+ * but traversal is with pathspec).
+ *
+ * weight = -1 means it has one parent and its distance is yet to
+ * be computed.
+ *
+ * weight = -2 means it has more than one parent and its distance is
+ * unknown.  After running count_distance() first, they will get zero
+ * or positive distance.
+ */
+static struct commit_list *do_find_bisection(struct commit_list *list,
+					     int nr, int *weights,
+					     int find_all)
+{
+	int n, counted;
+	struct commit_list *p;
+
+	counted = 0;
+
+	for (n = 0, p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+		unsigned flags = commit->object.flags;
+
+		p->item->util = &weights[n++];
+		switch (count_interesting_parents(commit)) {
+		case 0:
+			if (!(flags & TREESAME)) {
+				weight_set(p, 1);
+				counted++;
+				show_list("bisection 2 count one",
+					  counted, nr, list);
+			}
+			/*
+			 * otherwise, it is known not to reach any
+			 * tree-changing commit and gets weight 0.
+			 */
+			break;
+		case 1:
+			weight_set(p, -1);
+			break;
+		default:
+			weight_set(p, -2);
+			break;
+		}
+	}
+
+	show_list("bisection 2 initialize", counted, nr, list);
+
+	/*
+	 * If you have only one parent in the resulting set
+	 * then you can reach one commit more than that parent
+	 * can reach.  So we do not have to run the expensive
+	 * count_distance() for single strand of pearls.
+	 *
+	 * However, if you have more than one parents, you cannot
+	 * just add their distance and one for yourself, since
+	 * they usually reach the same ancestor and you would
+	 * end up counting them twice that way.
+	 *
+	 * So we will first count distance of merges the usual
+	 * way, and then fill the blanks using cheaper algorithm.
+	 */
+	for (p = list; p; p = p->next) {
+		if (p->item->object.flags & UNINTERESTING)
+			continue;
+		if (weight(p) != -2)
+			continue;
+		weight_set(p, count_distance(p));
+		clear_distance(list);
+
+		/* Does it happen to be at exactly half-way? */
+		if (!find_all && halfway(p, nr))
+			return p;
+		counted++;
+	}
+
+	show_list("bisection 2 count_distance", counted, nr, list);
+
+	while (counted < nr) {
+		for (p = list; p; p = p->next) {
+			struct commit_list *q;
+			unsigned flags = p->item->object.flags;
+
+			if (0 <= weight(p))
+				continue;
+			for (q = p->item->parents; q; q = q->next) {
+				if (q->item->object.flags & UNINTERESTING)
+					continue;
+				if (0 <= weight(q))
+					break;
+			}
+			if (!q)
+				continue;
+
+			/*
+			 * weight for p is unknown but q is known.
+			 * add one for p itself if p is to be counted,
+			 * otherwise inherit it from q directly.
+			 */
+			if (!(flags & TREESAME)) {
+				weight_set(p, weight(q)+1);
+				counted++;
+				show_list("bisection 2 count one",
+					  counted, nr, list);
+			}
+			else
+				weight_set(p, weight(q));
+
+			/* Does it happen to be at exactly half-way? */
+			if (!find_all && halfway(p, nr))
+				return p;
+		}
+	}
+
+	show_list("bisection 2 counted all", counted, nr, list);
+
+	if (!find_all)
+		return best_bisection(list, nr);
+	else
+		return best_bisection_sorted(list, nr);
+}
+
+struct commit_list *find_bisection(struct commit_list *list,
+					  int *reaches, int *all,
+					  int find_all)
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
+		if (!(flags & TREESAME))
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
+	best = do_find_bisection(list, nr, weights, find_all);
+	if (best) {
+		if (!find_all)
+			best->next = NULL;
+		*reaches = weight(best);
+	}
+	free(weights);
+	return best;
+}
+
diff --git a/bisect.h b/bisect.h
new file mode 100644
index 0000000..cce268d
--- /dev/null
+++ b/bisect.h
@@ -0,0 +1,8 @@
+#ifndef BISECT_H
+#define BISECT_H
+
+struct commit_list *find_bisection(struct commit_list *list,
+				   int *reaches, int *all,
+				   int find_all);
+
+#endif
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 28fe2dc..b1e8200 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -1,20 +1,12 @@
 #include "cache.h"
-#include "refs.h"
-#include "tag.h"
 #include "commit.h"
-#include "tree.h"
-#include "blob.h"
-#include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "builtin.h"
 #include "log-tree.h"
 #include "graph.h"
-
-/* bits #0-15 in revision.h */
-
-#define COUNTED		(1u<<16)
+#include "bisect.h"
 
 static const char rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -195,384 +187,6 @@ static void show_edge(struct commit *commit)
 	printf("-%s\n", sha1_to_hex(commit->object.sha1));
 }
 
-/*
- * This is a truly stupid algorithm, but it's only
- * used for bisection, and we just don't care enough.
- *
- * We care just barely enough to avoid recursing for
- * non-merge entries.
- */
-static int count_distance(struct commit_list *entry)
-{
-	int nr = 0;
-
-	while (entry) {
-		struct commit *commit = entry->item;
-		struct commit_list *p;
-
-		if (commit->object.flags & (UNINTERESTING | COUNTED))
-			break;
-		if (!(commit->object.flags & TREESAME))
-			nr++;
-		commit->object.flags |= COUNTED;
-		p = commit->parents;
-		entry = p;
-		if (p) {
-			p = p->next;
-			while (p) {
-				nr += count_distance(p);
-				p = p->next;
-			}
-		}
-	}
-
-	return nr;
-}
-
-static void clear_distance(struct commit_list *list)
-{
-	while (list) {
-		struct commit *commit = list->item;
-		commit->object.flags &= ~COUNTED;
-		list = list->next;
-	}
-}
-
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
-static int count_interesting_parents(struct commit *commit)
-{
-	struct commit_list *p;
-	int count;
-
-	for (count = 0, p = commit->parents; p; p = p->next) {
-		if (p->item->object.flags & UNINTERESTING)
-			continue;
-		count++;
-	}
-	return count;
-}
-
-static inline int halfway(struct commit_list *p, int nr)
-{
-	/*
-	 * Don't short-cut something we are not going to return!
-	 */
-	if (p->item->object.flags & TREESAME)
-		return 0;
-	if (DEBUG_BISECT)
-		return 0;
-	/*
-	 * 2 and 3 are halfway of 5.
-	 * 3 is halfway of 6 but 2 and 4 are not.
-	 */
-	switch (2 * weight(p) - nr) {
-	case -1: case 0: case 1:
-		return 1;
-	default:
-		return 0;
-	}
-}
-
-#if !DEBUG_BISECT
-#define show_list(a,b,c,d) do { ; } while (0)
-#else
-static void show_list(const char *debug, int counted, int nr,
-		      struct commit_list *list)
-{
-	struct commit_list *p;
-
-	fprintf(stderr, "%s (%d/%d)\n", debug, counted, nr);
-
-	for (p = list; p; p = p->next) {
-		struct commit_list *pp;
-		struct commit *commit = p->item;
-		unsigned flags = commit->object.flags;
-		enum object_type type;
-		unsigned long size;
-		char *buf = read_sha1_file(commit->object.sha1, &type, &size);
-		char *ep, *sp;
-
-		fprintf(stderr, "%c%c%c ",
-			(flags & TREESAME) ? ' ' : 'T',
-			(flags & UNINTERESTING) ? 'U' : ' ',
-			(flags & COUNTED) ? 'C' : ' ');
-		if (commit->util)
-			fprintf(stderr, "%3d", weight(p));
-		else
-			fprintf(stderr, "---");
-		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.sha1));
-		for (pp = commit->parents; pp; pp = pp->next)
-			fprintf(stderr, " %.*s", 8,
-				sha1_to_hex(pp->item->object.sha1));
-
-		sp = strstr(buf, "\n\n");
-		if (sp) {
-			sp += 2;
-			for (ep = sp; *ep && *ep != '\n'; ep++)
-				;
-			fprintf(stderr, " %.*s", (int)(ep - sp), sp);
-		}
-		fprintf(stderr, "\n");
-	}
-}
-#endif /* DEBUG_BISECT */
-
-static struct commit_list *best_bisection(struct commit_list *list, int nr)
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
-		distance = weight(p);
-		if (nr - distance < distance)
-			distance = nr - distance;
-		if (distance > best_distance) {
-			best = p;
-			best_distance = distance;
-		}
-	}
-
-	return best;
-}
-
-struct commit_dist {
-	struct commit *commit;
-	int distance;
-};
-
-static int compare_commit_dist(const void *a_, const void *b_)
-{
-	struct commit_dist *a, *b;
-
-	a = (struct commit_dist *)a_;
-	b = (struct commit_dist *)b_;
-	if (a->distance != b->distance)
-		return b->distance - a->distance; /* desc sort */
-	return hashcmp(a->commit->object.sha1, b->commit->object.sha1);
-}
-
-static struct commit_list *best_bisection_sorted(struct commit_list *list, int nr)
-{
-	struct commit_list *p;
-	struct commit_dist *array = xcalloc(nr, sizeof(*array));
-	int cnt, i;
-
-	for (p = list, cnt = 0; p; p = p->next) {
-		int distance;
-		unsigned flags = p->item->object.flags;
-
-		if (flags & TREESAME)
-			continue;
-		distance = weight(p);
-		if (nr - distance < distance)
-			distance = nr - distance;
-		array[cnt].commit = p->item;
-		array[cnt].distance = distance;
-		cnt++;
-	}
-	qsort(array, cnt, sizeof(*array), compare_commit_dist);
-	for (p = list, i = 0; i < cnt; i++) {
-		struct name_decoration *r = xmalloc(sizeof(*r) + 100);
-		struct object *obj = &(array[i].commit->object);
-
-		sprintf(r->name, "dist=%d", array[i].distance);
-		r->next = add_decoration(&name_decoration, obj, r);
-		p->item = array[i].commit;
-		p = p->next;
-	}
-	if (p)
-		p->next = NULL;
-	free(array);
-	return list;
-}
-
-/*
- * zero or positive weight is the number of interesting commits it can
- * reach, including itself.  Especially, weight = 0 means it does not
- * reach any tree-changing commits (e.g. just above uninteresting one
- * but traversal is with pathspec).
- *
- * weight = -1 means it has one parent and its distance is yet to
- * be computed.
- *
- * weight = -2 means it has more than one parent and its distance is
- * unknown.  After running count_distance() first, they will get zero
- * or positive distance.
- */
-static struct commit_list *do_find_bisection(struct commit_list *list,
-					     int nr, int *weights,
-					     int find_all)
-{
-	int n, counted;
-	struct commit_list *p;
-
-	counted = 0;
-
-	for (n = 0, p = list; p; p = p->next) {
-		struct commit *commit = p->item;
-		unsigned flags = commit->object.flags;
-
-		p->item->util = &weights[n++];
-		switch (count_interesting_parents(commit)) {
-		case 0:
-			if (!(flags & TREESAME)) {
-				weight_set(p, 1);
-				counted++;
-				show_list("bisection 2 count one",
-					  counted, nr, list);
-			}
-			/*
-			 * otherwise, it is known not to reach any
-			 * tree-changing commit and gets weight 0.
-			 */
-			break;
-		case 1:
-			weight_set(p, -1);
-			break;
-		default:
-			weight_set(p, -2);
-			break;
-		}
-	}
-
-	show_list("bisection 2 initialize", counted, nr, list);
-
-	/*
-	 * If you have only one parent in the resulting set
-	 * then you can reach one commit more than that parent
-	 * can reach.  So we do not have to run the expensive
-	 * count_distance() for single strand of pearls.
-	 *
-	 * However, if you have more than one parents, you cannot
-	 * just add their distance and one for yourself, since
-	 * they usually reach the same ancestor and you would
-	 * end up counting them twice that way.
-	 *
-	 * So we will first count distance of merges the usual
-	 * way, and then fill the blanks using cheaper algorithm.
-	 */
-	for (p = list; p; p = p->next) {
-		if (p->item->object.flags & UNINTERESTING)
-			continue;
-		if (weight(p) != -2)
-			continue;
-		weight_set(p, count_distance(p));
-		clear_distance(list);
-
-		/* Does it happen to be at exactly half-way? */
-		if (!find_all && halfway(p, nr))
-			return p;
-		counted++;
-	}
-
-	show_list("bisection 2 count_distance", counted, nr, list);
-
-	while (counted < nr) {
-		for (p = list; p; p = p->next) {
-			struct commit_list *q;
-			unsigned flags = p->item->object.flags;
-
-			if (0 <= weight(p))
-				continue;
-			for (q = p->item->parents; q; q = q->next) {
-				if (q->item->object.flags & UNINTERESTING)
-					continue;
-				if (0 <= weight(q))
-					break;
-			}
-			if (!q)
-				continue;
-
-			/*
-			 * weight for p is unknown but q is known.
-			 * add one for p itself if p is to be counted,
-			 * otherwise inherit it from q directly.
-			 */
-			if (!(flags & TREESAME)) {
-				weight_set(p, weight(q)+1);
-				counted++;
-				show_list("bisection 2 count one",
-					  counted, nr, list);
-			}
-			else
-				weight_set(p, weight(q));
-
-			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p, nr))
-				return p;
-		}
-	}
-
-	show_list("bisection 2 counted all", counted, nr, list);
-
-	if (!find_all)
-		return best_bisection(list, nr);
-	else
-		return best_bisection_sorted(list, nr);
-}
-
-static struct commit_list *find_bisection(struct commit_list *list,
-					  int *reaches, int *all,
-					  int find_all)
-{
-	int nr, on_list;
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
-
-		next = p->next;
-		if (flags & UNINTERESTING)
-			continue;
-		p->next = last;
-		last = p;
-		if (!(flags & TREESAME))
-			nr++;
-		on_list++;
-	}
-	list = last;
-	show_list("bisection 2 sorted", 0, nr, list);
-
-	*all = nr;
-	weights = xcalloc(on_list, sizeof(*weights));
-
-	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all);
-	if (best) {
-		if (!find_all)
-			best->next = NULL;
-		*reaches = weight(best);
-	}
-	free(weights);
-	return best;
-}
-
 static inline int log2i(int n)
 {
 	int log2 = 0;
-- 
1.6.2.83.g012a16.dirty
