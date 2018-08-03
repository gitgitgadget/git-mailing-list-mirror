Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E2B1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 06:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeHCIRM (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 04:17:12 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:62196 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727618AbeHCIRL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Aug 2018 04:17:11 -0400
X-IronPort-AV: E=Sophos;i="5.51,437,1526335200"; 
   d="scan'208";a="341265071"
Received: from abo-214-111-68.mrs.modulonet.fr (HELO [192.168.0.15]) ([85.68.111.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 08:22:24 +0200
Date:   Fri, 3 Aug 2018 08:22:24 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>,
        =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        nicolas.palix@univ-grenoble-alpes.fr,
        yamada.masahiro@socionext.com, cocci@systeme.lip6.fr,
        nicolas.palix@imag.fr
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more
 fine-grained
In-Reply-To: <87bmaktpbt.fsf@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.20.1808030755350.2446@hadrien>
References: <20180723135100.24288-1-szeder.dev@gmail.com> <20180802115522.16107-1-szeder.dev@gmail.com> <20180802180155.GD15984@sigill.intra.peff.net> <87bmaktpbt.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-890485604-1533277345=:2446"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--8323329-890485604-1533277345=:2446
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 2 Aug 2018, Ævar Arnfjörð Bjarmason wrote:

>
> On Thu, Aug 02 2018, Jeff King wrote:
>
> > On Thu, Aug 02, 2018 at 01:55:22PM +0200, SZEDER Gábor wrote:
> >
> >> Let's add a bit of Makefile metaprogramming to generate finer-grained
> >> make targets applying one semantic patch to only a single source file,
> >> and specify these as dependencies of the targets applying one semantic
> >> patch to all source files.  This way that shell loop can be avoided,
> >> semantic patches will only be applied to changed source files, and the
> >> same semantic patch can be applied in parallel to multiple source
> >> files.

This was already possible.  Make coccicheck is not supposed to be used
with -j, but rather with J=n.  That tells Coccinelle to parallelize the
treatment of the files internally.  In this case, the semantic patch is
only parsed once, and then n worker processes are forked to treat the
different files.

>  The only remaining sequential part is aggregating the
> >> suggested transformations from the individual targets into a single
> >> patch file, which is comparatively cheap (especially since ideally
> >> there aren't any suggestions).
> >>
> >> This change brings spectacular speedup in the scenario described in
> >> point (1) above.  When the results of a previous 'make coccicheck' are
> >> there, the time needed to run
> >>
> >>   touch apply.c ; time make -j4 coccicheck
> >>
> >> went from 3m42s to 1.848s, which is just over 99% speedup, yay!, and
> >> 'apply.c' is the second longest source file in our codebase.  In the
> >> scenario in point (2), running
> >>
> >>   touch contrib/coccinelle/array.cocci ; time make -j4 coccicheck
> >>
> >> went from 56.364s to 35.883s, which is ~36% speedup.
> >
> > I really like this direction. The slowness of coccicheck is one of the
> > things that has prevented me from running it more frequently. And I'm a
> > big fan of breaking steps down as much as possible into make targets. It
> > lets make do its job (avoiding repeated work and parallelizing).
>
> Yeah, this is great. Also, CC-ing some of the recent contributors to
> linux.git's coccinelle, perhaps they're interested / have comments.

I have extended the list of recipients with Nicolas Palix and the
Coccinelle mailing list.  In particular, Nicolas should comment on any
changes.

>
> >> All the above timings are best-of-five on a machine with 2 physical
> >> and 2 logical cores.  I don't have the hardware to bring any numbers
> >> for point (3).  The time needed to run 'make -j4 coccicheck' in a
> >> clean state didn't change, it's ~3m42s both with and without this
> >> patch.
> >
> > On a 40-core (20+20) machine, doing "make -j40 coccicheck" from scratch
> > went from:
> >
> >   real	1m25.520s
> >   user	5m41.492s
> >   sys	0m26.776s
> >
> > to:
> >
> >   real	0m24.300s
> >   user	14m35.084s
> >   sys	0m50.108s

By default, when the -j option is not used, make coccicheck causes
Coccinelle to run on all of the cores of the machine.  In my experience,
on a laptop (2 physical cores with hyperthreading), this is basically OK.
And on a server, it is a disaster.  On a machine with 80 physical cores
and hyperthreading, make coccicheck will run each instance of Coccinelle
such that it parallelizes on 160 cores.  But in reality, there is not much
difference between 20 and 40 cores, and after 40 cores the performance
starts to degrade.  So basically, using more than half of the physical
cores on each socket is a loss.


> >
> > I was surprised by the jump in CPU times. Doing "make -j1 coccicheck"
> > with your patch results in:
> >
> >   real	5m34.887s
> >   user	5m5.620s
> >   sys	0m19.908s
> >
> > so it's really the parallelizing that seems to be to blame (possibly
> > because this CPU boosts from 2.3Ghz to 3.0Ghz, and we're only using 8
> > threads in the first example).
> >
> >>   - [RFC]
> >>     With this patch 'make coccicheck's output will look like this
> >>     ('make' apparently doesn't iterate over semantic patches in
> >>     lexicographical order):
> >>
> >>       SPATCH commit.cocci              abspath.c
> >>       SPATCH commit.cocci              advice.c
> >>       <... lots of lines ...>
> >>       SPATCH array.cocci               http-walker.c
> >>       SPATCH array.cocci               remote-curl.c
> >>
> >>     which means that the number of lines in the output grows from
> >>     "Nr-of-semantic-patches" to "Nr-of-semantic-patches *
> >>     Nr-of-source-files".
> >
> > IMHO this is not really that big a deal. We are doing useful work for
> > each line, so to me it's just more eye candy (and it's really satisfying
> > to watch it zip by on the 40-core machine ;) ).
>
> FWIW on the 8-cpu box I usually test on this went from 2m30s to 1m50s,
> so not a huge improvement in time, but nice to have the per-file
> progress.

Coccinelle already does this when make coccicheck is used with J=n.  It
makes a subdirectory for the semantic patch that it is currently working
on, and this subdirectory contains stderr.n files that contain HANDLING
and the name of the file being treated.  It also prints information about
performance bottlenecks.  I think that make coccicheck turns off all this
reporting by default, but you can get it back with SPFLAGS="--quiet"

> > What if we inverted the current loop? That is, right now we iterate over
> > the cocci patches at the Makefile level, and then for each target we
> > iterate over the giant list of source files. Instead, we could teach the
> > Makefile to iterate over the source files, with a target for each, and
> > then hit each cocci patch inside there.
> >
> > That would give roughly the same output as a normal build. But moreover,
> > I wonder if we could make things faster by actually combining the cocci
> > files into a single set of rules to be applied to each source file. That
> > would mean invoking spatch 1/8 as much. It does give fewer opportunities
> > for "make" to reuse work, but that only matters when the cocci files
> > change (which is much less frequent than source files changing).
> >
> > Doing:
> >
> >   cat contrib/coccinelle/*.cocci >mega.cocci
> >   make -j40 coccicheck COCCI_SEM_PATCHES=mega.cocci

There was already a COCCI=foo.cocci argument to focus on a single semantic
patch.

I'm surprised that the above cat command would work.  Semantic patch rules
have names, and Coccinelle will not be happy isf two rules have the same
name.  Some may also have variables declared in initializers, although
perhaps the ones in the kernel don't do this.  Causing these variables to
be shared would not have a good effect.

Putting everything together can also go counter to the optimizations that
Coccinelle provides.  You can speed up spatch a lot on rules that mention
specific functions by running id-utils on your code base in advance (sh
coccinelle/scripts/idutils_index.sh).  The if you have one semantic patch
that only applies to files that contain foo and another that only applies
to files that contain bar, then each will only be applied to its
respective files.  If you don't have an id-utils index this optimization
will be done by Coccinelle by first scanning files for foo and bar, but
the index is obviously much faster.  If your semantic patch can be
relavant to files that contain foo or bar, then the rules from the foo
semantic patch (which could be very slow) will also be uselessly applied
to the bar files.  Whether this is relevant in practice depends on the
specific semantic patches of course.

> >
> > gives me:
> >
> >   real	0m17.573s
> >   user	10m56.724s
> >   sys	0m11.548s
> >
> > And that should show an improvement on more normal-sized systems, too,
> > because we really are eliminating some of the startup overhead.
> >
> > The other obvious downside is that you don't get individual patches for
> > each class of transformation. Do we care? Certainly for a routine "make
> > coccicheck" I primarily want to know:
> >
> >   - is there something that needs fixing?
> >
> >   - give me the patch for all fixes
> >
> > So I wonder if we'd want to have that be the default, and then perhaps
> > optionally give some targets to let people run single scripts (or not;
> > they could probably just run spatch themselves).
> >
> >>   - [RFC]
> >>     The overhead of applying a semantic patch to all source files
> >>     became larger.  'make coccicheck' currently runs only one shell
> >>     process

Not sure to understand this.  To my understanding it runs as many shell
processes as there are cores on the machine.

julia

> and creates two output files for each semantic patch.
> >>     With this patch it will run approx.  "Nr-of-semantic-patches *
> >>     Nr-of-source-files" shell processes and create twice as many
> >>     output files.
> >
> > Doing the "one big .cocci" would help with this, too (and again puts us
> > in the same ballpark as a compile).
> >
> >>   - [RFC]
> >>     This approach uses $(eval), which we haven't used in any of our
> >>     Makefiles yet.  I wonder whether it's portable enough.  And it's
> >>     ugly and complicated.
> >
> > I looked into this a long time ago for another set of Makefile patches I
> > was considering. $(eval) was added to GNU make in 3.80, released in
> > 2002. Which is probably fine by now.
> >
> > If it isn't, one more exotic option would be to push the coccicheck
> > stuff into its own Makefile, and just run it via recursive make. Then
> > anybody doing a vanilla build can do so even with an antique make, but
> > you could only "make coccicheck" with something from the last 16 years
> > (but good luck getting ocaml running there).
> >
> > I suspect if we go with the one-spatch-per-source route, though, that we
> > could do this just with regular make rules.
> >
> > -Peff
>
--8323329-890485604-1533277345=:2446--
