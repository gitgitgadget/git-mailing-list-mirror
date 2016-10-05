Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826F91F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 16:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754718AbcJEQQ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 12:16:26 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:55554 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753290AbcJEQQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 12:16:25 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1broqx-0007ib-00; Wed, 05 Oct 2016 16:15:31 +0000
Date:   Wed, 5 Oct 2016 12:15:31 -0400
From:   Rich Felker <dalias@libc.org>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     musl@lists.openwall.com, James B <jamesbond3142@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [musl] Re: Regression: git no longer works with musl libc's
 regex impl
Message-ID: <20161005161531.GH19318@brightrain.aerifal.cx>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610041802310.35196@virtualbox>
 <20161005090625.683fdbbfac8164125dee6469@gmail.com>
 <20161004223322.GE19318@brightrain.aerifal.cx>
 <bc3da1a4-4b99-737f-050e-54ef5844c402@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc3da1a4-4b99-737f-050e-54ef5844c402@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2016 at 03:11:05PM +0200, Jakub Narębski wrote:
> W dniu 05.10.2016 o 00:33, Rich Felker pisze:
> > On Wed, Oct 05, 2016 at 09:06:25AM +1100, James B wrote:
> >> On Tue, 4 Oct 2016 18:08:33 +0200 (CEST)
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >>>
> >>> No, it is not. You quote POSIX, but the matter of the fact is that we use
> >>> a subset of POSIX in order to be able to keep things running on Windows.
> >>>
> >>> And quite honestly, there are lots of reasons to keep things running on
> >>> Windows, and even to favor Windows support over musl support. Over four
> >>> million reasons: the Git for Windows users.
> >>
> >> Wow, I don't know that Windows is a git's first-tier platform now,
> >> and Linux/POSIX second. Are we talking about the same git that was
> >> originally written in Linus Torvalds, and is used to manage Linux
> >> kernel? Are you by any chance employed by Redmond, directly or
> >> indirectly?
> >>
> >> Sorry - can't help it.
> 
> Windows is one of the major platforms, yes.  I think there much, much
> more people using Git on Windows, than using Git with musl.  More
> users = more important.
> 
> Also, working with some inconvenience (requiring compilation with
> NO_REGEX=1) is better than not working at all.
> 
> In CodingGuidelines we say:
> 
>  - Most importantly, we never say "It's in POSIX; we'll happily
>    ignore your needs should your system not conform to it."
>    We live in the real world.
> 
>  - However, we often say "Let's stay away from that construct,
>    it's not even in POSIX".

I agree wholeheartedly with these points.

> 
>  - In spite of the above two rules, we sometimes say "Although
>    this is not in POSIX, it (is so convenient | makes the code
>    much more readable | has other good characteristics) and
>    practically all the platforms we care about support it, so
>    let's use it".
> 
> The REG_STARTEND is 3rd point,

To begin with I wasn't clear that REG_STARDEND being nonstandard was
even noticed or compatibility considered when adding the dependency on
it, but it seems such discussion did take place and most targets have
it. Perhaps this means it should be proposed for standardization in
the next issue of POSIX.

> mmap shenningans looks like 1st...
> 
> ....on the other hand midipix <writeonce@midipix.org> wrote in
> http://public-inbox.org/git/20161004200057.dc30d64f61e5ec441c34ffd4f788e58e.efa66ead67.wbe@email15.godaddy.com/
> that the proposed fix should work on all Windows version we are
> interested in (I think).  Test program included / attached.
> 
> The above-mentioned email also explains that the problem was
> caught on MS Windows; it triggers if file end falls on the mmapped
> page boundary, which is more likely to happen with 4096 mod size
> on Windows rather than 65536 mod size on Linux.

On Linux page-size (mmap granularity) varies by arch but it's 4k on
basically all archs that people care about. I think midipix's author
was talking about real page size on Windows (4k) vs the minimum
logical page size (mmap granularity) that can be used to get
POSIX-matching semantics in midipix (which is 64k due to some
technical reasons I forget, which he could probably remind me of).

> On the other hand, while the proposed solution of "add padding as
> to not end at page boundary, if necessary" doesn't have the
> performance impact of "memcpy into NUL-terminated buffer" that
> was originally proposed in patch series, it is still extra code
> to maintain.

*nod*

Rich
