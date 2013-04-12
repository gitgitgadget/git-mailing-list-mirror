From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 3/4] log -L: store the path instead of a diff_filespec
Date: Fri, 12 Apr 2013 18:05:11 +0200
Message-ID: <c4624ce5d381c62e76939455458ae0033e6d1399.1365781999.git.trast@inf.ethz.ch>
References: <cover.1365781999.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:05:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQgTq-0000ti-97
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab3DLQF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:05:28 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:4869 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753500Ab3DLQFV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 12:05:21 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Apr
 2013 18:05:20 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Apr
 2013 18:05:19 +0200
X-Mailer: git-send-email 1.8.2.1.567.g8ad0f43
In-Reply-To: <cover.1365781999.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220991>

line_log_data has held a diff_filespec* since the very early versions
of the code.  However, the only place in the code where we actually
need the full filespec is parse_range_arg(); in all other cases, we
are only interested in the path, so there is hardly a reason to store
a filespec.  Even worse, it causes a lot of redundant ->spec->path
pointer dereferencing.

And *even* worse, it caused the following bug.  If you merge a rename
with a modification to the old filename, like so:

  * Merge
  | \
  |  * Modify foo
  |  |
  *  | Rename foo->bar
  | /
  * Create foo

we internally -- in process_ranges_merge_commit() -- scan all parents.
We are mainly looking for one that doesn't have any modifications, so
that we can assign all the blame to it and simplify away the merge.
In doing so, we run the normal machinery on all parents in a loop.
For each parent, we prepare a "working set" line_log_data by making a
copy with line_log_data_copy(), which does *not* make a copy of the
spec.

Now suppose the rename is the first parent.  The diff machinery tells
us that the filepair is ('foo', 'bar').  We duly update the path we
are interested in:

  rg->spec->path = xstrdup(pair->one->path);

But that 'struct spec' is shared between the output line_log_data and
the original input line_log_data.  So we just wrecked the state of
process_ranges_merge_commit().  When we get around to the second
parent, the ranges tell us we are interested in a file 'foo' while the
commits touch 'bar'.

So most of this patch is just s/->spec->path/->path/ and associated
management changes.  This implicitly fixes the bug because we removed
the shared parts between input and output of line_log_data_copy(); it
is now safe to overwrite the path in the copy.

There's one only somewhat related change: the comment in
process_all_files() explains the reasoning behind using 'range' there.
That bit of half-correct code had me sidetracked for a while.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 line-log.c          | 45 ++++++++++++++++++++++++---------------------
 line-log.h          |  8 ++++++--
 t/t4211-line-log.sh |  2 +-
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/line-log.c b/line-log.c
index 85c7c24..44d1cd5 100644
--- a/line-log.c
+++ b/line-log.c
@@ -265,7 +265,7 @@ static void free_line_log_data(struct line_log_data *r)
 	if (insertion_point)
 		*insertion_point = NULL;
 	while (p) {
-		int cmp = strcmp(p->spec->path, path);
+		int cmp = strcmp(p->path, path);
 		if (!cmp)
 			return p;
 		if (insertion_point && cmp < 0)
@@ -275,22 +275,26 @@ static void free_line_log_data(struct line_log_data *r)
 	return NULL;
 }
 
+/*
+ * Note: takes ownership of 'path', which happens to be what the only
+ * caller needs.
+ */
 static void line_log_data_insert(struct line_log_data **list,
-				 struct diff_filespec *spec,
+				 char *path,
 				 long begin, long end)
 {
 	struct line_log_data *ip;
-	struct line_log_data *p = search_line_log_data(*list, spec->path, &ip);
+	struct line_log_data *p = search_line_log_data(*list, path, &ip);
 
 	if (p) {
 		range_set_append_unsafe(&p->ranges, begin, end);
 		sort_and_merge_range_set(&p->ranges);
-		free_filespec(spec);
+		free(path);
 		return;
 	}
 
 	p = xcalloc(1, sizeof(struct line_log_data));
-	p->spec = spec;
+	p->path = path;
 	range_set_append(&p->ranges, begin, end);
 	if (ip) {
 		p->next = ip->next;
@@ -354,7 +358,7 @@ static void dump_line_log_data(struct line_log_data *r)
 {
 	char buf[4096];
 	while (r) {
-		snprintf(buf, 4096, "file %s\n", r->spec->path);
+		snprintf(buf, 4096, "file %s\n", r->path);
 		dump_range_set(&r->ranges, buf);
 		r = r->next;
 	}
@@ -561,7 +565,7 @@ static const char *nth_line(void *data, long line)
 
 	for_each_string_list_item(item, args) {
 		const char *name_part, *range_part;
-		const char *full_name;
+		char *full_name;
 		struct diff_filespec *spec;
 		long begin = 0, end = 0;
 
@@ -584,7 +588,7 @@ static const char *nth_line(void *data, long line)
 
 		if (parse_range_arg(range_part, nth_line, &cb_data,
 				    lines, &begin, &end,
-				    spec->path))
+				    full_name))
 			die("malformed -L argument '%s'", range_part);
 		if (begin < 1)
 			begin = 1;
@@ -593,8 +597,9 @@ static const char *nth_line(void *data, long line)
 		begin--;
 		if (lines < end || lines < begin)
 			die("file %s has only %ld lines", name_part, lines);
-		line_log_data_insert(&ranges, spec, begin, end);
+		line_log_data_insert(&ranges, full_name, begin, end);
 
+		free_filespec(spec);
 		free(ends);
 		ends = NULL;
 	}
@@ -610,9 +615,7 @@ static struct line_log_data *line_log_data_copy_one(struct line_log_data *r)
 	line_log_data_init(ret);
 	range_set_copy(&ret->ranges, &r->ranges);
 
-	ret->spec = r->spec;
-	assert(ret->spec);
-	ret->spec->count++;
+	ret->path = xstrdup(r->path);
 
 	return ret;
 }
@@ -652,7 +655,7 @@ static struct line_log_data *line_log_data_merge(struct line_log_data *a,
 		else if (!b)
 			cmp = -1;
 		else
-			cmp = strcmp(a->spec->path, b->spec->path);
+			cmp = strcmp(a->path, b->path);
 		if (cmp < 0) {
 			src = a;
 			a = a->next;
@@ -667,8 +670,7 @@ static struct line_log_data *line_log_data_merge(struct line_log_data *a,
 		}
 		d = xmalloc(sizeof(struct line_log_data));
 		line_log_data_init(d);
-		d->spec = src->spec;
-		d->spec->count++;
+		d->path = xstrdup(src->path);
 		*pp = d;
 		pp = &d->next;
 		if (src2)
@@ -741,7 +743,7 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
 		paths = xmalloc((count+1)*sizeof(char *));
 		r = range;
 		for (i = 0; i < count; i++) {
-			paths[i] = xstrdup(r->spec->path);
+			paths[i] = xstrdup(r->path);
 			r = r->next;
 		}
 		paths[count] = NULL;
@@ -797,7 +799,7 @@ static void filter_diffs_for_paths(struct line_log_data *range, int keep_deletio
 			continue;
 		}
 		for (rg = range; rg; rg = rg->next) {
-			if (!strcmp(rg->spec->path, p->two->path))
+			if (!strcmp(rg->path, p->two->path))
 				break;
 		}
 		if (rg)
@@ -1021,8 +1023,8 @@ static int process_diff_filepair(struct rev_info *rev,
 
 	assert(pair->two->path);
 	while (rg) {
-		assert(rg->spec->path);
-		if (!strcmp(rg->spec->path, pair->two->path))
+		assert(rg->path);
+		if (!strcmp(rg->path, pair->two->path))
 			break;
 		rg = rg->next;
 	}
@@ -1050,7 +1052,8 @@ static int process_diff_filepair(struct rev_info *rev,
 	collect_diff(&file_parent, &file_target, &diff);
 
 	/* NEEDSWORK should apply some heuristics to prevent mismatches */
-	rg->spec->path = xstrdup(pair->one->path);
+	free(rg->path);
+	rg->path = xstrdup(pair->one->path);
 
 	range_set_init(&tmp, 0);
 	range_set_map_across_diff(&tmp, &rg->ranges, &diff, diff_out);
@@ -1096,7 +1099,7 @@ static int process_all_files(struct line_log_data **range_out,
 			struct line_log_data *rg = range;
 			changed++;
 			/* NEEDSWORK tramples over data structures not owned here */
-			while (rg && strcmp(rg->spec->path, queue->queue[i]->two->path))
+			while (rg && strcmp(rg->path, queue->queue[i]->two->path))
 				rg = rg->next;
 			assert(rg);
 			rg->pair = diff_filepair_dup(queue->queue[i]);
diff --git a/line-log.h b/line-log.h
index 9acd123..8bea45f 100644
--- a/line-log.h
+++ b/line-log.h
@@ -26,10 +26,14 @@ struct diff_ranges {
 };
 
 /* Linked list of interesting files and their associated ranges.  The
- * list must be kept sorted by spec->path */
+ * list must be kept sorted by path.
+ *
+ * For simplicity, even though this is highly redundant, each
+ * line_log_data owns its 'path'.
+ */
 struct line_log_data {
 	struct line_log_data *next;
-	struct diff_filespec *spec;
+	char *path;
 	char status;
 	struct range_set ranges;
 	int arg_alloc, arg_nr;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index bba0b09..7776f93 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -45,7 +45,7 @@ canned_test "-L '/long f/',/^}/:a.c -L /main/,/^}/:a.c simple" two-ranges
 canned_test "-L 24,+1:a.c simple" vanishes-early
 
 canned_test "-M -L '/long f/,/^}/:b.c' move-support" move-support-f
-canned_test_failure "-M -L ':f:b.c' parallel-change" parallel-change-f-to-main
+canned_test "-M -L ':f:b.c' parallel-change" parallel-change-f-to-main
 
 canned_test "-L 4,12:a.c -L :main:a.c simple" multiple
 canned_test "-L 4,18:a.c -L :main:a.c simple" multiple-overlapping
-- 
1.8.2.1.567.g8ad0f43
