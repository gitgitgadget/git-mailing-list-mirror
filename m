Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1F0C28D13
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 10:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbiHYKkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241063AbiHYKkn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 06:40:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B5A4B13
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 03:40:41 -0700 (PDT)
Received: (qmail 14143 invoked by uid 109); 25 Aug 2022 10:40:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Aug 2022 10:40:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28051 invoked by uid 111); 25 Aug 2022 10:40:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Aug 2022 06:40:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Aug 2022 06:40:40 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] promisor-remote: fix xcalloc() argument order
Message-ID: <YwdRqP1CyUAzCEn2@coredump.intra.peff.net>
References: <20220822213408.662482-1-szeder.dev@gmail.com>
 <20220823095733.58685-1-szeder.dev@gmail.com>
 <YwXiKXONiTt+fIdi@coredump.intra.peff.net>
 <20220824113901.GD1735@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220824113901.GD1735@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2022 at 01:39:01PM +0200, SZEDER Gábor wrote:

> I ran some runtime measurements yesterday, and there is a considerable
> runtime increase in the unbatched case:

Let me condense and rearrange this a bit to the part I think is
important:

>        semantic patch  |    all    | recursive |
>       -----------------+-----------+-----------+--------
>     SPATCH_BATCH_SIZE=1:
>        all             |    1324s  |    2504s  |   +89%
>     SPATCH_BATCH_SIZE=32:
>        all             |    1057s  |    1129s  |    +7%

Right, that's not surprising. "recursive" means we're looking at more
header files than before. For the batch case it has less impact because
it's more likely that some other file we're processing in the batch
_also_ was looking at that header, so we saw it anyway.

With an infinite bath size, adding --recursive-includes should make no
difference (or almost none; it's possible there are headers which
are _only_ included recursively across the whole code base).

My numbers for array.cocci are:

  SPATCH_BATCH_SIZE=1,  133s
  SPATCH_BATCH_SIZE=32,  34s
  SPATCH_BATCH_SIZE=0,   31s

Of course there we run into potential memory problems. Based on glancing
at top occasionally, the first one peaked around 100MB of memory, the
second around 200MB, and the third one around 2GB. So "32" is probably
still a reasonable middle ground for CPU vs memory.

Spending extra CPU, especially for people stuck BATCH_SIZE=1, does suck.
But the tool is already terribly slow. Even if we spend twice as much
CPU (which is what your numbers above show), isn't it worth it to get
the _correct_ result? To me there is not much point in running it at all
if it misses cases.

It would be nice if there was some way to tell coccinelle not to
actually _analyze_ included header files, but just to include them to
pick up types, etc (and then we'd add the headers themselves to
COCCI_SOURCES to check them). But I don't see a way to do that. And I
wouldn't be surprised if the code simply isn't written in a way to make
that easy internally.

Another alternative would be --no-includes (and again, listing the
headers manually via COCCI_SOURCES). But as the example you found shows,
it really does need the headers in order to properly process the code in
the C files themselves.

>     I don't have meaningful numbers about the impact of
>     '--recursive-includes' on the runtime of a parallel 'make -j<N>
>     coccicheck', because they're severely skewed by 'unused.cocci' and
>     'make's scheduler: applying 'unused.cocci' takes 5-10x as long as
>     other semantic patches (accounting for about 38-42% of the total
>     sequential runtime), and 'make' on my system usually schedules it near
>     the end, meaning that for a significant part there is no parallel
>     processing at all.

It may be that unused.cocci can be optimized. Once upon a time I spent
some effort optimizing some of the rules files. I found that if you
relied on having python support, it helped quite a bit, because without
it you are stuck with the "..." operator, which can be very expensive.
More details in this thread:

  https://lore.kernel.org/git/20180824064228.GA3183@sigill.intra.peff.net/

Back then the debian package wasn't being actively updated, and it
wasn't clear if python support would remain. But these days it seems a
bit more stable.  And with the CI job available, I'd prefer to optimize
over making the tool pleasant to use for people who do use it, rather
than worrying that everybody on every platform/build can use it.

All that said, I am not about to get sucked into the rabbit hole of
coccinelle optimization anytime soon. So good luck to you, if you're
interested. ;)

> > I suspect we'd still want to leave --all-includes there to get as much
> > type information as possible. If I understand correctly, the two are
> > orthogonal (one is "follow includes of includes" and the other is
> > "follow system includes in angle brackets").
> 
> 'spatch --help' tells me:
> 
>   --recursive-includes    causes all available include files, both
>                           those included in the C file(s) and those
>                           included in header files, to be used
>   --all-includes          causes all available include files included
>                           in the C file(s) to be used
> 
> So I think the difference is not about system includes, but rather
> about "consider includes of includes" vs. "consider only direct
> includes in the C files", so it seems '--recursive-includes' is a
> superset of '--all-includes'.

I'm not sure, because there's also --local-includes and --no-includes,
which are grouped with --all-includes. (The grouping is doubly confusing
because my copy of the manpage has _two_ options sections, and only some
of the options are mentioned together in the first one).

> Oh, and let's not forget the rather surprising behavior that if spatch
> processes multiple C files at once, then for each of the C files it
> considers all includes from all C files; this explains why
> '--all-includes promisor-remote.c config.c' works, because 'config.c'
> does include 'repository.h', supplying the necessary type information
> to catch the previously missed transformation in 'promisor-remote.c'.

Right. I have a feeling it is sucking in as much data as possible to a
global symbol table, and then doing the analysis. At least that's how
I'd implement it. ;)

> These descriptions don't make it clear (to me) whether the two options
> are orthogonal, exclusive, or something else.  However, trying out various
> combinations indicates that "last one wins", e.g.:

OK, that's compelling evidence. In that case it wouldn't hurt to say:

  --all-includes --recursive-includes

versus just

  --recursive-includes

but it also probably isn't doing anything. ;)

-Peff
