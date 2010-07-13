From: Johan Herland <johan@herland.net>
Subject: [CGit RFC/PATCH 4/5] ui-log: Implement support for commit graphs
Date: Tue, 13 Jul 2010 23:40:20 +0200
Message-ID: <1279057221-28036-5-git-send-email-johan@herland.net>
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
	id 1OYnDt-0004WU-W0
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 23:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293Ab0GMVkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 17:40:47 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64044 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756977Ab0GMVkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 17:40:39 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00AUPMVOA660@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:40:36 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 13F231EA5BA0_C3CDD54B	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:40:36 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 935CA1EA3AD7_C3CDD53F	for <git@vger.kernel.org>; Tue,
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150927>

Teach CGit to print an ASCII art commit graph to the left of the commit
message, similar to 'git log --graph'. The graph adds extra lines (table
rows) to the log when needed to add/remove/shuffle edges in the graph.

When 'showmsg' is enabled, the graph auto-adjusts to the lines added by
the commit message.

This feature is controlled by a new config variable: "enable-commit-graph"
(disabled by default), and individual repos can disable it by settign
"repo.enable-commit-graph" to "0".

Signed-off-by: Johan Herland <johan@herland.net>
---
 cgit.c       |    6 +++++
 cgit.css     |    5 ++++
 cgit.h       |    3 ++
 cgitrc.5.txt |   15 +++++++++++-
 shared.c     |    1 +
 ui-log.c     |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 94 insertions(+), 7 deletions(-)

diff --git a/cgit.c b/cgit.c
index ab25b6a..29fb57f 100644
--- a/cgit.c
+++ b/cgit.c
@@ -56,6 +56,8 @@ void repo_config(struct cgit_repo *repo, const char *name, const char *value)
 		repo->defbranch = xstrdup(value);
 	else if (!strcmp(name, "snapshots"))
 		repo->snapshots = ctx.cfg.snapshots & cgit_parse_snapshots_mask(value);
+	else if (!strcmp(name, "enable-commit-graph"))
+		repo->enable_commit_graph = ctx.cfg.enable_commit_graph * atoi(value);
 	else if (!strcmp(name, "enable-log-filecount"))
 		repo->enable_log_filecount = ctx.cfg.enable_log_filecount * atoi(value);
 	else if (!strcmp(name, "enable-log-linecount"))
@@ -137,6 +139,8 @@ void config_cb(const char *name, const char *value)
 		ctx.cfg.enable_filter_overrides = atoi(value);
 	else if (!strcmp(name, "enable-index-links"))
 		ctx.cfg.enable_index_links = atoi(value);
+	else if (!strcmp(name, "enable-commit-graph"))
+		ctx.cfg.enable_commit_graph = atoi(value);
 	else if (!strcmp(name, "enable-log-filecount"))
 		ctx.cfg.enable_log_filecount = atoi(value);
 	else if (!strcmp(name, "enable-log-linecount"))
@@ -522,6 +526,8 @@ void print_repo(FILE *f, struct cgit_repo *repo)
 		fprintf(f, "repo.section=%s\n", repo->section);
 	if (repo->clone_url)
 		fprintf(f, "repo.clone-url=%s\n", repo->clone_url);
+	fprintf(f, "repo.enable-commit-graph=%d\n",
+	        repo->enable_commit_graph);
 	fprintf(f, "repo.enable-log-filecount=%d\n",
 	        repo->enable_log_filecount);
 	fprintf(f, "repo.enable-log-linecount=%d\n",
diff --git a/cgit.css b/cgit.css
index 78f654e..65da960 100644
--- a/cgit.css
+++ b/cgit.css
@@ -153,6 +153,11 @@ table.list td {
 	padding: 0.1em 0.5em 0.1em 0.5em;
 }
 
+table.list td.commitgraph {
+	font-family: monospace;
+	white-space: pre;
+}
+
 table.list td.logsubject {
 	font-family: monospace;
 	font-weight: bold;
diff --git a/cgit.h b/cgit.h
index 2b28d63..402610b 100644
--- a/cgit.h
+++ b/cgit.h
@@ -19,6 +19,7 @@
 #include <xdiff-interface.h>
 #include <xdiff/xdiff.h>
 #include <utf8.h>
+#include <graph.h>
 
 
 /*
@@ -70,6 +71,7 @@ struct cgit_repo {
 	char *section;
 	char *clone_url;
 	int snapshots;
+	int enable_commit_graph;
 	int enable_log_filecount;
 	int enable_log_linecount;
 	int enable_remote_branches;
@@ -182,6 +184,7 @@ struct cgit_config {
 	int embedded;
 	int enable_filter_overrides;
 	int enable_index_links;
+	int enable_commit_graph;
 	int enable_log_filecount;
 	int enable_log_linecount;
 	int enable_remote_branches;
diff --git a/cgitrc.5.txt b/cgitrc.5.txt
index a853522..72fd2e1 100644
--- a/cgitrc.5.txt
+++ b/cgitrc.5.txt
@@ -90,7 +90,12 @@ embedded::
 	Flag which, when set to "1", will make cgit generate a html fragment
 	suitable for embedding in other html pages. Default value: none. See
 	also: "noheader".
-	
+
+enable-commit-graph::
+	Flag which, when set to "1", will make cgit print an ASCII-art commit
+	history graph to the left of the commit messages in the repository
+	log page. Default value: "0".
+
 enable-filter-overrides::
 	Flag which, when set to "1", allows all filter settings to be
 	overridden in repository-specific cgitrc files. Default value: none.
@@ -319,6 +324,10 @@ repo.defbranch::
 repo.desc::
 	The value to show as repository description. Default value: none.
 
+repo.enable-commit-graph::
+	A flag which can be used to disable the global setting
+	`enable-commit-graph'. Default value: none.
+
 repo.enable-log-filecount::
 	A flag which can be used to disable the global setting
 	`enable-log-filecount'. Default value: none.
@@ -404,6 +413,10 @@ css=/css/cgit.css
 enable-index-links=1
 
 
+# Enable ASCII art commit history graph on the log pages
+enable-commit-graph=1
+
+
 # Show number of affected files per commit on the log pages
 enable-log-filecount=1
 
diff --git a/shared.c b/shared.c
index 06f70bb..9c00a7d 100644
--- a/shared.c
+++ b/shared.c
@@ -56,6 +56,7 @@ struct cgit_repo *cgit_add_repo(const char *url)
 	ret->section = ctx.cfg.section;
 	ret->defbranch = "master";
 	ret->snapshots = ctx.cfg.snapshots;
+	ret->enable_commit_graph = ctx.cfg.enable_commit_graph;
 	ret->enable_log_filecount = ctx.cfg.enable_log_filecount;
 	ret->enable_log_linecount = ctx.cfg.enable_log_linecount;
 	ret->enable_remote_branches = ctx.cfg.enable_remote_branches;
diff --git a/ui-log.c b/ui-log.c
index 2cd0f19..3cfe3f9 100644
--- a/ui-log.c
+++ b/ui-log.c
@@ -106,7 +106,7 @@ static void print_commit_line(struct commit *commit, struct commitinfo *info)
 	html("</td>");
 }
 
-void print_commit(struct commit *commit)
+void print_commit(struct commit *commit, struct rev_info *revs)
 {
 	struct commitinfo *info = cgit_parse_commit(commit);
 	int cols = 3;
@@ -117,11 +117,65 @@ void print_commit(struct commit *commit)
 			cols++;
 	}
 
-	htmlf("<tr%s>", ctx.qry.showmsg ? " class='logheader'" : "");
+	if (revs->graph) {
+		struct strbuf msgbuf = STRBUF_INIT;
+
+		while (!graph_next_line(revs->graph, &msgbuf)) {
+			/* Create graph line + empty table row */
+			html("<tr class='nohover'><td class='commitgraph'>");
+			html_txt(msgbuf.buf);
+			htmlf("</td><td colspan='%d' /></tr>\n", cols);
+			strbuf_setlen(&msgbuf, 0);
+		}
+		/* Create graph line + commit info table row */
+		htmlf("<tr%s>", ctx.qry.showmsg ? " class='logheader'" : "");
+		html("<td class='commitgraph'>");
+		html_txt(msgbuf.buf);
+		html("</td>");
+	        strbuf_release(&msgbuf);
+	}
+	else
+		htmlf("<tr%s>", ctx.qry.showmsg ? " class='logheader'" : "");
+
 	print_commit_line(commit, info);
 	html("</tr>\n");
 
-	if (ctx.qry.showmsg) {
+	if (revs->graph) {
+		struct strbuf msgbuf = STRBUF_INIT;
+		int lines = 0;
+
+		if (ctx.qry.showmsg) {
+			/* Count #lines in commit message */
+			lines = 1;
+			if (*(info->msg)) {
+				const char *p = info->msg;
+				lines += 3;
+				while ((p = strchr(p, '\n') + 1) > info->msg)
+					lines++;
+			}
+		}
+
+		/* Print graph padding */
+		html("<tr class='nohover'><td class='commitgraph'>");
+		while (lines > 0 || !graph_is_commit_finished(revs->graph)) {
+			if (msgbuf.len)
+				html("\n");
+			strbuf_setlen(&msgbuf, 0);
+			graph_next_line(revs->graph, &msgbuf);
+			html_txt(msgbuf.buf);
+			lines--;
+		}
+
+		/* Print remainder of table row */
+		htmlf("</td><td colspan='%d'%s>\n", cols,
+		      ctx.qry.showmsg ? " class='logmsg'" : "");
+		if (ctx.qry.showmsg && *(info->msg)) {
+			html_txt(info->msg);
+			html("\n\n");
+		}
+		html("</td></tr>\n");
+	}
+	else if (ctx.qry.showmsg) {
 		html("<tr class='nohover'>");
 		htmlf("<td colspan='%d' class='logmsg'>\n", cols);
 		if (*(info->msg)) {
@@ -151,7 +205,7 @@ void cgit_print_log(const char *tip, int ofs, int cnt, char *grep, char *pattern
 {
 	struct rev_info rev;
 	struct commit *commit;
-	const char *argv[] = {NULL, NULL, NULL, NULL, NULL};
+	const char *argv[] = {NULL, NULL, NULL, NULL, NULL, NULL};
 	int argc = 2;
 	int i, columns = 3;
 
@@ -167,6 +221,8 @@ void cgit_print_log(const char *tip, int ofs, int cnt, char *grep, char *pattern
 		if (!strcmp(grep, "range"))
 			argv[1] = pattern;
 	}
+	if (ctx.repo->enable_commit_graph)
+		argv[argc++] = "--graph";
 
 	if (path) {
 		argv[argc++] = "--";
@@ -187,7 +243,10 @@ void cgit_print_log(const char *tip, int ofs, int cnt, char *grep, char *pattern
 	if (pager)
 		html("<table class='list nowrap'>");
 
-	html("<tr class='nohover'><th class='left'>Commit message");
+	html("<tr class='nohover'>");
+	if (ctx.repo->enable_commit_graph)
+		html("<th></th>");
+	html("<th class='left'>Commit message");
 	if (pager) {
 		html(" (");
 		cgit_log_link(ctx.qry.showmsg ? "Collapse" : "Expand", NULL,
@@ -218,7 +277,7 @@ void cgit_print_log(const char *tip, int ofs, int cnt, char *grep, char *pattern
 	}
 
 	for (i = 0; i < cnt && (commit = get_revision(&rev)) != NULL; i++) {
-		print_commit(commit);
+		print_commit(commit, &rev);
 		free(commit->buffer);
 		commit->buffer = NULL;
 		free_commit_list(commit->parents);
-- 
1.7.0.4
