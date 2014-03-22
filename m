From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 01/10] t4209: set up expectations up front
Date: Sat, 22 Mar 2014 18:15:51 +0100
Message-ID: <1395508560-19893-2-git-send-email-l.s.r@web.de>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 18:17:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRPY9-00030i-SW
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 18:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbaCVRQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 13:16:54 -0400
Received: from mout.web.de ([212.227.17.12]:60525 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbaCVRQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 13:16:36 -0400
Received: from debian.fritz.box ([79.253.149.120]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MeSLv-1WkL100oZT-00QE4I; Sat, 22 Mar 2014 18:16:13
 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395508560-19893-1-git-send-email-l.s.r@web.de>
X-Provags-ID: V03:K0:NAJUtnMQQG9WogHByNIKfCK3+juiYV7SC27xpgR+B9BCO08XMFY
 fqJS30K2/sbuVm8vf4SpHEMQkojI6VIUU4MYKypOFvcrpVAlGywNDtsjCLCKM/RjnlvLv+B
 NWZ2ar+non0Cfc7fBPobkpbUEB0S3KqDE8Ow0CCE8E8o4F3Qc5lmwBP1whU+Fuf0hEft+IB
 e+cWHuuQVghzBYWLOK/jg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244780>

Instead of creating an expect file for each test, build three files with
the possible valid values during setup and use them in the tests.  This
shortens the test code and saves nine calls to git rev-parse.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4209-log-pickaxe.sh | 64 ++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 39 deletions(-)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 38fb80f..ff668b5 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -4,80 +4,74 @@ test_description='log --grep/--author/--regexp-ignore-case/-S/-G'
 . ./test-lib.sh
 
 test_expect_success setup '
+	>expect_nomatch &&
+
 	>file &&
 	git add file &&
 	test_tick &&
 	git commit -m initial &&
+	git rev-parse --verify HEAD >expect_initial &&
 
 	echo Picked >file &&
+	git add file &&
 	test_tick &&
-	git commit -a --author="Another Person <another@example.com>" -m second
+	git commit --author="Another Person <another@example.com>" -m second &&
+	git rev-parse --verify HEAD >expect_second
 '
 
 test_expect_success 'log --grep' '
 	git log --grep=initial --format=%H >actual &&
-	git rev-parse --verify HEAD^ >expect &&
-	test_cmp expect actual
+	test_cmp expect_initial actual
 '
 
 test_expect_success 'log --grep --regexp-ignore-case' '
 	git log --regexp-ignore-case --grep=InItial --format=%H >actual &&
-	git rev-parse --verify HEAD^ >expect &&
-	test_cmp expect actual
+	test_cmp expect_initial actual
 '
 
 test_expect_success 'log --grep -i' '
 	git log -i --grep=InItial --format=%H >actual &&
-	git rev-parse --verify HEAD^ >expect &&
-	test_cmp expect actual
+	test_cmp expect_initial actual
 '
 
 test_expect_success 'log --author --regexp-ignore-case' '
 	git log --regexp-ignore-case --author=person --format=%H >actual &&
-	git rev-parse --verify HEAD >expect &&
-	test_cmp expect actual
+	test_cmp expect_second actual
 '
 
 test_expect_success 'log --author -i' '
 	git log -i --author=person --format=%H >actual &&
-	git rev-parse --verify HEAD >expect &&
-	test_cmp expect actual
+	test_cmp expect_second actual
 '
 
 test_expect_success 'log -G (nomatch)' '
 	git log -Gpicked --format=%H >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_cmp expect_nomatch actual
 '
 
 test_expect_success 'log -G (match)' '
 	git log -GPicked --format=%H >actual &&
-	git rev-parse --verify HEAD >expect &&
-	test_cmp expect actual
+	test_cmp expect_second actual
 '
 
 test_expect_success 'log -G --regexp-ignore-case (nomatch)' '
 	git log --regexp-ignore-case -Gpickle --format=%H >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_cmp expect_nomatch actual
 '
 
 test_expect_success 'log -G -i (nomatch)' '
 	git log -i -Gpickle --format=%H >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_cmp expect_nomatch actual
 '
 
 test_expect_success 'log -G --regexp-ignore-case (match)' '
 	git log --regexp-ignore-case -Gpicked --format=%H >actual &&
-	git rev-parse --verify HEAD >expect &&
-	test_cmp expect actual
+	test_cmp expect_second actual
 '
 
 test_expect_success 'log -G -i (match)' '
 	git log -i -Gpicked --format=%H >actual &&
-	git rev-parse --verify HEAD >expect &&
-	test_cmp expect actual
+	test_cmp expect_second actual
 '
 
 test_expect_success 'log -G --textconv (missing textconv tool)' '
@@ -89,45 +83,38 @@ test_expect_success 'log -G --textconv (missing textconv tool)' '
 test_expect_success 'log -G --no-textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
 	git -c diff.test.textconv=missing log -Gfoo --no-textconv >actual &&
-	>expect &&
-	test_cmp expect actual &&
+	test_cmp expect_nomatch actual &&
 	rm .gitattributes
 '
 
 test_expect_success 'log -S (nomatch)' '
 	git log -Spicked --format=%H >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_cmp expect_nomatch actual
 '
 
 test_expect_success 'log -S (match)' '
 	git log -SPicked --format=%H >actual &&
-	git rev-parse --verify HEAD >expect &&
-	test_cmp expect actual
+	test_cmp expect_second actual
 '
 
 test_expect_success 'log -S --regexp-ignore-case (match)' '
 	git log --regexp-ignore-case -Spicked --format=%H >actual &&
-	git rev-parse --verify HEAD >expect &&
-	test_cmp expect actual
+	test_cmp expect_second actual
 '
 
 test_expect_success 'log -S -i (match)' '
 	git log -i -Spicked --format=%H >actual &&
-	git rev-parse --verify HEAD >expect &&
-	test_cmp expect actual
+	test_cmp expect_second actual
 '
 
 test_expect_success 'log -S --regexp-ignore-case (nomatch)' '
 	git log --regexp-ignore-case -Spickle --format=%H >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_cmp expect_nomatch actual
 '
 
 test_expect_success 'log -S -i (nomatch)' '
 	git log -i -Spickle --format=%H >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_cmp expect_nomatch actual
 '
 
 test_expect_success 'log -S --textconv (missing textconv tool)' '
@@ -139,8 +126,7 @@ test_expect_success 'log -S --textconv (missing textconv tool)' '
 test_expect_success 'log -S --no-textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
 	git -c diff.test.textconv=missing log -Sfoo --no-textconv >actual &&
-	>expect &&
-	test_cmp expect actual &&
+	test_cmp expect_nomatch actual &&
 	rm .gitattributes
 '
 
-- 
1.9.1
