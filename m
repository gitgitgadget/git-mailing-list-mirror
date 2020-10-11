Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89073C433E7
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 22:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB182074D
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 22:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="RWjFkT9C";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="RWjFkT9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbgJKWvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 18:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387717AbgJKWvF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 18:51:05 -0400
X-Greylist: delayed 156 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Oct 2020 15:51:04 PDT
Received: from mail.sammserver.com (sammserver.com [IPv6:2001:470:5a5b:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE753C0613CE
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 15:51:04 -0700 (PDT)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id A51D3110018B; Mon, 12 Oct 2020 00:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602456505; bh=R1s2yEnsnXCIUip44XBtzDGha1jpIX2Wiah+0IxuPx8=;
        h=From:To:Cc:Subject:Date:From;
        b=RWjFkT9CBQk+ForcNsKhZS92fw28sIaey1pWdLJdFD51dVENKyYbsOkb6Y0Cd7FE8
         9v8xFPuU/n0DIi7mPqDzFBAdolI+iQGRT4mGiauh0fT1RFBjPfsxJ/4t41VQeKOrQ8
         3z1BvQ+An1Ra3Xrbiy9pE7UWxnNFoWxzThTeTKu8=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id 5BF1C1100188;
        Mon, 12 Oct 2020 00:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602456505; bh=R1s2yEnsnXCIUip44XBtzDGha1jpIX2Wiah+0IxuPx8=;
        h=From:To:Cc:Subject:Date:From;
        b=RWjFkT9CBQk+ForcNsKhZS92fw28sIaey1pWdLJdFD51dVENKyYbsOkb6Y0Cd7FE8
         9v8xFPuU/n0DIi7mPqDzFBAdolI+iQGRT4mGiauh0fT1RFBjPfsxJ/4t41VQeKOrQ8
         3z1BvQ+An1Ra3Xrbiy9pE7UWxnNFoWxzThTeTKu8=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 431CB1420A8F; Mon, 12 Oct 2020 00:48:25 +0200 (CEST)
From:   =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
Subject: [PATCH] sequencer: fix gpg option passed to octopus merge
Date:   Mon, 12 Oct 2020 00:48:04 +0200
Message-Id: <20201011224804.722607-1-samuel@cavoj.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When performing octopus merges with interactive rebase with gpgsign
enabled (either using rebase -S or config commit.gpgsign), the operation
would fail on the merge. Instead of "-S%s" with the key id substituted,
only the bare key id would get passed to the underlying merge command,
which tried to interpret it as a ref.

Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
---
It is unclear to me whether I should have based this off of maint or
master, master made more sense to me. I apologize if maint was the
correct one, please tell and I will resubmit.
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.28.0

