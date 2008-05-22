From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] log --graph: draw '>' and '<' with --left-right
Date: Thu, 22 May 2008 12:36:20 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805221235430.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Thu May 22 13:37:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz96c-0000Zp-QO
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 13:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757617AbYEVLgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 07:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757238AbYEVLgM
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 07:36:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:41253 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757332AbYEVLgK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 07:36:10 -0400
Received: (qmail invoked by alias); 22 May 2008 11:36:09 -0000
Received: from R5e98.r.pppool.de (EHLO racer.local) [89.54.94.152]
  by mail.gmx.net (mp037) with SMTP; 22 May 2008 13:36:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/W59wAXF3Wp/w6xtgCD/gk4CHF+kfD5nbuhCbBO0
	u6OIz7cJUWY19V
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82614>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-history-graph.txt |    2 +-
 graph.c                                       |   16 ++++++++++++++--
 graph.h                                       |    2 +-
 revision.c                                    |    2 +-
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/api-history-graph.txt b/Documentation/technical/api-history-graph.txt
index ce1c08e..e955979 100644
--- a/Documentation/technical/api-history-graph.txt
+++ b/Documentation/technical/api-history-graph.txt
@@ -115,7 +115,7 @@ Sample usage
 
 ------------
 struct commit *commit;
-struct git_graph *graph = graph_init();
+struct git_graph *graph = graph_init(opts);
 
 while ((commit = get_revision(opts)) != NULL) {
 	graph_update(graph, commit);
diff --git a/graph.c b/graph.c
index 9d6ed30..85a9ba0 100644
--- a/graph.c
+++ b/graph.c
@@ -55,6 +55,10 @@ struct git_graph {
 	 */
 	struct commit *commit;
 	/*
+	 * For the --left-right option.
+	 */
+	struct rev_info *revs;
+	/*
 	 * The number of parents this commit has.
 	 * (Stored so we don't have to walk over them each time we need
 	 * this number)
@@ -125,10 +129,11 @@ struct git_graph {
 	int *new_mapping;
 };
 
-struct git_graph *graph_init(void)
+struct git_graph *graph_init(struct rev_info *opt)
 {
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
 	graph->commit = NULL;
+	graph->revs = opt;
 	graph->num_parents = 0;
 	graph->expansion_row = 0;
 	graph->state = GRAPH_PADDING;
@@ -540,7 +545,14 @@ void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 
 		if (col_commit == graph->commit) {
 			seen_this = 1;
-			if (graph->num_parents > 1)
+			if (graph->revs && graph->revs->left_right) {
+				if (graph->commit->object.flags
+						& SYMMETRIC_LEFT)
+					strbuf_addch(sb, '<');
+				else
+					strbuf_addch(sb, '>');
+			}
+			else if (graph->num_parents > 1)
 				strbuf_addch(sb, 'M');
 			else
 				strbuf_addch(sb, '*');
diff --git a/graph.h b/graph.h
index a7748a5..eab4e3d 100644
--- a/graph.h
+++ b/graph.h
@@ -8,7 +8,7 @@ struct git_graph;
  * Create a new struct git_graph.
  * The graph should be freed with graph_release() when no longer needed.
  */
-struct git_graph *graph_init();
+struct git_graph *graph_init(struct rev_info *opt);
 
 /*
  * Destroy a struct git_graph and free associated memory.
diff --git a/revision.c b/revision.c
index 39ceef0..ce0f1ac 100644
--- a/revision.c
+++ b/revision.c
@@ -1206,7 +1206,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			if (!prefixcmp(arg, "--graph")) {
 				revs->topo_order = 1;
 				revs->rewrite_parents = 1;
-				revs->graph = graph_init();
+				revs->graph = graph_init(revs);
 				continue;
 			}
 			if (!strcmp(arg, "--root")) {
-- 
1.5.5.1.498.gaaa3c0
