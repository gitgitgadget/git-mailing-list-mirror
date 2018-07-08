Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80FE1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933049AbeGHXgx (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:36:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54286 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932821AbeGHXgu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:36:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4DE896073F;
        Sun,  8 Jul 2018 23:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093009;
        bh=8uPm2AHNVJ57PPkZFfXUzO1XiDqJqiJAPGvM6yX+2WY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=eNMGGwMbyHWEl4xD+z6GM6Xqt6ksAXh/gUqfUpT0n70OOoMSmfrQz5Cg3eQRLgkou
         WuZb3JN7nIBOmjE9xllzOjOMhCfVEWDAGgbrW6R14jNaIHOqeO9qRmkgzAVXs+6e4h
         F0gQxChGcpCPytUUhPXLauK5RsKh25es6lMdOnOSMjRNweyZewIWo/Tbt8lzyo1LJF
         XBDYTDiabaf1xc+/pcYAjMA70yS6xnExpZTj5yeGe2VZ+AjR4vjI4yzG4UJ08nbpep
         PyArywjNHY/2YNxfGQFuMZSiyjAMkIXIl5MBYsjM5XJiA7WewA1RyzQxKE/w8Ulun5
         X099nOBq6SVOyJI0xhdErIe8Ez2F8EgfoYRLj6ykvDQcLImFah4qZvR00KVxtilotf
         n+qto75NHIIcjPre2z42wUrWBfypMrorqgP59g/JDB7Bsz3CEVgKIVd3LnAkGYFjPL
         1/TS8bYfZXH6WyaTOxOGEjr7BiDeBrZ7OLZcF+5p7LofraHfj5/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 01/17] cache: update object ID functions for the_hash_algo
Date:   Sun,  8 Jul 2018 23:36:22 +0000
Message-Id: <20180708233638.520172-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the hashcpy and hashclr functions to use the_hash_algo, since
they are used in a variety of places to copy and manipulate buffers that
need to move data into or out of struct object_id.  Update oidcmp so
that it is implemented on its own and similarly uses the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index d49092d94d..c4a64278a1 100644
--- a/cache.h
+++ b/cache.h
@@ -977,7 +977,7 @@ static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 
 static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
 {
-	return hashcmp(oid1->hash, oid2->hash);
+	return memcmp(oid1->hash, oid2->hash, the_hash_algo->rawsz);
 }
 
 static inline int is_null_sha1(const unsigned char *sha1)
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
