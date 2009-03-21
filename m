From: Keith Cascio <keith@cs.ucla.edu>
Subject: [PATCH/RFC v3] Introduce config variable "diff.defaultoptions"
Date: Fri, 20 Mar 2009 19:00:53 -0700
Message-ID: <1237600853-22815-1-git-send-email-keith@cs.ucla.edu>
References: <20090320194930.GB26934@coredump.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 21 03:02:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkqXn-0002LL-Ma
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 03:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842AbZCUCBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 22:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbZCUCBD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 22:01:03 -0400
Received: from Sensitivity.CS.UCLA.EDU ([131.179.176.150]:40792 "EHLO
	sensitivity.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833AbZCUCA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 22:00:59 -0400
Received: from sensitivity.cs.ucla.edu (localhost.localdomain [127.0.0.1])
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8) with ESMTP id n2L20rX3022845;
	Fri, 20 Mar 2009 19:00:53 -0700
Received: (from keith@localhost)
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8/Submit) id n2L20rZj022844;
	Fri, 20 Mar 2009 19:00:53 -0700
X-Mailer: git-send-email 1.6.1
In-Reply-To: <20090320194930.GB26934@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114021>

Improve porcelain diff's accommodation of user preference by allowing any
command-line option to (a) persist over all invocations and (b) stay consistent
over multiple tools (e.g. command-line and gui).  The approach taken here is
good because it delivers the consistency a user expects without breaking any
plumbing.  It works by allowing the user, via git-config, to specify arbitrary
options to pass to porcelain diff on every invocation, including internal
invocations from other programs, e.g. git-gui.

Introduce diff command-line options --default-options and --no-default-options.

Affect only porcelain diff: we suppress default options for plumbing
diff-{files,index,tree}, format-patch, and all other commands unless explicitly
requested using --default-options (opt-in).

Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
---

Please notice v3 supports all diff options (improvement over v2).

This is a RFC.  I omitted the documentation and test portions for now.

                                    -- Keith

 diff.h         |   17 ++++++--
 diff.c         |  112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 builtin-diff.c |    1 +
 builtin-log.c  |    1 +
 4 files changed, 125 insertions(+), 6 deletions(-)

diff --git a/diff.h b/diff.h
index 6616877..66f1518 100644
--- a/diff.h
+++ b/diff.h
@@ -66,12 +66,17 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
+#define DIFF_OPT_ALLOW_DEFAULT_OPTIONS (1 << 22)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
-#define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
+#define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag),\
+				    ((opts)->mask  |= DIFF_OPT_##flag)
-#define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
+#define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag),\
+				    ((opts)->mask  |=  DIFF_OPT_##flag)
 #define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts & XDF_##flag)
-#define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
+#define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag),\
+				    ((opts)->xdl_mask |= XDF_##flag)
-#define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag)
+#define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag),\
+				    ((opts)->xdl_mask |=  XDF_##flag)
 
 struct diff_options {
 	const char *filter;
@@ -80,6 +85,7 @@ struct diff_options {
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	unsigned flags;
+	unsigned mask;
 	int context;
 	int interhunkcontext;
 	int break_opt;
@@ -98,6 +104,7 @@ struct diff_options {
 	int prefix_length;
 	const char *stat_sep;
 	long xdl_opts;
+	long xdl_mask;
 
 	int stat_width;
 	int stat_name_width;
@@ -193,7 +200,7 @@ extern void diff_unmerge(struct diff_options *,
 extern int git_diff_basic_config(const char *var, const char *value, void *cb);
 extern int git_diff_ui_config(const char *var, const char *value, void *cb);
 extern int diff_use_color_default;
-extern void diff_setup(struct diff_options *);
+extern struct diff_options* diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int);
 extern int diff_setup_done(struct diff_options *);
 
diff --git a/diff.c b/diff.c
index 75d9fab..1c4fec4 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,8 @@ static int diff_suppress_blank_empty;
 int diff_use_color_default = -1;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
+static const char *diff_defaults;
+static struct diff_options *defaults;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 
@@ -106,6 +108,8 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		diff_rename_limit_default = git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.defaultoptions"))
+		return git_config_string(&diff_defaults, var, value);
 
 	switch (userdiff_config(var, value)) {
 		case 0: break;
@@ -2314,7 +2318,101 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
 
+struct diff_options* parse_diff_defaults(struct diff_options *options)
+{
+	int count, len, i;
+	const char **new_argv;
+
+	if ((! diff_defaults) || ((len = (strlen(diff_defaults)+1)) < 3))
+		return options;
+	count = split_cmdline(strncpy(xmalloc(len), diff_defaults, len),
+			&new_argv);
+	for (i=0; i<count; i++)
+		diff_opt_parse(options, &new_argv[i], -1);
+	return options;
+}
+
+#define PRISTINE -0x40
+#define COALESCE_PTR(p) master->p = master->p ? master->p : slave->p
+#define COALESCE_INT(i) master->i = master->i != PRISTINE ? master->i : slave->i
+
+struct diff_options* flatten_diff_options(struct diff_options *master,
+					  struct diff_options *slave)
+{
+	/*
+	 * Our desired flags are:
+	 *
+	 *   1. Anything the master hasn't explicitly set, we can take from
+	 *      the slave.
+	 *   2. Anything the slave didn't explicitly set, we can take whether
+	 *      or not the master set it explicitly.
+	 *   3. Anything the master explicitly set, we take.
+	 */
+	master->flags =
+	 /* (1) */ (~master->mask & slave->flags & slave->mask) |
+	 /* (2) */ (master->flags & ~slave->mask) |
+	 /* (3) */ (master->flags & master->mask);
+	master->mask |= slave->mask;
+	master->xdl_opts =
+	 /* (1) */ (~master->xdl_mask & slave->xdl_opts & slave->xdl_mask) |
+	 /* (2) */ (master->xdl_opts & ~slave->xdl_mask) |
+	 /* (3) */ (master->xdl_opts & master->xdl_mask);
+	master->xdl_mask |= slave->xdl_mask;
+	master->output_format |= slave->output_format;
+	master->setup |= slave->setup;
+	COALESCE_PTR(a_prefix);
+	COALESCE_PTR(b_prefix);
+	COALESCE_PTR(filter);
+	COALESCE_PTR(orderfile);
+	COALESCE_PTR(pickaxe);
+	COALESCE_PTR(prefix);
+	COALESCE_PTR(single_follow);
+	COALESCE_PTR(stat_sep);
+	COALESCE_PTR(word_regex);
+	COALESCE_INT(abbrev);
+	COALESCE_INT(break_opt);
+	COALESCE_INT(close_file);
+	COALESCE_INT(context);
+	COALESCE_INT(detect_rename);
+	COALESCE_INT(dirstat_percent);
+	COALESCE_INT(interhunkcontext);
+	COALESCE_INT(line_termination);
+	COALESCE_INT(pickaxe_opts);
+	COALESCE_INT(prefix_length);
+	COALESCE_INT(rename_limit);
+	COALESCE_INT(rename_score);
+	COALESCE_INT(skip_stat_unmatch);
+	COALESCE_INT(stat_name_width);
+	COALESCE_INT(stat_width);
+	COALESCE_INT(warn_on_too_large_rename);
+	COALESCE_PTR(file);
+	COALESCE_PTR(change);
+	COALESCE_PTR(add_remove);
+	COALESCE_PTR(format_callback);
+	COALESCE_PTR(format_callback_data);
+	if((! master->paths) && slave->paths){
+		master->nr_paths = slave->nr_paths;
+		master->paths    = slave->paths;
+		master->pathlens = slave->pathlens;
+	}
+	return master;
+}
+
-void diff_setup(struct diff_options *options)
+struct diff_options* diff_setup(struct diff_options *options)
+{
+	memset(options, 0, sizeof(*options));
+	options->abbrev = options->break_opt = options->close_file =
+	options->context = options->detect_rename =
+	options->dirstat_percent = options->interhunkcontext =
+	options->line_termination = options->pickaxe_opts =
+	options->prefix_length = options->rename_limit =
+	options->rename_score = options->skip_stat_unmatch =
+	options->stat_name_width = options->stat_width =
+	options->warn_on_too_large_rename = PRISTINE;
+	return options;
+}
+
+struct diff_options* diff_fallback_values(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
 
@@ -2336,11 +2434,19 @@ void diff_setup(struct diff_options *options)
 		options->a_prefix = "a/";
 		options->b_prefix = "b/";
 	}
+	return options;
 }
 
 int diff_setup_done(struct diff_options *options)
 {
 	int count = 0;
+	struct diff_options fallback;
+
+	if (DIFF_OPT_TST(options, ALLOW_DEFAULT_OPTIONS))
+		flatten_diff_options(options, defaults ? defaults :
+			parse_diff_defaults(diff_setup(defaults =
+				xmalloc(sizeof(struct diff_options)))));
+	flatten_diff_options(options, diff_fallback_values(&fallback));
 
 	if (options->output_format & DIFF_FORMAT_NAME)
 		count++;
@@ -2615,6 +2721,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
 	else if (!strcmp(arg, "--ignore-submodules"))
 		DIFF_OPT_SET(options, IGNORE_SUBMODULES);
+	else if (!strcmp(arg, "--default-options"))
+		DIFF_OPT_SET(options, ALLOW_DEFAULT_OPTIONS);
+	else if (!strcmp(arg, "--no-default-options"))
+		DIFF_OPT_CLR(options, ALLOW_DEFAULT_OPTIONS);
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
diff --git a/builtin-diff.c b/builtin-diff.c
index d75d69b..34c6ce2 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -283,6 +283,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		diff_use_color_default = git_use_color_default;
 
 	init_revisions(&rev, prefix);
+	DIFF_OPT_SET(&rev.diffopt, ALLOW_DEFAULT_OPTIONS);
 
 	/* If this is a no-index diff, just run it and exit there. */
 	diff_no_index(&rev, argc, argv, nongit, prefix);
diff --git a/builtin-log.c b/builtin-log.c
index 8af55d2..1fa583f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -37,6 +37,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		get_commit_format(fmt_pretty, rev);
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
+	DIFF_OPT_SET(&rev->diffopt, ALLOW_DEFAULT_OPTIONS);
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
 	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
-- 
1.6.2.1.337.g3b73.dirty
