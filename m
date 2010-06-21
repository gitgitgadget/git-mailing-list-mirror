From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/3] add tests for checkout -b
Date: Tue, 22 Jun 2010 01:19:40 +0800
Message-ID: <1277140782-4064-2-git-send-email-rctay89@gmail.com>
References: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org>
 <1277140782-4064-1-git-send-email-rctay89@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>,
	Erick Mattos <erick.mattos@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 21 19:20:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQkfh-0007d1-MJ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 19:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115Ab0FURUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 13:20:21 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36947 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758063Ab0FURUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 13:20:19 -0400
Received: by pvh11 with SMTP id 11so334465pvh.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=h7duYMnlFVQIsxgv5eOZWNVkrEDcXixPfCprf+fUpZs=;
        b=oAM4Sz8poBsPIfjf9ZXfTBRT6al255XUudbXEuRNsebCq3aLr5bRiHvM1RloiC3Bxn
         SJYC8VhZWKYWOeoIHzobL+kWBE1Tlm3xjA8ddV3GXMKYzGfgzE/oMIpXDzooSdelm9Hw
         BtIpetlBT534Ek7aYNAPyZtD/gVekkgf5ALtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bYFWV0x3jSzjFXGpgqXmHdELQEUWE9ybK7hbE+0Ka+6BY60LqB1g8E4WT+zT3TKxo/
         nHjk+NVzE5Lw85YGrI8KMRqKasXOLfzE/nzeiynUkS57P7J25kEalnPTyKAqY3mhHfp7
         ygBbwj2jCvALhj59lhMQ4hC9BiZaNotjN1Btk=
Received: by 10.114.214.26 with SMTP id m26mr4181401wag.204.1277140818399;
        Mon, 21 Jun 2010 10:20:18 -0700 (PDT)
Received: from localhost.localdomain (cm134.zeta152.maxonline.com.sg [116.87.152.134])
        by mx.google.com with ESMTPS id b6sm32760016wam.21.2010.06.21.10.20.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 10:20:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.513.g06a69
In-Reply-To: <1277140782-4064-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149421>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t2018-checkout-branch.sh |  121 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100755 t/t2018-checkout-branch.sh

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
new file mode 100755
index 0000000..3c13065
--- /dev/null
+++ b/t/t2018-checkout-branch.sh
@@ -0,0 +1,121 @@
+#!/bin/sh
+
+test_description='checkout '
+
+. ./test-lib.sh
+
+# Arguments: <branch> <sha> [<checkout options>]
+#
+# Runs "git checkout" to switch to <branch>, testing that
+#
+#   1) we are on the specified branch, <branch>;
+#   2) HEAD is <sha>; if <sha> is not specified, the old HEAD is used.
+#
+# If <checkout options> is not specified, "git checkout" is run with -b.
+do_checkout() {
+	exp_branch=$1 &&
+	exp_ref="refs/heads/$exp_branch" &&
+
+	# if <sha> is not specified, use HEAD.
+	exp_sha=${2:-$(git rev-parse --verify HEAD)} &&
+
+	# default options for git checkout: -b
+	if [ -z "$3" ]; then
+		opts="-b"
+	else
+		opts="$3"
+	fi
+
+	git checkout $opts $exp_branch $exp_sha &&
+
+	test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
+	test $exp_sha = $(git rev-parse --verify HEAD)
+}
+
+test_dirty_unmergeable() {
+	! git diff --exit-code >/dev/null
+}
+
+setup_dirty_unmergeable() {
+	echo >>file1 change2
+}
+
+test_dirty_mergeable() {
+	! git diff --cached --exit-code >/dev/null
+}
+
+setup_dirty_mergeable() {
+	echo >file2 file2 &&
+	git add file2
+}
+
+test_expect_success 'setup' '
+	test_commit initial file1 &&
+	HEAD1=$(git rev-parse --verify HEAD) &&
+
+	test_commit change1 file1 &&
+	HEAD2=$(git rev-parse --verify HEAD) &&
+
+	git branch -m branch1
+'
+
+test_expect_success 'checkout -b to a new branch, set to HEAD' '
+	do_checkout branch2
+'
+
+test_expect_success 'checkout -b to a new branch, set to an explicit ref' '
+	git checkout branch1 &&
+	git branch -D branch2 &&
+
+	do_checkout branch2 $HEAD1
+'
+
+test_expect_success 'checkout -b to a new branch with unmergeable changes fails' '
+	git checkout branch1 &&
+
+	# clean up from previous test
+	git branch -D branch2 &&
+
+	setup_dirty_unmergeable &&
+	test_must_fail do_checkout branch2 $HEAD1 &&
+	test_dirty_unmergeable
+'
+
+test_expect_success 'checkout -f -b to a new branch with unmergeable changes discards changes' '
+	# still dirty and on branch1
+	do_checkout branch2 $HEAD1 "-f -b" &&
+	test_must_fail test_dirty_unmergeable
+'
+
+test_expect_success 'checkout -b to a new branch preserves mergeable changes' '
+	git checkout branch1 &&
+
+	# clean up from previous test
+	git branch -D branch2 &&
+
+	setup_dirty_mergeable &&
+	do_checkout branch2 $HEAD1 &&
+	test_dirty_mergeable
+'
+
+test_expect_success 'checkout -f -b to a new branch with mergeable changes discards changes' '
+	# clean up from previous test
+	git reset --hard &&
+
+	git checkout branch1 &&
+
+	# clean up from previous test
+	git branch -D branch2 &&
+
+	setup_dirty_mergeable &&
+	do_checkout branch2 $HEAD1 "-f -b" &&
+	test_must_fail test_dirty_mergeable
+'
+
+test_expect_success 'checkout -b to an existing branch fails' '
+	git reset --hard HEAD &&
+
+	test_must_fail do_checkout branch2 $HEAD2
+'
+
+test_done
-- 
1.7.1.513.g4f18
