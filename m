Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3906E1F462
	for <e@80x24.org>; Wed, 31 Jul 2019 00:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfGaA7f (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 20:59:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:56180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726369AbfGaA7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 20:59:35 -0400
Received: (qmail 10007 invoked by uid 109); 31 Jul 2019 00:59:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 00:59:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12352 invoked by uid 111); 31 Jul 2019 01:01:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2019 21:01:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jul 2019 20:59:34 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Message-ID: <20190731005933.GA9610@sigill.intra.peff.net>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
 <20190730194938.GZ4545@pobox.com>
 <20190730200203.GA4882@sigill.intra.peff.net>
 <20190730205624.GR20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730205624.GR20404@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 10:56:24PM +0200, SZEDER Gábor wrote:

> > Ah, of course. Our oid hashing is done by just picking off the first
> > bytes of the sha1, and it doesn't care about endianness (because these
> > are just internal-to-memory hashes).
> 
> Yeah.
> 
> > We _could_ reconcile that like this:
> 
> Do we really want that, though?  It's a hashmap, after all, and the
> order of iteration over various hashmap implementations tends to be
> arbitrary.  So an argument could be made that this test is overly
> specific by expecting a particular order of elements (and perhaps by
> checking the elements' oid as well), and it would be sufficient to
> check that it iterates over all elements, no matter the order (IOW
> sorting 'actual' before the comparison).

I'd agree that this test is being overly specific. I guess what I'm
feeling is a vague notion that it might be better if Git behaves
deterministically regardless of endian-ness. Not because it _should_
matter for this test, but there could literally be a bug on big-endian
platforms that nobody knows about because it's very rare for anybody to
test there.

I admit that's pretty hand-wavy though. And there may actually be a
benefit in finding such a bug, because it means that some part of the
code (or a test) is relying on something it ought not to.

> OTOH, this is not just any hashmap, but an oidmap, and I could imagine
> that there might be use cases where it would be beneficial if the
> iteration order were to match the oid order (but don't know whether we
> actually have such a use case).

I don't think we can promise anything about iteration order. This test
is relying on the order at least being deterministic between runs, but
if we added a new entry and had to grow the table, all bets are off.

So regardless of the endian thing above, it probably does make sense for
any hashmap iteration output to be sorted before comparing. That goes
for t0011, too; it doesn't have this endian thing, but it looks to be
relying on hash order that could change if we swapped out hash
functions.

> > I
> > wonder if it's appreciably less efficient. I'll bet I could nerd-snipe
> > René into doing a bunch of measurements and explorations of the
> > disassembled code. ;)
> 
> Maybe it shows up in an oidmap-specific performance test, but with all
> that's usually going on in Git hashmap performance tends to be
> negligible (e.g. it's rarely visible in flame graphs).

That's my guess, too, but data trumps guesses (you'll note that I'm not
volunteering to _collect_ the data, though, which perhaps gives a sense
of how invested I am in it. ;) ).

-Peff
