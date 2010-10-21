From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv6 2/6] pretty.c: teach format_commit_message() to
 reencode the output
Date: Thu, 21 Oct 2010 13:33:53 -0600
Message-ID: <1287689637-95301-3-git-send-email-patnotz@gmail.com>
References: <1287689637-95301-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 21:34:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90u4-0002WW-V5
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 21:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab0JUTeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 15:34:15 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:58708 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab0JUTeM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 15:34:12 -0400
X-WSS-ID: 0LANNOU-0C-20K-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 148AC4DDD26
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 13:34:06 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 21 Oct 2010 13:33:58 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o9LJXiYu018943 for
 <git@vger.kernel.org>; Thu, 21 Oct 2010 13:33:49 -0600
Received: from sacv8030mq.sandia.gov (134.253.116.124) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 21 Oct 2010 13:33:55 -0600
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1287689637-95301-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.10.21.192418
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, DATE_TZ_NA 0, __CT 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0,
 __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID
 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0,
 __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0,
 __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS '
X-TMWD-Spam-Summary: TS=20101021193400; ID=1; SEV=2.3.1;
 DFV=B2010102119; IFV=NA; AIF=B2010102119; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230372E34434330393541392E303041413A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010102119_5.03.0010
X-WSS-ID: 60DE4A2C3KK1094506-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159548>

format_commit_message() will now reencode the content if the desired
output encoding is different from the encoding in the passed in
commit.

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 archive.c               |    2 +-
 builtin/commit.c        |    8 +++++---
 builtin/fmt-merge-msg.c |    2 +-
 commit.h                |    5 ++++-
 log-tree.c              |    2 +-
 notes-cache.c           |    2 +-
 pretty.c                |   30 ++++++++++++++++++++++--------
 submodule.c             |    4 ++--
 8 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/archive.c b/archive.c
index edd6853..42b7ab1 100644
--- a/archive.c
+++ b/archive.c
@@ -51,7 +51,7 @@ static void format_subst(const struct commit *commit,
 		strbuf_add(&fmt, b + 8, c - b - 8);
 
 		strbuf_add(buf, src, b - src);
-		format_commit_message(commit, fmt.buf, buf, &ctx);
+		format_commit_message(commit, fmt.buf, buf, &ctx, NULL);
 		len -= c + 1 - src;
 		src  = c + 1;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 54fcc6d..5fa24f5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -826,7 +826,7 @@ static const char *find_author_by_nickname(const char *name)
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = DATE_NORMAL;
 		strbuf_release(&buf);
-		format_commit_message(commit, "%an <%ae>", &buf, &ctx);
+		format_commit_message(commit, "%an <%ae>", &buf, &ctx, NULL);
 		return strbuf_detach(&buf, NULL);
 	}
 	die("No existing author found with '%s'", name);
@@ -1127,8 +1127,10 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 	strbuf_addstr(&format, "format:%h] %s");
 
-	format_commit_message(commit, "%an <%ae>", &author_ident, &pctx);
-	format_commit_message(commit, "%cn <%ce>", &committer_ident, &pctx);
+	format_commit_message(commit, "%an <%ae>", &author_ident,
+			      &pctx, NULL);
+	format_commit_message(commit, "%cn <%ce>", &committer_ident,
+			      &pctx, NULL);
 	if (strbuf_cmp(&author_ident, &committer_ident)) {
 		strbuf_addstr(&format, "\n Author: ");
 		strbuf_addbuf_percentquote(&format, &author_ident);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 78c7774..7619f4f 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -173,7 +173,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 		if (subjects.nr > limit)
 			continue;
 
-		format_commit_message(commit, "%s", &sb, &ctx);
+		format_commit_message(commit, "%s", &sb, &ctx, NULL);
 		strbuf_ltrim(&sb);
 
 		if (!sb.len)
diff --git a/commit.h b/commit.h
index a0b710f..b0f7d39 100644
--- a/commit.h
+++ b/commit.h
@@ -85,13 +85,16 @@ struct userformat_want {
 
 extern int has_non_ascii(const char *text);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
+extern char *logmsg_reencode(const struct commit *commit,
+			     const char *output_encoding);
 extern char *reencode_commit_message(const struct commit *commit,
 				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
-				  const struct pretty_print_context *context);
+				  const struct pretty_print_context *context,
+				  const char *output_encoding);
 extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 				struct strbuf *sb,
 				const struct pretty_print_context *context);
diff --git a/log-tree.c b/log-tree.c
index b46ed3b..af3200d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -274,7 +274,7 @@ void get_patch_filename(struct commit *commit, int nr, const char *suffix,
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = DATE_NORMAL;
 
-		format_commit_message(commit, "%f", buf, &ctx);
+		format_commit_message(commit, "%f", buf, &ctx, NULL);
 		if (max_len < buf->len)
 			strbuf_setlen(buf, max_len);
 		strbuf_addstr(buf, suffix);
diff --git a/notes-cache.c b/notes-cache.c
index dee6d62..461c474 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -19,7 +19,7 @@ static int notes_cache_match_validity(const char *ref, const char *validity)
 		return 0;
 
 	memset(&pretty_ctx, 0, sizeof(pretty_ctx));
-	format_commit_message(commit, "%s", &msg, &pretty_ctx);
+	format_commit_message(commit, "%s", &msg, &pretty_ctx, NULL);
 	strbuf_trim(&msg);
 
 	ret = !strcmp(msg.buf, validity);
diff --git a/pretty.c b/pretty.c
index c253172..7f52aa4 100644
--- a/pretty.c
+++ b/pretty.c
@@ -403,8 +403,8 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 	return strbuf_detach(&tmp, NULL);
 }
 
-static char *logmsg_reencode(const struct commit *commit,
-			     const char *output_encoding)
+char *logmsg_reencode(const struct commit *commit,
+		      const char *output_encoding)
 {
 	static const char *utf8 = "UTF-8";
 	const char *use_encoding;
@@ -555,6 +555,7 @@ struct format_commit_context {
 	const struct pretty_print_context *pretty_ctx;
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
+	char *message;
 	size_t width, indent1, indent2;
 
 	/* These offsets are relative to the start of the commit message. */
@@ -591,7 +592,7 @@ static int add_again(struct strbuf *sb, struct chunk *chunk)
 
 static void parse_commit_header(struct format_commit_context *context)
 {
-	const char *msg = context->commit->buffer;
+	const char *msg = context->message;
 	int i;
 
 	for (i = 0; msg[i]; i++) {
@@ -677,8 +678,8 @@ const char *format_subject(struct strbuf *sb, const char *msg,
 
 static void parse_commit_message(struct format_commit_context *c)
 {
-	const char *msg = c->commit->buffer + c->message_off;
-	const char *start = c->commit->buffer;
+	const char *msg = c->message + c->message_off;
+	const char *start = c->message;
 
 	msg = skip_empty_lines(msg);
 	c->subject_off = msg - start;
@@ -741,7 +742,7 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 {
 	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
-	const char *msg = commit->buffer;
+	const char *msg = c->message;
 	struct commit_list *p;
 	int h1, h2;
 
@@ -1008,16 +1009,29 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 
 void format_commit_message(const struct commit *commit,
 			   const char *format, struct strbuf *sb,
-			   const struct pretty_print_context *pretty_ctx)
+			   const struct pretty_print_context *pretty_ctx,
+			   const char *output_encoding)
 {
 	struct format_commit_context context;
+	static char utf8[] = "UTF-8";
+	char *enc;
+
+	enc = get_header(commit, "encoding");
+	enc = enc ? enc : utf8;
 
 	memset(&context, 0, sizeof(context));
 	context.commit = commit;
 	context.pretty_ctx = pretty_ctx;
 	context.wrap_start = sb->len;
+	if (output_encoding && strcmp(enc, output_encoding))
+		context.message = logmsg_reencode(commit, output_encoding);
+	context.message = context.message ? context.message : commit->buffer;
+
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
+
+	if (context.message != commit->buffer)
+		free(context.message);
 }
 
 static void pp_header(enum cmit_fmt fmt,
@@ -1176,7 +1190,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	int need_8bit_cte = context->need_8bit_cte;
 
 	if (fmt == CMIT_FMT_USERFORMAT) {
-		format_commit_message(commit, user_format, sb, context);
+		format_commit_message(commit, user_format, sb, context, NULL);
 		return;
 	}
 
diff --git a/submodule.c b/submodule.c
index 91a4758..c108ff6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -217,7 +217,7 @@ void show_submodule_summary(FILE *f, const char *path,
 			}
 			else if (add)
 				strbuf_addstr(&sb, add);
-			format_commit_message(commit, format, &sb, &ctx);
+			format_commit_message(commit, format, &sb, &ctx, NULL);
 			if (reset)
 				strbuf_addstr(&sb, reset);
 			strbuf_addch(&sb, '\n');
@@ -362,7 +362,7 @@ static void print_commit(struct commit *commit)
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	ctx.date_mode = DATE_NORMAL;
-	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
+	format_commit_message(commit, " %h: %m %s", &sb, &ctx, NULL);
 	fprintf(stderr, "%s\n", sb.buf);
 	strbuf_release(&sb);
 }
-- 
1.7.3.1
