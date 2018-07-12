Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239A61F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbeGLTvo (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:44 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39849 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732395AbeGLTvn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:43 -0400
Received: by mail-qk0-f196.google.com with SMTP id b5-v6so14053203qkg.6
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TC24dwZrssf6gOi4GW6mZX8vOQ3INDg8q+FCzwt/sl0=;
        b=o9/Q/Kog0aSoNcGn63pui7n6PgTgwKJGb7yMjPtrNoxOwqObYRQL3Kd9dqyqEekEeG
         PUHCX+Bow7uCT2ZlX1NI+rryg83Bgk1MJ8cvJJpbFJUIS01Rip+wMebIzc/0IxE+BWO1
         es3QYWtmFhzswId3KxoZ8ngFtiRUe21BrHEKIz7jY/PAlOSMwj8kSTem6M9jay2UsOBg
         VnKUgPBubVGAtkKgDbtenQonMLLyo/oePqD4P/89ZuvaoUBzU64y0EP1RjLe5WFwY3lH
         jaAP+VWgGbyJUwvgZtf43LxxdnKHtdR62uORgVGYTNaAY0mqipqsD11R5ntxqkM278h4
         v7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TC24dwZrssf6gOi4GW6mZX8vOQ3INDg8q+FCzwt/sl0=;
        b=GXADyp2EiPEFNWXoX3S+Cp4PzDFT6NEUcJ4a2wnFDwCCj9Z7zsid0Czy9IUOLQof2H
         8ZhqkOSFn+H3XwmmOodM4AdHYCQ3OvscvzXCUbnXqCY/irgNrggIUQGweXv1kujLliVr
         /ja4xpDRuajBrlWrGkymz9aBFD+JgsKaoPFpTyetggESBAmphEV2dKPkxpQTbzEnk00R
         8h8dSqdrw4Ow45CRVqAi2miCaebYwNJqJmal7+ShiOHsMx0EG4sZWkumsBWWL8lL+Ks7
         DMOBNuRiQ+JEqy3eur8cLj6CvEjs9uARdeFzKdX6h6x3g4OfrAnCKSnBxD/MTrT/Nt9r
         dDCw==
X-Gm-Message-State: AOUpUlFvbaFJTcRoqYQJWJMGqDymnDDMI3XOlj6lryNHbCDQmVXfEDbc
        uijHPZMN0R6i87JExyY2Ln49viGbU/M=
X-Google-Smtp-Source: AAOMgpdlGd3ADlkSLZfIUW5KimXzGfqIn47Zs8iX+y75SNG++1nzv4eyjaPE3lAI/ukdVvzeIsjk9Q==
X-Received: by 2002:a37:4b46:: with SMTP id y67-v6mr2855854qka.207.1531424443212;
        Thu, 12 Jul 2018 12:40:43 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:42 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 21/23] midx: prevent duplicate packfile loads
Date:   Thu, 12 Jul 2018 15:39:38 -0400
Message-Id: <20180712193940.21065-22-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
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

