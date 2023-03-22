Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E9AC76195
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCVRk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCVRkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:40:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454045D76B
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:40:53 -0700 (PDT)
Received: (qmail 10509 invoked by uid 109); 22 Mar 2023 17:40:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Mar 2023 17:40:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15906 invoked by uid 111); 22 Mar 2023 17:40:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Mar 2023 13:40:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Mar 2023 13:40:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] fast-export: factor out anonymized_entry creation
Message-ID: <20230322174051.GA11424@coredump.intra.peff.net>
References: <20230322173636.GA5643@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322173636.GA5643@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When anonymizing output, there's only one spot where we generate new
entries to add to our hashmap: when anonymize_str() doesn't find an
entry, we use the generate() callback to make one and add it. Let's pull
that into its own function in preparation for another caller.

Note that we'll add one extra feature. In anonymize_str(), we know that
we won't find an existing entry in the hashmap (since it will only try
to add after failing to find one). But other callers won't have the same
behavior, so we should catch this case and free the now-dangling entry.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index ba9ab3a97e5..5a0b63219ad 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -139,6 +139,29 @@ static int anonymized_entry_cmp(const void *cmp_data UNUSED,
 	return strcmp(a->orig, b->orig);
 }
 
+static struct anonymized_entry *add_anonymized_entry(struct hashmap *map,
+						     unsigned hash,
+						     const char *orig, size_t len,
+						     char *anon)
+{
+	struct anonymized_entry *ret, *old;
+
+	if (!map->cmpfn)
+		hashmap_init(map, anonymized_entry_cmp, NULL, 0);
+
+	FLEX_ALLOC_MEM(ret, orig, orig, len);
+	hashmap_entry_init(&ret->hash, hash);
+	ret->anon = anon;
+	old = hashmap_put_entry(map, ret, hash);
+
+	if (old) {
+		free(old->anon);
+		free(old);
+	}
+
+	return ret;
+}
+
 /*
  * Basically keep a cache of X->Y so that we can repeatedly replace
  * the same anonymized string with another. The actual generation
@@ -164,15 +187,9 @@ static const char *anonymize_str(struct hashmap *map,
 		ret = hashmap_get_entry(map, &key, hash, &key);
 
 	/* ...and finally generate a new mapping if necessary */
-	if (!ret) {
-		if (!map->cmpfn)
-			hashmap_init(map, anonymized_entry_cmp, NULL, 0);
-
-		FLEX_ALLOC_MEM(ret, orig, orig, len);
-		hashmap_entry_init(&ret->hash, key.hash.hash);
-		ret->anon = generate(data);
-		hashmap_put(map, &ret->hash);
-	}
+	if (!ret)
+		ret = add_anonymized_entry(map, key.hash.hash,
+					   orig, len, generate(data));
 
 	return ret->anon;
 }
-- 
2.40.0.595.g9b96b494d8c

