Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9AF31F404
	for <e@80x24.org>; Sun, 12 Aug 2018 08:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeHLKxN (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 06:53:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33857 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeHLKxM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 06:53:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id n96-v6so9254911lfi.1
        for <git@vger.kernel.org>; Sun, 12 Aug 2018 01:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ad9vVPY7elIJ+f3S2tOIyPyUEa4wMNpmKQNFU1XzUk=;
        b=km9oV9uOUT9HWxnWY4pC/WAkXhgn62ZO1bMF5sLupfmnWNIE5hjd0Pdqt0YDo6GVv0
         VZ575Gkslch5Ja+fY292B2oytHA6LuE5ukIC7nWeLmWWAxRveCkk8IcQ64x2VC7Sokh3
         IohM2OKmXfEf6hLt/TCUjHaNx0wIxOGmLP3sEN9fmd7hmxeKWcba0NsDORwr0mczcb8u
         XMwRLWLjKVWcyWry/nLKTx0JfzFUazn55Mb/R0kFOj1I5Iv4uaax1+ZSFpmujJ4HZdV8
         xLgvRXAvtmZIS7klHNeUtrb+VPGBi02JOTb5QgEKfDIKRYEQXgjdYx6b6reSvP8t5633
         wR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ad9vVPY7elIJ+f3S2tOIyPyUEa4wMNpmKQNFU1XzUk=;
        b=JH8z4r6LkwT1jsPpd1EvAH20crdjRcWf1bYHmgQOrcj2I2lQmzV1rTtvTV3pETmftv
         GY0tGYWiQtSgLQZnmSpXLvQ2aOUs5ZhlBfHIvziADgLV/pwtKIhontij36+mcSDbugZn
         Ij17kS6J53HVreiqUwXFZSXm/dkuHxsPMtpLLRPhqx+jwEuoF8cGqxQXaqYFxlZ2D1pG
         4NFB/Mf6z9ygT8/zJok5qdcvvBM3wsYd2+jmGveinBqV/jdKyJTidxllft+oHGiLQn9t
         PPgCEIRQLhf82P6gPc+dH6+EXkNV3P6i7nNfx1KuMVweyOdeUmdjy0mmhGhcprAzM4mk
         vEPw==
X-Gm-Message-State: AOUpUlFbhv9/JojPvAoV1YansJlhMM0AdON0yOisPNbS7mSnphUEzhEo
        BiWMdm2WnzUNN/Oq0HUwbpw=
X-Google-Smtp-Source: AA+uWPzYzePn+uqdEn3XyQRB+8Tvt7d7o41U2oHTjtqA2BiO/2qgQDmZqkkBuIlwQF6Zkx0Sr5KlIw==
X-Received: by 2002:a19:e307:: with SMTP id a7-v6mr8020713lfh.125.1534061759974;
        Sun, 12 Aug 2018 01:15:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w73-v6sm2769576lfd.57.2018.08.12.01.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 01:15:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 4/5] unpack-trees: reduce malloc in cache-tree walk
Date:   Sun, 12 Aug 2018 10:15:50 +0200
Message-Id: <20180812081551.27927-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180812081551.27927-1-pclouds@gmail.com>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
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
---
 unpack-trees.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 07456d0fb2..6deb04c163 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -694,6 +694,8 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
+	struct cache_entry *tree_ce = NULL;
+	int ce_len = 0;
 	int i, d;
 
 	if (!o->merge)
@@ -708,30 +710,39 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
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

