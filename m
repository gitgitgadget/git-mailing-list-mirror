From: Jeff King <peff@peff.net>
Subject: Re: RFC: [PATCH] ignore SIGINT&QUIT while waiting for external
 command
Date: Tue, 19 Oct 2010 09:32:36 -0400
Message-ID: <20101019133236.GA804@sigill.intra.peff.net>
References: <20101019045300.GA18043@gnu.kitenet.net>
 <AANLkTi=tvyzyz2xpezufHLFc44HDbtMibkhNEvYxPB2g@mail.gmail.com>
 <20101019115943.GA8065@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Joey Hess <joey@kitenet.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 15:32:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8CIV-0007mc-WD
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 15:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758604Ab0JSNcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 09:32:04 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38355 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758488Ab0JSNcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 09:32:03 -0400
Received: (qmail 13190 invoked by uid 111); 19 Oct 2010 13:32:00 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 19 Oct 2010 13:32:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Oct 2010 09:32:36 -0400
Content-Disposition: inline
In-Reply-To: <20101019115943.GA8065@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159325>

On Tue, Oct 19, 2010 at 03:59:43PM +0400, Dmitry Potapov wrote:

> The solution is to disable SIGINT and SIGQUIT as it is normally done by
> system(). Disabling these signals is done only when silent_exec_failure
> is set, which means that the current process is used as a proxy to run
> another command.

I don't understand why we would only do it for silent_exec_failure. You
claim that flag means that the current process is a proxy for another
command, but:

  1. Is that really the case, or do the two things just happen to
     coincide in the current codebase?

  2. Why do we want to do it only for the proxy-command case? If I have
     a long-running external diff or merge helper, for example, what
     should happen on SIGINT? Should we exit with the child still
     potentially running, or should we actually be reaping the child
     properly?

> +	if (cmd->silent_exec_failure) {
> +		sigint = signal(SIGINT, SIG_IGN);
> +		sigquit = signal(SIGQUIT, SIG_IGN);
> +	}
>  	cmd->pid = fork();
>  	if (!cmd->pid) {
> +		if (cmd->silent_exec_failure) {
> +			signal(SIGINT, sigint);
> +			signal(SIGQUIT, sigquit);
> +		}

How does this interact with the sigchain code? If I do:

  start_command(...);
  sigchain_push(...);
  finish_command(...);

we will overwrite the function pushed in the sigchain_push with a stale
handler. I think you could just replace your signal() calls with:

  sigchain_push(SIGINT, SIG_IGN);
  ...
  sigchain_pop(SIGINT);

but I wonder if ignoring is necessarily the right thing. Shouldn't we
just reap the child and then run the signal handler that was there
before us? That means in general that we will continue to die via SIGINT
when we see SIGINT. With your patch, we will ignore it and (presumably)
end up dying with a return code indicated that the child had an error.

I think both of these things are not problems for executing dashed
externals. But as above, I am not sure that we should be limiting this
signal handling to those cases.

-Peff
