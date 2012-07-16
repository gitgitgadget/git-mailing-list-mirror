From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH 2/2] symbolic-ref: check format of given refname
Date: Mon, 16 Jul 2012 14:13:01 +0200
Message-ID: <1342440781-18816-3-git-send-email-mschub@elegosoft.com>
References: <1342440781-18816-1-git-send-email-mschub@elegosoft.com>
Cc: Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 14:16:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqkDr-00077f-KR
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 14:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121Ab2GPMQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 08:16:16 -0400
Received: from schu.io ([178.77.73.177]:57313 "EHLO
	lvps178-77-73-177.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751182Ab2GPMQP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2012 08:16:15 -0400
Received: from myhost.elego.de (i59F7870A.versanet.de [89.247.135.10])
	by lvps178-77-73-177.dedicated.hosteurope.de (Postfix) with ESMTPSA id C602314954001;
	Mon, 16 Jul 2012 14:16:14 +0200 (CEST)
X-Mailer: git-send-email 1.7.11.2.196.ga22866b
In-Reply-To: <1342440781-18816-1-git-send-email-mschub@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201515>

Currently, it's possible to update HEAD with a nonsense reference since
no strict validation ist performed. Example:

	$ git symbolic-ref HEAD 'refs/heads/master
    >
    >
    > '

Fix this by checking the given reference with check_refname_format().

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 builtin/symbolic-ref.c  |  4 +++-
 t/t1401-symbolic-ref.sh | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 801d62e..a529541 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -44,13 +44,15 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options,
 			     git_symbolic_ref_usage, 0);
-	if (msg &&!*msg)
+	if (msg && !*msg)
 		die("Refusing to perform update with empty message");
 	switch (argc) {
 	case 1:
 		check_symref(argv[0], quiet);
 		break;
 	case 2:
+		if (check_refname_format(argv[1], 0))
+			die("No valid reference format: '%s'", argv[1]);
 		if (!strcmp(argv[0], "HEAD") &&
 		    prefixcmp(argv[1], "refs/"))
 			die("Refusing to point HEAD outside of refs/");
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 2c96551..b1cd508 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -27,6 +27,16 @@ test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
 '
 reset_to_sane
 
+test_expect_success 'symbolic-ref refuses ref with leading dot' '
+	test_must_fail git symbolic-ref HEAD refs/heads/.foo
+'
+reset_to_sane
+
+test_expect_success 'symbolic-ref refuses ref with leading dash' '
+	test_must_fail git symbolic-ref HEAD refs/heads/-foo
+'
+reset_to_sane
+
 test_expect_success 'symbolic-ref refuses bare sha1' '
 	echo content >file && git add file && git commit -m one &&
 	test_must_fail git symbolic-ref HEAD `git rev-parse HEAD`
-- 
1.7.11.2.196.ga22866b
