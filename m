From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 5/7] gpg: centralize printing signature buffers
Date: Sun, 21 Jun 2015 23:14:41 +0000
Message-ID: <1434928483-105916-6-git-send-email-sandals@crustytoothpaste.net>
References: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 01:15:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6oSM-0006ER-M2
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 01:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264AbbFUXPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 19:15:12 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51197 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753363AbbFUXO6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2015 19:14:58 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D3FFE28098;
	Sun, 21 Jun 2015 23:14:55 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272304>

The code to handle printing of signature data from a struct
signature_check is very similar between verify-commit and verify-tag.
Place this in a single function.  verify-tag retains its special case
behavior of printing the tag even when no valid signature is found.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/verify-commit.c | 7 +------
 builtin/verify-tag.c    | 9 +++++----
 gpg-interface.c         | 9 +++++++++
 gpg-interface.h         | 3 +++
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index e30f7cf..016319a 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -26,12 +26,7 @@ static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned l
 	memset(&signature_check, 0, sizeof(signature_check));
 
 	ret = check_commit_signature(lookup_commit(sha1), &signature_check);
-
-	if (verbose && signature_check.payload)
-		fputs(signature_check.payload, stdout);
-
-	if (signature_check.gpg_output)
-		fputs(signature_check.gpg_output, stderr);
+	print_signature_buffer(&signature_check, verbose ? GPG_VERIFY_VERBOSE : 0);
 
 	signature_check_clear(&signature_check);
 	return ret;
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 8750bef..d67e3db 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -27,14 +27,15 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	memset(&sigc, 0, sizeof(sigc));
 
 	len = parse_signature(buf, size);
-	if (verbose)
-		write_in_full(1, buf, len);
 
-	if (size == len)
+	if (size == len) {
+		if (verbose)
+			write_in_full(1, buf, len);
 		return error("no signature found");
+	}
 
 	ret = check_signature(buf, len, buf + len, size - len, &sigc);
-	fputs(sigc.gpg_output, stderr);
+	print_signature_buffer(&sigc, verbose ? GPG_VERIFY_VERBOSE : 0);
 
 	signature_check_clear(&sigc);
 	return ret;
diff --git a/gpg-interface.c b/gpg-interface.c
index 77a4da6..e764fb6 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -85,6 +85,15 @@ int check_signature(const char *payload, size_t plen, const char *signature,
 	return sigc->result != 'G' && sigc->result != 'U';
 }
 
+void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
+{
+	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
+		fputs(sigc->payload, stdout);
+
+	if (sigc->gpg_output)
+		fputs(sigc->gpg_output, stderr);
+}
+
 /*
  * Look at GPG signed content (e.g. a signed tag object), whose
  * payload is followed by a detached signature on it.  Return the
diff --git a/gpg-interface.h b/gpg-interface.h
index e2aabde..1207861 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -1,6 +1,8 @@
 #ifndef GPG_INTERFACE_H
 #define GPG_INTERFACE_H
 
+#define GPG_VERIFY_VERBOSE	1
+
 struct signature_check {
 	char *payload;
 	char *gpg_output;
@@ -29,5 +31,6 @@ extern void set_signing_key(const char *);
 extern const char *get_signing_key(void);
 extern int check_signature(const char *payload, size_t plen,
 	const char *signature, size_t slen, struct signature_check *sigc);
+void print_signature_buffer(const struct signature_check *sigc, unsigned flags);
 
 #endif
-- 
2.4.0
