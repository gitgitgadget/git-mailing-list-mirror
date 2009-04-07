From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH] graph API: Added logic for colored edges
Date: Tue, 7 Apr 2009 14:57:24 -0400
Message-ID: <20090407185724.GA9996@linux.vnet>
References: <20090331235922.GA7411@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 21:02:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrGVj-0000x1-8J
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 20:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887AbZDGS5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 14:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbZDGS5d
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 14:57:33 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:25347 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZDGS5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 14:57:31 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2908877wff.4
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=hQ3qwnhul6ryTvNjZ0iUNidJb+o6BOeectThLzEJrLo=;
        b=tlGJxwcMlUgVeQX7MHyZEN0CqxqQzQ1vNV33DfvUjaFbtkKVRJc22FH/nTi8KcrIki
         kj0RfuA0TCTHHROc3f81rYuaI2itgI5XcV+7eeCc5iFFk5mSjG53MrrdbUhXiV0Sy8uz
         XEWd2Cka1+D2EZTDH1NMl8q6URwde+NqTyhGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=G28bhQeSgx8emCWQ9/9x8WdTic6eCF37KAaaL8+Tx8RStjvYu0DoA+Y6y5gbc7Y5qM
         sUNFmjP3ooCfdyyWJrH6qWZYYdqMWXkFV/TFXtGGavJE8dCLMh4NPqAlz1PGe1ketULd
         azihawLTgAaTjI/v6NNVszKrAeNUn32dMAf60=
Received: by 10.142.125.4 with SMTP id x4mr108359wfc.315.1239130650674;
        Tue, 07 Apr 2009 11:57:30 -0700 (PDT)
Received: from linux.vnet (n1-13-232.dhcp.drexel.edu [129.25.13.232])
        by mx.google.com with ESMTPS id 22sm10438650wfg.3.2009.04.07.11.57.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 11:57:29 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>
Content-Disposition: inline
In-Reply-To: <20090331235922.GA7411@linux.vnet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115977>

Modified the graph drawing logic to colorize edges based on parent-child
relationships similiarly to gitk.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
It seemed like it was time for another iteration so here it is.
Changes this round include: (Only the first two were actually posted
to the list as full patches.)

* graph.c: avoid compile warnings (Thanks Johannes)

* --graph: respect --no-color (Thanks Johannes)

* Remove some outdated TODO comments

* Avoid using forward declarations

* Remove commented out debugging code

* Avoid an unnecessary function call

* Refactor/rename some local functions
I replaced get_next_column_column color with graph_increment_column_color since
the return value is never actually used.  I also renamed
get_current_column_color to graph_get_current_column_color.

* Handle column colors as const pointers
The color codes used should never be modified once we begin graphing,
so columns should store/handle them as const char*.

* graph API: Add handling for merges with 3+ parents
I accidentally left this one out of the first round.

~Allan

 color.h |    1 +
 graph.c |  175 +++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 145 insertions(+), 31 deletions(-)

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
index 162a516..0e112d7 100644
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
@@ -72,11 +69,21 @@ struct column {
 	 */
 	struct commit *commit;
 	/*
-	 * XXX: Once we add support for colors, struct column could also
-	 * contain the color of its branch line.
+	 * The color to (optionally) print this column in.
 	 */
+	const char *color;
 };
 
+static void strbuf_write_column(struct strbuf *sb, const struct column *c,
+		const char *s)
+{
+	if (c->color)
+		strbuf_addstr(sb, c->color);
+	strbuf_addstr(sb, s);
+	if (c->color)
+		strbuf_addstr(sb, GIT_COLOR_RESET);
+}
+
 enum graph_state {
 	GRAPH_PADDING,
 	GRAPH_SKIP,
@@ -86,6 +93,24 @@ enum graph_state {
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
 struct git_graph {
 	/*
 	 * The commit currently being processed
@@ -185,6 +210,11 @@ struct git_graph {
 	 * temporary array each time we have to output a collapsing line.
 	 */
 	int *new_mapping;
+	/*
+	 * The current default column color being used.  This is
+	 * stored as an index into the array column_colors.
+	 */
+	short default_column_color;
 };
 
 struct git_graph *graph_init(struct rev_info *opt)
@@ -201,6 +231,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
+	graph->default_column_color = 0;
 
 	/*
 	 * Allocate a reasonably large default number of columns
@@ -312,6 +343,33 @@ static struct commit_list *first_interesting_parent(struct git_graph *graph)
 	return next_interesting_parent(graph, parents);
 }
 
+static const char* graph_get_current_column_color(const struct git_graph* graph)
+{
+	if (!DIFF_OPT_TST(&graph->revs->diffopt, COLOR_DIFF))
+		return NULL;
+	return column_colors[graph->default_column_color];
+}
+
+/*
+ * Update the graph's default column color.
+ */
+static void graph_increment_column_color(struct git_graph* graph)
+{
+	graph->default_column_color = (graph->default_column_color + 1) %
+		ARRAY_SIZE(column_colors);
+}
+
+static const char * graph_find_commit_color(const struct git_graph *graph,
+				      const struct commit *commit)
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
@@ -334,6 +392,7 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	 * This commit isn't already in new_columns.  Add it.
 	 */
 	graph->new_columns[graph->num_new_columns].commit = commit;
+	graph->new_columns[graph->num_new_columns].color = graph_find_commit_color(graph, commit);
 	graph->mapping[*mapping_index] = graph->num_new_columns;
 	*mapping_index += 2;
 	graph->num_new_columns++;
@@ -445,6 +504,12 @@ static void graph_update_columns(struct git_graph *graph)
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
@@ -596,7 +661,7 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
-		strbuf_addstr(sb, "| ");
+		strbuf_write_column(sb, &graph->new_columns[i], "| ");
 	}
 
 	graph_pad_horizontally(graph, sb);
@@ -648,8 +713,11 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		if (col->commit == graph->commit) {
+			struct strbuf tmp = STRBUF_INIT;
 			seen_this = 1;
-			strbuf_addf(sb, "| %*s", graph->expansion_row, "");
+			strbuf_addf(&tmp, "| %*s", graph->expansion_row, "");
+			strbuf_write_column(sb, col, tmp.buf);
+			strbuf_release(&tmp);
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -662,13 +730,13 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
 			    graph->prev_commit_index < i)
-				strbuf_addstr(sb, "\\ ");
+				strbuf_write_column(sb, col, "\\ ");
 			else
-				strbuf_addstr(sb, "| ");
+				strbuf_write_column(sb, col, "| ");
 		} else if (seen_this && (graph->expansion_row > 0)) {
-			strbuf_addstr(sb, "\\ ");
+			strbuf_write_column(sb, col, "\\ ");
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, "| ");
 		}
 	}
 
@@ -728,6 +796,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 	 */
 	seen_this = 0;
 	for (i = 0; i <= graph->num_columns; i++) {
+		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
 			if (seen_this)
@@ -744,14 +813,25 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			if (graph->num_parents < 3)
 				strbuf_addch(sb, ' ');
 			else {
+				/*
+				 * Here dashless_commits represents the
+				 * number of parents which don't need
+				 * to have dashes (because their edges
+				 * fit neatly under the commit).
+				 */
+				const int dashless_commits = 2;
 				int num_dashes =
-					((graph->num_parents - 2) * 2) - 1;
+					((graph->num_parents - dashless_commits) * 2) - 1;
 				for (j = 0; j < num_dashes; j++)
-					strbuf_addch(sb, '-');
-				strbuf_addstr(sb, ". ");
+					strbuf_write_column(sb,
+							    &graph->new_columns[(j / 2) + dashless_commits],
+							    "-");
+				strbuf_write_column(sb,
+						    &graph->new_columns[(j / 2) + dashless_commits],
+						    ". ");
 			}
 		} else if (seen_this && (graph->num_parents > 2)) {
-			strbuf_addstr(sb, "\\ ");
+			strbuf_write_column(sb, col, "\\ ");
 		} else if (seen_this && (graph->num_parents == 2)) {
 			/*
 			 * This is a 2-way merge commit.
@@ -768,11 +848,11 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
 			    graph->prev_commit_index < i)
-				strbuf_addstr(sb, "\\ ");
+				strbuf_write_column(sb, col, "\\ ");
 			else
-				strbuf_addstr(sb, "| ");
+				strbuf_write_column(sb, col, "| ");
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, "| ");
 		}
 	}
 
@@ -789,6 +869,17 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
+inline struct column* find_new_column_by_commit(struct git_graph *graph,
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
@@ -798,24 +889,43 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
 	 * Output the post-merge row
 	 */
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
+			strbuf_write_column(sb, par_column, "|");
+			for (j = 0; j < graph->num_parents - 1; j++) {
+				parents = next_interesting_parent(graph, parents);
+				assert(parents);
+				par_column = find_new_column_by_commit(graph,parents->item);
+				assert(par_column);
+				strbuf_write_column(sb, par_column, "\\ ");
+			}
 		} else if (seen_this) {
-			strbuf_addstr(sb, "\\ ");
+			strbuf_write_column(sb, col, "\\ ");
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, "| ");
 		}
 	}
 
@@ -912,9 +1022,11 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 		if (target < 0)
 			strbuf_addch(sb, ' ');
 		else if (target * 2 == i)
-			strbuf_addch(sb, '|');
-		else
-			strbuf_addch(sb, '/');
+			strbuf_write_column(sb, &graph->new_columns[target], "|");
+		else {
+			strbuf_write_column(sb, &graph->new_columns[target], "/");
+
+		}
 	}
 
 	graph_pad_horizontally(graph, sb);
@@ -979,9 +1091,10 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	 * children that we have already processed.)
 	 */
 	for (i = 0; i < graph->num_columns; i++) {
-		struct commit *col_commit = graph->columns[i].commit;
+		struct column *col = &graph->columns[i];
+		struct commit *col_commit = col->commit;
 		if (col_commit == graph->commit) {
-			strbuf_addch(sb, '|');
+			strbuf_write_column(sb, col, "|");
 
 			if (graph->num_parents < 3)
 				strbuf_addch(sb, ' ');
@@ -991,7 +1104,7 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 					strbuf_addch(sb, ' ');
 			}
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, "| ");
 		}
 	}
 
-- 
1.5.6.3
