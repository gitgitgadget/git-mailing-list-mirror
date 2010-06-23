From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 1/3] add tests for checkout -b
Date: Thu, 24 Jun 2010 03:28:58 +0800
Message-ID: <1277321340-4000-2-git-send-email-rctay89@gmail.com>
References: <1277140782-4064-1-git-send-email-rctay89@gmail.com>
 <1277321340-4000-1-git-send-email-rctay89@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>,
	Erick Mattos <erick.mattos@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:29:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVdX-0001e5-LN
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab0FWT3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 15:29:20 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46285 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0FWT3S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 15:29:18 -0400
Received: by pvg2 with SMTP id 2so50023pvg.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=h7duYMnlFVQIsxgv5eOZWNVkrEDcXixPfCprf+fUpZs=;
        b=mj0iO0tbx3i/P8+n2YTv8678KbGLbI9Dsjg16Vsdbn4hNH/bAxwe6cqpJT9e+vKN15
         /ycfs6cQ5pVHL35HikepRqa9PxeYDa8NGBSJNaA7twSd/HXbLtWa9n3W+wexM5VbrNkD
         6Oo1mkPRN2XrKlgMp3wtLE8xy+9VZzg3YWimM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=B2IR9a3Tp7COuQPkvaZURoBpMYmArSZDFkUN2Ziks/+p9VPc5DIXoIh0YmVkvrQFvc
         HBEMFgcdL9iPwcz3u7qNP/S29i7X5x+GlJoYyli3PH8DBkvUPoyhVrh417OrnyC45ux9
         aQbyahO2yEvs/RcT8XzA9l/mo4O3weRXKmjM4=
Received: by 10.142.6.35 with SMTP id 35mr7739377wff.79.1277321357595;
        Wed, 23 Jun 2010 12:29:17 -0700 (PDT)
Received: from localhost.localdomain (cm156.zeta152.maxonline.com.sg [116.87.152.156])
        by mx.google.com with ESMTPS id p1sm570577rvq.0.2010.06.23.12.29.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 12:29:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.513.g06a69
In-Reply-To: <1277321340-4000-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149535>

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
