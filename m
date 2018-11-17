Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0122F1F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 12:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeKQWn4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 17:43:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:42980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725964AbeKQWn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 17:43:56 -0500
Received: (qmail 29333 invoked by uid 109); 17 Nov 2018 12:27:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 17 Nov 2018 12:27:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4946 invoked by uid 111); 17 Nov 2018 12:26:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 17 Nov 2018 07:26:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2018 07:27:22 -0500
Date:   Sat, 17 Nov 2018 07:27:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: insteadOf and git-request-pull output
Message-ID: <20181117122722.GB4094@sigill.intra.peff.net>
References: <20181115182826.GB25806@pure.paranoia.local>
 <20181116115639.GO890086@genre.crustytoothpaste.net>
 <xmqq7ehci1td.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7ehci1td.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 17, 2018 at 04:46:22PM +0900, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> >> $ git request-pull HEAD^ git://foo.example.com/example | grep example
> >>   ssh://bar.example.com/example
> >> 
> >> I think that if we use the "principle of least surprise," insteadOf
> >> rules shouldn't be applied for git-request-pull URLs.
> >
> > I'd like to point out a different use that may change your view.  I have
> > an insteadOf alias, gh:, that points to GitHub.  Performing the rewrite
> > is definitely the right thing to do, since other users may not have my
> > alias available.
> >
> > I agree that in your case, a rewrite seems less appropriate, but I think
> > we should only skip the rewrite if the value already matches a valid
> > URL.
> 
> It would be tricky to define what a valid URL is, though.  Do we
> need some way to say "this is a private URL that should not be
> given preference when composing a request-pull message"?  E.g.
> 
>     [url "git://git.dev/"]
>             insteadOf = https://git.dev/
> 
>     [url "https://github.com/"]
>             insteadOf = gh:
> 	    private
> 
> The former does not mark https://git.dev/ a private one, so a
> "request-pull https://git.dev/$thing" would show the original
> "https://git.dev/$thing" without rewriting.  The latter marks gh: a
> private one so "request-pull gh:$thing" would be rewritten before
> exposed to the public as "https://github.com/$thing"
> 
> Or something like that?

One funny thing about this is that the "private" config key is
url.https://github.com.private. But that's the public URL!

It makes sense if you think of it as "this rewrite is private". And that
would probably serve for most people's needs, though it gets funny when
you have multiple conversions:

  [url "https://github.com/"]
  insteadOf = gh:
  insteadOf = git://github.com

you may want to share that you are rewriting one of those, but not the
other.

I suspect it would be less confusing if the rewrite were inverted, like:

  [url "gh:"]
  rewriteTo = https://github.com
  rewritePrivate

  [url "git://github.com"]
  rewriteTo = https://github.com

where the mapping of sections to rewrite rules must be one-to-one, not
one-to-many (and you can see that the flip side is that we have to
repeat ourselves).

I hate to introduce two ways of doing the same thing, but maybe it is
simple enough to explain that url.X.insteadOf=Y is identical to
url.Y.rewriteTo=X. I do think people have gotten confused by the
ordering of insteadOf over the years, so this would let them specify it
in whichever way makes the most sense to them.

-Peff
