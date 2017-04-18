Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 446541FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 17:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753817AbdDRRTf (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 13:19:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:35434 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752784AbdDRRTd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 13:19:33 -0400
Received: (qmail 27995 invoked by uid 109); 18 Apr 2017 17:19:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 17:19:33 +0000
Received: (qmail 14187 invoked by uid 111); 18 Apr 2017 17:19:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 13:19:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Apr 2017 13:19:31 -0400
Date:   Tue, 18 Apr 2017 13:19:31 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "mfick@codeaurora.org" <mfick@codeaurora.org>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: [PATCH] repack: respect gc.pid lock
Message-ID: <20170418171930.zad5wrbu5rvdsmg5@sigill.intra.peff.net>
References: <20170413202712.22192-1-dturner@twosigma.com>
 <20170414193341.itr3ybiiu2brt63b@sigill.intra.peff.net>
 <c6dd37238f154ccea56dda9b43f3277a@exmbdft7.ad.twosigma.com>
 <20170418034157.oi6hkg5obnca5zsa@sigill.intra.peff.net>
 <2400e9cbfaff4838a8f3b23c4c2c5a22@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2400e9cbfaff4838a8f3b23c4c2c5a22@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 05:16:52PM +0000, David Turner wrote:

> > -----Original Message-----
> > From: Jeff King [mailto:peff@peff.net]
> > Sent: Monday, April 17, 2017 11:42 PM
> > To: David Turner <David.Turner@twosigma.com>
> > Cc: git@vger.kernel.org; christian.couder@gmail.com; mfick@codeaurora.org;
> > jacob.keller@gmail.com
> > Subject: Re: [PATCH] repack: respect gc.pid lock
> > 
> > On Mon, Apr 17, 2017 at 11:29:18PM +0000, David Turner wrote:
> > 
> > > We saw this failure in the logs multiple  times (with three different
> > > shas, while a gc was running):
> > > April 12, 2017 06:45 -> ERROR -> 'git -c repack.writeBitmaps=true repack -A -d
> > --pack-kept-objects' in [repo] failed:
> > > fatal: packfile ./objects/pack/pack-[sha].pack cannot be accessed
> > > Possibly some other repack was also running at the time as well.
> > >
> > > My colleague also saw it while manually doing gc (again while repacks
> > > were likely to be running):
> > 
> > This is sort of a side question, but...why are you running other repacks alongside
> > git-gc? It seems like you ought to be doing one or the other.
> 
> But actually, it would be kind of nice if git would help protect us from doing this?

A lock can catch the racy cases where both run at the same time. But I
think that even:

  git -c repack.writeBitmaps=true repack -Ad
  [...wait...]
  git gc

is questionable, because that gc will erase your bitmaps. How does
git-gc know that it's doing a bad thing by repacking without bitmaps,
and that you didn't simply change your configuration or want to get rid
of them?

-Peff
