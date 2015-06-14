From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/3] verify-tag: add tests
Date: Sun, 14 Jun 2015 18:51:49 +0000
Message-ID: <1434307910-705555-3-git-send-email-sandals@crustytoothpaste.net>
References: <1434307910-705555-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 20:52:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4D11-0003RX-4z
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 20:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbbFNSwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 14:52:13 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:43777 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753110AbbFNSwL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2015 14:52:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 67D7528093;
	Sun, 14 Jun 2015 18:52:10 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434307910-705555-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1 ALL_TRUSTED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271645>

verify-tag was lacking tests.  Add some, mirroring those used for
verify-commit.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7030-verify-tag.sh | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 t/t7030-verify-tag.sh

diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
new file mode 100755
index 0000000..9ca0d29
--- /dev/null
+++ b/t/t7030-verify-tag.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description='signed tag tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success GPG 'create signed tags' '
+	echo 1 >file && git add file &&
+	test_tick && git commit -m initial &&
+	git tag -s -m initial initial &&
+	git branch side &&
+	echo a &&
+
+	echo 2 >file && test_tick && git commit -a -m second &&
+	git tag -s -m second second &&
+	echo b &&
+
+	git checkout side &&
+	echo 3 >elif && git add elif &&
+	test_tick && git commit -m "third on side" &&
+	echo c &&
+
+	git checkout master &&
+	test_tick && git merge -S side &&
+	git tag -s -m merge merge &&
+	echo d &&
+
+	echo 4 >file && test_tick && git commit -a -S -m "fourth unsigned" &&
+	git tag -a -m fourth-unsigned fourth-unsigned &&
+	echo e &&
+
+	test_tick && git commit --amend -S -m "fourth signed" &&
+	git tag -s -m fourth fourth-signed &&
+	echo f &&
+
+	echo 5 >file && test_tick && git commit -a -m "fifth" &&
+	git tag fifth-unsigned &&
+	echo g &&
+
+	git config commit.gpgsign true &&
+	echo 6 >file && test_tick && git commit -a -m "sixth" &&
+	git tag -a -m sixth sixth-unsigned &&
+	echo h &&
+
+	test_tick && git rebase -f HEAD^^ && git tag -s -m 6th sixth-signed HEAD^ &&
+	git tag -m seventh -s seventh-signed &&
+	echo i &&
+
+	echo 8 >file && test_tick && git commit -a -m eighth &&
+	git tag -uB7227189 -m eighth eighth-signed-alt &&
+	echo j
+'
+
+test_expect_success GPG 'verify and show signatures' '
+	(
+		for tag in initial second merge fourth-signed sixth-signed seventh-signed
+		do
+			git verify-tag $tag 2>actual &&
+			grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			echo $tag OK || exit 1
+		done
+	) &&
+	(
+		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
+		do
+			test_must_fail git verify-tag $tag 2>actual &&
+			! grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			echo $tag OK || exit 1
+		done
+	) &&
+	(
+		for tag in eighth-signed-alt
+		do
+			git verify-tag $tag 2>actual &&
+			grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			grep "not certified" actual &&
+			echo $tag OK || exit 1
+		done
+	)
+'
+
+test_done
-- 
2.4.0
