Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116D9C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C920A65294
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhCHSzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:55:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:55840 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhCHSzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:55:23 -0500
Received: (qmail 26519 invoked by uid 109); 8 Mar 2021 18:55:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Mar 2021 18:55:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20224 invoked by uid 111); 8 Mar 2021 18:55:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Mar 2021 13:55:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 Mar 2021 13:55:22 -0500
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH 0/7] Fix all leaks in t0001
Message-ID: <YEZzGjNMSj+MkDUH@coredump.intra.peff.net>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.899.git.1615228580.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 06:36:13PM +0000, Andrzej Hunt via GitGitGadget wrote:

> This series fixes (or annotates) all the memory leaks that can cause t0001
> to fail when run with LeakSanitizer (t0000 already passes without failures).
> 
> I suspect that none of these leaks had any user impact, and I'm aware that
> every change does cause some noise - I would have no objections to
> abandoning this series if it's not deemed valuable enough. On the other
> hand: fixing or suppressing these leaks should make it easier to spot leaks
> that have more significant user impact (it's entirely plausible that no real
> impactful leaks exist).

I think it's worth doing. The reason t0000 passes is because it was my
reference script when adding UNLEAK() back in:

  https://lore.kernel.org/git/20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net/

(which might be of historical interest if you haven't read it). I knew
that the next step would be tediously going through the test suite
looking at the tool results, and I somehow stalled on that part. ;)

But I think it's nice to move the goal forward incrementally. I agree
that a lot of these leaks aren't that important, but it's generally as
easy to fix or annotate them as it is to argue that they shouldn't be
dealt with.

> Note: this series does not guarantee that there are no leaks within
> t0000-t0001, it only fixes those leaks which cause test failures. There is
> at least one test case in t0000 where git is invoked in a subshell, and the
> return value is ignored - meaning that a memory leak that is occuring during
> that invocation does not cause tests to fail (I'm still trying to figure out
> if that's something that's worth fixing - but that's probably a topic for a
> separate thread):
> https://git.kernel.org/pub/scm/git/git.git/tree/t/t0000-basic.sh#n1285

It's not the subshell there, but rather that git is on the left-hand
side of a pipe (and so its exit code is discarded). We've been slowly
fixing such cases (the usual technique is to use a tempfile).

> In case anyone is interested: I have been using the following workflow to
> find leaks and verify fixes - I'm running into crashes when using LSAN
> standalone, therefore I'm using full ASAN instead (I'm not particularly
> concerned about this: LSAN standalone mode is known to be less-well tested
> than leak-checking within ASAN [1], and the crashes are occurring within the
> leak-checker itself):

Yeah, I think using ASAN is just fine. I found that LSAN is faster, but
if you are running a single script the difference probably doesn't
matter. I also found that clang's support was much more mature than
gcc's (I don't know how different the state is these days, though).

Regardless, if you can get it to run cleanly with _any_ leak checker,
I'll be quite happy. :)

> make GIT_TEST_OPTS="-i -v" DEFAULT_TEST_TARGET="t0000-basic.sh"
> ASAN_OPTIONS="detect_leaks=1:abort_on_error=1" SANITIZE=address DEVELOPER=1
> CFLAGS="-DSUPPRESS_ANNOTATED_LEAKS -g -fno-optimize-sibling-calls -O1
> -fno-omit-frame-pointer" test

There's some magic in the Makefile for detecting SANITIZE=leak and
setting -DSUPPRESS_ANNOTATED_LEAKS. It might be worth that extending
that to SANITIZE=address, but I guess we wouldn't want to do so for most
builds (which also are setting detect_leaks=0 in the test suite). Maybe
we should have some other name to trigger asan-as-a-leak-detector. Or
maybe that just gets complicated, because we pass the results of
SANITIZE on to the compiler directly.

> (I then rerun the entire test suite with ASAN but with leak-checking
> disabled in order to gain some confidence that my fixes aren't inadvertently
> introducing memory safety issues.)

Definitely a good idea.

> Andrzej Hunt (7):
>   symbolic-ref: don't leak shortened refname in check_symref()
>   reset: free instead of leaking unneeded ref
>   clone: free or UNLEAK further pointers when finished
>   worktree: fix leak in dwim_branch()
>   init: remove git_init_db_config() while fixing leaks
>   init-db: silence template_dir leak when converting to absolute path
>   parse-options: don't leak alias help messages

I haven't looked at the individual patches yet. I'll respond to them
individually.

-Peff
