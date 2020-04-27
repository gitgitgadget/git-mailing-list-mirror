Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521BEC4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DD5206D6
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgD0UIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:08:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:41306 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726609AbgD0UIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 16:08:54 -0400
Received: (qmail 15652 invoked by uid 109); 27 Apr 2020 20:08:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Apr 2020 20:08:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27155 invoked by uid 111); 27 Apr 2020 20:20:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2020 16:20:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Apr 2020 16:08:52 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
Message-ID: <20200427200852.GC1728884@coredump.intra.peff.net>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com>
 <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 25, 2020 at 02:24:34PM +0200, Johannes Schindelin wrote:

> > > The goal would be to maintain a CMake build for Git keeping it in sync
> > > with the Makefile. The Makefile is not going to be replaced at all.
> > > The CMake script for now only supports Linux and Windows. It does not
> > > support BSD, Solaris and others, whereas the Makefile does support
> > > them.
> >
> > So you are doing (1).  I already said that I feel that engineering
> > burden to divert resources for CMake support would be unacceptably
> > high.
> 
> Would your position change if Sibi was interested in maintaining this, and
> helping with keeping CMake support in shape?

I have mixed feelings.

Imagine we say that the Makefile is the official build mechanism and
that cmake support is a second-class citizen. I.e., somebody is willing
to be the maintainer of that feature and port over changes for people
who want to use cmake. That removes the issue of developers spending
time dealing with a new make tool that they don't care about (and might
not even have, or might not be available for their platform).

That's basically what we do with autoconf. But I haven't been all that
pleased with the results. The autoconf code is frequently out-of-date or
just plain wrong (e.g., the recent inet_ntop issues) and a frequent
response to questions on the list is "have you tried just building
without autoconf". I'm not sure if we are doing users a disservice to
pretend that we have maintained autoconf support.

On the other hand, if it is helping people avoid turning Makefile knobs
manually, we'd never hear complaints if it Just Works for some folks. So
maybe autoconf is a necessary evil (evil from the perspective of
developers, not users) that does pull its own weight.

Getting back to cmake: I can plausibly believe it's in the same boat. I
don't have any interest in Visual Studio, but I can believe that it's an
important convenience for some people / platforms, and that cmake is the
best way to get there.

So if you are proposing to declare this as an experiment which will be
maintained independently, and we can see how often it becomes a problem
and how many people it helps, that makes more sense to me.

Skimming the patches, I do wish I didn't see so much repetition with the
existing Makefile. I know that some of the logic will just have to be
ported manually, but surely we could be pulling things like the list of
libgit_SOURCES from the Makefile as the single source of truth?

> > Any patch that is acceptable to the current project would become
> > unacceptable because they lack updates to CMake part, but I suspect
> > we do not have enough people who are so much devoted to give a good
> > review if updates to CMake part are added.  And it is unclear why it
> > would be beneficial to slow our existing developers down by forcing
> > them to become familiar with CMake.
> 
> When it comes to new Makefile knobs, I do agree that it would place an
> unacceptable burden on contributors if we expected them to add the same
> knob to CMakeLists.txt. But we already don't do that for our autoconf
> support, so why would we expect it for CMake?

My concern here would be that the various knobs and behaviors are going
to fall out of date, and nobody will notice. Because there aren't many
cmake users, and because some of the logic is subtle (e.g., if it picked
the wrong sha1-implementation default, who would notice?). But again, if
we're willing to say "cmake support is an experiment" and let the
maintenance burden fall to people who are interested, then we can at
least have some data on how it works in practice.

> When it comes to adding new, and/or removing, files, I fail to see the
> problem. It is dead easy to keep the Makefile and CMakeLists.txt in sync
> when it comes to lists of files.

It's _conceptually_ dead easy, but now there's a new tool and a new step
people have to know about. Automated builds let you know when there's a
problem, but somebody still has to fix it. I'd hope that basic stuff
like file lists could be written so that there's no need to fix at all:
they'd just pull from the same source as the Makefile.

> But even if I haven't, I would like to propose to run with Sibi's patches
> and merge them first to `pu`, and then to `next`, and let that cook for a
> while (I will merge them into Git for Windows early so that there is also
> some support stream from that side).
> 
> I know you think that the maintenance cost is too high, but I think it
> might be more than just manageable. And I don't think that the risk is too
> high to give the patches a try, at least inside `next`, for a couple of
> weeks or even months.
> 
> If it turns out that they _do_ add too much of a maintenance burden, big
> deal: we just drop the patches, and that's that. No hard feelings, we gave
> it a try, a scientific test, if you want, and we now have evidence to back
> up your initial suspicion.
> 
> If it turns out that they _do_ add value _and_ are easy to maintain, then
> that's good, right? And then, at your leisurely leisure, you can merge
> them down to `master` and eventually into an official release.
> 
> What do you think? Doesn't that sound like a good plan?

I think what I'm suggesting is not all that different from this, except
that I'd suspect "next" would not get enough exposure. So in my mind
merging to master is not so much "hooray, we now have visual studio
support" but rather the first step in getting data. But we'd have to be
very clear about how the project regards the cmake support: it's there
for now, you're encouraged to play with it, but don't be upset if it
needs some coaxing to behave like the normal Makefile or if it goes away
in the future.

-Peff
