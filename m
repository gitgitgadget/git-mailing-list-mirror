Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790CF1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 00:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfAOAkS (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 19:40:18 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59218 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727506AbfAOAkN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Jan 2019 19:40:13 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c162:ac20:e47c:bd21])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 70BBA60FE3;
        Tue, 15 Jan 2019 00:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547512811;
        bh=lc/Ojoq+QQRF9LvFg/7+dxVi52xw+chTH4Xwh+Jd57I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vUTkclZPZQeYdWQVZJao/gjsMRBXEe60YQsOtLErTQjNJbho3Vg+W0MLfuSii7rj8
         qs3/rUqs9gLYMz2mNn44xM3+f/kYdbGNASazpSTA1sbD1BTjoagU914UtMTnwZcJbX
         dZ4wQels7CSQ+FhfnnyVOVp6s0irh+FqjBVLFJslWSYiYcXRVLv9J2/NQWnB6zOFUN
         A8rqAs/TARnJ1HVWGxfTT4l298lH31z+sKIazyuolPGJ6gcwvkolTIPYeFlAGqXyo4
         mPwjhpeK8RDSd7q/lZ+E/2aAtgLo0n9mgjfuOfhpoSbYl/0fDIE0NNhgJe3aq4x86j
         gVFXAqltHeN2GW3UnoaPwkZh5UHA1mhDad3b7aiANzMe8h7jhfN0m+8ghZ6NpmXqql
         hFZ1Gqk8JmkXd4/2BdXWq5HeZYYru5pC/e7Jv9ovobLIhDyDi9Bc0rWcLwfLGErWai
         0wN8LmfT8x1+aQX8HU0ctpUgEb513oWh7L8wTdlXqOW6R98Yjed
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 5/5] cache: make oidcpy always copy GIT_MAX_RAWSZ bytes
Date:   Tue, 15 Jan 2019 00:39:45 +0000
Message-Id: <20190115003946.932078-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce
In-Reply-To: <20190115003946.932078-1-sandals@crustytoothpaste.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190115003946.932078-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some situations in which we want to store an object ID into
struct object_id without the_hash_algo necessarily being set correctly.
One such case is when cloning a repository, where we must read refs from
the remote side without having a repository from which to read the
preferred algorithm.

In this cases, we may have the_hash_algo set to SHA-1, which is the
default, but read refs into struct object_id that are SHA-256. When
copying these values, we will want to copy them completely, not just the
first 20 bytes. Consequently, make sure that oidcpy copies the maximum
number of bytes at all times, regardless of the setting of
the_hash_algo.

Since oidcpy and hashcpy are no longer functionally identical, remove
the Cocinelle object_id transformations that convert from one into the
other.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h                            |  2 +-
 contrib/coccinelle/object_id.cocci | 30 ------------------------------
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/cache.h b/cache.h
index ca36b44ee0..8b8c6a1a2a 100644
--- a/cache.h
+++ b/cache.h
@@ -1072,7 +1072,7 @@ static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
 
 static inline void oidcpy(struct object_id *dst, const struct object_id *src)
 {
-	hashcpy(dst->hash, src->hash);
+	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
 }
 
 static inline struct object_id *oiddup(const struct object_id *src)
diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index 6a7cf3e02d..3e536a9834 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -86,36 +86,6 @@ struct object_id OID;
 - hashcmp(OID.hash, OIDPTR->hash)
 + oidcmp(&OID, OIDPTR)
 
-@@
-struct object_id OID1, OID2;
-@@
-- hashcpy(OID1.hash, OID2.hash)
-+ oidcpy(&OID1, &OID2)
-
-@@
-identifier f != oidcpy;
-struct object_id *OIDPTR1;
-struct object_id *OIDPTR2;
-@@
-  f(...) {<...
-- hashcpy(OIDPTR1->hash, OIDPTR2->hash)
-+ oidcpy(OIDPTR1, OIDPTR2)
-  ...>}
-
-@@
-struct object_id *OIDPTR;
-struct object_id OID;
-@@
-- hashcpy(OIDPTR->hash, OID.hash)
-+ oidcpy(OIDPTR, &OID)
-
-@@
-struct object_id *OIDPTR;
-struct object_id OID;
-@@
-- hashcpy(OID.hash, OIDPTR->hash)
-+ oidcpy(&OID, OIDPTR)
-
 @@
 struct object_id *OIDPTR1;
 struct object_id *OIDPTR2;
