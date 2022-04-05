Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D103CC433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiDEFWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiDEFWb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:22:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FB3BDF
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:20:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x31so11039313pfh.9
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ko/Ai79PakShokvJwLud0k/GT34+KE2Nntr/WUGjo4=;
        b=JfLxajJ0+iYjpJL7yQLPUY9SOzmf5ayCbO5s7rekhwxIf8dp+96ZXq3EL8PtUPx+Ne
         M+eO+eOV4pBjoJWf+6fnXzsWSbTW3+yzOsaDW65VuxKjto/WWTFJ2PhxkFNnDU/RRMqr
         4aPpUYA2GDRvs64QSuuhh1+2HRfc2ZVLegzVHLFaXEmZdCB1G7oKuEpPQkGGX7Llcp6U
         wZi/aic74nbGtg/V6xLozawZdMFbmbUWeB3zLNWDANJ2sg4WSn6gv8drEEJBnasbz1fY
         7B0BEpHMkYzcf7iJV9R2Uv5WZ0Wk5c71sqjOIsN2tgSjgSy41LriKnqX/YuO0EYmkYYt
         Hkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ko/Ai79PakShokvJwLud0k/GT34+KE2Nntr/WUGjo4=;
        b=OpTCBDcLzp8TBiKbVD7Eqm+ph8mS2eM5f3+Be2kPA8ofzMCV63sLaKf41plpDAQXQz
         1GRwocEpxFdDjBzt/RYPONNDhKxUa6TmZ6iucgDpQCc0zWfYaO+CuXKRM/9F35jg8av0
         hTMCTz0kKYHZ0eB40Muk1hCo/YRH/0XrOtuf6lzetTzOMtis9VQCErS6hfH5RKwUcA+0
         MBs+Uyn9bnsoC6zjjov8WZVc01oksomSIu0osZkK9OiNmOE57aZn90JyCODBYOMaH7pT
         PyJ07D5eGrCPBw09n7aIm6ySZQbnlHi61uapRFfwLxPxN/Beg7sUSCxj9QiE2QNEBASD
         3VwQ==
X-Gm-Message-State: AOAM530UzW5KwggnO6EKYh15/tu4FEi+3elncHjmQ3j8eJd6+hjE9ybL
        S9jHFq/hTUYELrKjKyDDqtE=
X-Google-Smtp-Source: ABdhPJyIbhq0RlB4RYHhRC5ljt/hld/4oBcYpqs8ErB43gMQXa8hP+Lrn5AaJlbPMooWWz4P71tbmA==
X-Received: by 2002:a65:6d06:0:b0:399:1485:6288 with SMTP id bf6-20020a656d06000000b0039914856288mr1506118pgb.346.1649136029397;
        Mon, 04 Apr 2022 22:20:29 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm808859pjk.8.2022.04.04.22.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:28 -0700 (PDT)
From:   nksingh85@gmail.com
X-Google-Original-From: neerajsi@microsoft.com
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        neerajsi@microsoft.com, nksingh85@gmail.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: [PATCH v6 05/12] builtin/add: add ODB transaction around add_files_to_cache
Date:   Mon,  4 Apr 2022 22:20:11 -0700
Message-Id: <20220405052018.11247-6-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.34.1.78.g86e39b8f8d
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The add_files_to_cache function is invoked internally by
builtin/commit.c and builtin/checkout.c for their flags that stage
modified files before doing the larger operation. These commands
can benefit from batched fsyncing.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/add.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index 9bf37ceae8e..e39770e4746 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -141,7 +141,16 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.format_callback_data = &data;
 	rev.diffopt.flags.override_submodule_config = 1;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
+
+	/*
+	 * Use an ODB transaction to optimize adding multiple objects.
+	 * This function is invoked from commands other than 'add', which
+	 * may not have their own transaction active.
+	 */
+	begin_odb_transaction();
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+	end_odb_transaction();
+
 	clear_pathspec(&rev.prune_data);
 	return !!data.add_errors;
 }
-- 
2.34.1.78.g86e39b8f8d

