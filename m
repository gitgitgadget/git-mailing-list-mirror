Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCABC35249
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 23:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D792F20661
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 23:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgBBXdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 18:33:11 -0500
Received: from piie.net ([80.82.223.85]:52778 "EHLO piie.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgBBXdL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 18:33:11 -0500
Received: from localhost (b2b-37-24-240-63.unitymedia.biz [37.24.240.63])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by piie.net (Postfix) with ESMTPSA id 67785260F;
        Mon,  3 Feb 2020 00:32:56 +0100 (CET)
From:   Peter Kaestle <peter@piie.net>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        peter.kaestle@nokia.com, Peter Kaestle <peter@piie.net>
Subject: [PATCH] t7400: testcase for submodule status on unregistered inner git repos
Date:   Mon,  3 Feb 2020 00:32:44 +0100
Message-Id: <20200202233244.199040-1-peter@piie.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <xmqqzhe8bwab.fsf@gitster-ct.c.googlers.com>
References: <xmqqzhe8bwab.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have test coverage for "git submodule status" output in
various cases, i.e.

  1) not-init, not-cloned: status should initially be "missing"
  2) init, not-cloned: status should be "missing"
  3) not-init, cloned: status should ignore the inner git-repo
  4) init, cloned: status should be "up-to-date" after update
  4.1) + modified: status should be "modified" after submodule commit
  4.2) + modified, committed: status should be "up-to-date" after update

the case 3) is not covered yet.

Test that submodule status reports an inner git repo as unknown, while
it is not added to the superproject.  This covers case (3).

Signed-off-by: Peter Kaestle <peter@piie.net>
---
 t/t7400-submodule-basic.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 29dc6812f1..d926b8c772 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -55,6 +55,21 @@ test_expect_success 'add aborts on repository with no commits' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'status should ignore inner git repo when not added' '
+	rm -fr inner &&
+	mkdir inner &&
+	(
+		cd inner &&
+		git init &&
+		>t &&
+		git add t &&
+		git commit -m "initial"
+	) &&
+	test_must_fail git submodule status inner 2>output.err &&
+	rm -fr inner &&
+	test_i18ngrep "^error: .*did not match any file(s) known to git" output.err
+'
+
 test_expect_success 'setup - repository in init subdirectory' '
 	mkdir init &&
 	(
-- 
2.25.0

