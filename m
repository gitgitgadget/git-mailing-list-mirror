From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] rev-list: implement --bisect-all
Date: Tue, 9 Oct 2007 06:25:11 +0200
Message-ID: <20071009062511.fb6f6222.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 06:18:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If6Xz-0000YC-WC
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 06:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbXJIESJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 00:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbXJIESI
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 00:18:08 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:32775 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbXJIESH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 00:18:07 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id DF0DD1AB2BE;
	Tue,  9 Oct 2007 06:18:02 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 976451AB2BB;
	Tue,  9 Oct 2007 06:18:02 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60352>

This is Junio's patch with some stuff to make --bisect-all
compatible with --bisect-vars.

This option makes it possible to see all the potential
bisection points. The best ones are displayed first.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |  100 ++++++++++++++++++++++++++++++++++++++++++++-------
 log-tree.c         |    2 +-
 log-tree.h         |    1 +
 3 files changed, 88 insertions(+), 15 deletions(-)

	There is a a small change in the second hunk 
	compared to the patch I sent yesterday.

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 33726b8..4439332 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -9,6 +9,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "builtin.h"
+#include "log-tree.h"
 
 /* bits #0-15 in revision.h */
 
@@ -38,7 +39,8 @@ static const char rev_list_usage[] =
 "    --left-right\n"
 "  special purpose:\n"
 "    --bisect\n"
-"    --bisect-vars"
+"    --bisect-vars\n"
+"    --bisect-all"
 ;
 
 static struct rev_info revs;
@@ -74,6 +76,7 @@ static void show_commit(struct commit *commit)
 			parents = parents->next;
 		}
 	}
+	show_decorations(commit);
 	if (revs.commit_format == CMIT_FMT_ONELINE)
 		putchar(' ');
 	else
@@ -278,6 +281,57 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
 	return best;
 }
 
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
+		if (revs.prune_fn && !(flags & TREECHANGE))
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
 /*
  * zero or positive weight is the number of interesting commits it can
  * reach, including itself.  Especially, weight = 0 means it does not
@@ -292,7 +346,8 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
  * or positive distance.
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
-					     int nr, int *weights)
+					     int nr, int *weights,
+					     int find_all)
 {
 	int n, counted;
 	struct commit_list *p;
@@ -351,7 +406,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
-		if (halfway(p, nr))
+		if (!find_all && halfway(p, nr))
 			return p;
 		counted++;
 	}
@@ -389,19 +444,22 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				weight_set(p, weight(q));
 
 			/* Does it happen to be at exactly half-way? */
-			if (halfway(p, nr))
+			if (!find_all && halfway(p, nr))
 				return p;
 		}
 	}
 
 	show_list("bisection 2 counted all", counted, nr, list);
 
-	/* Then find the best one */
-	return best_bisection(list, nr);
+	if (!find_all)
+		return best_bisection(list, nr);
+	else
+		return best_bisection_sorted(list, nr);
 }
 
 static struct commit_list *find_bisection(struct commit_list *list,
-					  int *reaches, int *all)
+					  int *reaches, int *all,
+					  int find_all)
 {
 	int nr, on_list;
 	struct commit_list *p, *best, *next, *last;
@@ -434,14 +492,13 @@ static struct commit_list *find_bisection(struct commit_list *list,
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights);
-
+	best = do_find_bisection(list, nr, weights, find_all);
 	if (best) {
-		best->next = NULL;
+		if (!find_all)
+			best->next = NULL;
 		*reaches = weight(best);
 	}
 	free(weights);
-
 	return best;
 }
 
@@ -468,6 +525,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int i;
 	int read_from_stdin = 0;
 	int bisect_show_vars = 0;
+	int bisect_find_all = 0;
 
 	git_config(git_default_config);
 	init_revisions(&revs, prefix);
@@ -490,6 +548,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			bisect_list = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--bisect-all")) {
+			bisect_list = 1;
+			bisect_find_all = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--bisect-vars")) {
 			bisect_list = 1;
 			bisect_show_vars = 1;
@@ -536,9 +599,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list) {
 		int reaches = reaches, all = all;
 
-		revs.commits = find_bisection(revs.commits, &reaches, &all);
+		revs.commits = find_bisection(revs.commits, &reaches, &all,
+					      bisect_find_all);
 		if (bisect_show_vars) {
 			int cnt;
+			char hex[41];
 			if (!revs.commits)
 				return 1;
 			/*
@@ -550,15 +615,22 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			 * A bisect set of size N has (N-1) commits further
 			 * to test, as we already know one bad one.
 			 */
-			cnt = all-reaches;
+			cnt = all - reaches;
 			if (cnt < reaches)
 				cnt = reaches;
+			strcpy(hex, sha1_to_hex(revs.commits->item->object.sha1));
+
+			if (bisect_find_all) {
+				traverse_commit_list(&revs, show_commit, show_object);
+				printf("------\n");
+			}
+
 			printf("bisect_rev=%s\n"
 			       "bisect_nr=%d\n"
 			       "bisect_good=%d\n"
 			       "bisect_bad=%d\n"
 			       "bisect_all=%d\n",
-			       sha1_to_hex(revs.commits->item->object.sha1),
+			       hex,
 			       cnt - 1,
 			       all - reaches - 1,
 			       reaches - 1,
diff --git a/log-tree.c b/log-tree.c
index 2319154..f766758 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -15,7 +15,7 @@ static void show_parents(struct commit *commit, int abbrev)
 	}
 }
 
-static void show_decorations(struct commit *commit)
+void show_decorations(struct commit *commit)
 {
 	const char *prefix;
 	struct name_decoration *decoration;
diff --git a/log-tree.h b/log-tree.h
index e82b56a..b33f7cd 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -12,5 +12,6 @@ int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 int log_tree_opt_parse(struct rev_info *, const char **, int);
 void show_log(struct rev_info *opt, const char *sep);
+void show_decorations(struct commit *commit);
 
 #endif
-- 
1.5.3.4.209.g5612
