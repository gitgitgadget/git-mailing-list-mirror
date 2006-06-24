From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 2/7] Merge with_raw, with_stat and summary variables to
 output_format
Date: Sat, 24 Jun 2006 20:21:53 +0300
Message-ID: <20060624202153.1001a66c.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 19:30:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuBxo-0001XZ-5U
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 19:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWFXRaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 13:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWFXRaU
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 13:30:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:12043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750951AbWFXRaS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 13:30:18 -0400
Received: by nf-out-0910.google.com with SMTP id m19so402611nfc
        for <git@vger.kernel.org>; Sat, 24 Jun 2006 10:30:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=rU9yXfovvxq4ZSgbP+tI0WYiTixmqyny1LQkUtCXoEL0Z8RXzq5oJg51Bt5lrUdbBUTefcX9QjBvV0In4xUFGs/33RobDtVzGzNE+ZDxNCzm5mRd9RKwjwEKzVo6lf9XRIYfnChVMnx4Q3Kp/dJsoBWcUxS1KM8aByPgRbsmRWo=
Received: by 10.48.143.15 with SMTP id q15mr3516773nfd;
        Sat, 24 Jun 2006 10:30:17 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id r33sm4227532nfc.2006.06.24.10.30.16;
        Sat, 24 Jun 2006 10:30:17 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22530>

DIFF_FORMAT_* are now bit-flags instead of enumerated values.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 builtin-diff.c |    2 -
 builtin-log.c  |    4 -
 combine-diff.c |   55 +++++++----------
 diff.c         |  183 +++++++++++++++++++++++++++-----------------------------
 diff.h         |   27 +++++---
 log-tree.c     |    9 ++-
 6 files changed, 136 insertions(+), 144 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 99a2f76..3b44296 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -56,7 +56,7 @@ static int builtin_diff_files(struct rev
 	    3 < revs->max_count)
 		usage(builtin_diff_usage);
 	if (revs->max_count < 0 &&
-	    (revs->diffopt.output_format == DIFF_FORMAT_PATCH))
+	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
 		revs->combine_merges = revs->dense_combined_merges = 1;
 	/*
 	 * Backward compatibility wart - "diff-files -s" used to
diff --git a/builtin-log.c b/builtin-log.c
index 5a8a50b..5c656bc 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -176,11 +176,9 @@ int cmd_format_patch(int argc, const cha
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
 	rev.diff = 1;
-	rev.diffopt.with_raw = 0;
-	rev.diffopt.with_stat = 1;
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
-	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+	rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 
 	git_config(git_format_config);
 	rev.extra_headers = extra_headers;
diff --git a/combine-diff.c b/combine-diff.c
index 64b20cc..3daa8cb 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -771,7 +771,7 @@ static void show_raw_diff(struct combine
 	if (rev->loginfo)
 		show_log(rev, rev->loginfo, "\n");
 
-	if (opt->output_format == DIFF_FORMAT_RAW) {
+	if (opt->output_format & DIFF_FORMAT_RAW) {
 		offset = strlen(COLONS) - num_parent;
 		if (offset < 0)
 			offset = 0;
@@ -791,8 +791,7 @@ static void show_raw_diff(struct combine
 		printf(" %s ", diff_unique_abbrev(p->sha1, opt->abbrev));
 	}
 
-	if (opt->output_format == DIFF_FORMAT_RAW ||
-	    opt->output_format == DIFF_FORMAT_NAME_STATUS) {
+	if (opt->output_format & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS)) {
 		for (i = 0; i < num_parent; i++)
 			putchar(p->parent[i].status);
 		putchar(inter_name_termination);
@@ -818,17 +817,12 @@ void show_combined_diff(struct combine_d
 	struct diff_options *opt = &rev->diffopt;
 	if (!p->len)
 		return;
-	switch (opt->output_format) {
-	case DIFF_FORMAT_RAW:
-	case DIFF_FORMAT_NAME_STATUS:
-	case DIFF_FORMAT_NAME:
+	if (opt->output_format & (DIFF_FORMAT_RAW |
+				  DIFF_FORMAT_NAME |
+				  DIFF_FORMAT_NAME_STATUS)) {
 		show_raw_diff(p, num_parent, rev);
-		return;
-	case DIFF_FORMAT_PATCH:
+	} else if (opt->output_format & DIFF_FORMAT_PATCH) {
 		show_patch_diff(p, num_parent, dense, rev);
-		return;
-	default:
-		return;
 	}
 }
 
@@ -842,13 +836,9 @@ void diff_tree_combined(const unsigned c
 	struct diff_options diffopts;
 	struct combine_diff_path *p, *paths = NULL;
 	int i, num_paths;
-	int do_diffstat;
 
-	do_diffstat = (opt->output_format == DIFF_FORMAT_DIFFSTAT ||
-		       opt->with_stat);
 	diffopts = *opt;
-	diffopts.with_raw = 0;
-	diffopts.with_stat = 0;
+	diffopts.output_format &= ~(DIFF_FORMAT_RAW | DIFF_FORMAT_DIFFSTAT);
 	diffopts.recursive = 1;
 
 	/* find set of paths that everybody touches */
@@ -856,19 +846,18 @@ void diff_tree_combined(const unsigned c
 		/* show stat against the first parent even
 		 * when doing combined diff.
 		 */
-		if (i == 0 && do_diffstat)
-			diffopts.output_format = DIFF_FORMAT_DIFFSTAT;
+		if (i == 0 && opt->output_format & DIFF_FORMAT_DIFFSTAT)
+			diffopts.output_format |= DIFF_FORMAT_DIFFSTAT;
 		else
-			diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
+			diffopts.output_format |= DIFF_FORMAT_NO_OUTPUT;
 		diff_tree_sha1(parent[i], sha1, "", &diffopts);
 		diffcore_std(&diffopts);
 		paths = intersect_paths(paths, i, num_parent);
 
-		if (do_diffstat && rev->loginfo)
-			show_log(rev, rev->loginfo,
-				 opt->with_stat ? "---\n" : "\n");
+		if (opt->output_format & DIFF_FORMAT_DIFFSTAT && rev->loginfo)
+			show_log(rev, rev->loginfo, "---\n");
 		diff_flush(&diffopts);
-		if (opt->with_stat)
+		if (opt->output_format & DIFF_FORMAT_DIFFSTAT)
 			putchar('\n');
 	}
 
@@ -878,17 +867,21 @@ void diff_tree_combined(const unsigned c
 			num_paths++;
 	}
 	if (num_paths) {
-		if (opt->with_raw) {
-			int saved_format = opt->output_format;
-			opt->output_format = DIFF_FORMAT_RAW;
+		if (opt->output_format & (DIFF_FORMAT_RAW |
+					  DIFF_FORMAT_NAME |
+					  DIFF_FORMAT_NAME_STATUS)) {
 			for (p = paths; p; p = p->next) {
-				show_combined_diff(p, num_parent, dense, rev);
+				if (p->len)
+					show_raw_diff(p, num_parent, rev);
 			}
-			opt->output_format = saved_format;
 			putchar(opt->line_termination);
 		}
-		for (p = paths; p; p = p->next) {
-			show_combined_diff(p, num_parent, dense, rev);
+		if (opt->output_format & DIFF_FORMAT_PATCH) {
+			for (p = paths; p; p = p->next) {
+				if (p->len)
+					show_patch_diff(p, num_parent, dense,
+							rev);
+			}
 		}
 	}
 
diff --git a/diff.c b/diff.c
index f358546..bfed79c 100644
--- a/diff.c
+++ b/diff.c
@@ -1372,23 +1372,27 @@ int diff_setup_done(struct diff_options 
 	    (0 <= options->rename_limit && !options->detect_rename))
 		return -1;
 
+	if (options->output_format & DIFF_FORMAT_NO_OUTPUT)
+		options->output_format = 0;
+
+	if (options->output_format & (DIFF_FORMAT_NAME |
+				      DIFF_FORMAT_NAME_STATUS |
+				      DIFF_FORMAT_CHECKDIFF |
+				      DIFF_FORMAT_NO_OUTPUT))
+		options->output_format &= ~(DIFF_FORMAT_RAW |
+					    DIFF_FORMAT_DIFFSTAT |
+					    DIFF_FORMAT_SUMMARY |
+					    DIFF_FORMAT_PATCH);
+
 	/*
 	 * These cases always need recursive; we do not drop caller-supplied
 	 * recursive bits for other formats here.
 	 */
-	if ((options->output_format == DIFF_FORMAT_PATCH) ||
-	    (options->output_format == DIFF_FORMAT_DIFFSTAT) ||
-	    (options->output_format == DIFF_FORMAT_CHECKDIFF))
+	if (options->output_format & (DIFF_FORMAT_PATCH |
+				      DIFF_FORMAT_DIFFSTAT |
+				      DIFF_FORMAT_CHECKDIFF))
 		options->recursive = 1;
 
-	/*
-	 * These combinations do not make sense.
-	 */
-	if (options->output_format == DIFF_FORMAT_RAW)
-		options->with_raw = 0;
-	if (options->output_format == DIFF_FORMAT_DIFFSTAT)
-		options->with_stat  = 0;
-
 	if (options->detect_rename && options->rename_limit < 0)
 		options->rename_limit = diff_rename_limit_default;
 	if (options->setup & DIFF_SETUP_USE_CACHE) {
@@ -1460,22 +1464,20 @@ int diff_opt_parse(struct diff_options *
 {
 	const char *arg = av[0];
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
-		options->output_format = DIFF_FORMAT_PATCH;
+		options->output_format |= DIFF_FORMAT_PATCH;
 	else if (opt_arg(arg, 'U', "unified", &options->context))
-		options->output_format = DIFF_FORMAT_PATCH;
+		options->output_format |= DIFF_FORMAT_PATCH;
 	else if (!strcmp(arg, "--patch-with-raw")) {
-		options->output_format = DIFF_FORMAT_PATCH;
-		options->with_raw = 1;
+		options->output_format |= DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW;
 	}
 	else if (!strcmp(arg, "--stat"))
-		options->output_format = DIFF_FORMAT_DIFFSTAT;
+		options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	else if (!strcmp(arg, "--check"))
-		options->output_format = DIFF_FORMAT_CHECKDIFF;
+		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
-		options->summary = 1;
+		options->output_format |= DIFF_FORMAT_SUMMARY;
 	else if (!strcmp(arg, "--patch-with-stat")) {
-		options->output_format = DIFF_FORMAT_PATCH;
-		options->with_stat = 1;
+		options->output_format |= DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT;
 	}
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
@@ -1484,19 +1486,20 @@ int diff_opt_parse(struct diff_options *
 	else if (!strcmp(arg, "--full-index"))
 		options->full_index = 1;
 	else if (!strcmp(arg, "--binary")) {
-		options->output_format = DIFF_FORMAT_PATCH;
+		options->output_format |= DIFF_FORMAT_PATCH;
 		options->full_index = options->binary = 1;
 	}
 	else if (!strcmp(arg, "--name-only"))
-		options->output_format = DIFF_FORMAT_NAME;
+		options->output_format |= DIFF_FORMAT_NAME;
 	else if (!strcmp(arg, "--name-status"))
-		options->output_format = DIFF_FORMAT_NAME_STATUS;
+		options->output_format |= DIFF_FORMAT_NAME_STATUS;
 	else if (!strcmp(arg, "-R"))
 		options->reverse_diff = 1;
 	else if (!strncmp(arg, "-S", 2))
 		options->pickaxe = arg + 2;
-	else if (!strcmp(arg, "-s"))
-		options->output_format = DIFF_FORMAT_NO_OUTPUT;
+	else if (!strcmp(arg, "-s")) {
+		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
+	}
 	else if (!strncmp(arg, "-O", 2))
 		options->orderfile = arg + 2;
 	else if (!strncmp(arg, "--diff-filter=", 14))
@@ -1671,15 +1674,17 @@ const char *diff_unique_abbrev(const uns
 }
 
 static void diff_flush_raw(struct diff_filepair *p,
-			   int line_termination,
-			   int inter_name_termination,
-			   struct diff_options *options,
-			   int output_format)
+			   struct diff_options *options)
 {
 	int two_paths;
 	char status[10];
 	int abbrev = options->abbrev;
 	const char *path_one, *path_two;
+	int inter_name_termination = '\t';
+	int line_termination = options->line_termination;
+
+	if (!line_termination)
+		inter_name_termination = 0;
 
 	path_one = p->one->path;
 	path_two = p->two->path;
@@ -1708,7 +1713,7 @@ static void diff_flush_raw(struct diff_f
 		two_paths = 0;
 		break;
 	}
-	if (output_format != DIFF_FORMAT_NAME_STATUS) {
+	if (!(options->output_format & DIFF_FORMAT_NAME_STATUS)) {
 		printf(":%06o %06o %s ",
 		       p->one->mode, p->two->mode,
 		       diff_unique_abbrev(p->one->sha1, abbrev));
@@ -1917,48 +1922,30 @@ static void diff_resolve_rename_copy(voi
 	diff_debug_queue("resolve-rename-copy done", q);
 }
 
-static void flush_one_pair(struct diff_filepair *p,
-			   int diff_output_format,
-			   struct diff_options *options,
-			   struct diffstat_t *diffstat)
+static int check_pair_status(struct diff_filepair *p)
 {
-	int inter_name_termination = '\t';
-	int line_termination = options->line_termination;
-	if (!line_termination)
-		inter_name_termination = 0;
-
 	switch (p->status) {
 	case DIFF_STATUS_UNKNOWN:
-		break;
+		return 0;
 	case 0:
 		die("internal error in diff-resolve-rename-copy");
-		break;
 	default:
-		switch (diff_output_format) {
-		case DIFF_FORMAT_DIFFSTAT:
-			diff_flush_stat(p, options, diffstat);
-			break;
-		case DIFF_FORMAT_CHECKDIFF:
-			diff_flush_checkdiff(p, options);
-			break;
-		case DIFF_FORMAT_PATCH:
-			diff_flush_patch(p, options);
-			break;
-		case DIFF_FORMAT_RAW:
-		case DIFF_FORMAT_NAME_STATUS:
-			diff_flush_raw(p, line_termination,
-				       inter_name_termination,
-				       options, diff_output_format);
-			break;
-		case DIFF_FORMAT_NAME:
-			diff_flush_name(p, line_termination);
-			break;
-		case DIFF_FORMAT_NO_OUTPUT:
-			break;
-		}
+		return 1;
 	}
 }
 
+static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
+{
+	int fmt = opt->output_format;
+
+	if (fmt & DIFF_FORMAT_CHECKDIFF)
+		diff_flush_checkdiff(p, opt);
+	else if (fmt & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS))
+		diff_flush_raw(p, opt);
+	else if (fmt & DIFF_FORMAT_NAME)
+		diff_flush_name(p, opt->line_termination);
+}
+
 static void show_file_mode_name(const char *newdelete, struct diff_filespec *fs)
 {
 	if (fs->mode)
@@ -2041,55 +2028,61 @@ static void diff_summary(struct diff_fil
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	int i;
-	int diff_output_format = options->output_format;
-	struct diffstat_t *diffstat = NULL;
+	int i, output_format = options->output_format;
 
-	if (diff_output_format == DIFF_FORMAT_DIFFSTAT || options->with_stat) {
-		diffstat = xcalloc(sizeof (struct diffstat_t), 1);
-		diffstat->xm.consume = diffstat_consume;
-	}
+	/*
+	 * Order: raw, stat, summary, patch
+	 * or:    name/name-status/checkdiff (other bits clear)
+	 */
 
-	if (options->with_raw) {
+	if (output_format & (DIFF_FORMAT_RAW |
+			     DIFF_FORMAT_NAME |
+			     DIFF_FORMAT_NAME_STATUS |
+			     DIFF_FORMAT_CHECKDIFF)) {
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			flush_one_pair(p, DIFF_FORMAT_RAW, options, NULL);
+			if (check_pair_status(p))
+				flush_one_pair(p, options);
 		}
-		putchar(options->line_termination);
 	}
-	if (options->with_stat) {
+
+	if (output_format & DIFF_FORMAT_DIFFSTAT) {
+		struct diffstat_t *diffstat;
+
+		diffstat = xcalloc(sizeof (struct diffstat_t), 1);
+		diffstat->xm.consume = diffstat_consume;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			flush_one_pair(p, DIFF_FORMAT_DIFFSTAT, options,
-				       diffstat);
+			if (check_pair_status(p))
+				diff_flush_stat(p, options, diffstat);
 		}
 		show_stats(diffstat);
 		free(diffstat);
-		diffstat = NULL;
-		if (options->summary)
-			for (i = 0; i < q->nr; i++)
-				diff_summary(q->queue[i]);
-		if (options->stat_sep)
-			fputs(options->stat_sep, stdout);
-		else
-			putchar(options->line_termination);
-	}
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		flush_one_pair(p, diff_output_format, options, diffstat);
 	}
 
-	if (diffstat) {
-		show_stats(diffstat);
-		free(diffstat);
+	if (output_format & DIFF_FORMAT_SUMMARY) {
+		for (i = 0; i < q->nr; i++)
+			diff_summary(q->queue[i]);
 	}
 
-	for (i = 0; i < q->nr; i++) {
-		if (diffstat && options->summary)
-			diff_summary(q->queue[i]);
-		diff_free_filepair(q->queue[i]);
+	if (output_format & DIFF_FORMAT_PATCH) {
+		if (output_format & (DIFF_FORMAT_DIFFSTAT |
+				     DIFF_FORMAT_SUMMARY)) {
+			if (options->stat_sep)
+				fputs(options->stat_sep, stdout);
+			else
+				putchar(options->line_termination);
+		}
+
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if (check_pair_status(p))
+				diff_flush_patch(p, options);
+		}
 	}
 
+	for (i = 0; i < q->nr; i++)
+		diff_free_filepair(q->queue[i]);
 	free(q->queue);
 	q->queue = NULL;
 	q->nr = q->alloc = 0;
diff --git a/diff.h b/diff.h
index b61fdc8..2b6dc0c 100644
--- a/diff.h
+++ b/diff.h
@@ -20,19 +20,31 @@ typedef void (*add_remove_fn_t)(struct d
 		    const unsigned char *sha1,
 		    const char *base, const char *path);
 
+#define DIFF_FORMAT_RAW		0x0001
+#define DIFF_FORMAT_DIFFSTAT	0x0002
+#define DIFF_FORMAT_SUMMARY	0x0004
+#define DIFF_FORMAT_PATCH	0x0008
+
+/* These override all above */
+#define DIFF_FORMAT_NAME	0x0010
+#define DIFF_FORMAT_NAME_STATUS	0x0020
+#define DIFF_FORMAT_CHECKDIFF	0x0040
+
+/* Same as output_format = 0 but we know that -s flag was given
+ * and we should not give default value to output_format.
+ */
+#define DIFF_FORMAT_NO_OUTPUT	0x0080
+
 struct diff_options {
 	const char *filter;
 	const char *orderfile;
 	const char *pickaxe;
 	unsigned recursive:1,
-		 with_raw:1,
-		 with_stat:1,
 		 tree_in_recursive:1,
 		 binary:1,
 		 full_index:1,
 		 silent_on_remove:1,
 		 find_copies_harder:1,
-		 summary:1,
 		 color_diff:1;
 	int context;
 	int break_opt;
@@ -151,15 +163,6 @@ #define COMMON_DIFF_OPTIONS_HELP \
 "                show all files diff when -S is used and hit is found.\n"
 
 extern int diff_queue_is_empty(void);
-
-#define DIFF_FORMAT_RAW		1
-#define DIFF_FORMAT_PATCH	2
-#define DIFF_FORMAT_NO_OUTPUT	3
-#define DIFF_FORMAT_NAME	4
-#define DIFF_FORMAT_NAME_STATUS	5
-#define DIFF_FORMAT_DIFFSTAT	6
-#define DIFF_FORMAT_CHECKDIFF	7
-
 extern void diff_flush(struct diff_options*);
 
 /* diff-raw status letters */
diff --git a/log-tree.c b/log-tree.c
index ebb49f2..7d4c51f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -163,8 +163,13 @@ int log_tree_diff_flush(struct rev_info 
 		return 0;
 	}
 
-	if (opt->loginfo && !opt->no_commit_id)
-		show_log(opt, opt->loginfo, opt->diffopt.with_stat ? "---\n" : "\n");
+	if (opt->loginfo && !opt->no_commit_id) {
+		if (opt->diffopt.output_format & DIFF_FORMAT_DIFFSTAT) {
+			show_log(opt, opt->loginfo,  "---\n");
+		} else {
+			show_log(opt, opt->loginfo,  "\n");
+		}
+	}
 	diff_flush(&opt->diffopt);
 	return 1;
 }
-- 
1.4.1.rc1.g8637
