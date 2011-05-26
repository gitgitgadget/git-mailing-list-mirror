From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] clean up calling conventions for pretty.c functions
Date: Thu, 26 May 2011 18:27:49 -0400
Message-ID: <20110526222749.GB21775@sigill.intra.peff.net>
References: <20110526222450.GA20077@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Fri May 27 00:27:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPj25-0007vU-7V
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 00:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758587Ab1EZW1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 18:27:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33262
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758450Ab1EZW1w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 18:27:52 -0400
Received: (qmail 18647 invoked by uid 107); 26 May 2011 22:27:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 18:27:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 18:27:49 -0400
Content-Disposition: inline
In-Reply-To: <20110526222450.GA20077@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174587>

We have a pretty_print_context representing the parameters
for a pretty-print session, but we did not use it uniformly.
As a result, functions kept growing more and more arguments.

Let's clean this up in a few ways:

  1. All pretty-print pp_* functions now take a context.
     This lets us reduce the number of arguments to these
     functions, since we were just passing around the
     context values separately.

  2. The context argument now has a cmit_fmt field, which
     was passed around separately. That's one less argument
     per function.

  3. The context argument always comes first, which makes
     calling a little more uniform.

This drops lines from some callers, and adds lines in a few
places (because we need an extra line to set the context's
fmt field). Overall, we don't save many lines, but the lines
that are there are a lot simpler and more readable.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c      |   21 ++++++-----
 builtin/merge.c    |    3 +-
 builtin/rev-list.c |    3 +-
 builtin/shortlog.c |    3 +-
 commit.h           |   19 +++++-----
 log-tree.c         |    3 +-
 pretty.c           |   99 ++++++++++++++++++++++++---------------------------
 7 files changed, 75 insertions(+), 76 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index cedfdb6..8d842cb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -327,9 +327,11 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 static void show_tagger(char *buf, int len, struct rev_info *rev)
 {
 	struct strbuf out = STRBUF_INIT;
+	struct pretty_print_context pp = {0};
 
-	pp_user_info("Tagger", rev->commit_format, &out, buf, rev->date_mode,
-		get_log_output_encoding());
+	pp.fmt = rev->commit_format;
+	pp.date_mode = rev->date_mode;
+	pp_user_info(&pp, "Tagger", &out, buf, get_log_output_encoding());
 	printf("%s", out.buf);
 	strbuf_release(&out);
 }
@@ -715,10 +717,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      int nr, struct commit **list, struct commit *head)
 {
 	const char *committer;
-	const char *subject_start = NULL;
 	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
 	const char *msg;
-	const char *extra_headers = rev->extra_headers;
 	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
 	int i;
@@ -726,6 +726,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	struct diff_options opts;
 	int need_8bit_cte = 0;
 	struct commit *commit = NULL;
+	struct pretty_print_context pp = {0};
 
 	if (rev->commit_format != CMIT_FMT_EMAIL)
 		die("Cover letter needs email format");
@@ -757,7 +758,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		free(commit);
 	}
 
-	log_write_email_headers(rev, head, &subject_start, &extra_headers,
+	log_write_email_headers(rev, head, &pp.subject, &pp.after_subject,
 				&need_8bit_cte);
 
 	for (i = 0; !need_8bit_cte && i < nr; i++)
@@ -765,11 +766,11 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			need_8bit_cte = 1;
 
 	msg = body;
-	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
-		     encoding);
-	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
-		      encoding, need_8bit_cte);
-	pp_remainder(CMIT_FMT_EMAIL, &msg, &sb, 0);
+	pp.fmt = CMIT_FMT_EMAIL;
+	pp.date_mode = DATE_RFC2822;
+	pp_user_info(&pp, NULL, &sb, committer, encoding);
+	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
+	pp_remainder(&pp, &msg, &sb, 0);
 	printf("%s\n", sb.buf);
 
 	strbuf_release(&sb);
diff --git a/builtin/merge.c b/builtin/merge.c
index 42fff38..c902e81 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -333,13 +333,14 @@ static void squash_message(void)
 
 	ctx.abbrev = rev.abbrev;
 	ctx.date_mode = rev.date_mode;
+	ctx.fmt = rev.commit_format;
 
 	strbuf_addstr(&out, "Squashed commit of the following:\n");
 	while ((commit = get_revision(&rev)) != NULL) {
 		strbuf_addch(&out, '\n');
 		strbuf_addf(&out, "commit %s\n",
 			sha1_to_hex(commit->object.sha1));
-		pretty_print_commit(rev.commit_format, commit, &out, &ctx);
+		pretty_print_commit(&ctx, commit, &out);
 	}
 	if (write(fd, out.buf, out.len) < 0)
 		die_errno("Writing SQUASH_MSG");
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ba27d39..0ec42fc 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -108,7 +108,8 @@ static void show_commit(struct commit *commit, void *data)
 		struct pretty_print_context ctx = {0};
 		ctx.abbrev = revs->abbrev;
 		ctx.date_mode = revs->date_mode;
-		pretty_print_commit(revs->commit_format, commit, &buf, &ctx);
+		ctx.fmt = revs->commit_format;
+		pretty_print_commit(&ctx, commit, &buf);
 		if (revs->graph) {
 			if (buf.len) {
 				if (revs->commit_format != CMIT_FMT_ONELINE)
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 90877b5..074fd26 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -161,11 +161,12 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		    sha1_to_hex(commit->object.sha1));
 	if (log->user_format) {
 		struct pretty_print_context ctx = {0};
+		ctx.fmt = CMIT_FMT_USERFORMAT;
 		ctx.abbrev = log->abbrev;
 		ctx.subject = "";
 		ctx.after_subject = "";
 		ctx.date_mode = DATE_NORMAL;
-		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &ufbuf, &ctx);
+		pretty_print_commit(&ctx, commit, &ufbuf);
 		buffer = ufbuf.buf;
 	} else if (*buffer) {
 		buffer++;
diff --git a/commit.h b/commit.h
index 3e733be..2935740 100644
--- a/commit.h
+++ b/commit.h
@@ -70,6 +70,7 @@ enum cmit_fmt {
 
 struct pretty_print_context
 {
+	enum cmit_fmt fmt;
 	int abbrev;
 	const char *subject;
 	const char *after_subject;
@@ -95,22 +96,20 @@ extern void userformat_find_requirements(const char *fmt, struct userformat_want
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
 				  const struct pretty_print_context *context);
-extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
-				struct strbuf *sb,
-				const struct pretty_print_context *context);
+extern void pretty_print_commit(const struct pretty_print_context *pp,
+				const struct commit *commit,
+				struct strbuf *sb);
 extern void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
 			   struct strbuf *sb);
-void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
-		   const char *line, enum date_mode dmode,
-		   const char *encoding);
-void pp_title_line(enum cmit_fmt fmt,
+void pp_user_info(const struct pretty_print_context *pp,
+		  const char *what, struct strbuf *sb,
+		  const char *line, const char *encoding);
+void pp_title_line(const struct pretty_print_context *pp,
 		   const char **msg_p,
 		   struct strbuf *sb,
-		   const char *subject,
-		   const char *after_subject,
 		   const char *encoding,
 		   int need_8bit_cte);
-void pp_remainder(enum cmit_fmt fmt,
+void pp_remainder(const struct pretty_print_context *pp,
 		  const char **msg_p,
 		  struct strbuf *sb,
 		  int indent);
diff --git a/log-tree.c b/log-tree.c
index b46ed3b..0d8cc7a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -505,7 +505,8 @@ void show_log(struct rev_info *opt)
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
 	ctx.reflog_info = opt->reflog_info;
-	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);
+	ctx.fmt = opt->commit_format;
+	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, opt->add_signoff);
diff --git a/pretty.c b/pretty.c
index 38cd398..f920205 100644
--- a/pretty.c
+++ b/pretty.c
@@ -266,16 +266,16 @@ needquote:
 	strbuf_addstr(sb, "?=");
 }
 
-void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
-		  const char *line, enum date_mode dmode,
-		  const char *encoding)
+void pp_user_info(const struct pretty_print_context *pp,
+		  const char *what, struct strbuf *sb,
+		  const char *line, const char *encoding)
 {
 	char *date;
 	int namelen;
 	unsigned long time;
 	int tz;
 
-	if (fmt == CMIT_FMT_ONELINE)
+	if (pp->fmt == CMIT_FMT_ONELINE)
 		return;
 	date = strchr(line, '>');
 	if (!date)
@@ -284,7 +284,7 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 	time = strtoul(date, &date, 10);
 	tz = strtol(date, NULL, 10);
 
-	if (fmt == CMIT_FMT_EMAIL) {
+	if (pp->fmt == CMIT_FMT_EMAIL) {
 		char *name_tail = strchr(line, '<');
 		int display_name_length;
 		if (!name_tail)
@@ -298,18 +298,18 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 		strbuf_addch(sb, '\n');
 	} else {
 		strbuf_addf(sb, "%s: %.*s%.*s\n", what,
-			      (fmt == CMIT_FMT_FULLER) ? 4 : 0,
+			      (pp->fmt == CMIT_FMT_FULLER) ? 4 : 0,
 			      "    ", namelen, line);
 	}
-	switch (fmt) {
+	switch (pp->fmt) {
 	case CMIT_FMT_MEDIUM:
-		strbuf_addf(sb, "Date:   %s\n", show_date(time, tz, dmode));
+		strbuf_addf(sb, "Date:   %s\n", show_date(time, tz, pp->date_mode));
 		break;
 	case CMIT_FMT_EMAIL:
 		strbuf_addf(sb, "Date: %s\n", show_date(time, tz, DATE_RFC2822));
 		break;
 	case CMIT_FMT_FULLER:
-		strbuf_addf(sb, "%sDate: %s\n", what, show_date(time, tz, dmode));
+		strbuf_addf(sb, "%sDate: %s\n", what, show_date(time, tz, pp->date_mode));
 		break;
 	default:
 		/* notin' */
@@ -340,12 +340,12 @@ static const char *skip_empty_lines(const char *msg)
 	return msg;
 }
 
-static void add_merge_info(enum cmit_fmt fmt, struct strbuf *sb,
-			const struct commit *commit, int abbrev)
+static void add_merge_info(const struct pretty_print_context *pp,
+			   struct strbuf *sb, const struct commit *commit)
 {
 	struct commit_list *parent = commit->parents;
 
-	if ((fmt == CMIT_FMT_ONELINE) || (fmt == CMIT_FMT_EMAIL) ||
+	if ((pp->fmt == CMIT_FMT_ONELINE) || (pp->fmt == CMIT_FMT_EMAIL) ||
 	    !parent || !parent->next)
 		return;
 
@@ -354,8 +354,8 @@ static void add_merge_info(enum cmit_fmt fmt, struct strbuf *sb,
 	while (parent) {
 		struct commit *p = parent->item;
 		const char *hex = NULL;
-		if (abbrev)
-			hex = find_unique_abbrev(p->object.sha1, abbrev);
+		if (pp->abbrev)
+			hex = find_unique_abbrev(p->object.sha1, pp->abbrev);
 		if (!hex)
 			hex = sha1_to_hex(p->object.sha1);
 		parent = parent->next;
@@ -1052,9 +1052,7 @@ void format_commit_message(const struct commit *commit,
 		free(context.message);
 }
 
-static void pp_header(enum cmit_fmt fmt,
-		      int abbrev,
-		      enum date_mode dmode,
+static void pp_header(const struct pretty_print_context *pp,
 		      const char *encoding,
 		      const struct commit *commit,
 		      const char **msg_p,
@@ -1074,7 +1072,7 @@ static void pp_header(enum cmit_fmt fmt,
 			/* End of header */
 			return;
 
-		if (fmt == CMIT_FMT_RAW) {
+		if (pp->fmt == CMIT_FMT_RAW) {
 			strbuf_add(sb, line, linelen);
 			continue;
 		}
@@ -1094,7 +1092,7 @@ static void pp_header(enum cmit_fmt fmt,
 				;
 			/* with enough slop */
 			strbuf_grow(sb, num * 50 + 20);
-			add_merge_info(fmt, sb, commit, abbrev);
+			add_merge_info(pp, sb, commit);
 			parents_shown = 1;
 		}
 
@@ -1105,21 +1103,19 @@ static void pp_header(enum cmit_fmt fmt,
 		 */
 		if (!memcmp(line, "author ", 7)) {
 			strbuf_grow(sb, linelen + 80);
-			pp_user_info("Author", fmt, sb, line + 7, dmode, encoding);
+			pp_user_info(pp, "Author", sb, line + 7, encoding);
 		}
 		if (!memcmp(line, "committer ", 10) &&
-		    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER)) {
+		    (pp->fmt == CMIT_FMT_FULL || pp->fmt == CMIT_FMT_FULLER)) {
 			strbuf_grow(sb, linelen + 80);
-			pp_user_info("Commit", fmt, sb, line + 10, dmode, encoding);
+			pp_user_info(pp, "Commit", sb, line + 10, encoding);
 		}
 	}
 }
 
-void pp_title_line(enum cmit_fmt fmt,
+void pp_title_line(const struct pretty_print_context *pp,
 		   const char **msg_p,
 		   struct strbuf *sb,
-		   const char *subject,
-		   const char *after_subject,
 		   const char *encoding,
 		   int need_8bit_cte)
 {
@@ -1129,8 +1125,8 @@ void pp_title_line(enum cmit_fmt fmt,
 	*msg_p = format_subject(&title, *msg_p, " ");
 
 	strbuf_grow(sb, title.len + 1024);
-	if (subject) {
-		strbuf_addstr(sb, subject);
+	if (pp->subject) {
+		strbuf_addstr(sb, pp->subject);
 		add_rfc2047(sb, title.buf, title.len, encoding);
 	} else {
 		strbuf_addbuf(sb, &title);
@@ -1144,16 +1140,16 @@ void pp_title_line(enum cmit_fmt fmt,
 			"Content-Transfer-Encoding: 8bit\n";
 		strbuf_addf(sb, header_fmt, encoding);
 	}
-	if (after_subject) {
-		strbuf_addstr(sb, after_subject);
+	if (pp->after_subject) {
+		strbuf_addstr(sb, pp->after_subject);
 	}
-	if (fmt == CMIT_FMT_EMAIL) {
+	if (pp->fmt == CMIT_FMT_EMAIL) {
 		strbuf_addch(sb, '\n');
 	}
 	strbuf_release(&title);
 }
 
-void pp_remainder(enum cmit_fmt fmt,
+void pp_remainder(const struct pretty_print_context *pp,
 		  const char **msg_p,
 		  struct strbuf *sb,
 		  int indent)
@@ -1170,7 +1166,7 @@ void pp_remainder(enum cmit_fmt fmt,
 		if (is_empty_line(line, &linelen)) {
 			if (first)
 				continue;
-			if (fmt == CMIT_FMT_SHORT)
+			if (pp->fmt == CMIT_FMT_SHORT)
 				break;
 		}
 		first = 0;
@@ -1195,19 +1191,19 @@ char *reencode_commit_message(const struct commit *commit, const char **encoding
 	return logmsg_reencode(commit, encoding);
 }
 
-void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
-			 struct strbuf *sb,
-			 const struct pretty_print_context *context)
+void pretty_print_commit(const struct pretty_print_context *pp,
+			 const struct commit *commit,
+			 struct strbuf *sb)
 {
 	unsigned long beginning_of_body;
 	int indent = 4;
 	const char *msg = commit->buffer;
 	char *reencoded;
 	const char *encoding;
-	int need_8bit_cte = context->need_8bit_cte;
+	int need_8bit_cte = pp->need_8bit_cte;
 
-	if (fmt == CMIT_FMT_USERFORMAT) {
-		format_commit_message(commit, user_format, sb, context);
+	if (pp->fmt == CMIT_FMT_USERFORMAT) {
+		format_commit_message(commit, user_format, sb, pp);
 		return;
 	}
 
@@ -1216,14 +1212,14 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		msg = reencoded;
 	}
 
-	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
+	if (pp->fmt == CMIT_FMT_ONELINE || pp->fmt == CMIT_FMT_EMAIL)
 		indent = 0;
 
 	/*
 	 * We need to check and emit Content-type: to mark it
 	 * as 8-bit if we haven't done so.
 	 */
-	if (fmt == CMIT_FMT_EMAIL && need_8bit_cte == 0) {
+	if (pp->fmt == CMIT_FMT_EMAIL && need_8bit_cte == 0) {
 		int i, ch, in_body;
 
 		for (in_body = i = 0; (ch = msg[i]); i++) {
@@ -1242,9 +1238,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		}
 	}
 
-	pp_header(fmt, context->abbrev, context->date_mode, encoding,
-		  commit, &msg, sb);
-	if (fmt != CMIT_FMT_ONELINE && !context->subject) {
+	pp_header(pp, encoding, commit, &msg, sb);
+	if (pp->fmt != CMIT_FMT_ONELINE && !pp->subject) {
 		strbuf_addch(sb, '\n');
 	}
 
@@ -1252,17 +1247,16 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	msg = skip_empty_lines(msg);
 
 	/* These formats treat the title line specially. */
-	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
-		pp_title_line(fmt, &msg, sb, context->subject,
-			      context->after_subject, encoding, need_8bit_cte);
+	if (pp->fmt == CMIT_FMT_ONELINE || pp->fmt == CMIT_FMT_EMAIL)
+		pp_title_line(pp, &msg, sb, encoding, need_8bit_cte);
 
 	beginning_of_body = sb->len;
-	if (fmt != CMIT_FMT_ONELINE)
-		pp_remainder(fmt, &msg, sb, indent);
+	if (pp->fmt != CMIT_FMT_ONELINE)
+		pp_remainder(pp, &msg, sb, indent);
 	strbuf_rtrim(sb);
 
 	/* Make sure there is an EOLN for the non-oneline case */
-	if (fmt != CMIT_FMT_ONELINE)
+	if (pp->fmt != CMIT_FMT_ONELINE)
 		strbuf_addch(sb, '\n');
 
 	/*
@@ -1270,10 +1264,10 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	 * format.  Make sure we did not strip the blank line
 	 * between the header and the body.
 	 */
-	if (fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
+	if (pp->fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	if (context->show_notes)
+	if (pp->show_notes)
 		format_display_notes(commit->object.sha1, sb, encoding,
 				     NOTES_SHOW_HEADER | NOTES_INDENT);
 
@@ -1284,5 +1278,6 @@ void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
 		    struct strbuf *sb)
 {
 	struct pretty_print_context pp = {0};
-	pretty_print_commit(fmt, commit, sb, &pp);
+	pp.fmt = fmt;
+	pretty_print_commit(&pp, commit, sb);
 }
-- 
1.7.4.5.26.g0c6a2
