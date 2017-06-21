Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55EAA20401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbdFUSGc (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:06:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:47714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752652AbdFUSGb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:06:31 -0400
Received: (qmail 1490 invoked by uid 109); 21 Jun 2017 18:06:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Jun 2017 18:06:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25834 invoked by uid 111); 21 Jun 2017 18:06:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jun 2017 14:06:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jun 2017 14:06:18 -0400
Date:   Wed, 21 Jun 2017 14:06:18 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     David Turner <dturner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: update 64-bit core.packedGitLimit default
Message-ID: <20170621180618.6yc433nwpi4d5wof@sigill.intra.peff.net>
References: <20170420204118.17856-1-dturner@twosigma.com>
 <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net>
 <20170621135130.6724hnoovcjfduto@sigill.intra.peff.net>
 <CAGZ79kZLcNdN0TsrHwm8YoAXx7tjWoWV29j=xyQFgUuNPouUOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZLcNdN0TsrHwm8YoAXx7tjWoWV29j=xyQFgUuNPouUOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 09:25:09AM -0700, Stefan Beller wrote:

> > -Default is 256 MiB on 32 bit platforms and 8 GiB on 64 bit platforms.
> > +Default is 256 MiB on 32 bit platforms and 32 TiB (effectively
> > +unlimited) on 64 bit platforms.
>
> nit: I would have not written "effectively unlimited", as we state
> the limit right here. The further sentences already sooth the
> user to not worry to much:
>
>     This should be reasonable for all users/operating systems,
>     except on the largest projects.  You probably do not need to
>     adjust this value.

I actually thought about taking it the other way, and simply saying "and
unlimited on 64 bit platforms". That's not technically true, of course.
You're limited by size_t and how much address space the OS will give
you. But unless you have petabyte repositories, you'd never know.

> But as we just adjusted the default to prevent a bug,
> maybe there are good reasons to adjust the value for users,
> too? (Specifically 32 bit platforms could run into the problem
> that the commit be4ca2905 (Increase core.packedGitLimit,
> 2017-04-20) states.)

No, there's really not a good reason to adjust it. If you're on 32-bit,
you almost certainly can't increase it to avoid the issue[1]. You could
bump it to say 512MB or even 1GB, and if your repository happens to be
smaller than that, it would help. But then you may also hit the
problem of running out of contiguous address space. In which case mmap
fails and you are much worse off than you otherwise would have been. The
exact value that's reasonable is going to to depend on things like how
much address space the kernel gives you, how much space other libraries
take up, how your libc allocates, etc. There's some discussion in the
thread around [2].

But in the end, I think the answer is "don't host a busy site full of
large repositories on a 32-bit system. It's 2017, for goodness' sake".

[1] I wouldn't call it a bug exactly; just an unfortunate interaction
    between two simultaneous processes.

[2] http://public-inbox.org/git/Pine.LNX.4.64.0612240126380.3671@woody.osdl.org/

> While I think this patch is worthwhile applying (even as-is),
> I think we might want to put another patch here?
> Or is there a way to fix the underlying issue when fetch and
> repack is run at the same time?

Before I remembered that we had already applied David's patch, I wrote
up a really long commit message for my own version. Let me quote a bit
from it, because it sets up some context for talking about solutions:

    In general, Git is resilient to the object database being
    repacked. If we fail to find an object, we re-scan the pack
    directory to pick the newly written pack.  The one exception
    is pack-objects, which records certain details of each
    objects (such as its exact pack location and delta format)
    and uses that during the final write phase. If a repack
    occurs while we're serving a fetch, the fetch may die with
    "packfile is invalid".

    We dealt with this somewhat in 4c0801820 (pack-objects:
    protect against disappearing packs, 2011-10-14), which
    doesn't commit to the use of a pack until we've opened and
    mmap'd the packfile. But that still leaves a loophole: we
    sometimes close and unmap packs if we hit certain limits.

    The rules are basically:

      1. If we open a pack bigger than our mmap window size
         (defined by core.packedGitWindowSize), we keep the
         descriptor open to make further maps.

      2. If we open a small pack, we mmap the whole thing and
         close the descriptor. This prevents us consuming too
         many descriptors if you have a lot of small packs.

      3. If we hit our descriptor limit (determined internally
         by getrlimit), we look for an open pack to close.

      4. If we hit our memory limit (defined by
         core.packedGitLimit), we close mmap windows until
         we're under the limit.

    As long as we have a reasonable number of packs (compared to
    the available descriptors), we won't close any descriptors
    according to (3). If we bump against the packedGitLimit in
    (4) and we close a large pack from (1), we're also OK; we
    retain the descriptor and can mmap again later. But if we
    hit the limit in (4) and close a small pack from (2), we'll
    have to re-open the pack, which may fail if it was repacked.

So the other direction, instead of avoiding the memory limit in (4), is
to stop closing "small" packs in (2). But I don't think that's a good
idea. Even with the code after David's patch, you can still trigger the
problem by running out of file descriptors. And if we stop closing
small packs, that makes it even more likely for that to happen.

-Peff
