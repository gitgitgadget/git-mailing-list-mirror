From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv7 2/6] pretty.c: teach format_commit_message() to
 reencode the output
Date: Tue, 2 Nov 2010 13:59:08 -0600
Message-ID: <1288727952-57498-3-git-send-email-patnotz@gmail.com>
References: <1288727952-57498-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 20:59:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDN17-0007b2-GB
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 20:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611Ab0KBT7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 15:59:32 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:39620 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab0KBT70 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 15:59:26 -0400
X-WSS-ID: 0LB9WUY-0C-05X-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 181D447FDC6
	for <git@vger.kernel.org>; Tue,  2 Nov 2010 13:59:22 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Tue, 02 Nov 2010 13:59:14 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id oA2Jx5ml000560 for
 <git@vger.kernel.org>; Tue, 2 Nov 2010 13:59:05 -0600
Received: from localhost.localdomain (134.253.98.198) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Tue, 2 Nov 2010 13:59:13 -0600
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1288727952-57498-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.11.2.195116
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODY_SIZE_3000_3999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS
 0, DATE_TZ_NA 0, __CT 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0,
 __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID
 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0,
 __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0,
 __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS '
X-TMWD-Spam-Summary: TS=20101102195917; ID=1; SEV=2.3.1;
 DFV=B2010110219; IFV=NA; AIF=B2010110219; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230392E34434430364439362E303046303A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010110219_5.03.0010
X-WSS-ID: 60CEB2183KK1977232-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160547>

format_commit_message() will now reencode the content if the desired
output encoding is different from the encoding in the passed in
commit.  Callers wanting to specify the output encoding do so via the
pretty_print_context struct.

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 commit.h |    3 +++
 pretty.c |   27 +++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/commit.h b/commit.h
index a0b710f..3bfb31b 100644
--- a/commit.h
+++ b/commit.h
@@ -77,6 +77,7 @@ struct pretty_print_context
 	int need_8bit_cte;
 	int show_notes;
 	struct reflog_walk_info *reflog_info;
+	const char *output_encoding;
 };
 
 struct userformat_want {
@@ -85,6 +86,8 @@ struct userformat_want {
 
 extern int has_non_ascii(const char *text);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
+extern char *logmsg_reencode(const struct commit *commit,
+			     const char *output_encoding);
 extern char *reencode_commit_message(const struct commit *commit,
 				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
diff --git a/pretty.c b/pretty.c
index c253172..8549934 100644
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
 
@@ -1011,13 +1012,27 @@ void format_commit_message(const struct commit *commit,
 			   const struct pretty_print_context *pretty_ctx)
 {
 	struct format_commit_context context;
+	static const char utf8[] = "UTF-8";
+	const char *enc;
+	const char *output_enc = pretty_ctx->output_encoding;
 
 	memset(&context, 0, sizeof(context));
 	context.commit = commit;
 	context.pretty_ctx = pretty_ctx;
 	context.wrap_start = sb->len;
+	context.message = commit->buffer;
+	if (output_enc) {
+		enc = get_header(commit, "encoding");
+		enc = enc ? enc : utf8;
+		if (strcmp(enc, output_enc))
+			context.message = logmsg_reencode(commit, output_enc);
+	}
+
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
+
+	if (context.message != commit->buffer)
+		free(context.message);
 }
 
 static void pp_header(enum cmit_fmt fmt,
-- 
1.7.3.2
