Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D991F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeH2Exd (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:53:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37332 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727657AbeH2Exc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:53:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AE8D56075D
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504356;
        bh=C7pd9uz10K5HKD0pT5jkbMpuVjGTgbE5Y1wzRg5JUJk=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=ijkzMXWwk0F4PHDdP3ab6EXytpx1YNMnZtjUA+kotn0D5fYBXaDtJD6p2DQYe8DOn
         9T5Zgp1yEqTWOvG23KniOxLsvs3tJ8mHxiSSP8F/nKaZZkDGqMXZeaSPC85NASlM4U
         RNzhiuST6gl5PVz1H0ixZsDo6T8pps9YLt4WBEAeTX8SqxQOLGEfSsJhsgXuN+Nn9p
         B/ceUTVX4iMOxAs24rWzodl2v7+sgJ+Bz8waNuJwj5gcY8oMGwz1DlafjwuEjn3Qlu
         /5Hkwj/Ygvf40A4xWotOzfnugzkzKUSbUxml7oKX9d/NNCp1WXlHxZz8Ctj+NYmBkS
         lMaLe1oLrKcHsIGZK+WOQ2wuttxdAGSgD338QduZs2Nidr6atLenK5tvrV22ndEWNF
         Me9/v5ROl7IXOv3uoP+7WSQ+O0RyTCqHkhgaK30uWJhvOcIilCxh1x/zOHNTsbFYN7
         gukqXMj95eWxvmwpCipj6qY1S2BXi5OlDqf7+5uLyec6jnsrYJG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 12/12] commit-graph: specify OID version for SHA-256
Date:   Wed, 29 Aug 2018 00:58:57 +0000
Message-Id: <20180829005857.980820-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180829005857.980820-1-sandals@crustytoothpaste.net>
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the commit-graph code wants to serialize the hash algorithm into
the data store, specify a version number for each supported algorithm.
Note that we don't use the values of the constants themselves, as they
are internal and could change in the future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit-graph.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 29356d84a2..5b86acdb43 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -45,7 +45,14 @@ char *get_commit_graph_filename(const char *obj_dir)
 
 static uint8_t oid_version(void)
 {
-	return 1;
+	switch (hash_algo_by_ptr(the_hash_algo)) {
+		case GIT_HASH_SHA1:
+			return 1;
+		case GIT_HASH_SHA256:
+			return 2;
+		default:
+			BUG("unknown hash algorithm");
+	}
 }
 
 static struct commit_graph *alloc_commit_graph(void)
