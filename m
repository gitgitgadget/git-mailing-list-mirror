From: David Greene <greened@obbligato.org>
Subject: [PATCH 4/5] Add test for redundant rebase
Date: Sun, 10 Jan 2016 23:00:20 -0600
Message-ID: <1452488421-26823-5-git-send-email-greened@obbligato.org>
References: <1452488421-26823-1-git-send-email-greened@obbligato.org>
Cc: gitster@pobox.com, peff@peff.net, chris@arachsys.com,
	nhorman@tuxdriver.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 06:01:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIUby-0005cL-J2
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 06:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbcAKFBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 00:01:05 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:53973 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751086AbcAKFAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 00:00:40 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aIUc0-0005H8-GN; Sun, 10 Jan 2016 23:01:48 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1452488421-26823-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283639>

From: "David A. Greene" <greened@obbligato.org>

Test that rebase --skip-redundant-commits works.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 t/t3428-rebase-redundant.sh | 100 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100755 t/t3428-rebase-redundant.sh

diff --git a/t/t3428-rebase-redundant.sh b/t/t3428-rebase-redundant.sh
new file mode 100755
index 0000000..eea63e9
--- /dev/null
+++ b/t/t3428-rebase-redundant.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+
+test_description='git rebase tests for redundant commits
+
+This test runs git rebase and tests handling of redundant commits.
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup' '
+	test_commit README &&
+	git checkout -b empty &&
+	test_commit empty1 &&
+	test_commit empty2 &&
+	git commit -m "Empty commit 1" --allow-empty &&
+	test_commit empty3 &&
+	git checkout -b onto master &&
+	test_commit onto1 &&
+	test_commit onto2 &&
+	test_commit onto3 &&
+	git checkout -b dev master &&
+	test_commit dev1 &&
+	test_commit dev2 &&
+	test_commit dev3 &&
+	git checkout -b redundant master &&
+	test_commit onto1 onto1.t onto1 onto1-2 &&
+	test_commit onto2 onto2.t onto2 onto2-2 &&
+	test_commit onto3 onto3.t onto3 onto3-2 &&
+	git checkout -b redundant-empty redundant &&
+	git commit -m "Empty commit 2" --allow-empty &&
+	test_commit empty4
+'
+
+test_expect_success 'default rebase without empty commits' '
+	reset_rebase &&
+	git checkout -b default-non-empty dev &&
+	git rebase --preserve-merges --onto onto master
+'
+
+test_expect_success 'default rebase with empty commits' '
+	reset_rebase &&
+	git checkout -b default-empty empty &&
+	git rebase --preserve-merges --onto onto master
+'
+
+test_expect_success 'default rebase with redundant commits' '
+	reset_rebase &&
+	git checkout -b default-redundant redundant &&
+	git rebase --preserve-merges --onto onto --root
+'
+
+test_expect_success 'rebase --skip-redundant without empty commits' '
+	reset_rebase &&
+	git checkout -b skip-redundant-non-empty dev &&
+	git rebase --skip-redundant-commits --preserve-merges --onto onto master
+'
+
+test_expect_success 'rebase --skip-redundant with empty commits' '
+	reset_rebase &&
+	git checkout -b skip-redundant-empty empty &&
+	git rebase --skip-redundant-commits --preserve-merges --onto onto master
+'
+
+test_expect_success 'rebase --skip-redundant with redundant commits' '
+	reset_rebase &&
+	git checkout -b skip-redundant-redundant redundant &&
+	git rebase --skip-redundant-commits --preserve-merges --onto onto --root
+'
+
+test_expect_success 'rebase --skip-redundant with empty and redundant commits' '
+	reset_rebase &&
+	git checkout -b skip-redundant-empty-redundant redundant-empty &&
+	git rebase --skip-redundant-commits --preserve-merges --onto onto --root
+'
+
+test_expect_success 'rebase --keep-empty --skip-redundant without empty commits' '
+	reset_rebase &&
+	git checkout -b keep-empty-skip-redundant-non-empty dev &&
+	git rebase --keep-empty --skip-redundant-commits --preserve-merges --onto onto master
+'
+
+test_expect_success 'rebase --keep-empty --skip-redundant with empty commits' '
+	reset_rebase &&
+	git checkout -b keep-empty-skip-redundant-empty empty &&
+	git rebase --keep-empty --skip-redundant-commits --preserve-merges --onto onto master
+'
+
+test_expect_success 'rebase --keep-empty --skip-redundant with redundant commits' '
+	reset_rebase &&
+	git checkout -b keep-empty-skip-redundant-redundant redundant &&
+	git rebase --keep-empty --skip-redundant-commits --preserve-merges --onto onto --root
+'
+
+test_expect_success 'rebase --keep-empty --skip-redundant with empty and redundant commits' '
+	reset_rebase &&
+	git checkout -b keep-empty-skip-redundant-empty-redundant redundant-empty &&
+	git rebase --skip-redundant-commits --preserve-merges --onto onto --root
+'
+
+test_done
-- 
2.6.1
