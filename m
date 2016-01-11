From: David Greene <greened@obbligato.org>
Subject: [PATCH 5/5] Add test for rebase with merges amd redundant commits
Date: Sun, 10 Jan 2016 23:00:21 -0600
Message-ID: <1452488421-26823-6-git-send-email-greened@obbligato.org>
References: <1452488421-26823-1-git-send-email-greened@obbligato.org>
Cc: gitster@pobox.com, peff@peff.net, chris@arachsys.com,
	nhorman@tuxdriver.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 06:01:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIUbi-0005RB-7N
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 06:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbcAKFBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 00:01:08 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:53981 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751248AbcAKFAm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 00:00:42 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aIUc1-0005H8-Tm; Sun, 10 Jan 2016 23:01:50 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1452488421-26823-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283636>

From: "David A. Greene" <greened@obbligato.org>

This tests rebase --preserve-merges in the presence of redundant
commits when there are actual erges being rebased.  It primarily
exercises the --skip-redundant-commits option.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 t/t3429-rebase-redundant-merge.sh | 73 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100755 t/t3429-rebase-redundant-merge.sh

diff --git a/t/t3429-rebase-redundant-merge.sh b/t/t3429-rebase-redundant-merge.sh
new file mode 100755
index 0000000..f677bb1
--- /dev/null
+++ b/t/t3429-rebase-redundant-merge.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+test_description='git rebase tests for redundant commits
+
+This test runs git rebase and tests handling of redundant commits.
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+# Setup this graph:
+#
+# O
+# o-o-o-o-o R/rebaseOR/rebaseSR/rebasemergeOR/rebasemergeSR
+#  \   /
+#   o-o S
+#
+test_expect_success 'setup' '
+	test_commit README &&
+	git branch O &&
+	git checkout -b branch O &&
+	test_commit branch1 &&
+	test_commit branch2 &&
+	git branch S &&
+	git checkout master &&
+	test_commit master1 &&
+	test_commit master2 &&
+	git merge branch -m "Merge branch to master" &&
+	test_commit merged1 &&
+	git branch R &&
+	git branch rebaseOR &&
+	git branch rebaseSR &&
+	git branch rebasemergeOR &&
+	git branch rebasemergeskipOR &&
+	git branch rebasemergeSR &&
+	git branch rebasemergeskipSR
+'
+
+test_expect_success 'rebase O..R --onto S' '
+	reset_rebase &&
+	git checkout rebaseOR &&
+	git rebase O --onto S
+'
+
+test_expect_success 'rebase S..R --onto S' '
+	reset_rebase &&
+	git checkout rebaseSR &&
+	git rebase S --onto S
+'
+
+test_expect_success 'rebase O..R --onto S preserving merges fails' '
+	reset_rebase &&
+	git checkout rebasemergeOR &&
+	test_must_fail git rebase --preserve-merges O --onto S
+'
+
+test_expect_success 'rebase O..R --onto S preserving merges --skip-redundant' '
+	reset_rebase &&
+	git checkout rebasemergeskipOR &&
+	git rebase --skip-redundant-commits --preserve-merges O --onto S
+'
+
+test_expect_success 'rebase S..R --onto S preserving merges' '
+	reset_rebase &&
+	git checkout rebasemergeSR &&
+	git rebase --preserve-merges S --onto S
+'
+
+test_expect_success 'rebase S..R --onto S preserving merges --skip-redundant' '
+	reset_rebase &&
+	git checkout rebasemergeskipSR &&
+	git rebase --skip-redundant-commits --preserve-merges S --onto S
+'
+test_done
-- 
2.6.1
