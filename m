Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C079C43219
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 12:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiKUMQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 07:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKUMQg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 07:16:36 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB12258BF5
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:16:34 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y13so11157917pfp.7
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tTV1LXlTK4FI+Ro+v1/5UTN9E8EgKW24BkvUjx8arU=;
        b=aBDmqBuJX5YJJPc+tZaFWWyIjyXoUVUgwSOU7K/zpE/5wk5D8OkTWZp9w14yGL/Jr9
         OT286qIqYnevZZEV2pKy7u3zrYN3kLrHLG6x0ATkA3yvt0bgwK36tf89tkWBig5ZQS81
         UH2KzIq5i708SDrlEC7DqMkmUr0SKKpu2/UUYa6ezDa8BZciNTkc4C/iteB1vEKI2HNR
         fM5D83L2y3Q/IZc/qVH3jCKr++FTMDSSE7pUCCCfEl5X2sATB7YdWXG9AQBLwd3iqwjN
         XHzvnvi2ehym9kI8WYZWs+iGg5Z+prSRnJGXR4TfkrcBdXRw+ktXJyX9CD46LKvcmS2o
         pIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tTV1LXlTK4FI+Ro+v1/5UTN9E8EgKW24BkvUjx8arU=;
        b=wS4QyVBWv2ajZ2iRjoPzEVgzNcuHqnAu9yjcZ3EXDVHE9fOH0ul3dWnCMrRYDkrXIn
         HcmNSWClKPSWVCR7ddCMgmoo+W16V0fhmKDm0Eyp59I7bi27zhKnk1dQ/r888xaPAY5j
         DJmZywADr+ulEvcT8xWVQmxgck25Go2K/qSDN9gCBTKImr4PqdHg2Y1VeN1uC9AHufmU
         Al8VPQjTw2F2ySFALnKztgslVHK2L3C6xwvx/cNSFFewq+CP/otpp5Hgau8aDSgzJNOb
         lVFaHiFQDeJ0z1tB+aEBR/J0WitrCvswE4v++fDELqaIkxi0GSVRxE2Z4jJjArP77s9l
         4avg==
X-Gm-Message-State: ANoB5pmhuWupshZcd5USCMBKQfNExh/ePHBpw8TEYmAbnlxnoIIceeZV
        ZOBJtYpD6ARARwPA5NwT17I=
X-Google-Smtp-Source: AA0mqf5k6pEvWFkhiV16qFTz6XHUbiko+ekSCbV8Zk37FCY78QwP5upRxsxLQe7eCD5oMv+aiB91vg==
X-Received: by 2002:a63:5724:0:b0:46f:9c0c:8674 with SMTP id l36-20020a635724000000b0046f9c0c8674mr1429620pgb.26.1669032994243;
        Mon, 21 Nov 2022 04:16:34 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b00176b63535adsm9630098plh.260.2022.11.21.04.16.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:16:33 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v4 3/4] pack-bitmap.c: break out of the bitmap loop early if not tracing
Date:   Mon, 21 Nov 2022 20:16:14 +0800
Message-Id: <f6c5b45bdcfd05eba2984163edf38d9915255047.1669032426.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.g9d5a491887b
In-Reply-To: <cover.1669032425.git.dyroneteng@gmail.com>
References: <cover.1669032425.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

When we successfully open a bitmap, we will continue to try to open
other packs, and when trace2 is enabled, we will report any subsequent
bitmap ignored information in the log. So when we find that trace2 is
not enabled, we can actually terminate the loop early.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index aaa2d9a104..3b6c2f804a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -527,8 +527,15 @@ static int open_pack_bitmap(struct repository *r,
 	assert(!bitmap_git->map);
 
 	for (p = get_all_packs(r); p; p = p->next) {
-		if (open_pack_bitmap_1(bitmap_git, p) == 0)
+		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
 			ret = 0;
+			/*
+			 * The only reason to keep looking is to report
+			 * duplicates.
+			 */
+			if (!trace2_is_enabled())
+				break;
+		}
 	}
 
 	return ret;
-- 
2.38.1.383.g9d5a491887b

