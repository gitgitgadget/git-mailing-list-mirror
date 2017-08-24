Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3634A208DC
	for <e@80x24.org>; Thu, 24 Aug 2017 13:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbdHXNxf (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 09:53:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:47890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752634AbdHXNxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 09:53:35 -0400
Received: (qmail 17304 invoked by uid 109); 24 Aug 2017 13:53:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Aug 2017 13:53:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9570 invoked by uid 111); 24 Aug 2017 13:54:03 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Aug 2017 09:54:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Aug 2017 06:53:32 -0700
Date:   Thu, 24 Aug 2017 06:53:32 -0700
From:   Jeff King <peff@peff.net>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
Message-ID: <20170824135331.27wtwicjuoiyremx@sigill.intra.peff.net>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
 <20170816083432.rgurgckch6phcul3@sigill.intra.peff.net>
 <0beb0a6c-acb3-ae24-5c52-95747f74c07f@suse.de>
 <20170823214349.k4ayl2urqepch7p4@sigill.intra.peff.net>
 <e11d4449-8377-dbd7-3ad5-441baf7446b6@morey-chaisemartin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e11d4449-8377-dbd7-3ad5-441baf7446b6@morey-chaisemartin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 10:00:47AM +0200, Nicolas Morey-Chaisemartin wrote:

> > Yes, I agree. I was hoping when we started this discussion that we were
> > more ready to switch to curl-by-default. But sadly, that isn't close to
> > being the case. But hopefully we can at least end up with logic that
> > lets us use it in the easy cases (no tunneling) and falls back in the
> > harder ones.
>
> I opened a bug upstream and they already fixed this.
> https://github.com/curl/curl/pull/1820

Cool! That's much faster than I had expected. :)

> At least bleeding edge curl user should be able to use this.
> I'm not sure where to go with these patches now.
> 
> 1) There does not seem to be an easy/clean workaround for the lack of socketpair on windows.
> Fidling with a loopback AF_UNIX?AF_LOCAL socket should work but it
> means creating a socket file somewhere which pulls a lot of potential
> issues (where to put it ? Post-mortem cleanup ? Parallel imap-send ?)

Even if you create a non-anonymous socket and connect to both ends, I'm
not sure how it works to pass that to the spawned child. IIRC, our
run_command emulation cannot pass arbitrary descriptors to the child
processes (but I don't know the details of why that is the case, or if
there are windows-specific calls we could be making to work around it).

> 2) The PREAUTH support won't largely be available  for a while (curl,
> release, distro, etc.)
> - If this is the main use case, it does not make much sense to puch
> curl; tunneling support without this. I could push the code and only
> enable the curl tunneling for the next curl release ?
>   Meaning no one (or close to no one) would use this until some later
>   This also means very little testing (apart from mine) until the next
> curl version gets widely available
> - If this is not the main case (or at least the non PREAUTH is
> important enough), it would make sense to get this changes in.
>   But it would probably need some more to code to either fallback to
> legacy mode when curl failed (due to PREAUTH) or detect PREAUTH and
> directly use the legacy mode.

It seems like we should be able to hit the cases that we know work out
of the box, and just hold back the default for the others. Like:

  static int use_curl_auto(void)
  {
  #ifndef USE_CURL_FOR_IMAP_SEND
	/* not built; we cannot use it */
	return 0;
  #else
	if (srvc->tunnel) {
  #if LIBCURL_VERSION < ...
		/* no preauth support */
		return 0;
  #else
		return 1;
  #endif /* LIBCURL_VERSION < ... */
	}
	... other checks go here ...
  #endif /* USE_CURL */
  }

  ...
  int use_curl = -1; /* auto */
  ... set use_curl to 0/1 from --curl/--no-curl command line */
  if (use_curl < 0)
      use_curl = use_curl_auto();

I'm not sure what other cases are left. But over time we'd hope that
use_curl_auto() would shrink to just "return 1", at which point
everybody is using it (and we can drop the fallback code).

-Peff
