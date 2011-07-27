From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC] notice error exit from pager
Date: Wed, 27 Jul 2011 21:36:52 +0200
Message-ID: <4E3068D4.4050006@kdbg.org>
References: <20110726210401.GA25207@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torvalds@linux-foundation.org,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jul 27 21:37:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm9ui-0004By-Va
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 21:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab1G0Tg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 15:36:59 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:47543 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754247Ab1G0Tg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 15:36:58 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4B4AD130045;
	Wed, 27 Jul 2011 21:36:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CCE8A19F350;
	Wed, 27 Jul 2011 21:36:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <20110726210401.GA25207@toss.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177995>

Am 26.07.2011 23:04, schrieb Clemens Buchacher:
> If the pager fails to run, git produces no output, e.g.:
> 
>  $ GIT_PAGER=not-a-command git log
> 
> The error reporting fails for two reasons:
> 
>  (1) start_command: There is a mechanism that detects errors during
>      execvp introduced in 2b541bf8 (start_command: detect execvp
>      failures early). ... This mechanism is
>      incompatible with the workaround introduced in 35ce8622
>      (pager: Work around window resizing bug in 'less')

You analysis is correct. I think the bug in less was fixed shortly after
this workaround was introduced. I would like to remove this workaround
for a different reason, but it seems there are people who are quite fond
of it ;)

> diff --git a/run-command.c b/run-command.c
> index 70e8a24..944a882 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -127,9 +127,6 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
>  		if (code == 127) {
>  			code = -1;
>  			failed_errno = ENOENT;
> -			if (!silent_exec_failure)
> -				error("cannot run %s: %s", argv0,
> -					strerror(ENOENT));
>  		}
>  	} else {
>  		error("waitpid is confused (%s)", argv0);
> @@ -287,10 +284,14 @@ fail_pipe:
>  		 * Do not check for cmd->silent_exec_failure; the parent
>  		 * process will check it when it sees this exit code.
>  		 */
> -		if (errno == ENOENT)
> +		if (errno == ENOENT) {
> +			if (!cmd->silent_exec_failure)
> +				error("cannot run %s: %s", cmd->argv[0],
> +					strerror(ENOENT));

This change is not good enough: There is no guarantee that this message
goes to the right channel (stderr in the child can be redirected). Look
carefully: We set a special die routine in the forked child that ensures
that the die() messages are written to the right channel; we do not have
a similar facility for error() messages (or do we?).

>  			exit(127);
> -		else
> +		} else {
>  			die_errno("cannot exec '%s'", cmd->argv[0]);
> +		}
>  	}
>  	if (cmd->pid < 0)
>  		error("cannot fork() for %s: %s", cmd->argv[0],

-- Hannes
