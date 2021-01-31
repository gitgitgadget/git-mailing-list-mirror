Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA98C433E0
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A6B64DDB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhAaDiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 22:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhAaDiR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 22:38:17 -0500
Received: from joooj.vinc17.net (joooj.vinc17.net [IPv6:2001:4b99:1:3:216:3eff:fe20:ac98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88025C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:37:37 -0800 (PST)
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id E55635D2;
        Sun, 31 Jan 2021 04:36:53 +0100 (CET)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id 7425FC20315; Sun, 31 Jan 2021 04:36:52 +0100 (CET)
Date:   Sun, 31 Jan 2021 04:36:52 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git fails with a broken pipe when one quits the pager
Message-ID: <20210131033652.GK623063@zira.vinc17.org>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735yhq3lc.fsf@evledraar.gmail.com>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.0.5+101 (ab6d0dc5) vl-132933 (2021-01-27)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-01-31 02:47:59 +0100, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Jan 15 2021, Vincent Lefevre wrote:
> > I had reported the following bug at
> >   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=914896
> >
> > It still occurs with Git 2.30.0.
> >
> > Some git commands with a lot of output fail with a broken pipe when
> > one quits the pager (without going to the end of the output).
> >
> > For instance, in zsh:
> >
> > cventin% setopt PRINT_EXIT_VALUE
> > cventin% git log
> > zsh: broken pipe  git log
> > cventin% echo $?
> > 141
> > cventin% 
> >
> > This is annoying[...]
> 
> Yes it's annoying, but the annoying output is from zsh, not
> git. Consider a smarter implementation like:
> 
>     case $__exit_status in
>         0) __exit_emoji=😀;;
>         1) __exit_emoji=☹️ ;;
>         141) __exit_emoji=🤕 ;;
>         [...]
> 
> Then put the $__exit_emoji in your $PS1 prompt, now when you 'q' in a
> pager you know the difference between having quit at the full output
> being emitted or not.

FYI, I already have the exit status already in my prompt (the above
commands were just for the example). Still, the git behavior is
disturbing.

Moreover, this doesn't solve the issue when doing something like

  git log && some_other_command

> > And of course, I don't want to hide error messages by default, because
> > this would hide *real* errors.
> 
> Isn't the solution to this that your shell stops reporting failures due
> to SIGPIPE in such a prominent way then?

No! I want to be warned about real SIGPIPEs.

> > The broken pipe is internally expected, thus should not be reported
> > by git.
> >
> > Just to be clear: this broken pipe should be discarded only when git
> > uses its builtin pager feature, not with a general pipe, where the
> > error may be important.
> >
> > For instance,
> >
> > $ { git log ; echo "Exit status: $?" >&2 ; } | true
> >
> > should still output
> >
> > Exit status: 141
> 
> I don't get it, how is it less meaningful when git itself invokes the
> pager?

I don't understand your question. If I invoke the pager myself,
I don't get a SIGPIPE:

cventin:~/software/gcc-trunk> git log
cventin:~/software/gcc-trunk[PIPE]> git log|m
cventin:~/software/gcc-trunk>

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
