From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 2/5] diff: allow --patch & cie to override -s/--no-patch
Date: Mon, 15 Jul 2013 19:05:11 +0200
Message-ID: <1373907914-8020-3-git-send-email-Matthieu.Moy@imag.fr>
References: <7vppujbwuh.fsf@alter.siamese.dyndns.org>
 <1373907914-8020-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: stefanbeller@googlemail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 15 19:15:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UymNE-00008h-HN
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab3GORPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:15:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44654 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab3GORPk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:15:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6FH5Hq2032582
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 19:05:17 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UymD9-0003g1-H1; Mon, 15 Jul 2013 19:05:19 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1UymD9-00026d-79; Mon, 15 Jul 2013 19:05:19 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <1373907914-8020-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Jul 2013 19:05:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FH5Hq2032582
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374512720.05208@j4GWpL/I8J4YnmIyTRR7Yw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230496>

All options that trigger a patch output now override --no-patch.

The case of --binary is particular as the name may suggest that it turns
a normal patch into a binary patch, but it actually already enables patch
output when normally disabled (e.g. "git log --binary" displays a patch),
hence it makes sense that "git show --no-patch --binary" display the
binary patch.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This is the one which changed.

 diff.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

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
-- 
1.8.3.1.495.g13f33cf.dirty
