Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE2CC33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 07:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37302465B
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 07:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgA1HwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:52:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:46072 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725810AbgA1HwP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 02:52:15 -0500
Received: (qmail 7538 invoked by uid 109); 28 Jan 2020 07:52:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Jan 2020 07:52:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5148 invoked by uid 111); 28 Jan 2020 07:59:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jan 2020 02:59:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jan 2020 02:52:14 -0500
From:   Jeff King <peff@peff.net>
To:     Jack Bates via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jack Bates <jack@nottheoilrig.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] diff-highlight: highlight range-diff
Message-ID: <20200128075214.GB564804@coredump.intra.peff.net>
References: <pull.684.git.git.1577634590.gitgitgadget@gmail.com>
 <547b3087ac2e8e05af86b4b9972cef8c20da1cdf.1577634590.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <547b3087ac2e8e05af86b4b9972cef8c20da1cdf.1577634590.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 29, 2019 at 03:49:50PM +0000, Jack Bates via GitGitGadget wrote:

> From: Jack Bates <jack@nottheoilrig.com>
> 
> Piping `git range-diff` through diff-highlight currently has no effect,
> for two reasons:

Sorry for the slow review; this got overlooked over the holidays.

>   1. There are ANSI escapes before and after the `@@` hunk headers (when
>      color is enabled) which diff-highlight fails to match. One solution
>      is to match both escapes (`/^$COLOR*\@\@$COLOR* /`). This patch
>      drops the trailing space from the existing pattern instead.

Hmm. Matching $COLOR on either side would be stricter. In particular,
with your patch I think we'd match "@@@", undoing 3dbfe2b8ae
(diff-highlight: avoid highlighting combined diffs, 2016-08-31).

>   2. Unlike `git log`, `git range-diff` diffs are indented, which
>      diff-highlight also fails to match. This patch allows hunk headers
>      preceded by any amount of whitespace, and then skips past that
>      indentation when parsing subsequent lines, by reusing the machinery
>      that handles the --graph output.

This also means we'd start trying to highlight diffs that are inside
commit messages. That might not be the end of the world.

You can see some examples in git.git by doing:

  git log | /path/to/original/diff-highlight >old
  git log | /path/to/your/new/diff-highlight >new
  diff -u old new

> diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
> index e2589922a6..74f53e53c9 100644
> --- a/contrib/diff-highlight/DiffHighlight.pm
> +++ b/contrib/diff-highlight/DiffHighlight.pm
> @@ -90,7 +90,8 @@ sub handle_line {
>  
>  	if (!$in_hunk) {
>  		$line_cb->($orig);
> -		$in_hunk = /^$COLOR*\@\@ /;
> +		$in_hunk = /^( *)$COLOR*\@\@/;

There's a similar regex a few lines below to decide of we should remain
in a hunk. Would you need to modify that, too?

> +		$graph_indent = length($1);

This throws away the existing $graph_indent. I know we wouldn't have a
range-diff mixed with a graph, but I think it breaks normal graph usage.
At least "make test" in contrib/diff-highlight seems to complain, and
adding "--graph -p" to the "git log" invocations above shows that we're
not highlighting a bunch of cases (perhaps all?).

-Peff
