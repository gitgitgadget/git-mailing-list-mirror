Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 283E01FBB0
	for <e@80x24.org>; Sat,  3 Sep 2016 00:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbcICA45 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 20:56:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:37333 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751765AbcICA44 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 20:56:56 -0400
Received: (qmail 6750 invoked by uid 109); 3 Sep 2016 00:56:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Sep 2016 00:56:56 +0000
Received: (qmail 30633 invoked by uid 111); 3 Sep 2016 00:57:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 20:57:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2016 20:56:53 -0400
Date:   Fri, 2 Sep 2016 20:56:53 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        spearce@spearce.org, sbeller@google.com
Subject: Re: [PATCH v2 2/2] connect: advertized capability is not a ref
Message-ID: <20160903005653.vzt3vel25vino7yk@sigill.intra.peff.net>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1472853827.git.jonathantanmy@google.com>
 <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
 <20160902233547.mzgluioc7hhabalw@sigill.intra.peff.net>
 <20160902235145.GI14758@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160902235145.GI14758@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2016 at 04:51:45PM -0700, Jonathan Nieder wrote:

> > I'd be more interested in the pain of this transition if there was a
> > concrete use case for "hide literally all refs, but still allow
> > fetches". Is that a thing that people do?
> 
> Sure, it is a thing that people do.  For example I've seen replication
> systems that learn what SHA-1s to fetch out-of-band and then use this
> approach to avoid the overhead of a long ref advertisement.

I know that's how those features work. I was more wondering if it ever
comes up that somebody actually has hidden refs, but _no_ non-hidden
ones. Do the systems you've seen hide all the refs?

> However, that is not my motivation.  My motivation is being able to
> extend the protocol in the future.  The capabilities line has been
> important for that historically.

Sure, I agree it's a nice move forward for compatibility. But that
argues for teaching the clients to handle it (for the future), and then
turning it on in the server only when it becomes useful (i.e., the "in a
year or so" can become "when we find a use for it").

In a similar vein, I'd think that a config to enable this in upload-pack
today could have an "auto" mode, which enables it _only_ when you know
something productive might come of it (namely that you have hidden refs,
one of the uploadpack.allow* features is enabled, and the ref
advertisement is empty). Then requests which could not benefit from it
at all do not have to pay the potential compatibility cost.

> Do you have any objection to the server gaining support for this
> guarded by a configuration option?  Then when the time comes to
> consider flipping the default we can use real-world statistics about
> what git client versions people use to make an informed decision.

Guarded by config, no. It's the flipping of the default I care more
about. The config is not necessary in the meantime for getting
real-world statistics; you can add the config and flip the default as
one unit at any time (the thing that is time-critical is teaching the
client to handle _both_ cases gracefully).

The config is useful in the meantime if there are people who could
benefit from it immediately, and don't mind paying the compatibility
cost. With an "auto" as I described above, using that as the default
seems like a decent interim behavior (i.e., why would you set up such a
repository if you didn't expect most clients to use the allowTipSHA1
feature?). I'd still probably give some lag between shipping the client,
and flipping the server default to "auto".

I hoped to share some numbers on what versions people are currently
using against GitHub, to get a sense of how far back most people are.
But I haven't been actively involved in keeping those numbers for a
while, and I'm not sure what we have readily stored. I did show some
numbers a few years ago[1], and it looks like about 2/3 of people were
within 6-12 months of the latest version, but the rest was a long tail.

I don't know if that will have changed with the advent of more client
versions (e.g., lots more people are using libgit2 now via GUI clients,
Visual Studio, etc; how does it fare with the proposed change?).

-Peff

[1] http://public-inbox.org/git/20120531114801.GA21367@sigill.intra.peff.net/
