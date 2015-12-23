From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Wed, 23 Dec 2015 16:31:40 -0500
Message-ID: <20151223213140.GB21277@sigill.intra.peff.net>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1450597819-26278-1-git-send-email-pclouds@gmail.com>
 <xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DFmZSa2x4y2fDwVsvwa5uAuMJn8v=utvYtAPTGFbdWPg@mail.gmail.com>
 <CACsJy8A5AcRj2HiLe3PQijhYcHMzJ6eEuMyeVTMvPtXvMg_Sug@mail.gmail.com>
 <xmqqd1tye4i8.fsf@gitster.mtv.corp.google.com>
 <20151223093700.GA13386@sigill.intra.peff.net>
 <567B05F0.5020604@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Dec 23 22:31:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBr0d-0008W0-Ok
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 22:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965453AbbLWVbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 16:31:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:45732 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965289AbbLWVbn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 16:31:43 -0500
Received: (qmail 16503 invoked by uid 102); 23 Dec 2015 21:31:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Dec 2015 15:31:43 -0600
Received: (qmail 11341 invoked by uid 107); 23 Dec 2015 21:31:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Dec 2015 16:31:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Dec 2015 16:31:40 -0500
Content-Disposition: inline
In-Reply-To: <567B05F0.5020604@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282967>

On Wed, Dec 23, 2015 at 09:37:04PM +0100, Johannes Sixt wrote:

> >--- a/git.c
> >+++ b/git.c
> >@@ -252,7 +252,7 @@ static int handle_alias(int *argcp, const char ***argv)
> >  			alias_argv[argc] = NULL;
> >
> >  			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
> >-			if (ret >= 0)   /* normal exit */
> >+			if (ret != -1)  /* normal exit */
> 
> Why does this make a difference? We only ever return -1, zero, or a positive
> value from run_command/finish_command/wait_or_whine, as far as I can see.

Yeah, you're right. This bit predates 709ca73 (run-command: encode
signal death as a positive integer, 2013-01-05), which came out of the
same discussion. So I'd agree this hunk can simply be dropped.

That leaves the ignoring of SIGPIPE in wait_or_whine. I started to
rewrite the commit message to drop the first hunk, but I found I
couldn't replicate the problem in the second either!

Doing:

  GIT_PAGER=false git -c alias.foo='!git log -p' foo

doesn't trigger it. We run the alias through a shell, so we see only the
munged "141" value from the shell's exit code.

Something like:

  GIT_PAGER=false git -p -c alias.foo='!yes' foo

does generate the error message. But we've redirected stderr into the
pager at that point, so by definition it can never be shown.

So I think we would need a case where:

  - the outer git doesn't run the pager that dies; instead the pager is
    run inside the alias. But...

  - inside the alias cannot be a shell pipeline, since "foo | less" will
    report the exit code of "less", not "foo" (we make special arrangements
    in git to propagate the exit code of "foo"). So it pretty much has
    to be a git invocation inside the alias. But...

  - The git invocation will convert signal death in the sub-process into
    141, like a shell would.

So I'm not sure if this is triggerable at all with an alias.

I did manage to trigger it with an external command, like:

  $ cat $(which git-yes)
  #!/bin/sh
  # This _has_ to be exec, otherwise the shell converts SIGPIPE death
  # into 141.
  exec yes

and then if you run your _own_ pager, like this:

  $ git yes | false
  error: git-yes died of signal 13

you see it. But if git starts the pager, you don't:

  $ GIT_PAGER=false git -p yes

Because the stderr of the outer git process is going to the same dead
pipe.

So my takeaways are:

  1. Complaining about signal death in general is going to be flaky,
     because it's so easy for shells or git to rewrite the exit code and
     not trigger WIFSIGNALED() in the first place.

  2. I doubt anybody is actually seeing this in practice anymore. But
     maybe I am misunderstanding something in Duy's series that changes
     this.

-Peff
