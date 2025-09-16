Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BAB2C2353
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053612; cv=none; b=nM4+h8zeATLaadb31oyVCO0oOdf/lP1/cidke9Y4EN70w1SHOlVN2wphKUwruyhIXuMXnxRWprF4fYFSe6SJWo7XWQX03fXxwai+uuYs2JaHQLv+eYxn2RwMBb5bnRAXeScv+mScZvWsXq5To7hGIDM0cCdg9WQHZZtYMMVw/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053612; c=relaxed/simple;
	bh=5/OIGLFikf4rYlME3V8Jx/t4JIdds+g3N/a51eNvaEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mS90B8T+Kkz2YoCZ1yn0FQNgIblK9y1Qk9MLucs0eZB0nyPW4g+h/2jjTSnxkJFY0myXz7k5+2CEcfFrtVc9DHxf8E455yOnnLL4nuK2k5skvGrsWDkfYPV+7JBjcPD06+eDcwZrVU6U+Mc93Rnk5waXpiqnjXeBjTF59jrW2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=a8UZEIf6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="a8UZEIf6"
Received: (qmail 102260 invoked by uid 109); 16 Sep 2025 20:13:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5/OIGLFikf4rYlME3V8Jx/t4JIdds+g3N/a51eNvaEE=; b=a8UZEIf6LAqBaQHv4+g8eMMJlQCm76l7pp5auHQIyyWxar9kLbnqy0xoULuVc9Rfo5Z3chyDbO+t8lNYRmEmXMPmkBEOBSflr65tvfJZz/SSSCd+QYhVmtfe52Nmn1PORor94/U6c3B/z/kVL9Jzt6cJ4stuzEAsPGu6bE2lUipbZ+ViTcnqvIi7wSrCTBh1QFjDu3FNuQ6+OZVc81887OsxAnEMnqhiif6dQ0hcKNpIzbuEWw90rSJbEi8Soso4yr9YMJ3/eM7te4T1BVRGEcW2TQS3j6Gdtux19IxTeVLb+lBXVgUPOF5qPZ1z/RHfY7RZIUM8iy+k/821Pp3o1A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:13:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166083 invoked by uid 111); 16 Sep 2025 20:13:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:13:28 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:13:28 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 01/13] color: use GIT_COLOR_* instead of numeric constants
Message-ID: <20250916201328.GA612873@coredump.intra.peff.net>
References: <20250916201036.GA612463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916201036.GA612463@coredump.intra.peff.net>

Long ago Git's decision to show color for a subsytem was stored in a
tri-state variable: it could be true (1), false (0), or unknown (-1).
But since daa0c3d971 (color: delay auto-color decision until point of
use, 2011-08-17) we want to carry around a new state, "auto", which
bases the decision on the tty-ness of stdout (rather than collapsing
that "auto" state to a true/false immediately).

That commit introduced a set of GIT_COLOR_* defines to represent each
state: UNKNOWN, ALWAYS, NEVER, and AUTO. But it only used the AUTO
value, and left alone code using bare 0/1/-1 values. And of course since
then we've grown many new spots that use those bare values.

Let's switch all of these to use the named constants. That should make
the code a bit easier to read, as it is more obvious that we're
representing a color decision.

Signed-off-by: Jeff King <peff@peff.net>
---
 add-interactive.c     |  9 +++++----
 advice.c              |  2 +-
 builtin/add.c         |  2 +-
 builtin/am.c          |  4 ++--
 builtin/branch.c      |  2 +-
 builtin/clean.c       |  2 +-
 builtin/commit.c      |  2 +-
 builtin/config.c      | 12 ++++++------
 builtin/grep.c        |  2 +-
 builtin/push.c        |  2 +-
 builtin/range-diff.c  |  3 ++-
 builtin/show-branch.c |  2 +-
 color.c               | 12 ++++++------
 diff.c                |  6 +++---
 grep.h                |  2 +-
 parse-options-cb.c    |  2 +-
 pretty.c              |  2 +-
 ref-filter.h          |  2 +-
 sideband.c            |  4 ++--
 transport.c           |  2 +-
 wt-status.c           |  6 +++---
 21 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 4604c69140..34c020673e 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -42,7 +42,7 @@ static int check_color_config(struct repository *r, const char *var)
 	int ret;
 
 	if (repo_config_get_value(r, var, &value))
-		ret = -1;
+		ret = GIT_COLOR_UNKNOWN;
 	else
 		ret = git_config_colorbool(var, value);
 
@@ -51,7 +51,8 @@ static int check_color_config(struct repository *r, const char *var)
 	 * the value parsed by git_color_config(), which may not have been
 	 * called by the main command.
 	 */
-	if (ret < 0 && !repo_config_get_value(r, "color.ui", &value))
+	if (ret == GIT_COLOR_UNKNOWN &&
+	    !repo_config_get_value(r, "color.ui", &value))
 		ret = git_config_colorbool("color.ui", value);
 
 	return want_color(ret);
@@ -130,8 +131,8 @@ void clear_add_i_state(struct add_i_state *s)
 	FREE_AND_NULL(s->interactive_diff_filter);
 	FREE_AND_NULL(s->interactive_diff_algorithm);
 	memset(s, 0, sizeof(*s));
-	s->use_color_interactive = -1;
-	s->use_color_diff = -1;
+	s->use_color_interactive = GIT_COLOR_UNKNOWN;
+	s->use_color_diff = GIT_COLOR_UNKNOWN;
 }
 
 /*
diff --git a/advice.c b/advice.c
index e5f0ff8449..a00aaad9de 100644
--- a/advice.c
+++ b/advice.c
@@ -7,7 +7,7 @@
 #include "help.h"
 #include "string-list.h"
 
-static int advice_use_color = -1;
+static int advice_use_color = GIT_COLOR_UNKNOWN;
 static char advice_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_YELLOW,	/* HINT */
diff --git a/builtin/add.c b/builtin/add.c
index 740c7c4581..4cd3d183f9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -200,7 +200,7 @@ static int edit_patch(struct repository *repo,
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
-	rev.diffopt.use_color = 0;
+	rev.diffopt.use_color = GIT_COLOR_NEVER;
 	rev.diffopt.flags.ignore_dirty_submodules = 1;
 	out = xopen(file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
 	rev.diffopt.file = xfdopen(out, "w");
diff --git a/builtin/am.c b/builtin/am.c
index 6073d64ae9..277c2e7937 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1408,7 +1408,7 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 	rev_info.no_commit_id = 1;
 	rev_info.diffopt.flags.binary = 1;
 	rev_info.diffopt.flags.full_index = 1;
-	rev_info.diffopt.use_color = 0;
+	rev_info.diffopt.use_color = GIT_COLOR_NEVER;
 	rev_info.diffopt.file = fp;
 	rev_info.diffopt.close_file = 1;
 	add_pending_object(&rev_info, &commit->object, "");
@@ -1441,7 +1441,7 @@ static void write_index_patch(const struct am_state *state)
 	rev_info.disable_stdin = 1;
 	rev_info.no_commit_id = 1;
 	rev_info.diffopt.output_format = DIFF_FORMAT_PATCH;
-	rev_info.diffopt.use_color = 0;
+	rev_info.diffopt.use_color = GIT_COLOR_NEVER;
 	rev_info.diffopt.file = fp;
 	rev_info.diffopt.close_file = 1;
 	add_pending_object(&rev_info, &tree->object, "");
diff --git a/builtin/branch.c b/builtin/branch.c
index fa5ced452e..029223df7b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -46,7 +46,7 @@ static struct object_id head_oid;
 static int recurse_submodules = 0;
 static int submodule_propagate_branches = 0;
 
-static int branch_use_color = -1;
+static int branch_use_color = GIT_COLOR_UNKNOWN;
 static char branch_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_NORMAL,       /* PLAIN */
diff --git a/builtin/clean.c b/builtin/clean.c
index 38b67923a6..0ac90a3feb 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -64,7 +64,7 @@ static const char *color_interactive_slots[] = {
 	[CLEAN_COLOR_RESET]  = "reset",
 };
 
-static int clean_use_color = -1;
+static int clean_use_color = GIT_COLOR_UNKNOWN;
 static char clean_colors[][COLOR_MAXLEN] = {
 	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
 	[CLEAN_COLOR_HEADER] = GIT_COLOR_BOLD,
diff --git a/builtin/commit.c b/builtin/commit.c
index 8a5dee384d..544603a9c7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1016,7 +1016,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		status_printf_ln(s, GIT_COLOR_NORMAL, "%s", ""); /* Add new line for clarity */
 
 		saved_color_setting = s->use_color;
-		s->use_color = 0;
+		s->use_color = GIT_COLOR_NEVER;
 		committable = run_status(s->fp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
 		string_list_clear_func(&s->change, change_data_free);
diff --git a/builtin/config.c b/builtin/config.c
index 59fb113b07..c3da3ae210 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -594,23 +594,23 @@ static int get_colorbool(const struct config_location_options *opts,
 {
 	struct get_colorbool_config_data data = {
 		.get_colorbool_slot = var,
-		.get_colorbool_found = -1,
-		.get_diff_color_found = -1,
-		.get_color_ui_found = -1,
+		.get_colorbool_found = GIT_COLOR_UNKNOWN,
+		.get_diff_color_found = GIT_COLOR_UNKNOWN,
+		.get_color_ui_found = GIT_COLOR_UNKNOWN,
 	};
 
 	config_with_options(git_get_colorbool_config, &data,
 			    &opts->source, the_repository,
 			    &opts->options);
 
-	if (data.get_colorbool_found < 0) {
+	if (data.get_colorbool_found == GIT_COLOR_UNKNOWN) {
 		if (!strcmp(data.get_colorbool_slot, "color.diff"))
 			data.get_colorbool_found = data.get_diff_color_found;
-		if (data.get_colorbool_found < 0)
+		if (data.get_colorbool_found == GIT_COLOR_UNKNOWN)
 			data.get_colorbool_found = data.get_color_ui_found;
 	}
 
-	if (data.get_colorbool_found < 0)
+	if (data.get_colorbool_found == GIT_COLOR_UNKNOWN)
 		/* default value if none found in config */
 		data.get_colorbool_found = GIT_COLOR_AUTO;
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 5df6537333..1d97eb2a2a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1091,7 +1091,7 @@ int cmd_grep(int argc,
 	if (show_in_pager == default_pager)
 		show_in_pager = git_pager(the_repository, 1);
 	if (show_in_pager) {
-		opt.color = 0;
+		opt.color = GIT_COLOR_NEVER;
 		opt.name_only = 1;
 		opt.null_following_name = 1;
 		opt.output_priv = &path_list;
diff --git a/builtin/push.c b/builtin/push.c
index d0794b7b30..0962b122c7 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -27,7 +27,7 @@ static const char * const push_usage[] = {
 	NULL,
 };
 
-static int push_use_color = -1;
+static int push_use_color = GIT_COLOR_UNKNOWN;
 static char push_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_RED,	/* ERROR */
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index a563abff5f..0d51ddd623 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -6,6 +6,7 @@
 #include "parse-options.h"
 #include "range-diff.h"
 #include "config.h"
+#include "color.h"
 
 
 static const char * const builtin_range_diff_usage[] = {
@@ -66,7 +67,7 @@ int cmd_range_diff(int argc,
 
 	/* force color when --dual-color was used */
 	if (!simple_color)
-		diffopt.use_color = 1;
+		diffopt.use_color = GIT_COLOR_ALWAYS;
 
 	/* If `--diff-merges` was specified, imply `--merges` */
 	if (diff_merges_arg.nr) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 1ab7db9d2c..970e78bc2d 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -29,7 +29,7 @@ static const char*const show_branch_usage[] = {
     NULL
 };
 
-static int showbranch_use_color = -1;
+static int showbranch_use_color = GIT_COLOR_UNKNOWN;
 
 static struct strvec default_args = STRVEC_INIT;
 
diff --git a/color.c b/color.c
index 7df8862c71..22aa453fef 100644
--- a/color.c
+++ b/color.c
@@ -373,19 +373,19 @@ int git_config_colorbool(const char *var, const char *value)
 {
 	if (value) {
 		if (!strcasecmp(value, "never"))
-			return 0;
+			return GIT_COLOR_NEVER;
 		if (!strcasecmp(value, "always"))
-			return 1;
+			return GIT_COLOR_ALWAYS;
 		if (!strcasecmp(value, "auto"))
 			return GIT_COLOR_AUTO;
 	}
 
 	if (!var)
-		return -1;
+		return GIT_COLOR_UNKNOWN;
 
 	/* Missing or explicit false to turn off colorization */
 	if (!git_config_bool(var, value))
-		return 0;
+		return GIT_COLOR_NEVER;
 
 	/* any normal truth value defaults to 'auto' */
 	return GIT_COLOR_AUTO;
@@ -418,15 +418,15 @@ int want_color_fd(int fd, int var)
 	if (fd < 1 || fd >= ARRAY_SIZE(want_auto))
 		BUG("file descriptor out of range: %d", fd);
 
-	if (var < 0)
+	if (var == GIT_COLOR_UNKNOWN)
 		var = git_use_color_default;
 
 	if (var == GIT_COLOR_AUTO) {
 		if (want_auto[fd] < 0)
 			want_auto[fd] = check_auto_color(fd);
 		return want_auto[fd];
 	}
-	return var;
+	return var == GIT_COLOR_ALWAYS;
 }
 
 int git_color_config(const char *var, const char *value, void *cb UNUSED)
diff --git a/diff.c b/diff.c
index 51603117a9..64a4bd23ea 100644
--- a/diff.c
+++ b/diff.c
@@ -57,7 +57,7 @@ static int diff_detect_rename_default;
 static int diff_indent_heuristic = 1;
 static int diff_rename_limit_default = 1000;
 static int diff_suppress_blank_empty;
-static int diff_use_color_default = -1;
+static int diff_use_color_default = GIT_COLOR_UNKNOWN;
 static int diff_color_moved_default;
 static int diff_color_moved_ws_default;
 static int diff_context_default = 3;
@@ -5278,7 +5278,7 @@ static int diff_opt_color_words(const struct option *opt,
 	struct diff_options *options = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
-	options->use_color = 1;
+	options->use_color = GIT_COLOR_ALWAYS;
 	options->word_diff = DIFF_WORDS_COLOR;
 	options->word_regex = arg;
 	return 0;
@@ -5600,7 +5600,7 @@ static int diff_opt_word_diff(const struct option *opt,
 		if (!strcmp(arg, "plain"))
 			options->word_diff = DIFF_WORDS_PLAIN;
 		else if (!strcmp(arg, "color")) {
-			options->use_color = 1;
+			options->use_color = GIT_COLOR_ALWAYS;
 			options->word_diff = DIFF_WORDS_COLOR;
 		}
 		else if (!strcmp(arg, "porcelain"))
diff --git a/grep.h b/grep.h
index 926c0875c4..43195baab3 100644
--- a/grep.h
+++ b/grep.h
@@ -198,7 +198,7 @@ struct grep_opt {
 		[GREP_COLOR_SEP] = GIT_COLOR_CYAN, \
 	}, \
 	.only_matching = 0, \
-	.color = -1, \
+	.color = GIT_COLOR_UNKNOWN, \
 	.output = std_output, \
 }
 
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 50c8afe412..e13e0a9e33 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -55,7 +55,7 @@ int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
 	if (!arg)
 		arg = unset ? "never" : (const char *)opt->defval;
 	value = git_config_colorbool(NULL, arg);
-	if (value < 0)
+	if (value == GIT_COLOR_UNKNOWN)
 		return error(_("option `%s' expects \"always\", \"auto\", or \"never\""),
 			     opt->long_name);
 	*(int *)opt->value = value;
diff --git a/pretty.c b/pretty.c
index cee96b9d94..0521deadc0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1462,7 +1462,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		} else {
 			int ret = parse_color(sb, placeholder, c);
 			if (ret)
-				c->auto_color = 0;
+				c->auto_color = GIT_COLOR_NEVER;
 			/*
 			 * Otherwise, we decided to treat %C<unknown>
 			 * as a literal string, and the previous
diff --git a/ref-filter.h b/ref-filter.h
index f22ca94b49..644f5c567c 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -111,7 +111,7 @@ struct ref_format {
 	.exclude = STRVEC_INIT, \
 }
 #define REF_FORMAT_INIT {             \
-	.use_color = -1,              \
+	.use_color = GIT_COLOR_UNKNOWN, \
 }
 
 /*  Macros for checking --merged and --no-merged options */
diff --git a/sideband.c b/sideband.c
index 8f15b98a65..3ac87148b9 100644
--- a/sideband.c
+++ b/sideband.c
@@ -29,14 +29,14 @@ static struct keyword_entry keywords[] = {
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
 static int use_sideband_colors(void)
 {
-	static int use_sideband_colors_cached = -1;
+	static int use_sideband_colors_cached = GIT_COLOR_UNKNOWN;
 
 	const char *key = "color.remote";
 	struct strbuf sb = STRBUF_INIT;
 	const char *value;
 	int i;
 
-	if (use_sideband_colors_cached >= 0)
+	if (use_sideband_colors_cached != GIT_COLOR_UNKNOWN)
 		return use_sideband_colors_cached;
 
 	if (!repo_config_get_string_tmp(the_repository, key, &value))
diff --git a/transport.c b/transport.c
index 6ac8aa402b..ea0be4503c 100644
--- a/transport.c
+++ b/transport.c
@@ -30,7 +30,7 @@
 #include "color.h"
 #include "bundle-uri.h"
 
-static int transport_use_color = -1;
+static int transport_use_color = GIT_COLOR_UNKNOWN;
 static char transport_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_RED		/* REJECTED */
diff --git a/wt-status.c b/wt-status.c
index 21dabab77d..8ffe6d3988 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -148,7 +148,7 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
 	memcpy(s->color_palette, default_wt_status_colors,
 	       sizeof(default_wt_status_colors));
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
-	s->use_color = -1;
+	s->use_color = GIT_COLOR_UNKNOWN;
 	s->relative_paths = 1;
 	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
 					"HEAD", 0, NULL, NULL);
@@ -1165,7 +1165,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	 * before.
 	 */
 	if (s->fp != stdout) {
-		rev.diffopt.use_color = 0;
+		rev.diffopt.use_color = GIT_COLOR_NEVER;
 		wt_status_add_cut_line(s);
 	}
 	if (s->verbose > 1 && s->committable) {
@@ -2155,7 +2155,7 @@ static void wt_shortstatus_print(struct wt_status *s)
 
 static void wt_porcelain_print(struct wt_status *s)
 {
-	s->use_color = 0;
+	s->use_color = GIT_COLOR_NEVER;
 	s->relative_paths = 0;
 	s->prefix = NULL;
 	s->no_gettext = 1;
-- 
2.51.0.527.g34bc42dacd

