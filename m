Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F110EC433FE
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 22:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhKSWW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:22:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:35380 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235124AbhKSWW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 17:22:26 -0500
Received: (qmail 9331 invoked by uid 109); 19 Nov 2021 22:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Nov 2021 22:19:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19779 invoked by uid 111); 19 Nov 2021 22:19:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 17:19:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 17:19:22 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] diff histogram: intern strings
Message-ID: <YZgi6ikhX4tqLtj0@coredump.intra.peff.net>
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
 <38c771a74d2a348e6a752555f95b746de029b1d7.1637148025.git.gitgitgadget@gmail.com>
 <2b2bd380-540f-959b-b950-cfdc95cbff29@gmail.com>
 <88eaee89-4536-fba4-3aa0-c3693f58eae0@gmail.com>
 <nycvar.QRO.7.76.6.2111181631260.11028@tvgsbejvaqbjf.bet>
 <YZZ0e7CCGW5QbQlW@coredump.intra.peff.net>
 <86d38148-7b97-76aa-148b-346cc179615a@gmail.com>
 <YZe4hqF6Jf14L5tb@coredump.intra.peff.net>
 <211119.86v90n25cv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211119.86v90n25cv.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 10:22:04PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Right, that makes more sense (and we are not likely to lift the 1GB
> > limit anytime soon; there are tons of 32-bit variables and potential
> > integer overflows all through the xdiff code).
> 
> Interestingly:
>     
>     $ du -sh 8gb*
>     8.1G    8gb
>     8.1G    8gb.cp
>     $ ~/g/git/git -P -c core.bigFileThreshold=10g diff -U0 --no-index --no-color-moved 2gb 2gb.cp
>     diff --git a/8gb b/8gb.cp
>     index a886cdfe5ce..4965a132d44 100644
>     --- a/8gb
>     +++ b/8gb.cp
>     @@ -17,0 +18 @@ more
>     +blah
> 
> And the only change I made was:
>     
>     diff --git a/xdiff-interface.c b/xdiff-interface.c
>     index 75b32aef51d..cb8ca5f5d0a 100644
>     --- a/xdiff-interface.c
>     +++ b/xdiff-interface.c
>     @@ -117,9 +117,6 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
>             mmfile_t a = *mf1;
>             mmfile_t b = *mf2;
>      
>     -       if (mf1->size > MAX_XDIFF_SIZE || mf2->size > MAX_XDIFF_SIZE)
>     -               return -1;
>     -
>             if (!xecfg->ctxlen && !(xecfg->flags & XDL_EMIT_FUNCCONTEXT))
>                     trim_common_tail(&a, &b);
> 
> Perhaps we're being overly concervative with these hardcoded limits, at
> least on some platforms? This is Linux x86_64.

It's been a couple of years since I looked, but I'm fairly certain there
are triggerable heap overflows. You probably need fewer than 2^31 lines,
but more than 2^30, as that will overflow the size computation of an
array whose elements are themselves 32-bit integers.

For instance, this:

  perl -e 'print "x\n" x (2**30 + 10)'  >gigaline
  cp gigaline gigaline.cp
  echo foo >>gigaline

results in:

  $ git.compile -c core.bigfilethreshold=10g --no-pager diff --no-index gigaline gigaline.cp
  fatal: Out of memory, malloc failed (tried to allocate 18446744056529682432 bytes)

so at some point we went negative with our allocation (and then it was
cast to size_t when we passed it xmalloc). There's probably a value
somewhere in the middle where it wraps but stays positive, and you'd get
a heap overflow.

> I understand from skimming the above that it's about the pathological
> case, these two files are the same except for a trailer at the end.

The real danger here is not producing a wrong answer for some dumb
cases, but introducing an exploitable heap overflow. Switching to
size_t, or at the very least using st_mult(), etc, everywhere in xdiff
would help. I looked at that long ago, but eventually decided it was
safer and less work to just stick the 1GB limit, since it practice
nobody really cares about diffing beyond that level. (And the limit is
really about number of lines, but 1GB of bytes is an easy proxy for
that).

It would be OK for somebody to fix it if they really want bigger diffs,
but I think it has to be done carefully.

-Peff
