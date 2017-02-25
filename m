Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C509B201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 22:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbdBYWbu (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 17:31:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:34223 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752102AbdBYWbt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 17:31:49 -0500
Received: (qmail 11976 invoked by uid 109); 25 Feb 2017 22:31:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 22:31:49 +0000
Received: (qmail 17229 invoked by uid 111); 25 Feb 2017 22:31:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 17:31:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 17:31:46 -0500
Date:   Sat, 25 Feb 2017 17:31:46 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] travis-ci: run scan-build every time
Message-ID: <20170225223146.ixubnwqkfol5q2gn@sigill.intra.peff.net>
References: <CAJZjrdXP3n5fOLx4rEEkbJT7JBMPUqk4Qdutm6KpvMVUMwCSPQ@mail.gmail.com>
 <BAB1EE0E-B258-4108-AE24-110172086DE4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BAB1EE0E-B258-4108-AE24-110172086DE4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 10:48:52PM +0100, Lars Schneider wrote:

> 
> > On 24 Feb 2017, at 18:29, Samuel Lijin <sxlijin@gmail.com> wrote:
> > 
> > Introduces the scan-build static code analysis tool from the Clang
> > project to all Travis CI builds. Installs clang (since scan-build
> > needs clang as a dependency) to make this possible (on macOS, also
> > updates PATH to allow scan-build to be invoked without referencing the
> > full path).
> 
> This is a pretty neat idea. However, I think this should become a
> dedicated job in a TravisCI build (similar to the Documentation job [1])
> because:
>  a) We don't want to build and test a scan-build version of Git (AFAIK
>     scan-build kind of proxies the compiler to do its job - I don't if
>     this has any side effects)
>  b) We don't want to slow down the other builds
>  c) It should be enough to run scan-build once on Linux per build

Yeah. I am all for static analysis, but I agree it should be its own
job. Especially as it can be quite noisy with false positives (and I
really think before any static analysis is useful we need to figure out
a way to suppress the false positives, so that we can see the signal in
the noise).

Fully a third of the problem cases found are dead assignments or
increments. I looked at a few, and I think the right strategy is to tell
the tool "no really, our code is fine". For instance, it complains
about:

  argc = parse_options(argc, argv, ...);

when argc is not used again later. Sure, that assignment is doing
nothing. But from a maintainability perspective, I'd much rather have a
dead assignment (that the compiler is free to remove) then for somebody
to later add a loop like:

  for (i = 0; i < argc; i++)
          something(argv[i]);

which will read past the end of the rearranged argv (and probably
_wouldn't_ be caught by static analysis, because the hidden dependency
between argc and argv is buried inside the parse_options() call).

So there is definitely some bug-fixing to be done, but I think there is
also some work in figuring out how to suppress these useless reports.
Turning off the dead-assignment checker is one option, but I actually
think it _could_ produce useful results. It just isn't in these cases.
So I'd much rather if we can somehow suppress the specific callsites.

> I ran scan-build on the current master and it detected 72 potential bugs [2]. 
> I looked through a few of them and they seem to be legitimate. If the list agrees
> that running scan-build is a useful thing and that these problems should be fixed
> then we could:
> 
> (1) Add scan-build check to Travis CI but only print errors as warning
> (2) Fix the 72 existing bugs over time
> (3) Turn scan-build warnings into errors

If they are warnings socked away in a Travis CI job that nobody looks
out, then I doubt anybody is going to bother fixing them.

Not that step (1) hurts necessarily, but I don't think it's really doing
anything until step (2) is finished.

I took a look at a few of the non-dead-assignment ones and some of them
are obviously false positives. E.g., in check_pbase_path(), it claims
that done_pbase_paths might be NULL. But that value just went through
ALLOC_GROW() with a non-zero value, which would either have allocated or
died.

There are other cases where it complains that a strbuf's "buf" parameter
might be NULL. That _shouldn't_ be the case, as it is an invariant of
strbuf. It might be a bug, but it is certainly not a bug where the
analyzer is pointing.

I won't be surprised at all if there are a bunch of real bugs in that
list. But I think the interesting work at this point is not a CI build,
but somebody locally slogging through scan-build and categorizing each
one.

-Peff
