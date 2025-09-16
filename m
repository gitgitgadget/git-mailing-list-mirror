Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D262E54B9
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054253; cv=none; b=DxEcHMbCRNX/CnMWboVpSCbAyXtk/ioDXeXlLueKXH8OKqBhOV6MfVI/vvQN0/0x/0YeDL/xPICZUxdWLOqXYs0GM61ZCvUeLgF8cXEbl974r3xtqJ+x5V/dJCofRoXDXnOYxsh2obajRvY4T1mdf7NEDtFRheOkDaYznJ5keZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054253; c=relaxed/simple;
	bh=IMSgihsAQ/7IKnuwJzO5SdC5zGOh+LUXPBY5yFfJSSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpuDwJuEAD9nXVpkpY1K92nfK+X+fed096JgHL059UdFRCM6u+4NgKiC80XHYHAbEF6TNLIMft8oNuU5pxY0s5014G8u4kVzQmsmEzjdhuW/J/f5+yI6MQ8VWg7WHnolAfvFHa0WxRUvoE3UODB83WJSbSwAdEwT5RpA1czM4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LM7gpFx0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LM7gpFx0"
Received: (qmail 102456 invoked by uid 109); 16 Sep 2025 20:24:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IMSgihsAQ/7IKnuwJzO5SdC5zGOh+LUXPBY5yFfJSSg=; b=LM7gpFx0Y9y+uMb0Vl1LS1HCmeGfdgFC/8WswvMj6NSe0gmSqjOpewHi4OCXLi8p/xNAKEZqZ0Pj0FBtu6RTEMkFuiQfJnwemHhlwocDEIXcz7OpE7LfP+LvGQcbJvCAWA+BU/tT35CnrR8FhO+NnmUQlisaJU/0H9ICcHHDFrcNRBf8MtThZmzmYt8rTJyJf1cIH6/na9MrdxMzKplxZ8JjAglOER9THUw1lu+EEk4Kju47dZhoZrC4gJsPm7h3+ywRdMQvg6Tht8yvUTK9fncdLUv3xzDbctfV5bzc2P+sMfWnXWEQ8Y6QHvgMk0W1mKOr2CKKYrSwaIQPoTwnOA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:24:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166255 invoked by uid 111); 16 Sep 2025 20:24:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:24:09 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:24:08 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 09/13] color: use git_colorbool enum to type to store
 colorbools
Message-ID: <20250916202408.GI612873@coredump.intra.peff.net>
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

We traditionally used "int" to store and pass around the values defined
by "enum git_colorbool" (which were originally just #define macros).
Using an int doesn't produce incorrect results, but using the actual
enum makes the intent of the code more clear.

It would be nice if the compiler could catch cases where we used the
enum and an int interchangeably, since it's very easy to accidentally
check the boolean true/false of a colorbool like:

  if (branch_use_color)

This is wrong because GIT_COLOR_UNKNOWN and GIT_COLOR_AUTO evaluate to
true in C, even though we may ultimately decide not to use color. But C
is pretty happy to convert between ints and enums (even with various
-Wenum-* warnings). So this sadly doesn't protect us from such mistakes,
but it hopefully does make the code easier to read.

Signed-off-by: Jeff King <peff@peff.net>
---
This actually could come sooner in the series, since the compiler will
not complain about conversions either way. But I thought it made sense to
clean up the weird spots first.

 add-interactive.c     | 2 +-
 advice.c              | 2 +-
 builtin/branch.c      | 2 +-
 builtin/clean.c       | 2 +-
 builtin/commit.c      | 2 +-
 builtin/config.c      | 6 +++---
 builtin/push.c        | 2 +-
 builtin/show-branch.c | 2 +-
 color.c               | 4 ++--
 color.h               | 2 +-
 combine-diff.c        | 2 +-
 diff.c                | 6 +++---
 diff.h                | 5 +++--
 grep.h                | 2 +-
 log-tree.c            | 4 ++--
 log-tree.h            | 2 +-
 parse-options-cb.c    | 2 +-
 pretty.c              | 6 +++---
 pretty.h              | 3 ++-
 ref-filter.h          | 2 +-
 sideband.c            | 4 ++--
 transport.c           | 2 +-
 wt-status.h           | 2 +-
 23 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 34c020673e..000315971e 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -39,7 +39,7 @@ static void init_color(struct repository *r, int use_color,
 static int check_color_config(struct repository *r, const char *var)
 {
 	const char *value;
-	int ret;
+	enum git_colorbool ret;
 
 	if (repo_config_get_value(r, var, &value))
 		ret = GIT_COLOR_UNKNOWN;
diff --git a/advice.c b/advice.c
index a00aaad9de..0018501b7b 100644
--- a/advice.c
+++ b/advice.c
@@ -7,7 +7,7 @@
 #include "help.h"
 #include "string-list.h"
 
-static int advice_use_color = GIT_COLOR_UNKNOWN;
+static enum git_colorbool advice_use_color = GIT_COLOR_UNKNOWN;
 static char advice_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_YELLOW,	/* HINT */
diff --git a/builtin/branch.c b/builtin/branch.c
index 029223df7b..9fcf04bebb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -46,7 +46,7 @@ static struct object_id head_oid;
 static int recurse_submodules = 0;
 static int submodule_propagate_branches = 0;
 
-static int branch_use_color = GIT_COLOR_UNKNOWN;
+static enum git_colorbool branch_use_color = GIT_COLOR_UNKNOWN;
 static char branch_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_NORMAL,       /* PLAIN */
diff --git a/builtin/clean.c b/builtin/clean.c
index 0ac90a3feb..1d5e7e5366 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -64,7 +64,7 @@ static const char *color_interactive_slots[] = {
 	[CLEAN_COLOR_RESET]  = "reset",
 };
 
-static int clean_use_color = GIT_COLOR_UNKNOWN;
+static enum git_colorbool clean_use_color = GIT_COLOR_UNKNOWN;
 static char clean_colors[][COLOR_MAXLEN] = {
 	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
 	[CLEAN_COLOR_HEADER] = GIT_COLOR_BOLD,
diff --git a/builtin/commit.c b/builtin/commit.c
index 544603a9c7..d8f21a4c62 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -936,7 +936,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	strbuf_addstr(&committer_ident, git_committer_info(IDENT_STRICT));
 	if (use_editor && include_status) {
 		int ident_shown = 0;
-		int saved_color_setting;
+		enum git_colorbool saved_color_setting;
 		struct ident_split ci, ai;
 		const char *hint_cleanup_all = allow_empty_message ?
 			_("Please enter the commit message for your changes."
diff --git a/builtin/config.c b/builtin/config.c
index c3da3ae210..9e4e4eb2f1 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -568,9 +568,9 @@ static void get_color(const struct config_location_options *opts,
 }
 
 struct get_colorbool_config_data {
-	int get_colorbool_found;
-	int get_diff_color_found;
-	int get_color_ui_found;
+	enum git_colorbool get_colorbool_found;
+	enum git_colorbool get_diff_color_found;
+	enum git_colorbool get_color_ui_found;
 	const char *get_colorbool_slot;
 };
 
diff --git a/builtin/push.c b/builtin/push.c
index 0962b122c7..5b6cebbb85 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -27,7 +27,7 @@ static const char * const push_usage[] = {
 	NULL,
 };
 
-static int push_use_color = GIT_COLOR_UNKNOWN;
+static enum git_colorbool push_use_color = GIT_COLOR_UNKNOWN;
 static char push_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_RED,	/* ERROR */
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 970e78bc2d..441babf2e3 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -29,7 +29,7 @@ static const char*const show_branch_usage[] = {
     NULL
 };
 
-static int showbranch_use_color = GIT_COLOR_UNKNOWN;
+static enum git_colorbool showbranch_use_color = GIT_COLOR_UNKNOWN;
 
 static struct strvec default_args = STRVEC_INIT;
 
diff --git a/color.c b/color.c
index f3adce0141..3348ead534 100644
--- a/color.c
+++ b/color.c
@@ -9,7 +9,7 @@
 #include "pager.h"
 #include "strbuf.h"
 
-static int git_use_color_default = GIT_COLOR_AUTO;
+static enum git_colorbool git_use_color_default = GIT_COLOR_AUTO;
 int color_stdout_is_tty = -1;
 
 /*
@@ -404,7 +404,7 @@ static int check_auto_color(int fd)
 	return 0;
 }
 
-int want_color_fd(int fd, int var)
+int want_color_fd(int fd, enum git_colorbool var)
 {
 	/*
 	 * NEEDSWORK: This function is sometimes used from multiple threads, and
diff --git a/color.h b/color.h
index 303e2c9a6d..fcb38c5562 100644
--- a/color.h
+++ b/color.h
@@ -106,7 +106,7 @@ enum git_colorbool git_config_colorbool(const char *var, const char *value);
  * Return a boolean whether to use color, where the argument 'var' is
  * one of GIT_COLOR_UNKNOWN, GIT_COLOR_NEVER, GIT_COLOR_ALWAYS, GIT_COLOR_AUTO.
  */
-int want_color_fd(int fd, int var);
+int want_color_fd(int fd, enum git_colorbool var);
 #define want_color(colorbool) want_color_fd(1, (colorbool))
 #define want_color_stderr(colorbool) want_color_fd(2, (colorbool))
 
diff --git a/combine-diff.c b/combine-diff.c
index 3878faabe7..21b7fdfff4 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -749,7 +749,7 @@ static void show_line_to_eol(const char *line, int len, const char *reset)
 
 static void dump_sline(struct sline *sline, const char *line_prefix,
 		       unsigned long cnt, int num_parent,
-		       int use_color, int result_deleted)
+		       enum git_colorbool use_color, int result_deleted)
 {
 	unsigned long mark = (1UL<<num_parent);
 	unsigned long no_pre_delete = (2UL<<num_parent);
diff --git a/diff.c b/diff.c
index 926429d55b..87fa16b730 100644
--- a/diff.c
+++ b/diff.c
@@ -57,7 +57,7 @@ static int diff_detect_rename_default;
 static int diff_indent_heuristic = 1;
 static int diff_rename_limit_default = 1000;
 static int diff_suppress_blank_empty;
-static int diff_use_color_default = GIT_COLOR_UNKNOWN;
+static enum git_colorbool diff_use_color_default = GIT_COLOR_UNKNOWN;
 static int diff_color_moved_default;
 static int diff_color_moved_ws_default;
 static int diff_context_default = 3;
@@ -2303,7 +2303,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 	}
 }
 
-const char *diff_get_color(int diff_use_color, enum color_diff ix)
+const char *diff_get_color(enum git_colorbool diff_use_color, enum color_diff ix)
 {
 	if (want_color(diff_use_color))
 		return diff_colors[ix];
@@ -4497,7 +4497,7 @@ static void fill_metainfo(struct strbuf *msg,
 			  struct diff_options *o,
 			  struct diff_filepair *p,
 			  int *must_show_header,
-			  int use_color)
+			  enum git_colorbool use_color)
 {
 	const char *set = diff_get_color(use_color, DIFF_METAINFO);
 	const char *reset = diff_get_color(use_color, DIFF_RESET);
diff --git a/diff.h b/diff.h
index 9bb939a4f1..bccd86a748 100644
--- a/diff.h
+++ b/diff.h
@@ -7,6 +7,7 @@
 #include "hash.h"
 #include "pathspec.h"
 #include "strbuf.h"
+#include "color.h"
 
 struct oidset;
 
@@ -283,7 +284,7 @@ struct diff_options {
 	/* diff-filter bits */
 	unsigned int filter, filter_not;
 
-	int use_color;
+	enum git_colorbool use_color;
 
 	/* Number of context lines to generate in patch output. */
 	int context;
@@ -469,7 +470,7 @@ enum color_diff {
 	DIFF_FILE_NEW_BOLD = 22,
 };
 
-const char *diff_get_color(int diff_use_color, enum color_diff ix);
+const char *diff_get_color(enum git_colorbool diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
 	diff_get_color((o)->use_color, ix)
 
diff --git a/grep.h b/grep.h
index 43195baab3..13e26a9318 100644
--- a/grep.h
+++ b/grep.h
@@ -159,7 +159,7 @@ struct grep_opt {
 	int pathname;
 	int null_following_name;
 	int only_matching;
-	int color;
+	enum git_colorbool color;
 	int max_depth;
 	int funcname;
 	int funcbody;
diff --git a/log-tree.c b/log-tree.c
index 233bf9f227..a2cd5c587b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -57,7 +57,7 @@ static const char *color_decorate_slots[] = {
 	[DECORATION_GRAFTED]	= "grafted",
 };
 
-static const char *decorate_get_color(int decorate_use_color, enum decoration_type ix)
+static const char *decorate_get_color(enum git_colorbool decorate_use_color, enum decoration_type ix)
 {
 	if (want_color(decorate_use_color))
 		return decoration_colors[ix];
@@ -341,7 +341,7 @@ static void show_name(struct strbuf *sb, const struct name_decoration *decoratio
  */
 void format_decorations(struct strbuf *sb,
 			const struct commit *commit,
-			int use_color,
+			enum git_colorbool use_color,
 			const struct decoration_options *opts)
 {
 	const struct name_decoration *decoration;
diff --git a/log-tree.h b/log-tree.h
index ebe491c543..1c82380d95 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -26,7 +26,7 @@ int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 void show_log(struct rev_info *opt);
 void format_decorations(struct strbuf *sb, const struct commit *commit,
-			int use_color, const struct decoration_options *opts);
+			enum git_colorbool use_color, const struct decoration_options *opts);
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     char **extra_headers_p,
diff --git a/parse-options-cb.c b/parse-options-cb.c
index e13e0a9e33..976cc86385 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -50,7 +50,7 @@ int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
 int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
 			    int unset)
 {
-	int value;
+	enum git_colorbool value;
 
 	if (!arg)
 		arg = unset ? "never" : (const char *)opt->defval;
diff --git a/pretty.c b/pretty.c
index 86d69bf877..e0646bbc5d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -470,7 +470,7 @@ static inline void strbuf_add_with_color(struct strbuf *sb, const char *color,
 
 static void append_line_with_color(struct strbuf *sb, struct grep_opt *opt,
 				   const char *line, size_t linelen,
-				   int color, enum grep_context ctx,
+				   enum git_colorbool color, enum grep_context ctx,
 				   enum grep_header_field field)
 {
 	const char *buf, *eol, *line_color, *match_color;
@@ -899,7 +899,7 @@ struct format_commit_context {
 	const char *message;
 	char *commit_encoding;
 	size_t width, indent1, indent2;
-	int auto_color;
+	enum git_colorbool auto_color;
 	int padding;
 
 	/* These offsets are relative to the start of the commit message. */
@@ -2167,7 +2167,7 @@ static int pp_utf8_width(const char *start, const char *end)
 }
 
 static void strbuf_add_tabexpand(struct strbuf *sb, struct grep_opt *opt,
-				 int color, int tabwidth, const char *line,
+				 enum git_colorbool color, int tabwidth, const char *line,
 				 int linelen)
 {
 	const char *tab;
diff --git a/pretty.h b/pretty.h
index df267afe4a..fac699033e 100644
--- a/pretty.h
+++ b/pretty.h
@@ -3,6 +3,7 @@
 
 #include "date.h"
 #include "string-list.h"
+#include "color.h"
 
 struct commit;
 struct repository;
@@ -46,7 +47,7 @@ struct pretty_print_context {
 	struct rev_info *rev;
 	const char *output_encoding;
 	struct string_list *mailmap;
-	int color;
+	enum git_colorbool color;
 	struct ident_split *from_ident;
 	unsigned encode_email_headers:1;
 	struct pretty_print_describe_status *describe_status;
diff --git a/ref-filter.h b/ref-filter.h
index 644f5c567c..81f2c229a9 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -95,7 +95,7 @@ struct ref_format {
 	const char *format;
 	const char *rest;
 	int quote_style;
-	int use_color;
+	enum git_colorbool use_color;
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
diff --git a/sideband.c b/sideband.c
index 3ac87148b9..ea7c25211e 100644
--- a/sideband.c
+++ b/sideband.c
@@ -27,9 +27,9 @@ static struct keyword_entry keywords[] = {
 };
 
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
-static int use_sideband_colors(void)
+static enum git_colorbool use_sideband_colors(void)
 {
-	static int use_sideband_colors_cached = GIT_COLOR_UNKNOWN;
+	static enum git_colorbool use_sideband_colors_cached = GIT_COLOR_UNKNOWN;
 
 	const char *key = "color.remote";
 	struct strbuf sb = STRBUF_INIT;
diff --git a/transport.c b/transport.c
index ea0be4503c..c7f06a7382 100644
--- a/transport.c
+++ b/transport.c
@@ -30,7 +30,7 @@
 #include "color.h"
 #include "bundle-uri.h"
 
-static int transport_use_color = GIT_COLOR_UNKNOWN;
+static enum git_colorbool transport_use_color = GIT_COLOR_UNKNOWN;
 static char transport_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_RED		/* REJECTED */
diff --git a/wt-status.h b/wt-status.h
index 4e377ce62b..e40a27214a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -111,7 +111,7 @@ struct wt_status {
 	int amend;
 	enum commit_whence whence;
 	int nowarn;
-	int use_color;
+	enum git_colorbool use_color;
 	int no_gettext;
 	int display_comment_prefix;
 	int relative_paths;
-- 
2.51.0.527.g34bc42dacd

