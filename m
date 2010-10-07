From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv5 4/8] pretty.c: teach format_commit_message() to
 reencode the output
Date: Thu, 7 Oct 2010 13:10:53 -0600
Message-ID: <1286478657-61581-5-git-send-email-patnotz@gmail.com>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 21:12:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vsq-0005oH-3Y
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab0JGTL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 15:11:29 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:35380 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab0JGTLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 15:11:17 -0400
X-WSS-ID: 0L9XPAM-0C-C70-02
X-M-MSG: 
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 13824532773
	for <git@vger.kernel.org>; Thu,  7 Oct 2010 13:11:10 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 07 Oct 2010 13:11:04 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o97JAoRE014917 for
 <git@vger.kernel.org>; Thu, 7 Oct 2010 13:10:54 -0600
Received: from sacv8030nk.sandia.gov (134.253.116.144) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 7 Oct 2010 13:11:01 -0600
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.10.7.190315
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODY_SIZE_6000_6999 0, BODY_SIZE_7000_LESS 0, DATE_TZ_NA 0, __CT
 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0, __FRAUD_WEBMAIL 0,
 __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID 0, __HAS_X_MAILER
 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __PHISH_SPEAR_STRUCTURE_1 0,
 __SANE_MSGID 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_PATH 0,
 __URI_NO_WWW 0, __URI_NS '
X-TMWD-Spam-Summary: TS=20101007191105; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230392E34434145314234382E303137433A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 60B0C4C22JS4401105-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158441>

format_commit_message() will now reencode the content if the desired
output encoding is different from the encoding in the passed in
commit.

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 archive.c               |    2 +-
 builtin/commit.c        |    6 +++---
 builtin/fmt-merge-msg.c |    2 +-
 commit.h                |    3 ++-
 log-tree.c              |    2 +-
 notes-cache.c           |    2 +-
 pretty.c                |   39 +++++++++++++++++++++++++++++++++++----
 submodule.c             |    4 ++--
 8 files changed, 46 insertions(+), 14 deletions(-)

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
index ea3801d..e66f10c 100644
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
@@ -1135,8 +1135,8 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 	strbuf_addstr(&format, "format:%h] %s");
 
-	format_commit_message(commit, "%an <%ae>", &author_ident, &pctx);
-	format_commit_message(commit, "%cn <%ce>", &committer_ident, &pctx);
+	format_commit_message(commit, "%an <%ae>", &author_ident, &pctx, NULL);
+	format_commit_message(commit, "%cn <%ce>", &committer_ident, &pctx, NULL);
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
index 6f4b586..51c7110 100644
--- a/commit.h
+++ b/commit.h
@@ -92,7 +92,8 @@ extern char *get_header(const struct commit *commit, const char *key);
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
index a607fd6..e5ce7fb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1009,16 +1009,47 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 
 void format_commit_message(const struct commit *commit,
 			   const char *format, struct strbuf *sb,
-			   const struct pretty_print_context *pretty_ctx)
+			   const struct pretty_print_context *pretty_ctx,
+			   const char *output_encoding)
 {
 	struct format_commit_context context;
+	static char utf8[] = "UTF-8";
+	char *enc;
+	char *buffer;
+	char *enc_buffer;
+	struct strbuf scratch_sb = STRBUF_INIT;
+	struct strbuf *sb_ptr;
+
+	enc = get_header(commit, "encoding");
+	enc = enc ? enc : utf8;
+	if(output_encoding && strcmp(enc,output_encoding)) {
+		sb_ptr = &scratch_sb;
+	} else {
+		sb_ptr = sb;
+	}
 
 	memset(&context, 0, sizeof(context));
 	context.commit = commit;
 	context.pretty_ctx = pretty_ctx;
 	context.wrap_start = sb->len;
-	strbuf_expand(sb, format, format_commit_item, &context);
-	rewrap_message_tail(sb, &context, 0, 0, 0);
+	strbuf_expand(sb_ptr, format, format_commit_item, &context);
+	rewrap_message_tail(sb_ptr, &context, 0, 0, 0);
+
+	if(sb_ptr != sb) {
+		/* if re-encoding fails, take the content byte-for-byte */
+		buffer = strbuf_detach(sb_ptr, 0);
+		enc_buffer = reencode_string(buffer, output_encoding, enc);
+		enc_buffer = enc_buffer ? enc_buffer : buffer;
+
+		strbuf_addstr(sb,enc_buffer);
+
+		if(enc_buffer != buffer)
+			free(enc_buffer);
+		free(buffer);
+	}
+
+	if(enc != utf8)
+		free(enc);
 }
 
 static void pp_header(enum cmit_fmt fmt,
@@ -1177,7 +1208,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
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
