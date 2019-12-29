Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D20BC2D0C0
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 06:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE567207FF
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 06:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfL2GYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 01:24:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:54878 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725800AbfL2GYP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 01:24:15 -0500
Received: (qmail 20828 invoked by uid 109); 29 Dec 2019 06:24:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 29 Dec 2019 06:24:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5032 invoked by uid 111); 29 Dec 2019 06:29:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2019 01:29:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 29 Dec 2019 01:24:14 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
Message-ID: <20191229062414.GC220034@coredump.intra.peff.net>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <20191222093036.GA3449072@coredump.intra.peff.net>
 <e9a4e4ff-5466-dc39-c3f5-c9a8b8f2f11d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9a4e4ff-5466-dc39-c3f5-c9a8b8f2f11d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 27, 2019 at 11:11:37AM -0500, Derrick Stolee wrote:

> > So here are a few patches to reduce the CPU and memory usage. They could
> > be squashed in at the appropriate spots, or perhaps taken as inspiration
> > if there are better solutions (especially for the first one).
> 
> I tested these patches with the Linux kernel repo and reported my results
> on each patch. However, I wanted to also test on a larger internal repo
> (the AzureDevOps repo), which has ~500 commits with more than 512 changes,
> and generally has larger diffs than the Linux kernel repo.
> 
> | Version  | Time   | Memory |
> |----------|--------|--------|
> | Garima   | 16m36s | 27.0gb |
> | Peff 1   | 6m32s  | 28.0gb |
> | Peff 2   | 6m48s  |  5.6gb |
> | Peff 3   | 6m14s  |  4.5gb |
> | Shortcut | 3m47s  |  4.5gb |
> 
> For reference, I found the time and memory information using
> "/usr/bin/time --verbose" in a bash script.

Thanks for giving it more exercise. My heap profiling was done with
massif, which measures the heap directly. Measuring RSS would cover
that, but will also include the mmap'd packfiles. That's probably why
your linux.git numbers were slightly higher than mine.

(massif is a really great tool if you haven't used it, as it also shows
which allocations were using the memory. But it's part of valgrind, so
it definitely doesn't run on native Windows. It might work under WSL,
though. I'm sure there are also other heap profilers on Windows).

> By "Shortcut" in the table above, I mean the following patch on top of
> Garima's and Peff's changes. It inserts a max_changes option into struct
> diff_options to halt the diff early. This seemed like an easier change
> than creating a new tree diff algorithm wholesale.

Yeah, I'm not opposed to a diff feature like this.

But be careful, because...

> diff --git a/diff.h b/diff.h
> index 6febe7e365..9443dc1b00 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -285,6 +285,11 @@ struct diff_options {
>  	/* Number of hexdigits to abbreviate raw format output to. */
>  	int abbrev;
>  
> +	/* If non-zero, then stop computing after this many changes. */
> +	int max_changes;
> +	/* For internal use only. */
> +	int num_changes;

This is holding internal state in diff_options, but the same
diff_options is often used for multiple diffs (e.g., "git log --raw"
would use the same rev_info.diffopt over and over again).

So it would need to be cleared between diffs. There's a similar feature
in the "has_changes" flag, though it looks like it is cleared manually
by callers. Yuck.

This isn't a problem for commit-graph right now, but:

  - it actually could be using a single diff_options, which would be
    slightly simpler (it doesn't seem to save much CPU, though, because
    the initialization is relatively cheap)

  - it's a bit of a subtle bug to leave hanging around for the next
    person who tries to use the feature

I actually wonder if this could be rolled into the has_changes and
diff_can_quit_early() feature. This really just a generalization of that
feature (which is like setting max_changes to "1").

-Peff
