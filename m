From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 4/6] t7810-grep: test interaction of multiple --grep and --author options
Date: Thu, 13 Sep 2012 16:04:42 +0200
Message-ID: <dfbe954c5248a41740fc120be0fe425ecf1f06ca.1347544259.git.git@drmicha.warpmail.net>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 16:05:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCA2d-00073N-EV
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 16:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940Ab2IMOFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 10:05:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51405 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755445Ab2IMOEw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 10:04:52 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1AB98208EC;
	Thu, 13 Sep 2012 10:04:52 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 13 Sep 2012 10:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=IN
	nLog4ioabqZXmmUgKf8h5q9lw=; b=P2WkqX33NaFw1YVyNQF7u9xId8WWqJBRSD
	T/WN77YnNsmRqqD+xj2FWKC6/7L4SRlGfz49C/S4qGuC5BQ5XbDHezJqY3SrRc3m
	DKEr/zncaUHkmwIC8puLh8M66oeUs6OzyGMZP2gGTGtnH2mjo4y3RPTOai5oM0CZ
	kyB3fsR+4=
X-Sasl-enc: Shyk3C1tIpWq8kilaXT/8p4YazuITchqXFkG3pJ0nu/v 1347545091
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AFD1B4836EA;
	Thu, 13 Sep 2012 10:04:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.463.gbd9d638
In-Reply-To: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347544259.git.git@drmicha.warpmail.net>
References: <cover.1347544259.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205380>

There are tests for this interaction already. Restructure slightly and
avoid any claims about --all-match.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7810-grep.sh | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 9bc63a3..f98f3f6 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -562,16 +562,6 @@ test_expect_success 'log --all-match with multiple --grep uses intersection' '
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
@@ -588,17 +578,33 @@ test_expect_success 'log --all-match with multiple --author still uses union' '
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
1.7.12.463.gbd9d638
