Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8299AC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 19:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3235E22A99
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 19:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbgLPTBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 14:01:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:35236 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732805AbgLPTBO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 14:01:14 -0500
Received: (qmail 24248 invoked by uid 109); 16 Dec 2020 19:00:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Dec 2020 19:00:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 746 invoked by uid 111); 16 Dec 2020 19:00:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Dec 2020 14:00:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Dec 2020 14:00:32 -0500
From:   Jeff King <peff@peff.net>
To:     Daniel Klauer <daniel.c.klauer@web.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, git@vger.kernel.org
Subject: Re: bug report: "git pack-redundant --all" crash in minimize()
Message-ID: <X9pZUELTD9i5TrvQ@coredump.intra.peff.net>
References: <dc410ef1-fc05-162e-ed4e-c843e0bc285d@web.de>
 <X9j+nuzjiYyw/vQx@coredump.intra.peff.net>
 <a46660c3-630c-5573-9ef4-75d273d37767@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a46660c3-630c-5573-9ef4-75d273d37767@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 02:22:52PM +0100, Daniel Klauer wrote:

> Background: bitbake downloads git repositories during a build process
> and supports caching them locally (in form of bare repos in some
> user-defined directory). This prevents having to re-download them during
> the next build, and also it is a convenient mirroring/backup system in
> case the original URLs stop working.
> 
> As far as I can tell (since I'm not a bitbake developer) the git
> pack-redundant invocation is one of multiple calls meant to improve
> storage (probably minimize disk usage) of the locally cached git repos.
> For reference, please take a look at the other git commands it's
> invoking [1], and at the commit messages of the commits that added these
> invocations [2] [3] [4].
> 
> If doing it that way seems wrong, I'll report the issue to bitbake
> upstream too. Maybe there is a better way to do whatever bitbake wants
> to do here?

Thanks for that context.

I don't think it's _wrong_, in the sense that what they want to do
(remove redundant packs) is a reasonable thing to want. But in practice
I suspect that it rarely helps. It only makes sense if a pack is fully
made redundant by other packs. But that is unlikely to happen after a
fetch, because Git tries not to send objects that already exist. So
while there could be overlap, it's unlikely that full packs are
candidates for deletion. And if any are, then that is probably a sign
that fetch is not being given enough information (e.g., if there are
packs being copied into the repo behind the scenes, make sure that there
are matching refs pointing to their objects, so Git knows it has that
part of the object graph).

For saving space, "git repack -ad" is a much better option. It puts
everything reachable into a single pack, which means:

  - if two packs contain duplicates of an object, we'll end up with only
    a single copy, even if those packs also contained some unique
    objects

  - by putting all objects in the same pack, we have more opportunities
    for delta compression between similar objects

  - we'll drop any unreachable objects completely (presumably this is
    desirable here, but if they're trying to keep objects that don't
    have refs pointing at them as part of some caching scheme, they
    might not; passing "-k" will keep the unreachable objects, too)

Since they're doing other maintenance like "pack-refs", then running
"git gc" may be preferable, as it would cover that, too. Use
"--prune=now" to drop the unreachable objects immediately (as opposed to
giving them a 2-week grace period). Note that there's no equivalent to
repack's "-k" from git-gc", so if they need that, they'll have to invoke
git-repack directly.

-Peff
