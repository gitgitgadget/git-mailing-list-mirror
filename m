Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C3FC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAF32076E
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406874AbgFYTs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:48:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:43302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406635AbgFYTsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 15:48:25 -0400
Received: (qmail 31393 invoked by uid 109); 25 Jun 2020 19:48:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Jun 2020 19:48:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19626 invoked by uid 111); 25 Jun 2020 19:48:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Jun 2020 15:48:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Jun 2020 15:48:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 05/11] fast-export: stop storing lengths in anonymized
 hashmaps
Message-ID: <20200625194823.GE4029374@coredump.intra.peff.net>
References: <20200625194802.GA4028913@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200625194802.GA4028913@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the anonymize_str() interface is restricted to NUL-terminated
strings, there's no need for us to keep track of the length of each
entry in the hashmap. This simplifies the code and saves a bit of
memory.

Note that we do still need to compare the stored results to partial
strings passed in by the callers. We can do that by using hashmap's
keydata feature to get the ptr/len pair into the comparison function,
and then using strncmp().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d8ea067630..5df2ada47d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -121,23 +121,32 @@ static int has_unshown_parent(struct commit *commit)
 struct anonymized_entry {
 	struct hashmap_entry hash;
 	const char *orig;
-	size_t orig_len;
 	const char *anon;
-	size_t anon_len;
+};
+
+struct anonymized_entry_key {
+	struct hashmap_entry hash;
+	const char *orig;
+	size_t orig_len;
 };
 
 static int anonymized_entry_cmp(const void *unused_cmp_data,
 				const struct hashmap_entry *eptr,
 				const struct hashmap_entry *entry_or_key,
-				const void *unused_keydata)
+				const void *keydata)
 {
 	const struct anonymized_entry *a, *b;
 
 	a = container_of(eptr, const struct anonymized_entry, hash);
-	b = container_of(entry_or_key, const struct anonymized_entry, hash);
+	if (keydata) {
+		const struct anonymized_entry_key *key = keydata;
+		int equal = !strncmp(a->orig, key->orig, key->orig_len) &&
+			    !a->orig[key->orig_len];
+		return !equal;
+	}
 
-	return a->orig_len != b->orig_len ||
-		memcmp(a->orig, b->orig, a->orig_len);
+	b = container_of(entry_or_key, const struct anonymized_entry, hash);
+	return strcmp(a->orig, b->orig);
 }
 
 /*
@@ -149,23 +158,22 @@ static const char *anonymize_str(struct hashmap *map,
 				 char *(*generate)(const char *, size_t),
 				 const char *orig, size_t len)
 {
-	struct anonymized_entry key, *ret;
+	struct anonymized_entry_key key;
+	struct anonymized_entry *ret;
 
 	if (!map->cmpfn)
 		hashmap_init(map, anonymized_entry_cmp, NULL, 0);
 
 	hashmap_entry_init(&key.hash, memhash(orig, len));
 	key.orig = orig;
 	key.orig_len = len;
-	ret = hashmap_get_entry(map, &key, hash, NULL);
+	ret = hashmap_get_entry(map, &key, hash, &key);
 
 	if (!ret) {
 		ret = xmalloc(sizeof(*ret));
 		hashmap_entry_init(&ret->hash, key.hash.hash);
 		ret->orig = xmemdupz(orig, len);
-		ret->orig_len = len;
 		ret->anon = generate(orig, len);
-		ret->anon_len = strlen(ret->anon);
 		hashmap_put(map, &ret->hash);
 	}
 
-- 
2.27.0.593.gb3082a2aaf

