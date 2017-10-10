Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6CC92036B
	for <e@80x24.org>; Tue, 10 Oct 2017 14:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932250AbdJJOKX (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 10:10:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:48396 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932229AbdJJOKV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 10:10:21 -0400
Received: (qmail 13571 invoked by uid 109); 10 Oct 2017 14:10:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 14:10:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26844 invoked by uid 111); 10 Oct 2017 14:10:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 10:10:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Oct 2017 10:10:19 -0400
Date:   Tue, 10 Oct 2017 10:10:19 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [RFC] column: show auto columns when pager is active
Message-ID: <20171010141019.3vfowj4fvxdvvl3c@sigill.intra.peff.net>
References: <20171009214543.12986-1-me@ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171009214543.12986-1-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2017 at 11:45:43PM +0200, Kevin Daudt wrote:

> +test_expect_success TTY '20 columns, mode auto, pager' '
> +	cat >expected <<\EOF &&
> +one    seven
> +two    eight
> +three  nine
> +four   ten
> +five   eleven
> +six
> +EOF
> +	test_terminal env PAGER="cat|cat" git column --mode=auto <lista >actual &&
> +	test_cmp expected actual
> +'

I don't think "git column" will run the pager by default, will it?
You'd need "git -p" here.

That said, I'm still puzzled why it would return zero output. Strace
shows that the read from stdin is getting no input. I suspect this may
have to do with how we redirect stdin in test-terminal.perl.

See 18d8c26930 (test_terminal: redirect child process' stdin to a pty,
2015-08-04), which claims there's some raciness with closing the
descriptor.

-Peff
