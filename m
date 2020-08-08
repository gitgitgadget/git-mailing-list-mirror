Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC5AC433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 07:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B30E221E2
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 07:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="YNUW8nQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgHHH6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 03:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgHHH6t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 03:58:49 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D4BC061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 00:58:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596873526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bDf2c4Lkr6sFTSv949KGSOpZ5owMyuyPROY338rdhbg=;
        b=YNUW8nQejHWzPmHOvmRvelQBYn9WgzekEyHJKKlmVRvirHISyhigahMVxtp2VOyX24CSXV
        DTZHWWlcjFA+tUq3u5pq8FTHbIiuDyIb1KTyLCOpfnG4v+sfRF44hvzF0/s/GlEzqysKrB
        DJFpnevVEKGgKDpNRTJlJyyPvGLJ2nw=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [HYPOTHETICAL PATCH 1/2] apply: reject modification diffs to i-t-a entries
Date:   Sat,  8 Aug 2020 03:58:26 -0400
Message-Id: <20200808075827.36248-2-ray@ameretat.dev>
In-Reply-To: <20200808075827.36248-1-ray@ameretat.dev>
References: <20200806060119.74587-1-ray@ameretat.dev>
 <20200808075827.36248-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because the correct diff between an i-t-a entry and a new file is now a
creation diff, reject diffs from the empty blob as not applying to the
preimage.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 apply.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/apply.c b/apply.c
index c5ecb64102..656f00c113 100644
--- a/apply.c
+++ b/apply.c
@@ -3637,6 +3637,9 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	if (load_preimage(state, &image, patch, st, ce) < 0)
 		return -1;
 
+	if (!(patch->is_new || patch->is_delete) && ce->ce_flags & CE_INTENT_TO_ADD)
+		return -1;
+
 	if (patch->direct_to_threeway ||
 	    apply_fragments(state, &image, patch) < 0) {
 		/* Note: with --reject, apply_fragments() returns 0 */
-- 
2.28.0.5.gfc8e108108

