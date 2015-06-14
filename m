From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/3] verify-tag: add option to print raw gpg status information
Date: Sun, 14 Jun 2015 18:51:50 +0000
Message-ID: <1434307910-705555-4-git-send-email-sandals@crustytoothpaste.net>
References: <1434307910-705555-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 20:52:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4D1B-0003W0-OT
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 20:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278AbbFNSwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 14:52:21 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:43779 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753209AbbFNSwL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2015 14:52:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9107528094;
	Sun, 14 Jun 2015 18:52:10 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434307910-705555-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1 ALL_TRUSTED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271646>

verify-tag by default displays human-readable output on standard error.
However, it can also be useful to get access to the raw gpg status
information, which is machine-readable, allowing automated
implementation of signing policy.  Add a --raw option to make verify-tag
produce the gpg status information on standard error instead of the
human-readable format.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-verify-tag.txt |  4 ++++
 builtin/verify-tag.c             | 21 +++++++++++++++------
 t/t7030-verify-tag.sh            | 31 +++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 6 deletions(-)

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
index 53c68fc..745c013 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -18,9 +18,12 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
+static int run_gpg_verify(const char *buf, unsigned long size, int verbose, int raw)
 {
+	struct strbuf status = STRBUF_INIT, human_readable = STRBUF_INIT;
+	const struct strbuf *output = raw ? &status : &human_readable;
 	int len;
+	int ret;
 
 	len = parse_signature(buf, size);
 	if (verbose)
@@ -29,10 +32,15 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	if (size == len)
 		return error("no signature found");
 
-	return verify_signed_buffer(buf, len, buf + len, size - len, NULL, NULL);
+	ret = verify_signed_buffer(buf, len, buf + len, size - len, &human_readable,
+			&status);
+
+	fputs(output->buf, stderr);
+
+	return ret;
 }
 
-static int verify_tag(const char *name, int verbose)
+static int verify_tag(const char *name, int verbose, int raw)
 {
 	enum object_type type;
 	unsigned char sha1[20];
@@ -52,7 +60,7 @@ static int verify_tag(const char *name, int verbose)
 	if (!buf)
 		return error("%s: unable to read file.", name);
 
-	ret = run_gpg_verify(buf, size, verbose);
+	ret = run_gpg_verify(buf, size, verbose, raw);
 
 	free(buf);
 	return ret;
@@ -68,9 +76,10 @@ static int git_verify_tag_config(const char *var, const char *value, void *cb)
 
 int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
-	int i = 1, verbose = 0, had_error = 0;
+	int i = 1, verbose = 0, had_error = 0, raw = 0;
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
+		OPT_BOOL(0, "raw", &raw, N_("print raw gpg status output")),
 		OPT_END()
 	};
 
@@ -85,7 +94,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
-		if (verify_tag(argv[i++], verbose))
+		if (verify_tag(argv[i++], verbose, raw))
 			had_error = 1;
 	return had_error;
 }
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 9ca0d29..0ac15e6 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -82,4 +82,35 @@ test_expect_success GPG 'verify and show signatures' '
 	)
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
