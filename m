Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C37FECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 14:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiISOO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 10:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiISOOw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 10:14:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA9013D65
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 07:14:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c24so6378321plo.3
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Ecjyv8KxQCELnhy9B9uB5hXBdr2Aa9igHTohaZ/zU38=;
        b=J4zDGnFnBuowcbsB0tkG4o4Mw1aMg9K4Lt6XxLdmRAv1OW+gUzd+piXO8jcwpKex3V
         6cHqC/dzhPccIOCrGBFoWtHS5zUBxgPDKtKHBWianOsEitsIBhBw9rqhsfGE/TGbjdnp
         Wi5M7C3dU1K8TX4ZiuxooKBFaQmBQmZB3NSTjvD50lUylYCP9VEPQc4YDZOYYSonKSCH
         Ka1xNZ7El6OKRYj4Yc7ipPI2/xeBq6PLsRKKhHeh7RkP/F3viFml3RReLAHgALAsm3yh
         ihY3sRpRLqi3z4INoDnZvWBQL4y8SOwA1BanBJtrLpmttM1dMdh0LXEHwh8xaGOYq+9+
         zJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Ecjyv8KxQCELnhy9B9uB5hXBdr2Aa9igHTohaZ/zU38=;
        b=4duSE/io0KRB4QJOMaGZ98nQsQlO9eigxT6cs8OLOiDGEOYGcWli+oHQPmrtXpZBim
         tWyVQ+JNfW8TIXN+S5zuqXzrJ5l475yhI038aNr9rrG23bAlXMtFy9/QvHAlm8rDBdS0
         lqHAUFwS87b+mnDST44lu9fz6KOCAPxhad7wTbLxbd5zDjSLSWCVgGjAlwKkNuz5tzpW
         uZzMTMZAe0FRzEIP1CdM/JpXpyayOyxUfDfyTlwRqoLuTEZpnvKAvTyh/RNm9AWUOqrL
         7fU6VSSXeoq0Vrvoc1OwLALl1TgoCc3ZxwW+GThhkYuWr5dwqsApr6zGReGWOxqnqlF2
         okzA==
X-Gm-Message-State: ACrzQf2TXpvjLfo4hrif2S49z9hnon8HG+evBCPEk91XCxhZb82ZrxhX
        OmlsKYZfR5sTzWIaYK0NXGUwt7yRhG89Vlo8
X-Google-Smtp-Source: AMsMyM6YVRQTmxO7fUAz36HNNwDeN4rWK12LrYsf+6RX4K/Tj0eC+zzZ5Hrqhz1dIVHlEQbLCwQCzg==
X-Received: by 2002:a17:902:e744:b0:178:6d7b:6d08 with SMTP id p4-20020a170902e74400b001786d7b6d08mr13461971plf.128.1663596889400;
        Mon, 19 Sep 2022 07:14:49 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id q6-20020aa79606000000b0052d432b4cc0sm20488622pfg.33.2022.09.19.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:14:48 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     linmq006@gmail.com
Subject: [PATCH v2] commit-graph: Fix missing closedir in expire_commit_graphs
Date:   Mon, 19 Sep 2022 18:14:40 +0400
Message-Id: <20220919141441.5644-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function calls opendir() but missing the corresponding
closedir() before exit the function.
Add missing closedir() to fix it.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- add if (dir) before closedir(), as suggested by Derrick.
---
 commit-graph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 06f7d9e0b6af..a7d875593288 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2265,6 +2265,8 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	}
 
 out:
+	if(dir)
+		closedir(dir);
 	strbuf_release(&path);
 }
 
-- 
2.25.1

