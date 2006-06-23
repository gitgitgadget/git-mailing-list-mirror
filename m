From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 2/5] Rework diff options
Date: Sat, 24 Jun 2006 00:52:52 +0300
Message-ID: <20060624005252.c694e421.tihirvon@gmail.com>
References: <20060624003315.804a1796.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 00:17:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fttxe-0004P0-6C
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 00:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbWFWWQ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 18:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbWFWWQ6
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 18:16:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:45557 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752118AbWFWWQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 18:16:56 -0400
Received: by nf-out-0910.google.com with SMTP id m19so277746nfc
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 15:16:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=caMoAk5bGXh0XWVkHYm8r7mqg7WE23b2xtju2yc7CfxGja9usChkU02y9QW9vSmLaiOCtdq4Yrgb6kCbpSqFTja5nFBnie1nZUxqjvzwNAnzBjozebHfDTf943mYk6t2G0alZNNd21XSX8Q8L8QI9p3ToWpvOTnWfHsVrU84Sw0=
Received: by 10.49.91.12 with SMTP id t12mr2865742nfl;
        Fri, 23 Jun 2006 15:16:56 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id q27sm3385380nfc.2006.06.23.15.16.55;
        Fri, 23 Jun 2006 15:16:55 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <20060624003315.804a1796.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22446>

Make raw, diffstat, summary and patch diff output format options
independent of each other.

name-only, name-status and checkdiff options override other options.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 builtin-diff-files.c |    6 +-
 builtin-diff.c       |   22 +++---
 builtin-log.c        |    8 +-
 combine-diff.c       |   45 ++++-------
 diff.c               |  199 +++++++++++++++++++++++++-------------------------
 diff.h               |   29 ++++---
 log-tree.c           |   15 +++-
 revision.c           |    4 +
 8 files changed, 160 insertions(+), 168 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 5afc1d7..42ca07d 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -47,9 +47,9 @@ int cmd_diff_files(int argc, const char 
 	/*
 	 * Backward compatibility wart - "diff-files -s" used to
 	 * defeat the common diff option "-s" which asked for
-	 * DIFF_FORMAT_NO_OUTPUT.
+	 * OUTPUT_FMT_NONE
 	 */
-	if (rev.diffopt.output_format == DIFF_FORMAT_NO_OUTPUT)
-		rev.diffopt.output_format = DIFF_FORMAT_RAW;
+	if (rev.diffopt.output_fmt & OUTPUT_FMT_NONE)
+		rev.diffopt.output_fmt = OUTPUT_FMT_RAW;
 	return run_diff_files(&rev, silent);
 }
diff --git a/builtin-diff.c b/builtin-diff.c
index 99a2f76..372894a 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -40,7 +40,7 @@ static int builtin_diff_files(struct rev
 		else if (!strcmp(arg, "-q"))
 			silent = 1;
 		else if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
+			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
 		else
 			usage(builtin_diff_usage);
 		argv++; argc--;
@@ -56,15 +56,15 @@ static int builtin_diff_files(struct rev
 	    3 < revs->max_count)
 		usage(builtin_diff_usage);
 	if (revs->max_count < 0 &&
-	    (revs->diffopt.output_format == DIFF_FORMAT_PATCH))
+	    (revs->diffopt.output_fmt & OUTPUT_FMT_PATCH))
 		revs->combine_merges = revs->dense_combined_merges = 1;
 	/*
 	 * Backward compatibility wart - "diff-files -s" used to
 	 * defeat the common diff option "-s" which asked for
-	 * DIFF_FORMAT_NO_OUTPUT.
+	 * OUTPUT_FMT_NONE
 	 */
-	if (revs->diffopt.output_format == DIFF_FORMAT_NO_OUTPUT)
-		revs->diffopt.output_format = DIFF_FORMAT_RAW;
+	if (revs->diffopt.output_fmt & OUTPUT_FMT_NONE)
+		revs->diffopt.output_fmt = OUTPUT_FMT_RAW;
 	return run_diff_files(revs, silent);
 }
 
@@ -110,7 +110,7 @@ static int builtin_diff_b_f(struct rev_i
 	while (1 < argc) {
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
+			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
 		else
 			usage(builtin_diff_usage);
 		argv++; argc--;
@@ -140,7 +140,7 @@ static int builtin_diff_blobs(struct rev
 	while (1 < argc) {
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
+			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
 		else
 			usage(builtin_diff_usage);
 		argv++; argc--;
@@ -163,7 +163,7 @@ static int builtin_diff_index(struct rev
 		if (!strcmp(arg, "--cached"))
 			cached = 1;
 		else if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
+			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
 		else
 			usage(builtin_diff_usage);
 		argv++; argc--;
@@ -188,7 +188,7 @@ static int builtin_diff_tree(struct rev_
 	while (1 < argc) {
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
+			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
 		else
 			usage(builtin_diff_usage);
 		argv++; argc--;
@@ -217,7 +217,7 @@ static int builtin_diff_combined(struct 
 	while (1 < argc) {
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
+			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
 		else
 			usage(builtin_diff_usage);
 		argv++; argc--;
@@ -276,7 +276,7 @@ int cmd_diff(int argc, const char **argv
 
 	git_config(git_diff_config);
 	init_revisions(&rev);
-	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+	rev.diffopt.output_fmt = OUTPUT_FMT_PATCH;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	/* Do we have --cached and not have a pending object, then
diff --git a/builtin-log.c b/builtin-log.c
index 5a8a50b..e4a6385 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -26,8 +26,8 @@ static int cmd_log_wc(int argc, const ch
 	if (rev->always_show_header) {
 		if (rev->diffopt.pickaxe || rev->diffopt.filter) {
 			rev->always_show_header = 0;
-			if (rev->diffopt.output_format == DIFF_FORMAT_RAW)
-				rev->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
+			if (rev->diffopt.output_fmt & OUTPUT_FMT_RAW)
+				rev->diffopt.output_fmt |= OUTPUT_FMT_NONE;
 		}
 	}
 
@@ -176,11 +176,9 @@ int cmd_format_patch(int argc, const cha
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
 	rev.diff = 1;
-	rev.diffopt.with_raw = 0;
-	rev.diffopt.with_stat = 1;
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
-	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+	rev.diffopt.output_fmt = OUTPUT_FMT_DIFFSTAT | OUTPUT_FMT_PATCH;
 
 	git_config(git_format_config);
 	rev.extra_headers = extra_headers;
diff --git a/combine-diff.c b/combine-diff.c
index 64b20cc..d0d8d01 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -771,7 +771,7 @@ static void show_raw_diff(struct combine
 	if (rev->loginfo)
 		show_log(rev, rev->loginfo, "\n");
 
-	if (opt->output_format == DIFF_FORMAT_RAW) {
+	if (opt->output_fmt & OUTPUT_FMT_RAW) {
 		offset = strlen(COLONS) - num_parent;
 		if (offset < 0)
 			offset = 0;
@@ -791,8 +791,7 @@ static void show_raw_diff(struct combine
 		printf(" %s ", diff_unique_abbrev(p->sha1, opt->abbrev));
 	}
 
-	if (opt->output_format == DIFF_FORMAT_RAW ||
-	    opt->output_format == DIFF_FORMAT_NAME_STATUS) {
+	if (opt->output_fmt & (OUTPUT_FMT_RAW | OUTPUT_FMT_NAME_STATUS)) {
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
+	if (opt->output_fmt & (OUTPUT_FMT_RAW |
+			       OUTPUT_FMT_NAME |
+			       OUTPUT_FMT_NAME_STATUS)) {
 		show_raw_diff(p, num_parent, rev);
-		return;
-	case DIFF_FORMAT_PATCH:
+	} else if (opt->output_fmt & OUTPUT_FMT_PATCH) {
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
+	diffopts.output_fmt &= ~(OUTPUT_FMT_RAW | OUTPUT_FMT_DIFFSTAT);
 	diffopts.recursive = 1;
 
 	/* find set of paths that everybody touches */
@@ -856,19 +846,18 @@ void diff_tree_combined(const unsigned c
 		/* show stat against the first parent even
 		 * when doing combined diff.
 		 */
-		if (i == 0 && do_diffstat)
-			diffopts.output_format = DIFF_FORMAT_DIFFSTAT;
+		if (i == 0 && opt->output_fmt & OUTPUT_FMT_DIFFSTAT)
+			diffopts.output_fmt |= OUTPUT_FMT_DIFFSTAT;
 		else
-			diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
+			diffopts.output_fmt |= OUTPUT_FMT_NONE;
 		diff_tree_sha1(parent[i], sha1, "", &diffopts);
 		diffcore_std(&diffopts);
 		paths = intersect_paths(paths, i, num_parent);
 
-		if (do_diffstat && rev->loginfo)
-			show_log(rev, rev->loginfo,
-				 opt->with_stat ? "---\n" : "\n");
+		if (opt->output_fmt & OUTPUT_FMT_DIFFSTAT && rev->loginfo)
+			show_log(rev, rev->loginfo, "---\n");
 		diff_flush(&diffopts);
-		if (opt->with_stat)
+		if (opt->output_fmt & OUTPUT_FMT_DIFFSTAT)
 			putchar('\n');
 	}
 
@@ -878,13 +867,13 @@ void diff_tree_combined(const unsigned c
 			num_paths++;
 	}
 	if (num_paths) {
-		if (opt->with_raw) {
-			int saved_format = opt->output_format;
-			opt->output_format = DIFF_FORMAT_RAW;
+		if (opt->output_fmt & OUTPUT_FMT_RAW) {
+			int saved_fmt = opt->output_fmt;
+			opt->output_fmt |= OUTPUT_FMT_RAW;
 			for (p = paths; p; p = p->next) {
 				show_combined_diff(p, num_parent, dense, rev);
 			}
-			opt->output_format = saved_format;
+			opt->output_fmt = saved_fmt;
 			putchar(opt->line_termination);
 		}
 		for (p = paths; p; p = p->next) {
diff --git a/diff.c b/diff.c
index 1db0285..6eb7db0 100644
--- a/diff.c
+++ b/diff.c
@@ -203,7 +203,7 @@ static void emit_rewrite_diff(const char
 static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one)) {
-		mf->ptr = ""; /* does not matter */
+		mf->ptr = (char *)""; /* does not matter */
 		mf->size = 0;
 		return 0;
 	}
@@ -395,7 +395,7 @@ static void show_stats(struct diffstat_t
 	}
 
 	for (i = 0; i < data->nr; i++) {
-		char *prefix = "";
+		const char *prefix = "";
 		char *name = data->files[i]->name;
 		int added = data->files[i]->added;
 		int deleted = data->files[i]->deleted;
@@ -917,7 +917,7 @@ int diff_populate_filespec(struct diff_f
 			err_empty:
 				err = -1;
 			empty:
-				s->data = "";
+				s->data = (char *)"";
 				s->size = 0;
 				return err;
 			}
@@ -1354,7 +1354,7 @@ static void run_checkdiff(struct diff_fi
 void diff_setup(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
-	options->output_format = DIFF_FORMAT_RAW;
+	options->output_fmt = OUTPUT_FMT_RAW;
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
@@ -1371,23 +1371,26 @@ int diff_setup_done(struct diff_options 
 	    (0 <= options->rename_limit && !options->detect_rename))
 		return -1;
 
+	if (options->output_fmt & OUTPUT_FMT_NONE)
+		options->output_fmt = 0;
+
+	if (options->output_fmt & (OUTPUT_FMT_NAME |
+				   OUTPUT_FMT_CHECKDIFF |
+				   OUTPUT_FMT_NONE))
+		options->output_fmt &= ~(OUTPUT_FMT_RAW |
+					 OUTPUT_FMT_DIFFSTAT |
+					 OUTPUT_FMT_SUMMARY |
+					 OUTPUT_FMT_PATCH);
+
 	/*
 	 * These cases always need recursive; we do not drop caller-supplied
 	 * recursive bits for other formats here.
 	 */
-	if ((options->output_format == DIFF_FORMAT_PATCH) ||
-	    (options->output_format == DIFF_FORMAT_DIFFSTAT) ||
-	    (options->output_format == DIFF_FORMAT_CHECKDIFF))
+	if (options->output_fmt & (OUTPUT_FMT_PATCH |
+				   OUTPUT_FMT_DIFFSTAT |
+				   OUTPUT_FMT_CHECKDIFF))
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
@@ -1408,7 +1411,7 @@ int diff_setup_done(struct diff_options 
 	return 0;
 }
 
-int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
+static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
 {
 	char c, *eq;
 	int len;
@@ -1459,22 +1462,20 @@ int diff_opt_parse(struct diff_options *
 {
 	const char *arg = av[0];
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
-		options->output_format = DIFF_FORMAT_PATCH;
+		options->output_fmt |= OUTPUT_FMT_PATCH;
 	else if (opt_arg(arg, 'U', "unified", &options->context))
-		options->output_format = DIFF_FORMAT_PATCH;
+		options->output_fmt |= OUTPUT_FMT_PATCH;
 	else if (!strcmp(arg, "--patch-with-raw")) {
-		options->output_format = DIFF_FORMAT_PATCH;
-		options->with_raw = 1;
+		options->output_fmt |= OUTPUT_FMT_PATCH | OUTPUT_FMT_RAW;
 	}
 	else if (!strcmp(arg, "--stat"))
-		options->output_format = DIFF_FORMAT_DIFFSTAT;
+		options->output_fmt |= OUTPUT_FMT_DIFFSTAT;
 	else if (!strcmp(arg, "--check"))
-		options->output_format = DIFF_FORMAT_CHECKDIFF;
+		options->output_fmt |= OUTPUT_FMT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
-		options->summary = 1;
+		options->output_fmt |= OUTPUT_FMT_SUMMARY;
 	else if (!strcmp(arg, "--patch-with-stat")) {
-		options->output_format = DIFF_FORMAT_PATCH;
-		options->with_stat = 1;
+		options->output_fmt |= OUTPUT_FMT_PATCH | OUTPUT_FMT_DIFFSTAT;
 	}
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
@@ -1483,19 +1484,20 @@ int diff_opt_parse(struct diff_options *
 	else if (!strcmp(arg, "--full-index"))
 		options->full_index = 1;
 	else if (!strcmp(arg, "--binary")) {
-		options->output_format = DIFF_FORMAT_PATCH;
+		options->output_fmt |= OUTPUT_FMT_PATCH;
 		options->full_index = options->binary = 1;
 	}
 	else if (!strcmp(arg, "--name-only"))
-		options->output_format = DIFF_FORMAT_NAME;
+		options->output_fmt |= OUTPUT_FMT_NAME;
 	else if (!strcmp(arg, "--name-status"))
-		options->output_format = DIFF_FORMAT_NAME_STATUS;
+		options->output_fmt |= OUTPUT_FMT_NAME_STATUS;
 	else if (!strcmp(arg, "-R"))
 		options->reverse_diff = 1;
 	else if (!strncmp(arg, "-S", 2))
 		options->pickaxe = arg + 2;
-	else if (!strcmp(arg, "-s"))
-		options->output_format = DIFF_FORMAT_NO_OUTPUT;
+	else if (!strcmp(arg, "-s")) {
+		options->output_fmt |= OUTPUT_FMT_NONE;
+	}
 	else if (!strncmp(arg, "-O", 2))
 		options->orderfile = arg + 2;
 	else if (!strncmp(arg, "--diff-filter=", 14))
@@ -1669,7 +1671,7 @@ static void diff_flush_raw(struct diff_f
 			   int line_termination,
 			   int inter_name_termination,
 			   struct diff_options *options,
-			   int output_format)
+			   int raw)
 {
 	int two_paths;
 	char status[10];
@@ -1703,7 +1705,7 @@ static void diff_flush_raw(struct diff_f
 		two_paths = 0;
 		break;
 	}
-	if (output_format != DIFF_FORMAT_NAME_STATUS) {
+	if (raw) {
 		printf(":%06o %06o %s ",
 		       p->one->mode, p->two->mode,
 		       diff_unique_abbrev(p->one->sha1, abbrev));
@@ -1720,16 +1722,12 @@ static void diff_flush_raw(struct diff_f
 		free((void*)path_two);
 }
 
-static void diff_flush_name(struct diff_filepair *p,
-			    int inter_name_termination,
-			    int line_termination)
+static void diff_flush_name(struct diff_filepair *p, int line_termination)
 {
 	char *path = p->two->path;
 
 	if (line_termination)
 		path = quote_one(p->two->path);
-	else
-		path = p->two->path;
 	printf("%s%c", path, line_termination);
 	if (p->two->path != path)
 		free(path);
@@ -1916,50 +1914,44 @@ static void diff_resolve_rename_copy(voi
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
-			diff_flush_name(p,
-					inter_name_termination,
-					line_termination);
-			break;
-		case DIFF_FORMAT_NO_OUTPUT:
-			break;
-		}
+		return 1;
 	}
 }
 
+static void flush_one_pair_raw(struct diff_filepair *p,
+			   struct diff_options *options, int raw)
+{
+	int inter_name_termination = '\t';
+	int line_termination = options->line_termination;
+
+	if (!line_termination)
+		inter_name_termination = 0;
+	diff_flush_raw(p, line_termination, inter_name_termination,
+			options, raw);
+}
+
+static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
+{
+	int fmt = opt->output_fmt;
+
+	if (fmt & OUTPUT_FMT_CHECKDIFF)
+		diff_flush_checkdiff(p, opt);
+	else if (fmt & OUTPUT_FMT_RAW)
+		flush_one_pair_raw(p, opt, 1);
+	else if (fmt & OUTPUT_FMT_NAME_STATUS)
+		flush_one_pair_raw(p, opt, 0);
+	else if (fmt & OUTPUT_FMT_NAME)
+		diff_flush_name(p, opt->line_termination);
+}
+
 static void show_file_mode_name(const char *newdelete, struct diff_filespec *fs)
 {
 	if (fs->mode)
@@ -2042,55 +2034,60 @@ static void diff_summary(struct diff_fil
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	int i;
-	int diff_output_format = options->output_format;
-	struct diffstat_t *diffstat = NULL;
+	int i, output_fmt = options->output_fmt;
 
-	if (diff_output_format == DIFF_FORMAT_DIFFSTAT || options->with_stat) {
-		diffstat = xcalloc(sizeof (struct diffstat_t), 1);
-		diffstat->xm.consume = diffstat_consume;
-	}
+	/*
+	 * Order: raw, stat, summary, patch
+	 * or:    name/name-status/checkdiff (other bits clear)
+	 */
 
-	if (options->with_raw) {
+	if (output_fmt & (OUTPUT_FMT_RAW |
+			  OUTPUT_FMT_NAME |
+			  OUTPUT_FMT_NAME_STATUS |
+			  OUTPUT_FMT_CHECKDIFF)) {
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
+	if (output_fmt & OUTPUT_FMT_DIFFSTAT) {
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
+	}
+
+	if (output_fmt & OUTPUT_FMT_SUMMARY) {
+		for (i = 0; i < q->nr; i++)
+			diff_summary(q->queue[i]);
+	}
+
+	if (output_fmt & (OUTPUT_FMT_DIFFSTAT | OUTPUT_FMT_SUMMARY)) {
 		if (options->stat_sep)
 			fputs(options->stat_sep, stdout);
 		else
 			putchar(options->line_termination);
 	}
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		flush_one_pair(p, diff_output_format, options, diffstat);
-	}
 
-	if (diffstat) {
-		show_stats(diffstat);
-		free(diffstat);
+	if (output_fmt & OUTPUT_FMT_PATCH) {
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if (check_pair_status(p))
+				diff_flush_patch(p, options);
+		}
 	}
 
-	for (i = 0; i < q->nr; i++) {
-		if (diffstat && options->summary)
-			diff_summary(q->queue[i]);
+	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
-	}
-
 	free(q->queue);
 	q->queue = NULL;
 	q->nr = q->alloc = 0;
diff --git a/diff.h b/diff.h
index de9de57..a16bc5a 100644
--- a/diff.h
+++ b/diff.h
@@ -20,25 +20,37 @@ typedef void (*add_remove_fn_t)(struct d
 		    const unsigned char *sha1,
 		    const char *base, const char *path);
 
+#define OUTPUT_FMT_RAW		0x0001
+#define OUTPUT_FMT_DIFFSTAT	0x0002
+#define OUTPUT_FMT_SUMMARY	0x0004
+#define OUTPUT_FMT_PATCH	0x0008
+
+/* These override all above */
+#define OUTPUT_FMT_NAME		0x0010
+#define OUTPUT_FMT_NAME_STATUS	0x0020
+#define OUTPUT_FMT_CHECKDIFF	0x0040
+
+/* Same as output_fmt = 0 but we know that -s flag was given
+ * and we should not give default value to output_fmt.
+ */
+#define OUTPUT_FMT_NONE		0x0080
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
 	int detect_rename;
 	int line_termination;
-	int output_format;
+	int output_fmt;
 	int pickaxe_opts;
 	int rename_score;
 	int reverse_diff;
@@ -150,15 +162,6 @@ #define COMMON_DIFF_OPTIONS_HELP \
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
index ebb49f2..2cdb0ab 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -156,15 +156,20 @@ int log_tree_diff_flush(struct rev_info 
 	diffcore_std(&opt->diffopt);
 
 	if (diff_queue_is_empty()) {
-		int saved_fmt = opt->diffopt.output_format;
-		opt->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
+		int saved_fmt = opt->diffopt.output_fmt;
+		opt->diffopt.output_fmt = OUTPUT_FMT_NONE;
 		diff_flush(&opt->diffopt);
-		opt->diffopt.output_format = saved_fmt;
+		opt->diffopt.output_fmt = saved_fmt;
 		return 0;
 	}
 
-	if (opt->loginfo && !opt->no_commit_id)
-		show_log(opt, opt->loginfo, opt->diffopt.with_stat ? "---\n" : "\n");
+	if (opt->loginfo && !opt->no_commit_id) {
+		if (opt->diffopt.output_fmt & OUTPUT_FMT_DIFFSTAT) {
+			show_log(opt, opt->loginfo,  "---\n");
+		} else {
+			show_log(opt, opt->loginfo,  "\n");
+		}
+	}
 	diff_flush(&opt->diffopt);
 	return 1;
 }
diff --git a/revision.c b/revision.c
index b963f2a..4ad2272 100644
--- a/revision.c
+++ b/revision.c
@@ -852,8 +852,8 @@ int setup_revisions(int argc, const char
 	if (revs->combine_merges) {
 		revs->ignore_merges = 0;
 		if (revs->dense_combined_merges &&
-		    (revs->diffopt.output_format != DIFF_FORMAT_DIFFSTAT))
-			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
+		   !(revs->diffopt.output_fmt & OUTPUT_FMT_DIFFSTAT))
+			revs->diffopt.output_fmt |= OUTPUT_FMT_PATCH;
 	}
 	revs->diffopt.abbrev = revs->abbrev;
 	diff_setup_done(&revs->diffopt);
-- 
1.4.1.rc1.gf603-dirty
