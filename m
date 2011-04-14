From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] send-pack: abort sideband demuxer on pack-objects
 error
Date: Thu, 14 Apr 2011 16:21:10 -0400
Message-ID: <20110414202110.GA6525@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <201104132153.06429.j6t@kdbg.org>
 <20110414135449.GD12410@sigill.intra.peff.net>
 <201104142136.25778.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 22:21:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAT2V-0005Ao-IN
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 22:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792Ab1DNUVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 16:21:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42304
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472Ab1DNUVN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 16:21:13 -0400
Received: (qmail 3077 invoked by uid 107); 14 Apr 2011 20:22:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 16:22:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 16:21:10 -0400
Content-Disposition: inline
In-Reply-To: <201104142136.25778.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171545>

On Thu, Apr 14, 2011 at 09:36:25PM +0200, Johannes Sixt wrote:

> On Donnerstag, 14. April 2011, Jeff King wrote:
> > Obviously it totally breaks the start_async abstraction if the called
> > code needs to care whether it forked or not. But we can use that to our
> > advantage, since it means start_async callers must assume the interface
> > is very limited.  So I think we can do something like:
> >
> >   1. Async code declares which file descriptors it cares about. This
> >      would automatically include the pipe we give to it, of course.
> >      So the declared ones for a sideband demuxer would be stderr, and
> >      some network fd for reading.
> >
> >   2. In the pthreads case, we do nothing. In the forked case, the child
> >      closes every descriptor except the "interesting" ones.
> >
> > And that solves this problem, and the general case that async-callers
> > have no idea if they have just leaked pipe descriptors in the forked
> > case.
> 
> Sounds like a plan. How do you close all file descriptors? Just iterate up to 
> getrlimit(RLIMIT_NOFILE)?

Sadly, yes, I think that is what we would have to do. It does feel like
an awful hack. And it will interact badly with things like valgrind,
which open descriptors behind the scenes (but can properly handle
the forking).

I just don't see another way around it for the general case.  The
"usual" fix for this sort of thing is that the descriptors should have
close-on-exec set, but that doesn't work for us here, because we are
only forking.

It's sufficiently ugly (and still possible to break in the pthreads
case!) that it may be worth not worrying about the general case at all,
and just fixing this one with the explicit close.

> > I'm still slightly confused, though, because I never see that descriptor
> > get closed in the threaded case. So I still don't understand why it
> > _doesn't_ deadlock with pthreads.
> 
> In the threaded case, this fd is closed by start_command(), where it is passed 
> as po.out in pack_objects(). In the fork case this is too late because a 
> duplicate was already inherited to the sideband demuxer.

Hrm, I see the code now. That seems like an odd thing to do to me.
Doesn't it disallow:

  /* set up a command */
  const char **argv = { "some", "command" };
  struct child_process c;
  c.argv = argv;
  c.out = fd;

  /* run it */
  run_command(&c);

  /* now tack our own output to the end */
  write(fd, "foo", 3);

And even weirder, we only do the close for high file descriptors. So you
_can_ do that above if "fd" is stdout, but not with an arbitrary fd.

I guess it is neither here nor there with respect to this problem; it
clearly is not something we want to do a lot, as it doesn't seem to have
come up.

But at least it explains what's going on here in the threaded case.

> However, pack_objects() works differently in the stateless_rpc case: then it 
> does not close fd anywhere, and I think it should be possible to construct a 
> similar case that hangs even in the threaded case. And the fix could simply 
> look like this:
> 
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 5e772c7..c8f601f 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -101,6 +101,7 @@ static int pack_objects(int fd, struct ref *refs,
>  		free(buf);
>  		close(po.out);
>  		po.out = -1;
> +		close(fd);
>  	}
>  
>  	if (finish_command(&po))

Yeah, from my reading of the code, you are right.

-Peff
