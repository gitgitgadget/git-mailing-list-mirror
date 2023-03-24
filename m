Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4CDC6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 20:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjCXUpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjCXUpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 16:45:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91727CA20
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:45:07 -0700 (PDT)
Received: (qmail 7193 invoked by uid 109); 24 Mar 2023 20:45:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Mar 2023 20:45:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5700 invoked by uid 111); 24 Mar 2023 20:45:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Mar 2023 16:45:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Mar 2023 16:45:04 -0400
From:   Jeff King <peff@peff.net>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: limiting git branch --contains
Message-ID: <20230324204504.GB549549@coredump.intra.peff.net>
References: <ZBygZbz5E6jVNp3y@ugly>
 <xmqqpm8z8dab.fsf@gitster.g>
 <ZBy6Ku+znv/wuOix@ugly>
 <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
 <ZB3o0seQJVbtPa+j@ugly>
 <85f81579-5876-a573-6d35-88b35ab0f290@github.com>
 <ZB3z3e5G3Lrv9g3Y@ugly>
 <20230324191302.GB536967@coredump.intra.peff.net>
 <ZB4A7+LMY+NSaPYE@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZB4A7+LMY+NSaPYE@ugly>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 08:58:39PM +0100, Oswald Buddenhagen wrote:

> On Fri, Mar 24, 2023 at 03:13:02PM -0400, Jeff King wrote:
> > On Fri, Mar 24, 2023 at 08:02:53PM +0100, Oswald Buddenhagen wrote:
> > > maybe the operation just forgets to load the graph?
> > 
> so i strace'd the thing, and there is indeed no appearance of 'commit-graph'
> in the log.
> 
> so i tried git log --graph ... and still nothing?!

That "--graph" option is unrelated. It asks for Git to draw a graph in
the output. Commit-graph is a fancy name for "a cache file which stores
some metadata about commits so we can quickly answer graph-like queries
such as ancestry, etc".

> so weird in fact, that i tried another repository. and it works!
> 
> so apparently something is wrong with my/the linux repository.
> things i can imagine contributing to throwing it off somehow:
> 
> $ git remote -v
> alsa    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git (fetch)
> alsa    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git (push)
> history git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git (fetch)
> history git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git (push)
> linux-mips      git://git.linux-mips.org/pub/scm/ralf/linux (fetch)
> linux-mips      git://git.linux-mips.org/pub/scm/ralf/linux (push)
> linux-wireless  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers (fetch)
> linux-wireless  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers (push)
> origin  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git (fetch)
> origin  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git (push)
> ossi    git@github.com:ossilator/linux.git (fetch)
> ossi    git@github.com:ossilator/linux.git (push)
> 
> (the linux-* remotes haven't been pulled for years.)
> 
> $ grep replace .git/packed-refs
> a3628e41a9946c4fe93d9b2ae5906e1b2184fa8e refs/replace/1da177e4c3f41524e886b7f1b8a0c1fc7321cac2

Ah, that is your problem. When "replace" refs are in use, the data
stored in the commit-graph can't reliably be used. It is storing
invariants like "commit XYZ is the Nth generation from the root", which
is an immutable property of a commit with a given hash. But as soon as
you use grafts or replace refs, now we don't know if that information is
valid or not (not just for the replaced commit, but for any of its
ancestors which might have been replaced). So the whole thing is
disabled.

I'd guess you are grafting the "history" remote's contents onto the
start of Linus's repo. It's probably better to do that in a one-off
repository, rather than your day-to-day working one. But you can also
flip it off and on at will. Try:

  git -c core.useReplaceRefs=false branch --contains ...

which I think should get faster. And likewise you can set it to "false"
in your config for day-to-day use, and then flip it on when you want to
run a command that you think might query all the way down into ancient
history.

If it does make things faster for you, I'd still be curious to see the
difference between "just commit graphs" and "commit graphs plus the
patch I showed earlier". I think it should make things faster, but if
it's only a few milliseconds on average, it's not that urgent to pursue.

-Peff
