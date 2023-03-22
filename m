Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71637C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCVRi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCVRiU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:38:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF394DBFD
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:38:05 -0700 (PDT)
Received: (qmail 10444 invoked by uid 109); 22 Mar 2023 17:38:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Mar 2023 17:38:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15870 invoked by uid 111); 22 Mar 2023 17:38:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Mar 2023 13:38:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Mar 2023 13:38:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] fast-export: simplify initialization of anonymized
 hashmaps
Message-ID: <20230322173804.GB5795@coredump.intra.peff.net>
References: <20230322173636.GA5643@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322173636.GA5643@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We take pains to avoid doing a lookup on a hashmap which has not been
initialized with hashmap_init(). That was necessary back when this code
was written. But hashmap_get() became safer in b7879b0ba6e (hashmap:
allow re-use after hashmap_free(), 2020-11-02). Since then it's OK to
call functions on a zero-initialized table; it will just correctly
return NULL, since there is no match.

This simplifies the code a little, and also lets us keep the
initialization line closer to when we add an entry (which is when the
hashmap really does need to be totally initialized). That will help
later refactoring.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index f422819c82a..ba9ab3a97e5 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -152,25 +152,22 @@ static const char *anonymize_str(struct hashmap *map,
 	struct anonymized_entry_key key;
 	struct anonymized_entry *ret;
 
-	if (!map->cmpfn)
-		hashmap_init(map, anonymized_entry_cmp, NULL, 0);
-
 	hashmap_entry_init(&key.hash, memhash(orig, len));
 	key.orig = orig;
 	key.orig_len = len;
 
 	/* First check if it's a token the user configured manually... */
-	if (anonymized_seeds.cmpfn)
-		ret = hashmap_get_entry(&anonymized_seeds, &key, hash, &key);
-	else
-		ret = NULL;
+	ret = hashmap_get_entry(&anonymized_seeds, &key, hash, &key);
 
 	/* ...otherwise check if we've already seen it in this context... */
 	if (!ret)
 		ret = hashmap_get_entry(map, &key, hash, &key);
 
 	/* ...and finally generate a new mapping if necessary */
 	if (!ret) {
+		if (!map->cmpfn)
+			hashmap_init(map, anonymized_entry_cmp, NULL, 0);
+
 		FLEX_ALLOC_MEM(ret, orig, orig, len);
 		hashmap_entry_init(&ret->hash, key.hash.hash);
 		ret->anon = generate(data);
-- 
2.40.0.595.g9b96b494d8c

