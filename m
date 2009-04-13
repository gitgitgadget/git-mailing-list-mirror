From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH v5] graph API: Added logic for colored edges
Date: Mon, 13 Apr 2009 15:53:41 -0400
Message-ID: <20090413195341.GA20532@linux.vnet>
References: <7veivx354b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 21:55:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtSFX-0007k7-CD
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 21:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbZDMTxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 15:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZDMTxt
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 15:53:49 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:28234 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbZDMTxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 15:53:48 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2279317wff.4
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 12:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=OZPKYQF5QOVb1s1oqvDlmdkPReDc1UwY5VHeZzx9t3E=;
        b=sOC1ncTbA+OMUwwgiQQiMQcnLxPmULYm9qj04to7OEW7jBbRYCkakmomDDZ3pOCRWH
         jMsdVSCVCcLwXeitpaCTSr+IuxZfRU3GTL22gNfGZ6/NsEit2JeHzOrU1m07ky3itzOY
         cPLS7CVr3Ec9YPJax2ZPjwlTHjEFueTGilibU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=OM416WhMtRFDihi8xb+vwMEGM+kLk7q+fodYgi1gMfc82rPzD6wAjzyfdDAfz31aJp
         zKh5aSkEDqk02eM8B/KenOjMBimGSfqytqZF2BgRc7hF/J/WsHqgd6A+dJBfyjgJbuDT
         15Dz7hKTAFF7avdRLbql+EckJlbR+hhDKVZnc=
Received: by 10.143.16.9 with SMTP id t9mr815155wfi.276.1239652427622;
        Mon, 13 Apr 2009 12:53:47 -0700 (PDT)
Received: from linux.vnet (n1-13-232.dhcp.drexel.edu [129.25.13.232])
        by mx.google.com with ESMTPS id 30sm18578943wfc.24.2009.04.13.12.53.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 12:53:46 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, Teemu Likonen <tlikonen@iki.fi>
Content-Disposition: inline
In-Reply-To: <7veivx354b.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116480>

Modified the graph drawing logic to colorize edges based on parent-child
relationships similiarly to gitk.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 color.h |    1 +
 graph.c |  246 ++++++++++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 199 insertions(+), 48 deletions(-)

diff --git a/color.h b/color.h
index 6846be1..18abeb7 100644
--- a/color.h
+++ b/color.h
@@ -11,6 +11,7 @@
 #define GIT_COLOR_GREEN		"\033[32m"
 #define GIT_COLOR_YELLOW	"\033[33m"
 #define GIT_COLOR_BLUE		"\033[34m"
+#define GIT_COLOR_MAGENTA	"\033[35m"
 #define GIT_COLOR_CYAN		"\033[36m"
 #define GIT_COLOR_BG_RED	"\033[41m"
 
diff --git a/graph.c b/graph.c
index 162a516..0fcb61a 100644
--- a/graph.c
+++ b/graph.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "color.h"
 #include "graph.h"
 #include "diff.h"
 #include "revision.h"
@@ -43,10 +44,6 @@ static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
 
 /*
  * TODO:
- * - Add colors to the graph.
- *   Pick a color for each column, and print all characters
- *   in that column with the specified color.
- *
  * - Limit the number of columns, similar to the way gitk does.
  *   If we reach more than a specified number of columns, omit
  *   sections of some columns.
@@ -72,9 +69,10 @@ struct column {
 	 */
 	struct commit *commit;
 	/*
-	 * XXX: Once we add support for colors, struct column could also
-	 * contain the color of its branch line.
+	 * The color to (optionally) print this column in.  This is an
+	 * index into column_colors.
 	 */
+	unsigned short color;
 };
 
 enum graph_state {
@@ -86,6 +84,41 @@ enum graph_state {
 	GRAPH_COLLAPSING
 };
 
+/*
+ * The list of available column colors.
+ */
+static char column_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RED,
+	GIT_COLOR_GREEN,
+	GIT_COLOR_YELLOW,
+	GIT_COLOR_BLUE,
+	GIT_COLOR_MAGENTA,
+	GIT_COLOR_CYAN,
+	GIT_COLOR_BOLD GIT_COLOR_RED,
+	GIT_COLOR_BOLD GIT_COLOR_GREEN,
+	GIT_COLOR_BOLD GIT_COLOR_YELLOW,
+	GIT_COLOR_BOLD GIT_COLOR_BLUE,
+	GIT_COLOR_BOLD GIT_COLOR_MAGENTA,
+	GIT_COLOR_BOLD GIT_COLOR_CYAN,
+};
+
+#define COLUMN_COLORS_MAX (ARRAY_SIZE(column_colors))
+
+static const char *column_get_color_code(const struct column *c)
+{
+	return column_colors[c->color];
+}
+
+static void strbuf_write_column(struct strbuf *sb, const struct column *c,
+				char col_char)
+{
+	if (c->color < COLUMN_COLORS_MAX)
+		strbuf_addstr(sb, column_get_color_code(c));
+	strbuf_addch(sb, col_char);
+	if (c->color < COLUMN_COLORS_MAX)
+		strbuf_addstr(sb, GIT_COLOR_RESET);
+}
+
 struct git_graph {
 	/*
 	 * The commit currently being processed
@@ -185,6 +218,11 @@ struct git_graph {
 	 * temporary array each time we have to output a collapsing line.
 	 */
 	int *new_mapping;
+	/*
+	 * The current default column color being used.  This is
+	 * stored as an index into the array column_colors.
+	 */
+	unsigned short default_column_color;
 };
 
 struct git_graph *graph_init(struct rev_info *opt)
@@ -201,6 +239,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
+	graph->default_column_color = 0;
 
 	/*
 	 * Allocate a reasonably large default number of columns
@@ -312,6 +351,33 @@ static struct commit_list *first_interesting_parent(struct git_graph *graph)
 	return next_interesting_parent(graph, parents);
 }
 
+static unsigned short graph_get_current_column_color(const struct git_graph *graph)
+{
+	if (!DIFF_OPT_TST(&graph->revs->diffopt, COLOR_DIFF))
+		return COLUMN_COLORS_MAX;
+	return graph->default_column_color;
+}
+
+/*
+ * Update the graph's default column color.
+ */
+static void graph_increment_column_color(struct git_graph *graph)
+{
+	graph->default_column_color = (graph->default_column_color + 1) %
+		COLUMN_COLORS_MAX;
+}
+
+static unsigned short graph_find_commit_color(const struct git_graph *graph,
+					      const struct commit *commit)
+{
+	int i;
+	for (i = 0; i < graph->num_columns; i++) {
+		if (graph->columns[i].commit == commit)
+			return graph->columns[i].color;
+	}
+	return graph_get_current_column_color(graph);
+}
+
 static void graph_insert_into_new_columns(struct git_graph *graph,
 					  struct commit *commit,
 					  int *mapping_index)
@@ -334,6 +400,7 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	 * This commit isn't already in new_columns.  Add it.
 	 */
 	graph->new_columns[graph->num_new_columns].commit = commit;
+	graph->new_columns[graph->num_new_columns].color = graph_find_commit_color(graph, commit);
 	graph->mapping[*mapping_index] = graph->num_new_columns;
 	*mapping_index += 2;
 	graph->num_new_columns++;
@@ -445,6 +512,12 @@ static void graph_update_columns(struct git_graph *graph)
 			for (parent = first_interesting_parent(graph);
 			     parent;
 			     parent = next_interesting_parent(graph, parent)) {
+				/*
+				 * If this is a merge increment the current
+				 * color.
+				 */
+				if (graph->num_parents > 1)
+					graph_increment_column_color(graph);
 				graph_insert_into_new_columns(graph,
 							      parent->item,
 							      &mapping_idx);
@@ -560,7 +633,8 @@ static int graph_is_mapping_correct(struct git_graph *graph)
 	return 1;
 }
 
-static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb)
+static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
+				   int chars_written)
 {
 	/*
 	 * Add additional spaces to the end of the strbuf, so that all
@@ -570,10 +644,10 @@ static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb)
 	 * aligned for the entire commit.
 	 */
 	int extra;
-	if (sb->len >= graph->width)
+	if (chars_written >= graph->width)
 		return;
 
-	extra = graph->width - sb->len;
+	extra = graph->width - chars_written;
 	strbuf_addf(sb, "%*s", (int) extra, "");
 }
 
@@ -596,10 +670,11 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
-		strbuf_addstr(sb, "| ");
+		strbuf_write_column(sb, &graph->new_columns[i], '|');
+		strbuf_addch(sb, ' ');
 	}
 
-	graph_pad_horizontally(graph, sb);
+	graph_pad_horizontally(graph, sb, graph->num_new_columns * 2);
 }
 
 static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
@@ -609,7 +684,7 @@ static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
 	 * of the graph is missing.
 	 */
 	strbuf_addstr(sb, "...");
-	graph_pad_horizontally(graph, sb);
+	graph_pad_horizontally(graph, sb, 3);
 
 	if (graph->num_parents >= 3 &&
 	    graph->commit_index < (graph->num_columns - 1))
@@ -623,6 +698,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 {
 	int num_expansion_rows;
 	int i, seen_this;
+	int chars_written;
 
 	/*
 	 * This function formats a row that increases the space around a commit
@@ -645,11 +721,14 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 * Output the row
 	 */
 	seen_this = 0;
+	chars_written = 0;
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		if (col->commit == graph->commit) {
 			seen_this = 1;
-			strbuf_addf(sb, "| %*s", graph->expansion_row, "");
+			strbuf_write_column(sb, col, '|');
+			strbuf_addf(sb, " %*s", graph->expansion_row, "");
+			chars_written += 2 + graph->expansion_row;
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -662,17 +741,22 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
 			    graph->prev_commit_index < i)
-				strbuf_addstr(sb, "\\ ");
+				strbuf_write_column(sb, col, '\\');
 			else
-				strbuf_addstr(sb, "| ");
+				strbuf_write_column(sb, col, '|');
+			chars_written++;
 		} else if (seen_this && (graph->expansion_row > 0)) {
-			strbuf_addstr(sb, "\\ ");
+			strbuf_write_column(sb, col, '\\');
+			chars_written++;
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, '|');
+			chars_written++;
 		}
+		strbuf_addch(sb, ' ');
+		chars_written++;
 	}
 
-	graph_pad_horizontally(graph, sb);
+	graph_pad_horizontally(graph, sb, chars_written);
 
 	/*
 	 * Increment graph->expansion_row,
@@ -714,10 +798,34 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 	strbuf_addch(sb, '*');
 }
 
+/*
+ * Draw an octopus merge and return the number of characters written.
+ */
+static int graph_draw_octopus_merge(struct git_graph *graph,
+				    struct strbuf *sb)
+{
+	/*
+	 * Here dashless_commits represents the number of parents
+	 * which don't need to have dashes (because their edges fit
+	 * neatly under the commit).
+	 */
+	const int dashless_commits = 2;
+	int col_num, i;
+	int num_dashes =
+		((graph->num_parents - dashless_commits) * 2) - 1;
+	for (i = 0; i < num_dashes; i++) {
+		col_num = (i / 2) + dashless_commits;
+		strbuf_write_column(sb, &graph->new_columns[col_num], '-');
+	}
+	col_num = (i / 2) + dashless_commits;
+	strbuf_write_column(sb, &graph->new_columns[col_num], '.');
+	return num_dashes + 1;
+}
+
 static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int seen_this = 0;
-	int i, j;
+	int i, chars_written;
 
 	/*
 	 * Output the row containing this commit
@@ -727,7 +835,9 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 	 * children that we have already processed.)
 	 */
 	seen_this = 0;
+	chars_written = 0;
 	for (i = 0; i <= graph->num_columns; i++) {
+		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
 			if (seen_this)
@@ -740,18 +850,14 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 		if (col_commit == graph->commit) {
 			seen_this = 1;
 			graph_output_commit_char(graph, sb);
+			chars_written++;
 
-			if (graph->num_parents < 3)
-				strbuf_addch(sb, ' ');
-			else {
-				int num_dashes =
-					((graph->num_parents - 2) * 2) - 1;
-				for (j = 0; j < num_dashes; j++)
-					strbuf_addch(sb, '-');
-				strbuf_addstr(sb, ". ");
-			}
+			if (graph->num_parents > 3)
+				chars_written += graph_draw_octopus_merge(graph,
+									  sb);
 		} else if (seen_this && (graph->num_parents > 2)) {
-			strbuf_addstr(sb, "\\ ");
+			strbuf_write_column(sb, col, '\\');
+			chars_written++;
 		} else if (seen_this && (graph->num_parents == 2)) {
 			/*
 			 * This is a 2-way merge commit.
@@ -768,15 +874,19 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
 			    graph->prev_commit_index < i)
-				strbuf_addstr(sb, "\\ ");
+				strbuf_write_column(sb, col, '\\');
 			else
-				strbuf_addstr(sb, "| ");
+				strbuf_write_column(sb, col, '|');
+			chars_written++;
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, '|');
+			chars_written++;
 		}
+		strbuf_addch(sb, ' ');
+		chars_written++;
 	}
 
-	graph_pad_horizontally(graph, sb);
+	graph_pad_horizontally(graph, sb, chars_written);
 
 	/*
 	 * Update graph->state
@@ -789,37 +899,75 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
+static struct column *find_new_column_by_commit(struct git_graph *graph,
+						struct commit *commit)
+{
+	int i;
+	for (i = 0; i < graph->num_new_columns; i++) {
+		if (graph->new_columns[i].commit == commit)
+			return &graph->new_columns[i];
+	}
+	return 0;
+}
+
 static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int seen_this = 0;
-	int i, j;
+	int i, j, chars_written;
 
 	/*
 	 * Output the post-merge row
 	 */
+	chars_written = 0;
 	for (i = 0; i <= graph->num_columns; i++) {
+		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
 			if (seen_this)
 				break;
 			col_commit = graph->commit;
 		} else {
-			col_commit = graph->columns[i].commit;
+			col_commit = col->commit;
 		}
 
 		if (col_commit == graph->commit) {
+			/*
+			 * Since the current commit is a merge find
+			 * the columns for the parent commits in
+			 * new_columns and use those to format the
+			 * edges.
+			 */
+			struct commit_list *parents = NULL;
+			struct column *par_column;
 			seen_this = 1;
-			strbuf_addch(sb, '|');
-			for (j = 0; j < graph->num_parents - 1; j++)
-				strbuf_addstr(sb, "\\ ");
+			parents = first_interesting_parent(graph);
+			assert(parents);
+			par_column = find_new_column_by_commit(graph,parents->item);
+			assert(par_column);
+
+			strbuf_write_column(sb, par_column, '|');
+			chars_written++;
+			for (j = 0; j < graph->num_parents - 1; j++) {
+				parents = next_interesting_parent(graph, parents);
+				assert(parents);
+				par_column = find_new_column_by_commit(graph,parents->item);
+				assert(par_column);
+				strbuf_write_column(sb, par_column, '\\');
+				strbuf_addch(sb, ' ');
+			}
+			chars_written += j * 2;
 		} else if (seen_this) {
-			strbuf_addstr(sb, "\\ ");
+			strbuf_write_column(sb, col, '\\');
+			strbuf_addch(sb, ' ');
+			chars_written += 2;
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, '|');
+			strbuf_addch(sb, ' ');
+			chars_written += 2;
 		}
 	}
 
-	graph_pad_horizontally(graph, sb);
+	graph_pad_horizontally(graph, sb, chars_written);
 
 	/*
 	 * Update graph->state
@@ -912,12 +1060,12 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 		if (target < 0)
 			strbuf_addch(sb, ' ');
 		else if (target * 2 == i)
-			strbuf_addch(sb, '|');
+			strbuf_write_column(sb, &graph->new_columns[target], '|');
 		else
-			strbuf_addch(sb, '/');
+			strbuf_write_column(sb, &graph->new_columns[target], '/');
 	}
 
-	graph_pad_horizontally(graph, sb);
+	graph_pad_horizontally(graph, sb, graph->mapping_size);
 
 	/*
 	 * Swap mapping and new_mapping
@@ -979,9 +1127,10 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	 * children that we have already processed.)
 	 */
 	for (i = 0; i < graph->num_columns; i++) {
-		struct commit *col_commit = graph->columns[i].commit;
+		struct column *col = &graph->columns[i];
+		struct commit *col_commit = col->commit;
 		if (col_commit == graph->commit) {
-			strbuf_addch(sb, '|');
+			strbuf_write_column(sb, col, '|');
 
 			if (graph->num_parents < 3)
 				strbuf_addch(sb, ' ');
@@ -991,11 +1140,12 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 					strbuf_addch(sb, ' ');
 			}
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, '|');
+			strbuf_addch(sb, ' ');
 		}
 	}
 
-	graph_pad_horizontally(graph, sb);
+	graph_pad_horizontally(graph, sb, graph->num_columns);
 
 	/*
 	 * Update graph->prev_state since we have output a padding line
-- 
1.5.6.3
