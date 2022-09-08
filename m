Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DC2C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 18:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiIHSki (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 14:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiIHSke (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 14:40:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0546CAC52
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 11:40:29 -0700 (PDT)
Received: (qmail 28460 invoked by uid 109); 8 Sep 2022 18:40:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 18:40:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23497 invoked by uid 111); 8 Sep 2022 18:40:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 14:40:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 14:40:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: opt "git --config-env" test out of SANITIZE=leak
Message-ID: <Yxo3HIXYDxutU0wF@coredump.intra.peff.net>
References: <Yxl91jfycCo7O7Pp@coredump.intra.peff.net>
 <patch-1.1-fb2f0a660c0-20220908T153252Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-fb2f0a660c0-20220908T153252Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2022 at 05:42:54PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This is arguably not a compiler issue or bug, as the very notion of a
> variable being "in scope" as far as the leak checker is concerned is
> fuzzy at best in the face of compiler optimizations.
> 
> A similar issue came up before related to the config.c code in
> [2]. There the consensus seemed to be to avoid hacks in the C code to
> work around these compiler edge cases. In this case however skipping
> one test is easy enough. We can deal with these "!SANITIZE_LEAK"
> issues later, when we have fewer overall leaks.

IMHO this is the wrong approach. It is playing whack-a-mole with
individual false positives, when we know the root cause is compiler
optimizations. We should be invoking the compiler in a way that gives us
the most reliable result.

In the long run, when all leaks are plugged, we'd want to ditch the
whole SANITIZE_LEAK system anyway. So we are better off preventing false
positives than trying to gloss over them.

> > Maybe this is a known problem, but it was certainly surprising to me.
> 
> It is surprising, but it's a (at least to me) known "issue". See
> e.g. https://lore.kernel.org/git/patch-v3-5.6-9a44204c4c9-20211022T175227Z-avarab@gmail.com/
> for a previous discussion between us. I took the consensus there to be
> that we shouldn't bend over backwards to worry about this.

Thanks, I'd forgotten about that conversation. I stand by my comments
there that we shouldn't be changing the code. But I really think just
using -O0 for the leak-check is a better solution than trying to label
false positives.

> But I see this one slipped through because I locally changed my
> default compiler from "clang" to "gcc" (again) a while ago, and thus
> missed testing clang at higher optimization levels. Usually it's GCC
> that's unhappy about this sort of thing.

FWIW, I found this using clang-14, because the gcc on my system (12.2.0)
does not seem to find actual leaks. It couldn't see any of the ones in
t1060 that I fixed yesterday.

> > But if you run this in a debugger, you'll find that under -O2 the "key"
> > variable has been optimized out! So LSan is producing the wrong result
> > due to the optimization. It doesn't know that "key" is conceptually
> > still reachable.
> > [...]
> 
> I don't know if we (or the compiler implementors) can call it the
> "wrong" result. Just as some warnings only pop up depending on
> optimization levels, this behavior also depends on it.

I think it's different than the case of warnings. In those cases the
optimizations let the compiler see more of what's going on in the code,
which lets them find a warn-able offense that they wouldn't otherwise
see (e.g., inlining a function lets the compiler see an invariant).
Those are real problems in the code that -O0 simply doesn't catch.

But this is different: there is no problem in the code. It is just that
the optimization of removing the variable does not work well with how
the leak-checker works. There is nothing we can do in the code to fix
it; the C conceptual model of variable scoping is all we have to work
with, and according to that, there is no leak. C's "as if" rule means
that the compiler can change the program as long as the behavior is the
same. And it is, from the perspective of the rest of the program. The
issue is that the leak-checker is itself a sort of undefined behavior;
it expects to poke at random parts of the stack at any moment and find a
consistent state, which is not something a normal C program can do.

> I've seen quite a few of these around die() codepaths. Presumably some
> re-arranging/eliminaton of the code around that NORETURN codepath...

The compiler probably does this kind of re-arranging and elimination all
the time. The reason it comes up around die() is that it means we invoke
the leak-checker mid-function. Even though the "key" variable here was
eliminated, the compiler would need to arrange that the pointer value is
_somewhere_ so that when we hit the end of the function we can call that
free(). But when we exit in the middle, we end up doing the leak-check
in a funny state.

It may be that this is influenced by the NORETURN flag. Presumably "key"
is held in a register, and the call to die(), knowing that it does not
need to return, may choose not to preserve that register. So turning
NORETURN into a noop _might_ help, but only because it's giving the
optimizer less information to work with (and it might not if the
optimizer can figure it out on its own via inline functions, for
example). The root cause is the optimizer, so disabling it is the
most complete fix.

-Peff
