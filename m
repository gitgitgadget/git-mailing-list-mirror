Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592AD1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 20:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbcHPUyb (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 16:54:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:56550 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752041AbcHPUya (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 16:54:30 -0400
Received: (qmail 638 invoked by uid 109); 16 Aug 2016 20:54:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 20:54:30 +0000
Received: (qmail 31028 invoked by uid 111); 16 Aug 2016 20:54:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 16:54:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 16:54:27 -0400
Date:	Tue, 16 Aug 2016 16:54:27 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org
Subject: Re: upload-pack/ls-remote: showing non-HEAD symbolic refs?
Message-ID: <20160816205426.dotqythoyn7zztma@sigill.intra.peff.net>
References: <20160816161838.klvjhhoxsftvkfmd@x>
 <20160816163145.mjc726til2daxl3d@sigill.intra.peff.net>
 <20160816173444.rpqlpsz2ognvlufy@x>
 <20160816182852.inyqzplee5m3wzt6@sigill.intra.peff.net>
 <20160816203150.GA16774@cloud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160816203150.GA16774@cloud>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 01:31:50PM -0700, Josh Triplett wrote:

> > You can dig up the discussion on the list under the name "protocol v2",
> > but basically yes, that approach has been considered. It's a little
> > gross just because it leaves other protocols behind http (and it is not
> > necessarily a good idea to push people into http, because it has some
> > fundamental drawbacks over the other protocols because of its
> > half-duplex nature).
> 
> I looked through the "protocol v2" threads, but couldn't find any
> discussions of using HTTP headers.  I found some mentions of using
> additional query parameters on the git-upload-pack request, which would
> break compatibility with existing servers (they won't just ignore the
> extra parameter).

Probably the most interesting recent discussion is the sub-thread of
this patch:

  http://public-inbox.org/git/1460747949-3514-5-git-send-email-dturner@twopensource.com/

which you might have missed because it only messages "v2 protocol" in
the body.

But basically, I think you get the gist of it. We need to pass
information from the client to the server _before_ the initial
capability advertisement. For HTTP, we can do it via specialized headers
or query parameters. For other protocols, we're stuck with some kind of
try-and-fallback hack.

That means those protocols may diverge slightly from HTTP, but at least
they would differ only in the "bootstrap v2" bit (and that would
eventually become irrelevant as everybody moves to v2).

> --client-caps could work for SSH as well, it just requires an extra
> round-trip to check for --client-caps.  Call git-upload-pack
> --supports-client-caps, ignore any output (which with current git will
> consist of a usage message), see if it returns a 0 exit code, if so,
> call git-upload-pack --client-caps='...', and if not just call
> git-upload-pack.  (A new git-upload-pack-2 binary would also work, but
> that seems like overkill.)  I don't see any way around the extra round
> trip here that would preserve backward compatibility with existing SSH
> servers (which may force clients to *only* run exactly the command
> "git-upload-pack" and nothing else).

Yep, that's about it. For ssh, I suspect we could optimistically try:

  git upload-pack --v2; test $? = 129 && git-upload-pack

and then fallback to just "git-upload-pack". That would work without an
extra round-trip on real shell-capable servers, and eventually work on
restricted ones.

That doesn't help git://, though.

There are proposals floating around for basically easing into it with
config. Have a "remote.*.v2" option you can set locally to enable (or
disable) it. Default to "false". When there are enough v2 servers around
to make it worthwhile, flip the default to "auto" which will do the
probing (at some minor expense of handling fallbacks). Optionally we
could record the last response for "auto" and use that going forward.

> Another possibility, which would work for both HTTPS and
> git-protocol-over-TLS, would be to use ALPN.

Do people actually use git-over-TLS? There's no core support AFAIK, so
you'd have to hack it up with a client proxy and git-remote-ext.

For HTTPS, I'd just as soon use HTTP-level features.

-Peff
