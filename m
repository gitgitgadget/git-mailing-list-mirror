Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D7C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326EA20702
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHXRhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:37:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:38842 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgHXRhh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:37:37 -0400
Received: (qmail 22166 invoked by uid 109); 24 Aug 2020 17:37:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2020 17:37:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14946 invoked by uid 111); 24 Aug 2020 17:37:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2020 13:37:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Aug 2020 13:37:35 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] index-pack: adjust default threading cap
Message-ID: <20200824173735.GA673908@coredump.intra.peff.net>
References: <20200821175153.GA3263018@coredump.intra.peff.net>
 <20200821175800.GC3263141@coredump.intra.peff.net>
 <20200822011607.GX8085@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200822011607.GX8085@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 22, 2020 at 01:16:07AM +0000, brian m. carlson wrote:

> > +		if (nr_threads < 4)
> > +			; /* too few cores to consider capping */
> > +		else if (nr_threads < 6)
> > +			nr_threads = 3; /* historic cap */
> > +		else if (nr_threads < 40)
> > +			nr_threads /= 2;
> 
> I was going to ask if we could make the halving conditional on x86_64,
> but it turns out POWER and UltraSPARC also have SMT, so that doesn't
> make sense.  I expect that most users who have more than 6 "cores" are
> going to be on one of those systems or possibly ARM64, and since the
> performance penalty of using half as many cores isn't that significant,
> I'm not sure it's worth worrying about further.  This will be an
> improvement regardless.
> 
> Which is just a long way of saying, this patch seems fine to me.

OK, good. :) I agree there may be room for more improvement on those
systems. But lacking access to any, my goal was to make things better on
systems I _could_ test on, and not make things worse on other systems.
So I'd be very happy if people on other platforms (especially non-intel
ones) wanted to run:

  cd t/perf
  GIT_PERF_EXTRA=1 \
  GIT_PERF_LARGE_REPO=/path/to/clone/of/linux.git \
  ./p5302-pack-index.sh

and report the results.

I do have a slightly-old AMD machine with 4 cores (an A8-7600). Here's
what it says:

  5302.3: index-pack 0 threads                   447.67(436.62+6.57)
  5302.4: index-pack 1 threads                   450.80(441.26+7.20)
  5302.5: index-pack 2 threads                   265.62(459.56+7.30)
  5302.6: index-pack 4 threads                   177.06(477.56+8.22)
  5302.7: index-pack default number of threads   202.60(473.15+7.61)

So it does get better with 4 threads (but we continue to cap it at 3).
I wonder whether we should just do:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9721bf1ffe..d7453d0c09 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1809,7 +1809,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		if (nr_threads < 4)
 			; /* too few cores to consider capping */
 		else if (nr_threads < 6)
-			nr_threads = 3; /* historic cap */
+			nr_threads = nr_threads;
 		else if (nr_threads < 40)
 			nr_threads /= 2;
 		else

That does probably make things slightly worse for a 6-core hyperthreaded
Intel machine. And it doesn't help an actual 8-core AMD machine at all.

-Peff
