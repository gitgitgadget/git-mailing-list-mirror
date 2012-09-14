From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 10/11] t7810-grep: test interaction of multiple --grep and --author options
Date: Fri, 14 Sep 2012 11:46:42 +0200
Message-ID: <e55a91f36d1accfb94fac34aba9ca1eade7b6777.1347615361.git.git@drmicha.warpmail.net>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 11:47:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCSUc-0007Hv-QY
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 11:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753Ab2INJrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 05:47:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60085 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752182Ab2INJrB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 05:47:01 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C618D2078F;
	Fri, 14 Sep 2012 05:47:00 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 14 Sep 2012 05:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=c5
	gIo5tOZmoyyXXQi/FulEwPakM=; b=MbQokuVGfdICOojZyz9bDzepdQS4f8dozj
	K7vFLaN1tX3p9ULJl4qqwhAj+EV2ZhelDf0Ww7r3fL5EUeciO37c4lfZ2bkbY9f1
	KmpBusJL5k4Odsajys8ecptc8yvh+3rvrTE5Rvu+b6BuyjeWQ+F2nFoy3uxBX5r4
	u+sN9HyDA=
X-Sasl-enc: batuXO/7/+6/hJ3L5pxEI1jgVFedGHVLLDIGx8/8PoTy 1347616020
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 653C648260B;
	Fri, 14 Sep 2012 05:47:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.592.g41e7905
In-Reply-To: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347615361.git.git@drmicha.warpmail.net>
References: <cover.1347615361.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205473>

There are tests for this interaction already. Restructure slightly and
avoid any claims about --all-match.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7810-grep.sh | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index be81d96..f6edb4d 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -495,16 +495,6 @@ test_expect_success 'log --all-match with multiple --grep uses intersection' '
 	test_cmp expect actual
 '
 
-test_expect_success 'log --grep --author implicitly uses all-match' '
-	# grep matches initial and second but not third
-	# author matches only initial and third
-	git log --author="A U Thor" --grep=s --grep=l --format=%s >actual &&
-	{
-		echo initial
-	} >expect &&
-	test_cmp expect actual
-'
-
 test_expect_success 'log with multiple --author uses union' '
 	git log --author="Thor" --author="Aster" --format=%s >actual &&
 	{
@@ -521,17 +511,33 @@ test_expect_success 'log --all-match with multiple --author still uses union' '
 	test_cmp expect actual
 '
 
-test_expect_success 'log with --grep and multiple --author uses all-match' '
-	git log --author="Thor" --author="Night" --grep=i --format=%s >actual &&
+test_expect_success 'log --grep --author uses intersection' '
+	# grep matches only third and fourth
+	# author matches only initial and third
+	git log --author="A U Thor" --grep=r --format=%s >actual &&
 	{
-	    echo third && echo initial
+		echo third
 	} >expect &&
 	test_cmp expect actual
 '
 
-test_expect_success 'log with --grep and multiple --author uses all-match' '
-	git log --author="Thor" --author="Night" --grep=q --format=%s >actual &&
-	>expect &&
+test_expect_success 'log --grep --grep --author takes union of greps and intersects with author' '
+	# grep matches initial and second but not third
+	# author matches only initial and third
+	git log --author="A U Thor" --grep=s --grep=l --format=%s >actual &&
+	{
+		echo initial
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --grep --author --author takes union of authors and intersects with grep' '
+	# grep matches only initial and third
+	# author matches all but second
+	git log --author="Thor" --author="Night" --grep=i --format=%s >actual &&
+	{
+	    echo third && echo initial
+	} >expect &&
 	test_cmp expect actual
 '
 
-- 
1.7.12.592.g41e7905
