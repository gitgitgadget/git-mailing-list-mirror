Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09E6C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 10:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E0E64E96
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 10:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhBAKfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 05:35:13 -0500
Received: from joooj.vinc17.net ([155.133.131.76]:60006 "EHLO joooj.vinc17.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232646AbhBAKfM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 05:35:12 -0500
X-Greylist: delayed 111456 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2021 05:35:12 EST
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id EF852146A;
        Mon,  1 Feb 2021 11:34:29 +0100 (CET)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id 3B4B1C2055A; Mon,  1 Feb 2021 11:34:29 +0100 (CET)
Date:   Mon, 1 Feb 2021 11:34:29 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git fails with a broken pipe when one quits the pager
Message-ID: <20210201103429.GT623063@zira.vinc17.org>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
 <87o8h4omqa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8h4omqa.fsf@evledraar.gmail.com>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.0.5+101 (ab6d0dc5) vl-132933 (2021-01-27)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-01-31 21:49:49 +0100, Ævar Arnfjörð Bjarmason wrote:
> On Sun, Jan 31 2021, Vincent Lefevre wrote:
> > FYI, I already have the exit status already in my prompt (the above
> > commands were just for the example). Still, the git behavior is
> > disturbing.
> >
> > Moreover, this doesn't solve the issue when doing something like
> >
> >   git log && some_other_command
> 
> What issue? That we're returning an exit code per getting a SIGHUP here
> is a feature. Consider:
> 
>     git -c core.pager=/bin/false log && echo showed you the output

If the pager exists with a non-zero exit status, it is normal to
return a non-zero exit status. This was not the bug I reported.

> > No! I want to be warned about real SIGPIPEs.
> 
> Not being able to write "git log" output is a real SIGPIPE.

Which is not the case here, because the full output has never been
requested by the user.

> Is it because in your mind it's got something to do with the "|" shell
> piping construct? The SIGPIPE is sent by the kernel, so it's no less
> expected in cases like:
> 
>     git log && echo foo
> 
> Than:
> 
>     git log | cat

See the difference (without the patch) between

$ git log && echo foo; echo $?
141

and

$ git log | head; echo $?
[...]
0

[...]
> Maybe we have users who'd like to work around zsh's "setopt
> PRINT_EXIT_VALUE" mode (would you want this patch if you could make zsh
> ignore 141?).

zsh is working as expected, and as I've already said, I ***WANT***
SIGPIPE to be reported by the shell, as it may indicate a real failure
in a script. BTW, I even have a script using git that relies on that:

{ git rev-list --author "$@[-1]" HEAD &&
  git rev-list --grep   "$@[-1]" HEAD } | \
  git "${@[1,-2]:-lv}" --no-walk --stdin

return $((pipestatus[2] ? pipestatus[2] : pipestatus[1]))

Here it is important not to lose any information. No pager is
involved, the full output is needed. If for some reason, the
LHS of the pipe fails due to a SIGPIPE but the right hand side
succeeds, the error will be reported.

The fact is that with a pager, the SIGPIPE with a pager is normal.
Thus with a pager, git is reporting a spurious SIGPIPE, and this
is disturbing.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
