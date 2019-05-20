Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E4D71F461
	for <e@80x24.org>; Mon, 20 May 2019 12:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbfETMuT (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 08:50:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:33884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730404AbfETMuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 08:50:19 -0400
Received: (qmail 24482 invoked by uid 109); 20 May 2019 12:50:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 May 2019 12:50:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3851 invoked by uid 111); 20 May 2019 12:50:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 May 2019 08:50:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2019 08:50:17 -0400
Date:   Mon, 20 May 2019 08:50:17 -0400
From:   Jeff King <peff@peff.net>
To:     Alejandro Sanchez <asanchez1987@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] am: drop tty requirement for --interactive
Message-ID: <20190520125016.GA13474@sigill.intra.peff.net>
References: <20190520120636.GA12634@sigill.intra.peff.net>
 <20190520121113.GC11212@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190520121113.GC11212@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 08:11:13AM -0400, Jeff King wrote:

> We have required that the stdin of "am --interactive" be a tty since
> a1451104ac (git-am: interactive should fail gracefully., 2005-10-12).
> However, this isn't strictly necessary, and makes the tool harder to
> test (and is unlike all of our other --interactive commands).

I think this is worth doing for simplicity and consistency. But as you
might guess, my ulterior motive was making it easier to add tests.

In theory we _should_ be able to use test_terminal for this, but it
seems to be racy, because it will quickly read all input and close the
descriptor (to give the reader EOF). But after that close, isatty() will
no longer report it correctly. E.g., if I run this:

  perl test-terminal.perl sh -c '
	for i in 0 1 2; do
		echo $i is $(test -t $i || echo not) a tty
	done
  ' </dev/null

it _usually_ says "0 is a tty", but racily may say "not a tty". If you
put a sleep into the beginning of the shell, then it will basically
always lose the race and say "not".

It might be possible to overcome this by making test-terminal more
clever (i.e., is there a way for us to send an "EOF" over the pty
without actually _closing_ it? That would behave like a real terminal,
where you can hit ^D to generate an EOF but then type more).

But barring that, this works by just avoiding it entirely. :)

Curiously, my script above also reports consistently that stdout is not
a tty, but that stderr is. I'm not sure why this is, but it no tests
seem to care either way.

-Peff
