Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E72A91F4B7
	for <e@80x24.org>; Sun,  8 Sep 2019 07:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfIHHty (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 03:49:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47476 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfIHHty (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 03:49:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 2D6941F461;
        Sun,  8 Sep 2019 07:49:54 +0000 (UTC)
Date:   Sun, 8 Sep 2019 07:49:53 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC 04/11] coccicheck: detect hashmap_entry.hash assignment
Message-ID: <20190908074953.kux7zz4y7iolqko4@whir>
References: <20190826024332.3403-1-e@80x24.org>
 <20190826024332.3403-5-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826024332.3403-5-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> By renaming the "hash" field to "_hash", it's easy to spot
> improper initialization of hashmap_entry structs which
> can leave "hashmap_entry.next" uninitialized.

Junio, I'm planning to reroll this series.
(Sorry for not following up sooner)

Would you prefer I drop 04/11 "hashmap_entry: detect improper initialization"
in favor of the following?  Thanks.

---------8<--------
Subject: [PATCH 4/11] coccicheck: detect hashmap_entry.hash assignment

Assigning hashmap_entry.hash manually leaves hashmap_entry.next
uninitialized, which can be dangerous once the hashmap_entry is
inserted into a hashmap.   Detect those assignments and use
hashmap_entry_init, instead.

Signed-off-by: Eric Wong <e@80x24.org>
---
 contrib/coccinelle/hashmap.cocci | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 contrib/coccinelle/hashmap.cocci

diff --git a/contrib/coccinelle/hashmap.cocci b/contrib/coccinelle/hashmap.cocci
new file mode 100644
index 0000000000..d69e120ccf
--- /dev/null
+++ b/contrib/coccinelle/hashmap.cocci
@@ -0,0 +1,16 @@
+@ hashmap_entry_init_usage @
+expression E;
+struct hashmap_entry HME;
+@@
+- HME.hash = E;
++ hashmap_entry_init(&HME, E);
+
+@@
+identifier f !~ "^hashmap_entry_init$";
+expression E;
+struct hashmap_entry *HMEP;
+@@
+  f(...) {<...
+- HMEP->hash = E;
++ hashmap_entry_init(HMEP, E);
+  ...>}
