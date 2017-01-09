Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57EE3205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 06:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757828AbdAIGVl (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 01:21:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:36838 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753484AbdAIGVk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 01:21:40 -0500
Received: (qmail 19356 invoked by uid 109); 9 Jan 2017 06:21:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 06:21:41 +0000
Received: (qmail 1501 invoked by uid 111); 9 Jan 2017 06:22:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 01:22:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jan 2017 01:21:37 -0500
Date:   Mon, 9 Jan 2017 01:21:37 -0500
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     repo-discuss@googlegroups.com, jmelvin@codeaurora.org,
        jgit-dev@eclipse.org, git@vger.kernel.org
Subject: Re: Preserve/Prune Old Pack Files
Message-ID: <20170109062137.zghmurndlbts5x44@sigill.intra.peff.net>
References: <24abd0ed58c25ce832014f9bd5bb2090@codeaurora.org>
 <5172470.bsscxDU4yv@mfick1-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5172470.bsscxDU4yv@mfick1-lnx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 04, 2017 at 09:11:55AM -0700, Martin Fick wrote:

> I am replying to this email across lists because I wanted to 
> highlight to the git community this jgit change to repacking 
> that we have up for review
> 
>  https://git.eclipse.org/r/#/c/87969/
> 
> This change introduces a new convention for how to preserve 
> old pack files in a staging area 
> (.git/objects/packs/preserved) before deleting them.  I 
> wanted to ensure that the new proposed convention would be 
> done in a way that would be satisfactory to the git 
> community as a whole so that it would be more easy to 
> provide the same behavior in git eventually.  The preserved 
> pack files (and accompanying index and bitmap files), are not 
> only moved, but they are also renamed so that they no longer 
> will match recursive finds looking for pack files.

It looks like objects/pack/pack-123.pack becomes
objects/pack/preserved/pack-123.old-pack, and so forth.
Which seems reasonable, and I'm happy that:

  find objects/pack -name '*.pack'

would not find it. :)

I suspect the name-change will break a few tools that you might want to
use to look at a preserved pack (like verify-pack). I know that's not
your primary use case, but it seems plausible that somebody may one day
want to use a preserved pack to try to recover from corruption. I think
"git index-pack --stdin <objects/packs/preserved/pack-123.old-pack"
could always be a last-resort for re-admitting the objects to the
repository.

I notice this doesn't do anything for loose objects. I think they
technically suffer the same issue, though the race window is much
shorter (we mmap them and zlib inflate immediately, whereas packfiles
may stay mapped across many object requests).

I have one other thought that's tangentially related.

I've wondered if we could make object pruning more atomic by
speculatively moving items to be deleted into some kind of "outgoing"
object area. Right now you can have a case like:

  0. We have a pack that has commit X, which is reachable, and commit Y,
     which is not.

  1. Process A is repacking. It walks the object graph and finds that X
     is reachable. It begins creating a new pack with X and its
     dependent objects.

  2. Meanwhile, process B pushes up a merge of X and Y, and updates a
     ref to point to it.

  3. Process A finishes writing the new pack, and deletes the old one,
     removing Y. The repository is now corrupt.

I don't have a solution here.  I don't think we want to solve it by
locking the repository for updates during a repack. I have a vague sense
that a solution could be crafted around moving the old pack into a
holding area instead of deleting (during which time nobody else would
see the objects, and thus not reference them), while the repacking
process checks to see if the actual deletion would break any references
(and rolls back the deletion if it would).

That's _way_ more complicated than your problem, and as I said, I do not
have a finished solution. But it seems like they touch on a similar
concept (a post-delete holding area for objects). So I thought I'd
mention it in case if spurs any brilliance.

-Peff
