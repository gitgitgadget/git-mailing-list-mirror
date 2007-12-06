From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] for-each-ref: Fix quoting style constants.
Date: Thu,  6 Dec 2007 13:11:46 +0100
Message-ID: <1196943106-4559-1-git-send-email-johannes.sixt@telecom.at>
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 13:12:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Fac-0008E3-IO
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 13:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbXLFMLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 07:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbXLFMLy
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 07:11:54 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21528 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbXLFMLx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 07:11:53 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1J0FZD-0000qq-EN; Thu, 06 Dec 2007 13:11:00 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 77F9054D; Thu,  6 Dec 2007 13:11:47 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 39C80FA45; Thu,  6 Dec 2007 13:11:47 +0100 (CET)
X-Mailer: git-send-email 1.5.3.7.1079.gecca
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67276>

for-each-ref can accept only one quoting style. For this reason it uses
OPT_BIT for the quoting style switches so that it is easy to check for
more than one bit being set. However, not all symbolic constants were
actually single bit values. In particular:

    $ git for-each-ref --python
    error: more than one quoting style ?

This fixes it.

While we are here, let's also remove the space before the question mark.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-for-each-ref.c  |    6 +++---
 t/t6300-for-each-ref.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index daf3a08..f36a43c 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -13,8 +13,8 @@
 #define QUOTE_NONE 0
 #define QUOTE_SHELL 1
 #define QUOTE_PERL 2
-#define QUOTE_PYTHON 3
-#define QUOTE_TCL 4
+#define QUOTE_PYTHON 4
+#define QUOTE_TCL 8
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -861,7 +861,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		usage_with_options(for_each_ref_usage, opts);
 	}
 	if (HAS_MULTI_BITS(quote_style)) {
-		error("more than one quoting style ?");
+		error("more than one quoting style?");
 		usage_with_options(for_each_ref_usage, opts);
 	}
 	if (verify_format(format))
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c722635..c5d0721 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -169,5 +169,49 @@ test_expect_success 'Verify descending sort' '
 	git diff expected actual
 '
 
+cat >expected <<\EOF
+'refs/heads/master'
+'refs/tags/testtag'
+EOF
+
+test_expect_success 'Quoting style: shell' '
+	git for-each-ref --shell --format="%(refname)" >actual &&
+	git diff expected actual
+'
+
+test_expect_success 'Quoting style: perl' '
+	git for-each-ref --perl --format="%(refname)" >actual &&
+	git diff expected actual
+'
+
+test_expect_success 'Quoting style: python' '
+	git for-each-ref --python --format="%(refname)" >actual &&
+	git diff expected actual
+'
+
+test_expect_success 'Quoting style: tcl' '
+	git for-each-ref --python --format="%(refname)" >actual &&
+	git diff expected actual
+'
+
+cat >expected <<\EOF
+"refs/heads/master"
+"refs/tags/testtag"
+EOF
+
+test_expect_success 'Quoting style: shell' '
+	git for-each-ref --tcl --format="%(refname)" >actual &&
+	git diff expected actual
+'
+
+for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
+	test_expect_success "more than one quoting style: $i" "
+		git for-each-ref $i 2>&1 | (read line &&
+		case \$line in
+		\"error: more than one quoting style\"*) : happy;;
+		*) false
+		esac)
+	"
+done
 
 test_done
-- 
1.5.3.7.1079.gecca
