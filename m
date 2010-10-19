From: Jeff King <peff@peff.net>
Subject: Re: RFC: [PATCH] ignore SIGINT&QUIT while waiting for external
 command
Date: Tue, 19 Oct 2010 15:50:22 -0400
Message-ID: <20101019195022.GA7287@sigill.intra.peff.net>
References: <20101019045300.GA18043@gnu.kitenet.net>
 <AANLkTi=tvyzyz2xpezufHLFc44HDbtMibkhNEvYxPB2g@mail.gmail.com>
 <20101019115943.GA8065@dpotapov.dyndns.org>
 <20101019133236.GA804@sigill.intra.peff.net>
 <20101019134040.GA3956@sigill.intra.peff.net>
 <20101019191638.GI25139@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Joey Hess <joey@kitenet.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 21:49:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8IC1-0006yv-FD
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 21:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab0JSTts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 15:49:48 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33171 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117Ab0JSTtr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 15:49:47 -0400
Received: (qmail 16081 invoked by uid 111); 19 Oct 2010 19:49:43 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 19 Oct 2010 19:49:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Oct 2010 15:50:22 -0400
Content-Disposition: inline
In-Reply-To: <20101019191638.GI25139@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159360>

On Tue, Oct 19, 2010 at 02:16:38PM -0500, Jonathan Nieder wrote:

> I think sigchain_push ought to accept a context object.

But signal() doesn't, so we would have to install a wrapper function
that gets the signal and calls the sigchain_pushed callback with the
context object. But we can't always install the wrapper. We need to
check for SIG_IGN and SIG_DFL, and literally install those.

So I think it's do-able, but I tried to keep the original sigchain as
simple as possible.

> +static void interrupted_with_child(int sig)
> +{
> +	if (the_child && the_child->pid > 0) {
> +		while ((waiting = waitpid(pid, NULL, 0)) < 0 && errno == EINTR)
> +			;	/* nothing */
> +		the_child = NULL;
> +	}
> +	sigchain_pop(sig);
> +	raise(sig);
> +}
> +
>  int start_command(struct child_process *cmd)
>  {
>  	int need_in, need_out, need_err;
> @@ -206,8 +220,11 @@ fail_pipe:
>  		notify_pipe[0] = notify_pipe[1] = -1;
>  
>  	fflush(NULL);
> -	sigchain_push(SIGINT, SIG_IGN);
> -	sigchain_push(SIGQUIT, SIG_IGN);
> +	if (the_child)
> +		die("What?  _Two_ children?");
> +	the_child = cmd;

Yuck. You can get around that by pushing onto a linked list of children,
though.

Thinking about it more, though, I don't think we do necessarily want to
always wait for the child. There are really two main types of
run_command's we do:

  1. The run command is basically the new process. In an ideal world, we
     would exec into it, but we need the parent to hang around to do
     some kind of bookkeeping (like waiting for the pager to exit).

     E.g., running external dashed commands.

  2. We are running the command, and if we are killed, the command
     should go away too (because its point in running is to give us some
     information).

     E.g., running textconv filters.

And there are a few instances that don't fall into either category
(e.g., running the pager).

In case (1), we probably want to SIG_IGN, wait for the command to
finish, and then die with its exit code. If we do it right, the fact
that _it_ was killed by signal will be propagated, and the fact that we
weren't will be irrelevant.

In case (2), we probably want to keep a linked list of "expendable"
processes, and on signal death and atexit, go through the list and make
sure all are dead. This is how we handle tempfiles already in diff.c.

Given that there is only really one instance of (1), we can just code it
there. For (2), there are many such callers, but I don't know that the
mechanism necessarily needs to be included as part of run_command. A
separate module to manage the list and set up the signal handler would
be fine (though there is a race between fork() and signal death, so it
perhaps pays to get the newly created pid on the "expendable" list as
soon as possible, which may mean cooperating from run_command).

-Peff
