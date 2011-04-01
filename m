From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 13:38:08 -0400
Message-ID: <20110401173808.GA24934@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <AANLkTikF_xLTdY0BgaXmUXvBJTG3HD3by9zN59KwPii5@mail.gmail.com>
 <AANLkTin3+PzYcQEaaxgr9_5mgDGO5oiYDyBD_2tJqCTk@mail.gmail.com>
 <201104011927.03366.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:38:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5iIb-0005uY-Bl
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 19:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab1DARiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 13:38:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38834
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab1DARiL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 13:38:11 -0400
Received: (qmail 12657 invoked by uid 107); 1 Apr 2011 17:38:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Apr 2011 13:38:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2011 13:38:08 -0400
Content-Disposition: inline
In-Reply-To: <201104011927.03366.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170598>

On Fri, Apr 01, 2011 at 07:27:03PM +0200, Johannes Sixt wrote:

> > OK, I've read up on thread-cancellation, and this code seems correct.
> > pthread_cancel doesn't kill the thread right away, it just signals a
> > cancellation-event, which is checked for at certain
> > cancellation-points. A lot of the CRT functions are defined as
> > cancellation points, so it'll be a matter for us Win32-guys to
> > implement pthread_testcancel() and inject that into the
> > function-wrappers of the CRT functions that are marked as
> > cancellation-points.
> 
> That's not going to happen. We cannot implement pthread_cancel() on Windows 
> because it would have to be able to interrupt blocking system calls. 
> (TerminateThread() is a no-no, given all the caveats about leaking system 
> resources that are mentioned in the manual.)
> 
> [OK, "cannot" is a hard word. It is possible in some way, I'm sure. But that 
> would mean that we implement the equivalent of Cygwin or so...]
> 
> But if I understand correctly what Jeff wrote so far, then the pthreaded case 
> happens to work - by chance or by design, we don't know (yet). Perhaps we can 
> get away with
> 
> -	/* no clue */
> +	/* pthread_cancel(async->tid); not necessary */

Yeah, I think that would probably work, but I haven't had a chance yet
to look deeper into why the pthread case doesn't hang.

I have another case, too, which is that killing a "git push" in progress
via signal will leave crufty child-processes around, still trying to
push.  One of these is the pack-objects sub-process, and the other is
(in the no-pthreads case) the sideband demuxer.

And obviously fixing that involves aborting the async process, too[1].
But we can again get away without pthread_cancel, because in the pthread
case, we can just rely on the parent process dying to take down the
thread.

-Peff

[1] Actually, my plan is to set up a signal/atexit handler to kill off
children.  Run-command callers can specify an option for "yes, this
child should be killed if I am killed". Async callers will have it
turned on automatically (since they won't even know if it's a subthread
or a different process).  So we won't actually be calling abort_async()
anyway.
