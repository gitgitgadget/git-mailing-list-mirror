From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 1/2] Remove dead code: show_log() sep argument and diff_options.msg_sep
Date: Tue, 29 Apr 2008 01:32:59 -0700
Message-ID: <1209457980-19677-1-git-send-email-adam@adamsimpkins.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 10:34:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqlHh-0004m6-LQ
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 10:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbYD2IdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 04:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbYD2IdI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 04:33:08 -0400
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:59851 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbYD2IdF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 04:33:05 -0400
Received: from relay1.r1.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay1.r1.iad.emailsrvr.com (SMTP Server) with ESMTP id 568A044C1CC;
	Tue, 29 Apr 2008 04:33:02 -0400 (EDT)
Received: by relay1.r1.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 0529244C0DD;
	Tue, 29 Apr 2008 04:33:02 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id CEFB214100C1; Tue, 29 Apr 2008 01:33:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80669>

These variables were made unnecessary by commit
3969cf7db1a13a78f3b7a36d8c1084bbe0a53459.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---

This is the first of two minor cleanup patches discussed in the thread
"entry terminator/separator behavior in show_log()"

 builtin-log.c  |    1 -
 combine-diff.c |    6 +++---
 diff.c         |    1 -
 diff.h         |    1 -
 log-tree.c     |   27 +++++++++------------------
 log-tree.h     |    2 +-
 6 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 1670d0b..256bbac 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -770,7 +770,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
-	rev.diffopt.msg_sep = "";
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
 	rev.subject_prefix = fmt_patch_subject_prefix;
diff --git a/combine-diff.c b/combine-diff.c
index f1e7a4d..41aaf83 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -798,7 +798,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		int deleted = 0;
 
 		if (rev->loginfo && !rev->no_commit_id)
-			show_log(rev, opt->msg_sep);
+			show_log(rev);
 		dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
 				 "", elem->path, c_meta, c_reset);
 		printf("%sindex ", c_meta);
@@ -881,7 +881,7 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 		inter_name_termination = 0;
 
 	if (rev->loginfo && !rev->no_commit_id)
-		show_log(rev, opt->msg_sep);
+		show_log(rev);
 
 	if (opt->output_format & DIFF_FORMAT_RAW) {
 		offset = strlen(COLONS) - num_parent;
@@ -962,7 +962,7 @@ void diff_tree_combined(const unsigned char *sha1,
 		paths = intersect_paths(paths, i, num_parent);
 
 		if (show_log_first && i == 0) {
-			show_log(rev, opt->msg_sep);
+			show_log(rev);
 			if (rev->verbose_header && opt->output_format)
 				putchar(opt->line_termination);
 		}
diff --git a/diff.c b/diff.c
index 3632b55..e35384b 100644
--- a/diff.c
+++ b/diff.c
@@ -2220,7 +2220,6 @@ void diff_setup(struct diff_options *options)
 	options->rename_limit = -1;
 	options->dirstat_percent = 3;
 	options->context = 3;
-	options->msg_sep = "";
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
diff --git a/diff.h b/diff.h
index f2c7739..1bd94a4 100644
--- a/diff.h
+++ b/diff.h
@@ -88,7 +88,6 @@ struct diff_options {
 	int abbrev;
 	const char *prefix;
 	int prefix_length;
-	const char *msg_sep;
 	const char *stat_sep;
 	long xdl_opts;
 
diff --git a/log-tree.c b/log-tree.c
index 8f5436b..4c7d7ef 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -208,14 +208,13 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 	*extra_headers_p = extra_headers;
 }
 
-void show_log(struct rev_info *opt, const char *sep)
+void show_log(struct rev_info *opt)
 {
 	struct strbuf msgbuf;
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev = opt->diffopt.abbrev;
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
-	const char *extra;
 	const char *subject = NULL, *extra_headers = opt->extra_headers;
 	int need_8bit_cte = 0;
 
@@ -240,17 +239,10 @@ void show_log(struct rev_info *opt, const char *sep)
 	}
 
 	/*
-	 * The "oneline" format has several special cases:
-	 *  - The pretty-printed commit lacks a newline at the end
-	 *    of the buffer, but we do want to make sure that we
-	 *    have a newline there. If the separator isn't already
-	 *    a newline, add an extra one.
-	 *  - unlike other log messages, the one-line format does
-	 *    not have an empty line between entries.
+	 * If use_terminator is set, add a newline at the end of the entry.
+	 * Otherwise, add a diffopt.line_termination character before all
+	 * entries but the first.  (IOW, as a separator between entries)
 	 */
-	extra = "";
-	if (*sep != '\n' && opt->use_terminator)
-		extra = "\n";
 	if (opt->shown_one && !opt->use_terminator)
 		putchar(opt->diffopt.line_termination);
 	opt->shown_one = 1;
@@ -292,10 +284,8 @@ void show_log(struct rev_info *opt, const char *sep)
 			show_reflog_message(opt->reflog_info,
 				    opt->commit_format == CMIT_FMT_ONELINE,
 				    opt->date_mode);
-			if (opt->commit_format == CMIT_FMT_ONELINE) {
-				printf("%s", sep);
+			if (opt->commit_format == CMIT_FMT_ONELINE)
 				return;
-			}
 		}
 	}
 
@@ -319,7 +309,8 @@ void show_log(struct rev_info *opt, const char *sep)
 
 	if (msgbuf.len) {
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
-		printf("%s%s", extra, sep);
+		if (opt->use_terminator)
+			putchar('\n');
 	}
 	strbuf_release(&msgbuf);
 }
@@ -342,7 +333,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 		 * an extra newline between the end of log and the
 		 * output for readability.
 		 */
-		show_log(opt, opt->diffopt.msg_sep);
+		show_log(opt);
 		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
 		    opt->verbose_header &&
 		    opt->commit_format != CMIT_FMT_ONELINE) {
@@ -430,7 +421,7 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	shown = log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
 		log.parent = NULL;
-		show_log(opt, "");
+		show_log(opt);
 		shown = 1;
 	}
 	opt->loginfo = NULL;
diff --git a/log-tree.h b/log-tree.h
index 8946ff3..59ba4c4 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -11,7 +11,7 @@ void init_log_tree_opt(struct rev_info *);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 int log_tree_opt_parse(struct rev_info *, const char **, int);
-void show_log(struct rev_info *opt, const char *sep);
+void show_log(struct rev_info *opt);
 void show_decorations(struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, const char *name,
 			     const char **subject_p,
-- 
1.5.3.6
