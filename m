Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 896C31F609
	for <e@80x24.org>; Wed, 19 Jun 2019 19:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfFSTKl (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 15:10:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:44444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726265AbfFSTKj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 15:10:39 -0400
Received: (qmail 11844 invoked by uid 109); 19 Jun 2019 19:07:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 19:07:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8411 invoked by uid 111); 19 Jun 2019 19:11:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 15:11:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 15:10:37 -0400
Date:   Wed, 19 Jun 2019 15:10:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] gc: run more pre-detach operations under lock
Message-ID: <20190619191037.GE28145@sigill.intra.peff.net>
References: <20190619094630.32557-1-pclouds@gmail.com>
 <20190619102601.24913-1-avarab@gmail.com>
 <CACsJy8AqA3TmNP62ko4c5Et39jsADYf9nKQByz28y-YQjNyKag@mail.gmail.com>
 <87k1dh8ne4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1dh8ne4.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 08:01:55PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > You could sort of avoid the problem here too with
> >
> > parallel 'git fetch --no-auto-gc {}' ::: $(git remote)
> > git gc --auto
> >
> > It's definitely simpler, but of course we have to manually add
> > --no-auto-gc in everywhere we need, so not quite as elegant.
> >
> > Actually you could already do that with 'git -c gc.auto=false fetch', I guess.
> 
> The point of the 'parallel' example is to show disconnected git
> commands, think trying to run 'git' in a terminal while your editor
> asynchronously runs a polling 'fetch', or a server with multiple
> concurrent clients running 'gc --auto'.
> 
> That's the question my RFC patch raises. As far as I can tell the
> approach in your patch is only needed because our locking for gc is
> buggy, rather than introduce the caveat that an fetch(N) operation won't
> do "gc" until it's finished (we may have hundreds, thousands of remotes,
> I use that for some more obscure use-cases) shouldn't we just fix the
> locking?

I think there may be room for both approaches. Yours fixes the repeated
message in the more general case, but Duy's suggestion is the most
efficient thing.

I agree that the "thousands of remotes" case means we might want to gc
in the interim. But we probably ought to do that deterministically
rather than hoping that the pattern of lock contention makes sense.

-Peff
