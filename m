Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3E8C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB196138B
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhHWSdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:33:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:56952 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhHWSdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 14:33:25 -0400
Received: (qmail 12932 invoked by uid 109); 23 Aug 2021 18:32:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Aug 2021 18:32:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31346 invoked by uid 111); 23 Aug 2021 18:32:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Aug 2021 14:32:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Aug 2021 14:32:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rafael Santiago <voidbrainvoid@tutanota.com>,
        Rafael Santiago via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Give support for hooks based on platform
Message-ID: <YSPpySdd5qqDeNbm@coredump.intra.peff.net>
References: <pull.1069.git.git.1629576007891.gitgitgadget@gmail.com>
 <YSF1GfpHXRrXebsB@camp.crustytoothpaste.net>
 <Mheyv1D--3-2@tutanota.com>
 <YSLKrX/QTZtxBGDz@camp.crustytoothpaste.net>
 <YSPLnWshLsWlXwUn@coredump.intra.peff.net>
 <xmqqfsv0qby7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfsv0qby7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 10:59:28AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sun, Aug 22, 2021 at 10:07:41PM +0000, brian m. carlson wrote:
> >
> >> > The point is that in many cases a dependency with a script language is
> >> > created only to make the hook actions portable from a platform to
> >> > other, but what this script in its essence does is a thing that could
> >> > be done with basic tools delivered with the current operating system.
> >> 
> >> Then, in general, it can be done in a shell script containing an if-then
> >> statement per platform using the native tools, so I'm not seeing the
> >> particular reason that this series is necessary if the hooks being
> >> executed aren't binaries.  All systems on which Git runs must contain a
> >> POSIX-compatible shell.
> >
> > This is my gut feeling, too (whether users know it or not, even on
> > Windows most programs specified by config are being run by the shell).
> >
> > However, I do think there is room for Git to make this case a bit
> > easier: conditional config includes. Once we are able to specify hooks
> > via config (which is being worked on elsewhere), then we ought to be
> > able to implement an includeIf like:
> >
> >   [includeIf "uname_s:linux"]
> >   path = linux-hooks.config
> >   [includeIf "uname_s:windows"]
> >   path = windows-hooks.config
> >
> > The advantage being that this could apply to _all_ config, and not just
> > hooks.
> 
> Heh, it seems great minds think alike.

One important distinction in what you wrote is that you're expecting the
user to set dev.host once. That nicely sidesteps any question of "how
does Git label each platform?", but it does mean the user has to do that
setup manually (which maybe is amortized across many repos, but in
practice for many people I suspect is no better than them setting up the
correct "include" in the first place).

I hoped that by calling it "uname_s", it would be clear it was the same
as "uname -s", and then we could blame any naming confusion on the OS. :)

But even if it is not used for this particular application, I think the
[includeIf "var:..."] you proposed might be a reasonable thing to
support.

-Peff
