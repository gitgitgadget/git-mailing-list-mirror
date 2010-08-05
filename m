From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 14/18] Add parent rewriting to line history browser
Date: Fri,  6 Aug 2010 00:11:53 +0800
Message-ID: <1281024717-7855-15-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:14:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh35J-0001XF-Gt
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933638Ab0HEQNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:13:31 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65010 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933629Ab0HEQN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:13:27 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so143837pwj.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hOrv36s6dvf2J9x9Zd1broV0eFycAYVyrQHvCG1HwY8=;
        b=x8HzNW3/j9smZ2RQB1Y7LQj83QZyzY36OUB1FZnPy1AiyF9cpTQ35BgzmEq4teq4+M
         B/BhQHoDorSzv3N1B4QxvsM3hj9hdodivU6EZwxxIxswNxGuefGmRUzOwvwJ7YnNNZYe
         J0kswzS9YHvlDjD2dVcXUffI5MyOCNRHzBjMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wnIC3cky4yxaWKLuwWeP6vLQHsuEczMEbVtgnKQFjquCL0XUEhyTTcoSf49bswv4xH
         4Gi55lq2VXpnCOFb1cjuOYW4hDG7jELi6ci4G5oRwORPGfnB/yDqwBMOhW7dabu+xVGO
         dpcNGZZu9aTK7KqluHOkfYrE6X4rleQ6DTq30=
Received: by 10.142.172.5 with SMTP id u5mr4139442wfe.148.1281024807508;
        Thu, 05 Aug 2010 09:13:27 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.13.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:13:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152680>

Walking forward through history (i.e., topologically earliest
commits first), we filter the parent list of every commit as
follows. Consider a parent P:
 - If P touches any of the interesting line ranges, we keep it.
 - If P is a merge and it takes all the interesting line ranges
   from one of its parents, P is rewritten to this parent, else
   we keep P.
 - Otherwise, P is rewritten to its (only) parent P^.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c     |  286 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 line.h     |    2 +
 revision.c |    3 +
 revision.h |    5 +-
 4 files changed, 269 insertions(+), 27 deletions(-)

diff --git a/line.c b/line.c
index c17659a..2e513da 100644
--- a/line.c
+++ b/line.c
@@ -10,6 +10,9 @@
 #include "xdiff-interface.h"
 #include "strbuf.h"
 #include "log-tree.h"
+#include "graph.h"
+
+static int limited = 0;
 
 static void cleanup(struct diff_line_range *r)
 {
@@ -387,6 +390,7 @@ struct diff_line_range *diff_line_range_clone(struct diff_line_range *r)
 	struct diff_line_range *ret = xmalloc(sizeof(*ret));
 	int i = 0;
 
+	assert(r);
 	DIFF_LINE_RANGE_INIT(ret);
 	ret->ranges = xcalloc(r->nr, sizeof(struct range));
 	memcpy(ret->ranges, r->ranges, sizeof(struct range) * r->nr);
@@ -467,15 +471,15 @@ void add_line_range(struct rev_info *revs, struct commit *commit, struct diff_li
 {
 	struct diff_line_range *ret = NULL;
 
-	if (r != NULL) {
-		ret = lookup_decoration(&revs->line_range, &commit->object);
-		if (ret != NULL) {
-			diff_line_range_merge(ret, r);
-		} else {
-			add_decoration(&revs->line_range, &commit->object, r);
-		}
-		commit->object.flags |= RANGE_UPDATE;
+	ret = lookup_decoration(&revs->line_range, &commit->object);
+	if (ret != NULL && r != NULL) {
+		diff_line_range_merge(ret, r);
+	} else {
+		add_decoration(&revs->line_range, &commit->object, r);
 	}
+
+	if (r != NULL)
+		commit->object.flags |= RANGE_UPDATE;
 }
 
 struct diff_line_range *lookup_line_range(struct rev_info *revs, struct commit *commit)
@@ -541,8 +545,26 @@ void map_lines(long p_start, long p_end, long t_start, long t_end,
 		return;
 	}
 
-	if (start == t_start && end == t_end) {
+	if (start == t_start && end == t_end)
+	{
+		*o_start = p_start;
+		*o_end = p_end;
+		return;
+	}
+
+	if (start == t_start)
+	{
 		*o_start = p_start;
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
 		*o_end = p_end;
 		return;
 	}
@@ -768,7 +790,7 @@ static void map_range_cb(void *data, long same, long p_next, long t_next)
 	d->tlno = t_next;
 }
 
-static void assign_range_to_parent(struct rev_info *rev, struct commit *c,
+static int assign_range_to_parent(struct rev_info *rev, struct commit *c,
 		struct commit *p, struct diff_line_range *r,
 		struct diff_options *opt, int map)
 {
@@ -914,20 +936,56 @@ static void assign_range_to_parent(struct rev_info *rev, struct commit *c,
 		}
 	}
 
+	if (!map)
+		goto out;
+
 	if (rr) {
 		assert(p);
 		add_line_range(rev, p, rr);
+	} else {
+		/*
+		 * If there is no new ranges assigned to the parent,
+		 * we should mark it as a 'root' commit.
+		 */
+		free(c->parents);
+		c->parents = NULL;
+	}
+
+	/* debug output */
+	/*
+	fprintf(stderr, "%8s..%8s:\n", sha1_to_hex(p->object.sha1), sha1_to_hex(c->object.sha1));
+	while (r) {
+		fprintf(stderr, "file: %s\n", r->spec->path);
+		int n = 0;
+		for (; n < r->nr; n++) {
+			fprintf(stderr, "%d-%d, ", r->ranges[n].start, r->ranges[n].end);
+		}
+		r = r->next;
 	}
+	fprintf(stderr, "\n");
+	while (rr) {
+		fprintf(stderr, "file: %s\n", rr->spec->path);
+		int n = 0;
+		for (; n < rr->nr; n++) {
+			fprintf(stderr, "%d-%d, ", rr->ranges[n].start, rr->ranges[n].end);
+		}
+		rr = rr->next;
+	}
+	fprintf(stderr, "\n");
+	*/
 
 	/* and the ranges of current commit c is updated */
 	c->object.flags &= ~RANGE_UPDATE;
 	if (diff)
 		c->object.flags |= NEED_PRINT;
 
+out:
 	if (tree1)
 		free(tree1);
 	if (tree2)
 		free(tree2);
+
+	return diff;
 }
 
 static void diff_update_parent_range(struct rev_info *rev, struct commit *commit)
@@ -943,13 +1001,21 @@ static void diff_update_parent_range(struct rev_info *rev, struct commit *commit
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
 	struct diff_line_range *copy = NULL, *range = NULL;
+	struct decoration parents_state;
+	struct commit_state *state = NULL;
 	int nontrivial = 0;
 
+	memset(&parents_state, 0, sizeof(parents_state));
 	/*
 	 * If we are in linear history, update range and flush the patch if
 	 * necessary
@@ -967,23 +1033,78 @@ static void assign_parents_range(struct rev_info *rev, struct commit *commit)
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
+				struct diff_line_range *line_range = NULL;
+				parents = parents->next;
+				line_range = lookup_line_range(rev, list->item);
+				cleanup(line_range);
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
 		assign_range_to_parent(rev, commit, p, copy, &rev->diffopt, 0);
 		parents = parents->next;
 	}
 
+	commit->object.flags |= NONTRIVIAL_MERGE;
 	/*
 	 * yes, this must be an evil merge.
 	 */
 	range = copy;
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
+			cleanup(state->range);
+			free(state);
+		}
+		parents = parents->next;
+	}
+
 	if (nontrivial) {
 		add_decoration(&rev->nontrivial_merge, &commit->object, copy);
 	} else {
@@ -1179,8 +1300,26 @@ static void flush_nontrivial_merge(struct rev_info *rev, struct diff_line_range
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
+
+	while (r) {
+		if (r->nr)
+			evil = 1;
+		r = r->next;
+	}
+
+	if (!evil)
+		return;
 
-	fprintf(opt->file, "%s%s%s\n", meta, EVIL_MERGE_STR, reset);
+	fprintf(opt->file, "%s%s%s%s\n", line_prefix, meta, EVIL_MERGE_STR, reset);
 
 	while (range) {
 		if (range->nr) {
@@ -1188,7 +1327,8 @@ static void flush_nontrivial_merge(struct rev_info *rev, struct diff_line_range
 			const char *ptr = range->spec->data;
 			const char *end = range->spec->data + range->spec->size;
 			int i = 0;
-			fprintf(opt->file, "%s%s%s\n\n", meta, range->spec->path, reset);
+			fprintf(opt->file, "%s%s%s%s\n", line_prefix,
+				meta, range->spec->path, reset);
 			for (; i < range->nr; i++) {
 				struct range *r = range->ranges + i;
 				fprintf(opt->file, "%s@@ %ld,%ld @@%s\n", frag, r->start,
@@ -1207,10 +1347,14 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 	struct diff_line_range *range = lookup_line_range(rev, c);
 	struct diff_line_range *nontrivial = lookup_decoration(&rev->nontrivial_merge, &c->object);
 	struct log_info log;
+	struct diff_options *opt = &rev->diffopt;
 
-	if (range == NULL)
+	if (range == NULL || ! (c->object.flags & NONTRIVIAL_MERGE ||
+							c->object.flags & NEED_PRINT))
 		return;
 
+	if (rev->graph)
+		graph_update(rev->graph, c);
 	log.commit = c;
 	log.parent = NULL;
 	rev->loginfo = &log;
@@ -1222,13 +1366,22 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
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
+	while (rev->graph && !graph_is_commit_finished(rev->graph))
+	{
+		struct strbuf sb;
+		strbuf_init(&sb, 0);
+		graph_next_line(rev->graph, &sb);
+		fputs(sb.buf, opt->file);
 	}
 }
 
@@ -1242,13 +1395,14 @@ int cmd_line_log_walk(struct rev_info *rev)
 		die("revision walk prepare failed");
 
 	list = rev->commits;
-	if (list) {
+	if (list && !limited) {
 		list->item->object.flags |= RANGE_UPDATE;
 		list = list->next;
 	}
 	/* Clear the flags */
-	while (list) {
-		list->item->object.flags &= ~(RANGE_UPDATE | EVIL_MERGE | NEED_PRINT);
+	while (list && !limited) {
+		list->item->object.flags &= ~(RANGE_UPDATE | NONTRIVIAL_MERGE |
+						NEED_PRINT | EVIL_MERGE);
 		list = list->next;
 	}
 
@@ -1261,7 +1415,8 @@ int cmd_line_log_walk(struct rev_info *rev)
 			assign_parents_range(rev, commit);
 		}
 
-		if (commit->object.flags & NEED_PRINT) {
+		if (commit->object.flags & NEED_PRINT ||
+			commit->object.flags & NONTRIVIAL_MERGE || rev->graph) {
 			line_log_flush(rev, commit);
 		}
 
@@ -1286,3 +1441,84 @@ int cmd_line_log_walk(struct rev_info *rev)
 	return 0;
 }
 
+static enum rewrite_result rewrite_one(struct rev_info *rev, struct commit **pp)
+{
+	struct diff_line_range *r = NULL;
+	struct commit *p;
+	while (1) {
+		p = *pp;
+		if (p->object.flags & RANGE_UPDATE)
+			assign_parents_range(rev, p);
+		if (p->object.flags & NEED_PRINT || p->object.flags & NONTRIVIAL_MERGE)
+			return rewrite_one_ok;
+		if (!p->parents)
+			return rewrite_one_noparents;
+
+		r = lookup_line_range(rev, p);
+		if (!r)
+			return rewrite_one_noparents;
+		*pp = p->parents->item;
+	}
+}
+
+/* The rev->commits must be sorted in topologically order */
+void limit_list_line(struct rev_info *rev)
+{
+	struct commit_list *list = rev->commits;
+	struct commit_list *commits = xmalloc(sizeof(struct commit_list));
+	struct commit_list *out = commits, *prev = commits;
+	struct commit *c;
+	struct diff_line_range *r;
+
+	if (list) {
+		list->item->object.flags |= RANGE_UPDATE;
+		list = list->next;
+	}
+	/* Clear the flags */
+	while (list) {
+		list->item->object.flags &= ~(RANGE_UPDATE | NONTRIVIAL_MERGE |
+						NEED_PRINT | EVIL_MERGE);
+		list = list->next;
+	}
+
+	list = rev->commits;
+	while (list) {
+		c = list->item;
+
+		if (c->object.flags & RANGE_UPDATE)
+			assign_parents_range(rev, c);
+
+		if (c->object.flags & NEED_PRINT || c->object.flags & NONTRIVIAL_MERGE) {
+			if (rewrite_parents(rev, c, rewrite_one))
+				die("Can't rewrite parent for commit %s",
+					sha1_to_hex(c->object.sha1));
+			commits->item = c;
+			commits->next = xmalloc(sizeof(struct commit_list));
+			prev = commits;
+			commits = commits->next;
+		} else {
+			r = lookup_line_range(rev, c);
+			if (r) {
+				cleanup(r);
+				r = NULL;
+				add_line_range(rev, c, r);
+			}
+		}
+
+		list = list->next;
+	}
+
+	prev->next = NULL;
+	free(commits);
+
+	list = rev->commits;
+	while (list) {
+		struct commit_list *l = list;
+		list = list->next;
+		free(l);
+	}
+
+	rev->commits = out;
+	limited = 1;
+}
+
diff --git a/line.h b/line.h
index 3f5c827..a2083ec 100644
--- a/line.h
+++ b/line.h
@@ -136,4 +136,6 @@ const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 
 extern int cmd_line_log_walk(struct rev_info *rev);
 
+extern void limit_list_line(struct rev_info *rev);
+
 #endif
diff --git a/revision.c b/revision.c
index fb08978..a6527ca 100644
--- a/revision.c
+++ b/revision.c
@@ -13,6 +13,7 @@
 #include "decorate.h"
 #include "log-tree.h"
 #include "string-list.h"
+#include "line.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1886,6 +1887,8 @@ int prepare_revision_walk(struct rev_info *revs)
 			return -1;
 	if (revs->topo_order)
 		sort_in_topological_order(&revs->commits, revs->lifo);
+	if (revs->rewrite_parents && revs->line_level_traverse)
+		limit_list_line(revs);
 	if (revs->simplify_merges)
 		simplify_merges(revs);
 	if (revs->children.name)
diff --git a/revision.h b/revision.h
index 48222f6..7f7d178 100644
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
-- 
1.7.2.20.g388bbb
