Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E28F1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 05:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeHWIaR (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 04:30:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:52744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728184AbeHWIaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 04:30:16 -0400
Received: (qmail 21090 invoked by uid 109); 23 Aug 2018 05:02:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 05:02:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7633 invoked by uid 111); 23 Aug 2018 05:02:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 Aug 2018 01:02:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2018 01:02:25 -0400
Date:   Thu, 23 Aug 2018 01:02:25 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180823050224.GA318@sigill.intra.peff.net>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823022756.GF92374@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823022756.GF92374@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 07:27:56PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > FWIW, it's not 10%. The best I measured was ~4% on a very
> > hashcmp-limited operation, and I suspect even that may be highly
> > dependent on the compiler. We might be able to improve more by
> > sprinkling more asserts around, but there are 75 mentions of
> > the_hash_algo->rawsz. I wouldn't want to an assert at each one.
> >
> > I don't mind doing one or a handful of these asserts as part of v2.19 if
> > we want to try to reclaim those few percent. But I suspect the very
> > first commit in any further hash-transition work is just going to be to
> > rip them all out.
> 
> I was thinking just hashcmp and hashcpy.
> 
> Ideally such a change would come with a performance test to help the
> person writing that very first commit.  Except we already have
> performance tests that capture this. ;-)
> 
> For further hash-transition work, I agree someone may want to revert
> this, and I don't mind such a revert appearing right away in "next".
> And it's possible that we might have to do the equivalent of manual
> template expansion to recover the performance in some
> performance-sensitive areas.  Maybe we can get the compiler to
> cooperate with us in that and maybe we can't.  That's okay with me.
> 
> Anyway, I'll resend your patch with a commit message added some time
> this evening.

Here's the patch. For some reason my numbers aren't quite as large as
they were yesterday (I was very careful to keep the system unloaded
today, whereas yesterday I was doing a few other things, so perhaps that
is the difference).

-- >8 --
Subject: [PATCH] hashcmp: assert constant hash size

Prior to 509f6f62a4 (cache: update object ID functions for
the_hash_algo, 2018-07-16), hashcmp() called memcmp() with a
constant size of 20 bytes. Some compilers were able to turn
that into a few quad-word comparisons, which is faster than
actually calling memcmp().

In 509f6f62a4, we started using the_hash_algo->rawsz
instead. Even though this will always be 20, the compiler
doesn't know that while inlining hashcmp() and ends up just
generating a call to memcmp().

Eventually we'll have to deal with multiple hash sizes, but
for the upcoming v2.19, we can restore some of the original
performance by asserting on the size. That gives the
compiler enough information to know that the memcmp will
always be called with a length of 20, and it performs the
same optimization.

Here are numbers for p0001.2 run against linux.git on a few
versions. This is using -O2 with gcc 8.2.0.

  Test     v2.18.0             v2.19.0-rc0               HEAD
  ------------------------------------------------------------------------------
  0001.2:  34.24(33.81+0.43)   34.83(34.42+0.40) +1.7%   33.90(33.47+0.42) -1.0%

You can see that v2.19 is a little slower than v2.18. This
commit ended up slightly faster than v2.18, but there's a
fair bit of run-to-run noise (the generated code in the two
cases is basically the same). This patch does seem to be
consistently 1-2% faster than v2.19.

I tried changing hashcpy(), which was also touched by
509f6f62a4, in the same way, but couldn't measure any
speedup. Which makes sense, at least for this workload. A
traversal of the whole commit graph requires looking up
every entry of every tree via lookup_object(). That's many
multiples of the numbers of objects in the repository (most
of the lookups just return "yes, we already saw that
object").

Reported-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/cache.h b/cache.h
index b1fd3d58ab..4d014541ab 100644
--- a/cache.h
+++ b/cache.h
@@ -1023,6 +1023,16 @@ extern const struct object_id null_oid;
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
+	/*
+	 * This is a temporary optimization hack. By asserting the size here,
+	 * we let the compiler know that it's always going to be 20, which lets
+	 * it turn this fixed-size memcmp into a few inline instructions.
+	 *
+	 * This will need to be extended or ripped out when we learn about
+	 * hashes of different sizes.
+	 */
+	if (the_hash_algo->rawsz != 20)
+		BUG("hash size not yet supported by hashcmp");
 	return memcmp(sha1, sha2, the_hash_algo->rawsz);
 }
 
-- 
2.19.0.rc0.412.g7005db4e88

