Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BA1C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 09:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjCIJVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 04:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjCIJVD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 04:21:03 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7DD77CB1
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 01:20:54 -0800 (PST)
Received: (qmail 7734 invoked by uid 109); 9 Mar 2023 09:20:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 09:20:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29329 invoked by uid 111); 9 Mar 2023 09:20:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 04:20:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 04:20:53 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/8] ahead-behind: new builtin for counting multiple
 commit ranges
Message-ID: <ZAmk9V54c/jIbJ65@coredump.intra.peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <xmqqedq1ag8d.fsf@gitster.g>
 <ZAaHB7XTz8HX75LD@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAaHB7XTz8HX75LD@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 07:36:23PM -0500, Taylor Blau wrote:

> > This makes readers wonder if "git rev-list --count B...C" should be
> > the end-user facing UI for this new feature, perhaps?
> >
> > Of course if you are checking how C0, C1, C2,... relate to a single
> > B, the existing rev-list syntax would not work, and makes a totally
> > new subcommand a possibilty.
> 
> Yeah. You could imagine that `rev-list --count` might do something
> fancy like coalescing
> 
>     git rev-list --count B...C1 B...C2 B...C3
> 
> into a single walk. But I am not sure that just because `rev-list
> --count` provides similar functionality that we should fold in the
> proposed `ahead-behind` interface into that flag.

It does coalesce all of that into a single walk. The problem is somewhat
the opposite: it only has a notion of two "sides" for a symmetric
traversal: left and right. But in your example there are many sides, and
we have to remember which is which.

I think getting the answer from one walk would require an arbitrary
number of bits to paint down each path. Certainly the ahead-behind that
Vicent and I wrote long ago didn't do that (IIRC it mostly relied on
doing multiple traversals in the same process, which amortized the cost
of commit parsing; that's not really an issue these days with commit
graphs).

Peeking at patch 7 of Stolee's series...yep. That's exactly what it
does. :)

I wondered how much it would matter on top of a naive loop of
single-traversals, now that we have commit graphs. It looks like there's
still quite a nice speedup from the numbers in patch 7 (though the
totally naive "loop of rev-list" is incurring extra startup overhead,
too).

> My personal feeling is that we ought to avoid (further) overloading
> `rev-list` absent of a compelling reason to do so. But I am definitely
> open to other thoughts here.

So I think this actually is what "git rev-list --left-right --count
old...new" does now. But extending it to multiple sets in one traversal
means you need:

  - being able to ask for individual left-right markers for each pair,
    not treating all lefts and all rights together

  - don't stop traversing when you hit an UNINTERESTING commit if there
    are still bits to paint. In a single-pair traversal, those two are
    the same thing (we stop at the merge base), but with multiple pairs
    you may have to keep walking past a commit that is excluded from one
    pair, but not another. This _might_ be doable if you assume all of
    the left-hand bases are the same, but I didn't think hard enough to
    feel confident in that. But even so, that only solves cases like
    "how do these branches compare to HEAD" (which I think is what
    GitHub does). But it doesn't allow "how do these branches compare to
    to their respective @{upstream} refs".

So I don't think it would be impossible to make this a mode of rev-list.
And that mode might even provide flexibility for other similar
operations, like a mass "git rev-list --cherry-mark"[1]. But it is a
pretty big departure from the current rev-list traversal (to my mind,
especially the "keep walking past UNINTERESTING part). I don't mind it
as its own command.

-Peff

[1] The reason you might want a mass cherry-mark is basically doing
    something like the "branches" page, but in a workflow where upstream
    applies patches, like git.git. There you may want to ask about
    "origin/next...$branch" for all of your branches to see which ones
    have been merged where.
