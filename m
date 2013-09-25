From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 2/2] checkout: proper error message on 'git checkout foo bar --'
Date: Wed, 25 Sep 2013 21:31:11 +0200
Message-ID: <1380137471-26972-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1380137471-26972-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: pclouds@gmail.com, jc@sahnwaldt.de,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 25 21:31:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOuo7-0006rn-UH
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 21:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab3IYTb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 15:31:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52276 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515Ab3IYTb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 15:31:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8PJVGUG027098
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Sep 2013 21:31:16 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VOunu-0003im-RF; Wed, 25 Sep 2013 21:31:18 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VOunu-00072M-HZ; Wed, 25 Sep 2013 21:31:18 +0200
X-Mailer: git-send-email 1.8.4.474.g128a96c
In-Reply-To: <1380137471-26972-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 25 Sep 2013 21:31:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8PJVGUG027098
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1380742278.57939@lrjDEt24Sm3c67cxUFTSMg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235369>

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
> > +               die("only one reference expected, %d given.", has_dash_dash);
> 
> The translator in me says this string should be marked for translation
> like others in git-checkout...

Indeed. Sorry, it's not like I didn't knoW about _("...") /o\.

 builtin/checkout.c            | 11 ++++++++++-
 t/t2010-checkout-ambiguous.sh |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a5a12f6..3dd45cc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -882,6 +882,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	unsigned char branch_rev[20];
 	const char *arg;
 	int has_dash_dash;
+	int i;
 
 	/*
 	 * case 1: git checkout <ref> -- [<paths>]
@@ -925,7 +926,15 @@ static int parse_branchname_arg(int argc, const char **argv,
 		return 1;
 
 	arg = argv[0];
-	has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
+	has_dash_dash = 0;
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--")) {
+			has_dash_dash = i;
+			break;
+		}
+	}
+	if (has_dash_dash >= 2)
+		die(_("only one reference expected, %d given."), has_dash_dash);
 
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index 7cc0a35..ce6b6e2 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -47,4 +47,10 @@ test_expect_success 'disambiguate checking out from a tree-ish' '
 	git diff --exit-code --quiet
 '
 
+test_expect_success C_LOCALE_OUTPUT 'accurate error message with more than one ref' '
+	test_must_fail git checkout HEAD master -- 2>actual &&
+	echo "fatal: only one reference expected, 2 given." >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.4.474.g128a96c
