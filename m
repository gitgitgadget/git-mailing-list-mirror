Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAC3C1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 14:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeHRRtk (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 13:49:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37005 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRRtk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 13:49:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so8481853ljk.4
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0jG4FwbyH4HSb2YA0pwlDNQCMUIRUfx2F09xdELoEE=;
        b=nDpsL/m0P27X+O0NAFwbjfp0xgZM0ngzdtDm+IUZf5o+YRxyb9S73zW4zr6qq9KiNq
         MR/139B2CigDQajneQStEJQCtZN6CQaFmjRpeX6MbSTHPhlCJT8qCbsqibWQUSeMfR1f
         npTn6CwmHl9iOsU1u05ZHp18VvnDm8k7flmksaXlnKS7dQhWqE1g1V+CYRnY9h7ULJ1P
         1C1lmKT4JBQB4M6yRhTawqWLYkbYe0bftZ5D0E311ufnOZok0j9pXpCRQhXkX63hV1q8
         Kjq2Ynt3TO+Vi53eKtjzQkWgil7bBIsZfnz7qXNyLseLXehPdqgN0KcTXIIykbNI1saW
         4wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0jG4FwbyH4HSb2YA0pwlDNQCMUIRUfx2F09xdELoEE=;
        b=iFhFPA2O8bgRxEyRFhmSMT1zL4Uzd+PVHtJtyA3kAEiiFl+MfKsq4OotH4LqEYgD07
         kOWX/7Q+4DDX43ZFB6y6aXj0+BI12R/ZPVI1FUBvE57cJ/YLc8YfsgHj2O0I4XKJ3I10
         pIxFjN3bN/dUht7mjqTzloEZUnRKW9vlG/awcszjcTluGk72ncHQlx9U9YcJ51NGMKl2
         XIYri6fxWCXuwczzydJFsrfuenfkI9ll5LAe8nFp5Gi5oNy6M7ItcU2yeK9zhNVIwhUq
         EbJPq5sDaW8qVvc3ltmjksQbnYX3smVCWhQAZcQtEYfnjqRQbWHCHsFlJXeuPvFNcd78
         LC0A==
X-Gm-Message-State: AOUpUlElTLf+tfOzNFLGLPtJTlM2y+6YJG4TaqLbIZT0F4HPuUh0Tu3A
        hsa0UjxJnhoGxrCKpM7wBvc=
X-Google-Smtp-Source: AA+uWPy+PR8tZfepew9Nnk5Wgj3iwszRXBMa/yBa3ycyGRCK5OvFKU++sJpU7w4vuHqsVRE/v2uRqQ==
X-Received: by 2002:a2e:610a:: with SMTP id v10-v6mr26089316ljb.39.1534603302540;
        Sat, 18 Aug 2018 07:41:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b76-v6sm884451lff.53.2018.08.18.07.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 07:41:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, peartben@gmail.com, peff@peff.net
Subject: [PATCH v5 4/7] unpack-trees: reduce malloc in cache-tree walk
Date:   Sat, 18 Aug 2018 16:41:25 +0200
Message-Id: <20180818144128.19361-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180818144128.19361-1-pclouds@gmail.com>
References: <20180812081551.27927-1-pclouds@gmail.com>
 <20180818144128.19361-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a micro optimization that probably only shines on repos with
deep directory structure. Instead of allocating and freeing a new
cache_entry in every iteration, we reuse the last one and only update
the parts that are new each iteration.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 8376663b59..dbef6e1b8a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -685,6 +685,8 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
+	struct cache_entry *tree_ce = NULL;
+	int ce_len = 0;
 	int i, d;
 
 	if (!o->merge)
@@ -699,30 +701,39 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 	 * get here in the first place.
 	 */
 	for (i = 0; i < nr_entries; i++) {
-		struct cache_entry *tree_ce;
-		int len, rc;
+		int new_ce_len, len, rc;
 
 		src[0] = o->src_index->cache[pos + i];
 
 		len = ce_namelen(src[0]);
-		tree_ce = xcalloc(1, cache_entry_size(len));
+		new_ce_len = cache_entry_size(len);
+
+		if (new_ce_len > ce_len) {
+			new_ce_len <<= 1;
+			tree_ce = xrealloc(tree_ce, new_ce_len);
+			memset(tree_ce, 0, new_ce_len);
+			ce_len = new_ce_len;
+
+			tree_ce->ce_flags = create_ce_flags(0);
+
+			for (d = 1; d <= nr_names; d++)
+				src[d] = tree_ce;
+		}
 
 		tree_ce->ce_mode = src[0]->ce_mode;
-		tree_ce->ce_flags = create_ce_flags(0);
 		tree_ce->ce_namelen = len;
 		oidcpy(&tree_ce->oid, &src[0]->oid);
 		memcpy(tree_ce->name, src[0]->name, len + 1);
 
-		for (d = 1; d <= nr_names; d++)
-			src[d] = tree_ce;
-
 		rc = call_unpack_fn((const struct cache_entry * const *)src, o);
-		free(tree_ce);
-		if (rc < 0)
+		if (rc < 0) {
+			free(tree_ce);
 			return rc;
+		}
 
 		mark_ce_used(src[0], o);
 	}
+	free(tree_ce);
 	if (o->debug_unpack)
 		printf("Unpacked %d entries from %s to %s using cache-tree\n",
 		       nr_entries,
-- 
2.18.0.1004.g6639190530

