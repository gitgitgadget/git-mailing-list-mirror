Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9020BC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 21:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AFFD20791
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 21:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405781AbgFYVPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:15:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:43462 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404016AbgFYVPY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 17:15:24 -0400
Received: (qmail 32460 invoked by uid 109); 25 Jun 2020 21:15:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Jun 2020 21:15:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20833 invoked by uid 111); 25 Jun 2020 21:15:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Jun 2020 17:15:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Jun 2020 17:15:22 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/10] fast-export: store anonymized oids as hex strings
Message-ID: <20200625211522.GA4030664@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
 <20200623152451.GC1435482@coredump.intra.peff.net>
 <20200624114313.GJ2898@szeder.dev>
 <20200624155420.GC2088459@coredump.intra.peff.net>
 <20200625154948.GA3968780@coredump.intra.peff.net>
 <20200625204532.GK2898@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625204532.GK2898@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 25, 2020 at 10:45:32PM +0200, SZEDER Gábor wrote:

> > So this really seems like a pointless false positive from the compiler,
> > and it's a rather old compiler (the warning no longer triggers in gcc 6
> > and up). Is it worth caring about? Ubuntu Trusty is out of standard
> > support but not fully EOL'd until 2022. Debian jessie has gcc 4.9
> > which triggers the warning, but will hit EOL in 5 days. If it were an
> > actual breakage I'd be more concerned, but keeping such an old compiler
> > -Werror clean doesn't seem that important.
> > 
> > I'd note also that none of the Actions CI jobs run with this compiler
> > version. If we _do_ want to care about it, it might be worth covering it
> > there.
> 
> C99 style 'for' loop initial declarations are still frowned upon in
> Git's codebase, and as far as we know it GCC 4.8 is the the most
> recent compiler that can reasonably detect it; see fb9d7431cf
> (travis-ci: build with GCC 4.8 as well, 2019-07-18).

TBH, that does not seem like that compelling a reason to me to keep it
around. If no compiler is complaining of C99 for-loop declarations, then
maybe we should consider loosening our style. Or are we trying to be
kind of some unknown set of platform-specific compilers that we can't
feasibly hit in our CI?

I also note that fb9d7431cf mentions that -std=c90 doesn't work, because
there are other spots where we violate the standard (looks like "inline"
is a big one). But gcc with -std=gnu89 seems to compile just fine for
me, and does notice for-loop declarations. That's obviously totally
unportable, but it would be sufficient for a CI test.

-Peff
