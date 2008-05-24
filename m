From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 1/2] Fix output of "git log --graph --boundary"
Date: Sat, 24 May 2008 16:02:04 -0700
Message-ID: <1211670125-10215-2-git-send-email-adam@adamsimpkins.net>
References: <1211670125-10215-1-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 25 01:03:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K02la-0006Ow-7u
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 01:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbYEXXCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 19:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYEXXCK
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 19:02:10 -0400
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:47919 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbYEXXCI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 19:02:08 -0400
Received: from relay3.r3.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay3.r3.iad.emailsrvr.com (SMTP Server) with ESMTP id 1449744C110;
	Sat, 24 May 2008 19:02:07 -0400 (EDT)
Received: by relay3.r3.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id B6AF244C089;
	Sat, 24 May 2008 19:02:06 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id BB1BA14100C7; Sat, 24 May 2008 16:02:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.389.g35a9d
In-Reply-To: <1211670125-10215-1-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82837>

Previously the graphing API wasn't aware of the revs->boundary flag, and
it always assumed that commits marked UNINTERESTING would not be
displayed.  As a result, the boundary commits were printed at the end of
the log output, but they didn't have any branch lines connecting them to
their children in the graph.

There was also another bug in the get_revision() code that caused
graph_update() to be called twice on the first boundary commit.  This
caused the graph API to think that a commit had been skipped, and print
a "..." line in the output.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 graph.c    |   94 ++++++++++++++++++++++++++++++++++++++++++------------------
 revision.c |    2 +-
 2 files changed, 67 insertions(+), 29 deletions(-)

diff --git a/graph.c b/graph.c
index 479035d..ce1abc0 100644
--- a/graph.c
+++ b/graph.c
@@ -191,9 +191,26 @@ static void graph_ensure_capacity(struct git_graph *graph, int num_columns)
  * Returns 1 if the commit will be printed in the graph output,
  * and 0 otherwise.
  */
-static int graph_is_interesting(struct commit *commit)
+static int graph_is_interesting(struct git_graph *graph, struct commit *commit)
 {
 	/*
+	 * If revs->boundary is set, commits whose children have
+	 * been shown are always interesting, even if they have the
+	 * UNINTERESTING or TREESAME flags set.
+	 *
+	 * However, ignore the commit if SHOWN is set.  If SHOWN is set,
+	 * the commit is interesting, but it has already been printed.
+	 * This can happen because get_revision() doesn't return the
+	 * boundary commits in topological order, even when
+	 * revs->topo_order is set.
+	 */
+	if (graph->revs && graph->revs->boundary) {
+		if ((commit->object.flags & (SHOWN | CHILD_SHOWN)) ==
+		    CHILD_SHOWN)
+			return 1;
+	}
+
+	/*
 	 * Uninteresting and pruned commits won't be printed
 	 */
 	return (commit->object.flags & (UNINTERESTING | TREESAME)) ? 0 : 1;
@@ -208,7 +225,7 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	/*
 	 * Ignore uinteresting commits
 	 */
-	if (!graph_is_interesting(commit))
+	if (!graph_is_interesting(graph, commit))
 		return;
 
 	/*
@@ -382,7 +399,7 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 */
 	graph->num_parents = 0;
 	for (parent = commit->parents; parent; parent = parent->next) {
-		if (graph_is_interesting(parent->item))
+		if (graph_is_interesting(graph, parent->item))
 			graph->num_parents++;
 	}
 
@@ -545,6 +562,51 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		graph->state = GRAPH_COMMIT;
 }
 
+static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
+{
+	/*
+	 * For boundary commits, print 'o'
+	 * (We should only see boundary commits when revs->boundary is set.)
+	 */
+	if (graph->commit->object.flags & BOUNDARY) {
+		assert(graph->revs->boundary);
+		strbuf_addch(sb, 'o');
+		return;
+	}
+
+	/*
+	 * If revs->left_right is set, print '<' for commits that
+	 * come from the left side, and '>' for commits from the right
+	 * side.
+	 */
+	if (graph->revs && graph->revs->left_right) {
+		if (graph->commit->object.flags & SYMMETRIC_LEFT)
+			strbuf_addch(sb, '<');
+		else
+			strbuf_addch(sb, '>');
+		return;
+	}
+
+	/*
+	 * Print 'M' for merge commits
+	 *
+	 * Note that we don't check graph->num_parents to determine if the
+	 * commit is a merge, since that only tracks the number of
+	 * "interesting" parents.  We want to print 'M' for merge commits
+	 * even if they have less than 2 interesting parents.
+	 */
+	if (graph->commit->parents != NULL &&
+	    graph->commit->parents->next != NULL) {
+		strbuf_addch(sb, 'M');
+		return;
+	}
+
+	/*
+	 * Print '*' in all other cases
+	 */
+	strbuf_addch(sb, '*');
+}
+
 void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int seen_this = 0;
@@ -570,31 +632,7 @@ void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 
 		if (col_commit == graph->commit) {
 			seen_this = 1;
-			/*
-			 * If revs->left_right is set, print the '<' or '>'
-			 * depending on which side this commit came from.
-			 *
-			 * If revs->left_right is not set and the commit is
-			 * a merge, print 'M'.  Otherwise, print '*'.
-			 *
-			 * Note that we don't check graph->num_parents to
-			 * determine if the commit is a merge, since that
-			 * only tracks the number of "interesting" parents.
-			 * We want to print 'M' for merge commits even if
-			 * they have less than 2 interesting parents.
-			 */
-			if (graph->revs && graph->revs->left_right) {
-				if (graph->commit->object.flags
-						& SYMMETRIC_LEFT)
-					strbuf_addch(sb, '<');
-				else
-					strbuf_addch(sb, '>');
-			}
-			else if (graph->commit->parents != NULL &&
-				 graph->commit->parents->next != NULL)
-				strbuf_addch(sb, 'M');
-			else
-				strbuf_addch(sb, '*');
+			graph_output_commit_char(graph, sb);
 
 			if (graph->num_parents < 2)
 				strbuf_addch(sb, ' ');
diff --git a/revision.c b/revision.c
index 1341f3d..181fb0b 100644
--- a/revision.c
+++ b/revision.c
@@ -1697,7 +1697,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 		 * switch to boundary commits output mode.
 		 */
 		revs->boundary = 2;
-		return get_revision(revs);
+		return get_revision_internal(revs);
 	}
 
 	/*
-- 
1.5.5.1.389.g35a9d
