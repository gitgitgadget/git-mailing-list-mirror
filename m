From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [BUG?] applypatch-msg hook no-longer thinks stdin is a tty
Date: Sat, 3 Oct 2015 20:37:44 +1300
Message-ID: <CAFOYHZC9ju5Yg9LkYwiwXC+D0QZGs1isetYd-XvyhwhcZuJK+w@mail.gmail.com>
References: <CAFOYHZArBv=2E_YonCqOSC4mWk9=xkbG9FyB+zNFFAqmUBUKHA@mail.gmail.com>
	<xmqqvbap5kbr.fsf@gitster.mtv.corp.google.com>
	<xmqqr3ld5fok.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 09:37:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiHOA-0005ru-Ck
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 09:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbbJCHhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 03:37:46 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37658 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbbJCHho (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 03:37:44 -0400
Received: by igbni9 with SMTP id ni9so30175339igb.0
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 00:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FKQuyCuwyvjzJqnoIeGuCRsUmjYG4zOedytHFPpapgM=;
        b=gxhGsMsixgJ/CaVz1oc8y10/yfM1I1wUm9dT6H9lsFN3yo5avctHXm32gKgxk3XC0j
         t/vuVqXjDA8HmXWy2EIJYU2vr/WiHtiYhC/+Y8cUHyPnDeaO2WS+O+9K2tslcDOpsoZ1
         8v31bro98dB0W3uIpXqNkv4PLG6ZM+1lcKc4V5ZI8L1ztkVZWZUrwvq2Da2e/DMON002
         PTqOF/zvsvnZFMEAJSF1h70IRiDNjUzPvp1aCuIBiP2mvJGEBM2PvixH8i7nQXLkG+Fo
         8s0hCrLJAT6u0HswgiMO+OkdinQNAmfXeu5MFPPIKRUXgfZEvBstMHtqwSHTrn0ZPi5l
         jWUw==
X-Received: by 10.50.50.68 with SMTP id a4mr1029372igo.49.1443857864266; Sat,
 03 Oct 2015 00:37:44 -0700 (PDT)
Received: by 10.79.109.71 with HTTP; Sat, 3 Oct 2015 00:37:44 -0700 (PDT)
In-Reply-To: <xmqqr3ld5fok.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278962>

On Sat, Oct 3, 2015 at 6:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Chris Packham <judge.packham@gmail.com> writes:
>>
>>> As of git 2.6 this has stopped working and stdin always fails the tty
>>> check.
>>
>> We now run that hook thru run_hook_ve(), which closes the standard
>> input (as the hook is not reading anything).  Perhaps you can check
>> if your output is connected to the tty instead?

Possibly but I still need to be able to push a prompt out to the user
and receive a response.

>
> s|closes the standard input|opens the standard input for /dev/null|;
>
> Having said that, here are some further thoughts:
>
>  * Hooks run via run_hook_ve() and run_hook_le() have their standard
>    input connected to /dev/null even before these functions were
>    introduced at ae98a008 (Move run_hook() from builtin-commit.c
>    into run-command.c (libgit), 2009-01-16).  The commit
>    consolidated the code to run hooks in "checkout", "commit", "gc",
>    and "merge", all of which run their hooks with their standard
>    input reading from /dev/null.
>
>  * Later at dfa7a6c5 (clone: run post-checkout hook when checking
>    out, 2009-03-03) "git clone" learned to run post-checkout hook
>    the same way.
>
>  * "receive-pack" (which accepts and processes an incoming "git
>    push") has pre-receive and post-receive hooks, and they do get
>    invoked with their standard input open, but they are connected to
>    a pipe to be fed with the information about the push from
>    "receive-pack" process.
>
>  * "post-rewrite" hooks, invoked by "rebase" and "commit", does get
>    invoked with its standard input open, but it is fed with the
>    information about the original and the rewritten commit.
>
> So in that sense, "am", primarily because it was implemented as a
> script, was an oddball.  It should have been connecting the standard
> input to /dev/null in order to be consistent with others, but it did
> not even bother to do so.
>
> We _could_ leave the standard input connected to the original
> process's standard input only for the specific hook by doing
> something along the lines of the attached, but I am not sure if it
> is a good change.  Given that the majority of existing hooks are
> spawned with their standard input connected to /dev/null (and also
> after scanning the output from "git hooks --help", I did not find
> any that would want to read from the standard input of the original
> process that spawns it), I tend to consider that the change in 2.6
> done as part of rewriting "am" in C is a bugfix, even though an
> unintended one, to make things more consistent.
>
> Besides "consistency", a hook that tried to read from "am"'s
> standard input would have been incorrect in the first place, as it
> is a normal mode of operation to feed one or more patch e-mails from
> the standard input of "git am", i.e.
>
>         $ git am <mbox

And my current hook handles that by assuming that the user input is "N"

>
> If you want to go interactive from the hook, you'd have to open and
> interact with /dev/tty yourself in your hook anyway.

That may be what I have to do, although I have absolutely no idea how.

>
>  builtin/am.c  |  8 +++++++-
>  run-command.c | 30 ++++++++++++++++++++++++++----
>  run-command.h |  9 +++++++++
>  3 files changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 4f77e07..3d160d9 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -510,9 +510,15 @@ static void am_destroy(const struct am_state *state)
>  static int run_applypatch_msg_hook(struct am_state *state)
>  {
>         int ret;
> +       struct child_process custom = CHILD_PROCESS_INIT;
>
>         assert(state->msg);
> -       ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
> +
> +       custom.env = NULL;
> +       custom.no_stdin = 0;
> +       custom.stdout_to_stderr = 1;
> +
> +       ret = run_hook_le_opt(&custom, "applypatch-msg", am_path(state, "final-commit"), NULL);
>
>         if (!ret) {
>                 free(state->msg);
> diff --git a/run-command.c b/run-command.c
> index 3277cf7..dee86df 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -793,7 +793,7 @@ const char *find_hook(const char *name)
>         return path.buf;
>  }
>
> -int run_hook_ve(const char *const *env, const char *name, va_list args)
> +int run_hook_ve_opt(struct child_process *custom, const char *name, va_list args)
>  {
>         struct child_process hook = CHILD_PROCESS_INIT;
>         const char *p;
> @@ -805,13 +805,35 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
>         argv_array_push(&hook.args, p);
>         while ((p = va_arg(args, const char *)))
>                 argv_array_push(&hook.args, p);
> -       hook.env = env;
> -       hook.no_stdin = 1;
> -       hook.stdout_to_stderr = 1;
> +       hook.env = custom->env;
> +       hook.no_stdin = custom->no_stdin;
> +       hook.stdout_to_stderr = custom->stdout_to_stderr;
>
>         return run_command(&hook);
>  }
>
> +int run_hook_ve(const char *const *env, const char *name, va_list args)
> +{
> +       struct child_process custom = CHILD_PROCESS_INIT;
> +
> +       custom.env = env;
> +       custom.no_stdin = 1;
> +       custom.stdout_to_stderr = 1;
> +       return run_hook_ve_opt(&custom, name, args);
> +}
> +
> +int run_hook_le_opt(struct child_process *custom, const char *name, ...)
> +{
> +       va_list args;
> +       int ret;
> +
> +       va_start(args, name);
> +       ret = run_hook_ve_opt(custom, name, args);
> +       va_end(args);
> +
> +       return ret;
> +}
> +
>  int run_hook_le(const char *const *env, const char *name, ...)
>  {
>         va_list args;
> diff --git a/run-command.h b/run-command.h
> index 5b4425a..33a0d72 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -62,6 +62,15 @@ LAST_ARG_MUST_BE_NULL
>  extern int run_hook_le(const char *const *env, const char *name, ...);
>  extern int run_hook_ve(const char *const *env, const char *name, va_list args);
>
> +/*
> + * Same as above, but env, no_stdin and stdout_to_stderr are copied from
> + * custom to the child_process structure that spawns the hook.
> + */
> +LAST_ARG_MUST_BE_NULL
> +extern int run_hook_le_opt(struct child_process *custom, const char *name, ...);
> +extern int run_hook_ve_opt(struct child_process *custom, const char *name, va_list args);
> +
> +
>  #define RUN_COMMAND_NO_STDIN 1
>  #define RUN_GIT_CMD         2  /*If this is to be git sub-command */
>  #define RUN_COMMAND_STDOUT_TO_STDERR 4
>
>
>
