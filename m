From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V4 1/2] test for '!' handling in rev-parse's named commits
Date: Tue, 12 Jan 2016 21:51:48 -0700
Message-ID: <1452660708-5568-1-git-send-email-ischis2@cox.net>
References: <ED12DDDA0C004D23BDDB14973C675800@PhilipOakley>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Will Palmer <wmpalmer@gmail.com>,
	"Stephen P . Smith" <ischis2@cox.net>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 05:51:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJDPY-0006EI-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 05:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbcAMEvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 23:51:52 -0500
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:52426 "EHLO
	fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371AbcAMEvv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 23:51:51 -0500
Received: from fed1rmimpo306 ([68.230.241.174]) by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160113045150.ZZCW22785.fed1rmfepo202.cox.net@fed1rmimpo306>
          for <git@vger.kernel.org>; Tue, 12 Jan 2016 23:51:50 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo306 with cox
	id 5Grp1s00H2tqoqC01Grqyb; Tue, 12 Jan 2016 23:51:50 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020205.5695D7E6.0058,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=LKq4tuq9 c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=7aQ_Q-yQQ-AA:10
 a=pGLkceISAAAA:8 a=ovi2m8PBhnH8zJ8Nv5UA:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 6F0F313F628;
	Tue, 12 Jan 2016 21:51:50 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
In-Reply-To: <ED12DDDA0C004D23BDDB14973C675800@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283878>

From: Will Palmer <wmpalmer@gmail.com>

In anticipation of extending this behaviour, add tests verifying the
handling of exclamation marks when looking up a commit "by name".

Specifically, as documented: '<rev>^{/!Message}' should fail, as the '!'
prefix is reserved; while '<rev>^{!!Message}' should search for a commit
whose message contains the string "!Message".

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
Notes:
    No actual changes made to this patch.  Just re-sending to keep 
    consistent with updates to the rest of the series.
 t/t1511-rev-parse-caret.sh | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index 15973f2..b2f90be 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -18,7 +18,15 @@ test_expect_success 'setup' '
 	git checkout master &&
 	echo modified >>a-blob &&
 	git add -u &&
-	git commit -m Modified
+	git commit -m Modified &&
+	git branch modref &&
+	echo changed! >>a-blob &&
+	git add -u &&
+	git commit -m !Exp &&
+	git branch expref &&
+	echo changed >>a-blob &&
+	git add -u &&
+	git commit -m Changed
 '
 
 test_expect_success 'ref^{non-existent}' '
@@ -77,4 +85,18 @@ test_expect_success 'ref^{/Initial}' '
 	test_cmp expected actual
 '
 
+test_expect_success 'ref^{/!Exp}' '
+	test_must_fail git rev-parse master^{/!Exp}
+'
+
+test_expect_success 'ref^{/!}' '
+	test_must_fail git rev-parse master^{/!}
+'
+
+test_expect_success 'ref^{/!!Exp}' '
+	git rev-parse expref >expected &&
+	git rev-parse master^{/!!Exp} >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.7.0-rc2
