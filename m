Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1A1C43457
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A9B212CC
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="ZCCXG0KK";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="AhnLdcFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439938AbgJQXQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 19:16:09 -0400
Received: from lithium.sammserver.com ([168.119.122.30]:33522 "EHLO
        lithium.sammserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439930AbgJQXQH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 19:16:07 -0400
Received: from mail.sammserver.com (sammserver.wg [10.32.40.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by lithium.sammserver.com (Postfix) with ESMTPS id 54083312B5AD;
        Sun, 18 Oct 2020 01:16:05 +0200 (CEST)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id 0C5161120A01; Sun, 18 Oct 2020 01:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602976565; bh=QqvBo8u2Xq74KIbnT8Xajw1Dpr6aeuHc1QoaFmaZtec=;
        h=From:To:Cc:Subject:Date:From;
        b=ZCCXG0KKDHBko/h7Qddnx2isx514I/cGeLe9Whxo/SVIRSBYu4cH33yNVN01wiyNe
         N3OEhMAl7Y2cskms4j6pgSMb1TxIJb/iaFCPfm+zLBIyAj4k0RWAfFQPLBulYcUHFP
         wdTwLQhWDKcJdx2Rvlf1hFvcOD9PkR5X9q8zhW40=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id C13CF11209F9;
        Sun, 18 Oct 2020 01:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602976564; bh=QqvBo8u2Xq74KIbnT8Xajw1Dpr6aeuHc1QoaFmaZtec=;
        h=From:To:Cc:Subject:Date:From;
        b=AhnLdcFltM3C7fgZSwl2CjamiqwQjqN/kexphLtlfgueYx5OKcp/DTAqogm1xQ9Pi
         6BR/r4ANtyO7W29y+lqAxZaVgvd1YdN8bfZjJuToFVqcBYi5CoKfxyXfcC9vSAuAgV
         wTfeMU+pdQbERy1CMBg4jNHi4Z2teD7Jebb/A6Bg=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id AEC8D1420A90; Sun, 18 Oct 2020 01:16:04 +0200 (CEST)
From:   =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
Subject: [PATCH v4 1/3] sequencer: fix gpg option passed to merge subcommand
Date:   Sun, 18 Oct 2020 01:15:55 +0200
Message-Id: <20201017231557.1001728-1-samuel@cavoj.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When performing a rebase with --rebase-merges using either a custom
strategy specified with -s or an octopus merge, and at the same time
having gpgsign enabled (either rebase -S or config commit.gpgsign), the
operation would fail on making the merge commit. Instead of "-S%s" with
the key id substituted, only the bare key id would get passed to the
underlying merge command, which tried to interpret it as a ref.

Fix the issue and add test cases as suggested by Johannes Schindelin and
Junio C Hamano.

Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
---
changed v3 -> v4:
    - added explicit test_unconfig to test case
    - use git config instead of test_config
    - added one more test case
---
 sequencer.c                |  2 +-
 t/t3435-rebase-gpg-sign.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 00acb12496..88ccff4838 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3677,7 +3677,7 @@ static int do_merge(struct repository *r,
 		strvec_push(&cmd.args, "-F");
 		strvec_push(&cmd.args, git_path_merge_msg(r));
 		if (opts->gpg_sign)
-			strvec_push(&cmd.args, opts->gpg_sign);
+			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
 
 		/* Add the tips to be merged */
 		for (j = to_merge; j; j = j->next)
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index b47c59c190..a2b7625707 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -68,4 +68,25 @@ test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
 	test_must_fail git verify-commit HEAD
 '
 
+test_expect_success 'rebase -r, merge strategy, --gpg-sign will sign commit' '
+	git reset --hard merged &&
+	test_unconfig commit.gpgsign &&
+	git rebase -fr --gpg-sign -s resolve --root &&
+	git verify-commit HEAD
+'
+
+test_expect_success 'rebase -r, merge strategy, commit.gpgsign=true will sign commit' '
+	git reset --hard merged &&
+	git config commit.gpgsign true &&
+	git rebase -fr -s resolve --root &&
+	git verify-commit HEAD
+'
+
+test_expect_success 'rebase -r, merge strategy, commit.gpgsign=false --gpg-sign will sign commit' '
+	git reset --hard merged &&
+	git config commit.gpgsign false &&
+	git rebase -fr --gpg-sign -s resolve --root &&
+	git verify-commit HEAD
+'
+
 test_done
-- 
2.28.0

