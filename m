Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C32C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 21:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiIWVCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 17:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiIWVCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 17:02:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627FF123DA9
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 14:01:25 -0700 (PDT)
Received: (qmail 13752 invoked by uid 109); 23 Sep 2022 21:01:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Sep 2022 21:01:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17015 invoked by uid 111); 23 Sep 2022 21:01:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Sep 2022 17:01:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Sep 2022 17:01:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: opt "git --config-env" test out of SANITIZE=leak
Message-ID: <Yy4eo6500C0ijhk+@coredump.intra.peff.net>
References: <Yxl91jfycCo7O7Pp@coredump.intra.peff.net>
 <patch-1.1-fb2f0a660c0-20220908T153252Z-avarab@gmail.com>
 <Yxo3HIXYDxutU0wF@coredump.intra.peff.net>
 <220923.86k05u4hfd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220923.86k05u4hfd.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 10:28:29AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > In the long run, when all leaks are plugged, we'd want to ditch the
> > whole SANITIZE_LEAK system anyway. So we are better off preventing false
> > positives than trying to gloss over them.
> 
> In the long run when all leaks are plugged I'd prefer to be able to
> compile a git with CFLAGS=-O3 and -fsanitize=leak, and have it run "git
> config" without erroring out about a leak.

Why? Do you want to run a leak-checking copy of Git all the time? If so,
I have bad news for you performance-wise. Running the tests marked as
leak-passing with -O2 (but not -fsanitize=leak) takes ~101s of CPU.
Running with -O0 takes ~111s. Running with -fsanitize=leak takes ~241s.
So the improvement from compiler optimizations is not a big win there,
relatively speaking.

Or are you thinking that -O3 reveals new information we would not find
under other optimization levels? I don't think this is the case. While
that does sometimes find new opportunities for static analysis (via
inlining code, etc), I don't think it helps with run-time analysis. And
as we've seen here, it actively makes things _worse_ by introducing
false positives.

> So I'd really prefer to keep this patch as-is. I'd agree with you if the
> "whack-a-mole" was painful, but in this case it's really not. I think
> it's just this one edge-case in the whole codebase (out of the things
> marked leak-free).

Is it just this one spot? This is already the second one we've discussed
on the list, and I think you indicated there were more spots where you
intentionally held back on setting TEST_PASSES_SANITIZE_LEAK when you
saw hits under higher optimization levels.

It really is a potential problem anywhere we'd call a NORETURN function,
because the compiler (rightly) realizes there is no point in making sure
we can call a later free() that we'll never reach.

> That's inching us closer to what I think should be the end goal,
> i.e. this SANITIZE=leak is just a transition mechanism, so having it
> enforce -O0 would mean that we can't have -fsanitize=leak Just Work in
> the future (both for the tests & when manually compiled).

I think TEST_PASSES_SANITIZE_LEAK is a transition mechanism. But we'll
always want SANITIZE=leak, and I don't think it makes sense for ordinary
builds to use it.

> This is just from vague recollection, and I couldn't find an example now
> with some light digging (which was just seeing if any of the tests with
> a "!SANITIZE_LEAK" prereq passed on -O0, but not -O3 with clang), but I
> think I've run into cases where higher optimization levels have also
> spotted genuine leaks that I've fixed.

If you have a counter-example, I'm all ears, but I have trouble
imagining how -O3 could actually find a leak not present in -O0. Again,
because we're testing runtime behavior, and the optimizations should not
be changing the visible behavior of our program (and the problem is the
leak checker itself is testing "invisible" things that may not actually
be important, like the state of a variable on the stack when we call
exit()).

-Peff
