Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8023C5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE7722227
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKLSka (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 13:40:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:56214 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgKLSk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 13:40:28 -0500
Received: (qmail 21698 invoked by uid 109); 12 Nov 2020 18:40:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Nov 2020 18:40:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 422 invoked by uid 111); 12 Nov 2020 18:40:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Nov 2020 13:40:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Nov 2020 13:40:26 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 00/11] Fix color handling in git add -i
Message-ID: <20201112184026.GB701197@coredump.intra.peff.net>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
 <20201111184527.GD9902@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011121504110.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2011121504110.18437@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 03:20:38PM +0100, Johannes Schindelin wrote:

> >   $ git -c interactive.difffilter='diff-so-fancy' add -p
> >   ──────────────────────────────────────────────────────────────────────
> >   modified: file
> >   ──────────────────────────────────────────────────────────────────────
> >   @ file:1 @
> >   old
> >   new
> >   (1/1) Stage this hunk [y,n,q,a,d,e,?]?
> 
> It might _seem_ that it works. But try to split a hunk. I did this with
> the test case (interrupting it just before running `add -p`):

Yes, there are definitely problems with how diff-so-fancy represents
things (because they don't maintain a 1-to-1 correspondence). You should
generally get a complaint like:

  $ git -c interactive.difffilter='diff-so-fancy' add -p
  fatal: mismatched output from interactive.diffFilter
  hint: Your filter must maintain a one-to-one correspondence
  hint: between its input and output lines.

The diff-so-fancy folks have asked me about this, and I've made clear
the problem to them, and that the solution is to have a mode which
maintains the line correspondence. AFAIK there's no fix yet. I don't
know how many people are actually using it in practice in its current
buggy state.

There's a big thread here:

  https://github.com/so-fancy/diff-so-fancy/issues/35

I don't really recommend reading the whole thing. Beyond what I just
said, the interesting bits are:

  - people recommend using the "delta" tool; it has a "--color-only"
    option which does just diff-highlight-style coloring, but doesn't
    break line correspondence

  - somebody suggested instead of using interactive.difffilter, to add
    an option to show each hunk in an individual pager command. So
    add-interactive would never see the "fancy" version at all, but it
    would be generated on the fly when the user sees it (and that filter
    would have to be able to handle seeing individual hunks without the
    diff header).

All of which is to say that the current state is a bit of a mess, and I
don't consider it completely necessary to fix it before the builtin
version becomes the default. But:

  - I think we should expect some possible complaints / bug reports
    from fringe users of the already-somewhat-broken state

  - IMHO the parsing of the filtered version done by the builtin is
    going in the wrong direction (see my other mail for an elaboration)

> > While it may touch on some of the coloring code, it's otherwise
> > orthogonal to the fixes here. And while the fix is likely to be to make
> > render_hunk() stop re-coloring in the non-edit cases, your more-robust
> > test here will still be checking what you expect (because it really is
> > triggering the edit case, not relying on the extra coloring to see the
> > effect of in-process color config).
> 
> I don't actually think that we _can_ stop re-coloring the hunk header in
> the general case because we need to keep this working even for split
> hunks. It would be a very bad idea to make it work for non-split cases and
> then something like `die()` only when the hunk is split. Better re-color
> all of them, then, to not even risk that situation.

Yeah, obviously calling die() in the split case is bad. And the fact
that newly-created split hunk headers are not filtered the same way as
the original hunk headers isn't ideal. But it's a pretty easy fix in the
perl version, and not in the builtin version.

-Peff
