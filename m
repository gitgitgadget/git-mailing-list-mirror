Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843C4C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 09:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236DB20B1F
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 09:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="Nx7UqkgH";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="Nx7UqkgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgJNJV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbgJNJVz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:55 -0400
Received: from mail.sammserver.com (sammserver.com [IPv6:2001:470:5a5b:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7497CC0613E5
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 14:31:28 -0700 (PDT)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id E3BF2110A4CB; Tue, 13 Oct 2020 23:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602624686; bh=4IXKUbq2cExyCQlkpsniwatKHlhenog3doN7aRuJ/8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nx7UqkgHOlI8GQrjQ7YncE10I88P78cKhwFZPbn6Y3FgZzz5jn4LrtxGtdmpd4rcg
         Q2XaftbeqljeRtaGpB9xykBu97bCsyjgk3QjZWaMKMGfJPUoHheQcwv+Io+8x+VbIe
         XZfTauHT4op3LJnxwyRypzmCaPGWVCQZYMpxsjEs=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id 3DA17110A4BB;
        Tue, 13 Oct 2020 23:31:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602624686; bh=4IXKUbq2cExyCQlkpsniwatKHlhenog3doN7aRuJ/8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nx7UqkgHOlI8GQrjQ7YncE10I88P78cKhwFZPbn6Y3FgZzz5jn4LrtxGtdmpd4rcg
         Q2XaftbeqljeRtaGpB9xykBu97bCsyjgk3QjZWaMKMGfJPUoHheQcwv+Io+8x+VbIe
         XZfTauHT4op3LJnxwyRypzmCaPGWVCQZYMpxsjEs=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 282EC1420A91; Tue, 13 Oct 2020 23:31:24 +0200 (CEST)
From:   =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
Subject: [PATCH v3 3/3] sequencer: pass explicit --no-gpg-sign to merge
Date:   Tue, 13 Oct 2020 23:30:24 +0200
Message-Id: <20201013213021.3671432-3-samuel@cavoj.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013213021.3671432-1-samuel@cavoj.net>
References: <20201013213021.3671432-1-samuel@cavoj.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The merge subcommand launched for merges with non-default strategy would
use its own default behaviour to decide how to sign commits, regardless
of what opts->gpg_sign was set to. For example the --no-gpg-sign flag
given to rebase explicitly would get ignored, if commit.gpgsign was set
to true.

Fix the issue and add a test case excercising this behaviour.

Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
---
v2 -> v3:
    - added test case
---
 sequencer.c                | 2 ++
 t/t3435-rebase-gpg-sign.sh | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 88ccff4838..043d606829 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3678,6 +3678,8 @@ static int do_merge(struct repository *r,
 		strvec_push(&cmd.args, git_path_merge_msg(r));
 		if (opts->gpg_sign)
 			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
+		else
+			strvec_push(&cmd.args, "--no-gpg-sign");
 
 		/* Add the tips to be merged */
 		for (j = to_merge; j; j = j->next)
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index 9d2faffa03..773c2a1d72 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -81,4 +81,11 @@ test_expect_success 'rebase -r, GPG config and merge strategies' '
 	git verify-commit HEAD
 '
 
+test_expect_success 'rebase -r, --no-gpg-sign and merge strategies' '
+	git reset --hard merged &&
+	test_config commit.gpgsign true &&
+	git rebase -fr --no-gpg-sign -s resolve --root &&
+	test_must_fail git verify-commit HEAD
+'
+
 test_done
-- 
2.28.0

