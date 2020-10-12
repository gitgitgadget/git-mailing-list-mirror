Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF45FC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 23:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C23120838
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 23:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="Kw5LIdEs";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="Kw5LIdEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389516AbgJLXtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 19:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388855AbgJLXtI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 19:49:08 -0400
Received: from mail.sammserver.com (sammserver.com [IPv6:2001:470:5a5b:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EF8C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 16:49:08 -0700 (PDT)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id 3233A1105843; Tue, 13 Oct 2020 01:49:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602546546; bh=7LR2nL8MZsveSBKY9u/ti2tusGjEurio7AY6BUrALw0=;
        h=From:To:Cc:Subject:Date:From;
        b=Kw5LIdEs3XklTP6hWaSoyFaOc+lg0MQoLvmKZ/NpSK3VbFFAmaVE0nB2BZgu7D4lb
         x0Fv26Hm/bbRB0YPVwV9zmyv/Q6G9r8NwfPAIhAVwZX+WH5QAOkGJ+Z4WImluRSq2y
         k3/oR1sNObr92nr5eT6NY3CdZfiZAmT/Z+/uGwTM=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id E92861105837;
        Tue, 13 Oct 2020 01:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602546546; bh=7LR2nL8MZsveSBKY9u/ti2tusGjEurio7AY6BUrALw0=;
        h=From:To:Cc:Subject:Date:From;
        b=Kw5LIdEs3XklTP6hWaSoyFaOc+lg0MQoLvmKZ/NpSK3VbFFAmaVE0nB2BZgu7D4lb
         x0Fv26Hm/bbRB0YPVwV9zmyv/Q6G9r8NwfPAIhAVwZX+WH5QAOkGJ+Z4WImluRSq2y
         k3/oR1sNObr92nr5eT6NY3CdZfiZAmT/Z+/uGwTM=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id D1BAB1420A8F; Tue, 13 Oct 2020 01:49:05 +0200 (CEST)
From:   =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
Subject: [PATCH v2 1/2] sequencer: fix gpg option passed to merge subcommand
Date:   Tue, 13 Oct 2020 01:49:00 +0200
Message-Id: <20201012234901.1356948-1-samuel@cavoj.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

When performing a rebase with --rebase-merges using either a custom
strategy specified with -s or an octopus merge, and at the same time
having gpgsign enabled (either rebase -S or config commit.gpgsign), the
operation would fail on making the merge commit. Instead of "-S%s" with
the key id substituted, only the bare key id would get passed to the
underlying merge command, which tried to interpret it as a ref.

Fix the issue and add a test case as suggested by Johannes Schindelin.

Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
---
changed v1 -> v2:
    added test case
---
 sequencer.c                | 2 +-
 t/t3435-rebase-gpg-sign.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
index b47c59c190..f70b280f5c 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -68,4 +68,10 @@ test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
 	test_must_fail git verify-commit HEAD
 '
 
+test_expect_success 'rebase -r, GPG and merge strategies' '
+	git reset --hard merged &&
+	git rebase -fr --gpg-sign -s resolve --root &&
+	git verify-commit HEAD
+'
+
 test_done
-- 
2.28.0

