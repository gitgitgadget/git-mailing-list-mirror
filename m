From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/4] Export some email and pretty-printing functions
Date: Wed, 6 Feb 2008 11:43:21 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802061141140.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:44:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMnOC-00049s-SQ
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 17:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbYBFQng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 11:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbYBFQnf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 11:43:35 -0500
Received: from iabervon.org ([66.92.72.58]:58418 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842AbYBFQnb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 11:43:31 -0500
Received: (qmail 27674 invoked by uid 1000); 6 Feb 2008 16:43:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2008 16:43:21 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72814>

These will be used for generating the cover letter in addition to the
patch emails.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 commit.h   |   15 +++++++
 log-tree.c |  126 ++++++++++++++++++++++++++++++++---------------------------
 log-tree.h |    2 +
 pretty.c   |   28 +++++++-------
 4 files changed, 99 insertions(+), 72 deletions(-)

diff --git a/commit.h b/commit.h
index 10e2b5d..42b4825 100644
--- a/commit.h
+++ b/commit.h
@@ -71,6 +71,21 @@ extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
                                 int abbrev, const char *subject,
                                 const char *after_subject, enum date_mode,
 				int non_ascii_present);
+void add_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
+		   const char *line, enum date_mode dmode,
+		   const char *encoding);
+void pp_title_line(enum cmit_fmt fmt,
+		   const char **msg_p,
+		   struct strbuf *sb,
+		   const char *subject,
+		   const char *after_subject,
+		   const char *encoding,
+		   int plain_non_ascii);
+void pp_remainder(enum cmit_fmt fmt,
+		  const char **msg_p,
+		  struct strbuf *sb,
+		  int indent);
+
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
diff --git a/log-tree.c b/log-tree.c
index 1f3fcf1..56c8b27 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -137,6 +137,72 @@ static int has_non_ascii(const char *s)
 	return 0;
 }
 
+void write_email_headers(struct rev_info *opt, const char *name,
+			 const char **subject_p, const char **extra_headers_p)
+{
+	const char *subject = NULL;
+	const char *extra_headers = opt->extra_headers;
+	if (opt->total > 0) {
+		static char buffer[64];
+		snprintf(buffer, sizeof(buffer),
+			 "Subject: [%s %0*d/%d] ",
+			 opt->subject_prefix,
+			 digits_in_number(opt->total),
+			 opt->nr, opt->total);
+		subject = buffer;
+	} else if (opt->total == 0 && opt->subject_prefix && *opt->subject_prefix) {
+		static char buffer[256];
+		snprintf(buffer, sizeof(buffer),
+			 "Subject: [%s] ",
+			 opt->subject_prefix);
+		subject = buffer;
+	} else {
+		subject = "Subject: ";
+	}
+
+	printf("From %s Mon Sep 17 00:00:00 2001\n", name);
+	if (opt->message_id)
+		printf("Message-Id: <%s>\n", opt->message_id);
+	if (opt->ref_message_id)
+		printf("In-Reply-To: <%s>\nReferences: <%s>\n",
+		       opt->ref_message_id, opt->ref_message_id);
+	if (opt->mime_boundary) {
+		static char subject_buffer[1024];
+		static char buffer[1024];
+		snprintf(subject_buffer, sizeof(subject_buffer) - 1,
+			 "%s"
+			 "MIME-Version: 1.0\n"
+			 "Content-Type: multipart/mixed;"
+			 " boundary=\"%s%s\"\n"
+			 "\n"
+			 "This is a multi-part message in MIME "
+			 "format.\n"
+			 "--%s%s\n"
+			 "Content-Type: text/plain; "
+			 "charset=UTF-8; format=fixed\n"
+			 "Content-Transfer-Encoding: 8bit\n\n",
+			 extra_headers ? extra_headers : "",
+			 mime_boundary_leader, opt->mime_boundary,
+			 mime_boundary_leader, opt->mime_boundary);
+		extra_headers = subject_buffer;
+
+		snprintf(buffer, sizeof(buffer) - 1,
+			 "--%s%s\n"
+			 "Content-Type: text/x-patch;"
+			 " name=\"%s.diff\"\n"
+			 "Content-Transfer-Encoding: 8bit\n"
+			 "Content-Disposition: %s;"
+			 " filename=\"%s.diff\"\n\n",
+			 mime_boundary_leader, opt->mime_boundary,
+			 name,
+			 opt->no_inline ? "attachment" : "inline",
+			 name);
+		opt->diffopt.stat_sep = buffer;
+	}
+	*subject_p = subject;
+	*extra_headers_p = extra_headers;
+}
+
 void show_log(struct rev_info *opt, const char *sep)
 {
 	struct strbuf msgbuf;
@@ -186,64 +252,8 @@ void show_log(struct rev_info *opt, const char *sep)
 	 */
 
 	if (opt->commit_format == CMIT_FMT_EMAIL) {
-		char *sha1 = sha1_to_hex(commit->object.sha1);
-		if (opt->total > 0) {
-			static char buffer[64];
-			snprintf(buffer, sizeof(buffer),
-					"Subject: [%s %0*d/%d] ",
-					opt->subject_prefix,
-					digits_in_number(opt->total),
-					opt->nr, opt->total);
-			subject = buffer;
-		} else if (opt->total == 0 && opt->subject_prefix && *opt->subject_prefix) {
-			static char buffer[256];
-			snprintf(buffer, sizeof(buffer),
-					"Subject: [%s] ",
-					opt->subject_prefix);
-			subject = buffer;
-		} else {
-			subject = "Subject: ";
-		}
-
-		printf("From %s Mon Sep 17 00:00:00 2001\n", sha1);
-		if (opt->message_id)
-			printf("Message-Id: <%s>\n", opt->message_id);
-		if (opt->ref_message_id)
-			printf("In-Reply-To: <%s>\nReferences: <%s>\n",
-			       opt->ref_message_id, opt->ref_message_id);
-		if (opt->mime_boundary) {
-			static char subject_buffer[1024];
-			static char buffer[1024];
-			snprintf(subject_buffer, sizeof(subject_buffer) - 1,
-				 "%s"
-				 "MIME-Version: 1.0\n"
-				 "Content-Type: multipart/mixed;"
-				 " boundary=\"%s%s\"\n"
-				 "\n"
-				 "This is a multi-part message in MIME "
-				 "format.\n"
-				 "--%s%s\n"
-				 "Content-Type: text/plain; "
-				 "charset=UTF-8; format=fixed\n"
-				 "Content-Transfer-Encoding: 8bit\n\n",
-				 extra_headers ? extra_headers : "",
-				 mime_boundary_leader, opt->mime_boundary,
-				 mime_boundary_leader, opt->mime_boundary);
-			extra_headers = subject_buffer;
-
-			snprintf(buffer, sizeof(buffer) - 1,
-				 "--%s%s\n"
-				 "Content-Type: text/x-patch;"
-				 " name=\"%s.diff\"\n"
-				 "Content-Transfer-Encoding: 8bit\n"
-				 "Content-Disposition: %s;"
-				 " filename=\"%s.diff\"\n\n",
-				 mime_boundary_leader, opt->mime_boundary,
-				 sha1,
-				 opt->no_inline ? "attachment" : "inline",
-				 sha1);
-			opt->diffopt.stat_sep = buffer;
-		}
+		write_email_headers(opt, sha1_to_hex(commit->object.sha1),
+				    &subject, &extra_headers);
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), stdout);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
diff --git a/log-tree.h b/log-tree.h
index b33f7cd..7cab9ef 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -13,5 +13,7 @@ int log_tree_commit(struct rev_info *, struct commit *);
 int log_tree_opt_parse(struct rev_info *, const char **, int);
 void show_log(struct rev_info *opt, const char *sep);
 void show_decorations(struct commit *commit);
+void write_email_headers(struct rev_info *opt, const char *name,
+			 const char **subject_p, const char **extra_headers_p);
 
 #endif
diff --git a/pretty.c b/pretty.c
index b987ff2..f82380b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -110,9 +110,9 @@ needquote:
 	strbuf_addstr(sb, "?=");
 }
 
-static void add_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
-			 const char *line, enum date_mode dmode,
-			 const char *encoding)
+void add_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
+		   const char *line, enum date_mode dmode,
+		   const char *encoding)
 {
 	char *date;
 	int namelen;
@@ -653,13 +653,13 @@ static void pp_header(enum cmit_fmt fmt,
 	}
 }
 
-static void pp_title_line(enum cmit_fmt fmt,
-			  const char **msg_p,
-			  struct strbuf *sb,
-			  const char *subject,
-			  const char *after_subject,
-			  const char *encoding,
-			  int plain_non_ascii)
+void pp_title_line(enum cmit_fmt fmt,
+		   const char **msg_p,
+		   struct strbuf *sb,
+		   const char *subject,
+		   const char *after_subject,
+		   const char *encoding,
+		   int plain_non_ascii)
 {
 	struct strbuf title;
 
@@ -708,10 +708,10 @@ static void pp_title_line(enum cmit_fmt fmt,
 	strbuf_release(&title);
 }
 
-static void pp_remainder(enum cmit_fmt fmt,
-			 const char **msg_p,
-			 struct strbuf *sb,
-			 int indent)
+void pp_remainder(enum cmit_fmt fmt,
+		  const char **msg_p,
+		  struct strbuf *sb,
+		  int indent)
 {
 	int first = 1;
 	for (;;) {
-- 
1.5.4.27.gf6864
