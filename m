Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162E0C7113B
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 20:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243600AbjHXUuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243646AbjHXUuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 16:50:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CFC1BE2
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 13:50:10 -0700 (PDT)
Received: (qmail 16352 invoked by uid 109); 24 Aug 2023 20:50:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Aug 2023 20:50:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22407 invoked by uid 111); 24 Aug 2023 20:50:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Aug 2023 16:50:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Aug 2023 16:50:09 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/3] leak tests: mark remaining tests leak-free as such
Message-ID: <20230824205009.GA1516@coredump.intra.peff.net>
References: <cover.1692902414.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692902414.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2023 at 02:40:34PM -0400, Taylor Blau wrote:

> While working on another topic that cleared up some leaks, I wanted to
> see if any new tests became leak-free, so I ran:
> 
>     $ make SANITIZE=leak
>     $ make GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_OPTS=-i test

Is that exactly what you ran? Because I'd expect the second "make"
invocation to rebuild Git _without_ SANITIZE=leak enabled in that case.
(Though I would have then expected most of the scripts to complain
loudly about the mismatch; did you "cd t" in between the two?).

>  t/t3321-notes-stripspace.sh | 1 +
>  t/t5571-pre-push-hook.sh    | 1 +
>  t/t5583-push-branches.sh    | 1 +
>  t/t7516-commit-races.sh     | 2 ++
>  4 files changed, 5 insertions(+)

If I run a single:

  make SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_OPTS=-i test

on v2.42.0, I get many hits. All of the ones you mentioned, plus:

  t7408 t5407 t7008 t5811 t3407 t6001 t4058 t2016

If I run a few by hand, I _do_ see leaks in them, but the exit codes are
hidden from the test suite (they are sub-programs of scripts, etc). I
guess you also have:

  GIT_TEST_SANITIZE_LEAK_LOG=true

set, which should find those (and which you mention in your first
commit). Turning that on eliminates some of them, but I'm left with:

  t5614 t5317 t5503

not in your list. Which is super weird, because t5614 is marked with
TEST_PASSES_SANITIZE_LEAK. Hrm. And if I run it again, I get a
_different_ set (t5614 again, along with your 4, but also t5303, t7701,
and t4050). I wonder if we have a race in the leak-log code or
something (I'm running under prove with -j32, naturally).

> This series marks all leak-free tests as such, meaning that the above
> "make test" invocation will pass after this series. The bulk of the
> tests which are marked here in the first patch were always
> leak-free[^1]. The remaining two patches address a couple of special
> cases of tests which are also leak-free.

Hmm. If I check t5571, for example, by bisecting on:

  make SANITIZE=leak && (cd t && ./t5571-pre-push-hook.sh -v -i)

it shows that it was fixed by 861c56f6f9 (branch: fix a leak in
setup_tracking, 2023-06-11), which make sense. There are a bunch of leak
fixes in the same series, which makes me wonder if they're responsible
for most of these.

If the leaks are gone, I am happy that we are marking them. But it is
weird to me that we are getting different results.

-Peff
