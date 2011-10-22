From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] git-credential-cache--daemon on Cygwin
Date: Sat, 22 Oct 2011 15:15:10 -0400
Message-ID: <20111022191509.GB1785@sigill.intra.peff.net>
References: <4EA2FC0D.5060404@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Oct 22 21:16:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHh3Y-0003PV-4S
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 21:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab1JVTPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 15:15:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39591
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792Ab1JVTPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 15:15:17 -0400
Received: (qmail 30158 invoked by uid 107); 22 Oct 2011 19:15:25 -0000
Received: from mc64036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.64.198)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Oct 2011 15:15:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Oct 2011 15:15:10 -0400
Content-Disposition: inline
In-Reply-To: <4EA2FC0D.5060404@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184111>

On Sat, Oct 22, 2011 at 06:23:25PM +0100, Ramsay Jones wrote:

> I had a quick look, and found that unix_stream_listen() was failing to
> bind() to a stale unix socket. The code looked OK to me, and should have
> handled this just fine, but didn't ...
> 
> On a hunch, I found that the following "belt-n-braces" approach fixed the
> the test for me:
> 
> -- >8 --
> diff --git a/unix-socket.c b/unix-socket.c
> index cf9890f..d974e01 100644
> --- a/unix-socket.c
> +++ b/unix-socket.c
> @@ -42,7 +42,9 @@ int unix_stream_listen(const char *path)
>  	fd = unix_stream_socket();
>  
>  	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
> +		close(fd);
>  		unlink(path);
> +		fd = unix_stream_socket();
>  		if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
>  			close(fd);
>  			return -1;
> -- 8< --

Wow, that seems horribly broken on the part of cygwin.

I think your solution to just unlink first() is the right way to go.  I
have a few comments, though so I'll respond to each of the patches
individually.

> Assuming that a modified http-auth-keyring series will make a return to pu
> sometime, could you please squash these patches into (the patch corresponding to)
> commit 2d6874d (credentials: add "cache" helper, 18-07-2011). Thanks!

I'm planning a reroll, so I'll squash them (or something similar) in.

> Also, note that this series breaks the build on MinGW. The patch to fix the build
> is rather simple, but the result doesn't work, of course, because winsock does
> not know about AF_UNIX (or AF_LOCAL). I started to code an win32 emulation of unix
> sockets, but stopped working on it when this branch dropped from next. If you
> intend to re-submit this work, then I can pick this up again.

Right. I sort of expected that, and figured we could just drop the cache
helper on mingw until somebody felt like writing such an emulation
layer.

It's definitely coming back, so if you feel like working on it, please
do. Also note that if it would be easier to have an alternate
abstraction for inter-process communication on windows, I'm open to
doing that in the cache daemon.

-Peff
