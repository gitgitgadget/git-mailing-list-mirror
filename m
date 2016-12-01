Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9BDC1FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 03:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754416AbcLAD4t (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 22:56:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:49511 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbcLAD4s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 22:56:48 -0500
Received: (qmail 13553 invoked by uid 109); 1 Dec 2016 03:56:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 03:56:48 +0000
Received: (qmail 28815 invoked by uid 111); 1 Dec 2016 03:57:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 22:57:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 22:56:45 -0500
Date:   Wed, 30 Nov 2016 22:56:45 -0500
From:   Jeff King <peff@peff.net>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Define XDL_FAST_HASH when building *for* (not *on*)
 x86_64
Message-ID: <20161201035645.mv7c7lr6rnsxokll@sigill.intra.peff.net>
References: <alpine.DEB.2.10.1611302202100.20145@buzzword-bingo.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.10.1611302202100.20145@buzzword-bingo.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 10:04:07PM -0500, Anders Kaseorg wrote:

> Previously, XDL_FAST_HASH was defined when ‘uname -m’ returns x86_64,
> even if we are cross-compiling for a different architecture.  Check
> the __x86_64__ compiler macro instead.
> 
> In addition to fixing the cross compilation bug, this is needed to
> pass the Debian build reproducibility test
> (https://tests.reproducible-builds.org/debian/index_variations.html).

I don't think this is a good approach to fix it. Right now XDL_FAST_HASH
is a Makefile knob that can be turned by the user, and can be used
either to explicitly enable or explicitly disable the feature.

With your patch, building with "make XDL_FAST_HASH=Yes" will still
explicitly enable it, but "make XDL_FAST_HASH=" would no longer disable
it (because even if unset, the compiler would turn it on when it sees
__x86_64__).

And being able to turn it off is important; more on that in a second.

So I think if we wanted to auto-detect based on __x86_64__, we'd
probably need to be able to set it to "auto" or something, and then

  #if defined(XDL_FAST_HASH_AUTO) && __x86_64__
  #define XDL_FAST_HASH
  #endif

or something.

However, I think this might be the tip of the iceberg. There are lots of
Makefile knobs whose defaults are tweaked based on uname output. This
one caught you because you are cross-compiling across architectures, but
in theory you could cross-compile for FreeBSD from Linux, or whatever.

So I suspect a better strategy in general is to just override the
uname_* variables when cross-compiling.


All that being said, I actually think an easier fix for this particular
case might be to drop XDL_FAST_HASH entirely. It computes the hashes
slightly faster, but its collision characteristics are much worse. About
2 years ago I ran across a pathological diff that ran over 100x slower
with XDL_FAST_HASH:

  http://public-inbox.org/git/20141222041944.GA441@peff.net/

The discussion veered into whether we should have a randomized hash
secured against DoS attacks. I played around with some alternatives, but
never found anything quite as fast for the "normal" case. And having
disabled XDL_FAST_HASH on GitHub's servers, it wasn't a big priority for
me.

I'd be happy if somebody wanted to investigate other hash functions
further. But barring that, I think we should drop XDL_FAST_HASH (or at
the very least stop turning it on by default) in the meantime. It's just
not a good tradeoff.

-Peff
