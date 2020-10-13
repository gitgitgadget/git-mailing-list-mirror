Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BEDC43457
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 09:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0670F214D8
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 09:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="GLWZwqQQ";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="GLWZwqQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgJNJVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbgJNJVv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:51 -0400
Received: from mail.sammserver.com (sammserver.com [IPv6:2001:470:5a5b:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEA6C0613E4
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 14:31:28 -0700 (PDT)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id CA534110A4C4; Tue, 13 Oct 2020 23:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602624686; bh=su5KAzqgrtMwRLhYFUv++V6jrwPYZWRt4O1Fo5Pt1TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLWZwqQQherodPEcMtuk2IpNGGGLtXn1eZTnwQ7RGXv8ZR+GoeWEz1NjVPH+rtmlo
         9lhIKHm1P48OXsqxAeuBlssmxxgob8Kpnv70j4jLQ36zAGc0703Uxc+0DhGBLGKCk9
         4stsxijtG82A9h9jEySj49gmsh9KGbvJUEv0edLo=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id 398EE110A4BA;
        Tue, 13 Oct 2020 23:31:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602624686; bh=su5KAzqgrtMwRLhYFUv++V6jrwPYZWRt4O1Fo5Pt1TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLWZwqQQherodPEcMtuk2IpNGGGLtXn1eZTnwQ7RGXv8ZR+GoeWEz1NjVPH+rtmlo
         9lhIKHm1P48OXsqxAeuBlssmxxgob8Kpnv70j4jLQ36zAGc0703Uxc+0DhGBLGKCk9
         4stsxijtG82A9h9jEySj49gmsh9KGbvJUEv0edLo=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 2233514200ED; Tue, 13 Oct 2020 23:31:24 +0200 (CEST)
From:   =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
Subject: [PATCH v3 2/3] sequencer: fix gpg option passed to merge subcommand
Date:   Tue, 13 Oct 2020 23:30:23 +0200
Message-Id: <20201013213021.3671432-2-samuel@cavoj.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013213021.3671432-1-samuel@cavoj.net>
References: <20201013213021.3671432-1-samuel@cavoj.net>
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

Fix the issue and add test cases as suggested by Johannes Schindelin.

Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
---
changed v2 -> v3:
    - first test is now okay, thanks to patch 1/3
    - added another test for config commit.gpgsign
---
 sequencer.c                |  2 +-
 t/t3435-rebase-gpg-sign.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

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
index 696cb6b6a4..9d2faffa03 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -68,4 +68,17 @@ test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
 	test_must_fail git verify-commit HEAD
 '
 
+test_expect_success 'rebase -r, GPG --gpg-sign and merge strategies' '
+	git reset --hard merged &&
+	git rebase -fr --gpg-sign -s resolve --root &&
+	git verify-commit HEAD
+'
+
+test_expect_success 'rebase -r, GPG config and merge strategies' '
+	git reset --hard merged &&
+	test_config commit.gpgsign true &&
+	git rebase -fr -s resolve --root &&
+	git verify-commit HEAD
+'
+
 test_done
-- 
2.28.0

