From: Allan Caffee <allan.caffee@gmail.com>
Subject: [RFC/PATCH] graph API: Added logic for colored edges.
Date: Mon, 30 Mar 2009 10:13:23 -0400
Message-ID: <20090330141322.GA6221@linux.vnet>
References: <20090318100512.GA7932@linux.vnet> <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de> <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com> <alpine.DEB.1.00.0903191831590.6357@intel-tinevez-2-302> <20090320064813.6117@nanako3.lavabit.com> <b2e43f8f0903201213o396de6c0sb52149ed1d889d1@mail.gmail.com> <20090320195806.GC26934@coredump.intra.peff.net> <20090321175726.GA6677@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 16:15:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoIGa-0001di-Mh
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 16:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbZC3ONi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 10:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbZC3ONh
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 10:13:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:33514 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbZC3ONg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 10:13:36 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2466699rvb.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=7lyWEpQMQDXUHelFQ3mYnqU4JTNkcpo+TLMkjLQ664U=;
        b=xFuduOkr7yJpEVUBiYv73JtFUaoHRpU93tXU+3/obVu0NLVoQJ2oApuZu1AYG3xOpO
         BbhM1A1QyJPOayVDyXdTBEylhaztxQDRlw6+j7ZpxNlTwmLMFbPi0TBI1P3sDofDKir+
         GmVzO6pLGzZJjq1K+VpSh1UI73HO7ybe7kolA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=ILJYQii6ejOebAKbq8kDPAbbSAJzL4lYg7OEGT1q2FWOCmKadIewBqaEUrWBM8mMqI
         ffxwZNzk9LBzMAz1hxuOnZgwQ9k7W/9fBxV1Ysc/H/5f7P64yC7z5nalPmCXa0NWNSxR
         WrsjZVHJEdb0XP5j4rAGpGTeyEy8vcdfeKBts=
Received: by 10.142.139.14 with SMTP id m14mr2146947wfd.159.1238422414393;
        Mon, 30 Mar 2009 07:13:34 -0700 (PDT)
Received: from linux.vnet (n2-55-108.dhcp.drexel.edu [144.118.55.108])
        by mx.google.com with ESMTPS id 32sm8651900wfc.49.2009.03.30.07.13.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 07:13:29 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20090321175726.GA6677@linux.vnet>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115152>

Modified the graph drawing logic to colorize edges based on parent-child
relationships similiarly to gitk.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---

I havn't gotten the chance to do any of the color clean up that's been
discussed on this thread.  I'll try to throw something together in a seperate
patch series.

Also this patch isn't respecting the --no-color option which I imagine means
that diff_use_color_default isn't the right variable to be checking.  Johannes
mentioned using diff_use_color but the only instance I see is a parameter to
diff_get_color.  What am I missing?

~Allan

 color.h |    1 +
 graph.c |  167 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 144 insertions(+), 24 deletions(-)

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
index 162a516..2929c8b 100644
--- a/graph.c
+++ b/graph.c
@@ -1,9 +1,11 @@
 #include "cache.h"
 #include "commit.h"
+#include "color.h"
 #include "graph.h"
 #include "diff.h"
 #include "revision.h"
 
+extern int diff_use_color_default;
 /* Internal API */
 
 /*
@@ -72,11 +74,22 @@ struct column {
 	 */
 	struct commit *commit;
 	/*
-	 * XXX: Once we add support for colors, struct column could also
-	 * contain the color of its branch line.
+	 * The color to (optionally) print this column in.
 	 */
+	char *color;
 };
 
+static void strbuf_write_column(struct strbuf *sb, const struct column *c,
+		const char *s);
+
+static char* get_current_column_color (const struct git_graph* graph);
+
+/*
+ * Update the default column color and return the new value.
+ */
+static char* get_next_column_color(struct git_graph* graph);
+
+
 enum graph_state {
 	GRAPH_PADDING,
 	GRAPH_SKIP,
@@ -86,6 +99,24 @@ enum graph_state {
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
@@ -185,6 +216,11 @@ struct git_graph {
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
@@ -201,6 +237,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
+	graph->default_column_color = 0;
 
 	/*
 	 * Allocate a reasonably large default number of columns
@@ -317,6 +354,14 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 					  int *mapping_index)
 {
 	int i;
+	char *color = get_current_column_color(graph);
+
+	for (i = 0; i < graph->num_columns; i++) {
+		if (graph->columns[i].commit == commit) {
+			color = graph->columns[i].color;
+			break;
+		}
+	}
 
 	/*
 	 * If the commit is already in the new_columns list, we don't need to
@@ -334,6 +379,8 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	 * This commit isn't already in new_columns.  Add it.
 	 */
 	graph->new_columns[graph->num_new_columns].commit = commit;
+/*         fprintf(stderr,"adding the %scommit%s\n", color, GIT_COLOR_RESET); */
+	graph->new_columns[graph->num_new_columns].color = color;
 	graph->mapping[*mapping_index] = graph->num_new_columns;
 	*mapping_index += 2;
 	graph->num_new_columns++;
@@ -445,6 +492,12 @@ static void graph_update_columns(struct git_graph *graph)
 			for (parent = first_interesting_parent(graph);
 			     parent;
 			     parent = next_interesting_parent(graph, parent)) {
+				/*
+				 * If this is a merge increment the current
+				 * color.
+				 */
+				if (graph->num_parents > 1)
+					get_next_column_color(graph);
 				graph_insert_into_new_columns(graph,
 							      parent->item,
 							      &mapping_idx);
@@ -596,7 +649,7 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
-		strbuf_addstr(sb, "| ");
+		strbuf_write_column(sb, &graph->new_columns[i], "| ");
 	}
 
 	graph_pad_horizontally(graph, sb);
@@ -649,7 +702,10 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		struct column *col = &graph->columns[i];
 		if (col->commit == graph->commit) {
 			seen_this = 1;
-			strbuf_addf(sb, "| %*s", graph->expansion_row, "");
+			struct strbuf tmp = STRBUF_INIT;
+			strbuf_addf(&tmp, "| %*s", graph->expansion_row, "");
+			strbuf_write_column(sb, col, tmp.buf);
+			strbuf_release(&tmp);
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -662,13 +718,13 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
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
 
@@ -728,6 +784,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 	 */
 	seen_this = 0;
 	for (i = 0; i <= graph->num_columns; i++) {
+		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
 			if (seen_this)
@@ -751,7 +808,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 				strbuf_addstr(sb, ". ");
 			}
 		} else if (seen_this && (graph->num_parents > 2)) {
-			strbuf_addstr(sb, "\\ ");
+			strbuf_write_column(sb, col, "\\ ");
 		} else if (seen_this && (graph->num_parents == 2)) {
 			/*
 			 * This is a 2-way merge commit.
@@ -768,11 +825,11 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
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
 
@@ -789,6 +846,17 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
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
@@ -798,24 +866,43 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
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
 
@@ -834,6 +921,8 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 {
 	int i;
 	int *tmp_mapping;
+	static int collapsing_columns[255];
+	int collapsing_seen_so_far = 0;
 
 	/*
 	 * Clear out the new_mapping array
@@ -912,9 +1001,11 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
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
@@ -979,9 +1070,10 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
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
@@ -991,7 +1083,7 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 					strbuf_addch(sb, ' ');
 			}
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, "| ");
 		}
 	}
 
@@ -1154,3 +1246,30 @@ void graph_show_commit_msg(struct git_graph *graph,
 			putchar('\n');
 	}
 }
+
+static void strbuf_write_column(struct strbuf *sb, const struct column *c,
+		const char *s)
+{
+	/*
+	 * TODO: I get the creeping suspicion that this isn't the
+	 * right flag to be checking since --no-color doesn't turn
+	 * this off.
+	 */
+	if (diff_use_color_default)
+		strbuf_addstr(sb, c->color);
+	strbuf_addstr(sb, s);
+	if (diff_use_color_default)
+		strbuf_addstr(sb, GIT_COLOR_RESET);
+}
+
+static char* get_current_column_color (const struct git_graph* graph)
+{
+	return column_colors[graph->default_column_color];
+}
+
+static char* get_next_column_color(struct git_graph* graph)
+{
+	graph->default_column_color = (graph->default_column_color + 1) %
+		ARRAY_SIZE(column_colors);
+	return (get_current_column_color(graph));
+}
-- 
1.5.4.3
