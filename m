From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] start_command(), if .in/.out > 0, closes file
 descriptors, not the callers
Date: Sat, 16 Feb 2008 14:55:21 -0800
Message-ID: <7vmyq07bqe.fsf@gitster.siamese.dyndns.org>
References: <7v1w7dhnov.fsf@gitster.siamese.dyndns.org>
 <1203183399-4813-1-git-send-email-johannes.sixt@telecom.at>
 <1203183399-4813-2-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Feb 16 23:56:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQVx2-0003CZ-S6
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 23:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbYBPWze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 17:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbYBPWze
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 17:55:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbYBPWzd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 17:55:33 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EB1C162FC;
	Sat, 16 Feb 2008 17:55:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 0AC1A62F9; Sat, 16 Feb 2008 17:55:23 -0500 (EST)
In-Reply-To: <1203183399-4813-2-git-send-email-johannes.sixt@telecom.at>
 (Johannes Sixt's message of "Sat, 16 Feb 2008 18:36:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74084>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Callers of start_command() can set the members .in and .out of struct
> child_process to a value > 0 to specify that this descriptor is used as
> the stdin or stdout of the child process.
>
> Previously, if start_command() was successful, this descriptor was closed
> upon return. Here we now make sure that the descriptor is also closed in
> case of failures. All callers are updated not to close the file descriptor
> themselves after start_command() was called.

These two patches make the calling convention more uniform and
it feels like a good clean-up of the semantics.

But I have to wonder...

> diff --git a/run-command.c b/run-command.c
> index 2919330..6c35d3c 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -20,10 +20,18 @@ int start_command(struct child_process *cmd)
>  	int need_in, need_out, need_err;
>  	int fdin[2], fdout[2], fderr[2];
>  
> +	/*
> +	 * In case of errors we must keep the promise to close FDs
> +	 * that have been passed in in ->in, ->out, and ->err.
> +	 */
> +
>  	need_in = !cmd->no_stdin && cmd->in < 0;
>  	if (need_in) {
> -		if (pipe(fdin) < 0)
> +		if (pipe(fdin) < 0) {
> +			if (cmd->out > 1)
> +				close(cmd->out);

Why check for "2 or more"?

Could the caller have specified FD #1 (its own usual stdout) to
be used by the child?

> @@ -34,6 +42,8 @@ int start_command(struct child_process *cmd)
>  		if (pipe(fdout) < 0) {
>  			if (need_in)
>  				close_pair(fdin);
> +			else if (cmd->in)
> +				close(cmd->in);

Likewise, could the caller have told the child to use its own
stdin?

> @@ -55,8 +69,12 @@ int start_command(struct child_process *cmd)
>  	if (cmd->pid < 0) {
>  		if (need_in)
>  			close_pair(fdin);
> +		else if (cmd->in > 0)
> +			close(cmd->in);

Here "in" is checked for "1 or more", unlike the above hunk...

> diff --git a/run-command.h b/run-command.h
> index e9c84d0..0e67472 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -14,6 +14,23 @@ enum {
>  struct child_process {
>  	const char **argv;
>  	pid_t pid;
> +	/*
> +	 * Using .in, .out, .err:
> +	 * - Specify 0 to inherit stdin, stdout, stderr from parent.

Wouldn't this be better if 0, 1, or 2 specify inheriting
these respectively?

I am confused...

> +	 * - Specify > 0 to give away a FD as follows:
> +	 *     .in: a readable FD, becomes child's stdin
> +	 *     .out: a writable FD, becomes child's stdout/stderr
> +	 *     .err > 0 not supported
> +	 *   The specified FD is closed by start_command(), even in case
> +	 *   of errors!

Perhaps you would need to spell out the semantic differences you
are assigning to "inherit" vs "give away".  I presume the former
is something run_command() would not touch vs the latter is
closed by run_command()?
