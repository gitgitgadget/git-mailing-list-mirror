Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723C420984
	for <e@80x24.org>; Tue, 13 Sep 2016 17:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756134AbcIMRhj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 13:37:39 -0400
Received: from mout.web.de ([212.227.17.11]:62063 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755062AbcIMRhg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 13:37:36 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MXYWA-1bYL3A18YY-00WUjj; Tue, 13 Sep 2016 19:37:18
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] unpack-trees: pass checkout state explicitly to
 check_updates()
Message-ID: <b57982ca-d508-5016-a187-fc3b829f9b0c@web.de>
Date:   Tue, 13 Sep 2016 19:37:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:eKfxIgJI2HPjDTYGSjDGb5c2eEIKtMvnJirVzhTeshcCclY6uPQ
 zKxjkVO3I/XdP+Z3OOIzW6SMB284qZWe+mMjq7jUHde/CNgqtITowmtLsQYnpsN95czFCg1
 HzStsyUkEVZVLjFy/EhTU/iATR+PhHDyy7qLI7aQu2+BjNVbwPfF5NoSKEh0gaEKmAetYr5
 AXcF57nhjZlQAxeKyTbpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oUHc0jD/gaA=:l8AL5bb9xrCHY1DG6xUJoV
 j6i4XlvfZRnneZJtgSOhGvPODODUiGlHvsvsax762WThGEmahWMsfzBJG75YTSqC3MEoFUZXq
 msOhpZCHmJhLNLcSprt2MbhML40lh1lMDkxYI87D1z6n6uJc63FexN5qBgcSsgGS4KNKUIu+T
 bVe5n/zyC1PXPdjKWi/nD2ExNofjxcOdFEHIVk62RLbrVtMdknCsUF6YZ0w6kjAArPfl94pG3
 gjLPFiYHew4Rco/fL0eyuxyrKRK0iEPkp353F+jRAMzmhqizB0TGn4QLyd3UMfIXOhARrbgWR
 lvNMggnbrkOEdfgBObeU2i9e8H7XlyqxiI9TdLyRY3xLS79xVsPAAwLT0ya2xBJkEu9xyzjNy
 IeImbJ+/yjqPKTYbagTTeavssAFWX85jiu3iKCn1PLqcMkmy+AYCgbgDqZobrVbqeGX6Lk2Ui
 2cootARvwvlfp61wyZlKbyB+8cCr7SZlyLkR4O6uedB3gwB20aXmr5RpOs6DSAnKpnfURoRwu
 gvdsAssVvCU/4KmCS/35XDkwqvkchkHH4Tghy0/ojigj1TG4PuS4E1oSG2/86M+YJo+1U9nr2
 h4Ta+zgO6fncZGbwrhajNtTTQCC0gWRbXmuBuG91NWGIbLxg9wy6dp/Xw6zV36cf8K9iw65R9
 nBmFqUAfa131Iaaougtngv/p34n69Nw2EnNFiLbwUcYOMusAKJ479e9rt4CH10fcjGr6SMU6F
 DadA1x9zUH/7R5znZwYL9VSoEvbuILu+y7jbKElP5a8CgF+1pFcP9avge2mTnw18UsEittkjy
 3NFTQ6Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a parameter for the struct checkout variable to check_updates()
instead of using a static global variable.  Passing it explicitly makes
object ownership and usage more easily apparent.  And we get rid of a
static variable; those can be problematic in library-like code.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 unpack-trees.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 11c37fb..74d6dd4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -218,8 +218,8 @@ static void unlink_entry(const struct cache_entry *ce)
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
 
-static struct checkout state;
-static int check_updates(struct unpack_trees_options *o)
+static int check_updates(struct unpack_trees_options *o,
+			 const struct checkout *state)
 {
 	unsigned cnt = 0, total = 0;
 	struct progress *progress = NULL;
@@ -264,7 +264,7 @@ static int check_updates(struct unpack_trees_options *o)
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
-				errs |= checkout_entry(ce, &state, NULL);
+				errs |= checkout_entry(ce, state, NULL);
 			}
 		}
 	}
@@ -1094,6 +1094,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct exclude_list el;
+	struct checkout state;
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
@@ -1239,7 +1240,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 
 	o->src_index = NULL;
-	ret = check_updates(o) ? (-2) : 0;
+	ret = check_updates(o, &state) ? (-2) : 0;
 	if (o->dst_index) {
 		if (!ret) {
 			if (!o->result.cache_tree)
-- 
2.10.0

