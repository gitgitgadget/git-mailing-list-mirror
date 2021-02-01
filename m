Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02C9C43381
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD6A64E9E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhBAPR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhBAPRs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 10:17:48 -0500
Received: from joooj.vinc17.net (joooj.vinc17.net [IPv6:2001:4b99:1:3:216:3eff:fe20:ac98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5995C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 07:17:07 -0800 (PST)
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id 1308AAA4;
        Mon,  1 Feb 2021 16:17:03 +0100 (CET)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id A7338C20354; Mon,  1 Feb 2021 16:17:03 +0100 (CET)
Date:   Mon, 1 Feb 2021 16:17:03 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git fails with a broken pipe when one quits the pager
Message-ID: <20210201151703.GC24560@zira.vinc17.org>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
 <87o8h4omqa.fsf@evledraar.gmail.com>
 <20210201103429.GT623063@zira.vinc17.org>
 <CAPx1Gvf92eCnSCZJLeqwyL-SprCxmnfi4w=d0-MHddY38DzADg@mail.gmail.com>
 <20210201123635.GA24560@zira.vinc17.org>
 <CAPx1Gverh2E2h5JOSOfJ7JYvbhjv8hJNLE8y4VA2fNv0La8Rtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx1Gverh2E2h5JOSOfJ7JYvbhjv8hJNLE8y4VA2fNv0La8Rtw@mail.gmail.com>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.0.5+101 (ab6d0dc5) vl-132933 (2021-01-27)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-02-01 04:53:03 -0800, Chris Torek wrote:
> On Mon, Feb 1, 2021 at 4:36 AM Vincent Lefevre <vincent@vinc17.net> wrote:
> > In general, repositories have more than 64k log.
> 
> Please don't focus on the exact size.  Some system might
> have a multi-gigabyte pipe buffer, and some other system
> might have a tiny one; we'd like consistent behavior no matter
> what size the system uses.  Can we *get* consistent behavior?
> I don't know.

The consistent behavior can be obtained by ignoring the broken pipe
(in the case where git starts the pager).

> [me]
> > > The problem that has come up is, if I understand correctly, that
> > > some Linux distributions have come with misconfigured pagers
> > > that don't bother reading their input, and silently exit zero.
> >
> > They are not misconfigured. This is how they work.
> 
> A pager that reads nothing and writes nothing does not seem
> very useful to me. [...]

I agree.

> [on various exit cases]
> > > There's no good way for Git to be able to tell which of these was
> > > the case.
> >
> > In the case git spawns a pager, it knows that this is a pager
> > (as per documentation).
> 
> Again, this seems irrelevant.  If the pager exited correctly
> while reading everything, or it exited correctly without reading
> everything, or if it exited incorrectly with or without reading
> everything, is not something *Git* can tell.

No, Git can tell when the pager exited abnormally: it suffices to
check its exit status. Git currently doesn't do that, and this is
bad, because it can miss real issues, which cannot always be detected
by the user.

If the pager exits with exit code 0, this means normal termination,
whether the user has read the full output or not.

> I'm therefore not sure that Git should *try* to tell -- which is the
> point I'm trying to make here. The question is this: if we can only
> do a poor job, should we try at all? What *should* we do, given what
> we *can* do? All we get is SIGPIPE and an exit status, and the
> SIGPIPE may or may not be meaningful.
> 
> That seems to be what you're arguing as well.  So I'm not sure
> why you're objecting to what I'm pointing out. :-)

Well, my objection is based on the fact that it is possible to get
the information from the exit status of the pager (I originally
thought that Git was taking it into account).

BTW, another related thing I dislike about Git, and I think that this
should also be regarded as a bug, is that when doing a commit, Git
doesn't check the exit status of the editor for the commit message.
Say, for instance, if something on the system kills the editor, Git
applies the commit with an incorrect or incomplete log message though
the commit wasn't validated yet by the user. Fortunately, the user
can amend the commit, but IMHO, that's an incorrect behavior.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
