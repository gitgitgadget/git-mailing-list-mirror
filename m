Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CE0C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 15:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED22613DC
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 15:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhFXPTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 11:19:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:59428 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232053AbhFXPS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 11:18:56 -0400
Received: (qmail 12153 invoked by uid 109); 24 Jun 2021 15:16:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 15:16:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13097 invoked by uid 111); 24 Jun 2021 15:16:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 11:16:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 11:16:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why the Makefile is so eager to re-build & re-link
Message-ID: <YNSh0CskelTwuZq0@coredump.intra.peff.net>
References: <874kdn1j6i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kdn1j6i.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 24, 2021 at 03:16:48PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This is probably all stuff that's been on list-before / known by
> some/all people in the CC list, but in case not: I looked a bit into why
> we'e so frequently re-linking and re compiling things these days,
> slowing down e.g. "git rebase --exec='make ...'".
> 
> These are all fixable issues, I haven't worked on them, just some notes
> in case anyone has better ideas:

From a quick skim I didn't see anything wrong in your analysis or
suggestions. I do kind of wonder if we are hitting a point of
diminishing returns here. "make -j16" on my system takes ~175ms for a
noop, and ~650ms if I have to regenerate version.h (it's something like
2s total of CPU, but I have 8 cores).

I know I've probably got a nicer machine than many other folks. But at
some point correctness and avoiding complexity in the Makefile become a
win over shaving off a second from compile times. You'd probably find
lower hanging fruit in the test suite which could shave off tens of
seconds. :)

>  * {command,config}-list.h (and in-flight, my hook-list.h): Every time
>    you touch a Documentation/git-*.txt we need to re-generate these, and
>    since their mtime changes we re-compile and re-link all the way up to
>    libgit and our other tools.
> 
>    I think the best solution here is to make the generate-*.sh
>    shellscripts faster (just one takes ~300ms of nested shellscripting,
>    just to grep out the first few lines of every git-*.txt, in e.g. Perl
>    or a smarter awk script this would be <5ms).

Yeah, I think Eric mentioned he had looked into doing this in perl, but
we weren't entirely happy with the dependency. Here's another really odd
thing I noticed:

  $ time sh ./generate-cmdlist.sh command-list.txt >one
  real	0m1.323s
  user	0m1.531s
  sys	0m0.834s

  $ time sh -x ./generate-cmdlist.sh command-list.txt >two
  [a bunch of trace output]
  real	0m0.513s
  user	0m0.754s
  sys	0m0.168s

  $ cmp one two
  [no output]

Er, what? Running with "-x" makes it almost 3 times faster to generate
the same output? I'd have said this is an anomaly, but it's repeatable
(and swapping the order produces the same output, so it's not some weird
priming thing). And then to top it all off, redirecting the trace is
slow again:

  $ time sh -x ./generate-cmdlist.sh command-list.txt >two 2>/dev/null
  real	0m1.363s
  user	0m1.538s
  sys	0m0.902s

A little mini-mystery that I think I may leave unsolved for now.

>    Then we make those FORCE, but most of the time the config or command
>    summary (or list of hooks) doesn't change, so we don't need to
>    replace the file.

Yes, possibly we could use the "if it hasn't changed, don't update the
file" trick to avoid cascading updates.

> Perhaps even better would be to piggy-back on the RUNTIME_PREFIX
> support, and simply drop in generated plain-text files, so in your build
> checkout the list of hooks, commands etc. would be parsed instead of
> compiled in. Then we wouldn't need to re-build or re-link anything for
> the version or this other data.

Yeah, that would work. I worry a bit that the value of something like
"version.h" is lost with a runtime file, though. The point is to bake it
into the binary so you can't accidentally get the wrong value (say, from
running "./git" from the build directory, which looks at the runtime
file where the binary _would_ be installed, except you haven't run "make
install" yet).

For cmdlist stuff it could be a good match, though.

-Peff
