From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3]
Date: Sat, 18 Feb 2012 03:52:21 -0500
Message-ID: <20120218085221.GA13922@sigill.intra.peff.net>
References: <7v7gzmxw78.fsf@alter.siamese.dyndns.org>
 <cover.1329472405.git.trast@student.ethz.ch>
 <7v62f5v1d1.fsf@alter.siamese.dyndns.org>
 <7vk43lqbt8.fsf@alter.siamese.dyndns.org>
 <20120218005148.GA1940@sigill.intra.peff.net>
 <7v8vk0r481.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, Jehan Bing <jehan@orb.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 18 09:52:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ryg1u-0007gk-Fb
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 09:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab2BRIwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 03:52:24 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41416
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628Ab2BRIwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 03:52:23 -0500
Received: (qmail 16945 invoked by uid 107); 18 Feb 2012 08:52:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 18 Feb 2012 03:52:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Feb 2012 03:52:21 -0500
Content-Disposition: inline
In-Reply-To: <7v8vk0r481.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191000>

On Fri, Feb 17, 2012 at 11:27:26PM -0800, Junio C Hamano wrote:

> > I'd be happy if we just ignored SIGPIPE everywhere, but turned it on for
> > the log family.
> 
> Hmmmm, now you confused me...  What is special about the log family?  Do
> you mean "when we use pager"?  But then we are writing into the pager,
> which the user can make it exit, which in turn causes us to write into the
> pipe, so I would expect that we would want to ignore SIGPIPE --- ah, then
> we explicitly catch error in xwrite() and say die() which we do not want.

Sort of. I mentioned the log family because those are the commands that
tend to generate large amounts of input, and which are likely to hit
SIGPIPE. But let me elaborate on my thinking a bit.

There are basically three types of writing callsites in git:

  1. Careful calls to write() or fwrite().

     These are the majority of calls. In these, we check the return
     value of write() and die, return the error code, or whatever is
     appropriate for the callsite. SIGPIPE kills the program before the
     careful code gets the chance to make a decision about what to do.
     At best, this is a nuisance; even if the program is going to die(),
     it's likely that the custom code could produce a useful error
     message. At worst it causes bugs. For example, we may write to a
     subprocess that only needs part of our input to make a decision
     (e.g., some hooks and credential helpers). With SIGPIPE, we end up
     dying even though no error has occurred. Worse, these are often
     annoying heisenbugs that depend on the timing of write() and
     close() between the two processes.

  2. Non-careful calls of small, fixed-size output.

     Things like "git remote" will write some output to stdout via
     printf and not bother checking the return code. As the main purpose
     of the program is to create output, it's OK to be killed by
     SIGPIPE if it happens due to a write to stdout. But respecting
     SIGPIPE doesn't buy as all that much. It might save us from making
     a few write() calls that will go to nowhere, but most of the work
     has already been done by the time we are outputting.

     And it has a cost to the other careful write calls in the same
     program, because respecting SIGPIPE is a per-process thing. So for
     something like "git remote show foo", while we would like SIGPIPE
     to kick in for output to stdout, we would not want it for a pipe we
     opened to talk to ls-remote.

  3. Non-careful calls of large, streaming data.

     Commands like "git log" will non-carefully output to stdout, as
     well, but they will generate tons of data, consuming possibly
     minutes of CPU time (e.g., "git log -p"). If whoever is reading the
     output stops doing so, we really want to kill the program to avoid
     wasting CPU time.  In this instance, SIGPIPE is a big win.

     It still has the downside that careful calls in the same program
     will be subject to using SIGPIPE. For "log" and friends, this is
     probably OK with the current code, as we don't make a lot of pipes.
     But that is somewhat of an implementation detail. E.g., "git log
     -p" with external diff or textconv writes to a tempfile, and then
     runs a subprocess with the tempfile as input. But we could just as
     easily have used pipes, and may choose to do so in the future. You
     may even be able to trigger a convert_to_git filter in the current
     code, which does use pipes.

So basically, I find SIGPIPE to be a simplistic too-heavy hammer that
ends up affecting all writes to pipes, when in reality we are only
interested in affecting ones to some "main" output (usually stdout).
That works OK for small Unix-y programs like "head", but is overly
simplistic for something as big as git.

In an ideal world, we could set a per-descriptor version of SIGPIPE, and
just turn it on for stdout (or somehow find out which descriptor caused
the SIGPIPE after the fact). But that's not possible.

So our next best thing would be to actually check the results of
these non-careful writes. Unfortunately, this means either:

  a. wrapping every printf with a function that will appropriately die
     on error. This makes the code more cumbersome.

  or

  b. occasionally checking ferror(stdout) while doing long streams
     (e.g., checking it after each commit is written in git log, and
     aborting if we saw a write error). This is less cumbersome, but it
     does mean that errno may or may not still be accurate by the time
     we notice the error. So it's hard to reliably differentiate EPIPE
     from other errors. It would be nice, for example, to have git log
     exit silently on EPIPE, but properly print an error for something
     like ENOSPC. But perhaps that isn't a big deal, as I believe right
     now that we would silently ignore something like ENOSPC.

Less robust than that is to just ignore SIGPIPE in most git programs
(which don't benefit from it, and where it is only a liability), but
then manually enable it for the few that care (the log family, and
perhaps diff. Maybe things like "git tag -l", though that output tends
to be pretty small). But I think it would work OK in practice, because
those commands don't tend to make pipes other than the "main" output.
And it's quite easy to implement.

> So you want to let SIGPIPE silently kill us when the pager is in use; is
> that it?

That's an OK heuristic, as the pager being in use is a good sign that we
will generate long, streaming output. It has two downsides, though. One
is that it suffers from the too-heavy hammer of the preceding paragraph.
The other is that it only catches when _we_ create the pipe. You would
also want to catch something like:

  git rev-list | head

and stop the traversal. So I think it is less about whether a pager is
in use and more about whether we are creating long output that would
benefit from being cut off early. The pager is an indicator of that, but
it's not a perfect one; I think we'd do better to mark those spots
manually (i.e., by re-enabling SIGPIPE in commands that we deem
appropriate).

-Peff
