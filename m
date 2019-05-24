Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1001F462
	for <e@80x24.org>; Fri, 24 May 2019 06:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbfEXG10 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 02:27:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:37536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388141AbfEXG10 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 02:27:26 -0400
Received: (qmail 25014 invoked by uid 109); 24 May 2019 06:27:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 May 2019 06:27:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6418 invoked by uid 111); 24 May 2019 06:28:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 May 2019 02:28:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 May 2019 02:27:24 -0400
Date:   Fri, 24 May 2019 02:27:24 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alejandro Sanchez <asanchez1987@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] am: drop tty requirement for --interactive
Message-ID: <20190524062724.GC25694@sigill.intra.peff.net>
References: <20190520120636.GA12634@sigill.intra.peff.net>
 <20190520121113.GC11212@sigill.intra.peff.net>
 <20190520125016.GA13474@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905230840450.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1905230840450.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 08:44:31AM +0200, Johannes Schindelin wrote:

> >   perl test-terminal.perl sh -c '
> > 	for i in 0 1 2; do
> > 		echo $i is $(test -t $i || echo not) a tty
> > 	done
> >   ' </dev/null
> >
> > it _usually_ says "0 is a tty", but racily may say "not a tty". If you
> > put a sleep into the beginning of the shell, then it will basically
> > always lose the race and say "not".
> 
> This is just another nail in the coffin for `test-terminal.perl`, as far
> as I am concerned.

I think it's only broken for stdin, but yeah, it's not great. I think
the fact that test-terminal is not available everywhere (and thus many
people are skipping a bunch of tests) is much more damning. :)

> In the built-in `add -i` patch series, I followed a strategy where I move
> totally away from `test-terminal`, in favor of using some knobs to force
> Git into thinking that we are in a terminal.

I'm in favor of this. The current "add -i" is pretty accepting of
reading from stdin, and I think we can do that in most places. The main
use of test_terminal has been to check color and progress decisions. I'd
be just as happy to see something like this:

  int git_isatty(int fd)
  {
	static int override[3];
	static int initialized;
	if (!initialized) {
		const char *x = getenv("GIT_PRETEND_TTY");
		if (x) {
			for (; *x; x++) {
				int n = *x - '0';
				if (n > 0 && n < ARRAY_SIZE(override)
					override[n] = 1;
			}
		}
		initialized = 1;
	}
	if (fd > 0 && fd < ARRAY_SIZE(override) && override[fd])
		return 1;
	return isatty(fd);
  }

> But at the same time, I *also* remove the limitation (for most cases) of
> "read from /dev/tty", in favor of reading from stdin, and making things
> testable, and more importantly: scriptable.

As far as I know, apart from this git-am fix, the only thing that reads
from the terminal is the credential prompt. That one has to be a bit
picky, because:

  - we need to prompt from processes which have no stdio connected to
    the user (e.g., remote-curl).

  - we need to put the terminal into no-echo mode for passwords (and
    probably should bail if that fails, to be paranoid)

In the case of credentials we already have multiple mechanisms for
scripting the input (credential helpers and askpass). It would be nice
to be able to test the terminal-level code automatically, but I'm just
not sure how that would work.

-Peff
