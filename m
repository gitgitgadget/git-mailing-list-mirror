From: Josef Kufner <josef@kufner.cz>
Subject: [PATCH 1/3] pretty: Pass graph width to pretty formatting for use in '%>|(N)'
Date: Sat, 12 Sep 2015 01:25:11 +0200
Message-ID: <1442013913-2970-1-git-send-email-josef@kufner.cz>
References: <xmqqk2rwzlhi.fsf@gitster.mtv.corp.google.com>
Cc: git@vger.kernel.org, josef@kufner.cz, sunshine@sunshineco.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 12 01:25:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaXhL-0007ZK-QN
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 01:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbbIKXZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 19:25:30 -0400
Received: from ip-94-112-209-113.net.upcbroadband.cz ([94.112.209.113]:41422
	"EHLO delfinek.frozen-doe.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754002AbbIKXZ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2015 19:25:29 -0400
Received: by delfinek.frozen-doe.net (Postfix, from userid 1000)
	id 55544C53B3B; Sat, 12 Sep 2015 01:25:26 +0200 (CEST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <xmqqk2rwzlhi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277710>

Pass graph width to pretty formatting, so N in '%>|(N)' includes columns
consumed by graph rendered when --graph option is in use.

Example:
  git log --all --graph --pretty='format: [%>|(20)%h] %ar%d'

  All commit hashes should be aligned at 20th column from edge of the
  terminal, not from the edge of the graph.

Signed-off-by: Josef Kufner <josef@kufner.cz>
---
 commit.h   | 1 +
 graph.c    | 7 +++++++
 graph.h    | 5 +++++
 log-tree.c | 2 ++
 pretty.c   | 1 +
 5 files changed, 16 insertions(+)

diff --git a/commit.h b/commit.h
index 5d58be0..0a9a707 100644
--- a/commit.h
+++ b/commit.h
@@ -160,6 +160,7 @@ struct pretty_print_context {
 	 * should not be counted on by callers.
 	 */
 	struct string_list in_body_headers;
+	int graph_width;
 };
 
 struct userformat_want {
diff --git a/graph.c b/graph.c
index c25a09a..4802411 100644
--- a/graph.c
+++ b/graph.c
@@ -671,6 +671,13 @@ static void graph_output_padding_line(struct git_graph *graph,
 	graph_pad_horizontally(graph, sb, graph->num_new_columns * 2);
 }
 
+
+int graph_width(struct git_graph *graph)
+{
+	return graph->width;
+}
+
+
 static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
 {
 	/*
diff --git a/graph.h b/graph.h
index 0be62bd..3f48c19 100644
--- a/graph.h
+++ b/graph.h
@@ -68,6 +68,11 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb);
 
 
 /*
+ * Return current width of the graph in on-screen characters.
+ */
+int graph_width(struct git_graph *graph);
+
+/*
  * graph_show_*: helper functions for printing to stdout
  */
 
diff --git a/log-tree.c b/log-tree.c
index 7b1b57a..08fd5b6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -686,6 +686,8 @@ void show_log(struct rev_info *opt)
 	ctx.output_encoding = get_log_output_encoding();
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident = &opt->from_ident;
+	if (opt->graph)
+		ctx.graph_width = graph_width(opt->graph);
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/pretty.c b/pretty.c
index 151c2ae..f1cf9e2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1297,6 +1297,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 		if (!start)
 			start = sb->buf;
 		occupied = utf8_strnwidth(start, -1, 1);
+		occupied += c->pretty_ctx->graph_width;
 		padding = (-padding) - occupied;
 	}
 	while (1) {
-- 
2.5.1
