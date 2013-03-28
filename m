From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v10 3/5] Implement line-history search (git log -L)
Date: Thu, 28 Mar 2013 17:47:32 +0100
Message-ID: <7367be84cefc0084b70160d63c4b77f1c82e1dd6.1364488205.git.trast@inf.ethz.ch>
References: <cover.1364488205.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:48:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULG05-0004bT-By
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab3C1Qrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:47:48 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:14138 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756796Ab3C1Qrk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:47:40 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 17:47:30 +0100
Received: from linux-k42r.v.cablecom.net (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 17:47:36 +0100
X-Mailer: git-send-email 1.8.2.446.g2b4de83
In-Reply-To: <cover.1364488205.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219433>

This is a rewrite of much of Bo's work, mainly in an effort to split
it into smaller, easier to understand routines.

The algorithm is built around the struct range_set, which encodes a
series of line ranges as intervals [a,b).  This is used in two
contexts:

* A set of lines we are tracking (which will change as we dig through
  history).
* To encode diffs, as pairs of ranges.

The main routine is range_set_map_across_diff().  It processes the
diff between a commit C and some parent P.  It determines which diff
hunks are relevant to the ranges tracked in C, and computes the new
ranges for P.

The algorithm is then simply to process history in topological order
from newest to oldest, computing ranges and (partial) diffs.  At
branch points, we need to merge the ranges we are watching.  We will
find that many commits do not affect the chosen ranges, and mark them
TREESAME (in addition to those already filtered by pathspec limiting).
Another pass of history simplification then gets rid of such commits.

This is wired as an extra filtering pass in the log machinery.  This
currently only reduces code duplication, but should allow for other
simplifications and options to be used.

Finally, we hook a diff printer into the output chain.  Ideally we
would wire directly into the diff logic, to optionally use features
like word diff.  However, that will require some major reworking of
the diff chain, so we completely replace the output with our own diff
for now.

As this was a GSoC project, and has quite some history by now, many
people have helped.  In no particular order, thanks go to

  Jakub Narebski <jnareb@gmail.com>
  Jens Lehmann <Jens.Lehmann@web.de>
  Jonathan Nieder <jrnieder@gmail.com>
  Junio C Hamano <gitster@pobox.com>
  Ramsay Jones <ramsay@ramsay1.demon.co.uk>
  Will Palmer <wmpalmer@gmail.com>

Apologies to everyone I forgot.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-log.txt        |   22 +
 Makefile                         |    2 +
 builtin/log.c                    |   31 +
 line-log.c                       | 1179 ++++++++++++++++++++++++++++++++++++++
 line-log.h                       |   49 ++
 line-range.c                     |   19 +-
 line-range.h                     |   11 +
 log-tree.c                       |    4 +
 revision.c                       |    9 +
 revision.h                       |    6 +-
 t/perf/p4211-line-log.sh         |   34 ++
 t/t4211-line-log.sh              |   49 ++
 t/t4211/expect.beginning-of-file |   43 ++
 t/t4211/expect.end-of-file       |   62 ++
 t/t4211/expect.move-support-f    |   40 ++
 t/t4211/expect.simple-f          |   59 ++
 t/t4211/expect.simple-main       |   68 +++
 t/t4211/expect.two-ranges        |  102 ++++
 t/t4211/expect.vanishes-early    |   39 ++
 t/t4211/history.export           |  330 +++++++++++
 20 files changed, 2156 insertions(+), 2 deletions(-)
 create mode 100644 line-log.c
 create mode 100644 line-log.h
 create mode 100755 t/perf/p4211-line-log.sh
 create mode 100755 t/t4211-line-log.sh
 create mode 100644 t/t4211/expect.beginning-of-file
 create mode 100644 t/t4211/expect.end-of-file
 create mode 100644 t/t4211/expect.move-support-f
 create mode 100644 t/t4211/expect.simple-f
 create mode 100644 t/t4211/expect.simple-main
 create mode 100644 t/t4211/expect.two-ranges
 create mode 100644 t/t4211/expect.vanishes-early
 create mode 100644 t/t4211/history.export

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 69db578..8727c60 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -69,6 +69,23 @@ produced by --stat etc.
 	Note that only message is considered, if also a diff is shown
 	its size is not included.
 
+-L <start>,<end>:<file>::
+	Trace the evolution of the line range given by "<start>,<end>"
+	within the <file>.  You may not give any pathspec limiters.
+	This is currently limited to a walk starting from a single
+	revision, i.e., you may only give zero or one positive
+	revision arguments.
+
+<start> and <end> can take one of these forms:
+
+include::line-range-format.txt[]
+You can specify this option more than once.
+
+
+--full-line-diff::
+	Always print the interesting range even if the current commit
+	does not change any line of the range.
+
 [\--] <path>...::
 	Show only commits that are enough to explain how the files
 	that match the specified paths came to be.  See "History
@@ -138,6 +155,11 @@ Examples
 	This makes sense only when following a strict policy of merging all
 	topic branches when staying on a single integration branch.
 
+git log -L '/int main/',/^}/:main.c::
+
+	Shows how the function `main()` in the file 'main.c' evolved
+	over time.
+
 `git log -3`::
 	Limits the number of commits to show to 3.
 
diff --git a/Makefile b/Makefile
index e83f64b..2156fa7 100644
--- a/Makefile
+++ b/Makefile
@@ -667,6 +667,7 @@ LIB_H += help.h
 LIB_H += http.h
 LIB_H += kwset.h
 LIB_H += levenshtein.h
+LIB_H += line-log.h
 LIB_H += line-range.h
 LIB_H += list-objects.h
 LIB_H += ll-merge.h
@@ -796,6 +797,7 @@ LIB_OBJS += hex.o
 LIB_OBJS += ident.o
 LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
+LIB_OBJS += line-log.o
 LIB_OBJS += line-range.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
diff --git a/builtin/log.c b/builtin/log.c
index 8f0b2e8..d584ff1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -19,6 +19,7 @@
 #include "remote.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "line-log.h"
 #include "branch.h"
 #include "streaming.h"
 #include "version.h"
@@ -41,6 +42,12 @@
 	NULL
 };
 
+struct line_opt_callback_data {
+	struct rev_info *rev;
+	const char *prefix;
+	struct string_list args;
+};
+
 static int parse_decoration_style(const char *var, const char *value)
 {
 	switch (git_config_maybe_bool(var, value)) {
@@ -75,6 +82,19 @@ static int decorate_callback(const struct option *opt, const char *arg, int unse
 	return 0;
 }
 
+static int log_line_range_callback(const struct option *option, const char *arg, int unset)
+{
+	struct line_opt_callback_data *data = option->value;
+
+	if (!arg)
+		return -1;
+
+	data->rev->line_level_traverse = 1;
+	string_list_append(&data->args, arg);
+
+	return 0;
+}
+
 static void cmd_log_init_defaults(struct rev_info *rev)
 {
 	if (fmt_pretty)
@@ -97,6 +117,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 {
 	struct userformat_want w;
 	int quiet = 0, source = 0, mailmap = 0;
+	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
 
 	const struct option builtin_log_options[] = {
 		OPT_BOOLEAN(0, "quiet", &quiet, N_("suppress diff output")),
@@ -104,9 +125,15 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT_BOOLEAN(0, "use-mailmap", &mailmap, N_("Use mail map file")),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
 		  PARSE_OPT_OPTARG, decorate_callback},
+		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
+			     "Process line range n,m in file, counting from 1",
+			     log_line_range_callback),
 		OPT_END()
 	};
 
+	line_cb.rev = rev;
+	line_cb.prefix = prefix;
+
 	mailmap = use_mailmap_config;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_log_options, builtin_log_usage,
@@ -160,6 +187,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		rev->show_decorations = 1;
 		load_ref_decorations(decoration_style);
 	}
+
+	if (rev->line_level_traverse)
+		line_log_init(rev, line_cb.prefix, &line_cb.args);
+
 	setup_pager();
 }
 
diff --git a/line-log.c b/line-log.c
new file mode 100644
index 0000000..6244231
--- /dev/null
+++ b/line-log.c
@@ -0,0 +1,1179 @@
+#include "git-compat-util.h"
+#include "line-range.h"
+#include "cache.h"
+#include "tag.h"
+#include "blob.h"
+#include "tree.h"
+#include "diff.h"
+#include "commit.h"
+#include "decorate.h"
+#include "revision.h"
+#include "xdiff-interface.h"
+#include "strbuf.h"
+#include "log-tree.h"
+#include "graph.h"
+#include "line-log.h"
+
+static void range_set_grow(struct range_set *rs, size_t extra)
+{
+	ALLOC_GROW(rs->ranges, rs->nr + extra, rs->alloc);
+}
+
+/* Either initialization would be fine */
+#define RANGE_SET_INIT {0}
+
+static void range_set_init(struct range_set *rs, size_t prealloc)
+{
+	rs->alloc = rs->nr = 0;
+	rs->ranges = NULL;
+	if (prealloc)
+		range_set_grow(rs, prealloc);
+}
+
+static void range_set_release(struct range_set *rs)
+{
+	free(rs->ranges);
+	rs->alloc = rs->nr = 0;
+	rs->ranges = NULL;
+}
+
+/* dst must be uninitialized! */
+static void range_set_copy(struct range_set *dst, struct range_set *src)
+{
+	range_set_init(dst, src->nr);
+	memcpy(dst->ranges, src->ranges, src->nr*sizeof(struct range_set));
+	dst->nr = src->nr;
+}
+static void range_set_move(struct range_set *dst, struct range_set *src)
+{
+	range_set_release(dst);
+	dst->ranges = src->ranges;
+	dst->nr = src->nr;
+	dst->alloc = src->alloc;
+	src->ranges = NULL;
+	src->alloc = src->nr = 0;
+}
+
+/* tack on a _new_ range _at the end_ */
+static void range_set_append(struct range_set *rs, long a, long b)
+{
+	assert(a <= b);
+	assert(rs->nr == 0 || rs->ranges[rs->nr-1].end <= a);
+	range_set_grow(rs, 1);
+	rs->ranges[rs->nr].start = a;
+	rs->ranges[rs->nr].end = b;
+	rs->nr++;
+}
+
+static int range_cmp(const void *_r, const void *_s)
+{
+	const struct range *r = _r;
+	const struct range *s = _s;
+
+	/* this could be simply 'return r.start-s.start', but for the types */
+	if (r->start == s->start)
+		return 0;
+	if (r->start < s->start)
+		return -1;
+	return 1;
+}
+
+/*
+ * Helper: In-place pass of sorting and merging the ranges in the
+ * range set, to re-establish the invariants after another operation
+ *
+ * NEEDSWORK currently not needed
+ */
+static void sort_and_merge_range_set(struct range_set *rs)
+{
+	int i;
+	int o = 1; /* output cursor */
+
+	qsort(rs->ranges, rs->nr, sizeof(struct range), range_cmp);
+
+	for (i = 1; i < rs->nr; i++) {
+		if (rs->ranges[i].start <= rs->ranges[o-1].end) {
+			rs->ranges[o-1].end = rs->ranges[i].end;
+		} else {
+			rs->ranges[o].start = rs->ranges[i].start;
+			rs->ranges[o].end = rs->ranges[i].end;
+			o++;
+		}
+	}
+	assert(o <= rs->nr);
+	rs->nr = o;
+}
+
+/*
+ * Union of range sets (i.e., sets of line numbers).  Used to merge
+ * them when searches meet at a common ancestor.
+ *
+ * This is also where the ranges are consolidated into canonical form:
+ * overlapping and adjacent ranges are merged, and empty ranges are
+ * removed.
+ */
+static void range_set_union(struct range_set *out,
+			     struct range_set *a, struct range_set *b)
+{
+	int i = 0, j = 0, o = 0;
+	struct range *ra = a->ranges;
+	struct range *rb = b->ranges;
+	/* cannot make an alias of out->ranges: it may change during grow */
+
+	assert(out->nr == 0);
+	while (i < a->nr || j < b->nr) {
+		struct range *new;
+		if (i < a->nr && j < b->nr) {
+			if (ra[i].start < rb[j].start)
+				new = &ra[i++];
+			else if (ra[i].start > rb[j].start)
+				new = &rb[j++];
+			else if (ra[i].end < rb[j].end)
+				new = &ra[i++];
+			else
+				new = &rb[j++];
+		} else if (i < a->nr)      /* b exhausted */
+			new = &ra[i++];
+		else                       /* a exhausted */
+			new = &rb[j++];
+		if (new->start == new->end)
+			; /* empty range */
+		else if (!o || out->ranges[o-1].end < new->start) {
+			range_set_grow(out, 1);
+			out->ranges[o].start = new->start;
+			out->ranges[o].end = new->end;
+			o++;
+		} else if (out->ranges[o-1].end < new->end) {
+			out->ranges[o-1].end = new->end;
+		}
+	}
+	out->nr = o;
+}
+
+/*
+ * Difference of range sets (out = a \ b).  Pass the "interesting"
+ * ranges as 'a' and the target side of the diff as 'b': it removes
+ * the ranges for which the commit is responsible.
+ */
+static void range_set_difference(struct range_set *out,
+				  struct range_set *a, struct range_set *b)
+{
+	int i, j =  0;
+	for (i = 0; i < a->nr; i++) {
+		long start = a->ranges[i].start;
+		long end = a->ranges[i].end;
+		while (start < end) {
+			while (j < b->nr && start >= b->ranges[j].end)
+				/*
+				 * a:         |-------
+				 * b: ------|
+				 */
+				j++;
+			if (j >= b->nr || end < b->ranges[j].start) {
+				/*
+				 * b exhausted, or
+				 * a:  ----|
+				 * b:         |----
+				 */
+				range_set_append(out, start, end);
+				break;
+			}
+			if (start >= b->ranges[j].start) {
+				/*
+				 * a:     |--????
+				 * b: |------|
+				 */
+				start = b->ranges[j].end;
+			} else if (end > b->ranges[j].start) {
+				/*
+				 * a: |-----|
+				 * b:    |--?????
+				 */
+				if (start < b->ranges[j].start)
+					range_set_append(out, start, b->ranges[j].start);
+				start = b->ranges[j].end;
+			}
+		}
+	}
+}
+
+static void diff_ranges_init(struct diff_ranges *diff)
+{
+	range_set_init(&diff->parent, 0);
+	range_set_init(&diff->target, 0);
+}
+
+static void diff_ranges_release(struct diff_ranges *diff)
+{
+	range_set_release(&diff->parent);
+	range_set_release(&diff->target);
+}
+
+void line_log_data_init(struct line_log_data *r)
+{
+	memset(r, 0, sizeof(struct line_log_data));
+	range_set_init(&r->ranges, 0);
+}
+
+static void line_log_data_clear(struct line_log_data *r)
+{
+	range_set_release(&r->ranges);
+	if (r->pair)
+		diff_free_filepair(r->pair);
+}
+
+static void free_line_log_data(struct line_log_data *r)
+{
+	while (r) {
+		struct line_log_data *next = r->next;
+		line_log_data_clear(r);
+		free(r);
+		r = next;
+	}
+}
+
+static struct line_log_data *
+search_line_log_data(struct line_log_data *list, const char *path,
+		     struct line_log_data **insertion_point)
+{
+	struct line_log_data *p = list;
+	if (insertion_point)
+		*insertion_point = NULL;
+	while (p) {
+		int cmp = strcmp(p->spec->path, path);
+		if (!cmp)
+			return p;
+		if (insertion_point && cmp < 0)
+			*insertion_point = p;
+		p = p->next;
+	}
+	return NULL;
+}
+
+static void line_log_data_insert(struct line_log_data **list,
+				 struct diff_filespec *spec,
+				 long begin, long end)
+{
+	struct line_log_data *ip;
+	struct line_log_data *p = search_line_log_data(*list, spec->path, &ip);
+
+	if (p) {
+		range_set_append(&p->ranges, begin, end);
+		sort_and_merge_range_set(&p->ranges);
+		free_filespec(spec);
+		return;
+	}
+
+	p = xcalloc(1, sizeof(struct line_log_data));
+	p->spec = spec;
+	range_set_append(&p->ranges, begin, end);
+	if (ip) {
+		p->next = ip->next;
+		ip->next = p;
+	} else {
+		p->next = *list;
+		*list = p;
+	}
+}
+
+struct collect_diff_cbdata {
+	struct diff_ranges *diff;
+};
+
+static int collect_diff_cb(long start_a, long count_a,
+			   long start_b, long count_b,
+			   void *data)
+{
+	struct collect_diff_cbdata *d = data;
+
+	if (count_a >= 0)
+		range_set_append(&d->diff->parent, start_a, start_a + count_a);
+	if (count_b >= 0)
+		range_set_append(&d->diff->target, start_b, start_b + count_b);
+
+	return 0;
+}
+
+static void collect_diff(mmfile_t *parent, mmfile_t *target, struct diff_ranges *out)
+{
+	struct collect_diff_cbdata cbdata = {NULL};
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	xdemitcb_t ecb;
+
+	memset(&xpp, 0, sizeof(xpp));
+	memset(&xecfg, 0, sizeof(xecfg));
+	xecfg.ctxlen = xecfg.interhunkctxlen = 0;
+
+	cbdata.diff = out;
+	xecfg.hunk_func = collect_diff_cb;
+	memset(&ecb, 0, sizeof(ecb));
+	ecb.priv = &cbdata;
+	xdi_diff(parent, target, &xpp, &xecfg, &ecb);
+}
+
+/*
+ * These are handy for debugging.  Removing them with #if 0 silences
+ * the "unused function" warning.
+ */
+#if 0
+static void dump_range_set(struct range_set *rs, const char *desc)
+{
+	int i;
+	printf("range set %s (%d items):\n", desc, rs->nr);
+	for (i = 0; i < rs->nr; i++)
+		printf("\t[%ld,%ld]\n", rs->ranges[i].start, rs->ranges[i].end);
+}
+
+static void dump_line_log_data(struct line_log_data *r)
+{
+	char buf[4096];
+	while (r) {
+		snprintf(buf, 4096, "file %s\n", r->spec->path);
+		dump_range_set(&r->ranges, buf);
+		r = r->next;
+	}
+}
+
+static void dump_diff_ranges(struct diff_ranges *diff, const char *desc)
+{
+	int i;
+	assert(diff->parent.nr == diff->target.nr);
+	printf("diff ranges %s (%d items):\n", desc, diff->parent.nr);
+	printf("\tparent\ttarget\n");
+	for (i = 0; i < diff->parent.nr; i++) {
+		printf("\t[%ld,%ld]\t[%ld,%ld]\n",
+		       diff->parent.ranges[i].start,
+		       diff->parent.ranges[i].end,
+		       diff->target.ranges[i].start,
+		       diff->target.ranges[i].end);
+	}
+}
+#endif
+
+
+static int ranges_overlap(struct range *a, struct range *b)
+{
+	return !(a->end <= b->start || b->end <= a->start);
+}
+
+/*
+ * Given a diff and the set of interesting ranges, determine all hunks
+ * of the diff which touch (overlap) at least one of the interesting
+ * ranges in the target.
+ */
+static void diff_ranges_filter_touched(struct diff_ranges *out,
+				       struct diff_ranges *diff,
+				       struct range_set *rs)
+{
+	int i, j = 0;
+
+	assert(out->target.nr == 0);
+
+	for (i = 0; i < diff->target.nr; i++) {
+		while (diff->target.ranges[i].start > rs->ranges[j].end) {
+			j++;
+			if (j == rs->nr)
+				return;
+		}
+		if (ranges_overlap(&diff->target.ranges[i], &rs->ranges[j])) {
+			range_set_append(&out->parent,
+					 diff->parent.ranges[i].start,
+					 diff->parent.ranges[i].end);
+			range_set_append(&out->target,
+					 diff->target.ranges[i].start,
+					 diff->target.ranges[i].end);
+		}
+	}
+}
+
+/*
+ * Adjust the line counts in 'rs' to account for the lines
+ * added/removed in the diff.
+ */
+static void range_set_shift_diff(struct range_set *out,
+				 struct range_set *rs,
+				 struct diff_ranges *diff)
+{
+	int i, j = 0;
+	long offset = 0;
+	struct range *src = rs->ranges;
+	struct range *target = diff->target.ranges;
+	struct range *parent = diff->parent.ranges;
+
+	for (i = 0; i < rs->nr; i++) {
+		while (j < diff->target.nr && src[i].start >= target[j].start) {
+			offset += (parent[j].end-parent[j].start)
+				- (target[j].end-target[j].start);
+			j++;
+		}
+		range_set_append(out, src[i].start+offset, src[i].end+offset);
+	}
+}
+
+/*
+ * Given a diff and the set of interesting ranges, map the ranges
+ * across the diff.  That is: observe that the target commit takes
+ * blame for all the + (target-side) ranges.  So for every pair of
+ * ranges in the diff that was touched, we remove the latter and add
+ * its parent side.
+ */
+static void range_set_map_across_diff(struct range_set *out,
+				      struct range_set *rs,
+				      struct diff_ranges *diff,
+				      struct diff_ranges **touched_out)
+{
+	struct diff_ranges *touched = xmalloc(sizeof(*touched));
+	struct range_set tmp1 = RANGE_SET_INIT;
+	struct range_set tmp2 = RANGE_SET_INIT;
+
+	diff_ranges_init(touched);
+	diff_ranges_filter_touched(touched, diff, rs);
+	range_set_difference(&tmp1, rs, &touched->target);
+	range_set_shift_diff(&tmp2, &tmp1, diff);
+	range_set_union(out, &tmp2, &touched->parent);
+	range_set_release(&tmp1);
+	range_set_release(&tmp2);
+
+	*touched_out = touched;
+}
+
+
+static struct commit *check_single_commit(struct rev_info *revs)
+{
+	struct object *commit = NULL;
+	int found = -1;
+	int i;
+
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object *obj = revs->pending.objects[i].item;
+		if (obj->flags & UNINTERESTING)
+			continue;
+		while (obj->type == OBJ_TAG)
+			obj = deref_tag(obj, NULL, 0);
+		if (obj->type != OBJ_COMMIT)
+			die("Non commit %s?", revs->pending.objects[i].name);
+		if (commit)
+			die("More than one commit to dig from: %s and %s?",
+			    revs->pending.objects[i].name,
+			    revs->pending.objects[found].name);
+		commit = obj;
+		found = i;
+	}
+
+	if (!commit)
+		die("No commit specified?");
+
+	return (struct commit *) commit;
+}
+
+static void fill_blob_sha1(struct commit *commit, struct diff_filespec *spec)
+{
+	unsigned mode;
+	unsigned char sha1[20];
+
+	if (get_tree_entry(commit->object.sha1, spec->path,
+			   sha1, &mode))
+		die("There is no path %s in the commit", spec->path);
+	fill_filespec(spec, sha1, 1, mode);
+
+	return;
+}
+
+static void fill_line_ends(struct diff_filespec *spec, long *lines,
+			   unsigned long **line_ends)
+{
+	int num = 0, size = 50;
+	long cur = 0;
+	unsigned long *ends = NULL;
+	char *data = NULL;
+
+	if (diff_populate_filespec(spec, 0))
+		die("Cannot read blob %s", sha1_to_hex(spec->sha1));
+
+	ends = xmalloc(size * sizeof(*ends));
+	ends[cur++] = 0;
+	data = spec->data;
+	while (num < spec->size) {
+		if (data[num] == '\n' || num == spec->size - 1) {
+			ALLOC_GROW(ends, (cur + 1), size);
+			ends[cur++] = num;
+		}
+		num++;
+	}
+
+	/* shrink the array to fit the elements */
+	ends = xrealloc(ends, cur * sizeof(*ends));
+	*lines = cur-1;
+	*line_ends = ends;
+}
+
+struct nth_line_cb {
+	struct diff_filespec *spec;
+	long lines;
+	unsigned long *line_ends;
+};
+
+static const char *nth_line(void *data, long line)
+{
+	struct nth_line_cb *d = data;
+	assert(d && line <= d->lines);
+	assert(d->spec && d->spec->data);
+
+	if (line == 0)
+		return (char *)d->spec->data;
+	else
+		return (char *)d->spec->data + d->line_ends[line] + 1;
+}
+
+static struct line_log_data *
+parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
+{
+	long lines = 0;
+	unsigned long *ends = NULL;
+	struct nth_line_cb cb_data;
+	struct string_list_item *item;
+	struct line_log_data *ranges = NULL;
+
+	for_each_string_list_item(item, args) {
+		const char *name_part, *range_part;
+		const char *full_name;
+		struct diff_filespec *spec;
+		long begin = 0, end = 0;
+
+		name_part = skip_range_arg(item->string);
+		if (!name_part || *name_part != ':' || !name_part[1])
+			die("-L argument '%s' not of the form start,end:file",
+			    item->string);
+		range_part = xstrndup(item->string, name_part - item->string);
+		name_part++;
+
+		full_name = prefix_path(prefix, prefix ? strlen(prefix) : 0,
+					name_part);
+
+		spec = alloc_filespec(full_name);
+		fill_blob_sha1(commit, spec);
+		fill_line_ends(spec, &lines, &ends);
+		cb_data.spec = spec;
+		cb_data.lines = lines;
+		cb_data.line_ends = ends;
+
+		if (parse_range_arg(range_part, nth_line, &cb_data,
+				    lines, &begin, &end))
+			die("malformed -L argument '%s'", range_part);
+		if (begin < 1)
+			begin = 1;
+		if (end < 1)
+			end = lines;
+		begin--;
+		if (lines < end || lines < begin)
+			die("file %s has only %ld lines", name_part, lines);
+		line_log_data_insert(&ranges, spec, begin, end);
+
+		free(ends);
+		ends = NULL;
+	}
+
+	return ranges;
+}
+
+static struct line_log_data *line_log_data_copy_one(struct line_log_data *r)
+{
+	struct line_log_data *ret = xmalloc(sizeof(*ret));
+
+	assert(r);
+	line_log_data_init(ret);
+	range_set_copy(&ret->ranges, &r->ranges);
+
+	ret->spec = r->spec;
+	assert(ret->spec);
+	ret->spec->count++;
+
+	return ret;
+}
+
+static struct line_log_data *
+line_log_data_copy(struct line_log_data *r)
+{
+	struct line_log_data *ret = NULL;
+	struct line_log_data *tmp = NULL, *prev = NULL;
+
+	assert(r);
+	ret = tmp = prev = line_log_data_copy_one(r);
+	r = r->next;
+	while (r) {
+		tmp = line_log_data_copy_one(r);
+		prev->next = tmp;
+		prev = tmp;
+		r = r->next;
+	}
+
+	return ret;
+}
+
+/* merge two range sets across files */
+static struct line_log_data *line_log_data_merge(struct line_log_data *a,
+						 struct line_log_data *b)
+{
+	struct line_log_data *head = NULL, **pp = &head;
+
+	while (a || b) {
+		struct line_log_data *src;
+		struct line_log_data *src2 = NULL;
+		struct line_log_data *d;
+		int cmp;
+		if (!a)
+			cmp = 1;
+		else if (!b)
+			cmp = -1;
+		else
+			cmp = strcmp(a->spec->path, b->spec->path);
+		if (cmp < 0) {
+			src = a;
+			a = a->next;
+		} else if (cmp == 0) {
+			src = a;
+			a = a->next;
+			src2 = b;
+			b = b->next;
+		} else {
+			src = b;
+			b = b->next;
+		}
+		d = xmalloc(sizeof(struct line_log_data));
+		line_log_data_init(d);
+		d->spec = src->spec;
+		d->spec->count++;
+		*pp = d;
+		pp = &d->next;
+		if (src2)
+			range_set_union(&d->ranges, &src->ranges, &src2->ranges);
+		else
+			range_set_copy(&d->ranges, &src->ranges);
+	}
+
+	return head;
+}
+
+static void add_line_range(struct rev_info *revs, struct commit *commit,
+			   struct line_log_data *range)
+{
+	struct line_log_data *old = NULL;
+	struct line_log_data *new = NULL;
+
+	old = lookup_decoration(&revs->line_log_data, &commit->object);
+	if (old && range) {
+		new = line_log_data_merge(old, range);
+		free_line_log_data(old);
+	} else if (range)
+		new = line_log_data_copy(range);
+
+	if (new)
+		add_decoration(&revs->line_log_data, &commit->object, new);
+}
+
+static void clear_commit_line_range(struct rev_info *revs, struct commit *commit)
+{
+	struct line_log_data *r;
+	r = lookup_decoration(&revs->line_log_data, &commit->object);
+	if (!r)
+		return;
+	free_line_log_data(r);
+	add_decoration(&revs->line_log_data, &commit->object, NULL);
+}
+
+static struct line_log_data *lookup_line_range(struct rev_info *revs,
+					       struct commit *commit)
+{
+	struct line_log_data *ret = NULL;
+
+	ret = lookup_decoration(&revs->line_log_data, &commit->object);
+	return ret;
+}
+
+void line_log_init(struct rev_info *rev, const char *prefix, struct string_list *args)
+{
+	struct commit *commit = NULL;
+	struct line_log_data *range;
+
+	commit = check_single_commit(rev);
+	range = parse_lines(commit, prefix, args);
+	add_line_range(rev, commit, range);
+
+	if (!rev->diffopt.detect_rename) {
+		int i, count = 0;
+		struct line_log_data *r = range;
+		const char **paths;
+		while (r) {
+			count++;
+			r = r->next;
+		}
+		paths = xmalloc((count+1)*sizeof(char *));
+		r = range;
+		for (i = 0; i < count; i++) {
+			paths[i] = xstrdup(r->spec->path);
+			r = r->next;
+		}
+		paths[count] = NULL;
+		init_pathspec(&rev->diffopt.pathspec, paths);
+		free(paths);
+	}
+}
+
+static void load_tree_desc(struct tree_desc *desc, void **tree,
+			   const unsigned char *sha1)
+{
+	unsigned long size;
+	*tree = read_object_with_reference(sha1, tree_type, &size, NULL);
+	if (!*tree)
+		die("Unable to read tree (%s)", sha1_to_hex(sha1));
+	init_tree_desc(desc, *tree, size);
+}
+
+static int count_parents(struct commit *commit)
+{
+	struct commit_list *parents = commit->parents;
+	int count = 0;
+	while (parents) {
+		count++;
+		parents = parents->next;
+	}
+	return count;
+}
+
+static void move_diff_queue(struct diff_queue_struct *dst,
+			    struct diff_queue_struct *src)
+{
+	assert(src != dst);
+	memcpy(dst, src, sizeof(struct diff_queue_struct));
+	DIFF_QUEUE_CLEAR(src);
+}
+
+static void queue_diffs(struct diff_options *opt,
+			struct diff_queue_struct *queue,
+			struct commit *commit, struct commit *parent)
+{
+	void *tree1 = NULL, *tree2 = NULL;
+	struct tree_desc desc1, desc2;
+
+	assert(commit);
+	load_tree_desc(&desc2, &tree2, commit->tree->object.sha1);
+	if (parent)
+		load_tree_desc(&desc1, &tree1, parent->tree->object.sha1);
+	else
+		init_tree_desc(&desc1, "", 0);
+
+	DIFF_QUEUE_CLEAR(&diff_queued_diff);
+	diff_tree(&desc1, &desc2, "", opt);
+	diffcore_std(opt);
+	move_diff_queue(queue, &diff_queued_diff);
+
+	if (tree1)
+		free(tree1);
+	if (tree2)
+		free(tree2);
+}
+
+static char *get_nth_line(long line, unsigned long *ends, void *data)
+{
+	if (line == 0)
+		return (char *)data;
+	else
+		return (char *)data + ends[line] + 1;
+}
+
+static void print_line(const char *prefix, char first,
+		       long line, unsigned long *ends, void *data,
+		       const char *color, const char *reset)
+{
+	char *begin = get_nth_line(line, ends, data);
+	char *end = get_nth_line(line+1, ends, data);
+	int had_nl = 0;
+
+	if (end > begin && end[-1] == '\n') {
+		end--;
+		had_nl = 1;
+	}
+
+	fputs(prefix, stdout);
+	fputs(color, stdout);
+	putchar(first);
+	fwrite(begin, 1, end-begin, stdout);
+	fputs(reset, stdout);
+	putchar('\n');
+	if (!had_nl)
+		fputs("\\ No newline at end of file\n", stdout);
+}
+
+static char *output_prefix(struct diff_options *opt)
+{
+	char *prefix = "";
+
+	if (opt->output_prefix) {
+		struct strbuf *sb = opt->output_prefix(opt, opt->output_prefix_data);
+		prefix = sb->buf;
+	}
+
+	return prefix;
+}
+
+static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *range)
+{
+	int i, j = 0;
+	long p_lines, t_lines;
+	unsigned long *p_ends = NULL, *t_ends = NULL;
+	struct diff_filepair *pair = range->pair;
+	struct diff_ranges *diff = &range->diff;
+
+	struct diff_options *opt = &rev->diffopt;
+	char *prefix = output_prefix(opt);
+	const char *c_reset = diff_get_color(opt->use_color, DIFF_RESET);
+	const char *c_frag = diff_get_color(opt->use_color, DIFF_FRAGINFO);
+	const char *c_meta = diff_get_color(opt->use_color, DIFF_METAINFO);
+	const char *c_old = diff_get_color(opt->use_color, DIFF_FILE_OLD);
+	const char *c_new = diff_get_color(opt->use_color, DIFF_FILE_NEW);
+	const char *c_plain = diff_get_color(opt->use_color, DIFF_PLAIN);
+
+	if (!pair || !diff)
+		return;
+
+	if (pair->one->sha1_valid)
+		fill_line_ends(pair->one, &p_lines, &p_ends);
+	fill_line_ends(pair->two, &t_lines, &t_ends);
+
+	printf("%s%sdiff --git a/%s b/%s%s\n", prefix, c_meta, pair->one->path, pair->two->path, c_reset);
+	printf("%s%s--- %s%s%s\n", prefix, c_meta,
+	       pair->one->sha1_valid ? "a/" : "",
+	       pair->one->sha1_valid ? pair->one->path : "/dev/null",
+	       c_reset);
+	printf("%s%s+++ b/%s%s\n", prefix, c_meta, pair->two->path, c_reset);
+	for (i = 0; i < range->ranges.nr; i++) {
+		long p_start, p_end;
+		long t_start = range->ranges.ranges[i].start;
+		long t_end = range->ranges.ranges[i].end;
+		long t_cur = t_start;
+		int j_last;
+
+		while (j < diff->target.nr && diff->target.ranges[j].end < t_start)
+			j++;
+		if (j == diff->target.nr || diff->target.ranges[j].start > t_end)
+			continue;
+
+		/* Scan ahead to determine the last diff that falls in this range */
+		j_last = j;
+		while (j_last < diff->target.nr && diff->target.ranges[j_last].start < t_end)
+			j_last++;
+		if (j_last > j)
+			j_last--;
+
+		/*
+		 * Compute parent hunk headers: we know that the diff
+		 * has the correct line numbers (but not all hunks).
+		 * So it suffices to shift the start/end according to
+		 * the line numbers of the first/last hunk(s) that
+		 * fall in this range.
+		 */
+		if (t_start < diff->target.ranges[j].start)
+			p_start = diff->parent.ranges[j].start - (diff->target.ranges[j].start-t_start);
+		else
+			p_start = diff->parent.ranges[j].start;
+		if (t_end > diff->target.ranges[j_last].end)
+			p_end = diff->parent.ranges[j_last].end + (t_end-diff->target.ranges[j_last].end);
+		else
+			p_end = diff->parent.ranges[j_last].end;
+
+		if (!p_start && !p_end) {
+			p_start = -1;
+			p_end = -1;
+		}
+
+		/* Now output a diff hunk for this range */
+		printf("%s%s@@ -%ld,%ld +%ld,%ld @@%s\n",
+		       prefix, c_frag,
+		       p_start+1, p_end-p_start, t_start+1, t_end-t_start,
+		       c_reset);
+		while (j < diff->target.nr && diff->target.ranges[j].start < t_end) {
+			int k;
+			for (; t_cur < diff->target.ranges[j].start; t_cur++)
+				print_line(prefix, ' ', t_cur, t_ends, pair->two->data,
+					   c_plain, c_reset);
+			for (k = diff->parent.ranges[j].start; k < diff->parent.ranges[j].end; k++)
+				print_line(prefix, '-', k, p_ends, pair->one->data,
+					   c_old, c_reset);
+			for (; t_cur < diff->target.ranges[j].end && t_cur < t_end; t_cur++)
+				print_line(prefix, '+', t_cur, t_ends, pair->two->data,
+					   c_new, c_reset);
+			j++;
+		}
+		for (; t_cur < t_end; t_cur++)
+			print_line(prefix, ' ', t_cur, t_ends, pair->two->data,
+				   c_plain, c_reset);
+	}
+
+	free(p_ends);
+	free(t_ends);
+}
+
+/*
+ * NEEDSWORK: manually building a diff here is not the Right
+ * Thing(tm).  log -L should be built into the diff pipeline.
+ */
+static void dump_diff_hacky(struct rev_info *rev, struct line_log_data *range)
+{
+	puts(output_prefix(&rev->diffopt));
+	while (range) {
+		dump_diff_hacky_one(rev, range);
+		range = range->next;
+	}
+}
+
+/*
+ * Unlike most other functions, this destructively operates on
+ * 'range'.
+ */
+static int process_diff_filepair(struct rev_info *rev,
+				 struct diff_filepair *pair,
+				 struct line_log_data *range,
+				 struct diff_ranges **diff_out)
+{
+	struct line_log_data *rg = range;
+	struct range_set tmp;
+	struct diff_ranges diff;
+	mmfile_t file_parent, file_target;
+
+	assert(pair->two->path);
+	while (rg) {
+		assert(rg->spec->path);
+		if (!strcmp(rg->spec->path, pair->two->path))
+			break;
+		rg = rg->next;
+	}
+
+	if (!rg)
+		return 0;
+	if (rg->ranges.nr == 0)
+		return 0;
+
+	assert(pair->two->sha1_valid);
+	diff_populate_filespec(pair->two, 0);
+	file_target.ptr = pair->two->data;
+	file_target.size = pair->two->size;
+
+	if (pair->one->sha1_valid) {
+		diff_populate_filespec(pair->one, 0);
+		file_parent.ptr = pair->one->data;
+		file_parent.size = pair->one->size;
+	} else {
+		file_parent.ptr = "";
+		file_parent.size = 0;
+	}
+
+	diff_ranges_init(&diff);
+	collect_diff(&file_parent, &file_target, &diff);
+
+	/* NEEDSWORK should apply some heuristics to prevent mismatches */
+	rg->spec->path = xstrdup(pair->one->path);
+
+	range_set_init(&tmp, 0);
+	range_set_map_across_diff(&tmp, &rg->ranges, &diff, diff_out);
+	range_set_release(&rg->ranges);
+	range_set_move(&rg->ranges, &tmp);
+
+	diff_ranges_release(&diff);
+
+	return ((*diff_out)->parent.nr > 0);
+}
+
+static struct diff_filepair *diff_filepair_dup(struct diff_filepair *pair)
+{
+	struct diff_filepair *new = xmalloc(sizeof(struct diff_filepair));
+	new->one = pair->one;
+	new->two = pair->two;
+	new->one->count++;
+	new->two->count++;
+	return new;
+}
+
+static void free_diffqueues(int n, struct diff_queue_struct *dq)
+{
+	int i, j;
+	for (i = 0; i < n; i++)
+		for (j = 0; j < dq[i].nr; j++)
+			diff_free_filepair(dq[i].queue[j]);
+	free(dq);
+}
+
+static int process_all_files(struct line_log_data **range_out,
+			     struct rev_info *rev,
+			     struct diff_queue_struct *queue,
+			     struct line_log_data *range)
+{
+	int i, changed = 0;
+
+	*range_out = line_log_data_copy(range);
+
+	for (i = 0; i < queue->nr; i++) {
+		struct diff_ranges *pairdiff = NULL;
+		if (process_diff_filepair(rev, queue->queue[i], *range_out, &pairdiff)) {
+			struct line_log_data *rg = range;
+			changed++;
+			/* NEEDSWORK tramples over data structures not owned here */
+			while (rg && strcmp(rg->spec->path, queue->queue[i]->two->path))
+				rg = rg->next;
+			assert(rg);
+			rg->pair = diff_filepair_dup(queue->queue[i]);
+			memcpy(&rg->diff, pairdiff, sizeof(struct diff_ranges));
+		}
+	}
+
+	return changed;
+}
+
+int line_log_print(struct rev_info *rev, struct commit *commit)
+{
+	struct line_log_data *range = lookup_line_range(rev, commit);
+
+	show_log(rev);
+	dump_diff_hacky(rev, range);
+	return 1;
+}
+
+static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *commit,
+					  struct line_log_data *range)
+{
+	struct commit *parent = NULL;
+	struct diff_queue_struct queue;
+	struct line_log_data *parent_range;
+	int changed;
+
+	if (commit->parents)
+		parent = commit->parents->item;
+
+	queue_diffs(&rev->diffopt, &queue, commit, parent);
+	changed = process_all_files(&parent_range, rev, &queue, range);
+	if (parent)
+		add_line_range(rev, parent, parent_range);
+	return changed;
+}
+
+static int process_ranges_merge_commit(struct rev_info *rev, struct commit *commit,
+				       struct line_log_data *range)
+{
+	struct diff_queue_struct *diffqueues;
+	struct line_log_data **cand;
+	struct commit **parents;
+	struct commit_list *p;
+	int i;
+	int nparents = count_parents(commit);
+
+	diffqueues = xmalloc(nparents * sizeof(*diffqueues));
+	cand = xmalloc(nparents * sizeof(*cand));
+	parents = xmalloc(nparents * sizeof(*parents));
+
+	p = commit->parents;
+	for (i = 0; i < nparents; i++) {
+		parents[i] = p->item;
+		p = p->next;
+		queue_diffs(&rev->diffopt, &diffqueues[i], commit, parents[i]);
+	}
+
+	for (i = 0; i < nparents; i++) {
+		int changed;
+		cand[i] = NULL;
+		changed = process_all_files(&cand[i], rev, &diffqueues[i], range);
+		if (!changed) {
+			/*
+			 * This parent can take all the blame, so we
+			 * don't follow any other path in history
+			 */
+			add_line_range(rev, parents[i], cand[i]);
+			clear_commit_line_range(rev, commit);
+			commit->parents = xmalloc(sizeof(struct commit_list));
+			commit->parents->item = parents[i];
+			commit->parents->next = NULL;
+			free(parents);
+			free(cand);
+			free_diffqueues(nparents, diffqueues);
+			/* NEEDSWORK leaking like a sieve */
+			return 0;
+		}
+	}
+
+	/*
+	 * No single parent took the blame.  We add the candidates
+	 * from the above loop to the parents.
+	 */
+	for (i = 0; i < nparents; i++) {
+		add_line_range(rev, parents[i], cand[i]);
+	}
+
+	clear_commit_line_range(rev, commit);
+	free(parents);
+	free(cand);
+	free_diffqueues(nparents, diffqueues);
+	return 1;
+
+	/* NEEDSWORK evil merge detection stuff */
+	/* NEEDSWORK leaking like a sieve */
+}
+
+static int process_ranges_arbitrary_commit(struct rev_info *rev, struct commit *commit)
+{
+	struct line_log_data *range = lookup_line_range(rev, commit);
+	int changed = 0;
+
+	if (range) {
+		if (!commit->parents || !commit->parents->next)
+			changed = process_ranges_ordinary_commit(rev, commit, range);
+		else
+			changed = process_ranges_merge_commit(rev, commit, range);
+	}
+
+	if (!changed)
+		commit->object.flags |= TREESAME;
+
+	return changed;
+}
+
+static enum rewrite_result line_log_rewrite_one(struct rev_info *rev, struct commit **pp)
+{
+	for (;;) {
+		struct commit *p = *pp;
+		if (p->parents && p->parents->next)
+			return rewrite_one_ok;
+		if (p->object.flags & UNINTERESTING)
+			return rewrite_one_ok;
+		if (!(p->object.flags & TREESAME))
+			return rewrite_one_ok;
+		if (!p->parents)
+			return rewrite_one_noparents;
+		*pp = p->parents->item;
+	}
+}
+
+int line_log_filter(struct rev_info *rev)
+{
+	struct commit *commit;
+	struct commit_list *list = rev->commits;
+	struct commit_list *out = NULL, **pp = &out;
+
+	while (list) {
+		struct commit_list *to_free = NULL;
+		commit = list->item;
+		if (process_ranges_arbitrary_commit(rev, commit)) {
+			*pp = list;
+			pp = &list->next;
+		} else
+			to_free = list;
+		list = list->next;
+		free(to_free);
+	}
+	*pp = NULL;
+
+	for (list = out; list; list = list->next)
+		rewrite_parents(rev, list->item, line_log_rewrite_one);
+
+	rev->commits = out;
+
+	return 0;
+}
diff --git a/line-log.h b/line-log.h
new file mode 100644
index 0000000..9acd123
--- /dev/null
+++ b/line-log.h
@@ -0,0 +1,49 @@
+#ifndef LINE_LOG_H
+#define LINE_LOG_H
+
+#include "diffcore.h"
+
+struct rev_info;
+struct commit;
+
+/* A range [start,end].  Lines are numbered starting at 0, and the
+ * ranges include start but exclude end. */
+struct range {
+	long start, end;
+};
+
+/* A set of ranges.  The ranges must always be disjoint and sorted. */
+struct range_set {
+	int alloc, nr;
+	struct range *ranges;
+};
+
+/* A diff, encoded as the set of pre- and post-image ranges where the
+ * files differ. A pair of ranges corresponds to a hunk. */
+struct diff_ranges {
+	struct range_set parent;
+	struct range_set target;
+};
+
+/* Linked list of interesting files and their associated ranges.  The
+ * list must be kept sorted by spec->path */
+struct line_log_data {
+	struct line_log_data *next;
+	struct diff_filespec *spec;
+	char status;
+	struct range_set ranges;
+	int arg_alloc, arg_nr;
+	const char **args;
+	struct diff_filepair *pair;
+	struct diff_ranges diff;
+};
+
+extern void line_log_data_init(struct line_log_data *r);
+
+extern void line_log_init(struct rev_info *rev, const char *prefix, struct string_list *args);
+
+extern int line_log_filter(struct rev_info *rev);
+
+extern int line_log_print(struct rev_info *rev, struct commit *commit);
+
+#endif /* LINE_LOG_H */
diff --git a/line-range.c b/line-range.c
index 5a226ab..7a7ca3c 100644
--- a/line-range.c
+++ b/line-range.c
@@ -21,6 +21,8 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 	if (1 < begin && (spec[0] == '+' || spec[0] == '-')) {
 		num = strtol(spec + 1, &term, 10);
 		if (term != spec + 1) {
+			if (!ret)
+				return term;
 			if (spec[0] == '-')
 				num = 0 - num;
 			if (0 < num)
@@ -35,7 +37,8 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 	}
 	num = strtol(spec, &term, 10);
 	if (term != spec) {
-		*ret = num;
+		if (ret)
+			*ret = num;
 		return term;
 	}
 	if (spec[0] != '/')
@@ -49,6 +52,10 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 	if (*term != '/')
 		return spec;
 
+	/* in the scan-only case we are not interested in the regex */
+	if (!ret)
+		return term+1;
+
 	/* try [spec+1 .. term-1] as regexp */
 	*term = 0;
 	begin--; /* input is in human terms */
@@ -90,3 +97,13 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 
 	return 0;
 }
+
+const char *skip_range_arg(const char *arg)
+{
+	arg = parse_loc(arg, NULL, NULL, 0, -1, NULL);
+
+	if (*arg == ',')
+		arg = parse_loc(arg+1, NULL, NULL, 0, 0, NULL);
+
+	return arg;
+}
diff --git a/line-range.h b/line-range.h
index 830f25b..88aaf08 100644
--- a/line-range.h
+++ b/line-range.h
@@ -21,4 +21,15 @@ extern int parse_range_arg(const char *arg,
 			   void *cb_data, long lines,
 			   long *begin, long *end);
 
+/*
+ * Scan past a range argument that could be parsed by
+ * 'parse_range_arg', to help the caller determine the start of the
+ * filename in '-L n,m:file' syntax.
+ *
+ * Returns a pointer to the first character after the 'n,m' part, or
+ * NULL in case the argument is obviously malformed.
+ */
+
+extern const char *skip_range_arg(const char *arg);
+
 #endif /* LINE_RANGE_H */
diff --git a/log-tree.c b/log-tree.c
index 3d88823..00dddaa 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -9,6 +9,7 @@
 #include "string-list.h"
 #include "color.h"
 #include "gpg-interface.h"
+#include "line-log.h"
 
 struct decoration name_decoration = { "object names" };
 
@@ -853,6 +854,9 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	log.parent = NULL;
 	opt->loginfo = &log;
 
+	if (opt->line_level_traverse)
+		return line_log_print(opt, commit);
+
 	shown = log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
 		log.parent = NULL;
diff --git a/revision.c b/revision.c
index 46319d5..3ad9d08 100644
--- a/revision.c
+++ b/revision.c
@@ -13,6 +13,7 @@
 #include "decorate.h"
 #include "log-tree.h"
 #include "string-list.h"
+#include "line-log.h"
 #include "mailmap.h"
 
 volatile show_early_output_fn_t show_early_output;
@@ -1896,6 +1897,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->combine_merges)
 		revs->ignore_merges = 0;
 	revs->diffopt.abbrev = revs->abbrev;
+
+	if (revs->line_level_traverse) {
+		revs->limited = 1;
+		revs->topo_order = 1;
+	}
+
 	diff_setup_done(&revs->diffopt);
 
 	grep_commit_pattern_type(GREP_PATTERN_TYPE_UNSPECIFIED,
@@ -2166,6 +2173,8 @@ int prepare_revision_walk(struct rev_info *revs)
 			return -1;
 	if (revs->topo_order)
 		sort_in_topological_order(&revs->commits, revs->lifo);
+	if (revs->line_level_traverse)
+		line_log_filter(revs);
 	if (revs->simplify_merges)
 		simplify_merges(revs);
 	if (revs->children.name)
diff --git a/revision.h b/revision.h
index 640110d..6b2870c 100644
--- a/revision.h
+++ b/revision.h
@@ -96,7 +96,8 @@ struct rev_info {
 			cherry_mark:1,
 			bisect:1,
 			ancestry_path:1,
-			first_parent_only:1;
+			first_parent_only:1,
+			line_level_traverse:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
@@ -175,6 +176,9 @@ struct rev_info {
 	int count_left;
 	int count_right;
 	int count_same;
+
+	/* line level range that we are chasing */
+	struct decoration line_log_data;
 };
 
 #define REV_TREE_SAME		0
diff --git a/t/perf/p4211-line-log.sh b/t/perf/p4211-line-log.sh
new file mode 100755
index 0000000..3d074b0
--- /dev/null
+++ b/t/perf/p4211-line-log.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='Tests log -L performance'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+# Pick a file to log pseudo-randomly.  The sort key is the blob hash,
+# so it is stable.
+test_expect_success 'select a file' '
+	git ls-tree HEAD | grep ^100644 |
+	sort -k 3 | head -1 | cut -f 2 >filelist
+'
+
+file=$(cat filelist)
+export file
+
+test_perf 'git rev-list --topo-order (baseline)' '
+	git rev-list --topo-order HEAD >/dev/null
+'
+
+test_perf 'git log --follow (baseline for -M)' '
+	git log --oneline --follow -- "$file" >/dev/null
+'
+
+test_perf 'git log -L' '
+	git log -L 1:"$file" >/dev/null
+'
+
+test_perf 'git log -M -L' '
+	git log -M -L 1:"$file" >/dev/null
+'
+
+test_done
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
new file mode 100755
index 0000000..9f36f17
--- /dev/null
+++ b/t/t4211-line-log.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='test log -L'
+. ./test-lib.sh
+
+test_expect_success 'setup (import history)' '
+	git fast-import < "$TEST_DIRECTORY"/t4211/history.export &&
+	git reset --hard
+'
+
+canned_test () {
+	test_expect_success "$1" "
+		git log $1 >actual &&
+		test_cmp \"\$TEST_DIRECTORY\"/t4211/expect.$2 actual
+	"
+}
+
+test_bad_opts () {
+	test_expect_success "invalid args: $1" "
+		test_must_fail git log $1 2>errors &&
+		grep '$2' errors
+	"
+}
+
+canned_test "-L 4,12:a.c simple" simple-f
+canned_test "-L 4,+9:a.c simple" simple-f
+canned_test "-L '/long f/,/^}/:a.c' simple" simple-f
+
+canned_test "-L '/main/,/^}/:a.c' simple" simple-main
+
+canned_test "-L 1,+4:a.c simple" beginning-of-file
+
+canned_test "-L 20:a.c simple" end-of-file
+
+canned_test "-L '/long f/',/^}/:a.c -L /main/,/^}/:a.c simple" two-ranges
+canned_test "-L 24,+1:a.c simple" vanishes-early
+
+canned_test "-L '/long f/,/^}/:b.c' move-support" move-support-f
+
+test_bad_opts "-L" "switch.*requires a value"
+test_bad_opts "-L b.c" "argument.*not of the form"
+test_bad_opts "-L 1:" "argument.*not of the form"
+test_bad_opts "-L 1:nonexistent" "There is no path"
+test_bad_opts "-L 1:simple" "There is no path"
+test_bad_opts "-L '/foo:b.c'" "argument.*not of the form"
+test_bad_opts "-L 1000:b.c" "has only.*lines"
+test_bad_opts "-L 1,1000:b.c" "has only.*lines"
+
+test_done
diff --git a/t/t4211/expect.beginning-of-file b/t/t4211/expect.beginning-of-file
new file mode 100644
index 0000000..91b4054
--- /dev/null
+++ b/t/t4211/expect.beginning-of-file
@@ -0,0 +1,43 @@
+commit 4a23ae5c98d59a58c6da036156959f2dc9f472ad
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:47:40 2013 +0100
+
+    change at very beginning
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -1,3 +1,4 @@
++#include <unistd.h>
+ #include <stdio.h>
+ 
+ long f(long x)
+
+commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -1,3 +1,3 @@
+ #include <stdio.h>
+ 
+-int f(int x)
++long f(long x)
+
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +1,3 @@
++#include <stdio.h>
++
++int f(int x)
diff --git a/t/t4211/expect.end-of-file b/t/t4211/expect.end-of-file
new file mode 100644
index 0000000..bd25bb2
--- /dev/null
+++ b/t/t4211/expect.end-of-file
@@ -0,0 +1,62 @@
+commit 4659538844daa2849b1a9e7d6fadb96fcd26fc83
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -20,3 +20,5 @@
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
++
++/* incomplete lines are bad! */
+
+commit 100b61a6f2f720f812620a9d10afb3a960ccb73c
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -20,3 +20,3 @@
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -19,3 +19,3 @@
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +18,3 @@
++	printf("%d\n", f(15));
++	return 0;
++}
diff --git a/t/t4211/expect.move-support-f b/t/t4211/expect.move-support-f
new file mode 100644
index 0000000..78a8cf1
--- /dev/null
+++ b/t/t4211/expect.move-support-f
@@ -0,0 +1,40 @@
+commit 6ce3c4ff690136099bb17e1a8766b75764726ea7
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:49:50 2013 +0100
+
+    another simple change
+
+diff --git a/b.c b/b.c
+--- a/b.c
++++ b/b.c
+@@ -4,9 +4,9 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+-		x >>= 1;
++		x /= 2;
+ 		s++;
+ 	}
+ 	return s;
+ }
+
+commit e6da343666244ea9e67cbe3f3bd26da860f9fe0e
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:49:28 2013 +0100
+
+    move file
+
+diff --git a/b.c b/b.c
+--- /dev/null
++++ b/b.c
+@@ -0,0 +4,9 @@
++long f(long x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++	return s;
++}
diff --git a/t/t4211/expect.simple-f b/t/t4211/expect.simple-f
new file mode 100644
index 0000000..a1f5bc4
--- /dev/null
+++ b/t/t4211/expect.simple-f
@@ -0,0 +1,59 @@
+commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,9 +3,9 @@
+-int f(int x)
++long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+
+commit f04fb20f2c77850996cba739709acc6faecc58f7
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,8 +3,9 @@
+ int f(int x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
++	return s;
+ }
+
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,8 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
diff --git a/t/t4211/expect.simple-main b/t/t4211/expect.simple-main
new file mode 100644
index 0000000..39ce39b
--- /dev/null
+++ b/t/t4211/expect.simple-main
@@ -0,0 +1,68 @@
+commit 4659538844daa2849b1a9e7d6fadb96fcd26fc83
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
+
+commit 100b61a6f2f720f812620a9d10afb3a960ccb73c
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -17,5 +17,5 @@
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +16,5 @@
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
diff --git a/t/t4211/expect.two-ranges b/t/t4211/expect.two-ranges
new file mode 100644
index 0000000..6109aa0
--- /dev/null
+++ b/t/t4211/expect.two-ranges
@@ -0,0 +1,102 @@
+commit 4659538844daa2849b1a9e7d6fadb96fcd26fc83
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
+
+commit 100b61a6f2f720f812620a9d10afb3a960ccb73c
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,9 +3,9 @@
+-int f(int x)
++long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+@@ -17,5 +17,5 @@
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit f04fb20f2c77850996cba739709acc6faecc58f7
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,8 +3,9 @@
+ int f(int x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
++	return s;
+ }
+
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,8 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
diff --git a/t/t4211/expect.vanishes-early b/t/t4211/expect.vanishes-early
new file mode 100644
index 0000000..1f7cd06
--- /dev/null
+++ b/t/t4211/expect.vanishes-early
@@ -0,0 +1,39 @@
+commit 4659538844daa2849b1a9e7d6fadb96fcd26fc83
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -22,1 +24,1 @@
+-}
+\ No newline at end of file
++/* incomplete lines are bad! */
+
+commit 100b61a6f2f720f812620a9d10afb3a960ccb73c
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -22,1 +22,1 @@
+-}
++}
+\ No newline at end of file
+
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +20,1 @@
++}
diff --git a/t/t4211/history.export b/t/t4211/history.export
new file mode 100644
index 0000000..c159794
--- /dev/null
+++ b/t/t4211/history.export
@@ -0,0 +1,330 @@
+blob
+mark :1
+data 157
+#include <stdio.h>
+
+int f(int x)
+{
+	int s = 0;
+	while (x) {
+		x >>= 1;
+		s++;
+	}
+}
+
+/*
+ * A comment.
+ */
+
+int main ()
+{
+	printf("%d\n", f(15));
+	return 0;
+}
+
+reset refs/tags/simple
+commit refs/tags/simple
+mark :2
+author Thomas Rast <trast@student.ethz.ch> 1362044688 +0100
+committer Thomas Rast <trast@student.ethz.ch> 1362044688 +0100
+data 8
+initial
+M 100644 :1 a.c
+
+blob
+mark :3
+data 168
+#include <stdio.h>
+
+int f(int x)
+{
+	int s = 0;
+	while (x) {
+		x >>= 1;
+		s++;
+	}
+	return s;
+}
+
+/*
+ * A comment.
+ */
+
+int main ()
+{
+	printf("%d\n", f(15));
+	return 0;
+}
+
+commit refs/tags/simple
+mark :4
+author Thomas Rast <trast@student.ethz.ch> 1362044695 +0100
+committer Thomas Rast <trast@student.ethz.ch> 1362044695 +0100
+data 11
+change f()
+from :2
+M 100644 :3 a.c
+
+blob
+mark :5
+data 171
+#include <stdio.h>
+
+long f(long x)
+{
+	int s = 0;
+	while (x) {
+		x >>= 1;
+		s++;
+	}
+	return s;
+}
+
+/*
+ * A comment.
+ */
+
+int main ()
+{
+	printf("%ld\n", f(15));
+	return 0;
+}
+
+commit refs/tags/simple
+mark :6
+author Thomas Rast <trast@student.ethz.ch> 1362044716 +0100
+committer Thomas Rast <trast@student.ethz.ch> 1362044716 +0100
+data 21
+touch both functions
+from :4
+M 100644 :5 a.c
+
+blob
+mark :7
+data 185
+#include <stdio.h>
+
+long f(long x)
+{
+	int s = 0;
+	while (x) {
+		x >>= 1;
+		s++;
+	}
+	return s;
+}
+
+/*
+ * This is only an example!
+ */
+
+int main ()
+{
+	printf("%ld\n", f(15));
+	return 0;
+}
+
+commit refs/tags/simple
+mark :8
+author Thomas Rast <trast@student.ethz.ch> 1362044741 +0100
+committer Thomas Rast <trast@student.ethz.ch> 1362044741 +0100
+data 14
+touch comment
+from :6
+M 100644 :7 a.c
+
+blob
+mark :9
+data 205
+#include <unistd.h>
+#include <stdio.h>
+
+long f(long x)
+{
+	int s = 0;
+	while (x) {
+		x >>= 1;
+		s++;
+	}
+	return s;
+}
+
+/*
+ * This is only an example!
+ */
+
+int main ()
+{
+	printf("%ld\n", f(15));
+	return 0;
+}
+
+commit refs/tags/simple
+mark :10
+author Thomas Rast <trast@student.ethz.ch> 1362044860 +0100
+committer Thomas Rast <trast@student.ethz.ch> 1362044860 +0100
+data 25
+change at very beginning
+from :8
+M 100644 :9 a.c
+
+blob
+mark :11
+data 204
+#include <unistd.h>
+#include <stdio.h>
+
+long f(long x)
+{
+	int s = 0;
+	while (x) {
+		x >>= 1;
+		s++;
+	}
+	return s;
+}
+
+/*
+ * This is only an example!
+ */
+
+int main ()
+{
+	printf("%ld\n", f(15));
+	return 0;
+}
+commit refs/tags/simple
+mark :12
+author Thomas Rast <trast@student.ethz.ch> 1362044890 +0100
+committer Thomas Rast <trast@student.ethz.ch> 1362044890 +0100
+data 36
+change to an incomplete line at end
+from :10
+M 100644 :11 a.c
+
+blob
+mark :13
+data 238
+#include <unistd.h>
+#include <stdio.h>
+
+long f(long x)
+{
+	int s = 0;
+	while (x) {
+		x >>= 1;
+		s++;
+	}
+	return s;
+}
+
+/*
+ * This is only an example!
+ */
+
+int main ()
+{
+	printf("%ld\n", f(15));
+	return 0;
+}
+
+/* incomplete lines are bad! */
+
+commit refs/tags/simple
+mark :14
+author Thomas Rast <trast@student.ethz.ch> 1362044923 +0100
+committer Thomas Rast <trast@student.ethz.ch> 1362044923 +0100
+data 29
+change back to complete line
+from :12
+M 100644 :13 a.c
+
+commit refs/tags/move-support
+mark :15
+author Thomas Rast <trast@student.ethz.ch> 1362044968 +0100
+committer Thomas Rast <trast@student.ethz.ch> 1362044968 +0100
+data 10
+move file
+from :14
+D a.c
+M 100644 :13 b.c
+
+blob
+mark :16
+data 237
+#include <unistd.h>
+#include <stdio.h>
+
+long f(long x)
+{
+	int s = 0;
+	while (x) {
+		x /= 2;
+		s++;
+	}
+	return s;
+}
+
+/*
+ * This is only an example!
+ */
+
+int main ()
+{
+	printf("%ld\n", f(15));
+	return 0;
+}
+
+/* incomplete lines are bad! */
+
+commit refs/tags/move-support
+mark :17
+author Thomas Rast <trast@student.ethz.ch> 1362044990 +0100
+committer Thomas Rast <trast@student.ethz.ch> 1362044990 +0100
+data 22
+another simple change
+from :15
+M 100644 :16 b.c
+
+blob
+mark :18
+data 254
+#include <unistd.h>
+#include <stdio.h>
+
+long f(long x);
+
+/*
+ * This is only an example!
+ */
+
+int main ()
+{
+	printf("%ld\n", f(15));
+	return 0;
+}
+
+/* incomplete lines are bad! */
+
+long f(long x)
+{
+	int s = 0;
+	while (x) {
+		x /= 2;
+		s++;
+	}
+	return s;
+}
+
+commit refs/heads/master
+mark :19
+author Thomas Rast <trast@student.ethz.ch> 1362045024 +0100
+committer Thomas Rast <trast@student.ethz.ch> 1362045024 +0100
+data 21
+move within the file
+from :17
+M 100644 :18 b.c
+
+reset refs/heads/master
+from :19
+
-- 
1.8.2.446.g2b4de83
