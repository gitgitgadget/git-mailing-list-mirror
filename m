From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 1/2] graph API: improve display of merge commits
Date: Sun,  1 Jun 2008 13:56:57 -0700
Message-ID: <1212353818-7031-2-git-send-email-adam@adamsimpkins.net>
References: <20080529085752.GA31865@adamsimpkins.net>
 <1212353818-7031-1-git-send-email-adam@adamsimpkins.net>
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 22:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2ud5-0004lK-F8
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 22:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbYFAU5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 16:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbYFAU5J
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 16:57:09 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:52361 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbYFAU5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 16:57:04 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id EB5B41B4003;
	Sun,  1 Jun 2008 16:57:00 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 72FC71B400C;
	Sun,  1 Jun 2008 16:57:00 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id DE35614100CE; Sun,  1 Jun 2008 13:56:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc0.54.g04bfd
In-Reply-To: <1212353818-7031-1-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83468>

This change improves the way merge commits are displayed, to eliminate a
few visual artifacts.  Previously, merge commits were displayed as:

| M  \
| |\  |

As pointed out by Teemu Likonen, this didn't look nice if the rightmost
branch line was displayed as '\' on the previous line, as it then
appeared to have an extra space in it:

| |\
| M  \
| |\  |

This change updates the code so that branch lines to the right of merge
commits are printed slightly differently depending on how the previous
line was displayed:

| |\          | | |        | |  /
| M \         | M |        | M |
| |\ \        | |\ \       | |\ \

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 graph.c |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 93 insertions(+), 17 deletions(-)

diff --git a/graph.c b/graph.c
index 26b8c52..332d1e8 100644
--- a/graph.c
+++ b/graph.c
@@ -81,6 +81,27 @@ struct git_graph {
 	 */
 	enum graph_state state;
 	/*
+	 * The output state for the previous line of output.
+	 * This is primarily used to determine how the first merge line
+	 * should appear, based on the last line of the previous commit.
+	 */
+	enum graph_state prev_state;
+	/*
+	 * The index of the column that refers to this commit.
+	 *
+	 * If none of the incoming columns refer to this commit,
+	 * this will be equal to num_columns.
+	 */
+	int commit_index;
+	/*
+	 * The commit_index for the previously displayed commit.
+	 *
+	 * This is used to determine how the first line of a merge
+	 * graph output should appear, based on the last line of the
+	 * previous commit.
+	 */
+	int prev_commit_index;
+	/*
 	 * The maximum number of columns that can be stored in the columns
 	 * and new_columns arrays.  This is also half the number of entries
 	 * that can be stored in the mapping and new_mapping arrays.
@@ -137,6 +158,9 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->num_parents = 0;
 	graph->expansion_row = 0;
 	graph->state = GRAPH_PADDING;
+	graph->prev_state = GRAPH_PADDING;
+	graph->commit_index = 0;
+	graph->prev_commit_index = 0;
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
@@ -164,6 +188,12 @@ void graph_release(struct git_graph *graph)
 	free(graph);
 }
 
+static void graph_update_state(struct git_graph *graph, enum graph_state s)
+{
+	graph->prev_state = graph->state;
+	graph->state = s;
+}
+
 static void graph_ensure_capacity(struct git_graph *graph, int num_columns)
 {
 	if (graph->column_capacity >= num_columns)
@@ -342,6 +372,7 @@ static void graph_update_columns(struct git_graph *graph)
 		if (col_commit == graph->commit) {
 			int old_mapping_idx = mapping_idx;
 			seen_this = 1;
+			graph->commit_index = i;
 			for (parent = graph->commit->parents;
 			     parent;
 			     parent = parent->next) {
@@ -395,6 +426,13 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	}
 
 	/*
+	 * Store the old commit_index in prev_commit_index.
+	 * graph_update_columns() will update graph->commit_index for this
+	 * commit.
+	 */
+	graph->prev_commit_index = graph->commit_index;
+
+	/*
 	 * Call graph_update_columns() to update
 	 * columns, new_columns, and mapping.
 	 */
@@ -404,6 +442,9 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 
 	/*
 	 * Update graph->state.
+	 * Note that we don't call graph_update_state() here, since
+	 * we don't want to update graph->prev_state.  No line for
+	 * graph->state was ever printed.
 	 *
 	 * If the previous commit didn't get to the GRAPH_PADDING state,
 	 * it never finished its output.  Goto GRAPH_SKIP, to print out
@@ -498,9 +539,9 @@ static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
 	graph_pad_horizontally(graph, sb);
 
 	if (graph->num_parents >= 3)
-		graph->state = GRAPH_PRE_COMMIT;
+		graph_update_state(graph, GRAPH_PRE_COMMIT);
 	else
-		graph->state = GRAPH_COMMIT;
+		graph_update_state(graph, GRAPH_COMMIT);
 }
 
 static void graph_output_pre_commit_line(struct git_graph *graph,
@@ -535,7 +576,22 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		if (col->commit == graph->commit) {
 			seen_this = 1;
 			strbuf_addf(sb, "| %*s", graph->expansion_row, "");
-		} else if (seen_this) {
+		} else if (seen_this && (graph->expansion_row == 0)) {
+			/*
+			 * This is the first line of the pre-commit output.
+			 * If the previous commit was a merge commit and
+			 * ended in the GRAPH_POST_MERGE state, all branch
+			 * lines after graph->prev_commit_index were
+			 * printed as "\" on the previous line.  Continue
+			 * to print them as "\" on this line.  Otherwise,
+			 * print the branch lines as "|".
+			 */
+			if (graph->prev_state == GRAPH_POST_MERGE &&
+			    graph->prev_commit_index < i)
+				strbuf_addstr(sb, "\\ ");
+			else
+				strbuf_addstr(sb, "| ");
+		} else if (seen_this && (graph->expansion_row > 0)) {
 			strbuf_addstr(sb, "\\ ");
 		} else {
 			strbuf_addstr(sb, "| ");
@@ -550,7 +606,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 */
 	graph->expansion_row++;
 	if (graph->expansion_row >= num_expansion_rows)
-		graph->state = GRAPH_COMMIT;
+		graph_update_state(graph, GRAPH_COMMIT);
 }
 
 static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
@@ -625,10 +681,8 @@ void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			seen_this = 1;
 			graph_output_commit_char(graph, sb);
 
-			if (graph->num_parents < 2)
+			if (graph->num_parents < 3)
 				strbuf_addch(sb, ' ');
-			else if (graph->num_parents == 2)
-				strbuf_addstr(sb, "  ");
 			else {
 				int num_dashes =
 					((graph->num_parents - 2) * 2) - 1;
@@ -636,8 +690,27 @@ void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 					strbuf_addch(sb, '-');
 				strbuf_addstr(sb, ". ");
 			}
-		} else if (seen_this && (graph->num_parents > 1)) {
+		} else if (seen_this && (graph->num_parents > 2)) {
 			strbuf_addstr(sb, "\\ ");
+		} else if (seen_this && (graph->num_parents == 2)) {
+			/*
+			 * This is a 2-way merge commit.
+			 * There is no GRAPH_PRE_COMMIT stage for 2-way
+			 * merges, so this is the first line of output
+			 * for this commit.  Check to see what the previous
+			 * line of output was.
+			 *
+			 * If it was GRAPH_POST_MERGE, the branch line
+			 * coming into this commit may have been '\',
+			 * and not '|' or '/'.  If so, output the branch
+			 * line as '\' on this line, instead of '|'.  This
+			 * makes the output look nicer.
+			 */
+			if (graph->prev_state == GRAPH_POST_MERGE &&
+			    graph->prev_commit_index < i)
+				strbuf_addstr(sb, "\\ ");
+			else
+				strbuf_addstr(sb, "| ");
 		} else {
 			strbuf_addstr(sb, "| ");
 		}
@@ -649,11 +722,11 @@ void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 	 * Update graph->state
 	 */
 	if (graph->num_parents > 1)
-		graph->state = GRAPH_POST_MERGE;
+		graph_update_state(graph, GRAPH_POST_MERGE);
 	else if (graph_is_mapping_correct(graph))
-		graph->state = GRAPH_PADDING;
+		graph_update_state(graph, GRAPH_PADDING);
 	else
-		graph->state = GRAPH_COLLAPSING;
+		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
 void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
@@ -679,9 +752,7 @@ void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
 			strbuf_addch(sb, '|');
 			for (j = 0; j < graph->num_parents - 1; j++)
 				strbuf_addstr(sb, "\\ ");
-			if (graph->num_parents == 2)
-				strbuf_addch(sb, ' ');
-		} else if (seen_this && (graph->num_parents > 2)) {
+		} else if (seen_this) {
 			strbuf_addstr(sb, "\\ ");
 		} else {
 			strbuf_addstr(sb, "| ");
@@ -694,9 +765,9 @@ void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
 	 * Update graph->state
 	 */
 	if (graph_is_mapping_correct(graph))
-		graph->state = GRAPH_PADDING;
+		graph_update_state(graph, GRAPH_PADDING);
 	else
-		graph->state = GRAPH_COLLAPSING;
+		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
 void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
@@ -801,7 +872,7 @@ void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
 	 * Otherwise, we need to collapse some branch lines together.
 	 */
 	if (graph_is_mapping_correct(graph))
-		graph->state = GRAPH_PADDING;
+		graph_update_state(graph, GRAPH_PADDING);
 }
 
 int graph_next_line(struct git_graph *graph, struct strbuf *sb)
@@ -865,6 +936,11 @@ void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	}
 
 	graph_pad_horizontally(graph, sb);
+
+	/*
+	 * Update graph->prev_state since we have output a padding line
+	 */
+	graph->prev_state = GRAPH_PADDING;
 }
 
 int graph_is_commit_finished(struct git_graph const *graph)
-- 
1.5.6.rc0.54.g04bfd
