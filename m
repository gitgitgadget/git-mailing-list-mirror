From: Jeff King <peff@peff.net>
Subject: Re: Can't get 'git archive' to work
Date: Mon, 7 Dec 2015 15:39:01 -0500
Message-ID: <20151207203900.GB30203@sigill.intra.peff.net>
References: <5665199A.7070304@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yuri <yuri@rawbw.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:39:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a62Yw-0008Jl-Dy
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 21:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932946AbbLGUjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 15:39:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:38486 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932716AbbLGUjE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 15:39:04 -0500
Received: (qmail 15950 invoked by uid 102); 7 Dec 2015 20:39:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 14:39:03 -0600
Received: (qmail 23105 invoked by uid 107); 7 Dec 2015 20:39:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 15:39:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2015 15:39:01 -0500
Content-Disposition: inline
In-Reply-To: <5665199A.7070304@rawbw.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282118>

On Sun, Dec 06, 2015 at 09:31:06PM -0800, Yuri wrote:

> Why "operation is not supported" through http and https? 'archive' is
> supposed to be the most efficient operation to get the specific snapshot of
> the repository, and it should be available without authentication.

Remote git-archive is not well-supported. It does work over git-daemon,
but the server side has to explicitly turn it on in their config. It was
never plumbed into the git-over-http protocol at all. ssh is generally
the only place it works out-of-the-box (but see below).

> In case of ssh with the key there is the strange error message about
> "core.gitProxy". What is this about? I am not using a proxy.
> [...]
> # through ssh with an active ssh key
> $ git archive --format=tar --remote=git@github.com:yurivict/vm-to-tor.git
> Invalid command: 'git-upload-archive 'yurivict/vm-to-tor.git''
>   You appear to be using ssh to clone a git:// URL.
>   Make sure your core.gitProxy config option and the
>   GIT_PROXY_COMMAND environment variable are NOT set.
> fatal: The remote end hung up unexpectedly

This message isn't from git, but rather from GitHub's ssh server. You
can see it here without running git locally at all:

  $ ssh git@github.com git-upload-archive
  Invalid command: 'git-upload-archive'
  You appear to be using ssh to clone a git:// URL.
  Make sure your core.gitProxy config option and the
  GIT_PROXY_COMMAND environment variable are NOT set.

The short of it is that GitHub does not support remote git-archive at
all, not even over ssh. Part of the reason is that it maintains a
separate caching layer for grabbing zips and tarballs, which is
available at an http endpoint:

  https://github.com/yurivict/vm-to-tor/archive/master.tar.gz

Clearly the advice above is not helpful in this case; I don't recall the
case that it was originally written to help. You may want to write to
GitHub support about it.

> # through ssh without an ssh key
> $  git archive --format=tar --remote=git@github.com:yurivict/vm-to-tor.git
> Permission denied (publickey).
> fatal: The remote end hung up unexpectedly

GitHub's ssh server only accepts key authentication, so this is not
surprising.

> # through https
> $  git archive --format=tar
> --remote=https://github.com/yurivict/vm-to-tor.git
> fatal: Operation not supported by protocol.
> 
> # through http
> $  git archive --format=tar
> --remote=http://github.com/yurivict/vm-to-tor.git
> fatal: Operation not supported by protocol.

This comes from the local git client. There's no scheme defined for
hitting git-upload-archive (the server side of a remote git-archive)
over HTTP. You'd have to define it, implement the client side of it, and
then convince the server side to configure their HTTP servers to handle
it as a CGI. That might be a nice project to work on, but it will not
get you tarballs anytime soon. :)

-Peff
