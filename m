Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76371F462
	for <e@80x24.org>; Thu, 20 Jun 2019 10:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfFTKn1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 06:43:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:45742 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726211AbfFTKn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 06:43:27 -0400
Received: (qmail 18551 invoked by uid 109); 20 Jun 2019 10:43:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 10:43:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14826 invoked by uid 111); 20 Jun 2019 10:44:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 06:44:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 06:43:25 -0400
Date:   Thu, 20 Jun 2019 06:43:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] gc: run more pre-detach operations under lock
Message-ID: <20190620104325.GA15942@sigill.intra.peff.net>
References: <20190619094630.32557-1-pclouds@gmail.com>
 <20190619102601.24913-1-avarab@gmail.com>
 <CACsJy8AqA3TmNP62ko4c5Et39jsADYf9nKQByz28y-YQjNyKag@mail.gmail.com>
 <87k1dh8ne4.fsf@evledraar.gmail.com>
 <20190619191037.GE28145@sigill.intra.peff.net>
 <87imt18a2r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87imt18a2r.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 12:49:32AM +0200, Ævar Arnfjörð Bjarmason wrote:

> We do it deterministically, when gc.auto thresholds et al are exceeded
> we kick one off without waiting for other stuff, if we can get the lock.
> 
> I don't think this desire to just wait a bit until all the fetches are
> complete makes sense as a special-case.
> 
> If, as you noted in <20190619190845.GD28145@sigill.intra.peff.net>, the
> desire is to reduce GC CPU use then you're better off just tweaking the
> limits upwards. Then you get that with everything, like when you run
> "commit" in a for-loop, not just this one special case of "fetch".

If you tweak the limit upwards, then you're more likely to exist in the
non-gc'd state, where reads are penalized. The gc limit is a tradeoff
between paying the price for maintenance work versus paying the price
for having an unmaintained state. So the optimal time is generally right
after you've finished a big chunk of writing, but before you've started
doing a bunch of reading (for continuous operations that are reading and
writing, there's probably some periodic crossover point every N units of
operation).

That said, I doubt it matters more than a few percent either way (if
that). So I'm fine if we want to optimize for simplicity.

-Peff
