From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential-cache: close stderr in daemon process
Date: Mon, 15 Sep 2014 20:28:25 -0400
Message-ID: <20140916002825.GD5019@peff.net>
References: <20140914073506.GA19667@peff.net>
 <xmqqoaug4la4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 02:28:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTgdE-00066a-8L
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 02:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757853AbaIPA22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 20:28:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:48653 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754970AbaIPA21 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 20:28:27 -0400
Received: (qmail 13445 invoked by uid 102); 16 Sep 2014 00:28:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Sep 2014 19:28:27 -0500
Received: (qmail 26373 invoked by uid 107); 16 Sep 2014 00:28:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Sep 2014 20:28:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Sep 2014 20:28:25 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoaug4la4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257120>

On Mon, Sep 15, 2014 at 02:38:11PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +	if (!debug)
> > +		freopen("/dev/null", "w", stderr);
> 
> I am getting this:
> 
> credential-cache--daemon.c:216:10: error: ignoring return value of
> 'freopen', declared with attribute warn_unused_result
> [-Werror=unused-result]

Hmph, my glibc does not seem to mark freopen. It's probably sane to
check it for error, as we would otherwise probably segfault on the next
call to "fprintf(stderr)".

>From my reading of freopen(3posix), I do not think we need to do
anything like "stderr = freopen(..., stderr);". The filehandle is
repointed, not re-allocated. And anyway, that is the assumption all of
our other freopen calls make. :)

> which is somewhat irritating.  Even though I am not irritated by
> this code, but by the compiler and glibc headers, this is apparently
> the only offending one, so we may want to fix it anyway.

Squash this in?

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index c07a67c..c2f0049 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -212,8 +212,10 @@ static void serve_cache(const char *socket_path, int debug)
 
 	printf("ok\n");
 	fclose(stdout);
-	if (!debug)
-		freopen("/dev/null", "w", stderr);
+	if (!debug) {
+		if (!freopen("/dev/null", "w", stderr))
+			die_errno("unable to point stderr to /dev/null");
+	}
 
 	while (serve_cache_loop(fd))
 		; /* nothing */
