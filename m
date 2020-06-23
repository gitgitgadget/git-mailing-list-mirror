Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FF8C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBFB20774
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbgFWPZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:25:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:40166 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732885AbgFWPZA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:25:00 -0400
Received: (qmail 11854 invoked by uid 109); 23 Jun 2020 15:24:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 15:24:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16970 invoked by uid 111); 23 Jun 2020 15:24:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 11:24:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 11:24:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 06/10] fast-export: use a flex array to store anonymized
 entries
Message-ID: <20200623152458.GF1435482@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623152436.GA50925@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we're using a separate keydata struct for hash lookups, we have
more flexibility in how we allocate anonymized_entry structs. Let's push
the "orig" key into a flex member within the struct. That should save us
a few bytes of memory per entry (a pointer plus any malloc overhead),
and may make lookups a little faster (since it's one less pointer to
chase in the comparison function).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 5df2ada47d..99d4a2b404 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -120,8 +120,8 @@ static int has_unshown_parent(struct commit *commit)
 
 struct anonymized_entry {
 	struct hashmap_entry hash;
-	const char *orig;
 	const char *anon;
+	const char orig[FLEX_ARRAY];
 };
 
 struct anonymized_entry_key {
@@ -170,9 +170,8 @@ static const char *anonymize_str(struct hashmap *map,
 	ret = hashmap_get_entry(map, &key, hash, &key);
 
 	if (!ret) {
-		ret = xmalloc(sizeof(*ret));
+		FLEX_ALLOC_MEM(ret, orig, orig, len);
 		hashmap_entry_init(&ret->hash, key.hash.hash);
-		ret->orig = xmemdupz(orig, len);
 		ret->anon = generate(orig, len);
 		hashmap_put(map, &ret->hash);
 	}
-- 
2.27.0.517.gbc32778fa3

