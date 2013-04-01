From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] run-command: add new check_command helper
Date: Mon, 1 Apr 2013 19:23:26 -0400
Message-ID: <20130401232326.GA30935@sigill.intra.peff.net>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
 <1364852804-31875-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 01:23:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMo50-0004VF-Rp
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 01:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671Ab3DAXXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 19:23:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51367 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473Ab3DAXX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 19:23:29 -0400
Received: (qmail 3588 invoked by uid 107); 1 Apr 2013 23:25:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Apr 2013 19:25:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Apr 2013 19:23:26 -0400
Content-Disposition: inline
In-Reply-To: <1364852804-31875-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219724>

On Mon, Apr 01, 2013 at 03:46:41PM -0600, Felipe Contreras wrote:

> And persistent_waitpid() to recover the information from the last run.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

A little background would be nice here...what problem are we solving?

> -static int wait_or_whine(pid_t pid, const char *argv0)
> +static pid_t persistent_waitpid(struct child_process *cmd, pid_t pid, int *stat_loc)
> +{
> +	if (cmd->last_wait.code) {
> +		errno = cmd->last_wait.failed_errno;
> +		*stat_loc = cmd->last_wait.status;
> +		return errno ? -1 : pid;
> +	} else {
> +		pid_t waiting;
> +		while ((waiting = waitpid(pid, stat_loc, 0)) < 0 && errno == EINTR)
> +			;	/* nothing */
> +		return waiting;
> +	}
> +}

So it looks we are trying to save the waitpid state from a previous run
and use the saved value. Otherwise, waitpid as normal.

We loop on EINTR when we actually call waitpid(). But we don't check
whether the saved errno is waitpid. What happens if we EINTR during the
saved call to waitpid?

> +static int wait_or_whine(struct child_process *cmd, pid_t pid, const char *argv0)
>  {
>  	int status, code = -1;
>  	pid_t waiting;
>  	int failed_errno = 0;
>  
> -	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
> -		;	/* nothing */
> +	waiting = persistent_waitpid(cmd, pid, &status);
>  
>  	if (waiting < 0) {
>  		failed_errno = errno;

We now take argv0 into wait_or_whine. But I don't see it being used.
What's it for?

> +int check_command(struct child_process *cmd)
> +{
> +	int status;
> +	pid_t waiting;
> +	int failed_errno = 0;
> +
> +	waiting = waitpid(cmd->pid, &status, WNOHANG);

This might return the pid if it has died, -1 if there was an error, or 0
if the process still exists but hasn't died. So...

> +	if (waiting != cmd->pid)
> +		return 1;
> +
> +	if (waiting < 0)
> +		failed_errno = errno;

How would we ever trigger this second conditional? It makes sense to
return 1 when "waiting == 0", as that is saying "yes, your process is
still running" (though documenting the return either at the top of the
function or in the commit message would be helpful)

But if we get an error from waitpid, we would also return 1, which
doesn't make sense (especially if it is something like EINTR -- I don't
know offhand if we can get EINTR during WNOHANG. It should not block,
but I don't know if it can race with a signal).

> +	cmd->last_wait.code = -1;
> +	cmd->last_wait.failed_errno = failed_errno;
> +	cmd->last_wait.status = status;

Since we can only get here when waiting == cmd->pid, failed_errno is
always 0. We do correctly record the status. Why is code set to -1?  It
seems to be used as a flag to say "this structure is valid". Should it
be defined as "unsigned valid:1;" instead?

-Peff
