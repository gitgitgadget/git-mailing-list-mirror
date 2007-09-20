From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list --bisect: Fix best == NULL case.
Date: Wed, 19 Sep 2007 23:46:33 -0700
Message-ID: <7vmyvhltpy.fsf@gitster.siamese.dyndns.org>
References: <20070920072301.689b96c9.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 08:46:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYFoD-0004Hx-Lq
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 08:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbXITGqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 02:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbXITGqk
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 02:46:40 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbXITGqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 02:46:39 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 36B131352D9;
	Thu, 20 Sep 2007 02:46:57 -0400 (EDT)
In-Reply-To: <20070920072301.689b96c9.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 20 Sep 2007 07:23:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58759>

The patch makes sense.  In fact you can crash any released
version like this:

    $ git rev-list --bisect v1.5.2..v1.5.0

I'll need to apply a moral equivalent to 'maint'.

By the way, you may find the attached patch an interesting food
for thought, on top of your patch.

    $ git rev-list --bisect-all --pretty=oneline v1.5.2.5..v1.5.3.2

---

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 3894633..e4ef172 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -9,6 +9,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "builtin.h"
+#include "log-tree.h"
 
 /* bits #0-15 in revision.h */
 
@@ -74,6 +75,7 @@ static void show_commit(struct commit *commit)
 			parents = parents->next;
 		}
 	}
+	show_decorations(commit);
 	if (revs.commit_format == CMIT_FMT_ONELINE)
 		putchar(' ');
 	else
@@ -278,6 +280,57 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
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
@@ -292,7 +345,8 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
  * or positive distance.
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
-					     int nr, int *weights)
+					     int nr, int *weights,
+					     int find_all)
 {
 	int n, counted;
 	struct commit_list *p;
@@ -351,7 +405,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
-		if (halfway(p, nr))
+		if (!find_all && halfway(p, nr))
 			return p;
 		counted++;
 	}
@@ -389,19 +443,22 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
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
@@ -434,14 +491,12 @@ static struct commit_list *find_bisection(struct commit_list *list,
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights);
-
-	if (best) {
+	best = do_find_bisection(list, nr, weights, find_all);
+	if (!find_all && best) {
 		best->next = NULL;
 		*reaches = weight(best);
 	}
 	free(weights);
-
 	return best;
 }
 
@@ -468,6 +523,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int i;
 	int read_from_stdin = 0;
 	int bisect_show_vars = 0;
+	int bisect_find_all = 0;
 
 	git_config(git_default_config);
 	init_revisions(&revs, prefix);
@@ -490,6 +546,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
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
@@ -536,7 +597,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list) {
 		int reaches = reaches, all = all;
 
-		revs.commits = find_bisection(revs.commits, &reaches, &all);
+		revs.commits = find_bisection(revs.commits, &reaches, &all,
+					      bisect_find_all);
 		if (bisect_show_vars) {
 			int cnt;
 			if (!revs.commits)
diff --git a/log-tree.c b/log-tree.c
index a642371..32e360b 100644
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
