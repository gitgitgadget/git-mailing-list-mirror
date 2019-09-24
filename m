Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FAC51F9FB
	for <e@80x24.org>; Tue, 24 Sep 2019 01:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503740AbfIXBDc (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 21:03:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59130 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503737AbfIXBDb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 21:03:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3C38A1F46C;
        Tue, 24 Sep 2019 01:03:25 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH v2 03/19] packfile: use hashmap_entry in delta_base_cache_entry
Date:   Tue, 24 Sep 2019 01:03:08 +0000
Message-Id: <20190924010324.22619-4-e@80x24.org>
In-Reply-To: <20190924010324.22619-1-e@80x24.org>
References: <20190924010324.22619-1-e@80x24.org>
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
