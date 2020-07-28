Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC756C433E5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FD020786
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgG1Plf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:41:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:39770 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730821AbgG1Ple (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 11:41:34 -0400
Received: (qmail 26880 invoked by uid 109); 28 Jul 2020 15:41:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 15:41:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25350 invoked by uid 111); 28 Jul 2020 15:41:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 11:41:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 11:41:32 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Anders Waldenborg <anders@0x63.nu>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Questions about trailer configuration semantics
Message-ID: <20200728154132.GA817108@coredump.intra.peff.net>
References: <87blk0rjob.fsf@0x63.nu>
 <xmqqr1swg9lc.fsf@gitster.c.googlers.com>
 <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com>
 <87a6zkr5z7.fsf@0x63.nu>
 <CAP8UFD1JZhNVDJ=fe-FLzmBqSbAwyaJuABK-G+-keL4LanZbpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1JZhNVDJ=fe-FLzmBqSbAwyaJuABK-G+-keL4LanZbpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 09:07:18AM +0200, Christian Couder wrote:

> > Maybe what I'm missing is a clear picture of the different cases that
> > "git interpret-trailers" is being used in. The "--trailer x=10" option
> > seems clearly designed for human input trying to be as helpful as
> > possible (e.g always allowing '=' regardless of separators
> > configured). But when reading a message with trailers, is same
> > helpfulness useful? Or is it always only reading proper trailers
> > previously added by --trailer?
> 
> I guess it depends on the purpose of reading a message with trailers.
> If you want to do stats for example, do you really want to consider
> "Reviewed", "Reviewer" and "Reviewed-by" as different trailers in your
> stats?

My guess would be that yes, you probably would want them to be
different. They _might_ be typos of each other, in which case
normalizing is helpful. But they might well have totally different
meanings. It will really depend on the project's use of the trailers,
and I'd expect any stats-gathering to do that kind of normalization much
later. I.e., use Git to reliably get "foo: bar" output from all of the
commits, and then count them up in a perl script or whatever, lumping
together like fields at that stage.

It's inevitable that you'll have to do some data cleanup like that
anyway. Lumping together prefixes isn't flexible enough to coverall
cases. Using trailer.*.key to manually map names covers more, but again
not all (e.g., if the project used to use "foo" but switched to "bar",
but the syntax of the value fields also changed at the same time, you'd
need to normalize those, too).

So to me it boils down to:

  - returning the data as verbatim as possible when reading existing
    trailers would give the least surprise to most people

  - real data collection is going to involve a separate post-processing
    step which is better done in a full programming language

> > There is also some inconsistency here. If one use '%(trailers) the
> > normalization doesn't happen. Only if using '%(trailers:only)' or some
> > other option.
> >
> > (because optimization in format_trailer_info:
> >  /* If we want the whole block untouched, we can take the fast path. */)
> 
> Maybe that's a bug. Peff, it looks like you added the above comment.
> Do you think it's a bug?

The original %(trailers) was "dump the trailers block verbatim". But
that's not super useful for parsing individual trailers. So "only"
actually starts parsing the individual trailers. I'd argue that the
%(trailers) behavior is correct, but that %(trailers:only) should
probably be doing less (i.e., just parsing and reporting what it finds,
but not changing any names).

-Peff
