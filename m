Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11CC1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 04:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750723AbdDREDJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 00:03:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:35080 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbdDREDH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 00:03:07 -0400
Received: (qmail 9965 invoked by uid 109); 18 Apr 2017 04:03:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 04:03:07 +0000
Received: (qmail 8507 invoked by uid 111); 18 Apr 2017 04:03:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 00:03:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Apr 2017 00:03:05 -0400
Date:   Tue, 18 Apr 2017 00:03:05 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/2] config: handle conditional include when $GIT_DIR is
 not set up
Message-ID: <20170418040305.t4soqhpllhd4f7u7@sigill.intra.peff.net>
References: <20170416045004.2ghhiv7jzgroejgw@sigill.intra.peff.net>
 <20170416104125.15300-1-pclouds@gmail.com>
 <20170416104125.15300-2-pclouds@gmail.com>
 <20170416155131.ppp5iakohiiphzmk@sigill.intra.peff.net>
 <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 05:07:52PM +0700, Duy Nguyen wrote:

> > You can see the second problem with:
> >
> >   # random external
> >   cat >git-foo <<-\EOF
> >   #!/bin/sh
> >   echo foo
> >   EOF
> >   chmod +x git-foo
> >   PATH=$PWD:$PATH
> >
> >   git init
> >   git config pager.foo 'sed s/^/repo:/'
> >   git -c pager.foo='sed s/^/cmdline:/' foo
> >
> > That command should prefer the cmdline config, but it doesn't.
> 
> I actually had problems seeing the problem, for some reason it didn't
> work for me. I guess I made a mistake somewhere.

I just double-checked it, and the above works for me. <shrug>

> > The fix is something like what's below, which is easy on top of your new
> > options struct. I can wrap it up with a config message and test on top
> > of your series.
> 
> ... anyway I read this last sentence too late and spent too much time
> wrapping your changes in a patch (well most of the time was spent on
> writing a new test actually), so I'm  sending it out too. My test uses
> test-config though (I have given up on dealing with pager and tty).

Thanks for doing that. I had planned to do it myself to avoid making
work for you, but what you posted looks good.

I hadn't thought about tty issues. You'd have to run it under
test_terminal (which isn't even available everywhere). So your
test-config version is probably the best bet.

> Off topic. Back to the pager.foo thing (because I had to fight it a
> bit before giving up). I find it a bit unintuitive that "--paginate"
> forces the pager back to less (or $PAGER) when I say "pager.foo =
> my-favorite-pager". Back when pager.foo is a boolean thing, it makes
> sense for --paginate to override the "to page or not to page"
> decision. But then you added a new meaning too pager.foo (what command
> to run). "--paginate" should respect the command pager.foo specifies
> when its value is a command, I think.

I never noticed that before, and I agree that it's nonsense. Using "-p"
should be unnecessary if you have pager.foo defined (because it already
implies "yes, use the pager"). But if you were to do it anyway, I agree
it should not ignore the configured pager. One might use an extra "-p"
hoping that it would override the tty check, but it doesn't. It's too
late to change that now, I think, but I have been tempted to add a
--paginate-me-harder option. It would be handy for tests.

-Peff
