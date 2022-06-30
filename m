Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769F2C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiF3SAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbiF3SA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:00:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A528739
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e28so23281200wra.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9aj3Lnupz8KmbsEqdc653+y8WXrvreEqZG+rFIF47I=;
        b=R55sQ40Ds6HmOW/WAjSLHKl56LxuJn+KsVAJjou99q8jmxgPpNvTk4Oq1jowkfj2Qw
         i1ESnR6quOpT32+O+q+5gBrr9cGbhBU6iSPiWcLP0VCS2h0F47tKJkcBkqIHXencmBN2
         G8rINzK0qdg21rDvju/wqqABUMsKRw0l2n+A5uuSx0d2xzEbqo6O0tPBitZHFkINrcID
         T//QAu9SVUZ6/Z/NTwL7r1c+ycWN02FNuTUnQdilG41+nec9+qzX+GTmnzfpqUkJwJJm
         LYBjekbUadgI6EIuWi2xtNYzJJTKaBHkFPu6Y+fp9NELLcGJVyYVKYM7UvEnpxbBSdwN
         5lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9aj3Lnupz8KmbsEqdc653+y8WXrvreEqZG+rFIF47I=;
        b=CptBBxusxMieQgeXS8HsvT7umUVK+H2nsVtZFtCBp3FNDkAZKKyb4s1VIhck+oExwr
         H+BtcizBa/pLaexsv2J0wkZQXVB5WWIJQ0G+DAa3Ghz8UT9jni0fxtWTDBq7PTUVAuQ3
         In3ucGk8JLZb8x8fYLao5X5IF2VhFxwp0InbgltcemSeO2Otes0Tn4EmHPYH54aHb0T/
         v24Y2SjtIKsO754dHRL2MN3ZG7T7ihWVryaJT62cAy+/XtbliNKqlCir/MtC/J2giA5L
         Tx+7yWQ4CX/BAttekStcVKydzapRMt+gk4L/dXw1s1awA5bFI+7YXTjEpQT+d09GyxWu
         XjWA==
X-Gm-Message-State: AJIora+7iiSEYSncUonvnVG08V+jHIleTLJZkeecDWBxSpngIPjt/Rn4
        ZmhHFcEuaDanOxc3xmrBRrQuPVfETFh7Ww==
X-Google-Smtp-Source: AGRyM1vHhBfYYR9P/LFCsmHlXnftJHfCDFr2MSMliJKSvn6aOMmFp7SBOOOuhCLHV1qVkfx73adcPw==
X-Received: by 2002:a5d:648b:0:b0:21b:a2d3:8dff with SMTP id o11-20020a5d648b000000b0021ba2d38dffmr10028963wri.716.1656612026408;
        Thu, 30 Jun 2022 11:00:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm7363985wmh.39.2022.06.30.11.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:00:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/11] clone: fix memory leak in copy_ref() call
Date:   Thu, 30 Jun 2022 20:00:12 +0200
Message-Id: <patch-02.11-8e424238071-20220630T175714Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.874.g7d3439f13c4
In-Reply-To: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak added in 0ec4b1650cc (clone: fix ref selection in
--single-branch --branch=xxx, 2012-06-22), we need to free_refs() the
result of copy_ref().

We can't mark any tests passing passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true" as a result of this change, but
e.g. "t/t1500-rev-parse.sh" now gets closer to passing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 89a91b00177..c43c85dad07 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -494,6 +494,7 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 			/* if --branch=tag, pull the requested tag explicitly */
 			get_fetch_map(remote_head, tag_refspec, &tail, 0);
 		}
+		free_refs(remote_head);
 	} else {
 		int i;
 		for (i = 0; i < refspec->nr; i++)
-- 
2.37.0.874.g7d3439f13c4

