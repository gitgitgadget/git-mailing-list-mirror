Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C611F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932526AbeCLC2U (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34282 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932420AbeCLC2S (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3677F6047B;
        Mon, 12 Mar 2018 02:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821697;
        bh=ZwCtI3j2efKjumyeu+Rgv6YsoGL/peozqhqRpt2pRu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=u7z7eRPYpTsY9YWXNlW8/fLO1rxlBhS1tHKBItMhAhpXTe068tjeHA1j8NdlhHnsf
         pXOKrej4zG1+FhHlIDrMdwTtiDqXZYJymnH8U8sXvoW2zib3gzcayTc6daB0lpp9jq
         YSNphSzQTtsB6gFK7mDlp9fZZOiEfzj/jSXuOUVrwHl2iQQxIO+iOViXnPbuHqEetd
         sTe9JQBsap1inFM+aWWisJ60Sq9wAp93vB7OUAJLviy+eqRl2Pd0raVkEBqHoj57rZ
         4C+oqwIIoqB5RQHABUfDN48Ks6UPGvvqNQgAD9f9VBEOTqIHGogUIfWhb/zf7xqjw3
         53zvlPPeA0E86z/0fz2tZY5cYscL86Qg/jv8qwEeJJ6rGF5A/k3abwqqKjhJY7U74O
         LsJu+2/g0S0OU7d62Ljt2SqkwFQ360Hv0LihStNGEh9/ViNLka0vDRgWtL37VPqWsi
         u7kU0635pkraekhhwIRVKDJnBMW7p32iKjwB8X/khuqfLMAt3wE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 04/36] cache-tree: convert remnants to struct object_id
Date:   Mon, 12 Mar 2018 02:27:24 +0000
Message-Id: <20180312022756.483934-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining portions of cache-tree.c to use struct object_id.
Convert several instances of 20 to use the_hash_algo instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache-tree.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index ba07a8067e..6a555f4d43 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -320,7 +320,7 @@ static int update_one(struct cache_tree *it,
 		struct cache_tree_sub *sub = NULL;
 		const char *path, *slash;
 		int pathlen, entlen;
-		const unsigned char *sha1;
+		const struct object_id *oid;
 		unsigned mode;
 		int expected_missing = 0;
 		int contains_ita = 0;
@@ -338,7 +338,7 @@ static int update_one(struct cache_tree *it,
 				die("cache-tree.c: '%.*s' in '%s' not found",
 				    entlen, path + baselen, path);
 			i += sub->count;
-			sha1 = sub->cache_tree->oid.hash;
+			oid = &sub->cache_tree->oid;
 			mode = S_IFDIR;
 			contains_ita = sub->cache_tree->entry_count < 0;
 			if (contains_ita) {
@@ -347,19 +347,19 @@ static int update_one(struct cache_tree *it,
 			}
 		}
 		else {
-			sha1 = ce->oid.hash;
+			oid = &ce->oid;
 			mode = ce->ce_mode;
 			entlen = pathlen - baselen;
 			i++;
 		}
 
-		if (is_null_sha1(sha1) ||
-		    (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))) {
+		if (is_null_oid(oid) ||
+		    (mode != S_IFGITLINK && !missing_ok && !has_object_file(oid))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
 			return error("invalid object %06o %s for '%.*s'",
-				mode, sha1_to_hex(sha1), entlen+baselen, path);
+				mode, oid_to_hex(oid), entlen+baselen, path);
 		}
 
 		/*
@@ -385,12 +385,12 @@ static int update_one(struct cache_tree *it,
 		/*
 		 * "sub" can be an empty tree if all subentries are i-t-a.
 		 */
-		if (contains_ita && !hashcmp(sha1, EMPTY_TREE_SHA1_BIN))
+		if (contains_ita && !oidcmp(oid, &empty_tree_oid))
 			continue;
 
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
-		strbuf_add(&buffer, sha1, 20);
+		strbuf_add(&buffer, oid->hash, the_hash_algo->rawsz);
 
 #if DEBUG
 		fprintf(stderr, "cache-tree update-one %o %.*s\n",
@@ -401,7 +401,7 @@ static int update_one(struct cache_tree *it,
 	if (repair) {
 		struct object_id oid;
 		hash_object_file(buffer.buf, buffer.len, tree_type, &oid);
-		if (has_sha1_file(oid.hash))
+		if (has_object_file(&oid))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
@@ -465,7 +465,7 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
 #endif
 
 	if (0 <= it->entry_count) {
-		strbuf_add(buffer, it->oid.hash, 20);
+		strbuf_add(buffer, it->oid.hash, the_hash_algo->rawsz);
 	}
 	for (i = 0; i < it->subtree_nr; i++) {
 		struct cache_tree_sub *down = it->down[i];
@@ -492,6 +492,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	char *ep;
 	struct cache_tree *it;
 	int i, subtree_nr;
+	const unsigned rawsz = the_hash_algo->rawsz;
 
 	it = NULL;
 	/* skip name, but make sure name exists */
@@ -520,11 +521,11 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 		goto free_return;
 	buf++; size--;
 	if (0 <= it->entry_count) {
-		if (size < 20)
+		if (size < rawsz)
 			goto free_return;
-		hashcpy(it->oid.hash, (const unsigned char*)buf);
-		buf += 20;
-		size -= 20;
+		memcpy(it->oid.hash, (const unsigned char*)buf, rawsz);
+		buf += rawsz;
+		size -= rawsz;
 	}
 
 #if DEBUG
