Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD641F404
	for <e@80x24.org>; Sat,  1 Sep 2018 07:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeIAMAy (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 08:00:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:36134 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726435AbeIAMAy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 08:00:54 -0400
Received: (qmail 24407 invoked by uid 109); 1 Sep 2018 07:49:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Sep 2018 07:49:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11604 invoked by uid 111); 1 Sep 2018 07:50:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Sep 2018 03:50:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Sep 2018 03:49:48 -0400
Date:   Sat, 1 Sep 2018 03:49:48 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] traverse_bitmap_commit_list(): don't free result
Message-ID: <20180901074948.GC25461@sigill.intra.peff.net>
References: <20180901074145.GA24023@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180901074145.GA24023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since it was introduced in fff42755ef (pack-bitmap: add
support for bitmap indexes, 2013-12-21), this function has
freed the result after traversing it. That is an artifact of
the early days of the bitmap code, when we had a single
static "struct bitmap_index". Back then, it was intended
that you would do:

  prepare_bitmap_walk(&revs);
  traverse_bitmap_commit_list(&revs);

Since the actual bitmap_index struct was totally behind the
scenes, it was convenient for traverse_bitmap_commit_list()
to clean it up, clearing the way for another traversal.

But since 3ae5fa0768 (pack-bitmap: remove bitmap_git global
variable, 2018-06-07), the caller explicitly manages the
bitmap_index struct itself, like this:

  b = prepare_bitmap_walk(&revs);
  traverse_bitmap_commit_list(b, &revs);
  free_bitmap_index(b);

It no longer makes sense to auto-free the result after the
traversal. If you want to do another traversal, you'd just
create a new bitmap_index. And while nobody tries to call
traverse_bitmap_commit_list() twice, the fact that it throws
away the result might be surprising, and is better avoided.

Note that in the "old" way it was possible for two walks to
amortize the cost of opening the on-disk .bitmap file (since
it was stored in the global bitmap_index), but we lost that
in 3ae5fa0768. However, no code actually does this, so it's
not worth addressing now. The solution might involve a new:

  reset_bitmap_walk(b, &revs);

call. Or we might even attach the bitmap data to its
matching packed_git struct, so that multiple
prepare_bitmap_walk() calls could use it. That can wait
until somebody actually has need of the optimization (and
until then, we'll do the correct, unsurprising thing).

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 76fd93a3de..8c1af1cca2 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -848,9 +848,6 @@ void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
 		OBJ_TAG, show_reachable);
 
 	show_extended_objects(bitmap_git, show_reachable);
-
-	bitmap_free(bitmap_git->result);
-	bitmap_git->result = NULL;
 }
 
 static uint32_t count_object_type(struct bitmap_index *bitmap_git,
-- 
2.19.0.rc1.549.g6ce4dc0f08

