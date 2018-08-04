Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D118B1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 05:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeHDHhA (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 03:37:00 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:36517 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeHDHg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 03:36:59 -0400
Received: by mail-lf1-f42.google.com with SMTP id b22-v6so5564752lfa.3
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 22:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4u0aGFpsBGOw1/EjBYc3jC7h0EdTA6e9DqqdEhHHtYs=;
        b=RulPStHRD18z4dpSbYZ2MhBm/eXou/jsihjhSwXVGxO6vMVXpTO1j13nE71Z/4G4uz
         SyatcnIp9BwfsDJobNJp8Dp3QH85l2oV14PNK56YEK1kisRkXYqe+RYlkz/xjCWYjHAn
         FzvlsizL0IoggG13tLNCMzozxmKg0JkQgGdfU10O7b9NfXkTZz99N6KRqmaIyW0AYxvg
         IcuCB1es7XMlGTHpKIybzGbgW8VjPwqz665A1iInR2ZsAjUDp0LuZFm5GWpMqDEa+9fI
         Asi07xGYd7zBy8OhvuUSvBjB/OdKn2XOncywGNhLxQ6tzvijCnrAJhMCE2NXBSBJ5Gto
         QiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4u0aGFpsBGOw1/EjBYc3jC7h0EdTA6e9DqqdEhHHtYs=;
        b=OiBjBge2Qvr/an3IwnB/xDhV/C8gMK1ssGT5OsWtXDv0Wc5mpHZUZJZ8UTZIFEeW/b
         q3ZLXGlPClT431ohVm9K1x/SMeq9i1JQATI4wNTR/2PBanxrolXBg3jY0rctDEPpEFp2
         xRw2rYPCxFO239OEeKYcY+/UCqT6yIkbHb4BrumCtAA5V0pJ9ZxkYKX5bgV4E3VoCwds
         QT+6ndOBYjPs27xpyv64RyMZDp96m4TGC3YLIKBqSV7NNLyV53Up2FHSe4BianhBQ66Z
         i1wHUbgZXLNYS7vfjIYQxUxMfkWXhhgqUvCere5wOCUbcpV4fOSu/IiY7mj6OmA2e591
         4ipg==
X-Gm-Message-State: AOUpUlF8aN+OSAopPKAeWzUlF6IUAyZXv7bFCbWNeg2DpRuPog/Q2yCw
        3d8oZhXP9736aGzJCbrDpE7hwKBE
X-Google-Smtp-Source: AAOMgpfozXLZXVjTTTPyg+7sRPATyN6Zayg5houiZB+eYPggjEfaED7178fSvfrVTJXIfGm4RqiV6w==
X-Received: by 2002:a19:6801:: with SMTP id d1-v6mr6431708lfc.8.1533361054994;
        Fri, 03 Aug 2018 22:37:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 85-v6sm1044021lft.76.2018.08.03.22.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 22:37:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, peff@peff.net
Subject: [PATCH v3 3/4] unpack-trees: reduce malloc in cache-tree walk
Date:   Sat,  4 Aug 2018 07:37:22 +0200
Message-Id: <20180804053723.4695-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180804053723.4695-1-pclouds@gmail.com>
References: <20180729103306.16403-1-pclouds@gmail.com>
 <20180804053723.4695-1-pclouds@gmail.com>
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
index ba3d2e947e..c8defc2015 100644
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
 	 * in the first place.
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
2.18.0.656.gda699b98b3

