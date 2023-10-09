Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C83FCD612F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 20:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378591AbjJIUVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 16:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjJIUVw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 16:21:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD5694
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 13:21:51 -0700 (PDT)
Received: (qmail 24037 invoked by uid 109); 9 Oct 2023 20:21:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 20:21:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18101 invoked by uid 111); 9 Oct 2023 20:21:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 16:21:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 16:21:49 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@gmail.com>
Subject: Re: [PATCH 7/7] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <20231009202149.GA3281325@coredump.intra.peff.net>
References: <cover.1696629697.git.me@ttaylorr.com>
 <e96921014557edb41dd73d93a8c3cf6cfaf0c719.1696629697.git.me@ttaylorr.com>
 <xmqqil7j751u.fsf@gitster.g>
 <ZSCR7e6KKqFv8mZk@nand.local>
 <CABPp-BE+mJ4e==fWNqUNi5RVkoui_xeZN+axnM6vBykDqAzHiA@mail.gmail.com>
 <ZSLS9G1lHruig48a@nand.local>
 <20231008173329.GA1557002@coredump.intra.peff.net>
 <ZSNZZrWyCqRH+0Bd@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSNZZrWyCqRH+0Bd@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2023 at 09:37:42PM -0400, Taylor Blau wrote:

> Very interesting, thanks for running (and documenting!) this experiment.
> I'm mostly with you that it probably doesn't make a huge difference in
> practice here.
> 
> One thing that I'm not entirely clear on is how we'd treat objects that
> could be good delta candidates for each other between two packs. For
> instance, if I write a tree corresponding to the merge between two
> branches, it's likely that the resulting tree would be a good delta
> candidate against either of the trees at the tips of those two refs.
> 
> But we won't pack those trees (the ones at the tips of the refs) in the
> same pack as the tree containing their merge. If we later on tried to
> repack, would we evaluate the tip trees as possible delta candidates
> against the merged tree? Or would we look at the merged tree, realize it
> isn't delta'd with anything, and then not attempt to find any
> candidates?

When we repack (either all-into-one, or in a geometric roll-up), we
should consider those trees as candidates. The only deltas we don't
consider are:

  - if something is already a delta in a pack, then we will usually
    reuse that delta verbatim (so you might get fooled by a mediocre
    delta and not go to the trouble to search again. But I don't think
    that applies here; there is no other tree in your new pack to make
    such a mediocre delta from, and anyway you are skipping deltas
    entirely)

  - if two objects are in the same pack but there's no delta
    relationship, the try_delta() heuristics will skip them immediately
    (under the assumption that we tried during the last repack and
    didn't find anything good).

So yes, if you had a big old pack with the original trees, and then a
new pack with the merge result, we should try to delta the new merge
result tree against the others, just as we would if it were loose.

> > I was going to suggest the same thing. ;) Unfortunately it's a bit
> > tricky to do as we have no room in the file format for an optional flag.
> > You'd have to add a ".mediocre-delta" file or something.
> 
> Yeah, I figured that we'd add a new ".baddeltas" file or something. (As
> an aside, we probably should have an optional flags section in the .pack
> format, since we seem to have a lot of optional pack extensions: .rev,
> .bitmap, .keep, .promisor, etc.)

Yes, though since packv2 is the on-the-wire format, it's very hard to
change now. It might be easier to put an annotation into the .idx file.

-Peff
