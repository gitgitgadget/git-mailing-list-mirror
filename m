From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 4/4] git log: Updated --graph to work even when the commit list is pruned
Date: Sun,  6 Apr 2008 11:42:11 -0700
Message-ID: <1207507332-1866-4-git-send-email-adam@adamsimpkins.net>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
 <1207507332-1866-2-git-send-email-adam@adamsimpkins.net>
 <1207507332-1866-3-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 20:43:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiZpY-0004Dg-Tb
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 20:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbYDFSmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 14:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbYDFSmP
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 14:42:15 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:56652 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbYDFSmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 14:42:14 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 90FB11B417B;
	Sun,  6 Apr 2008 14:42:13 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 3C5401B4177;
	Sun,  6 Apr 2008 14:42:13 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 2AFB214100BE; Sun,  6 Apr 2008 11:42:12 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207507332-1866-3-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78909>

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 graph.c    |   22 +++++++++++++++-------
 revision.c |    3 ---
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/graph.c b/graph.c
index e6d1d3a..be4000f 100644
--- a/graph.c
+++ b/graph.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "commit.h"
 #include "graph.h"
+#include "diff.h"
+#include "revision.h"
 
 /*
  * TODO:
@@ -174,17 +176,24 @@ static void graph_ensure_capacity(struct git_graph *graph, int num_columns)
 
 static void graph_insert_into_new_columns(struct git_graph *graph,
 					  struct commit *commit,
-					  int mapping_index)
+					  int *mapping_index)
 {
 	int i;
 
 	/*
+	 * Ignore uinteresting and pruned commits
+	 */
+	if (commit->object.flags & (UNINTERESTING | TREESAME))
+		return;
+
+	/*
 	 * If the commit is already in the new_columns list, we don't need to
 	 * add it.  Just update the mapping correctly.
 	 */
 	for (i = 0; i < graph->num_new_columns; ++i) {
 		if (graph->new_columns[i].commit == commit) {
-			graph->mapping[mapping_index] = i;
+			graph->mapping[*mapping_index] = i;
+			*mapping_index += 2;
 			return;
 		}
 	}
@@ -193,7 +202,8 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	 * This commit isn't already in new_columns.  Add it.
 	 */
 	graph->new_columns[graph->num_new_columns].commit = commit;
-	graph->mapping[mapping_index] = graph->num_new_columns;
+	graph->mapping[*mapping_index] = graph->num_new_columns;
+	*mapping_index += 2;
 	++graph->num_new_columns;
 }
 
@@ -266,13 +276,11 @@ static void graph_update_columns(struct git_graph *graph)
 			     parent = parent->next) {
 				graph_insert_into_new_columns(graph,
 							      parent->item,
-							      mapping_idx);
-				mapping_idx += 2;
+							      &mapping_idx);
 			}
 		} else {
 			graph_insert_into_new_columns(graph, col_commit,
-						      mapping_idx);
-			mapping_idx += 2;
+						      &mapping_idx);
 		}
 	}
 
diff --git a/revision.c b/revision.c
index 6c9622c..6a1f513 100644
--- a/revision.c
+++ b/revision.c
@@ -1410,9 +1410,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (revs->reflog_info && revs->graph)
 		die("cannot combine --walk-reflogs with --graph");
 
-	if (revs->graph && revs->prune_data)
-		die("cannot use --graph when pruning commit list");
-
 	return left;
 }
 
-- 
1.5.3.6
