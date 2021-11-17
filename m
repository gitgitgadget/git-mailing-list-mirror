Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD273C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 20:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8120761BE3
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 20:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhKQUFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 15:05:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:33200 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232439AbhKQUEx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 15:04:53 -0500
Received: (qmail 24301 invoked by uid 109); 17 Nov 2021 20:01:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Nov 2021 20:01:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18434 invoked by uid 111); 17 Nov 2021 20:01:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Nov 2021 15:01:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Nov 2021 15:01:50 -0500
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Message-ID: <YZVfrhos+lZas7hk@coredump.intra.peff.net>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-2-sandals@crustytoothpaste.net>
 <YZPOzqU0UQDVA57R@coredump.intra.peff.net>
 <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com>
 <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net>
 <00e001d7db40$985c61a0$c91524e0$@nexbridge.com>
 <YZRUzHVS32W4Flo/@camp.crustytoothpaste.net>
 <CAPUEspiHnTkwbUJ5o+fT2u4Kn+fwNe-3FoqVtNsjTF+Pg6Tryg@mail.gmail.com>
 <YZRxOrv9JFt2oeSU@coredump.intra.peff.net>
 <CAPUEsphh-enSYS66mi7_XaS0n1bmUvGXRcgVp6iqhg94xSHVog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEsphh-enSYS66mi7_XaS0n1bmUvGXRcgVp6iqhg94xSHVog@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 07:36:51PM -0800, Carlo Arenas wrote:

> > > for the little amount of random data we need, it might be wiser to
> > > fallback to something POSIX like lrand48 which is most likely to be
> > > available, but of course your tests that consume lots of random data
> > > will need to change.
> >
> > Unfortunately that won't help. You have to seed lrand48 with something,
> > which usually means pid and/or timestamp. Which are predictable to an
> > attacker, which was the start of the whole conversation. You really need
> > _some_ source of entropy, and only the OS can provide that.
> 
> again, showing my ignorance here; but that "something" doesn't need to
> be guessable externally; ex: git add could use as seed contents from
> the file that is adding, or even better mix it up with the other
> sources as a poor man's /dev/urandom

Those contents are still predictable. So you've made the attacker's job
a little harder (now they have to block tempfiles for, say, each tag
you're going to verify), but haven't changed the fundamental problem.

It definitely would help in _some_ threat models, but I think we should
strive for a solution that can be explained clearly as "nobody can DoS
your tempfiles" without complicated qualifications.

-Peff
