From: Jeff King <peff@peff.net>
Subject: [PATCH 05/10] diff: refactor COLOR_DIFF from a flag into an int
Date: Wed, 17 Aug 2011 22:03:12 -0700
Message-ID: <20110818050310.GE2889@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 07:03:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtulI-0007Lt-MZ
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 07:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab1HRFDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 01:03:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45186
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665Ab1HRFDT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 01:03:19 -0400
Received: (qmail 18327 invoked by uid 107); 18 Aug 2011 05:03:59 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 01:03:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 22:03:12 -0700
Content-Disposition: inline
In-Reply-To: <20110818045821.GA17377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179562>

This lets us store more than just a bit flag for whether we
want color; we can also store whether we want automatic
colors. This can be useful for making the automatic-color
decision closer to the point of use.

This mostly just involves replacing DIFF_OPT_* calls with
manipulations of the flag. The biggest exception is that
calls to DIFF_OPT_TST must check for "o->use_color > 0",
which lets an "unknown" value (i.e., the default) stay at
"no color". In the previous code, a value of "-1" was not
propagated at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge.c |    2 --
 combine-diff.c  |    7 +++----
 diff.c          |   41 +++++++++++++++++++----------------------
 diff.h          |    5 +++--
 graph.c         |    2 +-
 log-tree.c      |    4 ++--
 wt-status.c     |    2 +-
 7 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 325891e..7209edf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -390,8 +390,6 @@ static void finish(const unsigned char *new_head, const char *msg)
 		opts.output_format |=
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename = DIFF_DETECT_RENAME;
-		if (diff_use_color_default > 0)
-			DIFF_OPT_SET(&opts, COLOR_DIFF);
 		if (diff_setup_done(&opts) < 0)
 			die(_("diff_setup_done failed"));
 		diff_tree_sha1(head, new_head, "", &opts);
diff --git a/combine-diff.c b/combine-diff.c
index be67cfc..c588c79 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -702,9 +702,8 @@ static void show_combined_header(struct combine_diff_path *elem,
 	int abbrev = DIFF_OPT_TST(opt, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
 	const char *a_prefix = opt->a_prefix ? opt->a_prefix : "a/";
 	const char *b_prefix = opt->b_prefix ? opt->b_prefix : "b/";
-	int use_color = DIFF_OPT_TST(opt, COLOR_DIFF);
-	const char *c_meta = diff_get_color(use_color, DIFF_METAINFO);
-	const char *c_reset = diff_get_color(use_color, DIFF_RESET);
+	const char *c_meta = diff_get_color_opt(opt, DIFF_METAINFO);
+	const char *c_reset = diff_get_color_opt(opt, DIFF_RESET);
 	const char *abb;
 	int added = 0;
 	int deleted = 0;
@@ -964,7 +963,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		show_combined_header(elem, num_parent, dense, rev,
 				     mode_differs, 1);
 		dump_sline(sline, cnt, num_parent,
-			   DIFF_OPT_TST(opt, COLOR_DIFF), result_deleted);
+			   opt->use_color, result_deleted);
 	}
 	free(result);
 
diff --git a/diff.c b/diff.c
index 93ef9a2..2d86abe 100644
--- a/diff.c
+++ b/diff.c
@@ -583,11 +583,10 @@ static void emit_rewrite_diff(const char *name_a,
 			      struct diff_options *o)
 {
 	int lc_a, lc_b;
-	int color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
 	const char *name_a_tab, *name_b_tab;
-	const char *metainfo = diff_get_color(color_diff, DIFF_METAINFO);
-	const char *fraginfo = diff_get_color(color_diff, DIFF_FRAGINFO);
-	const char *reset = diff_get_color(color_diff, DIFF_RESET);
+	const char *metainfo = diff_get_color(o->use_color, DIFF_METAINFO);
+	const char *fraginfo = diff_get_color(o->use_color, DIFF_FRAGINFO);
+	const char *reset = diff_get_color(o->use_color, DIFF_RESET);
 	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
 	const char *a_prefix, *b_prefix;
 	char *data_one, *data_two;
@@ -623,7 +622,7 @@ static void emit_rewrite_diff(const char *name_a,
 	size_two = fill_textconv(textconv_two, two, &data_two);
 
 	memset(&ecbdata, 0, sizeof(ecbdata));
-	ecbdata.color_diff = color_diff;
+	ecbdata.color_diff = o->use_color > 0;
 	ecbdata.found_changesp = &o->found_changes;
 	ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
 	ecbdata.opt = o;
@@ -1004,7 +1003,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 
 const char *diff_get_color(int diff_use_color, enum color_diff ix)
 {
-	if (diff_use_color)
+	if (diff_use_color > 0)
 		return diff_colors[ix];
 	return "";
 }
@@ -1808,11 +1807,10 @@ static int is_conflict_marker(const char *line, int marker_size, unsigned long l
 static void checkdiff_consume(void *priv, char *line, unsigned long len)
 {
 	struct checkdiff_t *data = priv;
-	int color_diff = DIFF_OPT_TST(data->o, COLOR_DIFF);
 	int marker_size = data->conflict_marker_size;
-	const char *ws = diff_get_color(color_diff, DIFF_WHITESPACE);
-	const char *reset = diff_get_color(color_diff, DIFF_RESET);
-	const char *set = diff_get_color(color_diff, DIFF_FILE_NEW);
+	const char *ws = diff_get_color(data->o->use_color, DIFF_WHITESPACE);
+	const char *reset = diff_get_color(data->o->use_color, DIFF_RESET);
+	const char *set = diff_get_color(data->o->use_color, DIFF_FILE_NEW);
 	char *err;
 	char *line_prefix = "";
 	struct strbuf *msgbuf;
@@ -2157,7 +2155,7 @@ static void builtin_diff(const char *name_a,
 		memset(&xecfg, 0, sizeof(xecfg));
 		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path = lbl;
-		ecbdata.color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
+		ecbdata.color_diff = o->use_color > 0;
 		ecbdata.found_changesp = &o->found_changes;
 		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
@@ -2205,7 +2203,7 @@ static void builtin_diff(const char *name_a,
 					break;
 				}
 			}
-			if (DIFF_OPT_TST(o, COLOR_DIFF)) {
+			if (o->use_color > 0) {
 				struct diff_words_style *st = ecbdata.diff_words->style;
 				st->old.color = diff_get_color_opt(o, DIFF_FILE_OLD);
 				st->new.color = diff_get_color_opt(o, DIFF_FILE_NEW);
@@ -2855,7 +2853,7 @@ static void run_diff_cmd(const char *pgm,
 		 */
 		fill_metainfo(msg, name, other, one, two, o, p,
 			      &must_show_header,
-			      DIFF_OPT_TST(o, COLOR_DIFF) && !pgm);
+			      o->use_color > 0 && !pgm);
 		xfrm_msg = msg->len ? msg->buf : NULL;
 	}
 
@@ -3021,8 +3019,7 @@ void diff_setup(struct diff_options *options)
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
-	if (diff_use_color_default > 0)
-		DIFF_OPT_SET(options, COLOR_DIFF);
+	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 
 	if (diff_no_prefix) {
@@ -3410,24 +3407,24 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--follow"))
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
 	else if (!strcmp(arg, "--color"))
-		DIFF_OPT_SET(options, COLOR_DIFF);
+		options->use_color = 1;
 	else if (!prefixcmp(arg, "--color=")) {
 		int value = git_config_colorbool(NULL, arg+8, -1);
 		if (value == 0)
-			DIFF_OPT_CLR(options, COLOR_DIFF);
+			options->use_color = 0;
 		else if (value > 0)
-			DIFF_OPT_SET(options, COLOR_DIFF);
+			options->use_color = 1;
 		else
 			return error("option `color' expects \"always\", \"auto\", or \"never\"");
 	}
 	else if (!strcmp(arg, "--no-color"))
-		DIFF_OPT_CLR(options, COLOR_DIFF);
+		options->use_color = 0;
 	else if (!strcmp(arg, "--color-words")) {
-		DIFF_OPT_SET(options, COLOR_DIFF);
+		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
 	}
 	else if (!prefixcmp(arg, "--color-words=")) {
-		DIFF_OPT_SET(options, COLOR_DIFF);
+		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
 		options->word_regex = arg + 14;
 	}
@@ -3440,7 +3437,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		if (!strcmp(type, "plain"))
 			options->word_diff = DIFF_WORDS_PLAIN;
 		else if (!strcmp(type, "color")) {
-			DIFF_OPT_SET(options, COLOR_DIFF);
+			options->use_color = 1;
 			options->word_diff = DIFF_WORDS_COLOR;
 		}
 		else if (!strcmp(type, "porcelain"))
diff --git a/diff.h b/diff.h
index b920a20..8c66b59 100644
--- a/diff.h
+++ b/diff.h
@@ -58,7 +58,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_SILENT_ON_REMOVE    (1 <<  5)
 #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
 #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
-#define DIFF_OPT_COLOR_DIFF          (1 <<  8)
+/* (1 <<  8) unused */
 /* (1 <<  9) unused */
 #define DIFF_OPT_HAS_CHANGES         (1 << 10)
 #define DIFF_OPT_QUICK               (1 << 11)
@@ -101,6 +101,7 @@ struct diff_options {
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	unsigned flags;
+	int use_color;
 	int context;
 	int interhunkcontext;
 	int break_opt;
@@ -160,7 +161,7 @@ enum color_diff {
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
-	diff_get_color(DIFF_OPT_TST((o), COLOR_DIFF), ix)
+	diff_get_color((o)->use_color, ix)
 
 
 extern const char mime_boundary_leader[];
diff --git a/graph.c b/graph.c
index 2f6893d..556834a 100644
--- a/graph.c
+++ b/graph.c
@@ -347,7 +347,7 @@ static struct commit_list *first_interesting_parent(struct git_graph *graph)
 
 static unsigned short graph_get_current_column_color(const struct git_graph *graph)
 {
-	if (!DIFF_OPT_TST(&graph->revs->diffopt, COLOR_DIFF))
+	if (graph->revs->diffopt.use_color <= 0)
 		return column_colors_max;
 	return graph->default_column_color;
 }
diff --git a/log-tree.c b/log-tree.c
index e945701..9ba8fb2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -31,7 +31,7 @@ static char decoration_colors[][COLOR_MAXLEN] = {
 
 static const char *decorate_get_color(int decorate_use_color, enum decoration_type ix)
 {
-	if (decorate_use_color)
+	if (decorate_use_color > 0)
 		return decoration_colors[ix];
 	return "";
 }
@@ -77,7 +77,7 @@ int parse_decorate_color_config(const char *var, const int ofs, const char *valu
  * for showing the commit sha1, use the same check for --decorate
  */
 #define decorate_get_color_opt(o, ix) \
-	decorate_get_color(DIFF_OPT_TST((o), COLOR_DIFF), ix)
+	decorate_get_color((o)->use_color, ix)
 
 static void add_name_decoration(enum decoration_type type, const char *name, struct object *obj)
 {
diff --git a/wt-status.c b/wt-status.c
index 0237772..ee03431 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -681,7 +681,7 @@ static void wt_status_print_verbose(struct wt_status *s)
 	 * will have checked isatty on stdout).
 	 */
 	if (s->fp != stdout)
-		DIFF_OPT_CLR(&rev.diffopt, COLOR_DIFF);
+		rev.diffopt.use_color = 0;
 	run_diff_index(&rev, 1);
 }
 
-- 
1.7.6.10.g62f04
