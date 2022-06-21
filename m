Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D4FC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 13:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351697AbiFUNbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351716AbiFUN3M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 09:29:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6606B2AC5D
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:25:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 23so6955752pgc.8
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fi65D4MYJjaJ7Lgxqk/fx1z53rLLHQyarhYPZodZC1s=;
        b=GEq0gQ+ttem9OqDYfgjXr0qD+j6h3s4nkyScyd2CmrFiluGMVb5a10gu2oLW+OS5W1
         P+Z7jDMEVmf78HfjyxfkRUc5phXVHmD2nKGKRp1oT1bOA0sCtlfYyDTd4a6K/V5GJWaA
         FY8c80RrFVS57aurZXeEE+yjTdlJ0gcxpGbNh2Wh0sUFp+eIsuJiK/Inv+dq5a8YT0Pf
         jSsAy3BL319uDZJdvZchlNnjdc4zMOOhVHf7rt9MM6Z46K9Rw+o1k5ycK/eSp+eJ6GOd
         6/vcmOzReonIaxzz70p6n4CaX+1+NpAke7/xXQGZyG/8QCz1vwN6OvI3UsuRTMNrE/qc
         hGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fi65D4MYJjaJ7Lgxqk/fx1z53rLLHQyarhYPZodZC1s=;
        b=CePMtsCiicR6Ot57NJC8FaJMt92nL7ZT67d2jJ/fZen8UdSS8G2JnMN1EHf0i8P1aP
         H4KhisyPKzJevfUkG4IYIHjOA53ZqsyVbDMdsOjuDqByjEWUOorIWBcoh4IrmWyjFJF9
         g0AkFqCmdpv4VRekPoL5KBznNkJi1DwNRE6YilIbeg0aIfH3tjCTMxCWlglG6rQbMehF
         ERpNJgCCq4sliilsadQHSLzBS/4dQESOea6v6lXJWtZplDQ6UA2CjFNO4jQhpGMVypsw
         lulhdxaKIlXJGpZ7SxlVPtIO0ExQd3NAZ4SHnZTr//6/2+YxHWrwItbQu2Oclrs2tp+Y
         hgGg==
X-Gm-Message-State: AJIora+0f5Ly6jElPJCruWuaUdxIKqT3VM/HpEYN/7PuDxzZYwfd0+sD
        92WP3wxEvV6q0no9WzqAt2M=
X-Google-Smtp-Source: AGRyM1u0oaoGECA9eyck/sGDi4t8BD6asXlPD22cSpDNxlY9Kg+e/fXdcGRIS2laUX/0Dke3Rwxe9A==
X-Received: by 2002:a63:e45:0:b0:401:9f3e:9a6c with SMTP id 5-20020a630e45000000b004019f3e9a6cmr25760667pgo.395.1655817915878;
        Tue, 21 Jun 2022 06:25:15 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b0016a058b7547sm8602426pln.294.2022.06.21.06.25.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:25:15 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 1/5] pack-bitmap.c: continue looping when first MIDX bitmap is found
Date:   Tue, 21 Jun 2022 21:25:01 +0800
Message-Id: <589e3f4075513b13dcd057242fa207b95371b114.1655817253.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g270d558070.dirty
In-Reply-To: <cover.1655817253.git.dyroneteng@gmail.com>
References: <cover.1655817253.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In "open_midx_bitmap()", we do a loop with the MIDX(es) in repo, when
the first one has been found, then will break out by a "return"
directly.

But actually, it's better to continue the loop until we have visited
both the MIDX in our repository, as well as any alternates (along with
_their_ alternates, recursively).

The reason for this is, there may exist more than one MIDX file in
a repo. The "multi_pack_index" struct is actually designed as a singly
linked list, and if a MIDX file has been already opened successfully,
then the other MIDX files will be skipped and left with a warning
"ignoring extra bitmap file." to the output.

The discussion link of community:

  https://public-inbox.org/git/YjzCTLLDCby+kJrZ@nand.local/

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9c666cdb8b..112c2b12c6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -494,15 +494,16 @@ static int open_pack_bitmap(struct repository *r,
 static int open_midx_bitmap(struct repository *r,
 			    struct bitmap_index *bitmap_git)
 {
+	int ret = -1;
 	struct multi_pack_index *midx;
 
 	assert(!bitmap_git->map);
 
 	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
 		if (!open_midx_bitmap_1(bitmap_git, midx))
-			return 0;
+			ret = 0;
 	}
-	return -1;
+	return ret;
 }
 
 static int open_bitmap(struct repository *r,
-- 
2.35.1.582.g270d558070.dirty

