From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv5 2/8] commit.c: new function for looking up a comit by
 name
Date: Thu, 7 Oct 2010 13:10:51 -0600
Message-ID: <1286478657-61581-3-git-send-email-patnotz@gmail.com>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 21:11:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vsE-0005gv-9C
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050Ab0JGTLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 15:11:18 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:35367 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab0JGTLP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 15:11:15 -0400
X-WSS-ID: 0L9XPAM-0C-C7A-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1FC70532771
	for <git@vger.kernel.org>; Thu,  7 Oct 2010 13:11:10 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 07 Oct 2010 13:11:02 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o97JAoRC014917 for
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
 __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0, __FRAUD_REFNUM 0,
 __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID
 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0,
 __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0,
 __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS '
X-TMWD-Spam-Summary: TS=20101007191103; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230362E34434145314234372E303030363A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAAAAAAAAAAAAAAAAAAAAAAAfQ==
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 60B0C4CC2JS4401085-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158435>

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 builtin/commit.c |    7 +------
 commit.c         |   13 +++++++++++++
 commit.h         |    1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index bf9fcc1..9fe4bdc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -896,17 +896,12 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (!use_message && renew_authorship)
 		die("--reset-author can be used only with -C, -c or --amend.");
 	if (use_message) {
-		unsigned char sha1[20];
 		static char utf8[] = "UTF-8";
 		const char *out_enc;
 		char *enc;
 		struct commit *commit;
 
-		if (get_sha1(use_message, sha1))
-			die("could not lookup commit %s", use_message);
-		commit = lookup_commit_reference(sha1);
-		if (!commit || parse_commit(commit))
-			die("could not parse commit %s", use_message);
+		commit = lookup_commit_reference_by_name(use_message);
 
 		enc = get_header(commit, "encoding");
 		enc = enc ? enc : utf8;
diff --git a/commit.c b/commit.c
index 0094ec1..f51098a 100644
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
+		die("could not lookup commit %s", name);
+	commit = lookup_commit_reference(sha1);
+	if (!commit || parse_commit(commit))
+		die("could not parse commit %s", name);
+	return commit;
+}
+
 static unsigned long parse_commit_date(const char *buf, const char *tail)
 {
 	const char *dateptr;
diff --git a/commit.h b/commit.h
index c246c94..6f4b586 100644
--- a/commit.h
+++ b/commit.h
@@ -36,6 +36,7 @@ struct commit *lookup_commit(const unsigned char *sha1);
 struct commit *lookup_commit_reference(const unsigned char *sha1);
 struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
 					      int quiet);
+struct commit *lookup_commit_reference_by_name(const char *name);
 
 int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size);
 
-- 
1.7.3.1
