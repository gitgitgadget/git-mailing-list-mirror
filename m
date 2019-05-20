Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D64D1F461
	for <e@80x24.org>; Mon, 20 May 2019 15:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbfETPYg (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 11:24:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:34088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730766AbfETPYg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 11:24:36 -0400
Received: (qmail 26366 invoked by uid 109); 20 May 2019 15:24:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 May 2019 15:24:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5197 invoked by uid 111); 20 May 2019 15:25:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 May 2019 11:25:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2019 11:24:34 -0400
Date:   Mon, 20 May 2019 11:24:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] clone: auto-enable git-credential-store when
 necessary
Message-ID: <20190520152433.GB4583@sigill.intra.peff.net>
References: <20190519050724.GA26179@sigill.intra.peff.net>
 <20190519051604.GC19434@sigill.intra.peff.net>
 <87imu5ut4x.fsf@evledraar.gmail.com>
 <20190520140825.GA31580@sigill.intra.peff.net>
 <87h89pupdr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h89pupdr.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 05:17:20PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > There are more cases beyond that, too. You might have a helper defined
> > which doesn't actually store passwords, but just sometimes tries to
> > provide one. My thinking was that if you're clueful enough to have
> > configured helpers, you can probably deal with the fallout. But you're
> > right that it may still be a regression in the sense that the user may
> > still have to actually _do_ something to get their fetch to work.
> >
> > I guess a more robust version of this is that _after_ the successful
> > clone, we could ask the credential system "hey, do you have the
> > credential for $URL?". And if it can't answer, then we can take action
> > (whether that action is setting up credential-store and seeding it with
> > the password, or just advising the user about the situation).
> >
> > -Peff
> 
> Yeah I don't mean deal with some there-but-broken helper, but this:
> 
>     /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring:
>     not found
> 
> Until then the observable effect of that has been to make the
> credential.helper config a noop, but now it's causing "we have a helper"
> behavior.

Right, I understood. The other case I mean is not one that's broken, but
a helper that's designed to provide a password from a read-only store
(which presumably doesn't have _this_ password, else why would they be
providing it in the URL?).

It is not going to help that the clone will feed the password to such a
helper because it will (correctly, and by design) ignore any "store"
requests.

In other words, I am agreeing with you and indicating that there are
even more cases where a non-empty helper config will mislead us.

I'm going to try to re-work the patch to do this check-at-the-end
technique, and probably try to make the UI for clearing and seeding
passwords a bit more friendly, too.

-Peff
