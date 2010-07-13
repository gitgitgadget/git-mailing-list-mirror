From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/2] Enable custom schemes for column colors in the graph API
Date: Tue, 13 Jul 2010 23:23:39 +0200
Message-ID: <1279056219-27096-3-git-send-email-johan@herland.net>
References: <1279056219-27096-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net,
	Lars Hjemli <hjemli@gmail.com>, nanako3@lavabit.com,
	adam@adamsimpkins.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 23:24:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYmxL-00066v-Bj
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 23:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab0GMVX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 17:23:56 -0400
Received: from smtp.getmail.no ([84.208.15.66]:63069 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab0GMVXq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 17:23:46 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00APXM3JA650@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:23:43 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 995981EA5BDE_C3CD95FB	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:23:43 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 217A41EA3B0B_C3CD95FF	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:23:43 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00746M3I0N00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:23:43 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
In-reply-to: <1279056219-27096-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150920>

Currently, the graph code is hardcoded to use ANSI color escapes for
coloring the column characters in the generated graphs. This patch
allows a custom scheme of colors to be set at runtime, allowing
different types of color escapes to be used.

A new function - graph_set_column_colors() - is added to the graph.h API,
which allows a custom column_colors array (and column_colors_max value)
to replace the builtin ANSI array (and _max value). The new function -
if used - must be called before graph_init() is called.

Signed-off-by: Johan Herland <johan@herland.net>
---
 graph.c |   37 ++++++++++++++++++++++++++-----------
 graph.h |   17 +++++++++++++++++
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/graph.c b/graph.c
index 47397da..e2a5860 100644
--- a/graph.c
+++ b/graph.c
@@ -62,7 +62,7 @@ enum graph_state {
 /*
  * The list of available column colors.
  */
-static char column_colors[][COLOR_MAXLEN] = {
+static const char *column_colors_ansi[] = {
 	GIT_COLOR_RED,
 	GIT_COLOR_GREEN,
 	GIT_COLOR_YELLOW,
@@ -75,23 +75,33 @@ static char column_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_BOLD_BLUE,
 	GIT_COLOR_BOLD_MAGENTA,
 	GIT_COLOR_BOLD_CYAN,
+	GIT_COLOR_RESET,
 };
 
-#define COLUMN_COLORS_MAX (ARRAY_SIZE(column_colors))
+#define COLUMN_COLORS_ANSI_MAX (ARRAY_SIZE(column_colors_ansi) - 1)
 
-static const char *column_get_color_code(const struct column *c)
+static const char **column_colors;
+static unsigned short column_colors_max;
+
+void graph_set_column_colors(const char **colors, unsigned short colors_max)
+{
+	column_colors = colors;
+	column_colors_max = colors_max;
+}
+
+static const char *column_get_color_code(unsigned short color)
 {
-	return column_colors[c->color];
+	return column_colors[color];
 }
 
 static void strbuf_write_column(struct strbuf *sb, const struct column *c,
 				char col_char)
 {
-	if (c->color < COLUMN_COLORS_MAX)
-		strbuf_addstr(sb, column_get_color_code(c));
+	if (c->color < column_colors_max)
+		strbuf_addstr(sb, column_get_color_code(c->color));
 	strbuf_addch(sb, col_char);
-	if (c->color < COLUMN_COLORS_MAX)
-		strbuf_addstr(sb, GIT_COLOR_RESET);
+	if (c->color < column_colors_max)
+		strbuf_addstr(sb, column_get_color_code(column_colors_max));
 }
 
 struct git_graph {
@@ -215,6 +225,11 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 struct git_graph *graph_init(struct rev_info *opt)
 {
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
+
+	if (!column_colors)
+		graph_set_column_colors(column_colors_ansi,
+					COLUMN_COLORS_ANSI_MAX);
+
 	graph->commit = NULL;
 	graph->revs = opt;
 	graph->num_parents = 0;
@@ -231,7 +246,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	 * always increment it for the first commit we output.
 	 * This way we start at 0 for the first commit.
 	 */
-	graph->default_column_color = COLUMN_COLORS_MAX - 1;
+	graph->default_column_color = column_colors_max - 1;
 
 	/*
 	 * Allocate a reasonably large default number of columns
@@ -354,7 +369,7 @@ static struct commit_list *first_interesting_parent(struct git_graph *graph)
 static unsigned short graph_get_current_column_color(const struct git_graph *graph)
 {
 	if (!DIFF_OPT_TST(&graph->revs->diffopt, COLOR_DIFF))
-		return COLUMN_COLORS_MAX;
+		return column_colors_max;
 	return graph->default_column_color;
 }
 
@@ -364,7 +379,7 @@ static unsigned short graph_get_current_column_color(const struct git_graph *gra
 static void graph_increment_column_color(struct git_graph *graph)
 {
 	graph->default_column_color = (graph->default_column_color + 1) %
-		COLUMN_COLORS_MAX;
+		column_colors_max;
 }
 
 static unsigned short graph_find_commit_color(const struct git_graph *graph,
diff --git a/graph.h b/graph.h
index f188168..aff960c 100644
--- a/graph.h
+++ b/graph.h
@@ -5,6 +5,23 @@
 struct git_graph;
 
 /*
+ * Set up a custom scheme for column colors.
+ *
+ * The default column color scheme inserts ANSI color escapes to colorize
+ * the graph. The various color escapes are stored in an array of strings
+ * where each entry corresponds to a color, except for the last entry,
+ * which denotes the escape for resetting the color back to the default.
+ * When generating the graph, strings from this array are inserted before
+ * and after the various column characters.
+ *
+ * This function allows you to enable a custom array of color escapes.
+ * The 'colors_max' argument is the index of the last "reset" entry.
+ *
+ * This functions must be called BEFORE graph_init() is called.
+ */
+void graph_set_column_colors(const char **colors, unsigned short colors_max);
+
+/*
  * Create a new struct git_graph.
  */
 struct git_graph *graph_init(struct rev_info *opt);
-- 
1.7.0.4
