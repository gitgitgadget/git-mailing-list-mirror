Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB429C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B770864D9E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhBAPZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:25:40 -0500
Received: from joooj.vinc17.net ([155.133.131.76]:60554 "EHLO joooj.vinc17.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231263AbhBAOuP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 09:50:15 -0500
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id 31D11AA4;
        Mon,  1 Feb 2021 15:48:58 +0100 (CET)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id DB523C2033B; Mon,  1 Feb 2021 15:48:57 +0100 (CET)
Date:   Mon, 1 Feb 2021 15:48:57 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git fails with a broken pipe when one quits the pager
Message-ID: <20210201144857.GB24560@zira.vinc17.org>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
 <87o8h4omqa.fsf@evledraar.gmail.com>
 <20210201103429.GT623063@zira.vinc17.org>
 <87im7cng42.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im7cng42.fsf@evledraar.gmail.com>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.0.5+101 (ab6d0dc5) vl-132933 (2021-01-27)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-02-01 13:10:21 +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Feb 01 2021, Vincent Lefevre wrote:
> 
> > On 2021-01-31 21:49:49 +0100, ï¿½var Arnfjï¿½rï¿½ Bjarmason wrote:
> >> On Sun, Jan 31 2021, Vincent Lefevre wrote:
> >> > FYI, I already have the exit status already in my prompt (the above
> >> > commands were just for the example). Still, the git behavior is
> >> > disturbing.
> >> >
> >> > Moreover, this doesn't solve the issue when doing something like
> >> >
> >> >   git log && some_other_command
> >> 
> >> What issue? That we're returning an exit code per getting a SIGHUP here
> >> is a feature. Consider:
> >> 
> >>     git -c core.pager=/bin/false log && echo showed you the output
> >
> > If the pager exists with a non-zero exit status, it is normal to
> > return a non-zero exit status. This was not the bug I reported.
> 
> Is it normal? Isn't this subject to the same race noted in
> https://lore.kernel.org/git/20191115040909.GA21654@sigill.intra.peff.net/

There's a race only because the command is buggy under bash's
pipefail.

Something like

  git status -s -b | head -1

is fine by default, because the exist status of the LHS command is
ignored. With pipefail, you may start getting SIGPIPE exit codes,
which, depending on the context, you may want to ignore or not.
I suppose that the user who writes something like the above would
like to ignore SIGPIPE.

So, that should be:

  { git status -s -b; if [[ $? = 141 ]]; then return 0; fi } | head -1

(though that's 100% safe only if git catches/blocks/ignores SIGPIPE
and detect the broken pipe with EPIPE, so that an abnormal termination
due to a "kill -PIPE ..." from another process would not be ignored).

It appears that pipefail was designed mainly for scripts. So, having
to handle SIGPIPE like that is OK in scripts. For interactive use,
this would be bad, but that's not the purpose of pipefail (or bash
should have an option to regard 141 as 0 in any LHS command).

FYI, I have a zsh function to automatically pipe some commands to
"less" when connected to a terminal (a bit like what git does),
where I explicitly ignore SIGPIPE for the command:

pager-wrapper()
{
  local -a opt
  while [[ $1 == -* ]]
  do
    opt+=$1
    shift
  done
  if [[ -t 1 ]] then
    $@ $opt |& less -+c -FRX
    return $(( $pipestatus[2] != 0 ? $pipestatus[2] :
               $pipestatus[1] != 128 + $(kill -l PIPE) ? $pipestatus[1] : 0 ))
  else
    $@
  fi
}

So no SIGPIPE is reported when I quit the pager. I can still get a
reported SIGPIPE, e.g. if "less" is killed by SIGPIPE (e.g., this
is possible with "kill -PIPE ..."), and this one is meaningful.

> >> > No! I want to be warned about real SIGPIPEs.
> >> 
> >> Not being able to write "git log" output is a real SIGPIPE.
> >
> > Which is not the case here, because the full output has never been
> > requested by the user.
> 
> They requested it by running "git log", which e.g. for git.git is ~1
> million lines. Then presumably paged down just a few pages and issued
> "q" in their pager. At which point we'll fail on the write() in git-log.

But when outputting to a pager, this should not be regarded as an
error: the reason is either the user has quit the pager normally
(after having read what he wanted to read: the user did not need
more output) or the pager has terminated in an abnormal way, in
which case the exit status of the pager should be non-zero.

> The pager's exit status is usually/always 0 in those cases
> (e.g. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/more.html).

Yes, and there's no reason to return anything else, as quitting the
pager before reading the full output is not an error.

> So we've got the SIGPIPE to indicate the output wasn't fully
> consumed.

But the user doesn't care: he quit the pager because he didn't
need more output. So there is no need to signal that the output
wasn't fully consumed. The user already knew that before quitting
the pager!

> > [...]
> >> Maybe we have users who'd like to work around zsh's "setopt
> >> PRINT_EXIT_VALUE" mode (would you want this patch if you could make zsh
> >> ignore 141?).
> >
> > zsh is working as expected, and as I've already said, I ***WANT***
> > SIGPIPE to be reported by the shell, as it may indicate a real failure
> > in a script. BTW, I even have a script using git that relies on that:
> >
> > { git rev-list --author "$@[-1]" HEAD &&
> >   git rev-list --grep   "$@[-1]" HEAD } | \
> >   git "${@[1,-2]:-lv}" --no-walk --stdin
> >
> > return $((pipestatus[2] ? pipestatus[2] : pipestatus[1]))
> >
> > Here it is important not to lose any information. No pager is
> > involved, the full output is needed. If for some reason, the
> > LHS of the pipe fails due to a SIGPIPE but the right hand side
> > succeeds, the error will be reported.
> 
> Sorry, I really don't see how this is different. I think this goes back
> to my "'|' shell piping construct[...]" question in the E-Mail you're
> replying to.
> 
> in both the "git log &&" case and potentially here you'll get a program
> writing to a pipe getting a SIGPIPE, which is then reflected in the exit
> code.

I mean that there are SIGPIPEs that one does not want to ignore
(because they would indicate a problem -- in general in scripts),
and other ones that should be ignored because they don't indicate
an error.

> > The fact is that with a pager, the SIGPIPE with a pager is normal.
> > Thus with a pager, git is reporting a spurious SIGPIPE, and this
> > is disturbing.
> 
> I don't get what you're trying to say here, sorry.

I mean that when the user quits the pager, there is no reason to
report an error because the user explicitly wanted to quit now.

Similarly, if I run a text viewer on a file, I don't want a SIGPIPE
to be reported if I do not go to the end of the file (if a pipe was
used to read the file, e.g. to do some filtering, as "less" can do).

> Maybe this helps. So first, I don't know if your report came out of
> reading the recent "set -o pipefail" traffic on-list. As you can see in
> [1] I'm not some zealot for PIPEFAIL always being returned no matter
> what.

This is not related. And [1] is from 2021 (with a thread started
in 2019), while my report dates back to 2018:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=914896

Moreover, [1] is only about the use of pipes in the shell command.
My bug report is about the internal use of a pager by git.

> The difference between that though and what you're proposing is there
> you have the shell getting an exit code and opting to ignore it, as
> opposed to the program itself sweeping it under the rug.
> 
> I don't think either that just because you run a pager you're obligated
> to ferry down a SIGPIPE if you get it. E.g. mysql and postgresql both
> have interactive shells where you can open pagers. I didn't bother to
> check, but you can imagine doing a "show tables" or whatever and only
> viewing the first page, then quitting in the pager.
> 
> If that's part of a long interactive SQL session it would make no sense
> for the eventual exit code of mysql(1) or psql(1) to reflect that.
> 
> But with git we're (mostly) executing one-shot commands, e.g. with "git
> log" you give it some params, and it spews all the output at you, maybe
> with the help of a pager.
> 
> So then if we fail on the write() I don't see how it doesn't make sense
> to return the appropriate exit code for that failure downstream.

This depends on the kind of error. I agree for an unexpected error.
But for a broken pipe because git started a pager on its own and
the user chose to quit the pager, this should not be regarded as
an error.

> 1. https://lore.kernel.org/git/20210116153554.12604-12-avarab@gmail.com/

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
