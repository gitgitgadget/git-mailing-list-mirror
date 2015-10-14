From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Tracing commands includes its working directory
Date: Wed, 14 Oct 2015 14:45:39 -0700
Message-ID: <xmqqbnc16s58.fsf@gitster.mtv.corp.google.com>
References: <1444857857-25796-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 23:45:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmTrm-0001XO-Tu
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 23:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbbJNVpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 17:45:42 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36655 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbbJNVpl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 17:45:41 -0400
Received: by pabws5 with SMTP id ws5so1395568pab.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 14:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RtiiBVCK4Dufg4Qs8wTu8rnzWzy7TC1dsGQ02GcDD4M=;
        b=FZXZ5YHiyUllmPH9bHfjyvWx5pK3CC6Q0tLCrlzmhqeptmyYrd/QmFJUJhSSezf8sZ
         zX3BLQ/bh730sWQs0LGwDuTOJRmyl5eozT5GB5osoT1lGsAHLBDio2G4ypLa/NrsRxXp
         3hcMtZFmur6UNzvZZot5Zm+y84V7bBA5ar2Ot+iapgG+/zGczJT+6tfXcQEd17QRU5LV
         UA53dZwJ5UgYQakOUpm8LzbWSt3v185PrXfGGv8xBjQz2aMlsIviwLFbGrFUqDPB7v+L
         aoOE8NJ6+9pHELsnQ02o7XKoJN2HSwn0bFrg3vJI34kHSfnEf2Kwm08qsEYKOaUfRF0Q
         9PTw==
X-Received: by 10.68.107.133 with SMTP id hc5mr5924048pbb.5.1444859140583;
        Wed, 14 Oct 2015 14:45:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id v6sm11406138pbs.40.2015.10.14.14.45.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 14:45:39 -0700 (PDT)
In-Reply-To: <1444857857-25796-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 14 Oct 2015 14:24:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279632>

Stefan Beller <sbeller@google.com> writes:

> Specially when having concurrent flows of command execution,
> the order of commands printed cannot be relied upon. To aid
> the poor developer follow the flow of commands include the
> current working directory in which the command is carried out.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

I am not quite sure about the motivation behind this patch.  If you
are doing N processes, each of which *happens* to be working inside
its own directory that is different from all others, then it may be
a usable way to tell them apart, but that smells like too much of
special casing that will be applicable ohly to what you happen to be
developing recently and nowhere else.  Some of these N processes
share the same cwd in an application different from yours.

One way to tweak it to be generic enough may be to show a trace
output when git goes into a different working directory, which is a
significant event that is worth tracing, and then have a mode where
all trace lines are prefixed with process ID, perhaps?

>  exec_cmd.c    | 2 +-
>  git.c         | 8 ++++----
>  run-command.c | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/exec_cmd.c b/exec_cmd.c
> index e85f0fd..bb79933 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -125,7 +125,7 @@ const char **prepare_git_cmd(const char **argv)
>  
>  int execv_git_cmd(const char **argv) {
>  	const char **nargv = prepare_git_cmd(argv);
> -	trace_argv_printf(nargv, "trace: exec:");
> +	trace_argv_printf(nargv, "(%s) trace: exec:", xgetcwd());
>  
>  	/* execvp() can only ever return if it fails */
>  	sane_execvp("git", (char **)nargv);
> diff --git a/git.c b/git.c
> index deecba0..e077e2d 100644
> --- a/git.c
> +++ b/git.c
> @@ -278,8 +278,8 @@ static int handle_alias(int *argcp, const char ***argv)
>  			die("recursive alias: %s", alias_command);
>  
>  		trace_argv_printf(new_argv,
> -				  "trace: alias expansion: %s =>",
> -				  alias_command);
> +				  "(%s) trace: alias expansion: %s =>",
> +				  xgetcwd(), alias_command);
>  
>  		REALLOC_ARRAY(new_argv, count + *argcp);
>  		/* insert after command name */
> @@ -345,7 +345,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  	if (!help && p->option & NEED_WORK_TREE)
>  		setup_work_tree();
>  
> -	trace_argv_printf(argv, "trace: built-in: git");
> +	trace_argv_printf(argv, "(%s) trace: built-in: git", xgetcwd());
>  
>  	status = p->fn(argc, argv, prefix);
>  	if (status)
> @@ -557,7 +557,7 @@ static void execv_dashed_external(const char **argv)
>  	tmp = argv[0];
>  	argv[0] = cmd.buf;
>  
> -	trace_argv_printf(argv, "trace: exec:");
> +	trace_argv_printf(argv, "(%s) trace: exec:", xgetcwd());
>  
>  	/*
>  	 * if we fail because the command is not found, it is
> diff --git a/run-command.c b/run-command.c
> index ef3da27..e483bae 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -194,7 +194,7 @@ static const char **prepare_shell_cmd(const char **argv)
>  static int execv_shell_cmd(const char **argv)
>  {
>  	const char **nargv = prepare_shell_cmd(argv);
> -	trace_argv_printf(nargv, "trace: exec:");
> +	trace_argv_printf(nargv, "(%s) trace: exec:", xgetcwd());
>  	sane_execvp(nargv[0], (char **)nargv);
>  	free(nargv);
>  	return -1;
> @@ -346,7 +346,7 @@ fail_pipe:
>  		cmd->err = fderr[0];
>  	}
>  
> -	trace_argv_printf(cmd->argv, "trace: run_command:");
> +	trace_argv_printf(cmd->argv, "(%s) trace: run_command:", xgetcwd());
>  	fflush(NULL);
>  
>  #ifndef GIT_WINDOWS_NATIVE
