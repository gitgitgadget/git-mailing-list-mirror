Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826F1C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F1364DC4
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhA1GRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:17:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:41632 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhA1GRb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:17:31 -0500
Received: (qmail 9645 invoked by uid 109); 28 Jan 2021 06:16:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 06:16:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25329 invoked by uid 111); 28 Jan 2021 06:16:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 01:16:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 01:16:50 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] rerere: tighten rr-cache dirname check
Message-ID: <YBJW0gRn9SnP6N9d@coredump.intra.peff.net>
References: <YBJVuckmbGriVa//@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBJVuckmbGriVa//@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check only that get_sha1_hex() doesn't complain, which means we'd
match an all-hex name with trailing cruft after it. This probably
doesn't matter much in practice, since there shouldn't be anything else
ni the rr-cache directory, but it could possibly cause us to mix up sha1
and sha256 entries (which also shouldn't be intermingled, but could be
leftovers from a repository conversion).

Note that "get_sha1_hex()" is a confusing historical name. It is
actually using the_hash_algo, so it would be sha256 in a sha256 repo.
We'll switch to using parse_oid_hex(), because that conveniently
advances our pointer. But it also gets rid of the sha1 name. Arguably
it's a little funny to use "object_id" here for something that isn't
actually naming an object, but it's unlikely to be a problem (and is
contained in a single function).

Signed-off-by: Jeff King <peff@peff.net>
---
This is mostly just an oddity I noticed while touching the code, and
I've never seen triggered in real life.

 rerere.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rerere.c b/rerere.c
index 7b0c262ac6..e92e305f96 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1181,8 +1181,9 @@ static void prune_one(struct rerere_id *id,
 /* Does the basename in "path" look plausibly like an rr-cache entry? */
 static int is_rr_cache_dirname(const char *path)
 {
-	unsigned char hash[GIT_MAX_RAWSZ];
-	return !get_sha1_hex(path, hash);
+	struct object_id oid;
+	const char *end;
+	return !parse_oid_hex(path, &oid, &end) && !*end;
 }
 
 void rerere_gc(struct repository *r, struct string_list *rr)
-- 
2.30.0.758.gfe500d6872

