Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91C91F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934529AbeFYOfv (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:51 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40990 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934507AbeFYOfi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:38 -0400
Received: by mail-qt0-f196.google.com with SMTP id y20-v6so12110489qto.8
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVD1qrDVLD0Te1OFmSkzdukd96R4SzkHkS15OhHxpec=;
        b=f2ritydQosx3ENMc9DdxNtmxbzCmeBwogowjPIzerHj+AH/6ItCY4XJeFWt8ILXw8Q
         HzF6ZgC4NB48ks52ougMx+FYW0ywnKoX6Rg+iU3S95OIXBSdbvAuM0ZIywXU3X31RygB
         lUZhWl5EHOQ0D1Ghjo1KhkX8ogiot0ai2mPoGGfN+V1YcZOEmotKJiYS9HOmkpqmRWgy
         ThCT7yhOQS75AQ0llsDVuDnL29/uBxbxO12OnUZhd4366kGKyDyDFm2efvQoiwJAdp+5
         tZvQOzQp05gQ1utHODQo9BpV4cb8CyQU6aLB1nHyg9zmKa2tuzOFc7NsPwrSrekzadoH
         1eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVD1qrDVLD0Te1OFmSkzdukd96R4SzkHkS15OhHxpec=;
        b=QcaPZJrWNYnmLGJqP6jBfM4O7gz1Okm4p9G4Xkv4QK+Xtk7Tdf5LX489uz+a31hk3x
         tHt5nGlXU4Tai5Gt9rpRoVG8aoRPIrh4MrjP2ADcHTgLxuG5vNVKBl+RflYbAUSNaahX
         Fd33TkonFX9FBQgqmUaKfkvQmO7rIpd1YcL4LdpeQvQ5X41OSOT2PF9hYHii1TG9+Bjv
         Fiezj4mPYVrcFV32kQ7CqttDghgLyhYZQks8WJrfp9G0kJrCp1wW8qhyrPk/cYZUEm1J
         F1Ng7sX05rBGhT+k9T4RXVHJR13hLLbq/d2CveKi23QOy1Qa2xSSUxGgu6nGXki8pPdo
         g4cQ==
X-Gm-Message-State: APt69E15StEF5YdM/7Rifl/w2cBN1IpYJRffBV+IB5GQAKkuCvrTipik
        GPLQpUDBMypUE5bfGBpkBwDeqssL
X-Google-Smtp-Source: AAOMgpc/BtWP6byyLDOHqhfd1IGGSjIwWbgYiHHW0qBQJRR2xVgiBS3VQeLsgUaM+3JAgnV1EEtWVQ==
X-Received: by 2002:ac8:107:: with SMTP id e7-v6mr2749668qtg.119.1529937337433;
        Mon, 25 Jun 2018 07:35:37 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:36 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 22/24] midx: prevent duplicate packfile loads
Date:   Mon, 25 Jun 2018 10:34:32 -0400
Message-Id: <20180625143434.89044-23-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
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
index e72e8a685d..f2b8d6f8a7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -796,6 +796,7 @@ struct prepare_pack_data
 	struct repository *r;
 	struct string_list *garbage;
 	int local;
+	struct multi_pack_index *m;
 };
 
 static void prepare_pack(const char *full_name, size_t full_name_len, const char *file_name, void *_data)
@@ -805,6 +806,8 @@ static void prepare_pack(const char *full_name, size_t full_name_len, const char
 	size_t base_len = full_name_len;
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx")) {
+		if (data->m && midx_contains_pack(data->m, file_name))
+			return;
 		/* Don't reopen a pack we already have. */
 		for (p = data->r->objects->packed_git; p; p = p->next) {
 			size_t len;
@@ -841,6 +844,12 @@ static void prepare_packed_git_one(struct repository *r, char *objdir, int local
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
2.18.0.24.g1b579a2ee9

