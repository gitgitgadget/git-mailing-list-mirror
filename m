Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC48207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754468AbdEFWMd (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:12:33 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38000 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754117AbdEFWLX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:23 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 48168280C9;
        Sat,  6 May 2017 22:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108674;
        bh=NT1UQpbQkttVCT8qw5qwLDW12XNaybjk6AVQNEkk/JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EA0vDtgo7LeNk+vrFcaNVSndS8cMyaWP/glGYo+DafydkebZo4KkwZ6WLZFc/zUA6
         G7SM8XI4wdTaREgUDatuCN9Cb4OtW3fWoBVmNWF4OR71r/nNx1b7aErs1GazxfxzbC
         z1ZmbwIQ5GC5j9yVH1T4RmJ315gEuKUHvuCjUDHwf9yHxzp6XKUdx4gU9ajTWS732t
         IpVFvln8nSkt6AzFKk8qpt3ZJt1b4/cuM/Ay+X2fH9wuw755DtAg5brUcxZFFCe+y3
         LdMvq8xbB/xIeggY4LbYcCn/FiHe3V2L1gDyRWLZABVc4AD6DL41eifVK4TlHuSs2z
         1EF0ka006LjaWKS7pj159Qt7szP9AfUp3IkwovWnC1Yw73HGDWrOd9su6zJBmDWa53
         1VGj2ShWuLuAA09vBp4MSLiUtGbJ9N48gx1ZZ3HcdCtfEHJUVZLccbDZfuhNYoGT6v
         EUkv7307MzTL2m3i6xHT9wm4cdHEqdUC0m8DB6n9533mnZQKiIB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 30/53] tree: convert read_tree_1 to use struct object_id internally
Date:   Sat,  6 May 2017 22:10:15 +0000
Message-Id: <20170506221038.296722-31-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
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
