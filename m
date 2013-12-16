From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH] test the commit.gpgsign config option
Date: Mon, 16 Dec 2013 14:55:04 +0100
Message-ID: <1387202104-17580-1-git-send-email-boklm@mars-attacks.org>
References: <xmqqa9g1qrzj.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 14:55:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsYdp-0002jt-Mz
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 14:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385Ab3LPNzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 08:55:18 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:49839 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab3LPNzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 08:55:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id A3CBF4FA4;
	Mon, 16 Dec 2013 14:55:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id urqp-dTRtWB9; Mon, 16 Dec 2013 14:55:35 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id EFEA04676;
	Mon, 16 Dec 2013 14:55:34 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 0D399438C5; Mon, 16 Dec 2013 14:55:13 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <xmqqa9g1qrzj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239335>

The tests are checking that :

- when commit.gpgsign is true, "git commit" creates signed commits

- when commit.gpgsign is false, "git commit" creates unsigned commits

- when commit.gpgsign is true, "git commit --no-gpg-sign" creates
  unsigned commits

- when commit.gpgsign is true, "git rebase -f" creates signed commits

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 t/t7510-signed-commit.sh | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 1d3c56fe61fa..537bfba76ecf 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -25,12 +25,29 @@ test_expect_success GPG 'create signed commits' '
 	git tag fourth-unsigned &&
 
 	test_tick && git commit --amend -S -m "fourth signed" &&
-	git tag fourth-signed
+	git tag fourth-signed &&
+
+	git config commit.gpgsign true &&
+	echo 5 >file && test_tick && git commit -a -m "fifth signed" &&
+	git tag fifth-signed &&
+
+	git config commit.gpgsign false &&
+	echo 6 >file && test_tick && git commit -a -m "sixth" &&
+	git tag sixth-unsigned &&
+
+	git config commit.gpgsign true &&
+	echo 7 >file && test_tick && git commit -a -m "seventh" --no-gpg-sign &&
+	git tag seventh-unsigned &&
+
+	test_tick && git rebase -f HEAD^^ && git tag sixth-signed HEAD^ &&
+	git tag seventh-signed &&
+
+	git config --unset commit.gpgsign
 '
 
 test_expect_success GPG 'show signatures' '
 	(
-		for commit in initial second merge master
+		for commit in initial second merge fourth-signed fifth-signed sixth-signed master
 		do
 			git show --pretty=short --show-signature $commit >actual &&
 			grep "Good signature from" actual || exit 1
@@ -39,7 +56,7 @@ test_expect_success GPG 'show signatures' '
 		done
 	) &&
 	(
-		for commit in merge^2 fourth-unsigned
+		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
 		do
 			git show --pretty=short --show-signature $commit >actual &&
 			grep "Good signature from" actual && exit 1
@@ -52,7 +69,7 @@ test_expect_success GPG 'show signatures' '
 test_expect_success GPG 'detect fudged signature' '
 	git cat-file commit master >raw &&
 
-	sed -e "s/fourth signed/4th forged/" raw >forged1 &&
+	sed -e "s/seventh/7th forged/" raw >forged1 &&
 	git hash-object -w -t commit forged1 >forged1.commit &&
 	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
 	grep "BAD signature from" actual1 &&
-- 
1.8.4.2
