Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D91EC4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 07:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJSHRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 03:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJSHRB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 03:17:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9729B77E88
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 00:16:55 -0700 (PDT)
Received: (qmail 3899 invoked by uid 109); 19 Oct 2022 07:16:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Oct 2022 07:16:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28285 invoked by uid 111); 19 Oct 2022 07:10:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Oct 2022 03:10:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 Oct 2022 03:10:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: force -O0 when compiling with SANITIZE=leak
Message-ID: <Y0+i1G5ybdhUGph2@coredump.intra.peff.net>
References: <Y07yeEQu+C7AH7oN@nand.local>
 <Y08BPbWBj7SNluXq@coredump.intra.peff.net>
 <Y08JZVDgJpJvrBiz@coredump.intra.peff.net>
 <221018.86k04whkgf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221018.86k04whkgf.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2022 at 11:00:54PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Note that we're discussing two different leak here,
> git_config_push_env() one in
> https://lore.kernel.org/git/Yxl91jfycCo7O7Pp@coredump.intra.peff.net/;
> and now another one that originates in the exit() behavior in
> git.c. They're both triggered from t1300, but they're otherwise
> unrelated.

Yes, there are two different cases being discussed. But they _are_
related, in that they are caused by similar compiler optimizations.

> > So here's a patch that does so. I think one of Ævar's reservations in
> > the other thread was not wanting to have to switch optimization levels
> > manually for various builds. I think the patch below should make things
> > Just Work, whether in CI or running a custom build locally.
> 
> No, the opposite. I want to try out various combinations of compile
> flags & optimization levels and not have SANITIZE=leak second-guess it.
>
> Now if I want to compile with -O2 and SANITIZE=leak I'll need to
> monkeypatch the Makefile.

You don't have to patch it. You can do:

  make CFLAGS='-O2 -fsanitize=leak -DSUPPRESS_ANNOTATED_LEAKS'

Yes, that's a mouthful. If you really really want it, we can make the
"-O0" behavior conditional. But I remain entirely unconvinced that what
you're trying to do is useful.

> I'd prefer not to need to do that, because while non-O0 is noisy
> sometimes, I've also found that it points (at least indirectly) to some
> useful edge-cases.

I haven't seen any evidence that leak-checking with -O2 produces
anything of value. And I have seen several examples where it produces
garbage. I guess you're referring here to the elaboration you give below
in your message. But I think you're just wrong about it being useful.

> The tl;dr is that I think you use "leak" in the sense that valgrind
> talks about "still reachable" leaks, which is conceptually where
> -fsanitize=leak draws the line. I.e. it's not a malloc()/free() tracker,
> but tries to see what's "in scope".

No, these "still reachable" cases are not at all interesting. If we end
the program by returning up the stack, then perhaps they could be (but
IMHO they are not generally, because it's perfectly reasonable to leave
globals pointing to allocated memory at program exit). But if we exit in
the middle of a function, and variables are left on the stack, what in
the world is the use of a leak-checker complaining about that?

It is not hurting anything, because by definition we have exited the
program and released the memory. And it is near-impossible to remove
these entirely. In the example we're discussing, there's a local
variable in git_config_push_env() that _could_ be freed before calling
die(). But not in the general case:

  - what about heap allocations in callers? Imagine a program like this:

      void foo(const char *str)
      {
        if (some_func(str))
          die("bad str");
      }
      void bar(void)
      {
        char *str = strdup("some string");
	foo(str);
	free(str);
      }

    If foo() calls die(), then bar()'s str is a "still reachable" leak.
    But we can't fix it in any reasonable way. foo() doesn't know about
    freeing the string. And bar() doesn't know about calling die().

  - likewise, we may actually need the heap-allocated string to call
    die! Consider this:

      void foo(void)
      {
        char *str = strdup("some string");
	if (some_func(str))
	  die("bad str: %s", str);
	free(str);
      }

    You can't avoid a "still reachable" leak here, because die() would
    need to use the string, then free it, then exit.

So if these "still reachable" leaks are not hurting anything, and if
they are impossible to get rid of, why do we want to care about them?
Doing so just causes pain with no benefit.

> This is getting a bit academic, but I don't see how you can both say
> that the "compilers are allowed to modify the program as long as the
> observable behavior of that abstract machine is unchanged" *and* claim
> that e.g. the git_config_push_env() case isn't a real leak.

The words "observable behavior" are doing a lot of heavy lifting there.
That is the behavior which a conforming C program can observe. And in
this case, nothing is violated. We did not reach the free() call, so
there was no need to make sure we had the parameters available. The C
standard's abstract machine doesn't know about things like "the stack is
memory that you can look at". Doing that is undefined behavior, and a
program which cares about that is not conforming.

I agree this is mostly academic. My point in bringing it up was just to
say that no, this isn't a bug in the optimizer. Clobbering values for
NORETURN is perfectly reasonable and valid according to the standard.
And leak-checking, while basically undefined behavior from the
perspective of the standard, is a useful tool. It's the interaction
between the two that is ugly, and the most useful thing for us to do is
avoid using both at the same time.

> Because surely the thing that makes it a "leak" by your definition (and
> what LSAN strives for) is that it's attributed to a variable that's "in
> scope", but the compiler is free to re-arrange all of that.

If you mean "not a leak", then yes: there's still an in-scope variable
that points to it, which is what makes it not a leak.

> Anyway, one reason I wanted to punt on that "git --config-env" issue is
> because we can entirely avoid the malloc()/free() there. See the "-- >8
> --" below, but if we just malloc() after we do our assertions we can
> un-confuse clang.
> 
> And that seems like a good idea in general, and re whether the "leak" is
> gone, at that point valgrind will stop reporting it, so we're really not
> leaking at all, not just in the "still reachable" sense.

I'm not convinced it's a good idea. The resulting code requires an extra
variable and is (IMHO) slightly harder to understand. And what have we
accomplished? We silenced one false positive, but we know there are
others. And the linux-leaks CI job is failing on master _right now_, and
the patch below doesn't fix that.

That makes the job somewhat worthless. And worse, it makes all of CI
less useful, because if it says "failed" on every build, people will
start to ignore it.

> The reason I mention all of that is to try to define the problem here. I
> haven't seen cases where the compilers get it wrong about there being a
> leak, it's just that they're mis-categorizing them as "still reachable"
> or not, re your "abstract machine" summary.

This paragraph makes it sound like we are mixing up a real leak and a
"still reachable" leak. But it is mixing up "there is no leak and
nothing to fix" with "there is a still reachable leak".

> Now, the other cases in t1300 are from git.c using exit() instead of
> retur-ing to our main().
> 
> Among numerous other leak fixes I have queued up I have a fix for that,
> which fixes the other t1300 cases that have been reported now:
> https://github.com/avar/git/tree/avar/git-c-do-not-exit

I said it in the last round of discussion, and I'll say it again: this
is the wrong direction. These are not real leaks, and we should not be
twisting our code to try to avoid them. We should be fixing our
leak-checking so that they don't come up.

> The actual meaningful fix here is that we don't need to do this
> allocation at all. The only reason it's needed is because there's no
> variant of "sq_quote_buf()" in quote.c that takes a "len"
> parameter (but I have one locally).
> 
> If we had that we could just pass a "key" and "key_len" to
> git_config_push_split_parameter() instead and avoid the allocation
> altogether. But in lieu of that better fix (which other API users of
> quote.c would benefit from) let's defer the allocation, which happens
> to fix the leak reporting on

So as you probably guessed, I absolutely hate this patch and think we
should not take it.

If we had a version of sq_quote_buf() that took a "len" parameter, then
sure, it would be reasonable to use. But it absolutely is not worth
caring about to silence a leak that is a false positive. There is
_nothing_ wrong with the code as written.

-Peff
