Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495E71F462
	for <e@80x24.org>; Thu, 30 May 2019 11:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfE3Lz5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 07:55:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:42174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726792AbfE3Lz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 07:55:57 -0400
Received: (qmail 936 invoked by uid 109); 30 May 2019 11:55:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 May 2019 11:55:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3979 invoked by uid 111); 30 May 2019 11:56:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 May 2019 07:56:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 May 2019 07:55:55 -0400
Date:   Thu, 30 May 2019 07:55:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
Subject: Re: git archive generates tar with malformed pax extended attribute
Message-ID: <20190530115554.GB31607@sigill.intra.peff.net>
References: <20190524070644.GF25694@sigill.intra.peff.net>
 <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
 <20190524081337.GA9082@sigill.intra.peff.net>
 <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
 <20190528055805.GB7946@sigill.intra.peff.net>
 <5b312f6c-3375-66ba-efc7-931e4ddc4b11@web.de>
 <20190528190815.GA20499@sigill.intra.peff.net>
 <5f9ac691-4cb1-a15d-ca44-63fb64994d59@web.de>
 <20190529011744.GA22340@sigill.intra.peff.net>
 <24574d74-b6ca-6d36-759f-32cf26b36c3f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24574d74-b6ca-6d36-759f-32cf26b36c3f@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 29, 2019 at 07:54:44PM +0200, René Scharfe wrote:

> Am 29.05.19 um 03:17 schrieb Jeff King:
> > On Wed, May 29, 2019 at 01:34:32AM +0200, René Scharfe wrote:
> >> Parsing trees with symlinks twice is not ideal, but keeps the set
> >> structure simple -- a standard oidset suffices.
> >
> > If blobs comes after trees (and they usually do in a pack), you can do
> > it in a single pass by marking the blob as a symlink target, and then
> > when we actually see that blob's contents, marking it as either OK or
> > problematic. And then the finish() step just correlates those with the
> > tree.
> 
> Good idea.  Is that ordering guaranteed?  (Stumbling about the "usually"
> in your first sentence.)

It's not guaranteed. Our implementation of pack-objects does order blobs
after trees, but I suspect this could be violated in rare cases with
some of the delta-island pack layering stuff.

I think it makes sense to be sure that the receiver is correct no matter
what, but optimize for this expected case (that's what I tried to do
with the .gitmodules checks).

> An ordering where dependent objects (like trees) follow the objects they
> reference would be better suited for these kinds of checks..

But worse for others (e.g., like .gitmodules where it's cheap to
identify a candidate blob, but the blob check is involved; there it's
much more optimal to see the tree first).

> > But here the problem is in the tree, not the blob. So we're not finding
> > suspect blobs, but rather re-checking each tree. And no matter what we
> > do (whether it's visiting the object again, or creating a set or mapping
> > with the object names) is going to be linear there. And a repository
> > with a symlink in the root tree is going to revisit or put in our
> > mapping every single root tree.
> 
> That's true, potentially it needs remember and/or reprocess all trees,
> meaning this check may double the run time of fsck in the worst case.
> Example from the wild: The kernel repo currently has 36 symlinks and
> 6+ million objects are checked in total, and the symlink check processes
> 18943 trees_with_symlinks entries there.

That sounds about right. It's basically every version of every tree that
has a symlink. Did it make a noticeable difference in timing? Indexing
the whole kernel history is already a horribly slow process. :)

> > TBH, I'm not sure this fsck check was worth it even without the
> > implementation complexity.
> 
> Hmm.  git status reports such truncated symlinks as changed, so the
> issue *is* already detectable.

Hmm, yeah. That makes sense, since the filesystem (well, really the
syscall API layer) cannot represent the data we are feeding it.

-Peff
