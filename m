Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7BC20D12
	for <e@80x24.org>; Thu,  1 Jun 2017 04:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbdFAEHV (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 00:07:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:32905 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbdFAEHU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 00:07:20 -0400
Received: (qmail 11871 invoked by uid 109); 1 Jun 2017 04:07:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 04:07:18 +0000
Received: (qmail 14027 invoked by uid 111); 1 Jun 2017 04:07:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 00:07:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jun 2017 00:07:17 -0400
Date:   Thu, 1 Jun 2017 00:07:17 -0400
From:   Jeff King <peff@peff.net>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 4/4] stash: implement builtin stash
Message-ID: <20170601040717.63ajkcgr7ihhvgmz@sigill.intra.peff.net>
References: <20170528165642.14699-1-joel@teichroeb.net>
 <20170528165642.14699-5-joel@teichroeb.net>
 <CACBZZX6uXnE+BTfsiLNF2OT3Dsr-J99uUFEwcu-qK45OrU+1hQ@mail.gmail.com>
 <20170528192149.dgzibu334n5ja57e@sigill.intra.peff.net>
 <CA+CzEk8NoGhDB6nX6RRL7J-KenoJBE7rVfskJfCQn_iCSnA4nA@mail.gmail.com>
 <CACBZZX4VP2GZSxw5MqBY=w1EhN64=75MFnjd0CYvPTvoVdFWQw@mail.gmail.com>
 <CA+CzEk9uV5Oqa=NMhd1bjnXP-vjUqVUMH9KSzW6ehi67hqU2+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+CzEk9uV5Oqa=NMhd1bjnXP-vjUqVUMH9KSzW6ehi67hqU2+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 08:29:43PM -0700, Joel Teichroeb wrote:

> I'm running into a lot of trouble using argv_array_clear. It seems
> that some of the builtin git cmd functions move the parameters around,
> and write new pointers to argv. There's three options I have now, and
> I'm not sure which is the best one.

Hrm. It's normal for parsing to reorder the parameters (e.g., shifting
non-options to the front), but that should still allow a clear at the
end. New pointers would definitely cause a problem, though. I don't know
of any cases where we do that, but on the other hand I wouldn't be too
surprised to find that the revision.c options parser does some nasty
tricks.

Do you have a specific example? I'd be curious to see if we can just fix
the parser to be less surprising (i.e., your (1) below).

> 1. Fix all the builtin cmd functions that I use to not mess around with argv

If it's just one or two spots, this might be viable.

> 2. Stop using the builtin cmd functions, and use child processes exclusively

That might not be the worst thing in the world for a first cut at a
shell to C transition, because it eliminates a whole class of possible
problems. But it really just side-steps the problem, as we'd want to
eventually deal with it and reduce the process count.

> 3. Don't worry about clearing the memory used for these function calls.

That might be do-able, as long as the leaks are O(1) for a program run
(and not say, a leak per commit). At the very least we should mark
those spots with a "NEEDSWORK" comment and an explanation of the issue
so that your work in finding them isn't wasted.

> It looks like the rest of the code generally does #3.

It looks like we don't actually pass argv arrays to setup_revisions()
all that often. The three I see are:

  - bisect_rev_setup(), which is a known leak. This is trickier, though,
    because we actually pass the initialized rev_info out of the
    function, and the memory needs to last until we're done with the
    traversal

  - http-push, which does seem to free the memory

  - stat_tracking_info(), which does seem to free

I could well believe there are places where we leak, though, especially
for top-level functions that exit the program when they're done.

A fourth option is to massage the argv array into something that can be
massaged by the callee, and retain the original array for freeing. I.e.,
something like:

  struct argv_array argv = ARGV_ARRAY_INIT;
  const char **massaged;

  argv_array_pushl(&argv, ...whatever...);

  ALLOC_ARRAY(massaged, argc);
  COPY_ARRAY(massaged, argv, argc);

  setup_revisions(argv.argc, massaged, &revs, NULL);

  /*
   * No clue what's in "massaged" now, as setup_revisions() may have
   * reordered things, added new elements, deleted some, etc. But we
   * don't have to care because any pointers we need to free are still
   * in the original argv struct, and we should be safe to free the
   * massaged array itself.
   */
  free(massaged);
  argv_array_clear(&argv);

That's pretty horrible, though. If setup_revisions() is requiring us to
do that, I'd really prefer to look into fixing it.

-Peff
