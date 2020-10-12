Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E05C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 23:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 081DA20790
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 23:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="DvIjJPIo";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="DvIjJPIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389532AbgJLXtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 19:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389460AbgJLXtI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 19:49:08 -0400
Received: from mail.sammserver.com (sammserver.com [IPv6:2001:470:5a5b:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC4BC0613D1
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 16:49:08 -0700 (PDT)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id 214FB110583C; Tue, 13 Oct 2020 01:49:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602546546; bh=kLEXT3KXiLM2rb9NTyPvLjz7LiWHDW+0asHyeqak6rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvIjJPIo8sOd3RR4X2YszF8j0yx3qyb0kn33YqoiXdjL6iphzkk4WftzJ1nuhoLFh
         oSzfA/t/TfIIh+FpfoGGkc9DT7+lAO/aJCW1hHqbSHBuhFR6i7imytgjvb1yi8c/03
         +P2PNSzJj8YjqLWrVh1hgNjGYdipwZfk7se9pcr8=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id EB2C21105838;
        Tue, 13 Oct 2020 01:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602546546; bh=kLEXT3KXiLM2rb9NTyPvLjz7LiWHDW+0asHyeqak6rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvIjJPIo8sOd3RR4X2YszF8j0yx3qyb0kn33YqoiXdjL6iphzkk4WftzJ1nuhoLFh
         oSzfA/t/TfIIh+FpfoGGkc9DT7+lAO/aJCW1hHqbSHBuhFR6i7imytgjvb1yi8c/03
         +P2PNSzJj8YjqLWrVh1hgNjGYdipwZfk7se9pcr8=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id D5EB314200ED; Tue, 13 Oct 2020 01:49:05 +0200 (CEST)
From:   =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>
Subject: [PATCH v2 2/2] sequencer: pass explicit --no-gpg-sign to merge
Date:   Tue, 13 Oct 2020 01:49:01 +0200
Message-Id: <20201012234901.1356948-2-samuel@cavoj.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012234901.1356948-1-samuel@cavoj.net>
References: <20201012234901.1356948-1-samuel@cavoj.net>
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

Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
---
 sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.28.0

