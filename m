Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973091FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 21:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932087AbdAFVDu (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 16:03:50 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33279 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755386AbdAFVDj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 16:03:39 -0500
Received: by mail-pf0-f180.google.com with SMTP id d2so96155099pfd.0
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 13:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dexiLPa+cIKzyNXlpwG7qJ0zc+SPLbZIqspDRcRIJsg=;
        b=A0Zuo/MJ5JBvkiqUmOAghbOibHEnGTTXRY1iWySj23IfPrnwT/YWW55BPxiJWkxGXz
         1XiU0zsBtOQh2ndPJrkoyZCr3Cvoh9DBfO2DqquULoGGZgCIBrV2oN0pTD9fhu11Viwo
         dFlph/SbyWGO07JyUat+HVrTqV3CwFCXnnRFLIduU3gFqULMPmFcmuhDmGufNkZpu4di
         sm+pm1vL6QflajnSciW+mGVfd7bakQjjbOrWi6bA/7wiB6sBdQBIgiuteWKZv7urY9XR
         GBuL8AYiPYr1wSp1O2IU6IxwE/UdajC048W1/qO5nnfts11S4f4UranYfxnW+mcOaJlC
         9BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dexiLPa+cIKzyNXlpwG7qJ0zc+SPLbZIqspDRcRIJsg=;
        b=BK87/FKyGwsSNMGgOn+DDtzJ/nwYc3s4GraXs/oCmiNKfAz0+Kx9iv4F8Ot8b5yuVH
         oj5Y/3hHFwajrTAA6EYBLIc7K1r+D4bVOEiYMX/EgGoX27lbMYtEqYsaqkZfApT0hNEv
         XX0jfAPZQwBmfQCnczcz+2vZ4nzxnkzvDdvpjd5C0R2RINd3Pcxz6PxgXvwya62DdCXW
         K5pan9AYCuAuPyFr21r4hUwSZkcYEivd4JwTzknGDFO1p6WR4B8JT7Bg2QAriZPwZktc
         Xg0cMaD4t85UfkRNqAqkRhz2xJ6asfr8p5Nu7KJaxBvg+gaiNvBiaHiWiAzaWRXs3dVo
         e6PQ==
X-Gm-Message-State: AIkVDXKmhL5/xwYClp/mXKcG+kgRQAtww8tebTXi1Kr+1VbMej4Rix4UtvdKpDya8AHisKHV
X-Received: by 10.84.225.129 with SMTP id u1mr171266439plj.110.1483736618339;
        Fri, 06 Jan 2017 13:03:38 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:b5c6:5d9b:cb8b:89ed])
        by smtp.gmail.com with ESMTPSA id z9sm163384264pge.44.2017.01.06.13.03.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Jan 2017 13:03:37 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] unpack-trees: factor working tree update out of check_updates
Date:   Fri,  6 Jan 2017 13:03:30 -0800
Message-Id: <20170106210330.31761-6-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.31.g919a8d0.dirty
In-Reply-To: <20170106210330.31761-1-sbeller@google.com>
References: <CAGZ79kaM=Uosm7KAvAP-8w59Tyfc7LZiV3ZOr=PZnBgMCzr2AA@mail.gmail.com>
 <20170106210330.31761-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes check_updates shorter and easier to understand.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index b954ec1233..b40c069b1b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -275,67 +275,79 @@ static struct progress *get_progress(struct unpack_trees_options *o)
 	struct index_state *index = &o->result;
 
 	if (!o->update || !o->verbose_update)
 		return NULL;
 
 	for (; cnt < index->cache_nr; cnt++) {
 		const struct cache_entry *ce = index->cache[cnt];
 		if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
 			total++;
 	}
 
 	return start_progress_delay(_("Checking out files"),
 				    total, 50, 1);
 }
 
-static int check_updates(struct unpack_trees_options *o)
+static int update_working_tree_files(struct unpack_trees_options *o,
+				     struct progress *progress,
+				     unsigned start_cnt)
 {
-	unsigned cnt = 0;
+	unsigned cnt = start_cnt;
 	int i, errs = 0;
 
-	struct progress *progress = NULL;
 	struct index_state *index = &o->result;
 	struct checkout state = CHECKOUT_INIT;
 
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
 	state.istate = index;
 
-	progress = get_progress(o);
-
-	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
-
-	cnt = remove_workingtree_files(o, progress);
-	remove_marked_cache_entries(index);
-	remove_scheduled_dirs();
-
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_UPDATE) {
 			if (ce->ce_flags & CE_WT_REMOVE)
 				die("BUG: both update and delete flags are set on %s",
 				    ce->name);
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
-			if (o->update && !o->dry_run) {
+			if (o->update && !o->dry_run)
 				errs |= checkout_entry(ce, &state, NULL);
-			}
 		}
 	}
+
+	return errs;
+}
+
+static int check_updates(struct unpack_trees_options *o)
+{
+	struct progress *progress = NULL;
+	struct index_state *index = &o->result;
+	int errs;
+	unsigned total_removed;
+
+	progress = get_progress(o);
+
+	if (o->update)
+		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
+
+	total_removed = remove_workingtree_files(o, progress);
+	remove_marked_cache_entries(index);
+	remove_scheduled_dirs();
+	errs = update_working_tree_files(o, progress, total_removed);
+
 	stop_progress(&progress);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
 	return errs != 0;
 }
 
 static int verify_uptodate_sparse(const struct cache_entry *ce,
 				  struct unpack_trees_options *o);
 static int verify_absent_sparse(const struct cache_entry *ce,
 				enum unpack_trees_error_types,
 				struct unpack_trees_options *o);
 
 static int apply_sparse_checkout(struct index_state *istate,
 				 struct cache_entry *ce,
 				 struct unpack_trees_options *o)
-- 
2.11.0.31.g919a8d0.dirty

