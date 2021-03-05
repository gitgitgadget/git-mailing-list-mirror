Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05900C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 10:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C827564F5F
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 10:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCEKYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 05:24:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:53332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhCEKYP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 05:24:15 -0500
Received: (qmail 1002 invoked by uid 109); 5 Mar 2021 10:24:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Mar 2021 10:24:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18838 invoked by uid 111); 5 Mar 2021 10:24:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Mar 2021 05:24:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Mar 2021 05:24:13 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Makefile: fix bugs in coccicheck and speed it up
Message-ID: <YEIGzXMDax83cwAx@coredump.intra.peff.net>
References: <20190506234334.GA13296@sigill.intra.peff.net>
 <20210302205103.12230-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302205103.12230-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 02, 2021 at 09:51:03PM +0100, Ævar Arnfjörð Bjarmason wrote:

> What we were doing before was processing all our *.c files, and for
> each of those *.c files we'd recursively look around for includes and
> see if we needed to search/replace in those too.
> 
> That we did that dates back to [1] when we were only processing *.c
> files, and it was always very redundant. We'd e.g. visit the likes of
> strbuf.h lots of times since it's widely used as an include.

OK. I don't offhand know if processing the includes along with the C
files buys us anything else. Coccinelle's behavior is often quite a
mystery, but if we think this produces the same results with less time,
I'm for it.

BTW, this "dates back to when we were only processing *.c files"
statement confused me a bit. Doesn't that include the current state
before this patch?  I.e., this hunk:

> -FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
> +FOUND_C_SOURCES = $(filter %.c %.h,$(shell $(FIND_SOURCE_FILES)))

seems to be an important part of the change, without which moving away
from --all-includes would be wrong.

> Then in the most recent attempt to optimize coccicheck in [2] this
> anti-pattern finally turned into a bug.
>
> Namely: before this change, if your coccicheck rule applied to
> e.g. making a change in strbuf.h itself we'd get *lots* of duplicate
> hunks applying the exact same change, as concurrent spatch processes
> invoked by xargs raced one another. In one instance I ended up with 27
> copies of the same hunk in a strbuf.patch.
> 
> Setting SPATCH_BATCH_SIZE=0 and processing all the files in one giant
> batch mitigated this. I suspect the author of [2] either mostly ran in
> that mode, or didn't test on changes that impacted widely used header
> files.

This "turned into a bug" I didn't understand, though. That commit [2]
just switched from always feeding files one at a time to letting you
feed more than one.  So yes, feeding all at once (with
SPATCH_BATCH_SIZE=0) mitigated the bug. But wouldn't any bug that shows
up with SPATCH_BATCH_SIZE=1 have already existed previously?

IOW, I don't think the batch-size stuff made anything worse. It made one
specific case better, but that was not even its purpose.

That is maybe splitting hairs, but I want to make sure I understand all
of what you're claiming here. But also...

> I'm entirely removing SPATCH_BATCH_SIZE. If you want to tweak it you
> can tweak SPATCH_XARGS_FLAGS to e.g. "-n 256", or "-P 4 -n 128". But
> in my testing it isn't worth it to tweak SPATCH_XARGS_FLAGS for a full
> "make coccicheck".

You hard-code this to 32 now. But I'm not sure if that's going to be the
universal best value.

Applying just part of your patch, but leaving SPATCH_BATCH_SIZE in
place, like so:

diff --git a/Makefile b/Makefile
index dfb0f1000f..88cb157547 100644
--- a/Makefile
+++ b/Makefile
@@ -1201,7 +1201,7 @@ SP_EXTRA_FLAGS = -Wno-universal-initializer
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
-SPATCH_FLAGS = --all-includes --patch .
+SPATCH_FLAGS = --no-includes --patch .
 SPATCH_BATCH_SIZE = 1
 
 include config.mak.uname
@@ -2859,7 +2859,7 @@ check: config-list.h command-list.h
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
+FOUND_C_SOURCES = $(filter %.c %.h,$(shell $(FIND_SOURCE_FILES)))
 COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)

Then I get this with various batch sizes (using "make -j16" on an 8-core
machine, so all of the patches are being run at the same time):

  size |  real  |  user  | sys
  -------------------------------
    1  |  1m28s | 10m00s | 0m56s
    2  |  1m03s |  7m49s | 0m33s
    4  |  0m51s |  6m28s | 0m20s
    8  |  0m45s |  6m02s | 0m14s
   16  |  0m45s |  6m17s | 0m10s
   32  |  0m44s |  6m33s | 0m07s
   64  |  0m45s |  6m48s | 0m06s
    0  |  1m08s | 10m08s | 0m03s

So there's a sweet spot at 8. Doing "32" isn't that much worse (runtime
is about the same, but we use more CPU), but it gets progressively worse
as the batch size increases.

That's the same sweet spot before your patch, too, btw. I know because I
happened to be timing it the other day, as coccinelle 1.1.0 hit debian
unstable. When I originally wrote the SPATCH_BATCH_SIZE feature, I think
I was using 1.0.4 or 1.0.7. Back then SPATCH_BATCH_SIZE=0 was a clear
win, assuming you had the memory. But in 1.0.8 it ran for many minutes
without finishing. I found back then that "2" was the sweet spot. But
now it's "8".

All of which is to say: the timing difference between my "8" and "32"
cases isn't that exciting. But the performance of spatch has been
sufficiently baffling to me that I think it's worth keeping the knob.

Your XARGS_FLAGS does accomplish something similar (and is in fact more
flexible, though at the cost of being less abstract).  I'm OK to replace
one with the other, but shouldn't it happen in a separate patch? It's
completely orthogonal to the --no-includes behavior.

> I'm also the whole "cat $@.log" introduced in [3]. Since we don't call
> this in a loop anymore (and xargs will early-exit) we can just rely on
> standard V=1 for debugging issues.

I think this is missing the point of the cat. We've redirected spatch's
stderr to the logfile. So if there's an error, you have no idea what it
was without manually figuring out which file to cat. And V=1 doesn't
help that.

We could stop doing that redirection, but the problem is that spatch is
very verbose. So the point was to store the output but only dump it
when we see an error.

So this part of the patch seems like a pure regression to me. E.g.,
introduce a syntax error like:

diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
index 4490069df9..c6c6562a0a 100644
--- a/contrib/coccinelle/free.cocci
+++ b/contrib/coccinelle/free.cocci
@@ -11,7 +11,7 @@ expression E;
   free(E);
 
 @@
-expression E;
+expression E
 @@
 - free(E);
 + FREE_AND_NULL(E);

and run "make coccicheck" before and after your patch:

  [before]
  $ make coccicheck
  GIT_VERSION = 2.31.0.rc1.8.gbe7935ed8b.dirty
      SPATCH contrib/coccinelle/free.cocci
  init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
  meta: parse error: 
    File "contrib/coccinelle/free.cocci", line 15, column 0, charpos = 99
    around = '@@',
    whole content = @@

  xargs: spatch: exited with status 255; aborting
  make: *** [Makefile:2866: contrib/coccinelle/free.cocci.patch] Error 1

  [after]
  $ make coccicheck
    SPATCH contrib/coccinelle/free.cocci
  make: *** [Makefile:2875: contrib/coccinelle/free.cocci.patch] Error 124

-Peff
