From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH] graph API: eliminate unnecessary indentation
Date: Mon,  5 May 2008 00:57:03 -0700
Message-ID: <1209974223-2875-1-git-send-email-adam@adamsimpkins.net>
References: <1209897414-10091-4-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 09:59:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsvaA-0006q5-RD
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 09:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbYEEH5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 03:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbYEEH5J
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 03:57:09 -0400
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:48952 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbYEEH5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 03:57:08 -0400
Received: from relay1.r1.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay1.r1.iad.emailsrvr.com (SMTP Server) with ESMTP id BDB6D44C109;
	Mon,  5 May 2008 03:57:05 -0400 (EDT)
Received: by relay1.r1.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 7697144C0F2;
	Mon,  5 May 2008 03:57:05 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 0159514100C2; Mon,  5 May 2008 00:57:03 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1209897414-10091-4-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81238>

This change improves the calculation of the amount of horizontal
padding, so that there is always exactly 1 space of padding.
Previously, most commits had 3 spaces of padding, but commits that
didn't have any children in the graph had only 1 space of padding.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---

This fixes the issue reported by Ping Yin.

 graph.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/graph.c b/graph.c
index b575d10..809a582 100644
--- a/graph.c
+++ b/graph.c
@@ -61,6 +61,12 @@ struct git_graph {
 	 */
 	int num_parents;
 	/*
+	 * The width of the graph output for this commit.
+	 * All rows for this commit are padded to this width, so that
+	 * messages printed after the graph output are aligned.
+	 */
+	int width;
+	/*
 	 * The next expansion row to print
 	 * when state is GRAPH_PRE_COMMIT
 	 */
@@ -207,13 +213,48 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	graph->num_new_columns++;
 }
 
+static void graph_update_width(struct git_graph *graph,
+			       int is_commit_in_existing_columns)
+{
+	/*
+	 * Compute the width needed to display the graph for this commit.
+	 * This is the maximum width needed for any row.  All other rows
+	 * will be padded to this width.
+	 *
+	 * Compute the number of columns in the widest row:
+	 * Count each existing column (graph->num_columns), and each new
+	 * column added by this commit.
+	 */
+	int max_cols = graph->num_columns + graph->num_parents;
+
+	/*
+	 * Even if the current commit has no parents, it still takes up a
+	 * column for itself.
+	 */
+	if (graph->num_parents < 1)
+		max_cols++;
+
+	/*
+	 * We added a column for the the current commit as part of
+	 * graph->num_parents.  If the current commit was already in
+	 * graph->columns, then we have double counted it.
+	 */
+	if (is_commit_in_existing_columns)
+		max_cols--;
+
+	/*
+	 * Each column takes up 2 spaces
+	 */
+	graph->width = max_cols * 2;
+}
+
 static void graph_update_columns(struct git_graph *graph)
 {
 	struct commit_list *parent;
 	struct column *tmp_columns;
 	int max_new_columns;
 	int mapping_idx;
-	int i, seen_this;
+	int i, seen_this, is_commit_in_columns;
 
 	/*
 	 * Swap graph->columns with graph->new_columns
@@ -259,11 +300,13 @@ static void graph_update_columns(struct git_graph *graph)
 	 */
 	seen_this = 0;
 	mapping_idx = 0;
+	is_commit_in_columns = 1;
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
 			if (seen_this)
 				break;
+			is_commit_in_columns = 0;
 			col_commit = graph->commit;
 		} else {
 			col_commit = graph->columns[i].commit;
@@ -290,6 +333,11 @@ static void graph_update_columns(struct git_graph *graph)
 	while (graph->mapping_size > 1 &&
 	       graph->mapping[graph->mapping_size - 1] < 0)
 		graph->mapping_size--;
+
+	/*
+	 * Compute graph->width for this commit
+	 */
+	graph_update_width(graph, is_commit_in_columns);
 }
 
 void graph_update(struct git_graph *graph, struct commit *commit)
@@ -368,22 +416,12 @@ static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb)
 	 *
 	 * This way, fields printed to the right of the graph will remain
 	 * aligned for the entire commit.
-	 *
-	 * This computation results in 3 extra space to the right in most
-	 * cases, but only 1 extra space if the commit doesn't have any
-	 * children that have already been displayed in the graph (i.e.,
-	 * if the current commit isn't in graph->columns).
 	 */
-	size_t extra;
-	size_t final_width = graph->num_columns + graph->num_parents;
-	if (graph->num_parents < 1)
-		final_width++;
-	final_width *= 2;
-
-	if (sb->len >= final_width)
+	int extra;
+	if (sb->len >= graph->width)
 		return;
 
-	extra = final_width - sb->len;
+	extra = graph->width - sb->len;
 	strbuf_addf(sb, "%*s", extra, "");
 }
 
-- 
1.5.3.6
