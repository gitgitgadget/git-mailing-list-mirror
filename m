From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] run-command: add new check_command helper
Date: Sun, 07 Apr 2013 10:47:56 -0700
Message-ID: <7v1uam44hf.fsf@alter.siamese.dyndns.org>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
 <1365320706-13539-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:48:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOthE-0003ap-HV
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934203Ab3DGRsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:48:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55639 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934151Ab3DGRr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:47:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEDEA13E0A;
	Sun,  7 Apr 2013 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hu9UZP04fXd4S+N6LZLGmK0npJg=; b=SsqQp/
	cncRAfzB/7zWSyfaZ6ZRCOGA0vVyyyypavvvaSYBWjUk1bheeulWX0uCMOOUPoX5
	jW+3M3wQdROyZ25U7J/xGyWo8kaIoQ7fEAuUEllcLFBAC1eA9p8u1WqrKnLWw+93
	/I7mrFY9WSl4GW9fWjtrDmGYSw9XJw8h4VhZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EdosMcjou86ooPmOPaoLrkylfRY0S1dD
	s/vDgd5vRy7/k+06yRn12sVB7UFkFOifO+Camh/UAqe76hoOjbWxY4JTLtAeTg5K
	G3hQn+/avQ33AK6z4+SGgq7hc4xHLhbuUhmKHAky5JNkhS6m+n5Z1yO8CHwYUtSi
	4ihHmTRu6lg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B209513E08;
	Sun,  7 Apr 2013 17:47:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 074AA13E03; Sun,  7 Apr
 2013 17:47:58 +0000 (UTC)
In-Reply-To: <1365320706-13539-2-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 7 Apr 2013 01:45:05 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48A050C4-9FAB-11E2-AD95-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220342>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> And to recover the information from the last run when running
> wait_or_whine().
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

The above says what the updated wait_or_whine() does (it returns the
state an earlier call to check_command() has already polled to
determine), but lacks what the added check_command() does and why it
is needed.  I am guessing:

	In a codeflow like _this_ calls _that_ calls _that-other_,
	and finally the original caller culls the subprocesses by
	wait-or-whine, there is no good way for an intermediate
	level to detect dead child and abort the process early.
	They can now poll the status with check_command() without
	blocking in order to do so.

	wait_or_while() is adjusted to correctly report the status
	of the child that was already culled by an earlier call to
	check_command().  check_command() itself uses the same
	mechanism to indicate that the child was already culled, so
	that it is safe to call it more than once on the same child
	process.

might be a more understandable description for this change, but
these _this_, _that_ and _that-other_ blanks need to be filled.

>  run-command.c | 46 ++++++++++++++++++++++++++++++++++++++++------
>  run-command.h |  5 +++++
>  2 files changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 07e27ff..5cb5114 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -226,14 +226,20 @@ static inline void set_cloexec(int fd)
>  		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
>  }
>  
> -static int wait_or_whine(pid_t pid, const char *argv0)
> +static int wait_or_whine(struct child_process *cmd, pid_t pid, const char *argv0)
>  {
>  	int status, code = -1;
>  	pid_t waiting;
>  	int failed_errno = 0;
>  
> -	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
> -		;	/* nothing */
> +	/* First try the last status from check_command() */
> +	if (cmd && cmd->last_status.valid) {
> +		status = cmd->last_status.status;
> +		waiting = pid;
> +	} else {
> +		while ((waiting = waitpid(pid, status, 0)) < 0 && errno == EINTR)
> +			;	/* nothing */
> +	}
>  
>  	if (waiting < 0) {
>  		failed_errno = errno;
> @@ -276,6 +282,8 @@ int start_command(struct child_process *cmd)
>  	int failed_errno = failed_errno;
>  	char *str;
>  
> +	cmd->last_status.valid = 0;
> +
>  	/*
>  	 * In case of errors we must keep the promise to close FDs
>  	 * that have been passed in via ->in and ->out.
> @@ -437,7 +445,7 @@ fail_pipe:
>  		 * At this point we know that fork() succeeded, but execvp()
>  		 * failed. Errors have been reported to our stderr.
>  		 */
> -		wait_or_whine(cmd->pid, cmd->argv[0]);
> +		wait_or_whine(cmd, cmd->pid, cmd->argv[0]);
>  		failed_errno = errno;
>  		cmd->pid = -1;
>  	}
> @@ -542,7 +550,7 @@ fail_pipe:
>  
>  int finish_command(struct child_process *cmd)
>  {
> -	return wait_or_whine(cmd->pid, cmd->argv[0]);
> +	return wait_or_whine(cmd, cmd->pid, cmd->argv[0]);
>  }
>  
>  int run_command(struct child_process *cmd)
> @@ -553,6 +561,32 @@ int run_command(struct child_process *cmd)
>  	return finish_command(cmd);
>  }
>  
> +int check_command(struct child_process *cmd)
> +{
> +	int status;
> +	pid_t waiting;
> +
> +	if (cmd->last_status.valid)
> +		return 0;
> +
> +	while ((waiting = waitpid(cmd->pid, &status, WNOHANG)) < 0 && errno == EINTR)
> +		; /* nothing */
> +
> +	if (!waiting)
> +		return 1;
> +
> +	if (waiting == cmd->pid) {
> +		cmd->last_status.valid = 1;
> +		cmd->last_status.status = status;
> +		return 0;
> +	}
> +
> +	if (waiting > 0)
> +		die("BUG: waitpid reported a random pid?");
> +
> +	return 0;
> +}
> +
>  static void prepare_run_command_v_opt(struct child_process *cmd,
>  				      const char **argv,
>  				      int opt)
> @@ -729,7 +763,7 @@ error:
>  int finish_async(struct async *async)
>  {
>  #ifdef NO_PTHREADS
> -	return wait_or_whine(async->pid, "child process");
> +	return wait_or_whine(NULL, async->pid, "child process");
>  #else
>  	void *ret = (void *)(intptr_t)(-1);
>  
> diff --git a/run-command.h b/run-command.h
> index 221ce33..74a733d 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -39,11 +39,16 @@ struct child_process {
>  	unsigned stdout_to_stderr:1;
>  	unsigned use_shell:1;
>  	unsigned clean_on_exit:1;
> +	struct last_status {
> +		unsigned valid:1;
> +		int status;
> +	} last_status;
>  };
>  
>  int start_command(struct child_process *);
>  int finish_command(struct child_process *);
>  int run_command(struct child_process *);
> +int check_command(struct child_process *);
>  
>  extern char *find_hook(const char *name);
>  extern int run_hook(const char *index_file, const char *name, ...);
