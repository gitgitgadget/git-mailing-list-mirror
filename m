From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t1300: attempting to remove a non-existent .git/config is
 not an error
Date: Wed, 19 Oct 2011 09:37:06 +0200
Message-ID: <4E9E7E22.7010905@viscovery.net>
References: <20111012182742.GA14543@sigill.intra.peff.net> <20111012182920.GA18948@sigill.intra.peff.net> <4E9E7115.60303@viscovery.net> <7vzkgxcviz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 09:37:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGQiH-00005s-FF
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 09:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298Ab1JSHhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 03:37:14 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57823 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349Ab1JSHhN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 03:37:13 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RGQi3-00048h-B7; Wed, 19 Oct 2011 09:37:07 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E1D3F1660F;
	Wed, 19 Oct 2011 09:37:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <7vzkgxcviz.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183925>

From: Johannes Sixt <j6t@kdbg.org>

Since some tests before test number 79 ("quoting") are skipped, .git/config
does not exist and 'rm .git/config' fails. Fix this particular case.

While at it, move other instance of 'rm .git/config' that occur in this
file inside the test function to document that the test cases want to
protect themselves from remnants of earlier tests.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 You may think that the justification of this change would be the
 other way round: protect test cases, then incidentally this fixes
 a failure on Windows. But for me it is as described: The motivation
 is the fix for Windows, and without that, the "protect test cases"
 part would not have happened. :-)

 t/t1300-repo-config.sh |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index fba5ae0..51caff0 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -558,8 +558,6 @@ EOF
 test_expect_success "section was removed properly" \
 	"test_cmp expect .git/config"
 
-rm .git/config
-
 cat > expect << EOF
 [gitcvs]
 	enabled = true
@@ -570,6 +568,7 @@ EOF
 
 test_expect_success 'section ending' '
 
+	rm -f .git/config &&
 	git config gitcvs.enabled true &&
 	git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
 	git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
@@ -642,8 +641,6 @@ test_expect_success 'invalid bool (set)' '
 
 	test_must_fail git config --bool bool.nobool foobar'
 
-rm .git/config
-
 cat > expect <<\EOF
 [bool]
 	true1 = true
@@ -658,6 +655,7 @@ EOF
 
 test_expect_success 'set --bool' '
 
+	rm -f .git/config &&
 	git config --bool bool.true1 01 &&
 	git config --bool bool.true2 -1 &&
 	git config --bool bool.true3 YeS &&
@@ -668,8 +666,6 @@ test_expect_success 'set --bool' '
 	git config --bool bool.false4 FALSE &&
 	cmp expect .git/config'
 
-rm .git/config
-
 cat > expect <<\EOF
 [int]
 	val1 = 1
@@ -679,13 +675,12 @@ EOF
 
 test_expect_success 'set --int' '
 
+	rm -f .git/config &&
 	git config --int int.val1 01 &&
 	git config --int int.val2 -1 &&
 	git config --int int.val3 5m &&
 	cmp expect .git/config'
 
-rm .git/config
-
 cat >expect <<\EOF
 [bool]
 	true1 = true
@@ -699,6 +694,7 @@ cat >expect <<\EOF
 EOF
 
 test_expect_success 'get --bool-or-int' '
+	rm -f .git/config &&
 	(
 		echo "[bool]"
 		echo true1
@@ -718,7 +714,6 @@ test_expect_success 'get --bool-or-int' '
 
 '
 
-rm .git/config
 cat >expect <<\EOF
 [bool]
 	true1 = true
@@ -732,6 +727,7 @@ cat >expect <<\EOF
 EOF
 
 test_expect_success 'set --bool-or-int' '
+	rm -f .git/config &&
 	git config --bool-or-int bool.true1 true &&
 	git config --bool-or-int bool.false1 false &&
 	git config --bool-or-int bool.true2 yes &&
@@ -742,8 +738,6 @@ test_expect_success 'set --bool-or-int' '
 	test_cmp expect .git/config
 '
 
-rm .git/config
-
 cat >expect <<\EOF
 [path]
 	home = ~/
@@ -752,6 +746,7 @@ cat >expect <<\EOF
 EOF
 
 test_expect_success NOT_MINGW 'set --path' '
+	rm -f .git/config &&
 	git config --path path.home "~/" &&
 	git config --path path.normal "/dev/null" &&
 	git config --path path.trailingtilde "foo~" &&
@@ -800,7 +795,7 @@ cat > expect << EOF
 	hash = "test#test"
 EOF
 test_expect_success 'quoting' '
-	rm .git/config &&
+	rm -f .git/config &&
 	git config quote.leading " test" &&
 	git config quote.ending "test " &&
 	git config quote.semicolon "test;test" &&
-- 
1.7.7.1507.g94722
