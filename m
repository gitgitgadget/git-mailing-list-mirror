Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6521F954
	for <e@80x24.org>; Thu, 23 Aug 2018 02:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeHWFnk (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 01:43:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:52654 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726267AbeHWFnj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 01:43:39 -0400
Received: (qmail 15215 invoked by uid 109); 23 Aug 2018 02:16:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 02:16:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6647 invoked by uid 111); 23 Aug 2018 02:16:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 22:16:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 22:16:18 -0400
Date:   Wed, 22 Aug 2018 22:16:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180823021618.GA12052@sigill.intra.peff.net>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823012343.GB92374@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 06:23:43PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> >> On Tue, 2018-08-21 at 23:03 -0400, Jeff King wrote:
> 
> >>>  static inline int hashcmp(const unsigned char *sha1, const unsigned
> >>> char *sha2)
> >>>  {
> >>> +       assert(the_hash_algo->rawsz == 20);
> >>>         return memcmp(sha1, sha2, the_hash_algo->rawsz);
> >>>  }
> [...]
> >              The bigger questions are:
> >
> >   - are we OK with such an assertion; and
> >
> >   - does the assertion still give us the desired behavior when we add in
> >     a branch for rawsz==32?
> >
> > And I think the answers for those are both "probably not".
> 
> At this point in the release process, I think the answer to the first
> question is a pretty clear "yes".
> 
> A ~10% increase in latency of some operations is quite significant, in
> exchange for no user benefit yet.  We can continue to try to figure
> out how to convince compilers to generate good code for this (and
> that's useful), but in the meantime we should also do the simple thing
> to avoid the regression for users.

FWIW, it's not 10%. The best I measured was ~4% on a very
hashcmp-limited operation, and I suspect even that may be highly
dependent on the compiler. We might be able to improve more by
sprinkling more asserts around, but there are 75 mentions of
the_hash_algo->rawsz. I wouldn't want to an assert at each one.

I don't mind doing one or a handful of these asserts as part of v2.19 if
we want to try to reclaim those few percent. But I suspect the very
first commit in any further hash-transition work is just going to be to
rip them all out.

-Peff
