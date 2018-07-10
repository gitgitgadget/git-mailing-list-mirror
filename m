Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C0B1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 02:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933199AbeGJCPL (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 22:15:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:53056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932620AbeGJCPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 22:15:09 -0400
Received: (qmail 16982 invoked by uid 109); 10 Jul 2018 02:15:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 02:15:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19016 invoked by uid 111); 10 Jul 2018 02:15:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 09 Jul 2018 22:15:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jul 2018 22:15:05 -0400
Date:   Mon, 9 Jul 2018 22:15:05 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] sequencer: don't say BUG on bogus input
Message-ID: <20180710021505.GA10248@sigill.intra.peff.net>
References: <20180709194636.GB9852@sigill.intra.peff.net>
 <20180709194912.GB7980@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1807092222300.75@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1807092222300.75@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 09, 2018 at 10:24:25PM +0200, Johannes Schindelin wrote:

> > diff --git a/sequencer.c b/sequencer.c
> > index f692b2ef44..234666b980 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -3637,7 +3637,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
> >  			return error(_("revision walk setup failed"));
> >  		cmit = get_revision(opts->revs);
> >  		if (!cmit || get_revision(opts->revs))
> > -			return error("BUG: expected exactly one commit from walk");
> > +			return error(_("empty commit set passed"));
> 
> Should this not rather be
> 
> -		if (!cmit || get_revision(opts->revs))
> -			return error("BUG: expected exactly one commit from walk");
> +		if (!cmit)
> +			return error(_("empty commit set passed"));
> +		if (get_revision(opts->revs))
> +			return error(_("unexpected extra commit from walk"));

Yeah, you're right. I'm not sure how a single rev with no-walk would
ever turn up more than one commit, though. So I think we should probably
go with:

  if (!cmit)
	return error(_("empty commit set passed"));
  if (get_revision(opts->revs))
	BUG("unexpected extra commit from walk");

And then if we ever see that case, we can decide from there what the
right action is (though _probably_ it's just to emit an error like you
have above, it might be a sign that our single-pick logic is wrong).

I'll re-roll in that direction, and discuss further in the commit
message.

-Peff
