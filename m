Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F0A207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 16:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753819AbcILQqW (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 12:46:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:41969 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751120AbcILQqV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 12:46:21 -0400
Received: (qmail 15652 invoked by uid 109); 12 Sep 2016 16:46:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 16:46:20 +0000
Received: (qmail 14421 invoked by uid 111); 12 Sep 2016 16:46:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 12:46:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 12:46:17 -0400
Date:   Mon, 12 Sep 2016 12:46:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #03; Fri, 9)
Message-ID: <20160912164616.vg33kldazuthff3d@sigill.intra.peff.net>
References: <xmqqoa3w8zco.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa3w8zco.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 03:47:35PM -0700, Junio C Hamano wrote:

> * jk/delta-base-cache (2016-08-23) 7 commits
>   (merged to 'next' on 2016-08-25 at f1c141a)
>  + t/perf: add basic perf tests for delta base cache
>  + delta_base_cache: use hashmap.h
>  + delta_base_cache: drop special treatment of blobs
>  + delta_base_cache: use list.h for LRU
>  + release_delta_base_cache: reuse existing detach function
>  + clear_delta_base_cache_entry: use a more descriptive name
>  + cache_or_unpack_entry: drop keep_cache parameter
> 
>  The delta-base-cache mechanism has been a key to the performance in
>  a repository with a tightly packed packfile, but it did not scale
>  well even with a larger value of core.deltaBaseCacheLimit.

I happened to notice today that this topic needs a minor tweak:

-- >8 --
Subject: [PATCH] add_delta_base_cache: use list_for_each_safe

We may remove elements from the list while we are iterating,
which requires using a second temporary pointer. Otherwise
stepping to the next element of the list might involve
looking at freed memory (which generally works in practice,
as we _just_ freed it, but of course is wrong to rely on;
valgrind notices it).

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index a57b71d..132c861 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2187,11 +2187,11 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	void *base, unsigned long base_size, enum object_type type)
 {
 	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
-	struct list_head *lru;
+	struct list_head *lru, *tmp;
 
 	delta_base_cached += base_size;
 
-	list_for_each(lru, &delta_base_cache_lru) {
+	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
 		struct delta_base_cache_entry *f =
 			list_entry(lru, struct delta_base_cache_entry, lru);
 		if (delta_base_cached <= delta_base_cache_limit)
-- 
2.10.0.230.g6f8d04b

