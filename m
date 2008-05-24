From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 2/2] graph API: don't print branch lines for uninteresting merge parents
Date: Fri, 23 May 2008 19:24:11 -0700
Message-ID: <1211595851-11992-3-git-send-email-adam@adamsimpkins.net>
References: <7vk5hkpjj5.fsf@gitster.siamese.dyndns.org>
 <1211595851-11992-1-git-send-email-adam@adamsimpkins.net>
 <1211595851-11992-2-git-send-email-adam@adamsimpkins.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 04:25:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzjRp-0006aC-UJ
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 04:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309AbYEXCYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 22:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756942AbYEXCYP
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 22:24:15 -0400
Received: from smtp172.sat.emailsrvr.com ([66.216.121.172]:58837 "EHLO
	smtp172.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756928AbYEXCYN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 22:24:13 -0400
Received: from relay7.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 7B2EB1B4292;
	Fri, 23 May 2008 22:24:12 -0400 (EDT)
Received: by relay7.relay.sat.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 392051B42B3;
	Fri, 23 May 2008 22:24:12 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 7EF5F14100C7; Fri, 23 May 2008 19:24:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.384.g3f697
In-Reply-To: <1211595851-11992-2-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82791>

Previously, the graphing code printed lines coming out of a merge commit
for all of its parents, even if some of them were uninteresting.  Now it
only prints lines for interesting commits.

For example, for a merge commit where only the first parent is
interesting, the code now prints:

  *  merge commit
  *  interesting child

instead of:

  M  merge commit
  |\
  *  interesting child
---
 graph.c |   57 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/graph.c b/graph.c
index 400f014..add7e44 100644
--- a/graph.c
+++ b/graph.c
@@ -55,9 +55,11 @@ struct git_graph {
 	 */
 	struct commit *commit;
 	/*
-	 * The number of parents this commit has.
-	 * (Stored so we don't have to walk over them each time we need
-	 * this number)
+	 * The number of interesting parents that this commit has.
+	 *
+	 * Note that this is not the same as the actual number of parents.
+	 * This count excludes parents that won't be printed in the graph
+	 * output, as determined by graph_is_interesting().
 	 */
 	int num_parents;
 	/*
@@ -180,6 +182,18 @@ static void graph_ensure_capacity(struct git_graph *graph, int num_columns)
 				      sizeof(int) * 2 * graph->column_capacity);
 }
 
+/*
+ * Returns 1 if the commit will be printed in the graph output,
+ * and 0 otherwise.
+ */
+static int graph_is_interesting(struct commit *commit)
+{
+	/*
+	 * Uninteresting and pruned commits won't be printed
+	 */
+	return (commit->object.flags & (UNINTERESTING | TREESAME)) ? 0 : 1;
+}
+
 static void graph_insert_into_new_columns(struct git_graph *graph,
 					  struct commit *commit,
 					  int *mapping_index)
@@ -187,13 +201,10 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	int i;
 
 	/*
-	 * Ignore uinteresting and pruned commits
+	 * Ignore uinteresting commits
 	 */
-	if (commit->object.flags & (UNINTERESTING | TREESAME))
-	{
-		*mapping_index += 2;
+	if (!graph_is_interesting(commit))
 		return;
-	}
 
 	/*
 	 * If the commit is already in the new_columns list, we don't need to
@@ -231,8 +242,8 @@ static void graph_update_width(struct git_graph *graph,
 	int max_cols = graph->num_columns + graph->num_parents;
 
 	/*
-	 * Even if the current commit has no parents, it still takes up a
-	 * column for itself.
+	 * Even if the current commit has no parents to be printed, it
+	 * still takes up a column for itself.
 	 */
 	if (graph->num_parents < 1)
 		max_cols++;
@@ -316,6 +327,7 @@ static void graph_update_columns(struct git_graph *graph)
 		}
 
 		if (col_commit == graph->commit) {
+			int old_mapping_idx = mapping_idx;
 			seen_this = 1;
 			for (parent = graph->commit->parents;
 			     parent;
@@ -324,6 +336,14 @@ static void graph_update_columns(struct git_graph *graph)
 							      parent->item,
 							      &mapping_idx);
 			}
+			/*
+			 * We always need to increment mapping_idx by at
+			 * least 2, even if it has no interesting parents.
+			 * The current commit always takes up at least 2
+			 * spaces.
+			 */
+			if (mapping_idx == old_mapping_idx)
+				mapping_idx += 2;
 		} else {
 			graph_insert_into_new_columns(graph, col_commit,
 						      &mapping_idx);
@@ -353,11 +373,13 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	graph->commit = commit;
 
 	/*
-	 * Count how many parents this commit has
+	 * Count how many interesting parents this commit has
 	 */
 	graph->num_parents = 0;
-	for (parent = commit->parents; parent; parent = parent->next)
-		graph->num_parents++;
+	for (parent = commit->parents; parent; parent = parent->next) {
+		if (graph_is_interesting(parent->item))
+			graph->num_parents++;
+	}
 
 	/*
 	 * Call graph_update_columns() to update
@@ -543,6 +565,15 @@ void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 
 		if (col_commit == graph->commit) {
 			seen_this = 1;
+			/*
+			 * If the commit has more than 1 interesting
+			 * parent, print 'M' to indicate that it is a
+			 * merge.  Otherwise, print '*'.
+			 *
+			 * Note that even if this is actually a merge
+			 * commit, we still print '*' if less than 2 of its
+			 * parents are interesting.
+			 */
 			if (graph->num_parents > 1)
 				strbuf_addch(sb, 'M');
 			else
-- 
1.5.5.1.359.gebc23.dirty
