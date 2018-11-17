Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8771D1F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 06:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbeKQQzV (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 11:55:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:42834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725791AbeKQQzV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 11:55:21 -0500
Received: (qmail 15127 invoked by uid 109); 17 Nov 2018 06:39:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 17 Nov 2018 06:39:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3540 invoked by uid 111); 17 Nov 2018 06:39:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 17 Nov 2018 01:39:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2018 01:39:41 -0500
Date:   Sat, 17 Nov 2018 01:39:41 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     mhagger@alum.mit.edu, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, dnj@google.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        prohaska@zib.de, john@keeping.me.uk, stanhu@gmail.com,
        richardc@unixbeard.net, Joey Hess <id@joeyh.name>
Subject: Re: [RFC/PATCH 0/5] stop installing old libexec aliases like
 "git-init"
Message-ID: <20181117063940.GA31057@sigill.intra.peff.net>
References: <87efkkdwcv.fsf@evledraar.gmail.com>
 <20181102223743.4331-1-avarab@gmail.com>
 <87k1ld1f51.fsf@evledraar.gmail.com>
 <CAMy9T_EVh5Xa7wZFRSM+uGAKV7WSPRALRRaZhPaj_bg9v7Ohfg@mail.gmail.com>
 <87in0w25gc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87in0w25gc.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 08:22:11PM +0100, Ævar Arnfjörð Bjarmason wrote:

> So maybe we should just document this interface better. It seems one
> implicit dependency is that we expect a manpage for the tool to exist
> for --help.

Yeah, I think this really the only problematic assumption. The rest of
"-c", "--git-dir", etc, are just manipulating the environment, and that
gets passed through to sub-invocations of Git (so if I have a script
which calls git-config, it will pick up the "-c" config).

It would be nice if there was a way to ask "is there a manpage?", and
fallback to running "git-cmd --help". But:

  1. I don't think there is a portable way to query that via man. And
     anyway, depending platform and config, it may be opening a browser
     to show HTML documentation (or I think even texinfo?).

  2. We can just ask whether "man git-sizer" (or whatever help display
     command) returned a non-zero exit code, and fall back to "git-sizer
     --help". But there's an infinite-loop possibility here: running
     "git-sizer --help" does what we want. But if "man git-log" failed,
     we'd run "git-log --help", which in turn runs "git help log", which
     runs "man git-log", and so on.

     You can break that loop with an environment variable for "I already
     tried to show the manpage", which would I guess convert "--help" to
     "-h".

So it's maybe do-able, but not quite as trivial as one might hope.

> But I don't remember the details, and can't reproduce it now with:
> 
>     $ cat ~/bin/git-sigint 
>     #!/usr/bin/env perl
>     $SIG{INT} = sub { warn localtime . " " . $$ };
>     sleep 1 while 1;
>     $ git sigint # or git-sigint
>     [... behaves the same either way ...]
> 
> So maybe it was something else, or I'm misremembering...

I think that generally works because hitting ^C is going to send SIGINT
to the whole process group. A more interesting case is:

  git sigint &
  kill -INT $!

There $! is a parent "git" process that is just waiting on git-sigint to
die. But that works, too, because the parent relays common signals due
to 10c6cddd92 (dashed externals: kill children on exit, 2012-01-08). So
you might have been remembering issues prior to that commit (or uncommon
signals; these come from sigchain_push_common).

-Peff
