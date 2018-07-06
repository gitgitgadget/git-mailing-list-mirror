Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A25E1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753990AbeGFAyR (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:54:17 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39758 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753592AbeGFAyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:54:09 -0400
Received: by mail-qk0-f196.google.com with SMTP id b5-v6so3505114qkg.6
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TC24dwZrssf6gOi4GW6mZX8vOQ3INDg8q+FCzwt/sl0=;
        b=t2sQv9dLpehZLP8wWLnYVRNx0MrH23O1VOjJmq3Az4iDH3ewBMVJ0S76E/SFPIxHYD
         nDntErFuZsMTqQDT8KP9nMDnF1aVu9FNvJLcOEXY3W9Pb7KwXEx+8Boo5y7GbFNYb2eF
         XHuD/JtyCrmrsWv+DdeFwnP6xsEQUiv/1miKSlsDq6r2q+Z8HmBXeFknou8Bixn3cNdS
         jR6bR8kVdbaTAFQfw7zplp9rZzdCz6bgyGKV9/hPej7XU8o9+hfq3JfZEWKBrOLagqNV
         2mgSfmPHQMddXcEeemb8Zm1W+DlTN5wY5m1x1w3TRUV5Eo8qEQRU6gStJVM/UcjKUimL
         t5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TC24dwZrssf6gOi4GW6mZX8vOQ3INDg8q+FCzwt/sl0=;
        b=EgKEJT/Rodivc4vke/PAEGGjfHvzYozPalSLchzxo3I/zGOHLMoaLjvEoQphpO3KcU
         tc+FhGO4FR6Q2btrB3JXNY43ibcIsrfBEiZ3CGMbtnI/fKC/KlIe6GM7U0tQAmiUQcsy
         plITR9yJGmEm5oQvToKkoxPDY3QRCadyB30b2ty/cOAogBoOAShrSktehiSJ67BM5VG0
         o9fd4WwkAk4h4njIMIw7kjJdkWCqqFmZbzCeflZYgst6pJyRcKD0AP0d747Pfk0BJhjV
         VswJq6nSKdiXbb9Uo3DkM7i1/3n8wsTVh+WpH0ibNsaoz+qoKUjR3mVBOoJNoiYkA1Cw
         riqw==
X-Gm-Message-State: APt69E2nE9tswvrOJeYx2tCZNyHkZNbFBd1k6bjkObNFMv3S5FxkJYr0
        U763bM2mjdmjlXivgn0hbX0U9toR
X-Google-Smtp-Source: AAOMgpdSGyk+nJrvpBEkLSnN/SvgcsSPvpq007NPnfJSIGk6ZCvuEljfCnzZ/X6h2GFwU9dCnEcRGw==
X-Received: by 2002:ae9:c002:: with SMTP id u2-v6mr6875892qkk.391.1530838448884;
        Thu, 05 Jul 2018 17:54:08 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:54:08 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 22/24] midx: prevent duplicate packfile loads
Date:   Thu,  5 Jul 2018 20:53:19 -0400
Message-Id: <20180706005321.124643-23-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index, when present, tracks the existence of objects and
their offsets within a list of packfiles. This allows us to use the
multi-pack-index for object lookups, abbreviations, and object counts.

When the multi-pack-index tracks a packfile, then we do not need to add
that packfile to the packed_git linked list or the MRU list.

We still need to load the packfiles that are not tracked by the
multi-pack-index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packfile.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/packfile.c b/packfile.c
index 97e7812b6b..2c819a0ad8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -795,6 +795,7 @@ struct prepare_pack_data {
 	struct repository *r;
 	struct string_list *garbage;
 	int local;
+	struct multi_pack_index *m;
 };
 
 static void prepare_pack(const char *full_name, size_t full_name_len,
@@ -805,6 +806,8 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	size_t base_len = full_name_len;
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx")) {
+		if (data->m && midx_contains_pack(data->m, file_name))
+			return;
 		/* Don't reopen a pack we already have. */
 		for (p = data->r->objects->packed_git; p; p = p->next) {
 			size_t len;
@@ -839,6 +842,12 @@ static void prepare_packed_git_one(struct repository *r, char *objdir, int local
 	struct prepare_pack_data data;
 	struct string_list garbage = STRING_LIST_INIT_DUP;
 
+	data.m = r->objects->multi_pack_index;
+
+	/* look for the multi-pack-index for this object directory */
+	while (data.m && strcmp(data.m->object_dir, objdir))
+		data.m = data.m->next;
+
 	data.r = r;
 	data.garbage = &garbage;
 	data.local = local;
-- 
2.18.0.118.gd4f65b8d14

