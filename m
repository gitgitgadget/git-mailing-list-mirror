From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH] graph API: improve output for merge commits (option 2)
Date: Thu, 29 May 2008 02:04:16 -0700
Message-ID: <1212051856-32138-1-git-send-email-adam@adamsimpkins.net>
References: <20080529085752.GA31865@adamsimpkins.net>
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 11:06:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1e52-00015Q-Q0
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 11:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbYE2JEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 05:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755320AbYE2JET
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 05:04:19 -0400
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:57812 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbYE2JES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 05:04:18 -0400
Received: from relay1.r1.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay1.r1.iad.emailsrvr.com (SMTP Server) with ESMTP id 343D344C0C0;
	Thu, 29 May 2008 05:04:18 -0400 (EDT)
Received: by relay1.r1.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 09AA044C033;
	Thu, 29 May 2008 05:04:18 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id C1F1A14100CA; Thu, 29 May 2008 02:04:16 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc0.46.gd2b3.dirty
In-Reply-To: <20080529085752.GA31865@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83184>

This eliminates the extra space that sometimes appeared in branch lines
to the right of 2-way merge commits.  (It appeared when the branch line was
displayed as '\' on the line just before the merge commit.)

For example,

| |\
| M  \
| |\  |

is now displayed as

| |\
| M |
| |\ \

The output for octopus merges was also updated to be more
similar to that for 2-way merges.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 graph.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/graph.c b/graph.c
index 26b8c52..92f5b1a 100644
--- a/graph.c
+++ b/graph.c
@@ -535,7 +535,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		if (col->commit == graph->commit) {
 			seen_this = 1;
 			strbuf_addf(sb, "| %*s", graph->expansion_row, "");
-		} else if (seen_this) {
+		} else if (seen_this && (graph->expansion_row > 0)) {
 			strbuf_addstr(sb, "\\ ");
 		} else {
 			strbuf_addstr(sb, "| ");
@@ -625,10 +625,8 @@ void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
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
@@ -636,7 +634,7 @@ void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 					strbuf_addch(sb, '-');
 				strbuf_addstr(sb, ". ");
 			}
-		} else if (seen_this && (graph->num_parents > 1)) {
+		} else if (seen_this && (graph->num_parents > 2)) {
 			strbuf_addstr(sb, "\\ ");
 		} else {
 			strbuf_addstr(sb, "| ");
@@ -679,9 +677,7 @@ void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
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
-- 
1.5.6.rc0.46.gd2b3.dirty
