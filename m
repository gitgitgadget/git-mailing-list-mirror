From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Thu, 10 Jan 2013 12:22:49 -0800
Message-ID: <7vbocw23fq.fsf@alter.siamese.dyndns.org>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vr4lu3wx7.fsf@alter.siamese.dyndns.org>
 <20130109205116.GA24605@sigill.intra.peff.net>
 <7vehhu3u2y.fsf@alter.siamese.dyndns.org> <20130110001844.GC21054@google.com>
 <20130110112655.GB21993@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Bart Trojanowski <bart@jukie.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 21:23:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtOew-00045F-H0
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 21:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071Ab3AJUWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 15:22:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33478 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409Ab3AJUWw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 15:22:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB18AB62E;
	Thu, 10 Jan 2013 15:22:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r8GzzG+KD9Kodm66Z6xL/gNi8SY=; b=Lblfp7
	SIK9LJ3bxxN2O5j24aOdXAmNVh/tG6uh+zAKRpYMQW2ZBwFHOUA05TvnAnnTCsJN
	2AuSg1XFQgFA1IhZUE5eQ2TkJdmhJRsS1xxFtf5MEOs33b/8kVOcW1NFi0Z4ac7C
	PAiZNTPVaQ295TvdT8MNLJ5e7UcqGbJjryMWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZzenrgxCdwznv4hrMs2qZpzXpdO3A78
	a0AcYNdl3AISvj2cI7XdeE22HuYG2FitlOW2TfRKzj1jQlMJNVp/WZCZhtyCUHav
	jCeZH6KNZcHPHsOtj2wOicWjYo7s4jfRMjrS6v285q0UsJicFXdymreVIqKALrNN
	+GZCHglAdJk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFE8DB62D;
	Thu, 10 Jan 2013 15:22:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03CC7B62C; Thu, 10 Jan 2013
 15:22:50 -0500 (EST)
In-Reply-To: <20130110112655.GB21993@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 Jan 2013 06:26:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81B04DC4-5B63-11E2-8187-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213150>

Jeff King <peff@peff.net> writes:

> Maybe the right rule is "if we are using the shell to execute, do not
> mention SIGPIPE"? It seems a little iffy at first, but:
>
>   1. It tends to coincide with direct use of internal tools versus
>      external tools.
>
>   2. We do not reliably get SIGPIPE there, anyway, since most shells
>      will convert it into exit code 141 before we see it.
>
> I.e., something like:

Hmph.  That may be a good heuristics, but I wonder if we also want
to special case WIFEXITED(status) && WEXITSTATUS(status) == 141 to
pretend as if nothing went wrong, when ignore_sigpipe is in effect?

> diff --git a/run-command.c b/run-command.c
> index 24eaad5..8bd0b08 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -226,7 +226,7 @@ static inline void set_cloexec(int fd)
>  		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
>  }
>  
> -static int wait_or_whine(pid_t pid, const char *argv0)
> +static int wait_or_whine(pid_t pid, const char *argv0, int ignore_sigpipe)
>  {
>  	int status, code = -1;
>  	pid_t waiting;
> @@ -242,7 +242,8 @@ static int wait_or_whine(pid_t pid, const char *argv0)
>  		error("waitpid is confused (%s)", argv0);
>  	} else if (WIFSIGNALED(status)) {
>  		code = WTERMSIG(status);
> -		if (code != SIGINT && code != SIGQUIT)
> +		if (code != SIGINT && code != SIGQUIT &&
> +		    (!ignore_sigpipe || code != SIGPIPE))
>  			error("%s died of signal %d", argv0, code);
>  		/*
>  		 * This return value is chosen so that code & 0xff
> @@ -433,7 +434,7 @@ fail_pipe:
>  		 * At this point we know that fork() succeeded, but execvp()
>  		 * failed. Errors have been reported to our stderr.
>  		 */
> -		wait_or_whine(cmd->pid, cmd->argv[0]);
> +		wait_or_whine(cmd->pid, cmd->argv[0], 0);
>  		failed_errno = errno;
>  		cmd->pid = -1;
>  	}
> @@ -538,7 +539,7 @@ int finish_command(struct child_process *cmd)
>  
>  int finish_command(struct child_process *cmd)
>  {
> -	return wait_or_whine(cmd->pid, cmd->argv[0]);
> +	return wait_or_whine(cmd->pid, cmd->argv[0], cmd->use_shell);
>  }
>  
>  int run_command(struct child_process *cmd)
> @@ -725,7 +726,7 @@ int finish_async(struct async *async)
>  int finish_async(struct async *async)
>  {
>  #ifdef NO_PTHREADS
> -	return wait_or_whine(async->pid, "child process");
> +	return wait_or_whine(async->pid, "child process", 0);
>  #else
>  	void *ret = (void *)(intptr_t)(-1);
>  
