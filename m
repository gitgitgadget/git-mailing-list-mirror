Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE391F461
	for <e@80x24.org>; Mon, 26 Aug 2019 02:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfHZCni (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 22:43:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36276 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbfHZCni (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 22:43:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C27A41F4B9;
        Mon, 26 Aug 2019 02:43:32 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 02/11] packfile: use hashmap_entry in delta_base_cache_entry
Date:   Mon, 26 Aug 2019 02:43:23 +0000
Message-Id: <20190826024332.3403-3-e@80x24.org>
In-Reply-To: <20190826024332.3403-1-e@80x24.org>
References: <20190826024332.3403-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This hashmap_entry_init function is intended to take a
hashmap_entry struct pointer, not a hashmap struct pointer.

This was not noticed because hashmap_entry_init takes a "void *"
arg instead of "struct hashmap_entry *", and the hashmap struct
is larger and can be cast into a hashmap_entry struct without
data corruption.

This has the beneficial side effect of reducing the size of
a delta_base_cache_entry from 104 bytes to 72 bytes on 64-bit
systems.

Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index fc43a6c52c..37fe0b73a6 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1361,7 +1361,7 @@ struct delta_base_cache_key {
 };
 
 struct delta_base_cache_entry {
-	struct hashmap hash;
+	struct hashmap_entry ent;
 	struct delta_base_cache_key key;
 	struct list_head lru;
 	void *data;
-- 
EW

