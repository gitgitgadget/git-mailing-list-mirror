From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Wed, 23 Dec 2015 17:20:30 +0700
Message-ID: <CACsJy8AwoohWmUF9QCDg+xvNifDh0o+PBnExxwv=qxz2Mh4a1w@mail.gmail.com>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1450597819-26278-1-git-send-email-pclouds@gmail.com> <xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DFmZSa2x4y2fDwVsvwa5uAuMJn8v=utvYtAPTGFbdWPg@mail.gmail.com>
 <CACsJy8A5AcRj2HiLe3PQijhYcHMzJ6eEuMyeVTMvPtXvMg_Sug@mail.gmail.com>
 <xmqqd1tye4i8.fsf@gitster.mtv.corp.google.com> <20151223093700.GA13386@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 23 11:21:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBgXd-0005K6-Lq
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 11:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbbLWKVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 05:21:04 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36698 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbbLWKVC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 05:21:02 -0500
Received: by mail-lb0-f179.google.com with SMTP id oh2so44194789lbb.3
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 02:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HT8VSTT9DIgMoXKjG7cX/DVCefgSjfqDry/k178ix7M=;
        b=fWdrFxJQYLKuvVIDHmEI+4r04jylxJ1mo65H1rMaNwLUAJIYsYT8UFPKPn11oPf6xQ
         2aqFbeGRjpUFWZan+Qs1HNDYok93UbmSKhsHnzbqaBy7UkcjWJ/UhIgzw69bkSC/LUU4
         ffMLiNlmyCAOdItKHBMh8+3dLS1XvJBhOA3xH9uVqFemAMjECzgXG1terYdiRHBar7D9
         etVGYa76BOlR4C+qRb/CzUig0fY80kHtK8t5E+tMn3MySu3REQQ/K0H3jhXIeLpymhTB
         3pf05RI+0/ej0XmJ+2A/XU18JmUVZUMUSZefI/BpainaJ7UU8PMAf3QwAY4wVJtaLJt8
         S2sQ==
X-Received: by 10.112.168.70 with SMTP id zu6mr9957904lbb.26.1450866060408;
 Wed, 23 Dec 2015 02:21:00 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 23 Dec 2015 02:20:30 -0800 (PST)
In-Reply-To: <20151223093700.GA13386@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282932>

On Wed, Dec 23, 2015 at 4:37 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 22, 2015 at 10:13:03AM -0800, Junio C Hamano wrote:
>
>> > Another by the way, this "forcing aliases as external commands" now
>> > shows something like "error: git-log died of signal 13" when the pager
>> > exits early, for an alias like "l1 = log --oneline".
>>
>> ... and we do not show that when we directly call "git log" is...?
>>
>> We do signal this with non-zero exit status like so:
>>
>>       $ GIT_PAGER=true git log --oneline ; echo $?
>>         141
>>
>> and it is not surprising that the one that is catching the exit
>> status of what was spawned and reporting "signal 13".
>
> This sounded very familiar. Apparently I've been running with the patch
> below for almost 3 years and never got around to re-examining it.
>
> The original discussion is in:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/212630
>
> Having skimmed through the arguments there, and given that we applied
> the patch from the middle of the thread, I think this is a good change.

Yep. The new thing here is the "died of" message now also comes from
execv_dashed_external() for non-external aliases, so it can show up a
lot more often. I wasn't sure if excluding SIGPIPE in wait_and_whine
was safe. But I _guess_ it is, based on your having no problem with
the patch for a long time and the past discussion.

>
> -- >8 --
> Date: Fri, 4 Jan 2013 07:19:35 -0500
> Subject: [PATCH] avoid SIGPIPE warnings for aliases
>
> When git executes an alias that specifies an external
> command, it will complain if the alias dies due to a signal.
> This is usually a good thing, as signal deaths are
> unexpected. However, SIGPIPE is not unexpected for many
> commands which produce a lot of output; it is intended that
> the user closing the pager would kill them them via SIGPIPE.
>
> As a result, the user might see annoying messages in a
> scenario like this:
>
>   $ cat ~/.gitconfig
>   [alias]
>   lgbase = log --some-options
>   lg = !git lgbase --more-options
>   lg2 = !git lgbase --other-options
>
>   $ git lg -p
>   [user hits 'q' to exit pager]
>   error: git lgbase --more-options died of signal 13
>   fatal: While expanding alias 'lg': 'git lgbase --more-options': Success
>
> Many users won't see this, because we execute the external
> command with the shell, and a POSIX shell will silently
> rewrite the signal-death exit code into 128+signal, and we
> will treat it like a normal exit code. However, this does
> not always happen:
>
>   1. If the sub-command does not have shell metacharacters,
>      we will skip the shell and exec it directly, getting
>      the signal code.
>
>   2. Some shells do not do this rewriting; for example,
>      setting SHELL_PATH set to zsh will reveal this problem.
>
> This patch squelches the message, and lets git exit silently
> (with the same exit code that a shell would use in case of a
> signal).
>
> The first line of the message comes from run-command's
> wait_or_whine. To silence that message, we remain quiet
> anytime we see SIGPIPE.
>
> The second line comes from handle_alias itself. It calls
> die_errno whenever run_command returns a negative value.
> However, only -1 indicates a syscall error where errno has
> something useful (note that it says the useless "success"
> above). Instead, we treat negative returns from run_command
> (except for -1) as a normal code to be passed to exit.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git.c         | 2 +-
>  run-command.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git.c b/git.c
> index 6ed824c..34a18a3 100644
> --- a/git.c
> +++ b/git.c
> @@ -252,7 +252,7 @@ static int handle_alias(int *argcp, const char ***argv)
>                         alias_argv[argc] = NULL;
>
>                         ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
> -                       if (ret >= 0)   /* normal exit */
> +                       if (ret != -1)  /* normal exit */
>                                 exit(ret);
>
>                         die_errno("While expanding alias '%s': '%s'",
> diff --git a/run-command.c b/run-command.c
> index 13fa452..694a6ff 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -245,7 +245,7 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
>                 error("waitpid is confused (%s)", argv0);
>         } else if (WIFSIGNALED(status)) {
>                 code = WTERMSIG(status);
> -               if (code != SIGINT && code != SIGQUIT)
> +               if (code != SIGINT && code != SIGQUIT && code != SIGPIPE)
>                         error("%s died of signal %d", argv0, code);
>                 /*
>                  * This return value is chosen so that code & 0xff
> --
> 2.7.0.rc2.368.g1cbb535
>



-- 
Duy
