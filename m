Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103A41F461
	for <e@80x24.org>; Mon, 24 Jun 2019 02:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfFXCqm (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 22:46:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:48186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726510AbfFXCqm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 22:46:42 -0400
Received: (qmail 5091 invoked by uid 109); 23 Jun 2019 22:46:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 23 Jun 2019 22:46:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6208 invoked by uid 111); 23 Jun 2019 22:47:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 23 Jun 2019 18:47:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Jun 2019 18:46:39 -0400
Date:   Sun, 23 Jun 2019 18:46:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 15/17] khash: rename oid helper functions
Message-ID: <20190623224639.GC1100@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
 <20190620074141.GO3713@sigill.intra.peff.net>
 <xmqqwohgnocu.fsf@gitster-ct.c.googlers.com>
 <20190620182743.GC18704@sigill.intra.peff.net>
 <0e4ca2e6-5c75-20c3-def5-b2d3e31f9f08@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e4ca2e6-5c75-20c3-def5-b2d3e31f9f08@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 23, 2019 at 06:00:50PM +0200, René Scharfe wrote:

> > I do think if it took the more usual pass-by-const-pointer we'd probably
> > still end up with the exact same code from an optimizing compiler, since
> > all of the references and dereferences would cancel out once it was
> > inlined.
> 
> I suspect it depends on the compiler and the exact details.  Here's a
> simple experiment: https://godbolt.org/z/kuv4NE.  It has a comparison
> function for call by value and one for call by reference as well as a
> wrapper for each with the opposite interface.
> 
> An enlightened compiler would emit the same code for functions with the
> same interface, but none of the current ones do in all cases.  Clang
> and MSVC do emit the same code for the two call by value functions, so
> there's hope.  And moving to call by reference might make matters worse.
> GCC adds some 128-bit moves to both wrappers for some reason.

Hmm. I'm unsure whether your simplified setup is really showing
something interesting or whether we'd need to have true "static inline"
functions that are actually _used_ in a hash table to see if there are
any significant differences.

But...

> Perhaps it doesn't matter much anyway e.g. due to caching, especially
> for the branch-free variants.  A definite answer would require
> measurements.  Your cleanup would make the necessary surgery on khash.h
> a bit easier by reducing the number of functions and definitions.

Yeah, my gut feeling is it probably doesn't matter much to the overall
operation even if the inner code is slightly different (though I'm happy
to be overridden by real data). And it's definitely something we can
punt on for later (or never if nobody feels like dealing with it).

-Peff
