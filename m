Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9982DC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6304A64EA3
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBAMhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 07:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhBAMhU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 07:37:20 -0500
Received: from joooj.vinc17.net (joooj.vinc17.net [IPv6:2001:4b99:1:3:216:3eff:fe20:ac98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77640C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 04:36:39 -0800 (PST)
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id 2DCF9877;
        Mon,  1 Feb 2021 13:36:36 +0100 (CET)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id DBF1AC2034C; Mon,  1 Feb 2021 13:36:35 +0100 (CET)
Date:   Mon, 1 Feb 2021 13:36:35 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git fails with a broken pipe when one quits the pager
Message-ID: <20210201123635.GA24560@zira.vinc17.org>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
 <87o8h4omqa.fsf@evledraar.gmail.com>
 <20210201103429.GT623063@zira.vinc17.org>
 <CAPx1Gvf92eCnSCZJLeqwyL-SprCxmnfi4w=d0-MHddY38DzADg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx1Gvf92eCnSCZJLeqwyL-SprCxmnfi4w=d0-MHddY38DzADg@mail.gmail.com>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.0.5+101 (ab6d0dc5) vl-132933 (2021-01-27)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-02-01 03:33:54 -0800, Chris Torek wrote:
> > On 2021-01-31 21:49:49 +0100, Ævar Arnfjörð Bjarmason wrote:
> > > ... That we're returning an exit code per getting a SIGHUP here
> > > is a feature. Consider:
> > >
> > >     git -c core.pager=/bin/false log && echo showed you the output
> 
> This example has a minor flaw: it should use `git -c core.pager=/bin/true`,
> probably.

In this case, since /bin/true doesn't read anything on purpose,
I would not expect any non-zero exit status.

And note that

  git -c core.pager="sh -c 'cat; /bin/false'" log

exits with a zero exit status, which is unexpected since the
pager failed. For instance, in practice, the pager could be
killed by the system, but the user would not necessarily notice
this as the pager may be configured to quit automatically when
reaching the end of the output (there are some "less" options
to do that: -E, -F). So, the user would think that he got the
full output while he didn't.

[...]
> > > Not being able to write "git log" output is a real SIGPIPE.
> 
> Worth noting: Linux has a pretty large pipe buffer.  POSIX requires
> at least 4k here, as I recall, but Linux will buffer 64k or more, so that
> if `git log` is able to write the entire log text (will be the case for small
> repositories) *before* the program on the right side of the pager pipe
> exits (this depends on many things), the pager's exit *won't* cause
> a SIGPIPE.  You'll get the SIGPIPE if either the pager exits very
> quickly, so that `git log` is unable to write much before the exit, or
> if the repository is sufficiently large so that the pipe blocks first.

In general, repositories have more than 64k log.

> > Which is not the case here, because the full output has never been
> > requested by the user.
> 
> The `git log` command *did* request the full output.

No, because the output is sent to a pager. As long as the user
does not look at more than what he looks for, no more "git log"
output is requested (such output can happen internally, but it
is not requested by the user).

> The problem that has come up is, if I understand correctly, that
> some Linux distributions have come with misconfigured pagers
> that don't bother reading their input, and silently exit zero.

They are not misconfigured. This is how they work. Actually I don't
see why they should read more than needed: this would be a useless
waste of memory.

> This causes all kinds of Git commands to *seem* to fail. The Git
> commands are just fine; the bug is that the pager doesn't read or
> write anything.
> 
> Unfortunately, the way that pipes work -- asynchronously -- means
> that Git really *can't* catch all problems here.  But catching a SIGPIPE,
> whether Git itself spawned the pager or not, does indicate that
> something has gone wrong ... *unless* Git was piping to, e.g., less,
> and the user read enough, and the user typed `q` at less, and less
> exited without bothering to read the rest of the input.
> 
> There's no good way for Git to be able to tell which of these was
> the case.

In the case git spawns a pager, it knows that this is a pager
(as per documentation).

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
