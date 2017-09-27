Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD34202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 06:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbdI0Go0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:44:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:51692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750854AbdI0GoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:44:25 -0400
Received: (qmail 27142 invoked by uid 109); 27 Sep 2017 06:44:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 06:44:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12062 invoked by uid 111); 27 Sep 2017 06:45:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:45:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:44:23 -0400
Date:   Wed, 27 Sep 2017 02:44:23 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git: add --no-optional-locks option
Message-ID: <20170927064423.twluii6jj57hyk5y@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <7a2d895c-df8c-1305-234f-7f8e2b271ec2@kdbg.org>
 <20170922042539.fs37bauiabfqcjx5@sigill.intra.peff.net>
 <CAGZ79kaUTdFi5LkgR6zKeb+CH8vpfPQRZf6bFqRfYY-YXy_TNA@mail.gmail.com>
 <20170922212525.kxldygbjrmjqu7ci@sigill.intra.peff.net>
 <CAGZ79kYJH-4qb5hiT1C_aCFXLcdiJs5h+Z7Goz4trp52C5s3Lw@mail.gmail.com>
 <20170923033425.6ilykxl5pi7unlj6@sigill.intra.peff.net>
 <CAGZ79kYOeJvQmw-h3GwFpv2w7AKtNWUxf96tUjPKPY1dMuzagA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYOeJvQmw-h3GwFpv2w7AKtNWUxf96tUjPKPY1dMuzagA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 11:51:31AM -0700, Stefan Beller wrote:

> > diff --git a/read-cache.c b/read-cache.c
> > index 65f4fe8375..fc1ba122a3 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -1563,7 +1563,8 @@ static int read_index_extension(struct index_state *istate,
> >
> >  int hold_locked_index(struct lock_file *lk, int lock_flags)
> >  {
> > -       return hold_lock_file_for_update(lk, get_index_file(), lock_flags);
> > +       return hold_lock_file_for_update_timeout(lk, get_index_file(),
> > +                                                lock_flags, 500);
> >  }
> >
> >  int read_index(struct index_state *istate)
> >
> > though I think there are a few sites which manually call
> > hold_lock_file_for_update() on the index that would need similar
> > treatment.
> 
> uh, too bad. The patch above looks really promising, though. :)

There are probably only a handful of other callers, and they'd just need
to swap out s/update/&_timeout/. So it really is pretty trivial.

> > I suspect it would work OK in practice, unless your index is so big that
> > 500ms isn't enough. The user may also see minor stalls when there's lock
> > contention. I'm not sure how annoying that would be.
> 
> There is only one way to find out. Though we don't want to volunteer
> all users into this experiment, I'd presume.

Yes. One of the nice things about the optional-locks approach is that it
only affects callers who specify the option. And the general idea has
gotten a year of testing in Visual Studio, which makes me feel good
about it.

> Regarding larger indexes, I wonder if we can adapt the 500ms
> to the repo size. At first I thought the abbreviation length could be
> a good proxy to determine the maximum waiting time, but now I am
> not so sure any more.

I think madness that way lies.

-Peff
