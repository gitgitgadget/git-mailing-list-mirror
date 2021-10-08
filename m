Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1789DC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEB360F57
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbhJHT7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:59:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:36100 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241464AbhJHT7J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:59:09 -0400
Received: (qmail 6152 invoked by uid 109); 8 Oct 2021 19:57:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 19:57:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16460 invoked by uid 111); 8 Oct 2021 19:57:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Oct 2021 15:57:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Oct 2021 15:57:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] t/perf/perf-lib.sh: remove test_times.* at the end
 test_perf_()
Message-ID: <YWCilnNa2eAakoX0@coredump.intra.peff.net>
References: <pull.1051.git.1633386543759.gitgitgadget@gmail.com>
 <YVyPH59LpxFLHep0@nand.local>
 <YV3314Dnhj7srFZ4@coredump.intra.peff.net>
 <3f03ed89-d3db-32ba-3c1f-b8fac7cfb097@jeffhostetler.com>
 <YV+zFqi4VmBVJYex@coredump.intra.peff.net>
 <xmqqee8vl90e.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqee8vl90e.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 08, 2021 at 10:30:09AM -0700, Junio C Hamano wrote:

> > There are cases it doesn't help, though. For instance, in one of the
> > scripts we measure the time to run "git repack -adb" to generate
> > bitmaps. But the first run has to do more work, because we can reuse
> > results for subsequent ones! It would help to "rm -f
> > objects/pack/*.bitmap", but even that's not entirely fair, as it will be
> > repacking from a single pack, versus whatever state we started with.
> 
> You need a "do this too for each iteration but do not time it", i.e.
> 
>     test_perf 'repack performance' --prepare '
> 	make a messy original repository
>     ' --per-iteration-prepare '
> 	prepare a test repository from the messy original
>     ' --time-this-part-only '
>         git repack -adb
>     '
> 
> Syntactically, eh, Yuck.

If any step doesn't need to be per-iteration, you can do it in a
separate test_expect_success block. So --prepare would always be
per-iteration, I think.

The tricky thing I meant to highlight in that example is that the
preparation step is non-obvious, since the timed command actually throws
away the original state. But we can probably stash away what we need.
With the test_perf_prepare I showed earlier, maybe:

  test_expect_success 'stash original state' '
	cp -al objects objects.orig
  '

  test_perf_prepare 'set up original state' '
	rm -rf objects &&
	cp -al objects.orig objects
  '

  test_perf 'repack' '
	git repack -adb
  '

which is not too bad. Of course it is made a lot easier by my use of the
unportable "cp -l", but you get the general idea. ;) This is all a rough
sketch anyway, and not something I plan on working on anytime soon.

For Jeff's case, the preparation would hopefully just be some sequence
of reset/read-tree/etc to manipulate the index and working tree to the
original state.

-Peff
