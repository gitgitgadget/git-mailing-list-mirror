From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 5/8] log -L: support parent rewriting
Date: Tue, 14 Dec 2010 03:03:28 +0100
Message-ID: <ee0b1de110713e457c2cc7d87405e6cfdfa885ea.1292291624.git.trast@student.ethz.ch>
References: <cover.1292291624.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bo Yang <struggleyb.nku@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 03:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSKFY-0008W1-KJ
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 03:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759060Ab0LNCDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 21:03:44 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:54357 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759007Ab0LNCDh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 21:03:37 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:30 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:32 +0100
X-Mailer: git-send-email 1.7.3.3.797.g7a32f
In-Reply-To: <cover.1292291624.git.trast@student.ethz.ch>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163618>

From: Bo Yang <struggleyb.nku@gmail.com>

Walking forward through history (i.e., topologically earliest
commits first), we filter the parent list of every commit as
follows. Consider a parent P:
 - If P touches any of the interesting line ranges, we keep it.
 - If P is a merge and it takes all the interesting line ranges
   from one of its parents, P is rewritten to this parent, else
   we keep P.
 - Otherwise, P is rewritten to its (only) parent P^.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 line.c                            |  209 +++++++++++++++++++++++++++++++------
 revision.c                        |    1 +
 revision.h                        |    5 +-
 t/t4302-log-line-merge-history.sh |  174 ++++++++++++++++++++++++++++++
 4 files changed, 357 insertions(+), 32 deletions(-)
 create mode 100755 t/t4302-log-line-merge-history.sh

diff --git a/line.c b/line.c
index fe7609c..e766607 100644
--- a/line.c
+++ b/line.c
@@ -10,6 +10,7 @@
 #include "xdiff-interface.h"
 #include "strbuf.h"
 #include "log-tree.h"
+#include "graph.h"
 #include "line.h"
 
 struct print_range {
@@ -33,12 +34,6 @@ struct line_range {
 };
 
 /*
- * Eek-a-global
- */
-
-static int limited;
-
-/*
  * These could be in line.h but we put them here so the functions can
  * be static.
  */
@@ -596,14 +591,14 @@ static void add_line_range(struct rev_info *revs, struct commit *commit,
 {
 	struct diff_line_range *ret = NULL;
 
-	if (r) {
-		ret = lookup_decoration(&revs->line_range, &commit->object);
-		if (ret)
-			diff_line_range_merge(ret, r);
-		else
-			add_decoration(&revs->line_range, &commit->object, r);
+	ret = lookup_decoration(&revs->line_range, &commit->object);
+	if (ret && r)
+		diff_line_range_merge(ret, r);
+	else
+		add_decoration(&revs->line_range, &commit->object, r);
+
+	if (r)
 		commit->object.flags |= RANGE_UPDATE;
-	}
 }
 
 static void clear_commit_line_range(struct rev_info *revs, struct commit *commit)
@@ -687,6 +682,22 @@ void map_lines(long p_start, long p_end, long t_start, long t_end,
 		return;
 	}
 
+	if (start == t_start) {
+		*o_start = p_start;
+		*o_end = p_start + (end - start);
+		if (*o_end > p_end)
+			*o_end = p_end;
+		return;
+	}
+
+	if (end == t_end) {
+		*o_start = p_end - (end - start);
+		if (*o_start < p_start)
+			*o_start = p_start;
+		*o_end = p_end;
+		return;
+	}
+
 	/*
 	 * A heuristic for lines mapping:
 	 *
@@ -920,7 +931,7 @@ static void load_tree_desc(struct tree_desc *desc, void **tree,
  * to parents.
  * map_range_cb and map_range are used to map line ranges to the parent.
  */
-static void assign_range_to_parent(struct rev_info *rev, struct commit *commit,
+static int assign_range_to_parent(struct rev_info *rev, struct commit *commit,
 		struct commit *parent, struct diff_line_range *range,
 		struct diff_options *opt, int map)
 {
@@ -1065,10 +1076,22 @@ static void assign_range_to_parent(struct rev_info *rev, struct commit *commit,
 			prev_range->next = NULL;
 	}
 
+	if (!map)
+		goto out;
+
 	if (final_range) {
 		assert(parent);
 		assert(final_range->spec);
 		add_line_range(rev, parent, final_range);
+	} else {
+		/*
+		 * If there is no new ranges assigned to the parent,
+		 * we should mark it as a 'root' commit.
+		 */
+		if (commit->parents && !commit->parents->next) {
+			free(commit->parents);
+			commit->parents = NULL;
+		}
 	}
 
 	/* and the ranges of current commit is updated */
@@ -1076,10 +1099,13 @@ static void assign_range_to_parent(struct rev_info *rev, struct commit *commit,
 	if (diff)
 		commit->object.flags |= NEED_PRINT;
 
+out:
 	if (tree1)
 		free(tree1);
 	if (tree2)
 		free(tree2);
+
+	return diff;
 }
 
 static void diff_update_parent_range(struct rev_info *rev,
@@ -1096,13 +1122,21 @@ static void diff_update_parent_range(struct rev_info *rev,
 	assign_range_to_parent(rev, commit, c, r, &rev->diffopt, 1);
 }
 
+struct commit_state {
+	struct diff_line_range *range;
+	struct object obj;
+};
+
 static void assign_parents_range(struct rev_info *rev, struct commit *commit)
 {
 	struct commit_list *parents = commit->parents;
 	struct diff_line_range *r = lookup_line_range(rev, commit);
 	struct diff_line_range *evil = NULL, *range = NULL;
+	struct decoration parents_state;
+	struct commit_state *state = NULL;
 	int nontrivial = 0;
 
+	memset(&parents_state, 0, sizeof(parents_state));
 	/*
 	 * If we are in linear history, update range and flush the patch if
 	 * necessary
@@ -1119,23 +1153,76 @@ static void assign_parents_range(struct rev_info *rev, struct commit *commit)
 	parents = commit->parents;
 	while (parents) {
 		struct commit *p = parents->item;
-		assign_range_to_parent(rev, commit, p, r, &rev->diffopt, 1);
+		int diff = 0;
+		struct diff_line_range *origin_range = lookup_line_range(rev, p);
+		if (origin_range)
+			origin_range = diff_line_range_clone_deeply(origin_range);
+
+		state = xmalloc(sizeof(*state));
+		state->range = origin_range;
+		state->obj = p->object;
+		add_decoration(&parents_state, &p->object, state);
+		diff = assign_range_to_parent(rev, commit, p, r, &rev->diffopt, 1);
+		/* Since all the ranges comes from this parent, we can ignore others */
+		if (diff == 0) {
+			/* restore the state of parents before this one */
+			parents = commit->parents;
+			while (parents->item != p) {
+				struct commit_list *list = parents;
+				parents = parents->next;
+				clear_commit_line_range(rev, list->item);
+				state = lookup_decoration(&parents_state, &list->item->object);
+				add_decoration(&parents_state, &list->item->object, NULL);
+				add_line_range(rev, list->item, state->range);
+				list->item->object = state->obj;
+				free(state);
+				free(list);
+			}
+
+			commit->parents = parents;
+			parents = parents->next;
+			commit->parents->next = NULL;
+
+			/* free the non-use commit_list */
+			while (parents) {
+				struct commit_list *list = parents;
+				parents = parents->next;
+				free(list);
+			}
+			goto out;
+		}
+		/* take the ranges from 'commit', try to detect nontrivial merge */
 		assign_range_to_parent(rev, commit, p, evil, &rev->diffopt, 0);
 		parents = parents->next;
 	}
 
+	commit->object.flags |= NONTRIVIAL_MERGE;
 	/*
 	 * yes, this must be an evil merge.
 	 */
 	range = evil;
 	while (range) {
 		if (range->nr) {
-			commit->object.flags |= NEED_PRINT | EVIL_MERGE;
+			commit->object.flags |= EVIL_MERGE;
 			nontrivial = 1;
 		}
 		range = range->next;
 	}
 
+out:
+	/* Never print out any diff for a merge commit */
+	commit->object.flags &= ~NEED_PRINT;
+
+	parents = commit->parents;
+	while (parents) {
+		state = lookup_decoration(&parents_state, &parents->item->object);
+		if (state) {
+			free_diff_line_ranges(state->range);
+			free(state);
+		}
+		parents = parents->next;
+	}
+
 	if (nontrivial)
 		add_decoration(&rev->nontrivial_merge, &commit->object, evil);
 	else
@@ -1327,16 +1414,36 @@ static void flush_nontrivial_merge(struct rev_info *rev,
 	const char *frag = diff_get_color_opt(opt, DIFF_FRAGINFO);
 	const char *meta = diff_get_color_opt(opt, DIFF_METAINFO);
 	const char *new = diff_get_color_opt(opt, DIFF_FILE_NEW);
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
+	int evil = 0;
+	struct diff_line_range *r = range;
+
+	if (opt && opt->output_prefix) {
+		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
 
-	fprintf(opt->file, "%s%s%s\n", meta, "nontrivial merge found", reset);
+	while (r) {
+		if (r->nr)
+			evil = 1;
+		r = r->next;
+	}
+
+	if (!evil)
+		return;
+
+	fprintf(opt->file, "%s%s%s%s\n", line_prefix, meta,
+		"nontrivial merge found", reset);
 
 	while (range) {
 		if (range->nr) {
 			int lno = 1;
 			const char *ptr = range->spec->data;
-			const char *end = range->spec->data + range->spec->size;
+			const char *end = (const char *)range->spec->data + range->spec->size;
 			int i = 0;
-			fprintf(opt->file, "%s%s%s\n\n", meta, range->spec->path, reset);
+			fprintf(opt->file, "%s%s%s%s\n", line_prefix,
+				meta, range->spec->path, reset);
 			for (; i < range->nr; i++) {
 				struct line_range *r = range->ranges + i;
 				fprintf(opt->file, "%s@@ %ld,%ld @@%s\n", frag, r->start,
@@ -1353,12 +1460,17 @@ static void flush_nontrivial_merge(struct rev_info *rev,
 static void line_log_flush(struct rev_info *rev, struct commit *c)
 {
 	struct diff_line_range *range = lookup_line_range(rev, c);
-	struct diff_line_range *nontrivial = lookup_decoration(&rev->nontrivial_merge, &c->object);
+	struct diff_line_range *nontrivial = lookup_decoration(&rev->nontrivial_merge,
+							&c->object);
 	struct log_info log;
+	struct diff_options *opt = &rev->diffopt;
 
-	if (!range)
+	if (!range || !(c->object.flags & NONTRIVIAL_MERGE ||
+			c->object.flags & NEED_PRINT))
 		return;
 
+	if (rev->graph)
+		graph_update(rev->graph, c);
 	log.commit = c;
 	log.parent = NULL;
 	rev->loginfo = &log;
@@ -1370,13 +1482,42 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 	 */
 	fprintf(rev->diffopt.file, "\n");
 
-	if (c->object.flags & EVIL_MERGE)
-		return flush_nontrivial_merge(rev, nontrivial);
+	if (c->object.flags & NONTRIVIAL_MERGE)
+		flush_nontrivial_merge(rev, nontrivial);
+	else {
+		while (range) {
+			if (range->diff)
+				diff_flush_filepair(rev, range);
+			range = range->next;
+		}
+	}
 
-	while (range) {
-		if (range->diff)
-			diff_flush_filepair(rev, range);
-		range = range->next;
+	while (rev->graph && !graph_is_commit_finished(rev->graph)) {
+		struct strbuf sb;
+		strbuf_init(&sb, 0);
+		graph_next_line(rev->graph, &sb);
+		fputs(sb.buf, opt->file);
+	}
+}
+
+static enum rewrite_result rewrite_one(struct rev_info *rev, struct commit **pp)
+{
+	struct diff_line_range *r = NULL;
+	struct commit *p;
+	while (1) {
+		p = *pp;
+		if (p->object.flags & RANGE_UPDATE)
+			assign_parents_range(rev, p);
+		if (p->object.flags & NEED_PRINT ||
+		    p->object.flags & NONTRIVIAL_MERGE)
+			return rewrite_one_ok;
+		if (!p->parents)
+			return rewrite_one_noparents;
+
+		r = lookup_line_range(rev, p);
+		if (!r)
+			return rewrite_one_noparents;
+		*pp = p->parents->item;
 	}
 }
 
@@ -1401,7 +1542,8 @@ int line_log_walk(struct rev_info *rev)
 	}
 	/* Clear the flags */
 	while (list) {
-		list->item->object.flags &= ~(RANGE_UPDATE | EVIL_MERGE | NEED_PRINT);
+		list->item->object.flags &= ~(RANGE_UPDATE | NONTRIVIAL_MERGE |
+						NEED_PRINT | EVIL_MERGE);
 		list = list->next;
 	}
 
@@ -1413,7 +1555,15 @@ int line_log_walk(struct rev_info *rev)
 		if (commit->object.flags & RANGE_UPDATE)
 			assign_parents_range(rev, commit);
 
-		if (commit->object.flags & NEED_PRINT)
+		if (commit->object.flags & NEED_PRINT ||
+		    commit->object.flags & NONTRIVIAL_MERGE) {
+			if (rewrite_parents(rev, commit, rewrite_one))
+				die("Can't rewrite parent for commit %s",
+					sha1_to_hex(commit->object.sha1));
+		}
+
+		if (commit->object.flags & NEED_PRINT ||
+		    commit->object.flags & NONTRIVIAL_MERGE)
 			line_log_flush(rev, commit);
 
 		clear_commit_line_range(rev, commit);
@@ -1431,4 +1581,3 @@ int line_log_walk(struct rev_info *rev)
 
 	return 0;
 }
-
diff --git a/revision.c b/revision.c
index 369ec56..fbebf2f 100644
--- a/revision.c
+++ b/revision.c
@@ -13,6 +13,7 @@
 #include "decorate.h"
 #include "log-tree.h"
 #include "string-list.h"
+#include "line.h"
 
 volatile show_early_output_fn_t show_early_output;
 
diff --git a/revision.h b/revision.h
index 585b15f..6100904 100644
--- a/revision.h
+++ b/revision.h
@@ -16,8 +16,9 @@
 #define SYMMETRIC_LEFT	(1u<<8)
 #define RANGE_UPDATE	(1u<<9) /* for line level traverse */
 #define NEED_PRINT	(1u<<10)
-#define EVIL_MERGE	(1u<<11)
-#define ALL_REV_FLAGS	((1u<<12)-1)
+#define NONTRIVIAL_MERGE	(1u<<11)
+#define EVIL_MERGE	(1u<<12)
+#define ALL_REV_FLAGS	((1u<<13)-1)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
diff --git a/t/t4302-log-line-merge-history.sh b/t/t4302-log-line-merge-history.sh
new file mode 100755
index 0000000..0c086e0
--- /dev/null
+++ b/t/t4302-log-line-merge-history.sh
@@ -0,0 +1,174 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test git log -L with merge commit'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+cat >path0 <<\EOF
+void func()
+{
+	printf("hello");
+}
+EOF
+
+test_expect_success 'Add path0 and commit.' '
+	git add path0 &&
+	git commit -m "Base commit"
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	printf("hello earth");
+}
+EOF
+
+test_expect_success 'Change path0 in master.' '
+	git add path0 &&
+	git commit -m "Change path0 in master"
+'
+
+test_expect_success 'Make a new branch from the base commit' '
+	git checkout -b feature master^
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	print("hello moon");
+}
+EOF
+
+test_expect_success 'Change path0 in feature.' '
+	git add path0 &&
+	git commit -m "Change path0 in feature"
+'
+
+test_expect_success 'Merge the master to feature' '
+	! git merge master
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	printf("hello earth and moon");
+}
+EOF
+
+test_expect_success 'Resolve the conflict' '
+	git add path0 &&
+	git commit -m "Merge two branches"
+'
+
+test_expect_success 'Show the line level log of path0' '
+	git log --pretty=format:%s%n%b -L /func/,/^}/:path0 > current
+'
+
+cat >expected <<\EOF
+Merge two branches
+
+nontrivial merge found
+path0
+@@ 3,1 @@
+ 	printf("hello earth and moon");
+
+
+Change path0 in master
+
+diff --git a/path0 b/path0
+index 56aeee5..11e66c5 100644
+--- a/path0
++++ b/path0
+@@ -1,4 +1,4 @@
+ void func()
+ {
+-	printf("hello");
++	printf("hello earth");
+ }
+
+Change path0 in feature
+
+diff --git a/path0 b/path0
+index 56aeee5..258fced 100644
+--- a/path0
++++ b/path0
+@@ -1,4 +1,4 @@
+ void func()
+ {
+-	printf("hello");
++	print("hello moon");
+ }
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..56aeee5
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,4 @@
++void func()
++{
++	printf("hello");
++}
+EOF
+
+sed 's/#$//' > expected-graph <<\EOF
+*   Merge two branches
+|\  #
+| | #
+| | nontrivial merge found
+| | path0
+| | @@ 3,1 @@
+| |  	printf("hello earth and moon");
+| | #
+| |   #
+| * Change path0 in master
+| | #
+| | diff --git a/path0 b/path0
+| | index 56aeee5..11e66c5 100644
+| | --- a/path0
+| | +++ b/path0
+| | @@ -3,1 +3,1 @@
+| | -	printf("hello");
+| | +	printf("hello earth");
+| |   #
+* | Change path0 in feature
+|/  #
+|   #
+|   diff --git a/path0 b/path0
+|   index 56aeee5..258fced 100644
+|   --- a/path0
+|   +++ b/path0
+|   @@ -3,1 +3,1 @@
+|   -	printf("hello");
+|   +	print("hello moon");
+|  #
+* Base commit
+  #
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..56aeee5
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +3,1 @@
+  +	printf("hello");
+EOF
+
+test_expect_success 'Show the line log of the 2 line of path0 with graph' '
+	git log --pretty=format:%s%n%b --graph -L 3,+1:path0 > current-graph
+'
+
+test_expect_success 'validate the output.' '
+	test_cmp current expected
+'
+
+test_expect_success 'validate the graph output.' '
+	test_cmp current-graph expected-graph
+'
+
+test_done
-- 
1.7.3.3.811.g76615
