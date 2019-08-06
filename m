Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B0331F731
	for <e@80x24.org>; Tue,  6 Aug 2019 23:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfHFXnV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 19:43:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:36296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726133AbfHFXnV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 19:43:21 -0400
Received: (qmail 23275 invoked by uid 109); 6 Aug 2019 23:43:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 23:43:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7380 invoked by uid 111); 6 Aug 2019 23:45:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 19:45:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 19:43:20 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] --end-of-options marker
Message-ID: <20190806234319.GA19178@sigill.intra.peff.net>
References: <20190806143829.GA515@sigill.intra.peff.net>
 <20190806225853.GH118825@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806225853.GH118825@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 10:58:53PM +0000, brian m. carlson wrote:

> On 2019-08-06 at 14:38:30, Jeff King wrote:
> > It's hard for scripted uses of rev-list, etc, to avoid option injection
> > from untrusted arguments, because revision arguments must come before
> > any "--" separator. I.e.:
> > 
> >   git rev-list "$revision" -- "$path"
> > 
> > might mistake "$revision" for an option (with rev-list, that would make
> > it an error, but something like git-log would default to HEAD).
> > 
> > This series provides an alternative to "--" to stop option parsing
> > without indicating that further arguments are pathspecs.
> 
> Sorry, I hadn't had a chance to look at this series in depth, but I was
> wondering: could we not just accept two separate "--" arguments, and if
> there are two of them, interpret the first with the traditional meaning
> and the second with the Git-specific meaning? That would be much more
> intuitive for folks, although I suspect it would take a little more work
> in the options parser.

That also crossed my mind, but I think it opens up some complicated
corner cases.  For instance, if I'm parsing left-to-right and see "--",
how do I know which separator it is meant to be? I think the only rule
that makes sense is that you must have two "--", like:

  git rev-list [options] -- [revs] -- [paths]

but that means parsing the whole thing before we can interpret any of
it. What kinds of tricks can an attacker play by putting "--" in the
revs or paths areas? E.g., what does this mean:

  # expanded from "git rev-list -- $revs -- $paths"
  git rev-list -- --foo -- -- --bar --

I think if we at least choose the left-most "--" as the official
end-of-options then they can't inject an option (they can only inject a
rev as a path). I guess that's the same as with --end-of-options. But it
somehow feels less clear to me than a separate marker.

It also doesn't allow this:

  # allow paths and revs, with optional separator, but no more options
  git rev-list --end-of-options "$@"

though I'm not sure whether anybody cares.

-Peff
