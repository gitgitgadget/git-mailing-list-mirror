Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C0FD208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 18:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbeHBTyJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 15:54:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:40596 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732348AbeHBTyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 15:54:09 -0400
Received: (qmail 20196 invoked by uid 109); 2 Aug 2018 18:01:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 18:01:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26082 invoked by uid 111); 2 Aug 2018 18:01:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 14:01:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 14:01:55 -0400
Date:   Thu, 2 Aug 2018 14:01:55 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more
 fine-grained
Message-ID: <20180802180155.GD15984@sigill.intra.peff.net>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
 <20180802115522.16107-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180802115522.16107-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 01:55:22PM +0200, SZEDER Gábor wrote:

> Let's add a bit of Makefile metaprogramming to generate finer-grained
> make targets applying one semantic patch to only a single source file,
> and specify these as dependencies of the targets applying one semantic
> patch to all source files.  This way that shell loop can be avoided,
> semantic patches will only be applied to changed source files, and the
> same semantic patch can be applied in parallel to multiple source
> files.  The only remaining sequential part is aggregating the
> suggested transformations from the individual targets into a single
> patch file, which is comparatively cheap (especially since ideally
> there aren't any suggestions).
> 
> This change brings spectacular speedup in the scenario described in
> point (1) above.  When the results of a previous 'make coccicheck' are
> there, the time needed to run
> 
>   touch apply.c ; time make -j4 coccicheck
> 
> went from 3m42s to 1.848s, which is just over 99% speedup, yay!, and
> 'apply.c' is the second longest source file in our codebase.  In the
> scenario in point (2), running
> 
>   touch contrib/coccinelle/array.cocci ; time make -j4 coccicheck
> 
> went from 56.364s to 35.883s, which is ~36% speedup.

I really like this direction. The slowness of coccicheck is one of the
things that has prevented me from running it more frequently. And I'm a
big fan of breaking steps down as much as possible into make targets. It
lets make do its job (avoiding repeated work and parallelizing).

> All the above timings are best-of-five on a machine with 2 physical
> and 2 logical cores.  I don't have the hardware to bring any numbers
> for point (3).  The time needed to run 'make -j4 coccicheck' in a
> clean state didn't change, it's ~3m42s both with and without this
> patch.

On a 40-core (20+20) machine, doing "make -j40 coccicheck" from scratch
went from:

  real	1m25.520s
  user	5m41.492s
  sys	0m26.776s

to:

  real	0m24.300s
  user	14m35.084s
  sys	0m50.108s

I was surprised by the jump in CPU times. Doing "make -j1 coccicheck"
with your patch results in:

  real	5m34.887s
  user	5m5.620s
  sys	0m19.908s

so it's really the parallelizing that seems to be to blame (possibly
because this CPU boosts from 2.3Ghz to 3.0Ghz, and we're only using 8
threads in the first example).

>   - [RFC]
>     With this patch 'make coccicheck's output will look like this
>     ('make' apparently doesn't iterate over semantic patches in
>     lexicographical order):
> 
>       SPATCH commit.cocci              abspath.c
>       SPATCH commit.cocci              advice.c
>       <... lots of lines ...>
>       SPATCH array.cocci               http-walker.c
>       SPATCH array.cocci               remote-curl.c
> 
>     which means that the number of lines in the output grows from
>     "Nr-of-semantic-patches" to "Nr-of-semantic-patches *
>     Nr-of-source-files".

IMHO this is not really that big a deal. We are doing useful work for
each line, so to me it's just more eye candy (and it's really satisfying
to watch it zip by on the 40-core machine ;) ).

What if we inverted the current loop? That is, right now we iterate over
the cocci patches at the Makefile level, and then for each target we
iterate over the giant list of source files. Instead, we could teach the
Makefile to iterate over the source files, with a target for each, and
then hit each cocci patch inside there.

That would give roughly the same output as a normal build. But moreover,
I wonder if we could make things faster by actually combining the cocci
files into a single set of rules to be applied to each source file. That
would mean invoking spatch 1/8 as much. It does give fewer opportunities
for "make" to reuse work, but that only matters when the cocci files
change (which is much less frequent than source files changing).

Doing:

  cat contrib/coccinelle/*.cocci >mega.cocci
  make -j40 coccicheck COCCI_SEM_PATCHES=mega.cocci

gives me:

  real	0m17.573s
  user	10m56.724s
  sys	0m11.548s

And that should show an improvement on more normal-sized systems, too,
because we really are eliminating some of the startup overhead.

The other obvious downside is that you don't get individual patches for
each class of transformation. Do we care? Certainly for a routine "make
coccicheck" I primarily want to know:

  - is there something that needs fixing?

  - give me the patch for all fixes

So I wonder if we'd want to have that be the default, and then perhaps
optionally give some targets to let people run single scripts (or not;
they could probably just run spatch themselves).

>   - [RFC]
>     The overhead of applying a semantic patch to all source files
>     became larger.  'make coccicheck' currently runs only one shell
>     process and creates two output files for each semantic patch.
>     With this patch it will run approx.  "Nr-of-semantic-patches *
>     Nr-of-source-files" shell processes and create twice as many
>     output files.

Doing the "one big .cocci" would help with this, too (and again puts us
in the same ballpark as a compile).

>   - [RFC]
>     This approach uses $(eval), which we haven't used in any of our
>     Makefiles yet.  I wonder whether it's portable enough.  And it's
>     ugly and complicated.

I looked into this a long time ago for another set of Makefile patches I
was considering. $(eval) was added to GNU make in 3.80, released in
2002. Which is probably fine by now.

If it isn't, one more exotic option would be to push the coccicheck
stuff into its own Makefile, and just run it via recursive make. Then
anybody doing a vanilla build can do so even with an antique make, but
you could only "make coccicheck" with something from the last 16 years
(but good luck getting ocaml running there).

I suspect if we go with the one-spatch-per-source route, though, that we
could do this just with regular make rules.

-Peff
