Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6191F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfHRUFn (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57932 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727193AbfHRUFh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 940AE6074A;
        Sun, 18 Aug 2019 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158736;
        bh=wb6TebVtJICo//QuG0F7rBrVfSsdL9kAs81QJQZpYIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XwMHczYefHG2NYY2tAha6Z+vGjvuy4q+v0AENWsCkA84nSern44OvfNAm/y3RNWSg
         9E/B0FqHu+hZNGZ0X6TCZRqvGAoKx30FcRW7fIHgriSQzCfG+gwbl5EUm35UKfehBt
         j55ioKd3B7L4Zv4oxxx1dV6PfDYG8k390pQHboiKft03SnayfJiCO7rmfGP7BqfGxn
         diI/tbDfPUbJ56P6UhVgHDsClyPTUB8Sud0SO8jXaAP+B0a5NzUQVyYbicRqhQP2EK
         IFq/PDKaysCmCCyNQI3qyhXjjmYQg0ER1D/NNLLcNyIo4K7S2KJ+kd9BhUgwfgxqM0
         5xSOMNWUbyRHeHBJFu9DkMzqpzOHMqMcuaMbq/0asc6ELpQIyQNEdz9Vwe0VeniFzj
         qTiKSABMhv8LG4Y07hmhI1ATtYul8gkzJKAejpl1HFl7z39Yfv5VydMpT5/fJszl8M
         3iEqNpGAt689Vt4OZNhKInw2j2/H76MagP6pvQlHsTIE+5D1d4r
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 09/26] connected: switch GIT_SHA1_HEXSZ to the_hash_algo
Date:   Sun, 18 Aug 2019 20:04:10 +0000
Message-Id: <20190818200427.870753-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch various uses of GIT_SHA1_HEXSZ to reference the_hash_algo
instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connected.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/connected.c b/connected.c
index cd9b324afa..7cd3bc9979 100644
--- a/connected.c
+++ b/connected.c
@@ -28,6 +28,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	struct packed_git *new_pack = NULL;
 	struct transport *transport;
 	size_t base_len;
+	const unsigned hexsz = the_hash_algo->hexsz;
 
 	if (!opt)
 		opt = &defaults;
@@ -99,7 +100,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	commit[GIT_SHA1_HEXSZ] = '\n';
+	commit[hexsz] = '\n';
 	do {
 		/*
 		 * If index-pack already checked that:
@@ -112,8 +113,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		if (new_pack && find_pack_entry_one(oid.hash, new_pack))
 			continue;
 
-		memcpy(commit, oid_to_hex(&oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(rev_list.in, commit, GIT_SHA1_HEXSZ + 1) < 0) {
+		memcpy(commit, oid_to_hex(&oid), hexsz);
+		if (write_in_full(rev_list.in, commit, hexsz + 1) < 0) {
 			if (errno != EPIPE && errno != EINVAL)
 				error_errno(_("failed write to rev-list"));
 			err = -1;
