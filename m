From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] send-pack: abort sideband demuxer on pack-objects
 error
Date: Thu, 14 Apr 2011 16:51:13 -0400
Message-ID: <20110414205113.GA7451@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <201104142136.25778.j6t@kdbg.org>
 <20110414202110.GA6525@sigill.intra.peff.net>
 <201104142243.33522.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 22:51:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QATVZ-0006K2-Nt
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 22:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab1DNUvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 16:51:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54488
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801Ab1DNUvP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 16:51:15 -0400
Received: (qmail 3329 invoked by uid 107); 14 Apr 2011 20:52:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 16:52:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 16:51:13 -0400
Content-Disposition: inline
In-Reply-To: <201104142243.33522.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171549>

On Thu, Apr 14, 2011 at 10:43:33PM +0200, Johannes Sixt wrote:

> > > In the threaded case, this fd is closed by start_command(), where it is
> > > passed as po.out in pack_objects(). In the fork case this is too late
> > > because a duplicate was already inherited to the sideband demuxer.
> >
> > Hrm, I see the code now. That seems like an odd thing to do to me.
> 
> Why so? It's a matter of resource ownership: If you pass a positive value, you 
> give away ownership; if you pass -1, you gain ownership; if you pass 0, 
> ownership remains unchanged.

I can see how that is useful. Mostly I was just surprised, because I
wouldn't expect ownership to be transferred there.

> > Doesn't it disallow:
> >
> >   /* set up a command */
> >   const char **argv = { "some", "command" };
> >   struct child_process c;
> >   c.argv = argv;
> >   c.out = fd;
> >
> >   /* run it */
> >   run_command(&c);
> >
> >   /* now tack our own output to the end */
> >   write(fd, "foo", 3);
> 
> You would have to dup() the fd before run_command().

True. That makes it less of a big deal, because for the times that you
don't want full ownership transferred, you can work around it.

> > And even weirder, we only do the close for high file descriptors. So you
> > _can_ do that above if "fd" is stdout, but not with an arbitrary fd.
> 
> Ah, right, that's a bit dubious. The reason is that if you want to tell the 
> child process to use the parent's stdout for its own stdout, you specify 0 
> aka "no special treatement", i.e. just inherit from the parent, not 1. IOW, 1 
> is never a sane candidate to be assigned to c.out.

Fair enough.

So what do you want to do about the fd that needs closing? The options
I see are:

  1. Try for a general solution. That probably means the "close every
     descriptor in the child" hackiness that I mentioned earlier.

  2. Fix this case by having the async code close it if it was forked.
     It needs to know whether we forked, so we can:

       a. Use NO_PTHREADS. Easy and simple, though it does break
          start_async's abstraction a bit.

       b. Have start_async pass in a flag telling what happened. This
          really breaks the abstraction very similarly to (a), but it
          makes the connection more explicit.

I think I am leaning a bit towards (2a). It's simple, and it's not like
this is library code with a million unknown callers; fixing it simply
and cleanly with a nice commit message is probably sufficient.

-Peff
