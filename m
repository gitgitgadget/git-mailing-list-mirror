From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/4] send-pack: abort sideband demuxer on pack-objects error
Date: Thu, 14 Apr 2011 22:43:33 +0200
Message-ID: <201104142243.33522.j6t@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104142136.25778.j6t@kdbg.org> <20110414202110.GA6525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 22:43:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QATOC-0001ei-RX
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 22:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab1DNUnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 16:43:39 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:26555 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751187Ab1DNUni (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 16:43:38 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1AE2F130047;
	Thu, 14 Apr 2011 22:43:34 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9C43A19F610;
	Thu, 14 Apr 2011 22:43:33 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20110414202110.GA6525@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171548>

On Donnerstag, 14. April 2011, Jeff King wrote:
> On Thu, Apr 14, 2011 at 09:36:25PM +0200, Johannes Sixt wrote:
> > On Donnerstag, 14. April 2011, Jeff King wrote:
> > > Obviously it totally breaks the start_async abstraction if the called
> > > code needs to care whether it forked or not. But we can use that to our
> > > advantage, since it means start_async callers must assume the interface
> > > is very limited.  So I think we can do something like:
> > >
> > >   1. Async code declares which file descriptors it cares about. This
> > >      would automatically include the pipe we give to it, of course.
> > >      So the declared ones for a sideband demuxer would be stderr, and
> > >      some network fd for reading.
> > >
> > >   2. In the pthreads case, we do nothing. In the forked case, the child
> > >      closes every descriptor except the "interesting" ones.
> > >
> > > And that solves this problem, and the general case that async-callers
> > > have no idea if they have just leaked pipe descriptors in the forked
> > > case.
> >
> > Sounds like a plan. How do you close all file descriptors? Just iterate
> > up to getrlimit(RLIMIT_NOFILE)?
>
> Sadly, yes, I think that is what we would have to do. It does feel like
> an awful hack. And it will interact badly with things like valgrind,
> which open descriptors behind the scenes (but can properly handle
> the forking).
>
> I just don't see another way around it for the general case.  The
> "usual" fix for this sort of thing is that the descriptors should have
> close-on-exec set, but that doesn't work for us here, because we are
> only forking.
>
> It's sufficiently ugly (and still possible to break in the pthreads
> case!) that it may be worth not worrying about the general case at all,
> and just fixing this one with the explicit close.
>
> > > I'm still slightly confused, though, because I never see that
> > > descriptor get closed in the threaded case. So I still don't understand
> > > why it _doesn't_ deadlock with pthreads.
> >
> > In the threaded case, this fd is closed by start_command(), where it is
> > passed as po.out in pack_objects(). In the fork case this is too late
> > because a duplicate was already inherited to the sideband demuxer.
>
> Hrm, I see the code now. That seems like an odd thing to do to me.

Why so? It's a matter of resource ownership: If you pass a positive value, you 
give away ownership; if you pass -1, you gain ownership; if you pass 0, 
ownership remains unchanged.

> Doesn't it disallow:
>
>   /* set up a command */
>   const char **argv = { "some", "command" };
>   struct child_process c;
>   c.argv = argv;
>   c.out = fd;
>
>   /* run it */
>   run_command(&c);
>
>   /* now tack our own output to the end */
>   write(fd, "foo", 3);

You would have to dup() the fd before run_command().

> And even weirder, we only do the close for high file descriptors. So you
> _can_ do that above if "fd" is stdout, but not with an arbitrary fd.

Ah, right, that's a bit dubious. The reason is that if you want to tell the 
child process to use the parent's stdout for its own stdout, you specify 0 
aka "no special treatement", i.e. just inherit from the parent, not 1. IOW, 1 
is never a sane candidate to be assigned to c.out.

-- Hannes
