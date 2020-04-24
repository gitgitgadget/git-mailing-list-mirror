Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE198C2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 05:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF0620700
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 05:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgDXFvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:51:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:38444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725554AbgDXFvH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 01:51:07 -0400
Received: (qmail 19962 invoked by uid 109); 24 Apr 2020 05:51:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Apr 2020 05:51:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23431 invoked by uid 111); 24 Apr 2020 06:02:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Apr 2020 02:02:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Apr 2020 01:51:06 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Casey <drafnel@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jessica Clarke <jrtc27@jrtc27.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] config.mak.uname: Define FREAD_READS_DIRECTORIES for
 GNU/Hurd
Message-ID: <20200424055106.GG1648190@coredump.intra.peff.net>
References: <20200422153347.40018-1-jrtc27@jrtc27.com>
 <20200422164150.GA140314@google.com>
 <CA+sFfMfre6W5GcPh1pWcroFD9S9OPj_uLp5CK11yh-UhqgDs2w@mail.gmail.com>
 <CA+sFfMf=NZOV41-4oJTLF34rvELr7EvfEHOr90X_h8pSFC3AJQ@mail.gmail.com>
 <20200422195839.GE558336@coredump.intra.peff.net>
 <CA+sFfMcsiXcEV=oq-cdm1zVm2gvn=Ae1BU264puFU=E2JBQVCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+sFfMcsiXcEV=oq-cdm1zVm2gvn=Ae1BU264puFU=E2JBQVCw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 02:18:15PM -0700, Brandon Casey wrote:

> > I know that wasn't the original intent of the flag, but I think it was a
> > conscious decision to build on around the time of e2d90fd1c, when we
> > started actually checking fopen() return values (as opposed to just
> > segfaulting).
> 
> Our policy has always been to check return values hasn't it?

Policy perhaps, but practice didn't always follow it. :) At any rate, my
point was just that as part of a larger cleanup, we found it useful at
that time to have an fopen() which behaved predictably on all platforms.

> > And in practice, do we really care about cases that can fopen a
> > directory but refuse to read from it? It's simpler and more efficient to
> > catch this case up front.
> 
> I'm not sure I agree that it's simpler and more efficient to catch
> this up front. Catching the case where a directory is supplied when
> only a file is valid is an error path which we generally do not
> optimize for, and it requires us to add an extra stat to every fopen()
> call. We should have always been checking both the fopen() and any
> reads and handle a failure in either one. So normally we wouldn't have
> to do anything special to produce an error for the case of a directory
> being supplied.

True, I guess it's not really more efficient (I was thinking that we had
to deal with it only once, not on each fread). I do think it's simpler,
though, as it means fopen() behaves the same everywhere.

> Now, if you want to ignore when a directory is supplied, and not
> produce an error, I would expect the code to actually check for that
> explicitly/clearly and not depend on fopen() failing, since that is
> not a common behavior.

Sure, we could be stat()-ing each file before fopen(). And if you think
it's worth going back to that direction, you can try to work up a patch.
My suspicion is that it will end up making the callers worse, for no
real gain.

> We've generally taken the approach that there is an expected "normal"
> behavior for the c library, generally the linux/glibc behavior. Then,
> for platforms that behaved differently from what we've defined as
> "normal", we'd introduce a compatibility function to make them behave
> the way we wanted them to behave, or as close to that as possible. But
> what you're suggesting here seems different. You're suggesting that we
> should modify the behavior of fopen from what is commonly considered
> "normal" so that it behaves in a new uncommon way. That doesn't seem
> like the right thing to do.

I think this is just defining a different "normal". And FWIW, I'm not
suggesting any particular change now. I think we went in this direction
a few years ago, and I'm just trying to explain the current state in
terms of that decision.

> Instead, I would think it would be better to introduce a new function
> that has the behavior we want and to explicitly call that function
> instead of pretending that we're calling fopen(). Otherwise it just
> leads to confusion since _our_ fopen() doesn't actually work the way
> fopen() "normally" works on our common platform.  Maybe call it
> fopen_file_only() or something. I've been away from git development
> for too long to know whether most fopen callsites would need to use an
> fopen_file_only() function or whether it would just be a few special
> instances, and the rest could just use a regular fopen().

Yeah, I think that would be fine. Though again, I'm really not sure that
it gains us all that much, and it would require auditing each fopen()
site to see whether it's depending on the current compat behavior or
not.

-Peff
