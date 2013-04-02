From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] run-command: add new check_command helper
Date: Mon, 1 Apr 2013 22:22:14 -0400
Message-ID: <20130402022214.GA719@sigill.intra.peff.net>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
 <1364852804-31875-2-git-send-email-felipe.contreras@gmail.com>
 <20130401232326.GA30935@sigill.intra.peff.net>
 <CAMP44s3NxBexkaQa=KxJ963L29T4BAn7e+-3YVz-vgUp8jrb4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 04:22:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMqs3-00056H-2o
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 04:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759850Ab3DBCWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 22:22:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51519 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759396Ab3DBCWS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 22:22:18 -0400
Received: (qmail 4728 invoked by uid 107); 2 Apr 2013 02:24:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Apr 2013 22:24:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Apr 2013 22:22:14 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3NxBexkaQa=KxJ963L29T4BAn7e+-3YVz-vgUp8jrb4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219730>

On Mon, Apr 01, 2013 at 05:58:55PM -0600, Felipe Contreras wrote:

> On Mon, Apr 1, 2013 at 5:23 PM, Jeff King <peff@peff.net> wrote:
> > On Mon, Apr 01, 2013 at 03:46:41PM -0600, Felipe Contreras wrote:
> 
> >> -static int wait_or_whine(pid_t pid, const char *argv0)
> >> +static pid_t persistent_waitpid(struct child_process *cmd, pid_t pid, int *stat_loc)
> >> +{
> >> +     if (cmd->last_wait.code) {
> >> +             errno = cmd->last_wait.failed_errno;
> >> +             *stat_loc = cmd->last_wait.status;
> >> +             return errno ? -1 : pid;
> >> +     } else {
> >> +             pid_t waiting;
> >> +             while ((waiting = waitpid(pid, stat_loc, 0)) < 0 && errno == EINTR)
> >> +                     ;       /* nothing */
> >> +             return waiting;
> >> +     }
> >> +}
> >
> > So it looks we are trying to save the waitpid state from a previous run
> > and use the saved value. Otherwise, waitpid as normal.
> >
> > We loop on EINTR when we actually call waitpid(). But we don't check
> > whether the saved errno is waitpid. What happens if we EINTR during the
> > saved call to waitpid?
> 
> Are you saying that even if we have stored the result of a waitpid
> command, if errno is EINTR, then we should still loop waitpid()? If
> so, I guess this would do the trick:

Yes, I think that would work. Though I wonder if it is even worth
storing EINTR at all in the first place. It tells us nothing. In fact,
does storing any error condition really tell us anything? The two states
we are interested in at this point are:

  1. We have reaped the child via waitpid; here is its status.

  2. We have not (either we did not try, it was not dead yet, or we were
     not able to due to an error). We should now try it again.

If we got EINTR the first time around, we would likely get the "real"
answer this time. If we get anything else (like EINVAL or ECHILD), then
we would get the same thing again calling waitpid() later.

> > We now take argv0 into wait_or_whine. But I don't see it being used.
> > What's it for?
> 
> It was there before:
> -static int wait_or_whine(pid_t pid, const char *argv0)
> +static int wait_or_whine(struct child_process *cmd, pid_t pid, const
> char *argv0)

Ah, sorry, I misread the diff. We are adding "cmd", not "argv0".

> >> +     if (waiting != cmd->pid)
> >> +             return 1;
> >> +
> >> +     if (waiting < 0)
> >> +             failed_errno = errno;
> >
> > How would we ever trigger this second conditional?
> [...]
> How about this?
> 
> if (waiting >= 0 && waiting != cmd->pid)
> 		return 1;

That would trigger the rest of your code in the error case, which I
think was your original intent. But then we return "0" from
check_command. Is that right?

There are three states we can be in from calling waitpid:

  1. The process is dead.

  2. The process is not dead.

  3. We could not determine which because waitpid returned an error.

It is clear that check_command is trying to tell its caller (1) or (2);
but what should it say in case of (3)?

Naively, given how patch 2 uses it, I think it would actually make sense
for it to return 1. That is, the semantics are "return 0 if and only if
the pid is verified to be dead; otherwise return 1".

But if we know from reading waitpid(3) that waitpid should only fail due
to EINTR, or due to bogus arguments (e.g., a pid that does not exist or
has already been reaped), then maybe something like this makes sense:

  while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
          ; /* nothing */

  /* pid definitely still going */
  if (!waiting)
          return 1;

  /* pid definitely died */
  if (waiting == cmd->pid) {
          cmd->last_status.valid = 1;
          cmd->last_status.status = status;
          return 0;
  }

  /*
   * this should never happen, since we handed waitpid() a single
   * pid, so it should either return that pid, 0, or an error.
   */
  if (waiting > 0)
          die("BUG: waitpid reported a random pid?");

  /*
   * otherwise, we have an error. Assume the pid is gone, since that
   * is the only reason for waitpid to report a problem besides EINTR.
   * We don't bother recording errno, since we can just repeat
   * the waitpid again later.
   */
   return 0;

> >> +     cmd->last_wait.code = -1;
> >> +     cmd->last_wait.failed_errno = failed_errno;
> >> +     cmd->last_wait.status = status;
> >
> > Since we can only get here when waiting == cmd->pid,
> 
> No, also when waiting < 0.

After the fix above, yes; in the original we would always have exited
already.

As an aside, should check_command be able to be called twice? That is,
should it first check for cmd->last_status.valid and return early if
somebody has already reaped the child? It doesn't matter for the code
you add in patch 2, but it seems like it would give the least surprise
to somebody trying to use it later.

-Peff
