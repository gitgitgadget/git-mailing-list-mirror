Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE481C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD8361CEB
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhF2CPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:15:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:35662 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhF2CPi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:15:38 -0400
Received: (qmail 17654 invoked by uid 109); 29 Jun 2021 02:13:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Jun 2021 02:13:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23047 invoked by uid 111); 29 Jun 2021 02:13:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Jun 2021 22:13:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Jun 2021 22:13:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why the Makefile is so eager to re-build & re-link
Message-ID: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
References: <874kdn1j6i.fsf@evledraar.gmail.com>
 <YNSh0CskelTwuZq0@coredump.intra.peff.net>
 <fb23a23e-13be-14a8-4fbe-5ca2b4bcdb52@kdbg.org>
 <87r1gqxqxn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1gqxqxn.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 25, 2021 at 10:34:20AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Interesting, but I think rather than micro-optimizing the O(n) loop it
> makes more sense to turn it into a series of O(1) in -j parallel,
> i.e. actually use the make dependency graph for this as I suggested in:
> https://lore.kernel.org/git/87wnqiyejg.fsf@evledraar.gmail.com/

I have mixed feelings on that. I do like the general notion of breaking
apart tasks and feeding the dependencies to "make", because that lets it
do a better job of parallelizing or avoiding already-done work. But
there's a cost to running any job, so eventually you get to a unit of
work that's so small the overhead dominates.

For instance, starting from a built Git but dirtying all doc files with
"touch Documentation/*.txt", running "time make -j16" yields:

  real	0m1.749s
  user	0m2.963s
  sys	0m1.146s

With your patch to break it apart into many jobs, the same operation
gives:

  real	0m0.762s
  user	0m3.054s
  sys	0m0.600s

So that took fewer wall-clock seconds, but we actually spent more CPU.
On a system with fewer cores, it would probably be a loss in both
places.

Now maybe that's a good tradeoff, especially because the common case
(aside from a build-from-scratch, which will spend loads more time
actually compiling anyway) is that only a handful of files would be
updated.

But if we can just make the actual operation faster, then even O(n)
repeated work might be a win in all cases, because it's avoiding the
overhead of extra jobs.

I dunno. I think there's a formula here that depends on the overhead of
a job versus the time to handle a single file in the script, coupled
with the expected number of changed files for any run. I'm not sure of
the exact values of those numbers in this case, but am mostly pointing
out that it's a tradeoff and not always a pure win. :)

> Something like the hacky throwaway patch that follows. Now when you
> touch a file in Documentation/git-*.txt you re-make just that file
> chain, which gets assembled into the command-list.h:

I know you said this was throwaway, but in case you do pursue it
further, my first run hit:

  $ time make
  GIT_VERSION = 2.32.0.94.gaa5e6f14dd
      * new prefix flags
      GEN build/Documentation
      GEN build/Documentation/git-add.txt.cmdlist.in
  /bin/sh: 1: cannot create build/Documentation/git-add.txt.cmdlist.in: Directory nonexistent
  /bin/sh: 5: cannot create build/Documentation/git-add.txt.cmdlist.in: Directory nonexistent
      GEN build/Documentation/git-am.txt.cmdlist.in
  /bin/sh: 1: cannot create build/Documentation/git-am.txt.cmdlist.in: Directory nonexistent
  /bin/sh: 5: cannot create build/Documentation/git-am.txt.cmdlist.in: Directory nonexistent

So I'd guess there's some race with creating the build/Documentation
directory (a subsequent run worked fine).

-Peff
