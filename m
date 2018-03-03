Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018871F576
	for <e@80x24.org>; Sat,  3 Mar 2018 06:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeCCG4v (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 01:56:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:45434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751721AbeCCG4u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 01:56:50 -0500
Received: (qmail 12516 invoked by uid 109); 3 Mar 2018 06:56:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 06:56:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3814 invoked by uid 111); 3 Mar 2018 06:57:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Mar 2018 01:57:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2018 01:56:49 -0500
Date:   Sat, 3 Mar 2018 01:56:49 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: send verbose test-helper output to fd 4
Message-ID: <20180303065648.GA17312@sigill.intra.peff.net>
References: <20180222064836.GA10719@sigill.intra.peff.net>
 <CAM0VKjmtHEGmDi8x_AC8JoNj7rtcanSJX1n0b-f1CEX04Xn8CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjmtHEGmDi8x_AC8JoNj7rtcanSJX1n0b-f1CEX04Xn8CA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 03:30:29AM +0100, SZEDER Gábor wrote:

> > -       echo >&2 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
> > +       echo >&4 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
> >         return 1
> >  }
> 
> The parts above changing the fds used for error messages in
> 'test_must_fail' and 'test_expect_code' will become unnecessary if we
> take my patch from
> 
>   https://public-inbox.org/git/20180225134015.26964-1-szeder.dev@gmail.com/
> 
> because that patch also ensures that error messages from this function
> will go to fd 4 even if the stderr of the functions is redirected in the
> test.  Though, arguably, your patch makes it more readily visible that
> those error messages go to fd 4, so maybe it's still worth having.

Yeah, I could take it or leave it if we follow that other route.

> >  # not output anything when they fail.
> >  verbose () {
> >         "$@" && return 0
> > -       echo >&2 "command failed: $(git rev-parse --sq-quote "$@")"
> > +       echo >&4 "command failed: $(git rev-parse --sq-quote "$@")"
> >         return 1
> >  }
> 
> I'm not so sure about these changes to 'test_18ngrep' and 'verbose'.  It
> seems that they are the result of a simple s/>&2/>&4/ on
> 'test-lib-functions.sh'?  The problem described in the commit message
> doesn't really applies to them, because their _only_ output to stderr
> are the error messages intended to the user, so no sane test would
> redirect and check their stderr.  (OK, technically the command run by
> 'verbose' could output anything to stderr, but 'verbose' was meant for
> commands failing silently in the first place; that's why my patch linked
> above left 'verbose' unchanged.)

Yes, I agree it's not likely to help anybody. I did it mostly for
consistency. I.e., to say "and we are meaning to send this directly to
the user". It actually might make sense to wrap that concept in a helper
function. Arguably "say" should do this redirection automatically (we do
redirect it elsewhere, but mostly to try to accomplish the same thing).

> Also note that there are a lot of other test helper functions that
> output something primarily intended to the user on failure (e.g.
> 'test_path_is_*' and the like), though those messages go stdout instead
> of stderr.  Perhaps the messages of those functions should go to stderr
> as well (or even fd 4)?

Yeah, I just missed those. I agree they should redirect to fd 4, too.

I'm trying to clear my inbox before traveling, so I probably won't dig
into this further for a while. If you think this is the right direction,
do you want to add more ">&4" redirects to helpers as part of your
series?

-Peff
