Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4759820A93
	for <e@80x24.org>; Mon,  9 Jan 2017 19:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935226AbdAITrC (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 14:47:02 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35660 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763937AbdAITqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 14:46:34 -0500
Received: by mail-pg0-f42.google.com with SMTP id 194so16691886pgd.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 11:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rVbjsg550JGdIm2nUtEyCzOLGNZEXQxEVHj6tsXp8Ms=;
        b=SLuDf8S+VsjM7m/mIPWYJP7mbMyDpQgmEH9LPP7HOMCrRRjojGKWey/0cFHQxQSFpC
         tbl1J4YVgzSaiGBmrWyjH0i7bQoRpqKHBDuQmQo/cCs9aAvcvdC8KFbUaGYgGJwbahon
         SatYYh/5e9/la/0x8YVdHaU3FRKkzhXOv1JpsGf3Gmdn4XTXnkDJJvK20+kK3uttfNnB
         kKA3hr80bCaAWLpr9hRScf6Xb/NjT+v5I8DGGgs8ww/aeRI8SjyLOKZa7UUUuUuIAI0m
         n7E4G0fLvOQva8k5oUbUposCW3N25wFxj7UyAiSvm/q5O7NRXzQI8y8Q6Oowi9JZE641
         nU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rVbjsg550JGdIm2nUtEyCzOLGNZEXQxEVHj6tsXp8Ms=;
        b=fmCpN/IDlpnzhN2Buyo3LEGfP7Ai3cdk6U7kibvMxYN0c1Bo4ExfOLvjueRTTBtoeJ
         m/39IZ3aKfOFpwSDhpNsP51BIJK5xICJ60tD2kEA2TxaApU52xHVOU/c1dRBUAg9hnwb
         Oq+I+QRgLFqitj+M1Wr2VMqbfN6bRSqBz2O2/lz5M6eVL/r+Np3gEpal48ApedDwXZhB
         WVFslw+OqpegStP9emxCEI9GGmlLbWcXh0O/Ec9wjBeKUY9wcySMi5MoRWWRu0pki1Y2
         PgaaEy7gF4chQjkCaLKS1Djq/COqfee8Bh6J2oycDdI6RFQvOWMrjH081p/KxFzQxHED
         cCwA==
X-Gm-Message-State: AIkVDXIhxHg8FPhyn/uaaCYb/cRrONhjp80VylO6gn38E2d5JqEaChviESNuXS/0jdDB9Ku7
X-Received: by 10.99.185.1 with SMTP id z1mr163138679pge.179.1483991193024;
        Mon, 09 Jan 2017 11:46:33 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:45b6:2235:29e9:acb7])
        by smtp.gmail.com with ESMTPSA id w11sm181302198pfk.75.2017.01.09.11.46.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 11:46:32 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/5] unpack-trees: move checkout state into check_updates
Date:   Mon,  9 Jan 2017 11:46:17 -0800
Message-Id: <20170109194621.17013-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
In-Reply-To: <20170109194621.17013-1-sbeller@google.com>
References: <20170109194621.17013-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The checkout state was introduced via 16da134b1f9
(read-trees: refactor the unpack_trees() part, 2006-07-30). An attempt to
refactor the checkout state was done in b56aa5b268e (unpack-trees: pass
checkout state explicitly to check_updates(), 2016-09-13), but we can
go even further.

The `struct checkout state` is not used in unpack_trees apart from
initializing it, so move it into the function that makes use of it,
which is `check_updates`.

Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index ea6bdd20e0..8e6768f283 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -218,14 +218,19 @@ static void unlink_entry(const struct cache_entry *ce)
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
 
-static int check_updates(struct unpack_trees_options *o,
-			 const struct checkout *state)
+static int check_updates(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
+	int i, errs = 0;
+
 	struct progress *progress = NULL;
 	struct index_state *index = &o->result;
-	int i;
-	int errs = 0;
+	struct checkout state = CHECKOUT_INIT;
+
+	state.force = 1;
+	state.quiet = 1;
+	state.refresh_cache = 1;
+	state.istate = index;
 
 	if (o->update && o->verbose_update) {
 		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
@@ -240,7 +245,7 @@ static int check_updates(struct unpack_trees_options *o,
 	}
 
 	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKOUT, &o->result);
+		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
 	for (i = 0; i < index->cache_nr; i++) {
 		const struct cache_entry *ce = index->cache[i];
 
@@ -251,7 +256,7 @@ static int check_updates(struct unpack_trees_options *o,
 			continue;
 		}
 	}
-	remove_marked_cache_entries(&o->result);
+	remove_marked_cache_entries(index);
 	remove_scheduled_dirs();
 
 	for (i = 0; i < index->cache_nr; i++) {
@@ -264,7 +269,7 @@ static int check_updates(struct unpack_trees_options *o,
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
-				errs |= checkout_entry(ce, state, NULL);
+				errs |= checkout_entry(ce, &state, NULL);
 			}
 		}
 	}
@@ -1094,14 +1099,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct exclude_list el;
-	struct checkout state = CHECKOUT_INIT;
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
-	state.force = 1;
-	state.quiet = 1;
-	state.refresh_cache = 1;
-	state.istate = &o->result;
 
 	memset(&el, 0, sizeof(el));
 	if (!core_apply_sparse_checkout || !o->update)
@@ -1238,7 +1238,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 
 	o->src_index = NULL;
-	ret = check_updates(o, &state) ? (-2) : 0;
+	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index) {
 		if (!ret) {
 			if (!o->result.cache_tree)
-- 
2.11.0.rc2.30.g7c4be45.dirty

