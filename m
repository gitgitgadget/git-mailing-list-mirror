Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833A72F9D8A
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054473; cv=none; b=YJaa/CKlNT6HlDZDiEMwqoTAIyIYgMjQYk2HhVTVlU80KKAh3/6XRij1B36XJf+7zaPeNuh/E09rnVqEc0Kd4SJQt3dUsJfRBdQ3ezGO81DoV04iwuyBNZW5VVQOrrJMngM64RrghVCfRbmXhWVJ9VavdPrgt86CrcZihm/2QVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054473; c=relaxed/simple;
	bh=VUnzWzZ3Wcpuh6u0+zYrwTfqu8V2qHze0mMoXyqw16w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmyoR3i16NSX0/Io98mpdwZLk6N8bGgEql3b8ofa32viDCqkWPMOtrm+N7zh/MeBJXmePp2UmQU8ahQFpTc0nQNRC3OQaDK4vCrrb0HZP62mz/7n3426zHz3Qj7fcu77tyKka4nDNa4P6jGf/l/y0Zy6AFNlGh1yOEtaw31wezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BJwRveN0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BJwRveN0"
Received: (qmail 102520 invoked by uid 109); 16 Sep 2025 20:27:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VUnzWzZ3Wcpuh6u0+zYrwTfqu8V2qHze0mMoXyqw16w=; b=BJwRveN0DWXkXvvavmBxo6B5lQpjNskf7tw2ZVmSPf84mYn81Vc+5U5w4l6i6V9LypgNQZVjwR9NSylOPaXiwQLLAcYWruJ2yJUE6V5C+bwmGqEQCoH3W7ok5R35nZVJ185F/5y8jFItw6wYS9aJ+XO3Lc83ieaT+r+NBIbc3wPvHMkZUU0CqcBZ3C5SPfWmEQxR/yxKbIYMJOF+a69Q0nOGk5GraKwfb4blr3cPKY2vom7jQl3pBBkMFRpXfl04JHItJ7Q9azyng2H6/IUCB1DIb2jj7BGSGcd75ebBnY/myAG2yIByhVHiVrC3Fifp2YTeBtX3lDeoFzTnr1wzGg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:27:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166329 invoked by uid 111); 16 Sep 2025 20:27:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:27:49 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:27:48 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 13/13 DO NOT APPLY] color: convert git_colorbool into a struct
Message-ID: <20250916202748.GM612873@coredump.intra.peff.net>
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

There were a few minor bugs fixed earlier in this series that were
caused by confusion between an "enum git_colorbool" (which has four
values) and a real true/false bool. It would be nice if the compiler
alerted us to such problems, but C's weak typing allows implicit
conversions between bool, int, and enums (and even with more recent
-Wenum-* warnings, I couldn't get either gcc or clang to complain about
the buggy constructs).

But there is one way we can bend C's type system to our will: turning
the colorbool variables into structs, which cannot be implicitly
converted to a bool.

Unfortunately, doing so is rather invasive and ugly. Ideally we could
just do this in color.h:

  struct git_colorbool {
          enum git_colorbool f;
  };
  typedef struct git_colorbool git_colorbool;
  #define GIT_COLOR_AUTO (git_colorbool){GIT_COLOR_AUTO}
  /* ...etc... */

and then most calling code would be happy. But:

  - We don't use typedefs for enums in our project (so even with that
    typedef, we have to drop the "enum" from "enum git_colorbool"
    everywhere).

  - The anonymous struct syntax above works for assigning and returning
    values, but not for initializers. You have to use {GIT_COLOR_AUTO}
    without the fake-typecast there.

  - Likewise, C does not allow direct struct comparison at all! So for
    "foo == GIT_COLOR_AUTO", you must actually dereference foo.f to get
    to the field.

So this patch just makes all of the necessary changes throughout the
code base. This is not something we should apply, but it was useful for
flushing out all of the funny spots earlier in the series.

Signed-off-by: Jeff King <peff@peff.net>
---
 add-interactive.c     | 14 +++++++-------
 add-interactive.h     |  4 ++--
 advice.c              |  2 +-
 builtin/add.c         |  2 +-
 builtin/am.c          |  4 ++--
 builtin/branch.c      |  2 +-
 builtin/clean.c       |  2 +-
 builtin/commit.c      |  4 ++--
 builtin/config.c      | 20 ++++++++++----------
 builtin/grep.c        |  2 +-
 builtin/log.c         |  4 ++--
 builtin/push.c        |  2 +-
 builtin/range-diff.c  |  2 +-
 builtin/show-branch.c |  2 +-
 color.c               | 24 ++++++++++++------------
 color.h               |  7 ++++---
 combine-diff.c        |  2 +-
 diff.c                | 18 +++++++++---------
 diff.h                |  4 ++--
 grep.h                |  4 ++--
 log-tree.c            |  4 ++--
 log-tree.h            |  2 +-
 parse-options-cb.c    |  6 +++---
 pretty.c              |  8 ++++----
 pretty.h              |  2 +-
 ref-filter.h          |  4 ++--
 sequencer.c           |  2 +-
 sideband.c            |  8 ++++----
 transport.c           |  2 +-
 wt-status.c           |  6 +++---
 wt-status.h           |  2 +-
 31 files changed, 86 insertions(+), 85 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 6ffe64c38d..c16270dd60 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -20,7 +20,7 @@
 #include "prompt.h"
 #include "tree.h"
 
-static void init_color(struct repository *r, enum git_colorbool use_color,
+static void init_color(struct repository *r, git_colorbool use_color,
 		       const char *section_and_slot, char *dst,
 		       const char *default_color)
 {
@@ -36,13 +36,13 @@ static void init_color(struct repository *r, enum git_colorbool use_color,
 	free(key);
 }
 
-static enum git_colorbool check_color_config(struct repository *r, const char *var)
+static git_colorbool check_color_config(struct repository *r, const char *var)
 {
 	const char *value;
-	enum git_colorbool ret;
+	git_colorbool ret;
 
 	if (repo_config_get_value(r, var, &value))
-		ret = GIT_COLOR_UNKNOWN;
+		ret.f = GIT_COLOR_UNKNOWN;
 	else
 		ret = git_config_colorbool(var, value);
 
@@ -51,7 +51,7 @@ static enum git_colorbool check_color_config(struct repository *r, const char *v
 	 * the value parsed by git_color_config(), which may not have been
 	 * called by the main command.
 	 */
-	if (ret == GIT_COLOR_UNKNOWN &&
+	if (ret.f == GIT_COLOR_UNKNOWN &&
 	    !repo_config_get_value(r, "color.ui", &value))
 		ret = git_config_colorbool("color.ui", value);
 
@@ -131,8 +131,8 @@ void clear_add_i_state(struct add_i_state *s)
 	FREE_AND_NULL(s->interactive_diff_filter);
 	FREE_AND_NULL(s->interactive_diff_algorithm);
 	memset(s, 0, sizeof(*s));
-	s->use_color_interactive = GIT_COLOR_UNKNOWN;
-	s->use_color_diff = GIT_COLOR_UNKNOWN;
+	s->use_color_interactive = (git_colorbool){GIT_COLOR_UNKNOWN};
+	s->use_color_diff = (git_colorbool){GIT_COLOR_UNKNOWN};
 }
 
 /*
diff --git a/add-interactive.h b/add-interactive.h
index da49502b76..7016ea2d2f 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -12,8 +12,8 @@ struct add_p_opt {
 
 struct add_i_state {
 	struct repository *r;
-	enum git_colorbool use_color_interactive;
-	enum git_colorbool use_color_diff;
+	git_colorbool use_color_interactive;
+	git_colorbool use_color_diff;
 	char header_color[COLOR_MAXLEN];
 	char help_color[COLOR_MAXLEN];
 	char prompt_color[COLOR_MAXLEN];
diff --git a/advice.c b/advice.c
index 0018501b7b..21fa17d6a8 100644
--- a/advice.c
+++ b/advice.c
@@ -7,7 +7,7 @@
 #include "help.h"
 #include "string-list.h"
 
-static enum git_colorbool advice_use_color = GIT_COLOR_UNKNOWN;
+static git_colorbool advice_use_color = {GIT_COLOR_UNKNOWN};
 static char advice_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_YELLOW,	/* HINT */
diff --git a/builtin/add.c b/builtin/add.c
index 4cd3d183f9..c9ca3466a3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -200,7 +200,7 @@ static int edit_patch(struct repository *repo,
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
-	rev.diffopt.use_color = GIT_COLOR_NEVER;
+	rev.diffopt.use_color = (git_colorbool){GIT_COLOR_NEVER};
 	rev.diffopt.flags.ignore_dirty_submodules = 1;
 	out = xopen(file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
 	rev.diffopt.file = xfdopen(out, "w");
diff --git a/builtin/am.c b/builtin/am.c
index 277c2e7937..4c06b44607 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1408,7 +1408,7 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 	rev_info.no_commit_id = 1;
 	rev_info.diffopt.flags.binary = 1;
 	rev_info.diffopt.flags.full_index = 1;
-	rev_info.diffopt.use_color = GIT_COLOR_NEVER;
+	rev_info.diffopt.use_color = (git_colorbool){GIT_COLOR_NEVER};
 	rev_info.diffopt.file = fp;
 	rev_info.diffopt.close_file = 1;
 	add_pending_object(&rev_info, &commit->object, "");
@@ -1441,7 +1441,7 @@ static void write_index_patch(const struct am_state *state)
 	rev_info.disable_stdin = 1;
 	rev_info.no_commit_id = 1;
 	rev_info.diffopt.output_format = DIFF_FORMAT_PATCH;
-	rev_info.diffopt.use_color = GIT_COLOR_NEVER;
+	rev_info.diffopt.use_color = (git_colorbool){GIT_COLOR_NEVER};
 	rev_info.diffopt.file = fp;
 	rev_info.diffopt.close_file = 1;
 	add_pending_object(&rev_info, &tree->object, "");
diff --git a/builtin/branch.c b/builtin/branch.c
index 9fcf04bebb..f5dd0e00be 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -46,7 +46,7 @@ static struct object_id head_oid;
 static int recurse_submodules = 0;
 static int submodule_propagate_branches = 0;
 
-static enum git_colorbool branch_use_color = GIT_COLOR_UNKNOWN;
+static git_colorbool branch_use_color = {GIT_COLOR_UNKNOWN};
 static char branch_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_NORMAL,       /* PLAIN */
diff --git a/builtin/clean.c b/builtin/clean.c
index 1d5e7e5366..7f025aaea1 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -64,7 +64,7 @@ static const char *color_interactive_slots[] = {
 	[CLEAN_COLOR_RESET]  = "reset",
 };
 
-static enum git_colorbool clean_use_color = GIT_COLOR_UNKNOWN;
+static git_colorbool clean_use_color = {GIT_COLOR_UNKNOWN};
 static char clean_colors[][COLOR_MAXLEN] = {
 	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
 	[CLEAN_COLOR_HEADER] = GIT_COLOR_BOLD,
diff --git a/builtin/commit.c b/builtin/commit.c
index d8f21a4c62..3c1c12845a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -936,7 +936,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	strbuf_addstr(&committer_ident, git_committer_info(IDENT_STRICT));
 	if (use_editor && include_status) {
 		int ident_shown = 0;
-		enum git_colorbool saved_color_setting;
+		git_colorbool saved_color_setting;
 		struct ident_split ci, ai;
 		const char *hint_cleanup_all = allow_empty_message ?
 			_("Please enter the commit message for your changes."
@@ -1016,7 +1016,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		status_printf_ln(s, GIT_COLOR_NORMAL, "%s", ""); /* Add new line for clarity */
 
 		saved_color_setting = s->use_color;
-		s->use_color = GIT_COLOR_NEVER;
+		s->use_color = (git_colorbool){GIT_COLOR_NEVER};
 		committable = run_status(s->fp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
 		string_list_clear_func(&s->change, change_data_free);
diff --git a/builtin/config.c b/builtin/config.c
index 2348a99dd4..4105c4c812 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -568,9 +568,9 @@ static void get_color(const struct config_location_options *opts,
 }
 
 struct get_colorbool_config_data {
-	enum git_colorbool get_colorbool_found;
-	enum git_colorbool get_diff_color_found;
-	enum git_colorbool get_color_ui_found;
+	git_colorbool get_colorbool_found;
+	git_colorbool get_diff_color_found;
+	git_colorbool get_color_ui_found;
 	const char *get_colorbool_slot;
 };
 
@@ -594,26 +594,26 @@ static int get_colorbool(const struct config_location_options *opts,
 {
 	struct get_colorbool_config_data data = {
 		.get_colorbool_slot = var,
-		.get_colorbool_found = GIT_COLOR_UNKNOWN,
-		.get_diff_color_found = GIT_COLOR_UNKNOWN,
-		.get_color_ui_found = GIT_COLOR_UNKNOWN,
+		.get_colorbool_found = {GIT_COLOR_UNKNOWN},
+		.get_diff_color_found = {GIT_COLOR_UNKNOWN},
+		.get_color_ui_found = {GIT_COLOR_UNKNOWN},
 	};
 	bool result;
 
 	config_with_options(git_get_colorbool_config, &data,
 			    &opts->source, the_repository,
 			    &opts->options);
 
-	if (data.get_colorbool_found == GIT_COLOR_UNKNOWN) {
+	if (data.get_colorbool_found.f == GIT_COLOR_UNKNOWN) {
 		if (!strcmp(data.get_colorbool_slot, "color.diff"))
 			data.get_colorbool_found = data.get_diff_color_found;
-		if (data.get_colorbool_found == GIT_COLOR_UNKNOWN)
+		if (data.get_colorbool_found.f == GIT_COLOR_UNKNOWN)
 			data.get_colorbool_found = data.get_color_ui_found;
 	}
 
-	if (data.get_colorbool_found == GIT_COLOR_UNKNOWN)
+	if (data.get_colorbool_found.f == GIT_COLOR_UNKNOWN)
 		/* default value if none found in config */
-		data.get_colorbool_found = GIT_COLOR_AUTO;
+		data.get_colorbool_found = (git_colorbool){GIT_COLOR_AUTO};
 
 	result = want_color(data.get_colorbool_found);
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 1d97eb2a2a..3a6cdf9220 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1091,7 +1091,7 @@ int cmd_grep(int argc,
 	if (show_in_pager == default_pager)
 		show_in_pager = git_pager(the_repository, 1);
 	if (show_in_pager) {
-		opt.color = GIT_COLOR_NEVER;
+		opt.color = (git_colorbool){GIT_COLOR_NEVER};
 		opt.name_only = 1;
 		opt.null_following_name = 1;
 		opt.output_priv = &path_list;
diff --git a/builtin/log.c b/builtin/log.c
index c2f8bbf863..960482c2f1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2193,8 +2193,8 @@ int cmd_format_patch(int argc,
 			output_directory = cfg.config_output_directory;
 		output_directory = set_outdir(prefix, output_directory);
 
-		if (rev.diffopt.use_color != GIT_COLOR_ALWAYS)
-			rev.diffopt.use_color = GIT_COLOR_NEVER;
+		if (rev.diffopt.use_color.f != GIT_COLOR_ALWAYS)
+			rev.diffopt.use_color = (git_colorbool){GIT_COLOR_NEVER};
 		/*
 		 * We consider <outdir> as 'outside of gitdir', therefore avoid
 		 * applying adjust_shared_perm in s-c-l-d.
diff --git a/builtin/push.c b/builtin/push.c
index 5b6cebbb85..2c84eaac7b 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -27,7 +27,7 @@ static const char * const push_usage[] = {
 	NULL,
 };
 
-static enum git_colorbool push_use_color = GIT_COLOR_UNKNOWN;
+static git_colorbool push_use_color = {GIT_COLOR_UNKNOWN};
 static char push_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_RED,	/* ERROR */
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 0d51ddd623..94ceaffac2 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -67,7 +67,7 @@ int cmd_range_diff(int argc,
 
 	/* force color when --dual-color was used */
 	if (!simple_color)
-		diffopt.use_color = GIT_COLOR_ALWAYS;
+		diffopt.use_color = (git_colorbool){GIT_COLOR_ALWAYS};
 
 	/* If `--diff-merges` was specified, imply `--merges` */
 	if (diff_merges_arg.nr) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 441babf2e3..d5e9eb399a 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -29,7 +29,7 @@ static const char*const show_branch_usage[] = {
     NULL
 };
 
-static enum git_colorbool showbranch_use_color = GIT_COLOR_UNKNOWN;
+static git_colorbool showbranch_use_color = {GIT_COLOR_UNKNOWN};
 
 static struct strvec default_args = STRVEC_INIT;
 
diff --git a/color.c b/color.c
index 07ac8c9d40..14e994ab19 100644
--- a/color.c
+++ b/color.c
@@ -9,7 +9,7 @@
 #include "pager.h"
 #include "strbuf.h"
 
-static enum git_colorbool git_use_color_default = GIT_COLOR_AUTO;
+static git_colorbool git_use_color_default = {GIT_COLOR_AUTO};
 int color_stdout_is_tty = -1;
 
 /*
@@ -369,26 +369,26 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 #undef OUT
 }
 
-enum git_colorbool git_config_colorbool(const char *var, const char *value)
+git_colorbool git_config_colorbool(const char *var, const char *value)
 {
 	if (value) {
 		if (!strcasecmp(value, "never"))
-			return GIT_COLOR_NEVER;
+			return (git_colorbool){GIT_COLOR_NEVER};
 		if (!strcasecmp(value, "always"))
-			return GIT_COLOR_ALWAYS;
+			return (git_colorbool){GIT_COLOR_ALWAYS};
 		if (!strcasecmp(value, "auto"))
-			return GIT_COLOR_AUTO;
+			return (git_colorbool){GIT_COLOR_AUTO};
 	}
 
 	if (!var)
-		return GIT_COLOR_UNKNOWN;
+		return (git_colorbool){GIT_COLOR_UNKNOWN};
 
 	/* Missing or explicit false to turn off colorization */
 	if (!git_config_bool(var, value))
-		return GIT_COLOR_NEVER;
+		return (git_colorbool){GIT_COLOR_NEVER};
 
 	/* any normal truth value defaults to 'auto' */
-	return GIT_COLOR_AUTO;
+	return (git_colorbool){GIT_COLOR_AUTO};
 }
 
 static bool check_auto_color(int fd)
@@ -404,7 +404,7 @@ static bool check_auto_color(int fd)
 	return false;
 }
 
-bool want_color_fd(int fd, enum git_colorbool var)
+bool want_color_fd(int fd, git_colorbool var)
 {
 	/*
 	 * NEEDSWORK: This function is sometimes used from multiple threads, and
@@ -418,15 +418,15 @@ bool want_color_fd(int fd, enum git_colorbool var)
 	if (fd < 1 || fd >= ARRAY_SIZE(want_auto))
 		BUG("file descriptor out of range: %d", fd);
 
-	if (var == GIT_COLOR_UNKNOWN)
+	if (var.f == GIT_COLOR_UNKNOWN)
 		var = git_use_color_default;
 
-	if (var == GIT_COLOR_AUTO) {
+	if (var.f == GIT_COLOR_AUTO) {
 		if (want_auto[fd] < 0)
 			want_auto[fd] = check_auto_color(fd);
 		return want_auto[fd];
 	}
-	return var == GIT_COLOR_ALWAYS;
+	return var.f == GIT_COLOR_ALWAYS;
 }
 
 int git_color_config(const char *var, const char *value, void *cb UNUSED)
diff --git a/color.h b/color.h
index 43e6c9ad09..5e735ce827 100644
--- a/color.h
+++ b/color.h
@@ -73,12 +73,13 @@ struct strbuf;
  * returned from git_config_colorbool. The "auto" value can be returned from
  * config_colorbool, and will be converted by want_color() into either 0 or 1.
  */
-enum git_colorbool {
+enum git_colorbool_f {
 	GIT_COLOR_UNKNOWN = -1,
 	GIT_COLOR_NEVER = 0,
 	GIT_COLOR_ALWAYS = 1,
 	GIT_COLOR_AUTO = 2,
 };
+typedef struct { enum git_colorbool_f f; } git_colorbool;
 
 /* A default list of colors to use for commit graphs and show-branch output */
 extern const char *column_colors_ansi[];
@@ -100,13 +101,13 @@ int git_color_config(const char *var, const char *value, void *cb);
  * GIT_COLOR_ALWAYS for "always" or a positive boolean,
  * and GIT_COLOR_AUTO for "auto".
  */
-enum git_colorbool git_config_colorbool(const char *var, const char *value);
+git_colorbool git_config_colorbool(const char *var, const char *value);
 
 /*
  * Return a boolean whether to use color, where the argument 'var' is
  * one of GIT_COLOR_UNKNOWN, GIT_COLOR_NEVER, GIT_COLOR_ALWAYS, GIT_COLOR_AUTO.
  */
-bool want_color_fd(int fd, enum git_colorbool var);
+bool want_color_fd(int fd, git_colorbool var);
 #define want_color(colorbool) want_color_fd(1, (colorbool))
 #define want_color_stderr(colorbool) want_color_fd(2, (colorbool))
 
diff --git a/combine-diff.c b/combine-diff.c
index 21b7fdfff4..d70939ed71 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -749,7 +749,7 @@ static void show_line_to_eol(const char *line, int len, const char *reset)
 
 static void dump_sline(struct sline *sline, const char *line_prefix,
 		       unsigned long cnt, int num_parent,
-		       enum git_colorbool use_color, int result_deleted)
+		       git_colorbool use_color, int result_deleted)
 {
 	unsigned long mark = (1UL<<num_parent);
 	unsigned long no_pre_delete = (2UL<<num_parent);
diff --git a/diff.c b/diff.c
index 87fa16b730..59a9286aea 100644
--- a/diff.c
+++ b/diff.c
@@ -57,7 +57,7 @@ static int diff_detect_rename_default;
 static int diff_indent_heuristic = 1;
 static int diff_rename_limit_default = 1000;
 static int diff_suppress_blank_empty;
-static enum git_colorbool diff_use_color_default = GIT_COLOR_UNKNOWN;
+static git_colorbool diff_use_color_default = {GIT_COLOR_UNKNOWN};
 static int diff_color_moved_default;
 static int diff_color_moved_ws_default;
 static int diff_context_default = 3;
@@ -595,7 +595,7 @@ static struct diff_tempfile {
 } diff_temp[2];
 
 struct emit_callback {
-	int color_diff;
+	git_colorbool color_diff;
 	unsigned ws_rule;
 	int blank_at_eof_in_preimage;
 	int blank_at_eof_in_postimage;
@@ -2303,7 +2303,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 	}
 }
 
-const char *diff_get_color(enum git_colorbool diff_use_color, enum color_diff ix)
+const char *diff_get_color(git_colorbool diff_use_color, enum color_diff ix)
 {
 	if (want_color(diff_use_color))
 		return diff_colors[ix];
@@ -4497,7 +4497,7 @@ static void fill_metainfo(struct strbuf *msg,
 			  struct diff_options *o,
 			  struct diff_filepair *p,
 			  int *must_show_header,
-			  enum git_colorbool use_color)
+			  git_colorbool use_color)
 {
 	const char *set = diff_get_color(use_color, DIFF_METAINFO);
 	const char *reset = diff_get_color(use_color, DIFF_RESET);
@@ -4596,7 +4596,7 @@ static void run_diff_cmd(const struct external_diff *pgm,
 		 */
 		fill_metainfo(msg, name, other, one, two, o, p,
 			      &must_show_header,
-			      pgm ? GIT_COLOR_NEVER : o->use_color);
+			      pgm ? (git_colorbool){GIT_COLOR_NEVER} : o->use_color);
 		xfrm_msg = msg->len ? msg->buf : NULL;
 	}
 
@@ -5277,7 +5277,7 @@ static int diff_opt_color_words(const struct option *opt,
 	struct diff_options *options = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
-	options->use_color = GIT_COLOR_ALWAYS;
+	options->use_color = (git_colorbool){GIT_COLOR_ALWAYS};
 	options->word_diff = DIFF_WORDS_COLOR;
 	options->word_regex = arg;
 	return 0;
@@ -5458,8 +5458,8 @@ static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 	path = prefix_filename(ctx->prefix, arg);
 	options->file = xfopen(path, "w");
 	options->close_file = 1;
-	if (options->use_color != GIT_COLOR_ALWAYS)
-		options->use_color = GIT_COLOR_NEVER;
+	if (options->use_color.f != GIT_COLOR_ALWAYS)
+		options->use_color = (git_colorbool){GIT_COLOR_NEVER};
 	free(path);
 	return 0;
 }
@@ -5599,7 +5599,7 @@ static int diff_opt_word_diff(const struct option *opt,
 		if (!strcmp(arg, "plain"))
 			options->word_diff = DIFF_WORDS_PLAIN;
 		else if (!strcmp(arg, "color")) {
-			options->use_color = GIT_COLOR_ALWAYS;
+			options->use_color = (git_colorbool){GIT_COLOR_ALWAYS};
 			options->word_diff = DIFF_WORDS_COLOR;
 		}
 		else if (!strcmp(arg, "porcelain"))
diff --git a/diff.h b/diff.h
index bccd86a748..197dcb997f 100644
--- a/diff.h
+++ b/diff.h
@@ -284,7 +284,7 @@ struct diff_options {
 	/* diff-filter bits */
 	unsigned int filter, filter_not;
 
-	enum git_colorbool use_color;
+	git_colorbool use_color;
 
 	/* Number of context lines to generate in patch output. */
 	int context;
@@ -470,7 +470,7 @@ enum color_diff {
 	DIFF_FILE_NEW_BOLD = 22,
 };
 
-const char *diff_get_color(enum git_colorbool diff_use_color, enum color_diff ix);
+const char *diff_get_color(git_colorbool diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
 	diff_get_color((o)->use_color, ix)
 
diff --git a/grep.h b/grep.h
index 13e26a9318..0cc2806cae 100644
--- a/grep.h
+++ b/grep.h
@@ -159,7 +159,7 @@ struct grep_opt {
 	int pathname;
 	int null_following_name;
 	int only_matching;
-	enum git_colorbool color;
+	git_colorbool color;
 	int max_depth;
 	int funcname;
 	int funcbody;
@@ -198,7 +198,7 @@ struct grep_opt {
 		[GREP_COLOR_SEP] = GIT_COLOR_CYAN, \
 	}, \
 	.only_matching = 0, \
-	.color = GIT_COLOR_UNKNOWN, \
+	.color = {GIT_COLOR_UNKNOWN}, \
 	.output = std_output, \
 }
 
diff --git a/log-tree.c b/log-tree.c
index a2cd5c587b..df41c5c963 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -57,7 +57,7 @@ static const char *color_decorate_slots[] = {
 	[DECORATION_GRAFTED]	= "grafted",
 };
 
-static const char *decorate_get_color(enum git_colorbool decorate_use_color, enum decoration_type ix)
+static const char *decorate_get_color(git_colorbool decorate_use_color, enum decoration_type ix)
 {
 	if (want_color(decorate_use_color))
 		return decoration_colors[ix];
@@ -341,7 +341,7 @@ static void show_name(struct strbuf *sb, const struct name_decoration *decoratio
  */
 void format_decorations(struct strbuf *sb,
 			const struct commit *commit,
-			enum git_colorbool use_color,
+			git_colorbool use_color,
 			const struct decoration_options *opts)
 {
 	const struct name_decoration *decoration;
diff --git a/log-tree.h b/log-tree.h
index 1c82380d95..43ab208a7d 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -26,7 +26,7 @@ int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 void show_log(struct rev_info *opt);
 void format_decorations(struct strbuf *sb, const struct commit *commit,
-			enum git_colorbool use_color, const struct decoration_options *opts);
+			git_colorbool use_color, const struct decoration_options *opts);
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     char **extra_headers_p,
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 976cc86385..5f0e027139 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -50,15 +50,15 @@ int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
 int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
 			    int unset)
 {
-	enum git_colorbool value;
+	git_colorbool value;
 
 	if (!arg)
 		arg = unset ? "never" : (const char *)opt->defval;
 	value = git_config_colorbool(NULL, arg);
-	if (value == GIT_COLOR_UNKNOWN)
+	if (value.f == GIT_COLOR_UNKNOWN)
 		return error(_("option `%s' expects \"always\", \"auto\", or \"never\""),
 			     opt->long_name);
-	*(int *)opt->value = value;
+	*(git_colorbool *)opt->value = value;
 	return 0;
 }
 
diff --git a/pretty.c b/pretty.c
index e0646bbc5d..fcf7ee3d78 100644
--- a/pretty.c
+++ b/pretty.c
@@ -470,7 +470,7 @@ static inline void strbuf_add_with_color(struct strbuf *sb, const char *color,
 
 static void append_line_with_color(struct strbuf *sb, struct grep_opt *opt,
 				   const char *line, size_t linelen,
-				   enum git_colorbool color, enum grep_context ctx,
+				   git_colorbool color, enum grep_context ctx,
 				   enum grep_header_field field)
 {
 	const char *buf, *eol, *line_color, *match_color;
@@ -899,7 +899,7 @@ struct format_commit_context {
 	const char *message;
 	char *commit_encoding;
 	size_t width, indent1, indent2;
-	enum git_colorbool auto_color;
+	git_colorbool auto_color;
 	int padding;
 
 	/* These offsets are relative to the start of the commit message. */
@@ -1462,7 +1462,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		} else {
 			int ret = parse_color(sb, placeholder, c);
 			if (ret)
-				c->auto_color = GIT_COLOR_NEVER;
+				c->auto_color = (git_colorbool){GIT_COLOR_NEVER};
 			/*
 			 * Otherwise, we decided to treat %C<unknown>
 			 * as a literal string, and the previous
@@ -2167,7 +2167,7 @@ static int pp_utf8_width(const char *start, const char *end)
 }
 
 static void strbuf_add_tabexpand(struct strbuf *sb, struct grep_opt *opt,
-				 enum git_colorbool color, int tabwidth, const char *line,
+				 git_colorbool color, int tabwidth, const char *line,
 				 int linelen)
 {
 	const char *tab;
diff --git a/pretty.h b/pretty.h
index fac699033e..915c866c53 100644
--- a/pretty.h
+++ b/pretty.h
@@ -47,7 +47,7 @@ struct pretty_print_context {
 	struct rev_info *rev;
 	const char *output_encoding;
 	struct string_list *mailmap;
-	enum git_colorbool color;
+	git_colorbool color;
 	struct ident_split *from_ident;
 	unsigned encode_email_headers:1;
 	struct pretty_print_describe_status *describe_status;
diff --git a/ref-filter.h b/ref-filter.h
index 81f2c229a9..66f96a330a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -95,7 +95,7 @@ struct ref_format {
 	const char *format;
 	const char *rest;
 	int quote_style;
-	enum git_colorbool use_color;
+	git_colorbool use_color;
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
@@ -111,7 +111,7 @@ struct ref_format {
 	.exclude = STRVEC_INIT, \
 }
 #define REF_FORMAT_INIT {             \
-	.use_color = GIT_COLOR_UNKNOWN, \
+	.use_color = {GIT_COLOR_UNKNOWN}, \
 }
 
 /*  Macros for checking --merged and --no-merged options */
diff --git a/sequencer.c b/sequencer.c
index 9ae40a91b2..56999de1ec 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3732,7 +3732,7 @@ static int make_patch(struct repository *r,
 	log_tree_opt.disable_stdin = 1;
 	log_tree_opt.no_commit_id = 1;
 	log_tree_opt.diffopt.file = fopen(rebase_path_patch(), "w");
-	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
+	log_tree_opt.diffopt.use_color = (git_colorbool){GIT_COLOR_NEVER};
 	if (!log_tree_opt.diffopt.file)
 		res |= error_errno(_("could not open '%s'"),
 				   rebase_path_patch());
diff --git a/sideband.c b/sideband.c
index ea7c25211e..fb7b6a7e46 100644
--- a/sideband.c
+++ b/sideband.c
@@ -27,24 +27,24 @@ static struct keyword_entry keywords[] = {
 };
 
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
-static enum git_colorbool use_sideband_colors(void)
+static git_colorbool use_sideband_colors(void)
 {
-	static enum git_colorbool use_sideband_colors_cached = GIT_COLOR_UNKNOWN;
+	static git_colorbool use_sideband_colors_cached = {GIT_COLOR_UNKNOWN};
 
 	const char *key = "color.remote";
 	struct strbuf sb = STRBUF_INIT;
 	const char *value;
 	int i;
 
-	if (use_sideband_colors_cached != GIT_COLOR_UNKNOWN)
+	if (use_sideband_colors_cached.f != GIT_COLOR_UNKNOWN)
 		return use_sideband_colors_cached;
 
 	if (!repo_config_get_string_tmp(the_repository, key, &value))
 		use_sideband_colors_cached = git_config_colorbool(key, value);
 	else if (!repo_config_get_string_tmp(the_repository, "color.ui", &value))
 		use_sideband_colors_cached = git_config_colorbool("color.ui", value);
 	else
-		use_sideband_colors_cached = GIT_COLOR_AUTO;
+		use_sideband_colors_cached = (git_colorbool){GIT_COLOR_AUTO};
 
 	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
 		strbuf_reset(&sb);
diff --git a/transport.c b/transport.c
index c7f06a7382..a5f98ba6b6 100644
--- a/transport.c
+++ b/transport.c
@@ -30,7 +30,7 @@
 #include "color.h"
 #include "bundle-uri.h"
 
-static enum git_colorbool transport_use_color = GIT_COLOR_UNKNOWN;
+static git_colorbool transport_use_color = {GIT_COLOR_UNKNOWN};
 static char transport_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_RED		/* REJECTED */
diff --git a/wt-status.c b/wt-status.c
index 8ffe6d3988..0927b88734 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -148,7 +148,7 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
 	memcpy(s->color_palette, default_wt_status_colors,
 	       sizeof(default_wt_status_colors));
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
-	s->use_color = GIT_COLOR_UNKNOWN;
+	s->use_color = (git_colorbool){GIT_COLOR_UNKNOWN};
 	s->relative_paths = 1;
 	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
 					"HEAD", 0, NULL, NULL);
@@ -1165,7 +1165,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	 * before.
 	 */
 	if (s->fp != stdout) {
-		rev.diffopt.use_color = GIT_COLOR_NEVER;
+		rev.diffopt.use_color = (git_colorbool){GIT_COLOR_NEVER};
 		wt_status_add_cut_line(s);
 	}
 	if (s->verbose > 1 && s->committable) {
@@ -2155,7 +2155,7 @@ static void wt_shortstatus_print(struct wt_status *s)
 
 static void wt_porcelain_print(struct wt_status *s)
 {
-	s->use_color = GIT_COLOR_NEVER;
+	s->use_color = (git_colorbool){GIT_COLOR_NEVER};
 	s->relative_paths = 0;
 	s->prefix = NULL;
 	s->no_gettext = 1;
diff --git a/wt-status.h b/wt-status.h
index e40a27214a..5364eaa1f8 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -111,7 +111,7 @@ struct wt_status {
 	int amend;
 	enum commit_whence whence;
 	int nowarn;
-	enum git_colorbool use_color;
+	git_colorbool use_color;
 	int no_gettext;
 	int display_comment_prefix;
 	int relative_paths;
-- 
2.51.0.527.g34bc42dacd
