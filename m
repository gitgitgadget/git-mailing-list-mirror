Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18B01F4B6
	for <e@80x24.org>; Sun, 23 Jun 2019 18:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFWSC3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 14:02:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:47976 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726417AbfFWSC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 14:02:29 -0400
Received: (qmail 4070 invoked by uid 109); 23 Jun 2019 18:02:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 23 Jun 2019 18:02:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5344 invoked by uid 111); 23 Jun 2019 18:03:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 23 Jun 2019 14:03:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Jun 2019 14:02:27 -0400
Date:   Sun, 23 Jun 2019 14:02:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Janos Farkas <chexum@gmail.com>, git@vger.kernel.org,
        Eric Wong <e@80x24.org>
Subject: Re: 2.22.0 repack -a duplicating pack contents
Message-ID: <20190623180226.GA1100@sigill.intra.peff.net>
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
 <875zow8i85.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875zow8i85.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 23, 2019 at 04:54:50PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I haven't looked at this for more than a couple of minutes (and don't
> have more time now), but this is almost certainly due to 36eba0323d
> ("repack: enable bitmaps by default on bare repos", 2019-03-14). Can you
> confirm when you re-run with repack.writeBitmaps=false in the config?
> 
> I.e. something in the "yes I want bitmaps" code implies "*.keep"
> semantics changing from "keep" to "replace", which is obvious in
> retrospect, since we can only have one *.bitmap per-repo.

Yeah, the .keep behavior with bitmaps is intended, though it means a
funny implication for the bitmap-by-default strategy.

Basically, you never want to have .keep files if you have bitmaps turned
on, and so the default for "respect .keeps" is based on whether bitmaps
are in use. See ee34a2bead (repack: add `repack.packKeptObjects` config
var, 2014-03-03).

I'm not sure of the right solution. For maximal backwards-compatibility,
the default for bitmaps could become "if not bare and if there are no
.keep files". But that would mean bitmaps sometimes not getting
generated because of the problems that ee34a2bead was trying to solve.

That's probably OK, though; you can always flip the bitmap config to
"true" yourself if you _must_ have bitmaps.

-Peff
