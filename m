Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297071F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 23:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfJFXau (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 19:30:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39082 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfJFXat (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 19:30:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 046161F4BF;
        Sun,  6 Oct 2019 23:30:44 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 02/20] coccicheck: detect hashmap_entry.hash assignment
Date:   Sun,  6 Oct 2019 23:30:25 +0000
Message-Id: <20191006233043.3516-3-e@80x24.org>
In-Reply-To: <20191006233043.3516-1-e@80x24.org>
References: <20191006233043.3516-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Assigning hashmap_entry.hash manually leaves hashmap_entry.next
uninitialized, which can be dangerous once the hashmap_entry is
inserted into a hashmap.   Detect those assignments and use
hashmap_entry_init, instead.

Signed-off-by: Eric Wong <e@80x24.org>
Reviewed-by: Derrick Stolee <stolee@gmail.com>
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
