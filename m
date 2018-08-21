Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC79D1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 21:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeHVAvQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 20:51:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:51018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726628AbeHVAvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 20:51:16 -0400
Received: (qmail 12304 invoked by uid 109); 21 Aug 2018 21:29:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 21:29:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27261 invoked by uid 111); 21 Aug 2018 21:29:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 17:29:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 17:29:24 -0400
Date:   Tue, 21 Aug 2018 17:29:24 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180821212923.GB24431@sigill.intra.peff.net>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 04:41:02PM -0400, Derrick Stolee wrote:

> On 8/20/2018 6:13 PM, Junio C Hamano wrote:
> > An early preview release Git v2.19.0-rc0 is now available for
> > testing at the usual places.
> 
> As part of testing the release candidate, I ran the performance suite
> against a fresh clone of the Linux repository using v2.18.0 and v2.19.0-rc0
> (also: GIT_PERF_REPEAT_COUNT=10).

Wow, you're a glutton for punishment. :)

> I found a few nice improvements, but I
> also found a possible regression in tree walking. I say "tree walking"
> because it was revealed using p0001-rev-list.sh, but only with the
> "--objects" flag. I also saw some similar numbers on 'git log --raw'.
> 
> Test v2.18.0             v2.19.0-rc0
> --------------------------------------------------------------------------------------------
> 0001.1: rev-list --all 6.69(6.33+0.35)     6.52(6.20+0.31) -2.5%
> 0001.2: rev-list --all --objects 52.14(47.43+1.02)   57.15(51.09+1.18) +9.6%
> 
> To me, 9.6% seems out of the range of just noise for this length of a
> command, but I could be wrong. Could anyone else try to repro these results?

I got:

0001.2: rev-list --all --objects  37.07(36.62+0.45)   39.11(38.58+0.51) +5.5%

Less change, but my overall times were smaller, too, so clearly our
hardware or exact repos are a little bit different. Those numbers seem
pretty consistent in further runs.

It bisects to 509f6f62a4 (cache: update object ID functions for
the_hash_algo, 2018-07-16). Which make sense. An "--objects" traversal
spends a huge amount of time checking each tree entry to see if we've
processed that object yet, which ends up as hashcmp() in the hash table.
I expect that a fixed 20-byte memcmp() can be optimized a lot more than
one with an arbitrary value.

Even if _we_ know the value can only take on one of a few values, I
don't know that we have an easy way to tell the compiler that. Possibly
we could improve things by jumping directly to an optimized code path.
Sort of a poor-man's JIT. ;)

Doing this:

diff --git a/cache.h b/cache.h
index b1fd3d58ab..9c004a26c9 100644
--- a/cache.h
+++ b/cache.h
@@ -1023,7 +1023,10 @@ extern const struct object_id null_oid;
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
-	return memcmp(sha1, sha2, the_hash_algo->rawsz);
+	if (the_hash_algo->rawsz == 20)
+		return memcmp(sha1, sha2, 20);
+	else
+		return memcmp(sha1, sha1, the_hash_algo->rawsz);
 }
 
 static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
on top of v2.19-rc0 seems to give me about a 3% speedup (though I might
be imaging it, as there's a bit of noise). A function pointer in
the_hash_algo might make even more sense.

-Peff
