From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t2203,t4011: adjust to changed intent-to-add treatment
Date: Mon,  9 Mar 2015 16:45:25 +0100
Message-ID: <40da6c2f97f836acbaa654f470a007e06a47a22e.1425915714.git.git@drmicha.warpmail.net>
References: <1425910445-27383-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 16:45:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUzs9-0001fe-HT
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 16:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbbCIPpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 11:45:32 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43167 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753840AbbCIPp2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2015 11:45:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id F1249203A8
	for <git@vger.kernel.org>; Mon,  9 Mar 2015 11:45:25 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 09 Mar 2015 11:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=imQLi08X7zjpTq
	7A8DdI5IEcES8=; b=R65SwI3X1PYhtYBSMp4hbAaUUFxyoyVIKqW7UxTyHbWS1B
	KFZdjeY3ychcG1ZXZrfdqYG8hgG43nnhDgYySMKwZtGQJyVISLQz66aZmChHLsFb
	lW4qAfvdRroJ6zsfG7TmZ+tlOHBvrJeYLD7vI+b1OG/G1PGpoIaSMPdCk2G/0=
X-Sasl-enc: rOagZ9KUJWEC1oaVDz/fTPU35vWZiCUDxHSfUAoFWFSL 1425915927
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1261FC002A4;
	Mon,  9 Mar 2015 11:45:26 -0400 (EDT)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <1425910445-27383-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265171>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
For the record, the tests would need to change like this, and it makes
a lot of sense. After the change, "i-t-a" is not a "change staged in
the index" any more - and in fact in never was, as "git commit" shows.

 t/t2203-add-intent.sh   |  7 ++++---
 t/t4011-diff-symlink.sh | 10 ++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 2a4a749..1a9b3c4 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -43,7 +43,8 @@ test_expect_success 'i-t-a entry is simply ignored' '
 	git add -N nitfol &&
 	git commit -m second &&
 	test $(git ls-tree HEAD -- nitfol | wc -l) = 0 &&
-	test $(git diff --name-only HEAD -- nitfol | wc -l) = 1
+	test $(git diff --name-only HEAD -- nitfol | wc -l) = 0 &&
+	test $(git diff --name-only -- nitfol | wc -l) = 1
 '
 
 test_expect_success 'can commit with an unrelated i-t-a entry in index' '
@@ -71,13 +72,13 @@ test_expect_success 'cache-tree invalidates i-t-a paths' '
 
 	: >dir/bar &&
 	git add -N dir/bar &&
-	git diff --cached --name-only >actual &&
+	git diff --name-only >actual &&
 	echo dir/bar >expect &&
 	test_cmp expect actual &&
 
 	git write-tree >/dev/null &&
 
-	git diff --cached --name-only >actual &&
+	git diff --name-only >actual &&
 	echo dir/bar >expect &&
 	test_cmp expect actual
 '
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 13e7f62..7452fce 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -139,11 +139,13 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
 test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
 	cat >expect <<-\EOF &&
 	diff --git a/file.bin b/file.bin
-	index e69de29..d95f3ad 100644
-	Binary files a/file.bin and b/file.bin differ
+	new file mode 100644
+	index 0000000..d95f3ad
+	Binary files /dev/null and b/file.bin differ
 	diff --git a/link.bin b/link.bin
-	index e69de29..dce41ec 120000
-	--- a/link.bin
+	new file mode 120000
+	index 0000000..dce41ec
+	--- /dev/null
 	+++ b/link.bin
 	@@ -0,0 +1 @@
 	+file.bin
-- 
2.3.1.303.g5174db1
