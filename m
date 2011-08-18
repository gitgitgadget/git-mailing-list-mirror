From: Jeff King <peff@peff.net>
Subject: [PATCH 07/10] color: delay auto-color decision until point of use
Date: Wed, 17 Aug 2011 22:04:23 -0700
Message-ID: <20110818050421.GG2889@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 07:04:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtumQ-0007nY-3k
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 07:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043Ab1HRFE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 01:04:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45197
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268Ab1HRFE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 01:04:29 -0400
Received: (qmail 18390 invoked by uid 107); 18 Aug 2011 05:05:08 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 01:05:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 22:04:23 -0700
Content-Disposition: inline
In-Reply-To: <20110818045821.GA17377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179564>

When we read a color value either from a config file or from
the command line, we use git_config_colorbool to convert it
from the tristate always/never/auto into a single yes/no
boolean value.

This has some timing implications with respect to starting
a pager.

If we start (or decide not to start) the pager before
checking the colorbool, everything is fine. Either isatty(1)
will give us the right information, or we will properly
check for pager_in_use().

However, if we decide to start a pager after we have checked
the colorbool, things are not so simple. If stdout is a tty,
then we will have already decided to use color. However, the
user may also have configured color.pager not to use color
with the pager. In this case, we need to actually turn off
color. Unfortunately, the pager code has no idea which color
variables were turned on (and there are many of them
throughout the code, and they may even have been manipulated
after the colorbool selection by something like "--color" on
the command line).

This bug can be seen any time a pager is started after
config and command line options are checked. This has
affected "git diff" since 89d07f7 (diff: don't run pager if
user asked for a diff style exit code, 2007-08-12). It has
also affect the log family since 1fda91b (Fix 'git log'
early pager startup error case, 2010-08-24).

This patch splits the notion of parsing a colorbool and
actually checking the configuration. The "use_color"
variables now have an additional possible value,
GIT_COLOR_AUTO. Users of the variable should use the new
"want_color()" wrapper, which will lazily determine and
cache the auto-color decision.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c      |    2 +-
 builtin/config.c      |    2 ++
 builtin/show-branch.c |    4 ++--
 color.c               |   20 ++++++++++++++++++--
 color.h               |   11 +++++++++++
 diff.c                |   17 +++++++----------
 graph.c               |    2 +-
 grep.c                |    2 +-
 log-tree.c            |    2 +-
 t/t7006-pager.sh      |   12 ++++++++++++
 wt-status.c           |    4 +++-
 11 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b15fee5..d6d3c7d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -88,7 +88,7 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 
 static const char *branch_get_color(enum color_branch ix)
 {
-	if (branch_use_color > 0)
+	if (want_color(branch_use_color))
 		return branch_colors[ix];
 	return "";
 }
diff --git a/builtin/config.c b/builtin/config.c
index 5505ced..3a09296 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -330,6 +330,8 @@ static int get_colorbool(int print)
 			get_colorbool_found = git_use_color_default;
 	}
 
+	get_colorbool_found = want_color(get_colorbool_found);
+
 	if (print) {
 		printf("%s\n", get_colorbool_found ? "true" : "false");
 		return 0;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e6650b4..4b726fa 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -26,14 +26,14 @@ static const char **default_arg;
 
 static const char *get_color_code(int idx)
 {
-	if (showbranch_use_color)
+	if (want_color(showbranch_use_color))
 		return column_colors_ansi[idx % column_colors_ansi_max];
 	return "";
 }
 
 static const char *get_color_reset_code(void)
 {
-	if (showbranch_use_color)
+	if (want_color(showbranch_use_color))
 		return GIT_COLOR_RESET;
 	return "";
 }
diff --git a/color.c b/color.c
index 67affa4..8586417 100644
--- a/color.c
+++ b/color.c
@@ -166,7 +166,7 @@ int git_config_colorbool(const char *var, const char *value)
 		if (!strcasecmp(value, "always"))
 			return 1;
 		if (!strcasecmp(value, "auto"))
-			goto auto_color;
+			return GIT_COLOR_AUTO;
 	}
 
 	if (!var)
@@ -177,7 +177,11 @@ int git_config_colorbool(const char *var, const char *value)
 		return 0;
 
 	/* any normal truth value defaults to 'auto' */
- auto_color:
+	return GIT_COLOR_AUTO;
+}
+
+static int check_auto_color(void)
+{
 	if (color_stdout_is_tty < 0)
 		color_stdout_is_tty = isatty(1);
 	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {
@@ -188,6 +192,18 @@ int git_config_colorbool(const char *var, const char *value)
 	return 0;
 }
 
+int want_color(int var)
+{
+	static int want_auto = -1;
+
+	if (var == GIT_COLOR_AUTO) {
+		if (want_auto < 0)
+			want_auto = check_auto_color();
+		return want_auto;
+	}
+	return var > 0;
+}
+
 int git_color_default_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "color.ui")) {
diff --git a/color.h b/color.h
index a190a25..d715fd5 100644
--- a/color.h
+++ b/color.h
@@ -49,6 +49,16 @@ struct strbuf;
 #define GIT_COLOR_NIL "NIL"
 
 /*
+ * The first three are chosen to match common usage in the code, and what is
+ * returned from git_config_colorbool. The "auto" value can be returned from
+ * config_colorbool, and will be converted by want_color() into either 0 or 1.
+ */
+#define GIT_COLOR_UNKNOWN -1
+#define GIT_COLOR_ALWAYS 0
+#define GIT_COLOR_NEVER  1
+#define GIT_COLOR_AUTO   2
+
+/*
  * This variable stores the value of color.ui
  */
 extern int git_use_color_default;
@@ -69,6 +79,7 @@ extern int color_stdout_is_tty;
 int git_color_default_config(const char *var, const char *value, void *cb);
 
 int git_config_colorbool(const char *var, const char *value);
+int want_color(int var);
 void color_parse(const char *value, const char *var, char *dst);
 void color_parse_mem(const char *value, int len, const char *var, char *dst);
 __attribute__((format (printf, 3, 4)))
diff --git a/diff.c b/diff.c
index 2dfc359..29cecf1 100644
--- a/diff.c
+++ b/diff.c
@@ -622,7 +622,7 @@ static void emit_rewrite_diff(const char *name_a,
 	size_two = fill_textconv(textconv_two, two, &data_two);
 
 	memset(&ecbdata, 0, sizeof(ecbdata));
-	ecbdata.color_diff = o->use_color > 0;
+	ecbdata.color_diff = want_color(o->use_color);
 	ecbdata.found_changesp = &o->found_changes;
 	ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
 	ecbdata.opt = o;
@@ -1003,7 +1003,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 
 const char *diff_get_color(int diff_use_color, enum color_diff ix)
 {
-	if (diff_use_color > 0)
+	if (want_color(diff_use_color))
 		return diff_colors[ix];
 	return "";
 }
@@ -2155,7 +2155,7 @@ static void builtin_diff(const char *name_a,
 		memset(&xecfg, 0, sizeof(xecfg));
 		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path = lbl;
-		ecbdata.color_diff = o->use_color > 0;
+		ecbdata.color_diff = want_color(o->use_color);
 		ecbdata.found_changesp = &o->found_changes;
 		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
@@ -2203,7 +2203,7 @@ static void builtin_diff(const char *name_a,
 					break;
 				}
 			}
-			if (o->use_color > 0) {
+			if (want_color(o->use_color)) {
 				struct diff_words_style *st = ecbdata.diff_words->style;
 				st->old.color = diff_get_color_opt(o, DIFF_FILE_OLD);
 				st->new.color = diff_get_color_opt(o, DIFF_FILE_NEW);
@@ -2853,7 +2853,7 @@ static void run_diff_cmd(const char *pgm,
 		 */
 		fill_metainfo(msg, name, other, one, two, o, p,
 			      &must_show_header,
-			      o->use_color > 0 && !pgm);
+			      want_color(o->use_color) && !pgm);
 		xfrm_msg = msg->len ? msg->buf : NULL;
 	}
 
@@ -3410,12 +3410,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->use_color = 1;
 	else if (!prefixcmp(arg, "--color=")) {
 		int value = git_config_colorbool(NULL, arg+8);
-		if (value == 0)
-			options->use_color = 0;
-		else if (value > 0)
-			options->use_color = 1;
-		else
+		if (value < 0)
 			return error("option `color' expects \"always\", \"auto\", or \"never\"");
+		options->use_color = value;
 	}
 	else if (!strcmp(arg, "--no-color"))
 		options->use_color = 0;
diff --git a/graph.c b/graph.c
index 556834a..7358416 100644
--- a/graph.c
+++ b/graph.c
@@ -347,7 +347,7 @@ static struct commit_list *first_interesting_parent(struct git_graph *graph)
 
 static unsigned short graph_get_current_column_color(const struct git_graph *graph)
 {
-	if (graph->revs->diffopt.use_color <= 0)
+	if (!want_color(graph->revs->diffopt.use_color))
 		return column_colors_max;
 	return graph->default_column_color;
 }
diff --git a/grep.c b/grep.c
index 04e9ba4..abf4288 100644
--- a/grep.c
+++ b/grep.c
@@ -430,7 +430,7 @@ static int word_char(char ch)
 static void output_color(struct grep_opt *opt, const void *data, size_t size,
 			 const char *color)
 {
-	if (opt->color && color && color[0]) {
+	if (want_color(opt->color) && color && color[0]) {
 		opt->output(opt, color, strlen(color));
 		opt->output(opt, data, size);
 		opt->output(opt, GIT_COLOR_RESET, strlen(GIT_COLOR_RESET));
diff --git a/log-tree.c b/log-tree.c
index 9ba8fb2..95d6d40 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -31,7 +31,7 @@ static char decoration_colors[][COLOR_MAXLEN] = {
 
 static const char *decorate_get_color(int decorate_use_color, enum decoration_type ix)
 {
-	if (decorate_use_color > 0)
+	if (want_color(decorate_use_color))
 		return decoration_colors[ix];
 	return "";
 }
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 4884e1b..4582336 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -167,6 +167,18 @@ test_expect_success TTY 'color when writing to a pager' '
 	colorful paginated.out
 '
 
+test_expect_success TTY 'colors are suppressed by color.pager' '
+	rm -f paginated.out &&
+	test_config color.ui auto &&
+	test_config color.pager false &&
+	(
+		TERM=vt100 &&
+		export TERM &&
+		test_terminal git log
+	) &&
+	! colorful paginated.out
+'
+
 test_expect_success 'color when writing to a file intended for a pager' '
 	rm -f colorful.log &&
 	test_config color.ui auto ||
diff --git a/wt-status.c b/wt-status.c
index ee03431..8836a52 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -26,7 +26,9 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 
 static const char *color(int slot, struct wt_status *s)
 {
-	const char *c = s->use_color > 0 ? s->color_palette[slot] : "";
+	const char *c = "";
+	if (want_color(s->use_color))
+		c = s->color_palette[slot];
 	if (slot == WT_STATUS_ONBRANCH && color_is_nil(c))
 		c = s->color_palette[WT_STATUS_HEADER];
 	return c;
-- 
1.7.6.10.g62f04
