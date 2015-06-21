From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 7/7] verify-tag: add option to print raw gpg status information
Date: Sun, 21 Jun 2015 23:14:43 +0000
Message-ID: <1434928483-105916-8-git-send-email-sandals@crustytoothpaste.net>
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
	id 1Z6oSN-0006ER-9A
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 01:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbbFUXPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 19:15:15 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51208 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753499AbbFUXO7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2015 19:14:59 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 17E1F2809A;
	Sun, 21 Jun 2015 23:14:58 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272306>

verify-tag by default displays human-readable output on standard error.
However, it can also be useful to get access to the raw gpg status
information, which is machine-readable, allowing automated
implementation of signing policy.  Add a --raw option to make verify-tag
produce the gpg status information on standard error instead of the
human-readable format.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-verify-tag.txt |  4 ++++
 builtin/verify-tag.c             | 17 +++++++++++------
 t/t7030-verify-tag.sh            | 31 +++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index f88ba96..d590edc 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -16,6 +16,10 @@ Validates the gpg signature created by 'git tag'.
 
 OPTIONS
 -------
+--raw::
+	Print the raw gpg status output to standard error instead of the normal
+	human-readable output.
+
 -v::
 --verbose::
 	Print the contents of the tag object before validating it.
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index d67e3db..00663f6 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -18,7 +18,7 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
+static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 {
 	struct signature_check sigc;
 	int len;
@@ -29,19 +29,19 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	len = parse_signature(buf, size);
 
 	if (size == len) {
-		if (verbose)
+		if (flags & GPG_VERIFY_VERBOSE)
 			write_in_full(1, buf, len);
 		return error("no signature found");
 	}
 
 	ret = check_signature(buf, len, buf + len, size - len, &sigc);
-	print_signature_buffer(&sigc, verbose ? GPG_VERIFY_VERBOSE : 0);
+	print_signature_buffer(&sigc, flags);
 
 	signature_check_clear(&sigc);
 	return ret;
 }
 
-static int verify_tag(const char *name, int verbose)
+static int verify_tag(const char *name, unsigned flags)
 {
 	enum object_type type;
 	unsigned char sha1[20];
@@ -61,7 +61,7 @@ static int verify_tag(const char *name, int verbose)
 	if (!buf)
 		return error("%s: unable to read file.", name);
 
-	ret = run_gpg_verify(buf, size, verbose);
+	ret = run_gpg_verify(buf, size, flags);
 
 	free(buf);
 	return ret;
@@ -78,8 +78,10 @@ static int git_verify_tag_config(const char *var, const char *value, void *cb)
 int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
+	unsigned flags = 0;
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
+		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
 		OPT_END()
 	};
 
@@ -90,11 +92,14 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (argc <= i)
 		usage_with_options(verify_tag_usage, verify_tag_options);
 
+	if (verbose)
+		flags |= GPG_VERIFY_VERBOSE;
+
 	/* sometimes the program was terminated because this signal
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
-		if (verify_tag(argv[i++], verbose))
+		if (verify_tag(argv[i++], flags))
 			had_error = 1;
 	return had_error;
 }
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 632bc53..4608e71 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -81,4 +81,35 @@ test_expect_success GPG 'detect fudged signature' '
 	! grep "Good signature from" actual1
 '
 
+test_expect_success GPG 'verify signatures with --raw' '
+	(
+		for tag in initial second merge fourth-signed sixth-signed seventh-signed
+		do
+			git verify-tag --raw $tag 2>actual &&
+			grep "GOODSIG" actual &&
+			! grep "BADSIG" actual &&
+			echo $tag OK || exit 1
+		done
+	) &&
+	(
+		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
+		do
+			test_must_fail git verify-tag --raw $tag 2>actual &&
+			! grep "GOODSIG" actual &&
+			! grep "BADSIG" actual &&
+			echo $tag OK || exit 1
+		done
+	) &&
+	(
+		for tag in eighth-signed-alt
+		do
+			git verify-tag --raw $tag 2>actual &&
+			grep "GOODSIG" actual &&
+			! grep "BADSIG" actual &&
+			grep "TRUST_UNDEFINED" actual &&
+			echo $tag OK || exit 1
+		done
+	)
+'
+
 test_done
-- 
2.4.0
