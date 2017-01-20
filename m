Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE1B20756
	for <e@80x24.org>; Fri, 20 Jan 2017 19:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbdATTm1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 14:42:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:42273 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752630AbdATTm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 14:42:26 -0500
Received: (qmail 13057 invoked by uid 109); 20 Jan 2017 19:42:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 19:42:26 +0000
Received: (qmail 6482 invoked by uid 111); 20 Jan 2017 19:43:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 14:43:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jan 2017 14:42:24 -0500
Date:   Fri, 20 Jan 2017 14:42:24 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] Disallow commands from within unpopulated submodules.
Message-ID: <20170120194224.vikzovupwqx53x2c@sigill.intra.peff.net>
References: <20170119193023.26837-1-sbeller@google.com>
 <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
 <CAGZ79kaJQefSDkV-LKxRCTtSepsNsX7U+AZqy3Z_YCd1xsmTxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaJQefSDkV-LKxRCTtSepsNsX7U+AZqy3Z_YCd1xsmTxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 11:33:45AM -0800, Stefan Beller wrote:

> > I'd rather see it in the commands themselves. Especially given the
> > "ideal" in your status example, which requires command-specific
> > knowledge.
> 
> So you rather want to go bottom up, i.e. add it to each command individually
> for which it makes sense, instead of rather first having a catch-it-all like
> this and then we can have a flag similar to RUN_SETUP, e.g.
> ALLOW_IN_UNPOP_SUBMODULE, which allows commands to
> take over the responsibility to act responsibly in this case?

Yes. I know it's "less safe" in the sense that commands have to make an
effort to detect the situation, but I feel like only they'll know what
the sensible behavior is. And they can also do the check at a time when
they would be reading the index anyway.

> status may be the first command for going that route; I wonder if we'd
> want to add this feature unconditionally or only in the porcelain case.
> (In plumbing you're supposed to know what you're doing... so there is
> no need as well as our promise to not change it)

Yeah. The reason that it would be so painful to load the index
for every rev-parse is not just that it probably doesn't otherwise need
the index, but that scripts may make a _ton_ of rev-parse (or other
plumbing) calls.

One alternative would be to make the check cheaper. Could we reliably
tell from the submodule.foo.* block in the config that path "foo" is a
submodule? I think that would work after "submodule init" but not right
after "git clone". So the index really is the source of truth there.

I guess there could be an index extension "these are the gitlinks I
contain" and in theory we could read just that extension. I dunno.

-Peff
