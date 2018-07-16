Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46CBA1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeGPBxP (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58926 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727265AbeGPBxP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:15 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 09BD46073F;
        Mon, 16 Jul 2018 01:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704498;
        bh=uO3WYqMQR7UjPhS/tcZ563T3d0r44hlIZ9NbHsqdLa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=njh3PGGLp6hH4hdrDeZBPmpnUh/Y/ZF0YGOvWayfrAvArPcr3ThYasRBJwPWqQDMZ
         LPi+VvF70L85uN2XsMB2hCkSSqOU0OO/BgAaBZ3HcAySPCBQqkX1dEBDT795fQuHdX
         RTSEayZsHOnNm7zd7WCNl2D5Wexnx9X2D3Y/t1wnul/On3qCk4j68vS7oIxxOKkz3e
         oEe0Up4hz8ZwCl2qHml+6AuFZQ29PG87vkPfkLwIPo0uti4cyKCCYrr8qVCeoO2rrt
         Xo+6PORgsS/0GKc183EPQduR8YxNHoDjffS0pzusH8ksM52AI1VwX5LvgDBwhpQpS1
         R8Lw3ItubVVYpJDucMqEm8eZO2DM9qJm4VnN5ZJqkgW4QidwRNmh16InpvU9o6FmnX
         s5HnzZw/N0K8KC8DdeHVgMgpEOgN589dF6xEH7RJHjDHss3qul0r1ymidowz1xM7E1
         99+bUaS2cDjGlbqKbAe+ovTsbLG8KLQKCFttU2mdzTDQVsAwWCF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 01/16] cache: update object ID functions for the_hash_algo
Date:   Mon, 16 Jul 2018 01:27:53 +0000
Message-Id: <20180716012808.961328-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of our code has been converted to use struct object_id for object
IDs.  However, there are some places that still have not, and there are
a variety of places that compare equivalently sized hashes that are not
object IDs.  All of these hashes are artifacts of the internal hash
algorithm in use, and when we switch to NewHash for object storage, all
of these uses will also switch.

Update the hashcpy, hashclr, and hashcmp functions to use the_hash_algo,
since they are used in a variety of places to copy and manipulate
buffers that need to move data into or out of struct object_id.  This
has the effect of making the corresponding oid* functions use
the_hash_algo as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index d49092d94d..f00cc810bc 100644
--- a/cache.h
+++ b/cache.h
@@ -972,7 +972,7 @@ extern const struct object_id null_oid;
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
-	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
+	return memcmp(sha1, sha2, the_hash_algo->rawsz);
 }
 
 static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
@@ -992,7 +992,7 @@ static inline int is_null_oid(const struct object_id *oid)
 
 static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
 {
-	memcpy(sha_dst, sha_src, GIT_SHA1_RAWSZ);
+	memcpy(sha_dst, sha_src, the_hash_algo->rawsz);
 }
 
 static inline void oidcpy(struct object_id *dst, const struct object_id *src)
@@ -1009,7 +1009,7 @@ static inline struct object_id *oiddup(const struct object_id *src)
 
 static inline void hashclr(unsigned char *hash)
 {
-	memset(hash, 0, GIT_SHA1_RAWSZ);
+	memset(hash, 0, the_hash_algo->rawsz);
 }
 
 static inline void oidclr(struct object_id *oid)
