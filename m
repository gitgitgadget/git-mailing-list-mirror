Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84CCC1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 20:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeBTU4G (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 15:56:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:58624 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751270AbeBTU4F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 15:56:05 -0500
Received: (qmail 8647 invoked by uid 109); 20 Feb 2018 20:56:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Feb 2018 20:56:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16935 invoked by uid 111); 20 Feb 2018 20:56:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Feb 2018 15:56:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Feb 2018 15:56:03 -0500
Date:   Tue, 20 Feb 2018 15:56:03 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Git Users <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Is there any way to "interrupt" a rebase?
Message-ID: <20180220205603.GA13721@sigill.intra.peff.net>
References: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com>
 <20180219223653.GE6619@genre.crustytoothpaste.net>
 <CAE1pOi070p9VNPnLS3jSXp7TrbR2fhOc7sx+58exAp92k4D0dw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802201147300.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <nycvar.QRO.7.76.6.1802201240010.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1802201240010.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 12:44:51PM +0100, Johannes Schindelin wrote:

> > It might be even possible to design a new subcommand for the interactive
> > rebase to facilitate a variation of this strategy (possibly even making
> > use of the fact that the interactive rebase accumulates mappings between
> > the original commits and the rewritten ones in
> > $GIT_DIR/rebase-merge/rewritten-list, intended for use in the post-rewrite
> > hook).
> 
> This feature might look somewhat like this:
> 
> 	git rebase --replay-latest-commits 3
> 
> and it would not even have to look at the `rewritten-list`. All it would
> do is to put back the latest `pick` from the `done` file (in case of merge
> conflicts) into the `git-rebase-todo` file, then insert `pick lines for
> HEAD~3.. at the beginning of that todo file, and then `git reset --hard
> HEAD~3`.

Keep in mind that the "pick" lines could be "edit", "squash", etc.

I think the general form of your original email's proposal is something
like: What if we had a "git rebase --rewind" that could "undo" the prior
command? So if I had a todo file like:

  pick 1
  edit 2
  x make test
  edit 3
  x make test
  pick 4

and I failed at the second "make test", then I'd have:

  pick 1
  edit 2
  x make test
  edit 3
  x make test

in the "done" file, with the final pick remaining in "todo". Could I
then ask to "rewind" my state by moving "x make test" back to the
"todo". And two rewinds would get me back to applying patch 3, which I
could then fix up and re-run my test. Or four rewinds would get me back
to patch 2, which maybe is where I made the initial mistake.

That's a bit more primitive than what you're proposing in this
follow-on, because you'd be doing the replay yourself (unless we remap
the commits). But it's very easy to reason about and implement.

Anyway, just musing at this point. I haven't thought it through, but I
like the direction of everything you're saying. ;)

-Peff
