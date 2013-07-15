From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3 3/6] diff: allow --patch & cie to override -s/--no-patch
Date: Mon, 15 Jul 2013 19:55:22 +0200
Message-ID: <1373910925-18422-4-git-send-email-Matthieu.Moy@imag.fr>
References: <20130715173536.GB14690@google.com>
 <1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: jrnieder@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 15 19:56:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyn0Y-0004as-IU
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab3GOR4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:56:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45491 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753556Ab3GOR4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:56:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6FHtsn3010117
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 19:55:54 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Uyn09-00043h-4X; Mon, 15 Jul 2013 19:55:57 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Uyn08-0004oM-R5; Mon, 15 Jul 2013 19:55:56 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Jul 2013 19:55:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FHtsn3010117
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374515756.2575@VuS1Z88ipboB+45MCZxvJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230505>

All options that trigger a patch output now override --no-patch.

The case of --binary is particular as the name may suggest that it turns
a normal patch into a binary patch, but it actually already enables patch
output when normally disabled (e.g. "git log --binary" displays a patch),
hence it makes sense that "git show --no-patch --binary" display the
binary patch.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 diff.c                 | 28 +++++++++++++++++-----------
 t/t4000-diff-format.sh |  5 +++++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 6bd821d..66ab714 100644
--- a/diff.c
+++ b/diff.c
@@ -3508,6 +3508,11 @@ static int parse_submodule_opt(struct diff_options *options, const char *value)
 	return 1;
 }
 
+static void enable_patch_output(int *fmt) {
+	*fmt &= ~DIFF_FORMAT_NO_OUTPUT;
+	*fmt |= DIFF_FORMAT_PATCH;
+}
+
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
@@ -3515,15 +3520,15 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	int argcount;
 
 	/* Output format options */
-	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch"))
-		options->output_format |= DIFF_FORMAT_PATCH;
-	else if (opt_arg(arg, 'U', "unified", &options->context))
-		options->output_format |= DIFF_FORMAT_PATCH;
+	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch")
+	    || opt_arg(arg, 'U', "unified", &options->context))
+		enable_patch_output(&options->output_format);
 	else if (!strcmp(arg, "--raw"))
 		options->output_format |= DIFF_FORMAT_RAW;
-	else if (!strcmp(arg, "--patch-with-raw"))
-		options->output_format |= DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW;
-	else if (!strcmp(arg, "--numstat"))
+	else if (!strcmp(arg, "--patch-with-raw")) {
+		enable_patch_output(&options->output_format);
+		options->output_format |= DIFF_FORMAT_RAW;
+	} else if (!strcmp(arg, "--numstat"))
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
@@ -3545,9 +3550,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
 		options->output_format |= DIFF_FORMAT_SUMMARY;
-	else if (!strcmp(arg, "--patch-with-stat"))
-		options->output_format |= DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT;
-	else if (!strcmp(arg, "--name-only"))
+	else if (!strcmp(arg, "--patch-with-stat")) {
+		enable_patch_output(&options->output_format);
+		options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	} else if (!strcmp(arg, "--name-only"))
 		options->output_format |= DIFF_FORMAT_NAME;
 	else if (!strcmp(arg, "--name-status"))
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
@@ -3624,7 +3630,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
-		options->output_format |= DIFF_FORMAT_PATCH;
+		enable_patch_output(&options->output_format);
 		DIFF_OPT_SET(options, BINARY);
 	}
 	else if (!strcmp(arg, "--full-index"))
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index d702575..4fce12f 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -71,4 +71,9 @@ test_expect_success 'git diff-files --no-patch as synonym for -s' '
 	test_must_be_empty err
 '
 
+test_expect_success 'git diff-files --no-patch --patch shows the patch' '
+	git diff-files --no-patch --patch >diff-np-output 2>err &&
+	compare_diff_patch expected actual
+'
+
 test_done
-- 
1.8.3.1.495.g13f33cf.dirty
