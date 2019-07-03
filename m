Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152D71F4B6
	for <e@80x24.org>; Wed,  3 Jul 2019 17:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfGCRiR (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 13:38:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:58648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725933AbfGCRiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 13:38:16 -0400
Received: (qmail 19776 invoked by uid 109); 3 Jul 2019 17:38:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Jul 2019 17:38:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26093 invoked by uid 111); 3 Jul 2019 17:39:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Jul 2019 13:39:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jul 2019 13:38:14 -0400
Date:   Wed, 3 Jul 2019 13:38:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Janos Farkas <chexum@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] repack: warn if bitmaps are explicitly enabled with
 keep files
Message-ID: <20190703173814.GA29348@sigill.intra.peff.net>
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
 <875zow8i85.fsf@evledraar.gmail.com>
 <20190623180226.GA1100@sigill.intra.peff.net>
 <20190623180825.3ospajjgat3clwiu@dcvr>
 <20190623224244.GB1100@sigill.intra.peff.net>
 <20190628070211.hfweqcons6c6gy52@dcvr>
 <87zhm26uq9.fsf@evledraar.gmail.com>
 <20190629191600.nipp2ut37xd3mx56@dcvr>
 <xmqq7e917h9x.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e917h9x.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 01, 2019 at 11:15:38AM -0700, Junio C Hamano wrote:

> >> Maybe that's tricky with the gc.log functionality, but I think we should
> >> at least document this before the next guy shows up with "sometimes my
> >> .bitmap files aren't generated...".
> >
> > I'm not sure if the warning should be present by default;
> > because we'll silently stop using bitmaps, now.  But warning
> > if '-b' is specified seems right:
> 
> Hmph...  write_bitmaps can come either from the command line or from
> the configuration.  When repack.writebitmaps configuration is set,
> and some .keep files exist, the user probably is not even aware of
> doing something that is unsupported.

I think one tricky thing here is that we do not know if the .keep files
are meant to be there, or if they are simply transient locks.

The whole point of the current behavior is that we should be ignoring
the transient locks, and if you are explicitly using bitmaps you
understand the tradeoff you are making.

I think the important case to cover is the one where the user didn't
explicitly ask for them, and the initial patch (to disable them when
there's a .keep around) covers that.


A much more robust solution would be to stop conflating user-provided
permanent .keep files with temporary locks. I think that was a mistaken
design added many years ago. We probably could introduce a different
filename for the temporary locks (though I am not entirely convinced
they are necessary in the first place, as gc expiration-times would
generally save a racily-written packfile anyway).

Or perhaps we could differentiate our temporary locks from "real" .keep
files by looking at the content; I think our locks always say something
like "(receive|receive)-pack \d+ on .*", and it wouldn't be too onerous
to commit to that, I think (or even adjust it to something even more
unambiguous).

It does muddy the meaning of packed_git.pack_keep a bit.  Some callers
would want to consider it kept in either case (i.e., for purposes of
pruning, we delete neither) and some would want it kept only for
non-locks (for packing, duplicating the objects is OK). So I think we'd
end up with two bits there, and callers would have to use one or the
other as appropriate.

-Peff
