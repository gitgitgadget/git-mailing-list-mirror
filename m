Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E24C433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B1420657
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgHOWTC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 15 Aug 2020 18:19:02 -0400
Received: from elephants.elehost.com ([216.66.27.132]:18796 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbgHOWS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 18:18:59 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 07FMIll3001960
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 Aug 2020 18:18:47 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <jim.cromie@gmail.com>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
References: <CAJfuBxw2KudBPfpmVqU9VOfnvrKdczU6Us5FWvpj50T88BarHw@mail.gmail.com> <20200814220828.GP8085@camp.crustytoothpaste.net> <012301d67289$c5c36010$514a2030$@nexbridge.com> <CAJfuBxxqxKAFd_3F5ZKWjfmWA0v+kKX6mNqQA=sGYaP-NYXDSQ@mail.gmail.com>
In-Reply-To: <CAJfuBxxqxKAFd_3F5ZKWjfmWA0v+kKX6mNqQA=sGYaP-NYXDSQ@mail.gmail.com>
Subject: RE: git bisect enhancement request
Date:   Sat, 15 Aug 2020 18:18:41 -0400
Message-ID: <019701d67352$0ba8c250$22fa46f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLA1TswLub1wJdglSp//FP9kbFv/wITf/ABAL+FCF0B2qVWwqc/iQJQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 15, 2020 9:05 AM, jim.cromie@gmail.com wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: brian m. carlson <sandals@crustytoothpaste.net>; git@vger.kernel.org
> Subject: Re: git bisect enhancement request
> 
> good questions, thank you both
> 
> On Fri, Aug 14, 2020 at 4:25 PM Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> >
> > On August 14, 2020 6:08 PM, brian m. carlson wrote:
> > > On 2020-08-14 at 21:11:19, jim.cromie@gmail.com wrote:
> > > > please teach git bisect how to use 2 separate worktrees for the
> > > > bisection, toggling between them as bisection progresses, so that
> > > > the end result is 2 compiled kernels, one broken, one good.
> > >
> > > I'm not sure how such a thing would be implemented.  Git doesn't
> > > know until after it's checked out the tree whether a revision is
> > > good or bad, since usually the user needs to tell it (or use git
> > > bisect run).  Even if Git alternated between the two worktrees in
> > > order, that doesn't mean that one of them will end up being good,
> > > since Git may find the last good revision early on, then continue to bisect
> and find many bad revisions until it determines the right one.
> > >
> > > Can you tell us more about the algorithm you'd like to see here?
> >
> > I'm wondering more about the requirements on this. Does the bisect
> manipulate both worktrees at once or separately? Are these worktrees
> variants on a theme but on different branches (so synchronizing the commits
> would probably be impractical) - or bisect both workspaces but using
> different commits as start and end (this should be scriptable)? Does it flip
> back and forth between the two worktrees doing a bisect in one, then the
> other (this should be scriptable)? Or is this just to teach git to bisect a
> worktree in a distinct manner - which, correct me if I'm wrong, I think it
> already supports.
> >
> > Or is this more, I have two worktrees on basically the same branch. When
> bisect happens, one worktree is bisected, tested. If the new code succeeds,
> and the other worktree is in a failed state, don't bisect the other worktree in
> the same direction - that's not right, but I think I know your end-state goal:
> keep bisecting both worktrees until a state change. What that is leading to is
> really something different, which is that once bisect is done, you know which
> commit introduced the bug, so set one worktree to the working commit and
> the other to the broken commit. If that's the case, it's not a toggle, but an
> end-state operation to set two worktrees to adjacent commits essentially
> surrounding the introduction point. Is that what you want?
> >
> 
> heh - reading paragraph 1, I thought "yeah thats it"
> but then paragraph 2 ...
> 
> its more about the end-state as Ive thought about it, and I casually leaped to
> it being useful at every iteration.
> Having 2 worktrees converging on good/bad yes/no old/new does seem
> generically appealing, but I dont have a solid use case.
> 
> My best generic argument is that determining good/bad on a build can be
> hard, and having the previous build(s) around could be useful.
> 
> Broadening, having --last=N wktree-g<sha8>s, in a grove/orchard would be
> simple to explain (N=0 currently, wo naming games) Accepting a 'wktree'
> prefix, and adding suffixes like 5.8.0-v1-00025-g8bfb9456e727-dirty
> (with a strftime-like format "%v-%u-%5N-%14g-%s" ideally) would sidestep
> any 'policy/methodology' implied by wktree names.
> having -00025 etc would give cheap look at bisect convergence.
> 
> and having 'planted' a grove of bisection points, one could leave it around,
> for subsequent use as a "re-bisection cache" to retest against a iteratively
> refined bisect run script
> 
> Im now speculating hard, I hope it makes some sense.
> 
> My fever dream is to have a gdb-mi script/program talking to 2 separate
> targets, and "bisecting breakpoints" back from where the bad one panics, to
> the point where the gdb trace diverges between the 2 targets.
> 
> and I want to run rr record vmlinux inside qemu, with quick deterministic
> replay, and a tight "breakpoint bisection" loop.  But I digress. And a pony.

I think that you might have answered this yourself-ish. Assume that the code is broken and you are looking for the commit where that happened. Bisect will get you there in each target independently and answer which commit works and which commit breaks on system X. The same can be said for system Y in a separate worktree. You then can check whether the commits are the same or not. If not, you have established your system-X/Y delta. If they are the same, you can then check the gdb trace. If they are the same, conceptually anyway, both systems are behaving similarly. Otherwise, you can reset bisect and start over on system Y (or X, I suppose depending on the commit parentage) using the gdb trace as a criteria for good/bad for bisect purposes. Obviously I'm simplifying, but bisect is agnostic to your pass/fail criteria so perhaps some variant of this, where you use a multi-variate concept of "it works" and "the trace matches". The same concept is used for performance testing, where bisec
 t can be very useful for determining where a performance degradation was introduced (or where things got better), by using various performance metrics as good/bad criteria instead of whether the code functionally works. Sadly (a nit of mine) is that I don't see performance regression testing used enough in DevOps pipelines although it is somewhat difficult to quantify those metrics in a multi-target pipeline).

My $0.03
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



