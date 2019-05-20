Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A451F461
	for <e@80x24.org>; Mon, 20 May 2019 14:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbfETOI2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 10:08:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:33988 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731111AbfETOI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 10:08:28 -0400
Received: (qmail 25810 invoked by uid 109); 20 May 2019 14:08:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 May 2019 14:08:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4640 invoked by uid 111); 20 May 2019 14:09:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 May 2019 10:09:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2019 10:08:25 -0400
Date:   Mon, 20 May 2019 10:08:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] clone: auto-enable git-credential-store when
 necessary
Message-ID: <20190520140825.GA31580@sigill.intra.peff.net>
References: <20190519050724.GA26179@sigill.intra.peff.net>
 <20190519051604.GC19434@sigill.intra.peff.net>
 <87imu5ut4x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87imu5ut4x.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 03:56:14PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > -test_expect_failure 'fetch of password-URL clone uses stored auth' '
> > +test_expect_success 'fetch of password-URL clone uses stored auth' '
> >  	set_askpass wrong &&
> >  	git -C clone-auth-none fetch &&
> >  	expect_askpass none
> 
> I've only looked at this very briefly, there's a regression here where
> you're assuming that having a configured credential helper means it
> works.
> 
> I.e. I have a ~/.gitconfig where I point to some-gnome-thing-or-other
> what doesn't exist on my VPS in my ~/.gitconfig, cloning just warns
> about it being missing, but will store the password in the repo.
> 
> With this you detect that I have the helper, don't store it, but then my
> helper doesn't work, whereas this worked before.

There are more cases beyond that, too. You might have a helper defined
which doesn't actually store passwords, but just sometimes tries to
provide one. My thinking was that if you're clueful enough to have
configured helpers, you can probably deal with the fallout. But you're
right that it may still be a regression in the sense that the user may
still have to actually _do_ something to get their fetch to work.

I guess a more robust version of this is that _after_ the successful
clone, we could ask the credential system "hey, do you have the
credential for $URL?". And if it can't answer, then we can take action
(whether that action is setting up credential-store and seeding it with
the password, or just advising the user about the situation).

-Peff
