From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 4/8] Implement line-history search (git log -L)
Date: Tue, 14 Dec 2010 03:03:27 +0100
Message-ID: <3da6806ebdc0ff742a3a897838aac389de91fc38.1292291624.git.trast@student.ethz.ch>
References: <cover.1292291624.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bo Yang <struggleyb.nku@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 03:04:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSKFZ-0008W1-4Z
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 03:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759070Ab0LNCDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 21:03:52 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:52107 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759033Ab0LNCDg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 21:03:36 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:29 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163620>

From: Bo Yang <struggleyb.nku@gmail.com>

'struct diff_line_range' is the main data structure to keep
track of the line ranges we are currently interested in. The
user starts digging from a line range, and after examining the
diff that affects that range by a commit, we can find a new
range that corresponds to this range. So, we will associate this
new range with the commit's parent commit.

There is one 'diff_line_range' for each file, and there are
multiple 'struct line_range' in each 'diff_line_range'. In this way,
we support multiple ranges.

Within 'struct line_range', there are multiple 'struct print_range'
which represent a diff hunk.

When going from a commit to its parents, we map the "interesting"
range of lines according to the change made.  For non-merge commits,
we just run map_range on the ranges, which works as follows:

1. Run diffcore_std to find out the pre/postimage for each file.
2. Run xdi_diff_hunks on each interesting set of pre/postimages.
3. The map_range_cb callback is invoked for each hunk by the diff
   engine, and we use it to calculate the pre-image range from the
   post-image range in the function map_lines.

For merge commits, we run map_range once for every parent.  After that
we use a take_range pass to eliminate all ranges that are identical.
If any ranges remain after that, then the merge is considered
non-trivial.

The algorithm that maps lines from post-image to pre-image is in the
function map_lines.

To correctly track the line ranges over several branches, we must make
sure that we have processed all children before reaching the commit
itself.  So we let the revision machinery topo-order the commits
before doing anything.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/blame-options.txt     |   19 +-
 Documentation/git-log.txt           |   18 +
 Documentation/line-range-format.txt |   18 +
 builtin/log.c                       |   73 ++-
 line.c                              | 1332 ++++++++++++++++++++++++++++++++++-
 line.h                              |   49 ++
 revision.c                          |    6 +
 revision.h                          |   11 +-
 t/t4301-log-line-single-history.sh  |  685 ++++++++++++++++++
 9 files changed, 2187 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/line-range-format.txt
 create mode 100755 t/t4301-log-line-single-history.sh

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 16e3c68..3526835 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -13,24 +13,7 @@
 	Annotate only the given line range.  <start> and <end> can take
 	one of these forms:
 
-	- number
-+
-If <start> or <end> is a number, it specifies an
-absolute line number (lines count from 1).
-+
-
-- /regex/
-+
-This form will use the first line matching the given
-POSIX regex.  If <end> is a regex, it will search
-starting at the line given by <start>.
-+
-
-- +offset or -offset
-+
-This is only valid for <end> and will specify a number
-of lines before or after the line given by <start>.
-+
+include::line-range-format.txt[]
 
 -l::
 	Show long rev (Default: off).
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index ff41784..7fcf6e7 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -66,6 +66,19 @@ produced by --stat etc.
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
 [\--] <path>...::
 	Show only commits that affect any of the specified paths. To
 	prevent confusion with options and branch names, paths may need
@@ -132,6 +145,11 @@ git log -p -m --first-parent::
 	This makes sense only when following a strict policy of merging all
 	topic branches when staying on a single integration branch.
 
+git log -L '/int main/',/^}/:main.c::
+
+	Shows how the function `main()` in the file 'main.c' evolved
+	over time.
+
 
 Discussion
 ----------
diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
new file mode 100644
index 0000000..265bc23
--- /dev/null
+++ b/Documentation/line-range-format.txt
@@ -0,0 +1,18 @@
+- number
++
+If <start> or <end> is a number, it specifies an
+absolute line number (lines count from 1).
++
+
+- /regex/
++
+This form will use the first line matching the given
+POSIX regex.  If <end> is a regex, it will search
+starting at the line given by <start>.
++
+
+- +offset or -offset
++
+This is only valid for <end> and will specify a number
+of lines before or after the line given by <start>.
++
diff --git a/builtin/log.c b/builtin/log.c
index d8c6c28..342d4de 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -19,6 +19,7 @@
 #include "remote.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "line.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -28,10 +29,21 @@
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
-static const char * const builtin_log_usage =
+static char builtin_log_usage[] =
 	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
 	"   or: git show [options] <object>...";
 
+static const char *log_opt_usage[] = {
+	builtin_log_usage,
+	NULL
+};
+
+struct line_opt_callback_data {
+	struct rev_info *rev;
+	const char *prefix;
+	struct diff_line_range *ranges, *cur_range;
+};
+
 static int parse_decoration_style(const char *var, const char *value)
 {
 	switch (git_config_maybe_bool(var, value)) {
@@ -49,12 +61,53 @@ static int parse_decoration_style(const char *var, const char *value)
 	return -1;
 }
 
+static int log_line_range_callback(const struct option *option, const char *arg, int unset)
+{
+	struct line_opt_callback_data *data = option->value;
+	struct diff_line_range *r;
+	const char *name_start, *range_arg, *full_path;
+	const char *prefix = data->prefix;
+
+	if (!arg)
+		return -1;
+
+	name_start = skip_range_arg(arg);
+	if (!name_start || *name_start != ':')
+		die("-L argument '%s' not of the form start,end:file", arg);
+
+	range_arg = xstrndup(arg, name_start-arg);
+	name_start++;
+
+	full_path = prefix_path(prefix, prefix ? strlen(prefix) : 0,
+				name_start);
+
+	r = xmalloc(sizeof(struct diff_line_range));
+	diff_line_range_init(r);
+	if (data->cur_range)
+		data->cur_range->next = r;
+	else
+		data->ranges = r;
+	data->cur_range = r;
+	r->spec = alloc_filespec(full_path);
+	diff_line_range_append(r, range_arg);
+	data->rev->line_level_traverse = 1;
+	return 0;
+}
+
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	int i;
 	int decoration_given = 0;
 	struct userformat_want w;
+	static struct line_opt_callback_data line_cb = {0};
+
+	static const struct option options[] = {
+		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
+			     "Process line range n,m in file, counting from 1",
+			     log_line_range_callback),
+		OPT_END()
+	};
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
@@ -75,6 +128,14 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	 */
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_log_usage);
+
+	line_cb.rev = rev;
+	line_cb.prefix = prefix;
+
+	argc = parse_options(argc, argv, prefix, options, log_opt_usage,
+			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_KEEP_UNKNOWN);
+
 	argc = setup_revisions(argc, argv, rev, opt);
 
 	memset(&w, 0, sizeof(w));
@@ -125,6 +186,11 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		rev->show_decorations = 1;
 		load_ref_decorations(decoration_style);
 	}
+
+	/* Test whether line level history is asked for */
+	if (rev->line_level_traverse)
+		line_log_init(rev, line_cb.ranges);
+
 	setup_pager();
 }
 
@@ -509,7 +575,10 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
-	return cmd_log_walk(&rev);
+	if (rev.line_level_traverse)
+		return line_log_walk(&rev);
+	else
+		return cmd_log_walk(&rev);
 }
 
 /* format-patch */
diff --git a/line.c b/line.c
index 29898ec..fe7609c 100644
--- a/line.c
+++ b/line.c
@@ -1,6 +1,124 @@
 #include "git-compat-util.h"
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
 #include "line.h"
 
+struct print_range {
+	int start, end;		/* Line range of post-image */
+	int pstart, pend;	/* Line range of pre-image */
+	int line_added : 1;	/* whether this range is added */
+};
+
+struct print_pair {
+	int alloc, nr;
+	struct print_range *ranges;
+};
+
+struct line_range {
+	const char *arg;	/* The argument to specify this line range */
+	long start, end;	/* The interesting line range of current commit */
+	long pstart, pend;	/* The corresponding range of parent commit */
+	struct print_pair pair;
+			/* The changed lines inside this range */
+	unsigned int diff:1;
+};
+
+/*
+ * Eek-a-global
+ */
+
+static int limited;
+
+/*
+ * These could be in line.h but we put them here so the functions can
+ * be static.
+ */
+
+static struct line_range *diff_line_range_insert(struct diff_line_range *r,
+	       const char *arg, int start, int end);
+
+static void diff_line_range_clear(struct diff_line_range *r);
+
+static struct diff_line_range *diff_line_range_merge(
+	       struct diff_line_range *out,
+	       struct diff_line_range *other);
+
+static struct diff_line_range *diff_line_range_clone(struct diff_line_range *r);
+
+static struct diff_line_range *diff_line_range_clone_deeply(struct diff_line_range *r);
+
+static void add_line_range(struct rev_info *revs, struct commit *commit,
+	       struct diff_line_range *r);
+
+static struct diff_line_range *lookup_line_range(struct rev_info *revs,
+	       struct commit *commit);
+
+/*
+ * Data structure helpers
+ */
+
+static inline void print_range_init(struct print_range *r)
+{
+	r->start = r->end = 0;
+	r->pstart = r->pend = 0;
+	r->line_added = 0;
+}
+
+static inline void print_pair_init(struct print_pair *p)
+{
+	p->alloc = p->nr = 0;
+	p->ranges = NULL;
+}
+
+static inline void print_pair_grow(struct print_pair *p)
+{
+	p->nr++;
+	ALLOC_GROW(p->ranges, p->nr, p->alloc);
+}
+
+static inline void print_pair_clear(struct print_pair *p)
+{
+	p->alloc = p->nr = 0;
+	if (p->ranges)
+		free(p->ranges);
+	p->ranges = NULL;
+}
+
+static inline void line_range_init(struct line_range *r)
+{
+	r->arg = NULL;
+	r->start = r->end = 0;
+	r->pstart = r->pend = 0;
+	print_pair_init(&(r->pair));
+	r->copy_score = 0;
+	r->diff = 0;
+}
+
+static inline void line_range_clear(struct line_range *r)
+{
+	r->arg = NULL;
+	r->start = r->end = 0;
+	r->pstart = r->pend = 0;
+	print_pair_clear(&r->pair);
+	r->diff = 0;
+}
+
+static inline void diff_line_range_grow(struct diff_line_range *r)
+{
+	r->nr++;
+	ALLOC_GROW(r->ranges, r->nr, r->alloc);
+	line_range_init((r->ranges + r->nr - 1));
+}
+
 /*
  * Parse one item in the -L option
  */
@@ -17,7 +135,8 @@
         /* Catch the '$' matcher, now it is used to match the last
          * line of the file. */
         if (spec[0] == '$') {
-                *ret = lines;
+		if (ret)
+			*ret = lines;
                 return spec + 1;
         }
 
@@ -28,6 +147,8 @@
 	if (begin != -1 && (spec[0] == '+' || spec[0] == '-')) {
                 num = strtol(spec + 1, &term, 10);
                 if (term != spec + 1) {
+			if (!ret)
+				return term;
                         if (spec[0] == '-')
                                 num = 0 - num;
                         if (0 < num)
@@ -42,7 +163,8 @@
         }
         num = strtol(spec, &term, 10);
         if (term != spec) {
-                *ret = num;
+		if (ret)
+			*ret = num;
                 return term;
         }
         if (spec[0] != '/')
@@ -56,6 +178,10 @@
         if (*term != '/')
                 return spec;
 
+	/* in the scan-only case we are not interested in the regex */
+	if (!ret)
+		return term+1;
+
         /* try [spec+1 .. term-1] as regexp */
         *term = 0;
 	if (begin == -1)
@@ -104,3 +230,1205 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 
 	return 0;
 }
+
+const char *skip_range_arg(const char *arg)
+{
+	arg = parse_loc(arg, NULL, NULL, 0, -1, 0);
+
+	if (*arg == ',')
+		arg = parse_loc(arg+1, NULL, NULL, 0, 0, 0);
+
+	return arg;
+}
+
+static void free_diff_line_ranges(struct diff_line_range *r)
+{
+	while (r) {
+		struct diff_line_range *next = r->next;
+		diff_line_range_clear(r);
+		free(r);
+		r = next;
+	}
+}
+
+static struct object *verify_commit(struct rev_info *revs)
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
+				revs->pending.objects[found].name);
+		commit = obj;
+		found = i;
+	}
+
+	if (!commit)
+		die("No commit specified?");
+
+	return commit;
+}
+
+static void fill_blob_sha1(struct commit *commit, struct diff_line_range *r)
+{
+	unsigned mode;
+	unsigned char sha1[20];
+
+	while (r) {
+		if (get_tree_entry(commit->object.sha1, r->spec->path,
+			sha1, &mode))
+			goto error;
+		fill_filespec(r->spec, sha1, mode);
+		r = r->next;
+	}
+
+	return;
+error:
+	die("There is no path %s in the commit", r->spec->path);
+}
+
+static void fill_line_ends(struct diff_filespec *spec, long *lines,
+	unsigned long **line_ends)
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
+	*lines = cur;
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
+	assert(d && line < d->lines);
+	assert(d->spec && d->spec->data);
+
+	if (line == 0)
+		return (char *)d->spec->data;
+	else
+		return (char *)d->spec->data + d->line_ends[line] + 1;
+}
+
+static void parse_lines(struct commit *commit, struct diff_line_range *r)
+{
+	int i;
+	struct line_range *old_range = NULL;
+	long lines = 0;
+	unsigned long *ends = NULL;
+	struct nth_line_cb cb_data;
+
+	while (r) {
+		struct diff_filespec *spec = r->spec;
+		int num = r->nr;
+		assert(spec);
+		fill_blob_sha1(commit, r);
+		old_range = r->ranges;
+		r->ranges = NULL;
+		r->nr = r->alloc = 0;
+		fill_line_ends(spec, &lines, &ends);
+		cb_data.spec = spec;
+		cb_data.lines = lines;
+		cb_data.line_ends = ends;
+		for (i = 0; i < num; i++) {
+			long begin, end;
+			if (parse_range_arg(old_range[i].arg, nth_line, &cb_data,
+					    lines-1, &begin, &end))
+				die("malformed -L argument '%s'", old_range[i].arg);
+			diff_line_range_insert(r, old_range[i].arg, begin, end);
+		}
+
+		free(ends);
+		ends = NULL;
+
+		r = r->next;
+		free(old_range);
+	}
+}
+
+/*
+ * Insert a new line range into a diff_line_range struct, and keep the
+ * r->ranges sorted by their starting line number.
+ */
+static struct line_range *diff_line_range_insert(struct diff_line_range *r,
+		const char *arg, int start, int end)
+{
+	int i = 0;
+	struct line_range *rs = r->ranges;
+	int left_merge = 0, right_merge = 0;
+
+	assert(r);
+	assert(start <= end);
+
+	if (r->nr == 0 || rs[r->nr - 1].end < start - 1) {
+		int num = 0;
+		diff_line_range_grow(r);
+		rs = r->ranges;
+		num = r->nr - 1;
+		rs[num].arg = arg;
+		rs[num].start = start;
+		rs[num].end = end;
+		return rs + num;
+	}
+
+	for (; i < r->nr; i++) {
+		if (rs[i].end < start - 1)
+			continue;
+		if (rs[i].end == start - 1) {
+			rs[i].end = end;
+			right_merge = 1;
+			goto out;
+		}
+
+		assert(rs[i].end > start - 1);
+		if (rs[i].start <= start) {
+			if (rs[i].end < end) {
+				rs[i].end = end;
+				right_merge = 1;
+			}
+			goto out;
+		} else if (rs[i].start <= end + 1) {
+			rs[i].start = start;
+			left_merge = 1;
+			if (rs[i].end < end) {
+				rs[i].end = end;
+				right_merge = 1;
+			}
+			goto out;
+		} else {
+			int num = r->nr - i;
+			diff_line_range_grow(r);
+			rs = r->ranges;
+			memmove(rs + i + 1, rs + i, num * sizeof(struct line_range));
+			rs[i].arg = arg;
+			rs[i].start = start;
+			rs[i].end = end;
+			goto out;
+		}
+	}
+
+out:
+	assert(r->nr != i);
+	if (left_merge) {
+		int j = i;
+		for (; j > -1; j--) {
+			if (rs[j].end >= rs[i].start - 1)
+				if (rs[j].start < rs[i].start)
+					rs[i].start = rs[j].start;
+		}
+		memmove(rs + j + 1, rs + i, (r->nr - i) * sizeof(struct line_range));
+		r->nr -= i - j - 1;
+	}
+	if (right_merge) {
+		int j = i;
+		for (; j < r->nr; j++) {
+			if (rs[j].start <= rs[i].end + 1)
+				if (rs[j].end > rs[i].end)
+					rs[i].end = rs[j].end;
+		}
+		if (j < r->nr)
+			memmove(rs + i + 1, rs + j, (r->nr - j) * sizeof(struct line_range));
+		r->nr -= j - i - 1;
+	}
+	assert(r->nr);
+
+	return rs + i;
+}
+
+static void diff_line_range_clear(struct diff_line_range *r)
+{
+	int i = 0, zero = 0;
+
+	for (; i < r->nr; i++) {
+		struct line_range *rg = r->ranges + i;
+		line_range_clear(rg);
+	}
+
+	if (r->prev) {
+		zero = 0;
+		if (r->prev->count == 1)
+			zero = 1;
+		free_filespec(r->prev);
+		if (zero)
+			r->prev = NULL;
+	}
+	if (r->spec) {
+		zero = 0;
+		if (r->spec->count == 1)
+			zero = 1;
+		free_filespec(r->spec);
+		if (zero)
+			r->spec = NULL;
+	}
+
+	r->status = '\0';
+	r->alloc = r->nr = 0;
+
+	if (r->ranges)
+		free(r->ranges);
+	r->ranges = NULL;
+	r->next = NULL;
+}
+
+void diff_line_range_append(struct diff_line_range *r, const char *arg)
+{
+	diff_line_range_grow(r);
+	r->ranges[r->nr - 1].arg = arg;
+}
+
+static struct diff_line_range *diff_line_range_clone(struct diff_line_range *r)
+{
+	struct diff_line_range *ret = xmalloc(sizeof(*ret));
+	int i = 0;
+
+	assert(r);
+	diff_line_range_init(ret);
+	ret->ranges = xcalloc(r->nr, sizeof(struct line_range));
+	memcpy(ret->ranges, r->ranges, sizeof(struct line_range) * r->nr);
+
+	ret->alloc = ret->nr = r->nr;
+
+	for (; i < ret->nr; i++)
+		print_pair_init(&ret->ranges[i].pair);
+
+	ret->spec = r->spec;
+	assert(ret->spec);
+	ret->spec->count++;
+
+	return ret;
+}
+
+static struct diff_line_range *
+diff_line_range_clone_deeply(struct diff_line_range *r)
+{
+	struct diff_line_range *ret = NULL;
+	struct diff_line_range *tmp = NULL, *prev = NULL;
+
+	assert(r);
+	ret = tmp = prev = diff_line_range_clone(r);
+	r = r->next;
+	while (r) {
+		tmp = diff_line_range_clone(r);
+		prev->next = tmp;
+		prev = tmp;
+		r = r->next;
+	}
+
+	return ret;
+}
+
+static struct diff_line_range *diff_line_range_merge(struct diff_line_range *out,
+		struct diff_line_range *other)
+{
+	struct diff_line_range *one = out, *two = other;
+	struct diff_line_range *pone = NULL;
+
+	while (one) {
+		struct diff_line_range *ptwo;
+		two = other;
+		ptwo = other;
+		while (two) {
+			if (!strcmp(one->spec->path, two->spec->path)) {
+				int i = 0;
+				for (; i < two->nr; i++) {
+					diff_line_range_insert(one, NULL,
+						two->ranges[i].start,
+						two->ranges[i].end);
+				}
+				if (two == other)
+					other = other->next;
+				else
+					ptwo->next = two->next;
+				diff_line_range_clear(two);
+				free(two);
+				two = NULL;
+
+				break;
+			}
+
+			ptwo = two;
+			two = two->next;
+		}
+
+		pone = one;
+		one = one->next;
+	}
+	pone->next = other;
+
+	return out;
+}
+
+static void add_line_range(struct rev_info *revs, struct commit *commit,
+		struct diff_line_range *r)
+{
+	struct diff_line_range *ret = NULL;
+
+	if (r) {
+		ret = lookup_decoration(&revs->line_range, &commit->object);
+		if (ret)
+			diff_line_range_merge(ret, r);
+		else
+			add_decoration(&revs->line_range, &commit->object, r);
+		commit->object.flags |= RANGE_UPDATE;
+	}
+}
+
+static void clear_commit_line_range(struct rev_info *revs, struct commit *commit)
+{
+	struct diff_line_range *r;
+	r = lookup_decoration(&revs->line_range, &commit->object);
+	if (!r)
+		return;
+	free_diff_line_ranges(r);
+	add_decoration(&revs->line_range, &commit->object, NULL);
+}
+
+static struct diff_line_range *lookup_line_range(struct rev_info *revs,
+		struct commit *commit)
+{
+	struct diff_line_range *ret = NULL;
+
+	ret = lookup_decoration(&revs->line_range, &commit->object);
+	return ret;
+}
+
+void line_log_init(struct rev_info *rev, struct diff_line_range *r)
+{
+	struct commit *commit = NULL;
+	struct diff_options *opt = &rev->diffopt;
+
+	commit = (struct commit *)verify_commit(rev);
+	parse_lines(commit, r);
+
+	add_line_range(rev, commit, r);
+	/*
+	 * Note we support -M/-C to detect file rename
+	 */
+	opt->nr_paths = 0;
+	diff_tree_release_paths(opt);
+}
+
+struct take_range_cb_data {
+	struct diff_line_range *interesting;	/* currently interesting ranges */
+	struct diff_line_range *range;
+		/* the ranges corresponds to the interesting ranges of parent commit */
+	long plno, tlno;
+		/* the last line number of diff hunk */
+	int diff;
+		/* whether there is some line changes between the current
+		 * commit and its parent */
+};
+
+#define SCALE_FACTOR 4
+/*
+ * [p_start, p_end] represents the pre-image of current diff hunk,
+ * [t_start, t_end] represents the post-image of the current diff hunk,
+ * [start, end] represents the currently interesting line range in
+ * post-image,
+ * [o_start, o_end] represents the original line range that coresponds
+ * to current line range.
+ */
+void map_lines(long p_start, long p_end, long t_start, long t_end,
+		long start, long end, long *o_start, long *o_end)
+{
+	/*
+	 * Normally, p_start should be less than p_end, so does the
+	 * t_start and t_end. But when the line range is added from
+	 * scratch, p_start will be greater than p_end. When the line
+	 * range is deleted, t_start will be greater than t_end.
+	 */
+	if (p_start > p_end) {
+		*o_start = *o_end = 0;
+		return;
+	}
+	/* A deletion */
+	if (t_start > t_end) {
+		*o_start = p_start;
+		*o_end = p_end;
+		return;
+	}
+
+	if (start == t_start && end == t_end) {
+		*o_start = p_start;
+		*o_end = p_end;
+		return;
+	}
+
+	/*
+	 * A heuristic for lines mapping:
+	 *
+	 * When the pre-image is no more than 1/SCALE_FACTOR of the post-image,
+	 * there is no effective way to find out which part of pre-image
+	 * corresponds to the currently interesting range of post-image.
+	 * And we are in the danger of tracking totally useless lines.
+	 * So, we just treat all the post-image lines as added from scratch.
+	 */
+	if (SCALE_FACTOR * (p_end - p_start + 1) < (t_end - t_start + 1)) {
+		*o_start = *o_end = 0;
+		return;
+	}
+
+	*o_start = p_start + start - t_start;
+	*o_end = p_end - (t_end - end);
+
+	if (*o_start > *o_end) {
+		int temp = *o_start;
+		*o_start = *o_end;
+		*o_end = temp;
+	}
+
+	if (*o_start < p_start)
+		*o_start = p_start;
+	if (*o_end > p_end)
+		*o_end = p_end;
+}
+
+/*
+ * When same == 1:
+ * [p_start, p_end] represents the diff hunk line range of pre-image,
+ * [t_start, t_end] represents the diff hunk line range of post-image.
+ * When same == 0, they represent a range of identical lines between
+ * two images.
+ *
+ * This function find out the corresponding line ranges of currently
+ * interesting ranges which this diff hunk touches.
+ */
+static void map_range(struct take_range_cb_data *data, int same,
+		long p_start, long p_end, long t_start, long t_end)
+{
+	struct line_range *ranges = data->interesting->ranges;
+	long takens, takene, start, end;
+	int i = 0, out = 0, added = 0;
+	long op_start = p_start, op_end = p_end, ot_start = t_start, ot_end = t_end;
+
+	for (; i < data->interesting->nr; i++) {
+		added = 0;
+		if (t_start > ranges[i].end)
+			continue;
+		if (t_end < ranges[i].start)
+			break;
+
+		if (t_start > ranges[i].start) {
+			start = t_start;
+			takens = p_start;
+		} else {
+			start = ranges[i].start;
+			takens = p_start + start - t_start;
+		}
+
+		if (t_end >= ranges[i].end) {
+			end = ranges[i].end;
+			takene = p_start + end - t_start;
+		} else {
+			end = t_end;
+			takene = p_end;
+			out = 1;
+		}
+
+		if (!same) {
+			struct print_pair *pair = &ranges[i].pair;
+			struct print_range *rr = NULL;
+			print_pair_grow(pair);
+			rr = pair->ranges + pair->nr - 1;
+			print_range_init(rr);
+			rr->start = start;
+			rr->end = end;
+			map_lines(op_start, op_end, ot_start, ot_end, start, end,
+					&takens, &takene);
+			if (takens == 0 && takene == 0) {
+				added = 1;
+				rr->line_added = 1;
+			}
+			rr->pstart = takens;
+			rr->pend = takene;
+			data->diff = 1;
+			data->interesting->diff = 1;
+			ranges[i].diff = 1;
+		}
+		if (added) {
+			/* Code movement/copy goes here */
+		} else {
+			struct line_range *added_range = diff_line_range_insert(data->range,
+					NULL, takens, takene);
+			assert(added_range);
+			ranges[i].pstart = added_range->start;
+			ranges[i].pend = added_range->end;
+		}
+
+		t_start = end + 1;
+		p_start = takene + 1;
+
+		if (out)
+			break;
+	}
+}
+
+/*
+ * [p_start, p_end] represents the line range of pre-image,
+ * [t_start, t_end] represents the line range of post-image,
+ * and they are identical lines.
+ *
+ * This function substracts out the identical lines between current
+ * commit and its parent, from currently interesting ranges.
+ */
+static void take_range(struct take_range_cb_data *data,
+		long p_start, long p_end, long t_start, long t_end)
+{
+	struct line_range *ranges = data->interesting->ranges;
+	long takens, takene, start, end;
+	int i = 0, out = 0, added = 0;
+
+	for (; i < data->interesting->nr; i++) {
+		added = 0;
+		if (t_start > ranges[i].end)
+			continue;
+		if (t_end < ranges[i].start)
+			break;
+
+		if (t_start > ranges[i].start) {
+			long tmp = ranges[i].end;
+			ranges[i].end = t_start - 1;
+			start = t_start;
+			takens = p_start;
+			if (t_end >= tmp) {
+				end = tmp;
+				takene = p_start + end - t_start;
+				p_start = takene + 1;
+				t_start = end + 1;
+			} else {
+				end = t_end;
+				takene = p_end;
+				diff_line_range_insert(data->interesting, NULL,
+					t_end + 1, tmp);
+				out = 1;
+			}
+		} else {
+			start = ranges[i].start;
+			takens = p_start + start - t_start;
+			if (t_end >= ranges[i].end) {
+				int num = data->interesting->nr - 1;
+				end = ranges[i].end;
+				takene = p_start + end - t_start;
+				t_start = end + 1;
+				p_start = takene + 1;
+				memmove(ranges + i, ranges + i + 1, (num - i) * sizeof(*ranges));
+				data->interesting->nr = num;
+				i--;
+			} else {
+				end = t_end;
+				takene = p_end;
+				ranges[i].start = t_end + 1;
+				out = 1;
+			}
+		}
+
+		diff_line_range_insert(data->range, NULL, takens, takene);
+
+		if (out)
+			break;
+	}
+}
+
+static void take_range_cb(void *data, long same, long p_next, long t_next)
+{
+	struct take_range_cb_data *d = data;
+	long p_start = d->plno + 1, t_start = d->tlno + 1;
+	long p_end = p_start + same - t_start, t_end = same;
+
+	/* If one file is added from scratch, we should not bother to call
+	 * take_range, since there is nothing to take
+	 */
+	if (t_end >= t_start)
+		take_range(d, p_start, p_end, t_start, t_end);
+	d->plno = p_next;
+	d->tlno = t_next;
+}
+
+static void map_range_cb(void *data, long same, long p_next, long t_next)
+{
+	struct take_range_cb_data *d = data;
+
+	long p_start = d->plno + 1;
+	long t_start = d->tlno + 1;
+	long p_end = same - t_start + p_start;
+	long t_end = same;
+
+	/* Firstly, take the unchanged lines from child */
+	if (t_end >= t_start)
+		map_range(d, 1, p_start, p_end, t_start, t_end);
+
+	/* find out which lines to print */
+	t_start = same + 1;
+	p_start = d->plno + t_start - d->tlno;
+	map_range(d, 0, p_start, p_next, t_start, t_next);
+
+	d->plno = p_next;
+	d->tlno = t_next;
+}
+
+static void load_tree_desc(struct tree_desc *desc, void **tree,
+		const unsigned char *sha1)
+{
+	unsigned long size;
+	*tree = read_object_with_reference(sha1, tree_type, &size, NULL);
+	if (!tree)
+		die("Unable to read tree (%s)", sha1_to_hex(sha1));
+	init_tree_desc(desc, *tree, size);
+}
+
+/*
+ * We support two kinds of operation in this function:
+ * 1. map == 0, take the same lines from the current commit and assign it
+ *              to parent;
+ * 2. map == 1, in addition to the same lines, we also map the changed lines
+ *              from the current commit to the parent according to the
+ *              diff output.
+ * take_range_cb and take_range are used to take same lines from current commit
+ * to parents.
+ * map_range_cb and map_range are used to map line ranges to the parent.
+ */
+static void assign_range_to_parent(struct rev_info *rev, struct commit *commit,
+		struct commit *parent, struct diff_line_range *range,
+		struct diff_options *opt, int map)
+{
+	struct diff_line_range *final_range = xmalloc(sizeof(*final_range));
+	struct diff_line_range *cur_range = final_range;
+	struct diff_line_range *prev_range = final_range;
+	struct diff_line_range *rg = NULL;
+	void *tree1 = NULL, *tree2 = NULL;
+	struct tree_desc desc1, desc2;
+	struct diff_queue_struct *queue;
+	struct take_range_cb_data cb_data = {NULL, cur_range, 0, 0};
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	int i, diff = 0;
+	xdiff_emit_hunk_consume_fn fn = map ? map_range_cb : take_range_cb;
+
+	diff_line_range_init(cur_range);
+	memset(&xpp, 0, sizeof(xpp));
+	memset(&xecfg, 0, sizeof(xecfg));
+	xecfg.ctxlen = xecfg.interhunkctxlen = 0;
+
+	/*
+	 * Compose up two trees, for root commit, we make up a empty tree.
+	 */
+	assert(commit);
+	load_tree_desc(&desc2, &tree2, commit->tree->object.sha1);
+	if (parent) {
+		load_tree_desc(&desc1, &tree1, parent->tree->object.sha1);
+	} else {
+		init_tree_desc(&desc1, "", 0);
+	}
+
+	DIFF_QUEUE_CLEAR(&diff_queued_diff);
+	diff_tree(&desc1, &desc2, "", opt);
+	diffcore_std(opt);
+
+	queue = &diff_queued_diff;
+	for (i = 0; i < queue->nr; i++) {
+		struct diff_filepair *pair = queue->queue[i];
+		struct diff_line_range *rg = range;
+		mmfile_t file_parent, file_t;
+		assert(pair->two->path);
+		while (rg) {
+			assert(rg->spec->path);
+			if (!strcmp(rg->spec->path, pair->two->path))
+				break;
+			rg = rg->next;
+		}
+
+		if (!rg)
+			continue;
+		rg->touched = 1;
+		if (rg->nr == 0)
+			continue;
+
+		rg->status = pair->status;
+		assert(pair->two->sha1_valid);
+		diff_populate_filespec(pair->two, 0);
+		file_t.ptr = pair->two->data;
+		file_t.size = pair->two->size;
+
+		if (rg->prev)
+			free_filespec(rg->prev);
+		rg->prev = pair->one;
+		rg->prev->count++;
+		if (pair->one->sha1_valid) {
+			diff_populate_filespec(pair->one, 0);
+			file_parent.ptr = pair->one->data;
+			file_parent.size = pair->one->size;
+		} else {
+			file_parent.ptr = "";
+			file_parent.size = 0;
+		}
+
+		if (cur_range->nr != 0) {
+			struct diff_line_range *tmp = xmalloc(sizeof(*tmp));
+			cur_range->next = tmp;
+			prev_range = cur_range;
+			cur_range = tmp;
+		} else if (cur_range->spec)
+			diff_line_range_clear(cur_range);
+
+		diff_line_range_init(cur_range);
+		if (pair->one->sha1_valid) {
+			cur_range->spec = pair->one;
+			cur_range->spec->count++;
+		} else {
+			assert(is_null_sha1(pair->one->sha1));
+			cur_range->spec = pair->two;
+			cur_range->spec->count++;
+		}
+
+		cb_data.interesting = rg;
+		cb_data.range = cur_range;
+		cb_data.diff = 0;
+		cb_data.plno = cb_data.tlno = 0;
+		xdi_diff_hunks(&file_parent, &file_t, fn, &cb_data, &xpp, &xecfg);
+		if (cb_data.diff)
+			diff = 1;
+		/*
+		 * The remain part is the same part.
+		 * Instead of calculating the true line number of the two files,
+		 * use the biggest integer.
+		 */
+		if (map)
+			map_range(&cb_data, 1, cb_data.plno + 1,
+				  INT_MAX, cb_data.tlno + 1, INT_MAX);
+		else
+			take_range(&cb_data, cb_data.plno + 1,
+				   INT_MAX, cb_data.tlno + 1, INT_MAX);
+	}
+	opt->output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_flush(opt);
+
+	/*
+	 * Collect the untouched ranges, this comes from the files not changed
+	 * between two commit.
+	 */
+	rg = range;
+	while (rg) {
+		/* clear the touched one to make it usable in next round */
+		if (rg->touched) {
+			rg->touched = 0;
+		} else {
+			struct diff_line_range *untouched = diff_line_range_clone(rg);
+			if (prev_range == final_range && final_range->nr == 0) {
+				final_range = prev_range = untouched;
+			} else {
+				prev_range->next = untouched;
+				prev_range = untouched;
+			}
+		}
+		rg = rg->next;
+	}
+
+	if (cur_range->nr == 0) {
+		diff_line_range_clear(cur_range);
+		free(cur_range);
+		if (prev_range == cur_range)
+			final_range = NULL;
+		else
+			prev_range->next = NULL;
+	}
+
+	if (final_range) {
+		assert(parent);
+		assert(final_range->spec);
+		add_line_range(rev, parent, final_range);
+	}
+
+	/* and the ranges of current commit is updated */
+	commit->object.flags &= ~RANGE_UPDATE;
+	if (diff)
+		commit->object.flags |= NEED_PRINT;
+
+	if (tree1)
+		free(tree1);
+	if (tree2)
+		free(tree2);
+}
+
+static void diff_update_parent_range(struct rev_info *rev,
+		struct commit *commit)
+{
+	struct diff_line_range *r = lookup_line_range(rev, commit);
+	struct commit_list *parents = commit->parents;
+	struct commit *c = NULL;
+	if (parents) {
+		assert(!parents->next);
+		c = parents->item;
+	}
+
+	assign_range_to_parent(rev, commit, c, r, &rev->diffopt, 1);
+}
+
+static void assign_parents_range(struct rev_info *rev, struct commit *commit)
+{
+	struct commit_list *parents = commit->parents;
+	struct diff_line_range *r = lookup_line_range(rev, commit);
+	struct diff_line_range *evil = NULL, *range = NULL;
+	int nontrivial = 0;
+
+	/*
+	 * If we are in linear history, update range and flush the patch if
+	 * necessary
+	 */
+	if (!parents || !parents->next)
+		return diff_update_parent_range(rev, commit);
+
+	/*
+	 * Loop on the parents and assign the ranges to different
+	 * parents, if there is any range left, this commit must
+	 * be an evil merge.
+	 */
+	evil = diff_line_range_clone_deeply(r);
+	parents = commit->parents;
+	while (parents) {
+		struct commit *p = parents->item;
+		assign_range_to_parent(rev, commit, p, r, &rev->diffopt, 1);
+		assign_range_to_parent(rev, commit, p, evil, &rev->diffopt, 0);
+		parents = parents->next;
+	}
+
+	/*
+	 * yes, this must be an evil merge.
+	 */
+	range = evil;
+	while (range) {
+		if (range->nr) {
+			commit->object.flags |= NEED_PRINT | EVIL_MERGE;
+			nontrivial = 1;
+		}
+		range = range->next;
+	}
+
+	if (nontrivial)
+		add_decoration(&rev->nontrivial_merge, &commit->object, evil);
+	else
+		free_diff_line_ranges(evil);
+}
+
+struct line_chunk {
+	int lone, ltwo;
+	const char *one, *two;
+	const char *one_end, *two_end;
+	struct diff_line_range *range;
+};
+
+static void flush_lines(struct diff_options *opt, const char **ptr, const char *end,
+		int slno, int elno, int *lno, const char *color, const char heading)
+{
+	const char *p = *ptr;
+	struct strbuf buf = STRBUF_INIT;
+	const char *reset;
+
+	if (*color)
+		reset = diff_get_color_opt(opt, DIFF_RESET);
+	else
+		reset = "";
+
+	strbuf_addf(&buf, "%s%c", color, heading);
+	while (*ptr < end && *lno < slno) {
+		if (**ptr == '\n') {
+			(*lno)++;
+			if (*lno == slno) {
+				(*ptr)++;
+				break;
+			}
+		}
+		(*ptr)++;
+	}
+	assert(*ptr <= end);
+	p = *ptr;
+
+	while (*ptr < end && *lno <= elno) {
+		if (**ptr == '\n') {
+			fprintf(opt->file, "%s", buf.buf);
+			if (*ptr - p)
+				fwrite(p, *ptr - p, 1, opt->file);
+			fprintf(opt->file, "%s\n", reset);
+			p = *ptr + 1;
+			(*lno)++;
+		}
+		(*ptr)++;
+	}
+	if (*lno <= elno) {
+		fprintf(opt->file, "%s", buf.buf);
+		if (*ptr - p)
+			fwrite(p, *ptr - p, 1, opt->file);
+		fprintf(opt->file, "%s\n", reset);
+	}
+	strbuf_release(&buf);
+}
+
+static void diff_flush_range(struct diff_options *opt, struct line_chunk *chunk,
+		struct line_range *range)
+{
+	struct print_pair *pair = &range->pair;
+	const char *old = diff_get_color_opt(opt, DIFF_FILE_OLD);
+	const char *new = diff_get_color_opt(opt, DIFF_FILE_NEW);
+	int i, cur = range->start;
+
+	for (i = 0; i < pair->nr; i++) {
+		struct print_range *pr = pair->ranges + i;
+		if (cur < pr->start)
+			flush_lines(opt, &chunk->two, chunk->two_end,
+				cur, pr->start - 1, &chunk->ltwo, "", ' ');
+
+		if (!pr->line_added)
+			flush_lines(opt, &chunk->one, chunk->one_end,
+				pr->pstart, pr->pend, &chunk->lone, old, '-');
+		flush_lines(opt, &chunk->two, chunk->two_end,
+			pr->start, pr->end, &chunk->ltwo, new, '+');
+
+		cur = pr->end + 1;
+	}
+
+	if (cur <= range->end) {
+		flush_lines(opt, &chunk->two, chunk->two_end,
+			cur, range->end, &chunk->ltwo, "", ' ');
+	}
+}
+
+static void diff_flush_chunks(struct diff_options *opt, struct line_chunk *chunk)
+{
+	struct diff_line_range *range = chunk->range;
+	const char *set = diff_get_color_opt(opt, DIFF_FRAGINFO);
+	const char *reset = diff_get_color_opt(opt, DIFF_RESET);
+	int i;
+
+	for (i = 0; i < range->nr; i++) {
+		struct line_range *r = range->ranges + i;
+		long lenp = r->pend - r->pstart + 1, pstart = r->pstart;
+		long len = r->end - r->start + 1;
+		if (pstart == 0)
+			lenp = 0;
+
+		fprintf(opt->file, "%s@@ -%ld,%ld +%ld,%ld @@%s\n",
+			set, pstart, lenp, r->start, len, reset);
+
+		diff_flush_range(opt, chunk, r);
+	}
+}
+
+static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *range)
+{
+	struct diff_options *opt = &rev->diffopt;
+	struct diff_filespec *one = range->prev, *two = range->spec;
+	struct diff_filepair p = {one, two, range->status, 0};
+	struct strbuf header = STRBUF_INIT, meta = STRBUF_INIT;
+	const char *a_prefix, *b_prefix;
+	const char *name_a, *name_b, *a_one, *b_two;
+	const char *lbl[2];
+	const char *set = diff_get_color_opt(opt, DIFF_METAINFO);
+	const char *reset = diff_get_color_opt(opt, DIFF_RESET);
+	struct line_chunk chunk;
+	int must_show_header;
+
+	/*
+	 * the ranges that touch no different file, in this case
+	 * the line number will not change, and of course we have
+	 * no sensible rang->pair since there is no diff run.
+	 */
+	if (!one)
+		return;
+
+	if (range->status == DIFF_STATUS_DELETED)
+		die("We are following an nonexistent file, interesting!");
+
+	name_a  = one->path;
+	name_b = two->path;
+	fill_metainfo(&meta, name_a, name_b, one, two, opt, &p, &must_show_header,
+			DIFF_OPT_TST(opt, COLOR_DIFF));
+
+	diff_set_mnemonic_prefix(opt, "a/", "b/");
+	if (DIFF_OPT_TST(opt, REVERSE_DIFF)) {
+		a_prefix = opt->b_prefix;
+		b_prefix = opt->a_prefix;
+	} else {
+		a_prefix = opt->a_prefix;
+		b_prefix = opt->b_prefix;
+	}
+
+	name_a = DIFF_FILE_VALID(one) ? name_a : name_b;
+	name_b = DIFF_FILE_VALID(two) ? name_b : name_a;
+
+	a_one = quote_two(a_prefix, name_a + (*name_a == '/'));
+	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
+	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
+	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
+	strbuf_addf(&header, "%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
+	if (lbl[0][0] == '/') {
+		strbuf_addf(&header, "%snew file mode %06o%s\n", set, two->mode, reset);
+	} else if (lbl[1][0] == '/') {
+		strbuf_addf(&header, "%sdeleted file mode %06o%s\n", set, one->mode, reset);
+	} else if (one->mode != two->mode) {
+			strbuf_addf(&header, "%sold mode %06o%s\n", set, one->mode, reset);
+			strbuf_addf(&header, "%snew mode %06o%s\n", set, two->mode, reset);
+	}
+
+	fprintf(opt->file, "%s%s", header.buf, meta.buf);
+	strbuf_release(&meta);
+	strbuf_release(&header);
+	fprintf(opt->file, "%s--- %s%s\n", set, lbl[0], reset);
+	fprintf(opt->file, "%s+++ %s%s\n", set, lbl[1], reset);
+	free((void *)a_one);
+	free((void *)b_two);
+
+	chunk.one = one->data;
+	chunk.one_end = (const char *)one->data + one->size;
+	chunk.lone = 1;
+	chunk.two = two->data;
+	chunk.two_end = (const char *)two->data + two->size;
+	chunk.ltwo = 1;
+	chunk.range = range;
+	diff_flush_chunks(&rev->diffopt, &chunk);
+}
+
+static void flush_nontrivial_merge(struct rev_info *rev,
+		struct diff_line_range *range)
+{
+	struct diff_options *opt = &rev->diffopt;
+	const char *reset = diff_get_color_opt(opt, DIFF_RESET);
+	const char *frag = diff_get_color_opt(opt, DIFF_FRAGINFO);
+	const char *meta = diff_get_color_opt(opt, DIFF_METAINFO);
+	const char *new = diff_get_color_opt(opt, DIFF_FILE_NEW);
+
+	fprintf(opt->file, "%s%s%s\n", meta, "nontrivial merge found", reset);
+
+	while (range) {
+		if (range->nr) {
+			int lno = 1;
+			const char *ptr = range->spec->data;
+			const char *end = range->spec->data + range->spec->size;
+			int i = 0;
+			fprintf(opt->file, "%s%s%s\n\n", meta, range->spec->path, reset);
+			for (; i < range->nr; i++) {
+				struct line_range *r = range->ranges + i;
+				fprintf(opt->file, "%s@@ %ld,%ld @@%s\n", frag, r->start,
+					r->end - r->start + 1, reset);
+				flush_lines(opt, &ptr, end, r->start, r->end,
+					&lno, new, ' ');
+			}
+			fprintf(opt->file, "\n");
+		}
+		range = range->next;
+	}
+}
+
+static void line_log_flush(struct rev_info *rev, struct commit *c)
+{
+	struct diff_line_range *range = lookup_line_range(rev, c);
+	struct diff_line_range *nontrivial = lookup_decoration(&rev->nontrivial_merge, &c->object);
+	struct log_info log;
+
+	if (!range)
+		return;
+
+	log.commit = c;
+	log.parent = NULL;
+	rev->loginfo = &log;
+	show_log(rev);
+	rev->loginfo = NULL;
+	/*
+	 * Add a new line after each commit message, of course we should
+	 * add --graph alignment later when the patches comes to master.
+	 */
+	fprintf(rev->diffopt.file, "\n");
+
+	if (c->object.flags & EVIL_MERGE)
+		return flush_nontrivial_merge(rev, nontrivial);
+
+	while (range) {
+		if (range->diff)
+			diff_flush_filepair(rev, range);
+		range = range->next;
+	}
+}
+
+int line_log_walk(struct rev_info *rev)
+{
+	struct commit *commit;
+	struct commit_list *list = NULL;
+	struct diff_line_range *r = NULL;
+
+	if (prepare_revision_walk(rev))
+		die("revision walk prepare failed");
+
+	/*
+	 * Note that -L automatically turns on --topo-order, so
+	 * rev->commits already holds all commits in the range.  The
+	 * first commit is our starting point.
+	 */
+	list = rev->commits;
+	if (list) {
+		list->item->object.flags |= RANGE_UPDATE;
+		list = list->next;
+	}
+	/* Clear the flags */
+	while (list) {
+		list->item->object.flags &= ~(RANGE_UPDATE | EVIL_MERGE | NEED_PRINT);
+		list = list->next;
+	}
+
+	list = rev->commits;
+	while (list) {
+		struct commit_list *need_free = list;
+		commit = list->item;
+
+		if (commit->object.flags & RANGE_UPDATE)
+			assign_parents_range(rev, commit);
+
+		if (commit->object.flags & NEED_PRINT)
+			line_log_flush(rev, commit);
+
+		clear_commit_line_range(rev, commit);
+
+		r = lookup_decoration(&rev->nontrivial_merge, &commit->object);
+		if (r) {
+			free_diff_line_ranges(r);
+			add_decoration(&rev->nontrivial_merge, &commit->object,
+				       NULL);
+		}
+
+		list = list->next;
+		free(need_free);
+	}
+
+	return 0;
+}
+
diff --git a/line.h b/line.h
index 5878c94..5f2931a 100644
--- a/line.h
+++ b/line.h
@@ -1,6 +1,8 @@
 #ifndef LINE_H
 #define LINE_H
 
+#include "diffcore.h"
+
 /*
  * Parse one item in an -L begin,end option w.r.t. the notional file
  * object 'cb_data' consisting of 'lines' lines.
@@ -20,4 +22,51 @@ extern int parse_range_arg(const char *arg,
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
+struct rev_info;
+struct commit;
+struct diff_line_range;
+struct diff_options;
+
+struct line_range;
+
+struct diff_line_range {
+	struct diff_filespec *prev;
+	struct diff_filespec *spec;
+	char status;
+	int alloc;
+	int nr;
+	struct line_range *ranges;
+	unsigned int	touched:1,
+			diff:1;
+	struct diff_line_range *next;
+};
+
+static inline void diff_line_range_init(struct diff_line_range *r)
+{
+	r->prev = r->spec = NULL;
+	r->status = '\0';
+	r->alloc = r->nr = 0;
+	r->ranges = NULL;
+	r->next = NULL;
+	r->touched = 0;
+	r->diff = 0;
+}
+
+extern void diff_line_range_append(struct diff_line_range *r, const char *arg);
+
+extern void line_log_init(struct rev_info *rev, struct diff_line_range *r);
+
+extern int line_log_walk(struct rev_info *rev);
+
 #endif /* LINE_H */
diff --git a/revision.c b/revision.c
index 6465c45..369ec56 100644
--- a/revision.c
+++ b/revision.c
@@ -1662,6 +1662,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->combine_merges)
 		revs->ignore_merges = 0;
 	revs->diffopt.abbrev = revs->abbrev;
+
+	if (revs->line_level_traverse) {
+		revs->limited = 1;
+		revs->topo_order = 1;
+	}
+
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
 
diff --git a/revision.h b/revision.h
index 8897368..585b15f 100644
--- a/revision.h
+++ b/revision.h
@@ -14,7 +14,10 @@
 #define CHILD_SHOWN	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
-#define ALL_REV_FLAGS	((1u<<9)-1)
+#define RANGE_UPDATE	(1u<<9) /* for line level traverse */
+#define NEED_PRINT	(1u<<10)
+#define EVIL_MERGE	(1u<<11)
+#define ALL_REV_FLAGS	((1u<<12)-1)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
@@ -68,7 +71,8 @@ struct rev_info {
 			cherry_pick:1,
 			bisect:1,
 			ancestry_path:1,
-			first_parent_only:1;
+			first_parent_only:1,
+			line_level_traverse:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
@@ -137,6 +141,9 @@ struct rev_info {
 	/* commit counts */
 	int count_left;
 	int count_right;
+	/* line level range that we are chasing */
+	struct decoration line_range;
+	struct decoration nontrivial_merge;
 };
 
 #define REV_TREE_SAME		0
diff --git a/t/t4301-log-line-single-history.sh b/t/t4301-log-line-single-history.sh
new file mode 100755
index 0000000..d7ae3e0
--- /dev/null
+++ b/t/t4301-log-line-single-history.sh
@@ -0,0 +1,685 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test git log -L with single line of history'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+cat >path0 <<\EOF
+void func()
+{
+	int a = 0;
+	int b = 1;
+	int c;
+	c = a + b;
+}
+EOF
+
+cat >path1 <<\EOF
+void output()
+{
+	printf("hello world");
+}
+EOF
+
+test_expect_success 'add path0/path1 and commit.' '
+	git add path0 path1 &&
+	git commit -m "Base commit"
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	int a = 10;
+	int b = 11;
+	int c;
+	c = a + b;
+}
+EOF
+
+cat >path1 <<\EOF
+void output()
+{
+	const char *str = "hello world!";
+	printf("%s", str);
+}
+EOF
+
+test_expect_success 'Change the 2,3 lines of path0 and path1.' '
+	git add path0 path1 &&
+	git commit -m "Change 2,3 lines of path0 and path1"
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	int a = 10;
+	int b = 11;
+	int c;
+	c = 10 * (a + b);
+}
+EOF
+
+test_expect_success 'Change the 5th line of path0.' '
+	git add path0 &&
+	git commit -m "Change the 5th line of path0"
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	int a = 10;
+	int b = 11;
+	printf("%d", a - b);
+}
+EOF
+
+test_expect_success 'Final change of path0.' '
+	git add path0 &&
+	git commit -m "Final change of path0"
+'
+
+cat >expected-path0 <<\EOF
+Final change of path0
+
+diff --git a/path0 b/path0
+index ccdf243..ccf8bcf 100644
+--- a/path0
++++ b/path0
+@@ -1,7 +1,6 @@
+ void func()
+ {
+ 	int a = 10;
+ 	int b = 11;
+-	int c;
+-	c = 10 * (a + b);
++	printf("%d", a - b);
+ }
+
+Change the 5th line of path0
+
+diff --git a/path0 b/path0
+index b0eb888..ccdf243 100644
+--- a/path0
++++ b/path0
+@@ -1,7 +1,7 @@
+ void func()
+ {
+ 	int a = 10;
+ 	int b = 11;
+ 	int c;
+-	c = a + b;
++	c = 10 * (a + b);
+ }
+
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index fb33939..b0eb888 100644
+--- a/path0
++++ b/path0
+@@ -1,7 +1,7 @@
+ void func()
+ {
+-	int a = 0;
+-	int b = 1;
++	int a = 10;
++	int b = 11;
+ 	int c;
+ 	c = a + b;
+ }
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..fb33939
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,7 @@
++void func()
++{
++	int a = 0;
++	int b = 1;
++	int c;
++	c = a + b;
++}
+EOF
+
+cat >expected-path1 <<\EOF
+Change 2,3 lines of path0 and path1
+
+diff --git a/path1 b/path1
+index 52be2a5..cc54b12 100644
+--- a/path1
++++ b/path1
+@@ -1,4 +1,5 @@
+ void output()
+ {
+-	printf("hello world");
++	const char *str = "hello world!";
++	printf("%s", str);
+ }
+
+Base commit
+
+diff --git a/path1 b/path1
+new file mode 100644
+index 0000000..52be2a5
+--- /dev/null
++++ b/path1
+@@ -0,0 +1,4 @@
++void output()
++{
++	printf("hello world");
++}
+EOF
+
+cat >expected-pathall <<\EOF
+Final change of path0
+
+diff --git a/path0 b/path0
+index ccdf243..ccf8bcf 100644
+--- a/path0
++++ b/path0
+@@ -1,7 +1,6 @@
+ void func()
+ {
+ 	int a = 10;
+ 	int b = 11;
+-	int c;
+-	c = 10 * (a + b);
++	printf("%d", a - b);
+ }
+
+Change the 5th line of path0
+
+diff --git a/path0 b/path0
+index b0eb888..ccdf243 100644
+--- a/path0
++++ b/path0
+@@ -1,7 +1,7 @@
+ void func()
+ {
+ 	int a = 10;
+ 	int b = 11;
+ 	int c;
+-	c = a + b;
++	c = 10 * (a + b);
+ }
+
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index fb33939..b0eb888 100644
+--- a/path0
++++ b/path0
+@@ -1,7 +1,7 @@
+ void func()
+ {
+-	int a = 0;
+-	int b = 1;
++	int a = 10;
++	int b = 11;
+ 	int c;
+ 	c = a + b;
+ }
+diff --git a/path1 b/path1
+index 52be2a5..cc54b12 100644
+--- a/path1
++++ b/path1
+@@ -1,4 +1,5 @@
+ void output()
+ {
+-	printf("hello world");
++	const char *str = "hello world!";
++	printf("%s", str);
+ }
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..fb33939
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,7 @@
++void func()
++{
++	int a = 0;
++	int b = 1;
++	int c;
++	c = a + b;
++}
+diff --git a/path1 b/path1
+new file mode 100644
+index 0000000..52be2a5
+--- /dev/null
++++ b/path1
+@@ -0,0 +1,4 @@
++void output()
++{
++	printf("hello world");
++}
+EOF
+
+cat >expected-linenum <<\EOF
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index fb33939..b0eb888 100644
+--- a/path0
++++ b/path0
+@@ -2,3 +2,3 @@
+ {
+-	int a = 0;
+-	int b = 1;
++	int a = 10;
++	int b = 11;
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..fb33939
+--- /dev/null
++++ b/path0
+@@ -0,0 +2,3 @@
++{
++	int a = 0;
++	int b = 1;
+EOF
+
+cat >expected-always <<\EOF
+Final change of path0
+
+diff --git a/path0 b/path0
+index ccdf243..ccf8bcf 100644
+--- a/path0
++++ b/path0
+@@ -2,3 +2,3 @@
+ {
+ 	int a = 10;
+ 	int b = 11;
+
+Change the 5th line of path0
+
+diff --git a/path0 b/path0
+index b0eb888..ccdf243 100644
+--- a/path0
++++ b/path0
+@@ -2,3 +2,3 @@
+ {
+ 	int a = 10;
+ 	int b = 11;
+
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index fb33939..b0eb888 100644
+--- a/path0
++++ b/path0
+@@ -2,3 +2,3 @@
+ {
+-	int a = 0;
+-	int b = 1;
++	int a = 10;
++	int b = 11;
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..fb33939
+--- /dev/null
++++ b/path0
+@@ -0,0 +2,3 @@
++{
++	int a = 0;
++	int b = 1;
+EOF
+
+test_expect_success 'Show the line level log of path0' '
+	git log --pretty=format:%s%n%b -L /func/,/^}/:path0 > current-path0
+'
+
+test_expect_success 'validate the path0 output.' '
+	test_cmp current-path0 expected-path0
+'
+
+test_expect_success 'Show the line level log of path1' '
+	git log --pretty=format:%s%n%b -L /output/,/^}/:path1 > current-path1
+'
+
+test_expect_success 'validate the path1 output.' '
+	test_cmp current-path1 expected-path1
+'
+
+test_expect_success 'Show the line level log of two files' '
+	git log --pretty=format:%s%n%b -L /func/,/^}/:path0 -L /output/,/^}/:path1 > current-pathall
+'
+
+test_expect_success 'validate the all path output.' '
+	test_cmp current-pathall expected-pathall
+'
+
+test_expect_success 'Test the line number argument' '
+	git log --pretty=format:%s%n%b -L 2,4:path0 > current-linenum
+'
+
+test_expect_success 'validate the line number output.' '
+	test_cmp current-linenum expected-linenum
+'
+test_expect_success 'Test the --full-line-diff option' '
+	git log --pretty=format:%s%n%b --full-line-diff -L 2,4:path0 > current-always
+'
+
+test_expect_success 'validate the --full-line-diff output.' '
+    test_cmp current-always expected-always
+'
+
+# Rerun all log with graph
+test_expect_success 'Show the line level log of path0 with --graph' '
+	git log --pretty=format:%s%n%b --graph -L /func/,/^}/:path0 > current-path0-graph
+'
+
+test_expect_success 'Show the line level log of path1 with --graph' '
+	git log --pretty=format:%s%n%b --graph -L /output/,/^}/:path1 > current-path1-graph
+'
+
+test_expect_success 'Show the line level log of two files with --graph' '
+	git log --pretty=format:%s%n%b --graph -L /func/,/^}/:path0 -L /output/,/^}/:path1 > current-pathall-graph
+'
+
+test_expect_success 'Test the line number argument with --graph' '
+	git log --pretty=format:%s%n%b --graph -L 2,4:path0 > current-linenum-graph
+'
+
+test_expect_success 'Test the --full-line-diff option with --graph option' '
+	git log --pretty=format:%s%n%b --full-line-diff --graph -L 2,4:path0 > current-always-graph
+'
+
+sed 's/#$//' > expected-path0-graph <<\EOF
+* Final change of path0
+| #
+| diff --git a/path0 b/path0
+| index ccdf243..ccf8bcf 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,7 +1,6 @@
+|  void func()
+|  {
+|  	int a = 10;
+|  	int b = 11;
+| -	int c;
+| -	c = 10 * (a + b);
+| +	printf("%d", a - b);
+|  }
+|  #
+* Change the 5th line of path0
+| #
+| diff --git a/path0 b/path0
+| index b0eb888..ccdf243 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,7 +1,7 @@
+|  void func()
+|  {
+|  	int a = 10;
+|  	int b = 11;
+|  	int c;
+| -	c = a + b;
+| +	c = 10 * (a + b);
+|  }
+|  #
+* Change 2,3 lines of path0 and path1
+| #
+| diff --git a/path0 b/path0
+| index fb33939..b0eb888 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,7 +1,7 @@
+|  void func()
+|  {
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  	int c;
+|  	c = a + b;
+|  }
+|  #
+* Base commit
+  #
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..fb33939
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,7 @@
+  +void func()
+  +{
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+  +}
+EOF
+
+sed 's/#$//' > expected-path1-graph <<\EOF
+* Change 2,3 lines of path0 and path1
+| #
+| diff --git a/path1 b/path1
+| index 52be2a5..cc54b12 100644
+| --- a/path1
+| +++ b/path1
+| @@ -1,4 +1,5 @@
+|  void output()
+|  {
+| -	printf("hello world");
+| +	const char *str = "hello world!";
+| +	printf("%s", str);
+|  }
+|  #
+* Base commit
+  #
+  diff --git a/path1 b/path1
+  new file mode 100644
+  index 0000000..52be2a5
+  --- /dev/null
+  +++ b/path1
+  @@ -0,0 +1,4 @@
+  +void output()
+  +{
+  +	printf("hello world");
+  +}
+EOF
+
+sed 's/#$//' > expected-pathall-graph <<\EOF
+* Final change of path0
+| #
+| diff --git a/path0 b/path0
+| index ccdf243..ccf8bcf 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,7 +1,6 @@
+|  void func()
+|  {
+|  	int a = 10;
+|  	int b = 11;
+| -	int c;
+| -	c = 10 * (a + b);
+| +	printf("%d", a - b);
+|  }
+|  #
+* Change the 5th line of path0
+| #
+| diff --git a/path0 b/path0
+| index b0eb888..ccdf243 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,7 +1,7 @@
+|  void func()
+|  {
+|  	int a = 10;
+|  	int b = 11;
+|  	int c;
+| -	c = a + b;
+| +	c = 10 * (a + b);
+|  }
+|  #
+* Change 2,3 lines of path0 and path1
+| #
+| diff --git a/path0 b/path0
+| index fb33939..b0eb888 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,7 +1,7 @@
+|  void func()
+|  {
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  	int c;
+|  	c = a + b;
+|  }
+| diff --git a/path1 b/path1
+| index 52be2a5..cc54b12 100644
+| --- a/path1
+| +++ b/path1
+| @@ -1,4 +1,5 @@
+|  void output()
+|  {
+| -	printf("hello world");
+| +	const char *str = "hello world!";
+| +	printf("%s", str);
+|  }
+|  #
+* Base commit
+  #
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..fb33939
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,7 @@
+  +void func()
+  +{
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+  +}
+  diff --git a/path1 b/path1
+  new file mode 100644
+  index 0000000..52be2a5
+  --- /dev/null
+  +++ b/path1
+  @@ -0,0 +1,4 @@
+  +void output()
+  +{
+  +	printf("hello world");
+  +}
+EOF
+
+sed 's/#$//' > expected-linenum-graph <<\EOF
+* Change 2,3 lines of path0 and path1
+| #
+| diff --git a/path0 b/path0
+| index fb33939..b0eb888 100644
+| --- a/path0
+| +++ b/path0
+| @@ -2,3 +2,3 @@
+|  {
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  #
+* Base commit
+  #
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..fb33939
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +2,3 @@
+  +{
+  +	int a = 0;
+  +	int b = 1;
+EOF
+
+sed 's/#$//' > expected-always-graph <<\EOF
+* Final change of path0
+| #
+| diff --git a/path0 b/path0
+| index ccdf243..ccf8bcf 100644
+| --- a/path0
+| +++ b/path0
+| @@ -2,3 +2,3 @@
+|  {
+|  	int a = 10;
+|  	int b = 11;
+|  #
+* Change the 5th line of path0
+| #
+| diff --git a/path0 b/path0
+| index b0eb888..ccdf243 100644
+| --- a/path0
+| +++ b/path0
+| @@ -2,3 +2,3 @@
+|  {
+|  	int a = 10;
+|  	int b = 11;
+|  #
+* Change 2,3 lines of path0 and path1
+| #
+| diff --git a/path0 b/path0
+| index fb33939..b0eb888 100644
+| --- a/path0
+| +++ b/path0
+| @@ -2,3 +2,3 @@
+|  {
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  #
+* Base commit
+  #
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..fb33939
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +2,3 @@
+  +{
+  +	int a = 0;
+  +	int b = 1;
+EOF
+
+test_expect_success 'validate the path0 output.' '
+	test_cmp current-path0-graph expected-path0-graph
+'
+
+test_expect_success 'validate the path1 output.' '
+	test_cmp current-path1-graph expected-path1-graph
+'
+
+test_expect_success 'validate the all path output.' '
+	test_cmp current-pathall-graph expected-pathall-graph
+'
+
+test_expect_success 'validate graph output' '
+	test_cmp current-linenum-graph expected-linenum-graph
+'
+
+test_expect_success 'validate --full-line-diff output' '
+	test_cmp current-always-graph expected-always-graph
+'
+
+test_done
-- 
1.7.3.3.811.g76615
