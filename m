Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9411FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 21:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932098AbdAFVEG (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 16:04:06 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36062 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755349AbdAFVDh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 16:03:37 -0500
Received: by mail-pg0-f47.google.com with SMTP id f188so255179964pgc.3
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 13:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WljYPbTfrKnedHoA+msEhOT697knb3m9/ZZjB+oxDZA=;
        b=uXB6y0Vwc2n6bkfpbDQ7dKhmm9rYnBqoILuGqqxCgyqwHkX1uIB4B4tFZcYSh6XQiZ
         vRLCeJlzyvPzuVMdDF5ChMYtFpDwhK/LXn6GpordEKBrWRmDYBFv2wvKZY/OmdQF/5Qv
         +PMu2MPHzSbZXDMdp0LJ2UF7aUgwS/s7oA5f4oH9jGP+CDDfNPoHDuFC1Jn0BzWj6QeY
         2gcSp/bmjQXQ8FFaIGNHk7DhddIEag1qU/8UHRjeRzVSgowow6sry7tbvbFKO228kVz4
         QK+LlwHZ6rCk5InxZmlY+k/hlUiiGM/RrrI49edsxFI2Od1H7fH/DjIgyiqDYj0pCym8
         0ZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WljYPbTfrKnedHoA+msEhOT697knb3m9/ZZjB+oxDZA=;
        b=MdMr6mhfJMyYK7mDU9uEHBa2GQBTCr4tVQea83se6JJQrTD/vGu7xyo3ktKkxfSJOc
         XkPocvokAYksvdFJ1QOwtHGdaTJU+HEffR+8BJOp8mEvCuOcdr5j9Fp+ZGU+oiwKtHWO
         JsSDaULGimR5SG+jvwHCf8c/iXBK7FZK9mXxckSScAl/2FwvWa5PWOuEfhK2G5E/1DgN
         0XvgKHTfl8ZioekRiILF9yuLX2whk8k9OOJ5rMNp8E7MvI+2YrhwSZMfi6Buk67oRUH/
         8pEG/Qulh6snOdbE5ySpNuc2FRzJ7o55/6VIjUENnFNLHxqKpclGsGwXgeFHSFEFdZS2
         or4g==
X-Gm-Message-State: AIkVDXKzVov+IYyteT022LWp+GI+3boCbWpJwoGzyFT00Uz1Y4Hp21PXoV5W+Sj2psOy5KCd
X-Received: by 10.84.210.107 with SMTP id z98mr159136075plh.171.1483736616164;
        Fri, 06 Jan 2017 13:03:36 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:b5c6:5d9b:cb8b:89ed])
        by smtp.gmail.com with ESMTPSA id o77sm16283481pfk.7.2017.01.06.13.03.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Jan 2017 13:03:35 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] unpack-trees: factor progress setup out of check_updates
Date:   Fri,  6 Jan 2017 13:03:28 -0800
Message-Id: <20170106210330.31761-4-sbeller@google.com>
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
 unpack-trees.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index f16ef14294..971d091fd0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -237,55 +237,63 @@ static void display_error_msgs(struct unpack_trees_options *o)
 }
 
 /*
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
  */
 static void unlink_entry(const struct cache_entry *ce)
 {
 	if (!check_leading_path(ce->name, ce_namelen(ce)))
 		return;
 	if (remove_or_warn(ce->ce_mode, ce->name))
 		return;
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
 
-static int check_updates(struct unpack_trees_options *o)
+static struct progress *get_progress(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
+	struct index_state *index = &o->result;
+
+	if (!o->update || !o->verbose_update)
+		return NULL;
+
+	for (; cnt < index->cache_nr; cnt++) {
+		const struct cache_entry *ce = index->cache[cnt];
+		if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
+			total++;
+	}
+
+	return start_progress_delay(_("Checking out files"),
+				    total, 50, 1);
+}
+
+static int check_updates(struct unpack_trees_options *o)
+{
+	unsigned cnt = 0;
 	int i, errs = 0;
 
 	struct progress *progress = NULL;
 	struct index_state *index = &o->result;
 	struct checkout state = CHECKOUT_INIT;
 
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
 	state.istate = index;
 
-	if (o->update && o->verbose_update) {
-		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
-			const struct cache_entry *ce = index->cache[cnt];
-			if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
-				total++;
-		}
-
-		progress = start_progress_delay(_("Checking out files"),
-						total, 50, 1);
-		cnt = 0;
-	}
+	progress = get_progress(o);
 
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
 	for (i = 0; i < index->cache_nr; i++) {
 		const struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_WT_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update && !o->dry_run)
 				unlink_entry(ce);
 		}
 	}
 	remove_marked_cache_entries(index);
 	remove_scheduled_dirs();
 
-- 
2.11.0.31.g919a8d0.dirty

