From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv7 1/6] commit: helper methods to reduce redundant blocks
 of code
Date: Tue, 2 Nov 2010 13:59:07 -0600
Message-ID: <1288727952-57498-2-git-send-email-patnotz@gmail.com>
References: <1288727952-57498-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 21:00:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDN1c-0007yP-BB
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 21:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab0KBT7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 15:59:37 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:39657 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab0KBT7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 15:59:34 -0400
X-WSS-ID: 0LB9WV5-0C-06H-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1F55647FDC1
	for <git@vger.kernel.org>; Tue,  2 Nov 2010 13:59:27 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Tue, 02 Nov 2010 13:59:20 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id oA2Jx5mq000560 for
 <git@vger.kernel.org>; Tue, 2 Nov 2010 13:59:10 -0600
Received: from localhost.localdomain (134.253.98.198) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Tue, 2 Nov 2010 13:59:13 -0600
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1288727952-57498-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.11.2.195116
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODY_SIZE_6000_6999 0, BODY_SIZE_7000_LESS 0, DATE_TZ_NA 0, __CT
 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0, __FRAUD_REFNUM 0,
 __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID
 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0,
 __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0,
 __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS '
X-TMWD-Spam-Summary: TS=20101102195923; ID=1; SEV=2.3.1;
 DFV=B2010110219; IFV=NA; AIF=B2010110219; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230332E34434430364439422E303131383A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAAAAAAAAAAAAAAAAAAAAAAAfQ==
X-MMS-Spam-Filter-ID: B2010110219_5.03.0010
X-WSS-ID: 60CEB2123KK1977240-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160550>

* builtin/commit.c: Replace block of code with a one-liner call to
  logmsg_reencode().

* commit.c: new function for looking up a comit by name

* pretty.c: helper methods for getting output encodings

  Add helpers get_log_output_encoding() and
  get_commit_output_encoding() that eliminate some messy and duplicate
  if-blocks.

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 builtin/commit.c   |   26 ++++----------------------
 builtin/log.c      |    3 +--
 builtin/mailinfo.c |    2 +-
 cache.h            |    3 +++
 commit.c           |   13 +++++++++++++
 commit.h           |    1 +
 environment.c      |   11 +++++++++++
 pretty.c           |    9 ++-------
 8 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..54fcc6d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -896,30 +896,14 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (!use_message && renew_authorship)
 		die("--reset-author can be used only with -C, -c or --amend.");
 	if (use_message) {
-		unsigned char sha1[20];
-		static char utf8[] = "UTF-8";
 		const char *out_enc;
-		char *enc, *end;
 		struct commit *commit;
 
-		if (get_sha1(use_message, sha1))
+		commit = lookup_commit_reference_by_name(use_message);
+		if (!commit)
 			die("could not lookup commit %s", use_message);
-		commit = lookup_commit_reference(sha1);
-		if (!commit || parse_commit(commit))
-			die("could not parse commit %s", use_message);
-
-		enc = strstr(commit->buffer, "\nencoding");
-		if (enc) {
-			end = strchr(enc + 10, '\n');
-			enc = xstrndup(enc + 10, end - (enc + 10));
-		} else {
-			enc = utf8;
-		}
-		out_enc = git_commit_encoding ? git_commit_encoding : utf8;
-
-		if (strcmp(out_enc, enc))
-			use_message_buffer =
-				reencode_string(commit->buffer, out_enc, enc);
+		out_enc = get_commit_output_encoding();
+		use_message_buffer = logmsg_reencode(commit, out_enc);
 
 		/*
 		 * If we failed to reencode the buffer, just copy it
@@ -929,8 +913,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		 */
 		if (use_message_buffer == NULL)
 			use_message_buffer = xstrdup(commit->buffer);
-		if (enc != utf8)
-			free(enc);
 	}
 
 	if (!!also + !!only + !!all + !!interactive > 1)
diff --git a/builtin/log.c b/builtin/log.c
index 22d1290..90e05ac 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -329,8 +329,7 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
 	struct strbuf out = STRBUF_INIT;
 
 	pp_user_info("Tagger", rev->commit_format, &out, buf, rev->date_mode,
-		git_log_output_encoding ?
-		git_log_output_encoding: git_commit_encoding);
+		get_log_output_encoding());
 	printf("%s", out.buf);
 	strbuf_release(&out);
 }
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2320d98..71e6262 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -1032,7 +1032,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	 */
 	git_config(git_mailinfo_config, NULL);
 
-	def_charset = (git_commit_encoding ? git_commit_encoding : "UTF-8");
+	def_charset = get_commit_output_encoding();
 	metainfo_charset = def_charset;
 
 	while (1 < argc && argv[1][0] == '-') {
diff --git a/cache.h b/cache.h
index 33decd9..5ed5374 100644
--- a/cache.h
+++ b/cache.h
@@ -1003,6 +1003,9 @@ extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int git_config_global(void);
 extern int config_error_nonbool(const char *);
+extern const char *get_log_output_encoding(void);
+extern const char *get_commit_output_encoding(void);
+
 extern const char *config_exclusive_filename;
 
 #define MAX_GITNAME (1000)
diff --git a/commit.c b/commit.c
index 0094ec1..5ed9ccd 100644
--- a/commit.c
+++ b/commit.c
@@ -49,6 +49,19 @@ struct commit *lookup_commit(const unsigned char *sha1)
 	return check_commit(obj, sha1, 0);
 }
 
+struct commit *lookup_commit_reference_by_name(const char *name)
+{
+	unsigned char sha1[20];
+	struct commit *commit;
+
+	if (get_sha1(name, sha1))
+		return NULL;
+	commit = lookup_commit_reference(sha1);
+	if (!commit || parse_commit(commit))
+		return NULL;
+	return commit;
+}
+
 static unsigned long parse_commit_date(const char *buf, const char *tail)
 {
 	const char *dateptr;
diff --git a/commit.h b/commit.h
index 9113bbe..a0b710f 100644
--- a/commit.h
+++ b/commit.h
@@ -36,6 +36,7 @@ struct commit *lookup_commit(const unsigned char *sha1);
 struct commit *lookup_commit_reference(const unsigned char *sha1);
 struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
 					      int quiet);
+struct commit *lookup_commit_reference_by_name(const char *name);
 
 int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size);
 
diff --git a/environment.c b/environment.c
index de5581f..a9d44a2 100644
--- a/environment.c
+++ b/environment.c
@@ -192,3 +192,14 @@ int set_git_dir(const char *path)
 	setup_git_env();
 	return 0;
 }
+
+const char *get_log_output_encoding(void)
+{
+	return git_log_output_encoding ? git_log_output_encoding
+		: get_commit_output_encoding();
+}
+
+const char *get_commit_output_encoding(void)
+{
+	return git_commit_encoding ? git_commit_encoding : "UTF-8";
+}
diff --git a/pretty.c b/pretty.c
index f85444b..c253172 100644
--- a/pretty.c
+++ b/pretty.c
@@ -886,8 +886,7 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	case 'N':
 		if (c->pretty_ctx->show_notes) {
 			format_display_notes(commit->object.sha1, sb,
-				    git_log_output_encoding ? git_log_output_encoding
-							    : git_commit_encoding, 0);
+				    get_log_output_encoding(), 0);
 			return 1;
 		}
 		return 0;
@@ -1159,11 +1158,7 @@ char *reencode_commit_message(const struct commit *commit, const char **encoding
 {
 	const char *encoding;
 
-	encoding = (git_log_output_encoding
-		    ? git_log_output_encoding
-		    : git_commit_encoding);
-	if (!encoding)
-		encoding = "UTF-8";
+	encoding = get_log_output_encoding();
 	if (encoding_p)
 		*encoding_p = encoding;
 	return logmsg_reencode(commit, encoding);
-- 
1.7.3.2
