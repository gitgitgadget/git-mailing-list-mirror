From: Johan Herland <johan@herland.net>
Subject: [CGit RFC/PATCH 3/5] ui-log: Refactor display of commit messages
Date: Tue, 13 Jul 2010 23:40:19 +0200
Message-ID: <1279057221-28036-4-git-send-email-johan@herland.net>
References: <1279056219-27096-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 23:40:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYnDX-0004Or-Ue
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 23:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266Ab0GMVkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 17:40:41 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64044 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756556Ab0GMVki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 17:40:38 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00AULMVOA660@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:40:36 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 079611EA5BC6_C3CDD54B	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:40:36 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 79C441EA3594_C3CDD53F	for <git@vger.kernel.org>; Tue,
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150923>

Split new function print_commit_line() out of print_commit(). The new
function only prints the initial table cells containing commit metadata,
i.e. the commit subject, author and date (and file/line-count if enabled).

The printing of the rest of the commit message (when showmsg is enabled)
is still performed in print_commit(), but is slightly changed to use
additional newlines to achieve the vertical margins that were previously
implemented with CSS. This is in preparation for the commit graph which
will be printed to the left of the commit message as part of the same
table row, and therefore needs to minimize margins that would otherwise
cause ugly gaps in the graph.

Signed-off-by: Johan Herland <johan@herland.net>
---
 cgit.css |    2 +-
 ui-log.c |   38 +++++++++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/cgit.css b/cgit.css
index 6e47eb3..78f654e 100644
--- a/cgit.css
+++ b/cgit.css
@@ -161,7 +161,7 @@ table.list td.logsubject {
 table.list td.logmsg {
 	font-family: monospace;
 	white-space: pre;
-	padding: 1em 0.5em 2em 0.5em;
+	padding: 0 0.5em;
 }
 
 table.list td a {
diff --git a/ui-log.c b/ui-log.c
index 390c38b..2cd0f19 100644
--- a/ui-log.c
+++ b/ui-log.c
@@ -75,14 +75,10 @@ void show_commit_decorations(struct commit *commit)
 	}
 }
 
-void print_commit(struct commit *commit)
+static void print_commit_line(struct commit *commit, struct commitinfo *info)
 {
-	struct commitinfo *info;
 	char *tmp;
-	int cols = 3;
 
-	info = cgit_parse_commit(commit);
-	htmlf("<tr%s>", ctx.qry.showmsg ? " class='logheader'" : "");
 	htmlf("<td%s>", ctx.qry.showmsg ? " class='logsubject'" : "");
 	cgit_commit_link(info->subject, NULL, NULL, ctx.qry.head,
 			 sha1_to_hex(commit->object.sha1), ctx.qry.vpath, 0);
@@ -107,18 +103,34 @@ void print_commit(struct commit *commit)
 			htmlf("-%d/+%d", rem_lines, add_lines);
 		}
 	}
-	html("</td></tr>\n");
-	if (ctx.qry.showmsg) {
-		if (ctx.repo->enable_log_filecount) {
+	html("</td>");
+}
+
+void print_commit(struct commit *commit)
+{
+	struct commitinfo *info = cgit_parse_commit(commit);
+	int cols = 3;
+
+	if (ctx.repo->enable_log_filecount) {
+		cols++;
+		if (ctx.repo->enable_log_linecount)
 			cols++;
-			if (ctx.repo->enable_log_linecount)
-				cols++;
+	}
+
+	htmlf("<tr%s>", ctx.qry.showmsg ? " class='logheader'" : "");
+	print_commit_line(commit, info);
+	html("</tr>\n");
+
+	if (ctx.qry.showmsg) {
+		html("<tr class='nohover'>");
+		htmlf("<td colspan='%d' class='logmsg'>\n", cols);
+		if (*(info->msg)) {
+			html_txt(info->msg);
+			html("\n\n");
 		}
-		htmlf("<tr class='nohover'><td colspan='%d' class='logmsg'>",
-			cols);
-		html_txt(info->msg);
 		html("</td></tr>\n");
 	}
+
 	cgit_free_commitinfo(info);
 }
 
-- 
1.7.0.4
