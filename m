Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1F71FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 19:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbcL2TnN (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 14:43:13 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34517 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbcL2TnM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 14:43:12 -0500
Received: by mail-pg0-f46.google.com with SMTP id y62so117437069pgy.1
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=crMBntoisFSwx2NFo314XcQro1qVrsfbmjgWbkTDf7w=;
        b=kqvJVBwiP95nLK2TFCvvaZj3+pniVDJS89B+VxG1jhmqRY+MftPOGkV9F5xwbpkaPL
         wNHslQYlmwHfG25l2iNWwSftPbCGm/lAh6Q2EsmJkiI/Ac4E5i23T3LiiJUL93qQ4i4s
         LKpNXW6CA/NB+hrg7XsDw3/PgbDJP5OGFU9nbl2cii7zO35ktxrkZkwfQkYbxvP8GiDM
         iPL8I4tWXMya7w1X16bu4MXvO9LHGMCvD7gziJ9E41oqf0oyXq8rbKkI5L3SZ8yLG+en
         /zvEBD4qf125T0S/QJw3rZKrqvjXGZls2Pbwo6aUivxvLQx0YWl3dqhiLfu256kMhMLJ
         jPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=crMBntoisFSwx2NFo314XcQro1qVrsfbmjgWbkTDf7w=;
        b=SteHZqXEZXQEYyowz5D5OfXN9HZ8KRCVymKxmUHyPWQJ7CAeqAsSLg/937Q5tOCXND
         OM2ZUEH9zt38JTcbMCOE5wKq0ueEFuWVkiGngF+3Y5e6Cig3HK9IgMLk6LetXUr4CzMw
         z6asGTb9Wc7LMTXGlYKOnjrwz50nYphQSpzQr40AquhCIC6taL4Pz+g2fAPeLq/WMnPX
         WgtIxOLZ8NkVKzbv0S7my0LK/H5kmDK7jhJf6wRUj9z0uHwMOoKJ7fJVBf9NAfGke6p/
         0rMzb0MSbjD4dMKSzaMgiNzA/0joHf4fwvos21DDLyBYB1DZCLNdc7zAjXzQO95002FI
         ePjQ==
X-Gm-Message-State: AIkVDXJpS4VtwxyvO4uCfNOLb7CGstHUbPKO6oeoCEGiPi3QeVt6b7ocYFaB8/C5RCNqUv4q
X-Received: by 10.98.15.5 with SMTP id x5mr40030813pfi.140.1483040591385;
        Thu, 29 Dec 2016 11:43:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:a8f2:a269:38d5:58bc])
        by smtp.gmail.com with ESMTPSA id w24sm106841280pfa.9.2016.12.29.11.43.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Dec 2016 11:43:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, l.s.r@web.de,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] unpack-trees: move checkout state into check_updates
Date:   Thu, 29 Dec 2016 11:43:09 -0800
Message-Id: <20161229194309.2373-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.259.ga95e92af08.dirty
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
---

Rene wrote:
> we could use "index" instead of "&o->result".  Not sure if it's worth a patch, though.

done in this iteration of the patch.
I also reordered the variables at the beginning of the function for readability.

Thanks,
Stefan

 unpack-trees.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 7a6df99d10..eb44f50e65 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -218,14 +218,18 @@ static void unlink_entry(const struct cache_entry *ce)
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
 
-static int check_updates(struct unpack_trees_options *o,
-			 const struct checkout *state)
+static int check_updates(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
 	struct progress *progress = NULL;
 	struct index_state *index = &o->result;
-	int i;
-	int errs = 0;
+	struct checkout state = CHECKOUT_INIT;
+	int i, errs = 0;
+
+	state.force = 1;
+	state.quiet = 1;
+	state.refresh_cache = 1;
+	state.istate = index;
 
 	if (o->update && o->verbose_update) {
 		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
@@ -240,7 +244,7 @@ static int check_updates(struct unpack_trees_options *o,
 	}
 
 	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKOUT, &o->result);
+		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
 	for (i = 0; i < index->cache_nr; i++) {
 		const struct cache_entry *ce = index->cache[i];
 
@@ -251,7 +255,7 @@ static int check_updates(struct unpack_trees_options *o,
 			continue;
 		}
 	}
-	remove_marked_cache_entries(&o->result);
+	remove_marked_cache_entries(index);
 	remove_scheduled_dirs();
 
 	for (i = 0; i < index->cache_nr; i++) {
@@ -264,7 +268,7 @@ static int check_updates(struct unpack_trees_options *o,
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
-				errs |= checkout_entry(ce, state, NULL);
+				errs |= checkout_entry(ce, &state, NULL);
 			}
 		}
 	}
@@ -1094,14 +1098,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
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
@@ -1238,7 +1237,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 
 	o->src_index = NULL;
-	ret = check_updates(o, &state) ? (-2) : 0;
+	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index) {
 		if (!ret) {
 			if (!o->result.cache_tree)
-- 
2.11.0.259.ga95e92af08.dirty

