From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 2/2] graph API: avoid printing unnecessary padding before some octopus merges
Date: Sun,  1 Jun 2008 13:56:58 -0700
Message-ID: <1212353818-7031-3-git-send-email-adam@adamsimpkins.net>
References: <20080529085752.GA31865@adamsimpkins.net>
 <1212353818-7031-1-git-send-email-adam@adamsimpkins.net>
 <1212353818-7031-2-git-send-email-adam@adamsimpkins.net>
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 22:58:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2ucm-0004dG-LQ
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 22:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbYFAU5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 16:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbYFAU5C
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 16:57:02 -0400
Received: from smtp202.sat.emailsrvr.com ([66.216.121.202]:40450 "EHLO
	smtp202.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbYFAU5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 16:57:01 -0400
Received: from relay10.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 749391B40CC;
	Sun,  1 Jun 2008 16:57:00 -0400 (EDT)
Received: by relay10.relay.sat.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 455E41B408D;
	Sun,  1 Jun 2008 16:57:00 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id C137714100CB; Sun,  1 Jun 2008 13:56:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc0.54.g04bfd
In-Reply-To: <1212353818-7031-2-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83467>

When an octopus merge is printed, several lines are printed before it to
move over existing branch lines to its right.  This is needed to make
room for the children of the octopus merge.  For example:

| | | |
| |  \ \
| |   \ \
| |    \ \
| M---. \ \
| |\ \ \ \ \

However, this step isn't necessary if there are no branch lines to the
right of the octopus merge.  Therefore, skip this step when it is not
needed, to avoid printing extra lines that don't really serve any
purpose.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 graph.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/graph.c b/graph.c
index 332d1e8..0531716 100644
--- a/graph.c
+++ b/graph.c
@@ -450,16 +450,18 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 * it never finished its output.  Goto GRAPH_SKIP, to print out
 	 * a line to indicate that portion of the graph is missing.
 	 *
-	 * Otherwise, if there are 3 or more parents, we need to print
-	 * extra rows before the commit, to expand the branch lines around
-	 * it and make room for it.
+	 * If there are 3 or more parents, we may need to print extra rows
+	 * before the commit, to expand the branch lines around it and make
+	 * room for it.  We need to do this unless there aren't any branch
+	 * rows to the right of this commit.
 	 *
 	 * If there are less than 3 parents, we can immediately print the
 	 * commit line.
 	 */
 	if (graph->state != GRAPH_PADDING)
 		graph->state = GRAPH_SKIP;
-	else if (graph->num_parents >= 3)
+	else if (graph->num_parents >= 3 &&
+		 graph->commit_index < (graph->num_columns - 1))
 		graph->state = GRAPH_PRE_COMMIT;
 	else
 		graph->state = GRAPH_COMMIT;
@@ -538,7 +540,8 @@ static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
 	strbuf_addstr(sb, "...");
 	graph_pad_horizontally(graph, sb);
 
-	if (graph->num_parents >= 3)
+	if (graph->num_parents >= 3 &&
+	    graph->commit_index < (graph->num_columns - 1))
 		graph_update_state(graph, GRAPH_PRE_COMMIT);
 	else
 		graph_update_state(graph, GRAPH_COMMIT);
-- 
1.5.6.rc0.54.g04bfd
