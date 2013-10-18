From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4 2/2] checkout: proper error message on 'git checkout foo bar --'
Date: Fri, 18 Oct 2013 11:25:58 +0200
Message-ID: <1382088358-2213-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1382088358-2213-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: pclouds@gmail.com, jc@sahnwaldt.de, jrnieder@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 18 11:26:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VX6K0-0006vR-PB
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 11:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab3JRJ0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 05:26:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60132 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452Ab3JRJ0M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 05:26:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r9I9Q4Ru024713
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Oct 2013 11:26:04 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VX6Jo-0002ur-W9; Fri, 18 Oct 2013 11:26:05 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VX6Jo-0000af-M1; Fri, 18 Oct 2013 11:26:04 +0200
X-Mailer: git-send-email 1.8.4.479.g0ed768e
In-Reply-To: <1382088358-2213-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 18 Oct 2013 11:26:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r9I9Q4Ru024713
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1382693165.775@CB7rPZGgJemxZU+lFjs1YA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236337>

The previous code was detecting the presence of "--" by looking only at
argument 1. As a result, "git checkout foo bar --" was interpreted as an
ambiguous file/revision list, and errored out with:

error: pathspec 'foo' did not match any file(s) known to git.
error: pathspec 'bar' did not match any file(s) known to git.
error: pathspec '--' did not match any file(s) known to git.

This patch fixes it by walking through the argument list to find the
"--", and now complains about the number of references given.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Unchanged since v3.

 builtin/checkout.c            | 21 ++++++++++++++++-----
 t/t2010-checkout-ambiguous.sh |  6 ++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2003795..54f80bd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -873,7 +873,9 @@ static int parse_branchname_arg(int argc, const char **argv,
 	int argcount = 0;
 	unsigned char branch_rev[20];
 	const char *arg;
-	int has_dash_dash;
+	int dash_dash_pos;
+	int has_dash_dash = 0;
+	int i;
 
 	/*
 	 * case 1: git checkout <ref> -- [<paths>]
@@ -917,11 +919,20 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!argc)
 		return 0;
 
-	if (!strcmp(argv[0], "--"))	/* case (2) */
-		return 1;
-
 	arg = argv[0];
-	has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
+	dash_dash_pos = -1;
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--")) {
+			dash_dash_pos = i;
+			break;
+		}
+	}
+	if (dash_dash_pos == 0)
+		return 1; /* case (2) */
+	else if (dash_dash_pos == 1)
+		has_dash_dash = 1; /* case (3) or (1) */
+	else if (dash_dash_pos >= 2)
+		die(_("only one reference expected, %d given."), dash_dash_pos);
 
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index 7cc0a35..87bdf9c 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -47,4 +47,10 @@ test_expect_success 'disambiguate checking out from a tree-ish' '
 	git diff --exit-code --quiet
 '
 
+test_expect_success 'accurate error message with more than one ref' '
+	test_must_fail git checkout HEAD master -- 2>actual &&
+	grep 2 actual &&
+	test_i18ngrep "one reference expected, 2 given" actual
+'
+
 test_done
-- 
1.8.4.479.g0ed768e
