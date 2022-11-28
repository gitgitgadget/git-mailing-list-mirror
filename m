Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E287DC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiK1OKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiK1OKM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:10:12 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B105110F3
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:10:11 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 9so10555836pfx.11
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcX6O+2x7hVt7hCMHxxPsA7VyEPMDY+1esqmocG1yhA=;
        b=c2/njlOp0FJcBQEpwRNi18VE8tndGzZG2UZqyoMgSky25Ayrt9bwAxvC3bWSHFPMfK
         M9Zlp8HWNqAbgOgSRV53DUvXhJXUVMlKmspr1qKJ07+a+C2ChHTKXBbTxj94RL+X7uq9
         JCHICXX66BQP4vxKTrXNcH8y1SGF0wpJ/zfLSPt5Jag4usAUB+saaYLSi8ge27hULMpm
         S35CtM/016aremk0+R6YtN1r4u4FqlFwCI4yLxXnKwvVmxWbw26n+jBk8ACybySDb7XG
         AglXJHzchAWIeUuMp5vF9brHbbMInyUKoAEQCepiy4tLX9w5CUr2gDU7jhMrQ4L00WoJ
         2spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcX6O+2x7hVt7hCMHxxPsA7VyEPMDY+1esqmocG1yhA=;
        b=AAH6r5pyLwg7XeC2rmqzaT9oePjnLn6JK0rpffV3i8v7PhAB5KoFVMdjS5abkthxKp
         PYFGlpn6nOSUg76KFwCQBIA+ed3jnJvZrVY5ysc4WmPHnAx+2CPsI9acm5RZIBBPg4Za
         GMO7d0SKeCrzJvQysDm12VkKWw2eb7riBXT/92Dn++1RzKyleN3yf3zVg4/wolOD0AE9
         /aT2+cGae3zkTPanSfdt0y42VLiEh1+S3/o0I85P7pZCHRZwxLHGTpzSNZiOmPFlbdTq
         mECHcWzqY8X7tJJV1+a7CJTv9R0eGgmGLvAw+cgZGRH30DmPK5+Vsk3Dm1yF/cFJuE4Y
         19NA==
X-Gm-Message-State: ANoB5pkD7ujlNa6kaYnfwZJOC7pXZh7wI+FozCoBaL1fGIywKMKp/50/
        D7rRLapX8cH6a0tnzJM5/z0=
X-Google-Smtp-Source: AA0mqf7kTfcQcC1tCJzM1mhyXE+1vE8n6jerE+rKqCCNR5EQRBJ9X9P1I26Lb5SuxbVl95cD62Zapw==
X-Received: by 2002:aa7:800f:0:b0:575:5774:44b5 with SMTP id j15-20020aa7800f000000b00575577444b5mr1760599pfi.5.1669644611159;
        Mon, 28 Nov 2022 06:10:11 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0017f64ab80e5sm8842819plg.179.2022.11.28.06.10.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:10:10 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v5 3/4] pack-bitmap.c: break out of the bitmap loop early if not tracing
Date:   Mon, 28 Nov 2022 22:09:52 +0800
Message-Id: <22deec6aab6649b228af7d858b93672f9ce2b925.1669644101.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.385.g28306b7e8d5
In-Reply-To: <cover.1669644101.git.dyroneteng@gmail.com>
References: <cover.1669644101.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

After opening a bitmap successfully, we try opening others only
because we want to report that other bitmap files are ignored in
the trace2 log.  When trace2 is not enabled, we do not have to
do any of that.

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
2.38.1.385.g28306b7e8d5

