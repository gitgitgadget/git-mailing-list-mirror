Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E9B207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046213AbdDWVhN (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:37:13 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37630 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046134AbdDWVfv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3AA72280C9;
        Sun, 23 Apr 2017 21:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983338;
        bh=NT1UQpbQkttVCT8qw5qwLDW12XNaybjk6AVQNEkk/JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=apqXvYY1QO0gLKfoJTUy8l76ECY7P7QfwP7x6TTc80hqHNdvHFn1tHszzBZ2Bejue
         Fc5EmeBzcnbNVd03sNaNAkipJled556rLtpBtH7aC9y1xlcsY9MYrHjxCWWh/7BsO7
         hHj1vatW+zXFaR8gk5NZZdYq06aFBYM8zuy7xVhuv+SiIXEay1T2zEt0w9UDEsx7m8
         yaY3CBDCUkhdWjOB1MQRvGhg3TOAouaGJW9YK9fgT5HQSwr2qfyw4uDV+kS1XPJX3b
         6nNQGq8w7wRethv5K4BU+kG51Ogj6H5I/CaGkI4QxLHbF5O/tGsNCEoAFzBR5SRYq0
         vh7OJcJ+Wdo1IDKdtXql7zperbdWMIU9MPmDWrvW00DNDDkRWxNLNHcWR1fC0rpiyT
         30FRIV90d6d0JQqeAJLdslz6MfB2/cAdvsLiCWmIuuM3C8JD61vZ4GgRa+b1oe991s
         aS5Y2I+vphQ1DnKdNA7G6iW9W4t/FDz0ygtq82agvRFJE/xF5FB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 30/53] tree: convert read_tree_1 to use struct object_id internally
Date:   Sun, 23 Apr 2017 21:34:30 +0000
Message-Id: <20170423213453.253425-31-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tree.c b/tree.c
index 33fa7ee71..21fd80b80 100644
--- a/tree.c
+++ b/tree.c
@@ -58,7 +58,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 {
 	struct tree_desc desc;
 	struct name_entry entry;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int len, oldlen = base->len;
 	enum interesting retval = entry_not_interesting;
 
@@ -87,7 +87,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 		}
 
 		if (S_ISDIR(entry.mode))
-			hashcpy(sha1, entry.oid->hash);
+			oidcpy(&oid, entry.oid);
 		else if (S_ISGITLINK(entry.mode)) {
 			struct commit *commit;
 
@@ -102,7 +102,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 				    oid_to_hex(entry.oid),
 				    base->buf, entry.path);
 
-			hashcpy(sha1, commit->tree->object.oid.hash);
+			oidcpy(&oid, &commit->tree->object.oid);
 		}
 		else
 			continue;
@@ -110,7 +110,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 		len = tree_entry_len(&entry);
 		strbuf_add(base, entry.path, len);
 		strbuf_addch(base, '/');
-		retval = read_tree_1(lookup_tree(sha1),
+		retval = read_tree_1(lookup_tree(oid.hash),
 				     base, stage, pathspec,
 				     fn, context);
 		strbuf_setlen(base, oldlen);
