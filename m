Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD11C43446
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164AD204FD
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="MsrbKUtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgHFGBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 02:01:55 -0400
Received: from out0.migadu.com ([94.23.1.103]:34842 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbgHFGBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 02:01:53 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596693712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nukpke5y28ILOWZ5GLqVB9hTaMKKcPJO23ZATCLcsYU=;
        b=MsrbKUtBQey0hpPP7XynRB5AMxLMbV9gUoOcTEDsGKRQ4+UK18z70F43faLgeR56jPP0nK
        0n7XA2tI58fQ6wQT010HH0DiDF9VjutaAxG70KZl05O1T+LefUrD08E6uGO+D3kO8C1Pvj
        xV9AIqul7wUYElyvEeya/sV+JRVWSE8=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH v4 2/3] apply: make i-t-a entries never match worktree
Date:   Thu,  6 Aug 2020 02:01:18 -0400
Message-Id: <20200806060119.74587-3-ray@ameretat.dev>
In-Reply-To: <20200806060119.74587-1-ray@ameretat.dev>
References: <C4ON23BIKMVK.2ZESQJ1FB5PVA@ziyou.local>
 <20200806060119.74587-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By definition, an intent-to-add index entry can never match the
worktree, because worktrees have no concept of intent-to-add entries.
Therefore, "apply --index" should always fail on intent-to-add paths.

Because check_preimage() calls verify_index_match(), it already fails
for patches other than creation patches, which check_preimage() ignores.
This patch adds a check to check_preimage()'s rough equivalent for
creation patches, check_to_create().

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 apply.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/apply.c b/apply.c
index 4cba4ce71a..6328591489 100644
--- a/apply.c
+++ b/apply.c
@@ -3754,6 +3754,21 @@ static int check_to_create(struct apply_state *state,
 			return EXISTS_IN_INDEX;
 	}
 
+	/* If the new path to be added has an intent-to-add entry, then
+	 * by definition it does not match what is in the work tree. So
+	 * "apply --index" should always fail in this case. Patches other
+	 * than creation patches are already held to this standard by
+	 * check_preimage() calling verify_index_match().
+	 */
+	if (state->check_index && !state->cached) {
+		int pos = index_name_pos(state->repo->index, new_name,
+					 strlen(new_name));
+		if (pos >= 0 &&
+		    state->repo->index->cache[pos]->ce_flags & CE_INTENT_TO_ADD)
+			return error(_("%s: does not match index"), new_name);
+	}
+
+
 	if (state->cached)
 		return 0;
 
-- 
2.28.0.2.g72bf77540a.dirty

