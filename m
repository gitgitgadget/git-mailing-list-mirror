Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59A21F803
	for <e@80x24.org>; Thu, 10 Jan 2019 04:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfAJE0P (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 23:26:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58382 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727256AbfAJE0M (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Jan 2019 23:26:12 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8A40C60FE3;
        Thu, 10 Jan 2019 04:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547094370;
        bh=lc/Ojoq+QQRF9LvFg/7+dxVi52xw+chTH4Xwh+Jd57I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=x/0a1507Ypu3Pq/wvy24h5+pCnwB1YSrxsxxYldSoJI5aPrMj8fcjRB1Dqi9hp7UQ
         TOKZUK+UFdHq8kUXopB8P0xpk9yGq9R3RgYxcGV9Du69vUoPcRMj/nMkO4DXL171gM
         qdwAbJn29NPPp0AVyCNRQIDFn0DQHGtLU4LTeH7HCsCpigptud1op9Gf1wmjw4CDcw
         RY1pNAd1wNNDcxPIipyrOOCIkWDaX51N11VUs9jwpz+Yaz/4+6D6wqzZS3A/Kmvfh0
         n+cJpBvoHLwiEoKL48dI3e/w8RvOI7aB3r5yCKnorEzoBIoUzF6XGaCdueknM6PYnS
         Xl68uqfkASYSEEUwYmHV28wNngZr0TWj50EIkyGihl+4lbaurbR8ai/gcwZjGOGAeY
         fIins3xs1EeInT8FfsAy/06X/RI2kHJQXTh/kn6c0Qt8Gmys8yzvBr/zSqDh1EWM3x
         ZzvNAJwGH3FYx5TdENf2nsBam99JzBdezyHv6wrraelIHwv+EUk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] cache: make oidcpy always copy GIT_MAX_RAWSZ bytes
Date:   Thu, 10 Jan 2019 04:25:51 +0000
Message-Id: <20190110042551.915769-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3
In-Reply-To: <20190110042551.915769-1-sandals@crustytoothpaste.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
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
