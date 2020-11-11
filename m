Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5698C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1D1206FB
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKKSp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 13:45:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:54794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgKKSp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 13:45:28 -0500
Received: (qmail 13744 invoked by uid 109); 11 Nov 2020 18:45:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Nov 2020 18:45:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18013 invoked by uid 111); 11 Nov 2020 18:45:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Nov 2020 13:45:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Nov 2020 13:45:27 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/11] Fix color handling in git add -i
Message-ID: <20201111184527.GD9902@coredump.intra.peff.net>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 12:28:13PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Changes since v1:
> 
>  * The regression test now actually exercises the re-coloring (that is the
>    primary purpose of git add -p looking at the color.diff.* variables).
>  * The way the built-in git add -p renders hunk headers of split hunks was
>    aligned with how the Perl version does things.
>  * We now consistently prefer color.diff.context over color.diff.plain, no
>    matter whether using the Perl or the built-in version of git add -p.
>  * The commit message for the regression test no longer confuses readers by
>    mentioning dash.
>  * The regression test was structured a bit better, first testing error
>    message coloring, then the menu in git add -i and then the diff coloring
>    in git add -p.

The changes were less scary than I was led to believe after reading your
earlier response. :)

Everything here looks sensible. As I said elsewhere, I do worry there
may be a lingering issue with how parse_diff() looks at the filtered
diffs. Let me see if I can get diff-so-fancy working...

Aha, yes. I think using diff-so-fancy here isn't entirely robust,
because it has some cases where it fails at the 1-to-1 line
correspondence, but they're aware of the issue. But it does work in
simples cases now (there's some coloring which makes the output more
meaningful, but I obviously won't paste it here):

  $ git -c interactive.difffilter='diff-so-fancy' add -p
  ──────────────────────────────────────────────────────────────────────
  modified: file
  ──────────────────────────────────────────────────────────────────────
  @ file:1 @
  old
  new
  (1/1) Stage this hunk [y,n,q,a,d,e,?]? 

But with the builtin:

  $ git -c interactive.difffilter='diff-so-fancy' \
        -c add.interactive.usebuiltin=true \
	add -p
  error: could not parse colored hunk header '?[1m?[38;5;1m?[31mold?[m'

I don't use it myself, and as I said, I think they have some fixes to
make for it to be robust as a diff-filter. But I suspect this may be a
problem once the builtin version becomes the default.

I don't think it should be dealt with in this patch series, though.
While it may touch on some of the coloring code, it's otherwise
orthogonal to the fixes here. And while the fix is likely to be to make
render_hunk() stop re-coloring in the non-edit cases, your more-robust
test here will still be checking what you expect (because it really is
triggering the edit case, not relying on the extra coloring to see the
effect of in-process color config).

-Peff
