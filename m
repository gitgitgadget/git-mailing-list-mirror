From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] send-pack: abort sideband demuxer on pack-objects
 error
Date: Thu, 14 Apr 2011 09:54:49 -0400
Message-ID: <20110414135449.GD12410@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <20110331184443.GD16906@sigill.intra.peff.net>
 <201104132153.06429.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 15:54:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAN0b-0001gY-4Q
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 15:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758711Ab1DNNyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 09:54:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46782
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757881Ab1DNNyv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 09:54:51 -0400
Received: (qmail 31314 invoked by uid 107); 14 Apr 2011 13:55:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 09:55:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 09:54:49 -0400
Content-Disposition: inline
In-Reply-To: <201104132153.06429.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171517>

On Wed, Apr 13, 2011 at 09:53:06PM +0200, Johannes Sixt wrote:

> > Meanwhile, the async sideband demuxer will continue trying
> > to stream data from the remote repo until it gets EOF.
> > Depending on what data pack-objects actually sent, the
> > remote repo may not actually send anything (e.g., if we sent
> > nothing and it is simply waiting for the pack). This leads
> > to deadlock cycle in which send-pack waits on the demuxer,
> > the demuxer waits on the remote receive-pack, and the remote
> > receive-pack waits on send-pack to send the pack data.
> 
> This is an indication that a writable end of the pipe between send-pack and 
> receive-pack is still open. This fixes the deadlock for me without having to 
> kill the demuxer explicitly:
> 
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 5e772c7..db32ded 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -229,6 +229,9 @@ static void print_helper_status(struct ref *ref)
>  static int sideband_demux(int in, int out, void *data)
>  {
>  	int *fd = data;
> +#ifdef NO_PTHREADS
> +	close(fd[1]);
> +#endif
>  	int ret = recv_sideband("send-pack", fd[0], out);
>  	close(out);
>  	return ret;
> 
> If only I had a brilliant idea how to forge this into a re-usable pattern...

Thanks for finding that. I had the notion that there was a pipe end
hanging open somewhere, but looking through the async code, I found us
closing the pipes properly. But of course I failed to check the fds
coming into send_pack.

Obviously it totally breaks the start_async abstraction if the called
code needs to care whether it forked or not. But we can use that to our
advantage, since it means start_async callers must assume the interface
is very limited.  So I think we can do something like:

  1. Async code declares which file descriptors it cares about. This
     would automatically include the pipe we give to it, of course.
     So the declared ones for a sideband demuxer would be stderr, and
     some network fd for reading.

  2. In the pthreads case, we do nothing. In the forked case, the child
     closes every descriptor except the "interesting" ones.

And that solves this problem, and the general case that async-callers
have no idea if they have just leaked pipe descriptors in the forked
case.

I'm still slightly confused, though, because I never see that descriptor
get closed in the threaded case. So I still don't understand why it
_doesn't_ deadlock with pthreads.

-Peff
