Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A14A01F4B6
	for <e@80x24.org>; Wed,  3 Jul 2019 21:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfGCVXS (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 17:23:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:59000 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726678AbfGCVXS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 17:23:18 -0400
Received: (qmail 23713 invoked by uid 109); 3 Jul 2019 21:23:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Jul 2019 21:23:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28083 invoked by uid 111); 3 Jul 2019 21:24:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Jul 2019 17:24:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jul 2019 17:23:16 -0400
Date:   Wed, 3 Jul 2019 17:23:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Janos Farkas <chexum@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] repack: warn if bitmaps are explicitly enabled with
 keep files
Message-ID: <20190703212316.GB32035@sigill.intra.peff.net>
References: <875zow8i85.fsf@evledraar.gmail.com>
 <20190623180226.GA1100@sigill.intra.peff.net>
 <20190623180825.3ospajjgat3clwiu@dcvr>
 <20190623224244.GB1100@sigill.intra.peff.net>
 <20190628070211.hfweqcons6c6gy52@dcvr>
 <87zhm26uq9.fsf@evledraar.gmail.com>
 <20190629191600.nipp2ut37xd3mx56@dcvr>
 <xmqq7e917h9x.fsf@gitster-ct.c.googlers.com>
 <20190703173814.GA29348@sigill.intra.peff.net>
 <xmqqftnn0z1t.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftnn0z1t.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 03, 2019 at 11:10:22AM -0700, Junio C Hamano wrote:

> > Or perhaps we could differentiate our temporary locks from "real" .keep
> > files by looking at the content; I think our locks always say something
> > like "(receive|receive)-pack \d+ on .*", and it wouldn't be too onerous
> > to commit to that, I think (or even adjust it to something even more
> > unambiguous).
> 
> True, but it may be overkill to open and read.

Yeah, that cross my mind as well, but:

  1. We'd only need to open them when we _see_ them. And they're pretty
     rare anyway.

  2. Effort-wise, we're already opening and mmap-ing the .idx files, so
     this is on par.

  3. Most callers don't care about keep-files anyway. We could turn
     packed_git.pack_keep into:

       enum {
         PACK_KEEP_NONE,
         PACK_KEEP_LOCK,
	 PACK_KEEP_USER
       } check_packed_keep(struct packed_git *pack);

     and then most programs wouldn't pay anything.

Just some thoughts. I don't have immediate plans to work on it, but
maybe somebody else is excited about it. :)

-Peff
