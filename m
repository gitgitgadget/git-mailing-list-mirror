From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH] graph API: fix "git log --graph --first-parent"
Date: Thu,  5 Jun 2008 01:56:19 -0700
Message-ID: <1212656179-13637-1-git-send-email-adam@adamsimpkins.net>
References: <20080604180432.GA31437@adamsimpkins.net>
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 10:57:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4BHg-000600-Uz
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 10:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbYFEI4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 04:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbYFEI4c
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 04:56:32 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:33700 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbYFEI4b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 04:56:31 -0400
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 8EA6A76ECD6;
	Thu,  5 Jun 2008 04:56:30 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 4EC3376E9B8;
	Thu,  5 Jun 2008 04:56:30 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 977F714100CC; Thu,  5 Jun 2008 01:56:19 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc1.14.g4936c
In-Reply-To: <20080604180432.GA31437@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83884>

This change teaches the graph API that only the first parent of each
commit is interesting when "--first-parent" was specified.

This change also consolidates the graph parent walking logic into two
new internal functions, first_interesting_parent() and
next_interesting_parent().  A simpler fix would have been to simply
break at the end of the 2 existing for loops when
graph->revs->first_parent_only is set.  However, this change seems
nicer, especially if we ever need to add any new loops over the parent
list in the future.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 graph.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/graph.c b/graph.c
index edfab2d..283b137 100644
--- a/graph.c
+++ b/graph.c
@@ -237,6 +237,52 @@ static int graph_is_interesting(struct git_graph *graph, struct commit *commit)
 	return (commit->object.flags & (UNINTERESTING | TREESAME)) ? 0 : 1;
 }
 
+static struct commit_list *next_interesting_parent(struct git_graph *graph,
+						   struct commit_list *orig)
+{
+	struct commit_list *list;
+
+	/*
+	 * If revs->first_parent_only is set, only the first
+	 * parent is interesting.  None of the others are.
+	 */
+	if (graph->revs->first_parent_only)
+		return NULL;
+
+	/*
+	 * Return the next interesting commit after orig
+	 */
+	for (list = orig->next; list; list = list->next) {
+		if (graph_is_interesting(graph, list->item))
+			return list;
+	}
+
+	return NULL;
+}
+
+static struct commit_list *first_interesting_parent(struct git_graph *graph)
+{
+	struct commit_list *parents = graph->commit->parents;
+
+	/*
+	 * If this commit has no parents, ignore it
+	 */
+	if (!parents)
+		return NULL;
+
+	/*
+	 * If the first parent is interesting, return it
+	 */
+	if (graph_is_interesting(graph, parents->item))
+		return parents;
+
+	/*
+	 * Otherwise, call next_interesting_parent() to get
+	 * the next interesting parent
+	 */
+	return next_interesting_parent(graph, parents);
+}
+
 static void graph_insert_into_new_columns(struct git_graph *graph,
 					  struct commit *commit,
 					  int *mapping_index)
@@ -244,12 +290,6 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	int i;
 
 	/*
-	 * Ignore uinteresting commits
-	 */
-	if (!graph_is_interesting(graph, commit))
-		return;
-
-	/*
 	 * If the commit is already in the new_columns list, we don't need to
 	 * add it.  Just update the mapping correctly.
 	 */
@@ -373,9 +413,9 @@ static void graph_update_columns(struct git_graph *graph)
 			int old_mapping_idx = mapping_idx;
 			seen_this = 1;
 			graph->commit_index = i;
-			for (parent = graph->commit->parents;
+			for (parent = first_interesting_parent(graph);
 			     parent;
-			     parent = parent->next) {
+			     parent = next_interesting_parent(graph, parent)) {
 				graph_insert_into_new_columns(graph,
 							      parent->item,
 							      &mapping_idx);
@@ -420,9 +460,11 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 * Count how many interesting parents this commit has
 	 */
 	graph->num_parents = 0;
-	for (parent = commit->parents; parent; parent = parent->next) {
-		if (graph_is_interesting(graph, parent->item))
-			graph->num_parents++;
+	for (parent = first_interesting_parent(graph);
+	     parent;
+	     parent = next_interesting_parent(graph, parent))
+	{
+		graph->num_parents++;
 	}
 
 	/*
-- 
1.5.6.rc1.13.g14be6
