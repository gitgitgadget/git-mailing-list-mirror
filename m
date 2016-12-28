Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D102320441
	for <e@80x24.org>; Wed, 28 Dec 2016 23:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbcL1X1B (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 18:27:01 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34712 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbcL1X07 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 18:26:59 -0500
Received: by mail-pg0-f54.google.com with SMTP id y62so108057183pgy.1
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 15:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2hbXfbRY7+kw68yNT2lyH/WY9DO04MedEHaFBq+54UU=;
        b=TnaA+w27YtLRytXqRsweLZtuPykCeUFt8YsNjH3hpnTxeF55uVNukm0XvMO8rj9ZBA
         Ia25k+VA+PYJWdUr0oEqa+vMZ9jtRNpNi7tsnHrPCO7tjkQXpy+33prZuteyT75Vms5w
         btzQSKAILJ5Urr26QAXtU3q+8D/fNZzd/iQAKdjyvINxcYUdW1M+pt6uMnNDZ6OGMBqS
         ubwrv3vCW5uDlgGefiBkUUYiheoN01mL56QDfFTxocDVl8XLoEEF9mmKO5kMV3rocpl8
         3wjnRg/74BXEaLyz25f4DqZF3OSP71ltpLs/Olx5GeLo1408l0aEKP37Iz/YLxOORXVp
         Z0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2hbXfbRY7+kw68yNT2lyH/WY9DO04MedEHaFBq+54UU=;
        b=OxcWbcjqkxCLbLLdWB84NyPBau7zRIhT9SQ5Berl+bf++OEo3EkGrlObiuWcEhKtot
         5WQVRYi863JD4Gq/yvpul4p+meM77D2l2m3EcvSElTkL1MVGxaD9y7P7iqMUbJAfJF+5
         r/BFaHmqOQDxMhIyR4B2USboMbqlqZTlGuxMiAaRaf0w1yH+yerjBW/4YaL4FOkUbCC5
         hQ37WEB5hja0MO92oCh87OMhbQB2UvAvInYCt0JwRBQ/iVfTvUJFFv3Cf1jksorV2F7G
         QlUU0lJ2yh5wDSMkt0r80/FNy6AZ9VGOWOkbJEJNv8CPr43e3+oCqgPD5rS3E/aNpMkG
         bDCg==
X-Gm-Message-State: AIkVDXLG6IWsP/2Gray0fzUB2OxFsJsxLK7honiRJBfRs0vkb6Z/g7bi/h2UMUHNJWWRC4kv
X-Received: by 10.98.101.71 with SMTP id z68mr30927009pfb.165.1482967618977;
        Wed, 28 Dec 2016 15:26:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:a8f2:a269:38d5:58bc])
        by smtp.gmail.com with ESMTPSA id f5sm83762455pgg.5.2016.12.28.15.26.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Dec 2016 15:26:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     l.s.r@web.de, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] unpack-trees: move checkout state into check_updates
Date:   Wed, 28 Dec 2016 15:26:16 -0800
Message-Id: <20161228232616.21109-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.51.g8b63c0e.dirty
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
 unpack-trees.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index ea799d37c5..78703af135 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -224,14 +224,18 @@ static void unlink_entry(const struct cache_entry *ce)
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
 
-static int check_updates(struct unpack_trees_options *o,
-			 const struct checkout *state)
+static int check_updates(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
 	struct progress *progress = NULL;
 	struct index_state *index = &o->result;
 	int i;
 	int errs = 0;
+	struct checkout state = CHECKOUT_INIT;
+	state.force = 1;
+	state.quiet = 1;
+	state.refresh_cache = 1;
+	state.istate = &o->result;
 
 	if (o->update && o->verbose_update) {
 		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
@@ -270,7 +274,7 @@ static int check_updates(struct unpack_trees_options *o,
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
-				errs |= checkout_entry(ce, state, NULL);
+				errs |= checkout_entry(ce, &state, NULL);
 			}
 		}
 	}
@@ -1100,14 +1104,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
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
@@ -1244,7 +1243,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 
 	o->src_index = NULL;
-	ret = check_updates(o, &state) ? (-2) : 0;
+	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index) {
 		if (!ret) {
 			if (!o->result.cache_tree)
-- 
2.11.0.rc2.51.g8b63c0e.dirty

