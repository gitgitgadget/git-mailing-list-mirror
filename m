Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D7DC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345897AbiHITKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345329AbiHITJN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD1826550
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id az6-20020a05600c600600b003a530cebbe3so4317551wmb.0
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bSLfdThemNhLnl2UxpppknDa7YTekoJOJTrP7VayP+E=;
        b=ORNZHGRxa2Ke+KYaFpmPe5VA9PVkBFrUgqy09sbOUiAk6/eicPt30rSz+6kdHMWcrv
         F9CE1wkb3QfWJCfaK6OCjAQpERMVk3XxxKLfgzazGMoZqkBoAQp9Izjpmr6UL04P8ggr
         5Et7FI35wIS1WptuLGYnoIvwh0rnDv4hG/MCPWlAruz73SNq51fPPZ1bx0hH4mcraRsD
         YAEF596bAteuf/pwHSfU+cZEkny2hWX7O9E+PXV4NbbiPBqtVAT6xC+lBFINY40wtGkW
         F7ezJccTxUL9Alji8FCp9cdkIFbwO+TLKzVzVgvZRup5lVkc0ZNglfPZdWb98uYo8LAY
         58/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bSLfdThemNhLnl2UxpppknDa7YTekoJOJTrP7VayP+E=;
        b=OpjB32SwD9b75/1175wo6sqEunZ3YVMR/4tcTjl9ove74nF+nAvm3fTCp2P96xATnN
         06QT3YAlqis08a9N9fycLYrGabMUaEKmK7IGQRgmwZ0X88WxbdLk5G9TgdBXAA5eHJ3F
         3v9ilEBjg2u1XTmttw1aawbGFxdCYxzrX6aoUE6Agv7HV2Uy8dUYhRc3Fgt9NIoI5/m6
         DaD7XNlphE+bt86DKB7rRYVZkZzpBQhTl2olbw7vhL7Om2wU4j7e9vtU1rd7+4Ozu30N
         IEH6a/9go9xIDzzR9+AOsUG6D8xhTx8a76MYpfU9bRWv0q1CsGvSuD4NGRk2ExjRos1T
         1SdA==
X-Gm-Message-State: ACgBeo3ahUyD12dLRr9vDagP/d4BTl6qUCAIh9+0Q7U6p/YLp/chmZz+
        0atIv2yt+HSRb/WGfCunXLVGjPDto90=
X-Google-Smtp-Source: AA6agR5z9NvGts7t5w5S5hXVoD6NcbdQjgj+bdywwuSYQS2SHWyAkTkvyQVZTqtYQ3R+ZbFvZ41t3A==
X-Received: by 2002:a05:600c:1d8a:b0:3a3:1104:88ad with SMTP id p10-20020a05600c1d8a00b003a3110488admr16246358wms.179.1660071334547;
        Tue, 09 Aug 2022 11:55:34 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:34 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 12/14] merge: use the "octopus" strategy without forking
Date:   Tue,  9 Aug 2022 20:54:27 +0200
Message-Id: <20220809185429.20098-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "octopus" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0ab2993ab2..a44a6b810b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -778,6 +778,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	} else if (!strcmp(strategy, "resolve")) {
 		return merge_strategies_resolve(the_repository, common,
 						head_arg, remoteheads);
+	} else if (!strcmp(strategy, "octopus")) {
+		return merge_strategies_octopus(the_repository, common,
+						head_arg, remoteheads);
 	} else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
-- 
2.37.1.412.gcfdce49ffd

