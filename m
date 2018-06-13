Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0B01F403
	for <e@80x24.org>; Wed, 13 Jun 2018 21:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935864AbeFMVNF (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 17:13:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:43708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754517AbeFMVNE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 17:13:04 -0400
Received: (qmail 4820 invoked by uid 109); 13 Jun 2018 21:13:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Jun 2018 21:13:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6388 invoked by uid 111); 13 Jun 2018 21:13:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Jun 2018 17:13:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jun 2018 17:13:02 -0400
Date:   Wed, 13 Jun 2018 17:13:02 -0400
From:   Jeff King <peff@peff.net>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] fetch-pack: don't try to fetch peel values with --all
Message-ID: <20180613211302.GB15574@sigill.intra.peff.net>
References: <20180610143231.7131-1-kirr@nexedi.com>
 <20180611042016.GA31642@sigill.intra.peff.net>
 <20180611044710.GB31642@sigill.intra.peff.net>
 <CAPig+cT73d0rYoSbt7oHVG4MYHVvjKidP0ogRwV+9F73jcjZEA@mail.gmail.com>
 <20180611055357.GA16430@sigill.intra.peff.net>
 <20180611094255.GA15563@deco.navytux.spb.ru>
 <20180612094849.GB26123@sigill.intra.peff.net>
 <20180612185413.GA21856@deco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180612185413.GA21856@deco.navytux.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 06:54:17PM +0000, Kirill Smelkov wrote:

> > If an extra connection isn't a problem, you might be better off with
> > "git ls-remote", and then picking through the results for refs of
> > interest, and then "git fetch-pack" to actually get the pack. That's how
> > git-fetch worked when it was a shell script (e.g., see c3a200120d, the
> > last shell version).
> 
> Yes, this is what I ended up doing:
> 
> https://lab.nexedi.com/kirr/git-backup/commit/899103bf
> 
> but for another reason - to avoid repeating for every fetched repository
> slow (in case of my "big" destination backup repository) quickfetch()
> checking in every spawned `git fetch`: git-backup can build index of
> objects we already have ourselves only once at startup, and then in
> fetch, after checking lsremote output, consult that index, and if we see
> we already have everything for an advertised reference - just avoid
> giving it to fetch-pack to process. It turns out for many pulled
> repositories there is usually no references changed at all and this way
> fetch-pack can be skipped completely:
> 
> https://lab.nexedi.com/kirr/git-backup/commit/3efed898

Thanks for sharing that, it's an interesting case. I'd hope that
git-fetch is smart enough not to even bother with quickfetch() if there
are no refs to update. But if we have even one change to fetch, then
yeah, in the general case it makes sense to me that you could do better
by amortizing the scan of local objects across many operations.

-Peff
