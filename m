From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V3 1/2] test for '!' handling in rev-parse's named commits
Date: Sat,  9 Jan 2016 19:22:29 -0700
Message-ID: <1452392549-2656-1-git-send-email-ischis2@cox.net>
References: <1452392429-2578-1-git-send-email-ischis2@cox.net>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Will Palmer <wmpalmer@gmail.com>,
	"Stephen P . Smith" <ischis2@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 03:22:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aI5e1-0000wJ-0s
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 03:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704AbcAJCWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 21:22:09 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:51328 "EHLO
	fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756634AbcAJCWI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2016 21:22:08 -0500
Received: from fed1rmimpo210 ([68.230.241.161]) by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160110022206.MIQQ7752.fed1rmfepo102.cox.net@fed1rmimpo210>
          for <git@vger.kernel.org>; Sat, 9 Jan 2016 21:22:06 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo210 with cox
	id 42N51s00G2tqoqC012N57a; Sat, 09 Jan 2016 21:22:06 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020204.5691C04E.001E,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=Hq2o7TvS c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=7aQ_Q-yQQ-AA:10
 a=pGLkceISAAAA:8 a=TSbVqHtbAAAA:8 a=QDujTDpxwbEU8GLRqUIA:9
 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id F0E0213F7BB;
	Sat,  9 Jan 2016 19:22:53 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
In-Reply-To: <1452392429-2578-1-git-send-email-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283610>

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
    Moved modref branch from 2/2 to the 1/2 patch as discussed in [1] and
    [2].
    
    In [3] the suggestion was made to change ^{!/... to ^{/!.  The comment
    notes that anything after { is reserved and can be used.
    
    The v2 commit mesage (which has been retained) noted that !Message
    should fail as '!' is reserved where !!Message should search for a
    string that contains !Message.
    
    Because of the commit note, I chose not to make the change from
    ^{!/... to ^{/!..
    
    [1] http://article.gmane.org/gmane.comp.version-control.git/271071
    [2] http://article.gmane.org/gmane.comp.version-control.git/283573
    [3] http://article.gmane.org/gmane.comp.version-control.git/283597

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
