From: Johan Herland <johan@herland.net>
Subject: [CGit RFC/PATCH 5/5] ui-log: Colorize commit graph
Date: Tue, 13 Jul 2010 23:40:21 +0200
Message-ID: <1279057221-28036-6-git-send-email-johan@herland.net>
References: <1279056219-27096-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 23:41:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYnDs-0004WU-8A
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 23:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283Ab0GMVkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 17:40:43 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64044 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757277Ab0GMVkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 17:40:41 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00AV0MVOA660@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:40:36 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 51C0C1EA5BC7_C3CDD54B	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:40:36 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id A654C1EA3AE2_C3CDD53F	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:40:35 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00782MVL0N10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:40:35 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
In-reply-to: <1279056219-27096-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150925>

Use the existing coloring logic in Git's graph code to color the lines
between commits in the commit graph.

Whereas Git normally uses ANSI color escapes to produce colors, we here
use graph_set_column_colors() to replace those with "HTML color escapes"
which embed the graph lines in <span> tags that apply the desired color
using CSS.

Signed-off-by: Johan Herland <johan@herland.net>
---
 cgit.css |   24 ++++++++++++++++++++++++
 ui-log.c |   29 ++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/cgit.css b/cgit.css
index 65da960..e8be2b1 100644
--- a/cgit.css
+++ b/cgit.css
@@ -158,6 +158,30 @@ table.list td.commitgraph {
 	white-space: pre;
 }
 
+table.list td.commitgraph .column1 {
+	color: #a00;
+}
+
+table.list td.commitgraph .column2 {
+	color: #0a0;
+}
+
+table.list td.commitgraph .column3 {
+	color: #aa0;
+}
+
+table.list td.commitgraph .column4 {
+	color: #00a;
+}
+
+table.list td.commitgraph .column5 {
+	color: #a0a;
+}
+
+table.list td.commitgraph .column6 {
+	color: #0aa;
+}
+
 table.list td.logsubject {
 	font-family: monospace;
 	font-weight: bold;
diff --git a/ui-log.c b/ui-log.c
index 3cfe3f9..2fc8c7b 100644
--- a/ui-log.c
+++ b/ui-log.c
@@ -12,6 +12,21 @@
 
 int files, add_lines, rem_lines;
 
+/*
+ * The list of available column colors in the commit graph.
+ */
+static const char *column_colors_html[] = {
+	"<span class='column1'>",
+	"<span class='column2'>",
+	"<span class='column3'>",
+	"<span class='column4'>",
+	"<span class='column5'>",
+	"<span class='column6'>",
+	"</span>",
+};
+
+#define COLUMN_COLORS_HTML_MAX (ARRAY_SIZE(column_colors_html) - 1)
+
 void count_lines(char *line, int size)
 {
 	if (size <= 0)
@@ -123,14 +138,14 @@ void print_commit(struct commit *commit, struct rev_info *revs)
 		while (!graph_next_line(revs->graph, &msgbuf)) {
 			/* Create graph line + empty table row */
 			html("<tr class='nohover'><td class='commitgraph'>");
-			html_txt(msgbuf.buf);
+			html(msgbuf.buf);
 			htmlf("</td><td colspan='%d' /></tr>\n", cols);
 			strbuf_setlen(&msgbuf, 0);
 		}
 		/* Create graph line + commit info table row */
 		htmlf("<tr%s>", ctx.qry.showmsg ? " class='logheader'" : "");
 		html("<td class='commitgraph'>");
-		html_txt(msgbuf.buf);
+		html(msgbuf.buf);
 		html("</td>");
 	        strbuf_release(&msgbuf);
 	}
@@ -162,7 +177,7 @@ void print_commit(struct commit *commit, struct rev_info *revs)
 				html("\n");
 			strbuf_setlen(&msgbuf, 0);
 			graph_next_line(revs->graph, &msgbuf);
-			html_txt(msgbuf.buf);
+			html(msgbuf.buf);
 			lines--;
 		}
 
@@ -205,7 +220,7 @@ void cgit_print_log(const char *tip, int ofs, int cnt, char *grep, char *pattern
 {
 	struct rev_info rev;
 	struct commit *commit;
-	const char *argv[] = {NULL, NULL, NULL, NULL, NULL, NULL};
+	const char *argv[] = {NULL, NULL, NULL, NULL, NULL, NULL, NULL};
 	int argc = 2;
 	int i, columns = 3;
 
@@ -221,8 +236,12 @@ void cgit_print_log(const char *tip, int ofs, int cnt, char *grep, char *pattern
 		if (!strcmp(grep, "range"))
 			argv[1] = pattern;
 	}
-	if (ctx.repo->enable_commit_graph)
+	if (ctx.repo->enable_commit_graph) {
 		argv[argc++] = "--graph";
+		argv[argc++] = "--color";
+		graph_set_column_colors(column_colors_html,
+					COLUMN_COLORS_HTML_MAX);
+	}
 
 	if (path) {
 		argv[argc++] = "--";
-- 
1.7.0.4
