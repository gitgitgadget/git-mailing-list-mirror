Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B85C33C9E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 02:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3FD20720
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 02:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgA2CX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:23:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:47032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726442AbgA2CXz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 21:23:55 -0500
Received: (qmail 13114 invoked by uid 109); 29 Jan 2020 02:23:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 02:23:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12881 invoked by uid 111); 29 Jan 2020 02:31:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jan 2020 21:31:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jan 2020 21:23:54 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Jerdonek <chris.jerdonek@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-clone --single-branch clones objects outside of branch
Message-ID: <20200129022354.GA596285@coredump.intra.peff.net>
References: <CAOTb1wfoMf338VPRYcjAv+EaMYQxKJ=kP6-qMykG-LfxPrWuag@mail.gmail.com>
 <20200127055509.GA12108@coredump.intra.peff.net>
 <CAOTb1wd9D3YytevTt0cGnw1o-9cN1-yxCqbuH4oLH1KB6mzEeA@mail.gmail.com>
 <20200128094801.GC574544@coredump.intra.peff.net>
 <CAOTb1wecnwXrOqJa-dq1zyS1ydgQ-c_b_GX7FkWzJPtGk6xL3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOTb1wecnwXrOqJa-dq1zyS1ydgQ-c_b_GX7FkWzJPtGk6xL3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 05:59:54PM -0800, Chris Jerdonek wrote:

> > No, "--reference" behaves as usual.
> 
> On this, I found that --reference does behave differently in the way
> that I suspected. For example, when run with the default --local, I
> found that git-clone will create hard links in the new repo to loose
> objects, even if those objects already exist in the reference
> repository. When run with --non-local, the objects in the reference
> repository weren't copied (I didn't find them in the cloned repo's
> pack file).

Sure, but I'd just consider that the same issue: hardlinking takes
everything in the object database without regard to what's needed. So
--reference still works (and when you repack and break the hardlinks, it
will drop any duplicates as usual), but obviously you have access to the
extra hardlinked objects in the meantime.

IOW, I don't think it's worth calling this out in the --reference
documentation, but could be in the --local documentation. Because the
unusual implication is the same whether --reference is used or not.

> So in addition to --single-branch, this seems to be another case where
> `git-clone --local` will ignore the provided options when deciding
> what files inside .git/objects/ to hard-link. It just hard-links
> everything. This is another example of something that I think would be
> worth mentioning in the docs in some form. Currently, the
> documentation for --reference suggests that objects won't be created
> in the new repo if they already exist in the reference repository.

It says:

  Using an already existing repository as an alternate will require
  fewer objects to be copied from the repository being cloned, reducing
  network and local storage costs.

which I think is still technically true. The hardlinks are free in terms
of storage (and there's no network cost by definition). So at worst
--reference is doing nothing to start with. And the repository has been
setup in such a way that it may yield benefits later (after you repack
and the hardlinks are broken).

This is maybe splitting hairs a bit. The thing that matters, I think, is
where a documentation change should go (and what it should say).

-Peff
