Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A423DC432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 22:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A42053B
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 22:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfLCWRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:17:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:37828 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727575AbfLCWRc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 17:17:32 -0500
Received: (qmail 17561 invoked by uid 109); 3 Dec 2019 22:17:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Dec 2019 22:17:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20050 invoked by uid 111); 3 Dec 2019 22:21:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Dec 2019 17:21:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Dec 2019 17:17:30 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Colin Stolley <cstolley@runbox.com>, git@vger.kernel.org
Subject: Re: [PATCH] packfile.c: speed up loading lots of packfiles.
Message-ID: <20191203221730.GA28419@sigill.intra.peff.net>
References: <20191127222453.GA3765@owl.colinstolley.com>
 <20191202174035.GJ23183@szeder.dev>
 <20191202194231.GA10707@sigill.intra.peff.net>
 <xmqq7e3d75vk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e3d75vk.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 03, 2019 at 08:04:15AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Good catch. The issue is that we only add entries to the hashmap in
> > prepare_packed_git(), but they may be added to the pack list by other
> > callers of install_packed_git(). It probably makes sense to just push
> > the hashmap maintenance down into that function, like below.
> 
> Makes sense to me.
> 
> Let me locally squash your fix in and credit you with helped-by
> footer in the amended log message.  Strictly speaking, this may
> invalidate the perf numbers, but I do not think the scenario p5303
> sets up alone is all that interesting anyway---if you have 10,000
> packs, not just registering them (which is improved with this patch)
> but using objects from them would be slower than necessary X-<.

Thanks, that sounds good.

I actually re-checked the perf numbers (mostly to make sure I didn't
screw anything up) and got similar results.

I agree that 10,000 packs is ridiculous, but we do see it (and worse)
occasionally from people pushing in a loop before our scheduled
maintenance kicks in.  And it's quadratic, so if you hit 30k packs, it's
another factor of 9 worse. It makes even diagnosing the repository
pretty painful. :)

Also a fun fact: Linux actually has a limit on the number of
simultaneous mmaps that a process can have, which defaults to ~64k. But
if you have if you have 32k packs, then we'll map both the packs and the
idx files. Plus whatever you need for mapping the binary, libraries,
etc, plus any maps opened by malloc() for large requests.

I have occasionally run into this trying to repack some very
out-of-control cases (the magic fix is to double the limit with `sysctl
-w vm.max_map_count=131060`, if you are curious). I also wondered if
this might be made worse by the recent change to drop
release_pack_memory(). But I ran into it even before that change,
because zlib calls malloc() directly. We're also pretty aggressive about
dying when mmap() returns an error (rather than closing packs and trying
again).

I think Git _could_ be handle this more gracefully by just trying to
keep fewer packs open at one time (the way we similarly try not to use
up all of the file descriptors). But I have a hard time caring too much,
since it's such a ridiculous situation in the first place. Bumping the
limits is an easy operational fix.

-Peff
