From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv5 1/8] commit.c: prefer get_header() to manual searching
Date: Thu, 7 Oct 2010 13:10:50 -0600
Message-ID: <1286478657-61581-2-git-send-email-patnotz@gmail.com>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 21:11:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vsG-0005gv-0T
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954Ab0JGTLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 15:11:17 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:35369 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab0JGTLP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 15:11:15 -0400
X-WSS-ID: 0L9XPAM-0C-C75-02
X-M-MSG: 
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1D33B532767
	for <git@vger.kernel.org>; Thu,  7 Oct 2010 13:11:10 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 07 Oct 2010 13:11:01 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o97JAoRB014917 for
 <git@vger.kernel.org>; Thu, 7 Oct 2010 13:10:52 -0600
Received: from sacv8030nk.sandia.gov (134.253.116.144) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 7 Oct 2010 13:10:59 -0600
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.10.7.190315
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_2000_2999 0,
 BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DATE_TZ_NA 0, __CT 0,
 __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0, __FRAUD_WEBMAIL 0,
 __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID 0, __HAS_X_MAILER
 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __PHISH_SPEAR_STRUCTURE_1 0,
 __SANE_MSGID 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_PATH 0,
 __URI_NO_WWW 0, __URI_NS '
X-TMWD-Spam-Summary: TS=20101007191103; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230342E34434145314234362E303133373A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAAAAAAAAAAAAAAAAAAAAAAAfQ==
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 60B0C4CF2JS4401082-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158436>

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 builtin/commit.c |   11 +++--------
 commit.h         |    1 +
 pretty.c         |    2 +-
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..bf9fcc1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -899,7 +899,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		unsigned char sha1[20];
 		static char utf8[] = "UTF-8";
 		const char *out_enc;
-		char *enc, *end;
+		char *enc;
 		struct commit *commit;
 
 		if (get_sha1(use_message, sha1))
@@ -908,13 +908,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		if (!commit || parse_commit(commit))
 			die("could not parse commit %s", use_message);
 
-		enc = strstr(commit->buffer, "\nencoding");
-		if (enc) {
-			end = strchr(enc + 10, '\n');
-			enc = xstrndup(enc + 10, end - (enc + 10));
-		} else {
-			enc = utf8;
-		}
+		enc = get_header(commit, "encoding");
+		enc = enc ? enc : utf8;
 		out_enc = git_commit_encoding ? git_commit_encoding : utf8;
 
 		if (strcmp(out_enc, enc))
diff --git a/commit.h b/commit.h
index 9113bbe..c246c94 100644
--- a/commit.h
+++ b/commit.h
@@ -87,6 +87,7 @@ struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern char *reencode_commit_message(const struct commit *commit,
 				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
+extern char *get_header(const struct commit *commit, const char *key);
 extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
diff --git a/pretty.c b/pretty.c
index f85444b..839944c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -348,7 +348,7 @@ static void add_merge_info(enum cmit_fmt fmt, struct strbuf *sb,
 	strbuf_addch(sb, '\n');
 }
 
-static char *get_header(const struct commit *commit, const char *key)
+char *get_header(const struct commit *commit, const char *key)
 {
 	int key_len = strlen(key);
 	const char *line = commit->buffer;
-- 
1.7.3.1
