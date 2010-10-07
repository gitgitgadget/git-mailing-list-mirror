From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv5 3/8] pretty.c: helper methods for getting output
 encodings
Date: Thu, 7 Oct 2010 13:10:52 -0600
Message-ID: <1286478657-61581-4-git-send-email-patnotz@gmail.com>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 21:12:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vsp-0005oH-H3
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571Ab0JGTL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 15:11:28 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:35382 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab0JGTLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 15:11:17 -0400
X-WSS-ID: 0L9XPAM-0C-C71-02
X-M-MSG: 
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 165CB53276E
	for <git@vger.kernel.org>; Thu,  7 Oct 2010 13:11:10 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 07 Oct 2010 13:11:03 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o97JAoRD014917 for
 <git@vger.kernel.org>; Thu, 7 Oct 2010 13:10:53 -0600
Received: from sacv8030nk.sandia.gov (134.253.116.144) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 7 Oct 2010 13:11:00 -0600
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
X-TMWD-Spam-Summary: TS=20101007191104; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230392E34434145314234372E303142413A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAAAAAAAAAAAAAAAAAAAAAAAfQ==
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 60B0C4CD2JS4401086-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158440>

Add helpers get_log_output_encoding() and get_commit_output_encoding()
that eliminate some messy and duplicate if-blocks.

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 builtin/commit.c |    2 +-
 cache.h          |    3 +++
 environment.c    |   11 +++++++++++
 pretty.c         |    6 +-----
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9fe4bdc..ea3801d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -905,7 +905,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 		enc = get_header(commit, "encoding");
 		enc = enc ? enc : utf8;
-		out_enc = git_commit_encoding ? git_commit_encoding : utf8;
+		out_enc = get_commit_output_encoding();
 
 		if (strcmp(out_enc, enc))
 			use_message_buffer =
diff --git a/cache.h b/cache.h
index 3d5ed51..7d49805 100644
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
index 839944c..a607fd6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1159,11 +1159,7 @@ char *reencode_commit_message(const struct commit *commit, const char **encoding
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
1.7.3.1
