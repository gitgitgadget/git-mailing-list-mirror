From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] run-command: Be more informative about what failed
Date: Thu, 31 Jan 2013 08:24:21 -0800
Message-ID: <7vfw1hiami.fsf@alter.siamese.dyndns.org>
References: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org>
 <1359597666-10108-3-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 17:24:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0wwR-00084a-VS
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 17:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564Ab3AaQY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 11:24:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755494Ab3AaQYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 11:24:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C788BD0A;
	Thu, 31 Jan 2013 11:24:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FfxOu5oOtnC/t0vkhGI/E8bbORw=; b=NIjd3t
	77RrKQcIRWj1sWLkh35A6KRdUXYCQIxE6N1lmEimrmopqCw+U1dlcCx5yniGYuwm
	g49DRcd7LocC2mCEvP2RHzf0GegNzZPUiHsSIC63TdsghL58+bF/GAb9yXuyiRT1
	rq7rp88NUntDWT9yCPk6fq+yjmzmnMsFVXjj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yz2d7RXKh48p08ygJXQop/tHOkjTkqZh
	ttXSy2FGQ7HJY5xiDHDaDAZpGVA1jQwkoDnKlzAzr7vjsgZi2ZbfD8VOT5RX3c62
	oIH+uf6KBwxdmfoMLYb2HYcmCgEAzWHFuhOnTSGITSDOxRzSYhlSRZpAkd8PI65/
	hN2MhU6gWw4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F64ABD09;
	Thu, 31 Jan 2013 11:24:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75BF5BD07; Thu, 31 Jan 2013
 11:24:23 -0500 (EST)
In-Reply-To: <1359597666-10108-3-git-send-email-sboyd@codeaurora.org>
 (Stephen Boyd's message of "Wed, 30 Jan 2013 18:01:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC687EA0-6BC2-11E2-A8DB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215123>

Stephen Boyd <sboyd@codeaurora.org> writes:

> While debugging an error with verify_signed_buffer() the error
> messages from run-command weren't very useful:
>
>  error: cannot create pipe for gpg: Too many open files
>  error: could not run gpg.
>
> because they didn't indicate *which* pipe couldn't be created.

For the message emitted here with your update (or without for that
matter) to be useful, it has to hold that there is a single leaker,
that leaker fails in this codepath, and that there is nobody else
involved.  Otherwise, you may be able to tell that one caller could
not create its stdin, but the reason it couldn't may be because
somebody else consumed all the available file descriptors.

I am not opposed to this change per-se, but I am not sure that
saying "stdin" etc. makes the message more useful for the purpose of
debugging.

> For example, the above error now prints:
>
>  error: cannot create stderr pipe for gpg: Too many open files
>  error: could not run gpg.

I'd prefer to see these names spelled out (e.g. "standard error")
in any case.

Thanks.

> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

>  run-command.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 12d4ddb..016dd05 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -274,6 +274,7 @@ int start_command(struct child_process *cmd)
>  	int need_in, need_out, need_err;
>  	int fdin[2], fdout[2], fderr[2];
>  	int failed_errno = failed_errno;
> +	char *str;
>  
>  	/*
>  	 * In case of errors we must keep the promise to close FDs
> @@ -286,6 +287,7 @@ int start_command(struct child_process *cmd)
>  			failed_errno = errno;
>  			if (cmd->out > 0)
>  				close(cmd->out);
> +			str = "stdin";
>  			goto fail_pipe;
>  		}
>  		cmd->in = fdin[1];
> @@ -301,6 +303,7 @@ int start_command(struct child_process *cmd)
>  				close_pair(fdin);
>  			else if (cmd->in)
>  				close(cmd->in);
> +			str = "stdout";
>  			goto fail_pipe;
>  		}
>  		cmd->out = fdout[0];
> @@ -318,9 +321,10 @@ int start_command(struct child_process *cmd)
>  				close_pair(fdout);
>  			else if (cmd->out)
>  				close(cmd->out);
> +			str = "stderr";
>  fail_pipe:
> -			error("cannot create pipe for %s: %s",
> -				cmd->argv[0], strerror(failed_errno));
> +			error("cannot create %s pipe for %s: %s",
> +				str, cmd->argv[0], strerror(failed_errno));
>  			errno = failed_errno;
>  			return -1;
>  		}
