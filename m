From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 6/7] verify-commit: add option to print raw gpg status information
Date: Sun, 21 Jun 2015 23:14:42 +0000
Message-ID: <1434928483-105916-7-git-send-email-sandals@crustytoothpaste.net>
References: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 01:15:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6oSO-0006ER-AM
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 01:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbbFUXPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 19:15:17 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51201 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753408AbbFUXO6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2015 19:14:58 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7BA6828099;
	Sun, 21 Jun 2015 23:14:57 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272305>

verify-commit by default displays human-readable output on standard
error.  However, it can also be useful to get access to the raw gpg
status information, which is machine-readable, allowing automated
implementation of signing policy.  Add a --raw option to make
verify-commit produce the gpg status information on standard error
instead of the human-readable format.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-verify-commit.txt |  4 ++++
 builtin/verify-commit.c             | 15 ++++++++++-----
 gpg-interface.c                     |  7 +++++--
 gpg-interface.h                     |  1 +
 t/t7510-signed-commit.sh            | 31 +++++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 7 deletions(-)

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
index 016319a..38bedf8 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -18,7 +18,7 @@ static const char * const verify_commit_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned long size, int verbose)
+static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned long size, unsigned flags)
 {
 	struct signature_check signature_check;
 	int ret;
@@ -26,13 +26,13 @@ static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned l
 	memset(&signature_check, 0, sizeof(signature_check));
 
 	ret = check_commit_signature(lookup_commit(sha1), &signature_check);
-	print_signature_buffer(&signature_check, verbose ? GPG_VERIFY_VERBOSE : 0);
+	print_signature_buffer(&signature_check, flags);
 
 	signature_check_clear(&signature_check);
 	return ret;
 }
 
-static int verify_commit(const char *name, int verbose)
+static int verify_commit(const char *name, unsigned flags)
 {
 	enum object_type type;
 	unsigned char sha1[20];
@@ -50,7 +50,7 @@ static int verify_commit(const char *name, int verbose)
 		return error("%s: cannot verify a non-commit object of type %s.",
 				name, typename(type));
 
-	ret = run_gpg_verify(sha1, buf, size, verbose);
+	ret = run_gpg_verify(sha1, buf, size, flags);
 
 	free(buf);
 	return ret;
@@ -67,8 +67,10 @@ static int git_verify_commit_config(const char *var, const char *value, void *cb
 int cmd_verify_commit(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
+	unsigned flags = 0;
 	const struct option verify_commit_options[] = {
 		OPT__VERBOSE(&verbose, N_("print commit contents")),
+		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
 		OPT_END()
 	};
 
@@ -79,11 +81,14 @@ int cmd_verify_commit(int argc, const char **argv, const char *prefix)
 	if (argc <= i)
 		usage_with_options(verify_commit_usage, verify_commit_options);
 
+	if (verbose)
+		flags |= GPG_VERIFY_VERBOSE;
+
 	/* sometimes the program was terminated because this signal
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
-		if (verify_commit(argv[i++], verbose))
+		if (verify_commit(argv[i++], flags))
 			had_error = 1;
 	return had_error;
 }
diff --git a/gpg-interface.c b/gpg-interface.c
index e764fb6..3dc2fe3 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -87,11 +87,14 @@ int check_signature(const char *payload, size_t plen, const char *signature,
 
 void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 {
+	const char *output = flags & GPG_VERIFY_RAW ?
+		sigc->gpg_status : sigc->gpg_output;
+
 	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
 		fputs(sigc->payload, stdout);
 
-	if (sigc->gpg_output)
-		fputs(sigc->gpg_output, stderr);
+	if (output)
+		fputs(output, stderr);
 }
 
 /*
diff --git a/gpg-interface.h b/gpg-interface.h
index 1207861..ea68885 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -2,6 +2,7 @@
 #define GPG_INTERFACE_H
 
 #define GPG_VERIFY_VERBOSE	1
+#define GPG_VERIFY_RAW		2
 
 struct signature_check {
 	char *payload;
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 796138f..18e5cf0 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -88,6 +88,37 @@ test_expect_success GPG 'verify-commit exits success on untrusted signature' '
 	grep "not certified" actual
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
+			git verify-commit --raw $commit 2>actual &&
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
