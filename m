From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3 2/2] checkout: proper error message on 'git checkout foo bar --'
Date: Thu, 26 Sep 2013 11:08:06 +0200
Message-ID: <1380186486-8220-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1380186486-8220-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: pclouds@gmail.com, jc@sahnwaldt.de, jrnieder@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 26 11:08:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP7Yc-0004wh-8Q
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 11:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862Ab3IZJIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 05:08:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38774 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313Ab3IZJIR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 05:08:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8Q98Bth027581
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Sep 2013 11:08:11 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VP7YS-0001xL-IG; Thu, 26 Sep 2013 11:08:12 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VP7YS-00029h-7z; Thu, 26 Sep 2013 11:08:12 +0200
X-Mailer: git-send-email 1.8.4.474.g128a96c
In-Reply-To: <1380186486-8220-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 26 Sep 2013 11:08:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8Q98Bth027581
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1380791292.26835@QdxK+2R420F5corwNyEK1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235408>

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
Again, Jonathan's comments (partly) applied since v2.

 builtin/checkout.c            | 21 ++++++++++++++++-----
 t/t2010-checkout-ambiguous.sh |  6 ++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9edd9c3..ef6b56a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -880,7 +880,9 @@ static int parse_branchname_arg(int argc, const char **argv,
 	int argcount = 0;
 	unsigned char branch_rev[20];
 	const char *arg;
-	int has_dash_dash;
+	int dash_dash_pos;
+	int has_dash_dash = 0;
+	int i;
 
 	/*
 	 * case 1: git checkout <ref> -- [<paths>]
@@ -924,11 +926,20 @@ static int parse_branchname_arg(int argc, const char **argv,
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
1.8.4.474.g128a96c
