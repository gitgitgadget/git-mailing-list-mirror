Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80A21F731
	for <e@80x24.org>; Wed, 31 Jul 2019 21:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfGaVW7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 17:22:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:57574 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726626AbfGaVW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 17:22:59 -0400
Received: (qmail 20836 invoked by uid 109); 31 Jul 2019 21:22:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 21:22:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22079 invoked by uid 111); 31 Jul 2019 21:24:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 17:24:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 17:22:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: non-cryptographic hash algorithms in git
Message-ID: <20190731212258.GB1207@sigill.intra.peff.net>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
 <20190730194938.GZ4545@pobox.com>
 <20190730200203.GA4882@sigill.intra.peff.net>
 <20190730205624.GR20404@szeder.dev>
 <20190731005933.GA9610@sigill.intra.peff.net>
 <20190731012336.GA13880@sigill.intra.peff.net>
 <20190731015917.GB4545@pobox.com>
 <20190731032735.GA14684@sigill.intra.peff.net>
 <20190731035344.GA26019@sigill.intra.peff.net>
 <xmqq5zniqg36.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zniqg36.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[breaking the thread since we're way off the original topic, and this
 subject might get more interesting attention]

On Wed, Jul 31, 2019 at 10:17:01AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And here it is for reference with the matching change in test-oidmap,
> > and the adjustments necessary for the test scripts (from master, not
> > from my earlier patch). I think I prefer the simpler "just sort it all"
> > version I posted with the commit message.
> 
> Yeah, let's go with that version.
> 
> I am wondering if we should follow suit to certain language's hash
> implementation to make sure the iteration order is unpredictable to
> catch bad scripts ;-)  Perhaps that is not worth it, either.

That would be a nice side effect, but the real benefit is that it makes
hash-collision denial-of-service attacks harder. I experimented with
this some when I looked at swapping out the xdiff hash algorithm[1] for
murmur, siphash, or similar, but I could never get the performance quite
on par with what we have now.

I haven't pursued randomization that much because git's diff engine is
a ready-made DoS machine in the first place. If you're diffing untrusted
input, you have to be ready to cut it off after using too much CPU and
say "nope, this one is too big". That may be less true for our general
purpose hashmap, though.

-Peff

[1] I didn't dig up the emails, but this was several years ago, when we
    realized that XDL_FAST_HASH didn't actually work well. I recently
    found out about xxhash:

      https://cyan4973.github.io/xxHash/

    which looks promising. But I haven't gotten around to plugging it in
    and timing the result. Anybody else is welcome to beat me to it. :)

    IIRC, one really tricky thing about our diff code is that it finds
    the newline for each line while it's hashing. That makes it hard to
    plug in an existing hash implementation without going over each line
    twice, and many of them perform poorly if you hand them a byte at a
    time.
