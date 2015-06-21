From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/7] verify-tag: add tests
Date: Sun, 21 Jun 2015 23:14:37 +0000
Message-ID: <1434928483-105916-2-git-send-email-sandals@crustytoothpaste.net>
References: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 01:15:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6oS8-00066b-R6
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 01:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbbFUXO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 19:14:57 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51175 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752342AbbFUXOy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2015 19:14:54 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9B29828094;
	Sun, 21 Jun 2015 23:14:53 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272303>

verify-tag was lacking tests.  Add some, mirroring those used for
verify-commit.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7030-verify-tag.sh | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 t/t7030-verify-tag.sh

diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
new file mode 100755
index 0000000..632bc53
--- /dev/null
+++ b/t/t7030-verify-tag.sh
@@ -0,0 +1,84 @@
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
+
+	echo 2 >file && test_tick && git commit -a -m second &&
+	git tag -s -m second second &&
+
+	git checkout side &&
+	echo 3 >elif && git add elif &&
+	test_tick && git commit -m "third on side" &&
+
+	git checkout master &&
+	test_tick && git merge -S side &&
+	git tag -s -m merge merge &&
+
+	echo 4 >file && test_tick && git commit -a -S -m "fourth unsigned" &&
+	git tag -a -m fourth-unsigned fourth-unsigned &&
+
+	test_tick && git commit --amend -S -m "fourth signed" &&
+	git tag -s -m fourth fourth-signed &&
+
+	echo 5 >file && test_tick && git commit -a -m "fifth" &&
+	git tag fifth-unsigned &&
+
+	git config commit.gpgsign true &&
+	echo 6 >file && test_tick && git commit -a -m "sixth" &&
+	git tag -a -m sixth sixth-unsigned &&
+
+	test_tick && git rebase -f HEAD^^ && git tag -s -m 6th sixth-signed HEAD^ &&
+	git tag -m seventh -s seventh-signed &&
+
+	echo 8 >file && test_tick && git commit -a -m eighth &&
+	git tag -uB7227189 -m eighth eighth-signed-alt
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
+test_expect_success GPG 'detect fudged signature' '
+	git cat-file tag seventh-signed >raw &&
+	sed -e "s/seventh/7th forged/" raw >forged1 &&
+	git hash-object -w -t tag forged1 >forged1.tag &&
+	test_must_fail git verify-tag $(cat forged1.tag) 2>actual1 &&
+	grep "BAD signature from" actual1 &&
+	! grep "Good signature from" actual1
+'
+
+test_done
-- 
2.4.0
