From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/3] verify-commit: add option to print raw gpg status information
Date: Sun, 14 Jun 2015 18:51:48 +0000
Message-ID: <1434307910-705555-2-git-send-email-sandals@crustytoothpaste.net>
References: <1434307910-705555-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 20:52:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4D1B-0003W0-5H
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 20:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbbFNSwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 14:52:19 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:43775 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753203AbbFNSwL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2015 14:52:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 14C8628092;
	Sun, 14 Jun 2015 18:52:10 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434307910-705555-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1 ALL_TRUSTED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271644>

verify-commit by default displays human-readable output on standard
error.  However, it can also be useful to get access to the raw gpg
status information, which is machine-readable, allowing automated
implementation of signing policy.  Add a --raw option to make
verify-commit produce the gpg status information on standard error
instead of the human-readable format.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-verify-commit.txt |  4 ++++
 builtin/verify-commit.c             | 13 +++++++------
 t/t7510-signed-commit.sh            | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-verify-commit.txt b/Documentation/git-verify-commit.txt
index 9413e28..ecf4da1 100644
--- a/Documentation/git-verify-commit.txt
+++ b/Documentation/git-verify-commit.txt
@@ -16,6 +16,10 @@ Validates the gpg signature created by 'git commit -S'.
 
 OPTIONS
 -------
+--raw::
+	Print the raw gpg status output to standard error instead of the normal
+	human-readable output.
+
 -v::
 --verbose::
 	Print the contents of the commit object before validating it.
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index ec0c4e3..04646fc 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -18,7 +18,7 @@ static const char * const verify_commit_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned long size, int verbose)
+static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned long size, int verbose, int raw)
 {
 	struct signature_check signature_check;
 
@@ -30,13 +30,13 @@ static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned l
 		fputs(signature_check.payload, stdout);
 
 	if (signature_check.gpg_output)
-		fputs(signature_check.gpg_output, stderr);
+		fputs(raw ? signature_check.gpg_status : signature_check.gpg_output, stderr);
 
 	signature_check_clear(&signature_check);
 	return signature_check.result != 'G';
 }
 
-static int verify_commit(const char *name, int verbose)
+static int verify_commit(const char *name, int verbose, int raw)
 {
 	enum object_type type;
 	unsigned char sha1[20];
@@ -54,7 +54,7 @@ static int verify_commit(const char *name, int verbose)
 		return error("%s: cannot verify a non-commit object of type %s.",
 				name, typename(type));
 
-	ret = run_gpg_verify(sha1, buf, size, verbose);
+	ret = run_gpg_verify(sha1, buf, size, verbose, raw);
 
 	free(buf);
 	return ret;
@@ -70,9 +70,10 @@ static int git_verify_commit_config(const char *var, const char *value, void *cb
 
 int cmd_verify_commit(int argc, const char **argv, const char *prefix)
 {
-	int i = 1, verbose = 0, had_error = 0;
+	int i = 1, verbose = 0, had_error = 0, raw = 0;
 	const struct option verify_commit_options[] = {
 		OPT__VERBOSE(&verbose, N_("print commit contents")),
+		OPT_BOOL(0, "raw", &raw, N_("print raw gpg status output")),
 		OPT_END()
 	};
 
@@ -87,7 +88,7 @@ int cmd_verify_commit(int argc, const char **argv, const char *prefix)
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
-		if (verify_commit(argv[i++], verbose))
+		if (verify_commit(argv[i++], verbose, raw))
 			had_error = 1;
 	return had_error;
 }
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 13331e5..ef316f2 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -81,6 +81,38 @@ test_expect_success GPG 'verify and show signatures' '
 	)
 '
 
+test_expect_success GPG 'verify signatures with --raw' '
+	(
+		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
+		do
+			git verify-commit --raw $commit 2>actual &&
+			grep "GOODSIG" actual &&
+			! grep "BADSIG" actual &&
+			echo $commit OK || exit 1
+		done
+	) &&
+	(
+		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
+		do
+			test_must_fail git verify-commit --raw $commit 2>actual &&
+			! grep "GOODSIG" actual &&
+			! grep "BADSIG" actual &&
+			echo $commit OK || exit 1
+		done
+	) &&
+	(
+		for commit in eighth-signed-alt
+		do
+			# Undefined trust causes verify-commit to exit abnormally.
+			test_must_fail git verify-commit --raw $commit 2>actual &&
+			grep "GOODSIG" actual &&
+			! grep "BADSIG" actual &&
+			grep "TRUST_UNDEFINED" actual &&
+			echo $commit OK || exit 1
+		done
+	)
+'
+
 test_expect_success GPG 'show signed commit with signature' '
 	git show -s initial >commit &&
 	git show -s --show-signature initial >show &&
-- 
2.4.0
