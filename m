From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential-cache--daemon: Change to root dir on startup
Date: Sun, 21 Feb 2016 18:52:26 -0500
Message-ID: <20160221235225.GE4094@sigill.intra.peff.net>
References: <1456037497-9895-1-git-send-email-jon_p_griffiths@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jon Griffiths <jon_p_griffiths@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:52:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdnk-00073h-W8
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbcBUXw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 18:52:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:46435 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751460AbcBUXw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:52:28 -0500
Received: (qmail 25795 invoked by uid 102); 21 Feb 2016 23:52:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 21 Feb 2016 18:52:28 -0500
Received: (qmail 13600 invoked by uid 107); 21 Feb 2016 23:52:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 21 Feb 2016 18:52:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Feb 2016 18:52:26 -0500
Content-Disposition: inline
In-Reply-To: <1456037497-9895-1-git-send-email-jon_p_griffiths@yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286853>

On Sun, Feb 21, 2016 at 07:51:37PM +1300, Jon Griffiths wrote:

> Stop the daemon from preventing umount of the directory it
> was started in.
> 
> Without this change the daemon prevents umount because it
> it holds open its cwd. If it starts in a directory we want
> to unmount we have to manually kill the process which is
> undesirable and also uncaches any credentials it is holding.
> 
> Signed-off-by: Jon Griffiths <jon_p_griffiths@yahoo.com>
> ---
>  credential-cache--daemon.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
> index cc65a9c..d911b40 100644
> --- a/credential-cache--daemon.c
> +++ b/credential-cache--daemon.c
> @@ -270,6 +270,8 @@ int main(int argc, const char **argv)
>  	if (ignore_sighup)
>  		signal(SIGHUP, SIG_IGN);
>  
> +	chdir("/");
> +
>  	serve_cache(socket_path, debug);
>  	delete_tempfile(&socket_file);

What happens if socket_path is relative here?

I don't know how common that would be in practice. In general, the
daemon is running out of $GIT_DIR or the top-level of the work-tree, I'd
guess, which is inappropriate for any user-level config, and probably
simply confusing even for repo-level config. I'm actually tempted to
just disallow relative paths entirely.

I think your patch _just_ helps the case where the git repository is
being unmounted (and our daemon's cwd happened to be there). It doesn't
help the case that the socket path is unmounted (which will still get
EBUSY because we have the socket open).

I can't think of any reason that chdir() to "/" would be a bad thing (if
you get EPERM going to "/", you probably have bigger problems), but
another option would be:

  1. chdir(dirname(socket_path));

  2. serve_cache(basename(socket_path));

That works with relative paths, and it puts all of our open files in the
same part of the hierarchy.

-Peff
