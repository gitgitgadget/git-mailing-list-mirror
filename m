From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] connect: treat generic proxy processes like ssh
 processes
Date: Tue, 17 May 2011 01:54:22 -0400
Message-ID: <20110517055422.GD10048@sigill.intra.peff.net>
References: <20110516063944.GB25731@sigill.intra.peff.net>
 <20110516064607.GA19078@sigill.intra.peff.net>
 <4DD181C6.4020104@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue May 17 07:54:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMDEl-0001pN-7c
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 07:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab1EQFy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 01:54:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53510
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab1EQFyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 01:54:25 -0400
Received: (qmail 21634 invoked by uid 107); 17 May 2011 05:56:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 May 2011 01:56:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2011 01:54:22 -0400
Content-Disposition: inline
In-Reply-To: <4DD181C6.4020104@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173788>

On Mon, May 16, 2011 at 09:57:58PM +0200, Johannes Sixt wrote:

> > The code path for git://, on the other hand, always sets it
> > to no_fork. In the case of a direct TCP connection, this
> > makes sense; we have no child process. But in the case of a
> > proxy command (configured by core.gitproxy), we do have a
> > child process, but we throw away its pid, and therefore
> > ignore its return code.
> > 
> > Instead, let's keep that information in the proxy case, and
> > respect its return code, which can help catch some errors
> 
> This patch looks strikingly familiar. I had written an almost identical
> change more than 3 years ago and forgot about it, though the
> justification I noted in the commit was more to properly shutdown the
> proxy process rather than to abandon it and let it be collected by
> init(8). Your justification is much better.

Thanks, I had no idea your patch existed. I hate to duplicate work, but
at least it's a sanity check that it's not a totally stupid idea. ;)

> >  	const char *argv[4];
> > -	struct child_process proxy;
> > +	struct child_process *proxy;
> [...]
> At this point, proxy->argv would point to automatic storage; but we
> need argv[0] in finish_command() for error reporting.

Ick. Good catch.

> In my implementation, I xmalloced the pointer array and leaked it.
> (And that's probably the reason that I never submitted the patch.) I
> wouldn't dare to make argv just static because this limits us to have
> just one open connection at a time established via
> git_proxy_connect().  Dunno...

We also need to worry about the contents of each argv[] element, no? So
we should be xstrdup()ing the host and port, which point into some
string which gets passed to us. I didn't trace its provenance but I
think it is better to be defensive.

The leak is probably OK in a practical sense (you generally make no more
than one such connection per command), but it does seem ugly. I would
not be surprised if many other run-command invocations leak similarly.

The interdiff with the strdups is:

diff --git a/connect.c b/connect.c
index c678ceb..c24866e 100644
--- a/connect.c
+++ b/connect.c
@@ -398,14 +398,15 @@ static int git_use_proxy(const char *host)
 static struct child_process *git_proxy_connect(int fd[2], char *host)
 {
 	const char *port = STR(DEFAULT_GIT_PORT);
-	const char *argv[4];
+	const char **argv;
 	struct child_process *proxy;
 
 	get_host_and_port(&host, &port);
 
+	argv = xmalloc(4 * sizeof(*argv));
 	argv[0] = git_proxy_command;
-	argv[1] = host;
-	argv[2] = port;
+	argv[1] = xstrdup(host);
+	argv[2] = xstrdup(port);
 	argv[3] = NULL;
 	proxy = xcalloc(1, sizeof(*proxy));
 	proxy->argv = argv;
