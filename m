Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8C8EB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 22:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGBWhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 18:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGBWht (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 18:37:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B125F1B7
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 15:37:48 -0700 (PDT)
Received: (qmail 18000 invoked by uid 109); 2 Jul 2023 22:37:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 02 Jul 2023 22:37:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16720 invoked by uid 111); 2 Jul 2023 22:37:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 02 Jul 2023 18:37:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 2 Jul 2023 18:37:47 -0400
From:   Jeff King <peff@peff.net>
To:     Jan =?utf-8?Q?Kl=C3=B6tzke?= <jan@kloetzke.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Steve Kemp <steve@steve.org.uk>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 2/3] ref-filter: avoid parsing non-tags in match_points_at()
Message-ID: <20230702223747.GB3494279@coredump.intra.peff.net>
References: <20230702223342.GA1598765@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230702223342.GA1598765@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When handling --points-at, we have to try to peel each ref to see if
it's a tag that points at a requested oid. We start this process by
calling parse_object() on the oid pointed to by each ref.

The cost of parsing each object adds up, especially in an output that
doesn't otherwise need to open the objects at all. Ideally we'd use
peel_iterated_oid() here, which uses the cached information in the
packed-refs file. But we can't, because our --points-at must match not
only the fully peeled value, but any interim values (so if tag A points
to tag B which points to commit C, we should match --points-at=B, but
peel_iterated_oid() will only tell us about C).

So the best we can do (absent changes to the packed-refs peel traits) is
to avoid parsing non-tags. The obvious way to do that is to call
oid_object_info() to check the type before parsing. But there are a few
gotchas there, like checking if the object has already been parsed.

Instead we can just tell parse_object() that we are OK skipping the hash
check, which lets it turn on several optimizations. Commits can be
loaded via the commit graph (so it's both fast and we have the benefit
of the parsed data if we need it later at the output stage). Blobs are
not loaded at all. Trees are still loaded, but it's rather rare to have
a ref point directly to a tree (and since this is just an optimization,
kicking in 99% of the time is OK).

Even though we're paying for an extra lookup, the cost to avoid parsing
the non-tags is a net benefit. In my git.git repository with 941 tags
and 1440 other refs pointing to commits, this significantly cuts the
runtime:

  Benchmark 1: ./git.old for-each-ref --points-at=HEAD
    Time (mean ± σ):      26.8 ms ±   0.5 ms    [User: 24.5 ms, System: 2.2 ms]
    Range (min … max):    25.9 ms …  29.2 ms    107 runs

  Benchmark 2: ./git.new for-each-ref --points-at=HEAD
    Time (mean ± σ):       9.1 ms ±   0.3 ms    [User: 6.8 ms, System: 2.2 ms]
    Range (min … max):     8.6 ms …  10.2 ms    308 runs

  Summary
    './git.new for-each-ref --points-at=HEAD' ran
      2.96 ± 0.10 times faster than './git.old for-each-ref --points-at=HEAD'

In a repository that is mostly annotated tags, we'd expect less
improvement (we might still skip a few object loads, but that's balanced
by the extra lookups). In my clone of linux.git, which has 782 tags and
3 branches, the run-time is about the same (it's actually ~1% faster on
average after this patch, but that's within the run-to-run noise).

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index e091f056ab..f5ac486430 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2223,7 +2223,8 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 
 	if (oid_array_lookup(points_at, oid) >= 0)
 		return oid;
-	obj = parse_object(the_repository, oid);
+	obj = parse_object_with_flags(the_repository, oid,
+				      PARSE_OBJECT_SKIP_HASH_CHECK);
 	while (obj && obj->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *)obj;
 
-- 
2.41.0.586.g3c0cc15bc7

