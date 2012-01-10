From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 10/13] credentials: add "cache" helper
Date: Tue, 10 Jan 2012 12:53:12 -0500
Message-ID: <20120110175312.GA7289@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103407.GJ16529@sigill.intra.peff.net>
 <20120110015038.GA17754@burratino>
 <20120110044430.GA23619@sigill.intra.peff.net>
 <20120110174420.GA22184@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 18:53:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkfsv-0008Hw-3B
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 18:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499Ab2AJRxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 12:53:15 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33747
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756400Ab2AJRxO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 12:53:14 -0500
Received: (qmail 11917 invoked by uid 107); 10 Jan 2012 18:00:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 13:00:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 12:53:12 -0500
Content-Disposition: inline
In-Reply-To: <20120110174420.GA22184@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188271>

On Tue, Jan 10, 2012 at 11:44:21AM -0600, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> >   2. A hack in credential-cache won't help any unix-socket
> >      users who come along later.
> >
> >   3. The chdir trickery isn't that likely to fail (basically
> >      it's only a problem if your cwd is missing or goes away
> >      while you're running).  And because we only enable the
> >      hack when we get a too-long name, it can only fail in
> >      cases that would have failed under the previous code
> >      anyway.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> 
> A part of me worries that this assumption (3), and the additional
> assumption that nothing running concurrently cares about the cwd,
> might come back to bite us when the future (2) arrives.  But I don't
> see a better approach.

The problem is that when future (2) arrives, a credential-cache specific
hack won't be helping it at all. :)

To be honest, I don't really expect a lot of future unix-socket users.
It's not portable, and most of our IPC happens over pipes. The design of
the cache daemon is very specific in requiring a true
many-clients-to-one-server model, but also caring deeply about access
controls (making TCP sockets less good[1]).

[1] One could in theory do a loopback TCP socket and provide a random
    token read from an access-controlled file. But that ends up a lot
    more complicated and introduces new attack surfaces. Which is a bad
    thing for security-sensitive code like this.

> Follow-on ideas: on platforms that support it, it would be nice to use
> 
> 	ctx->orig_dirfd = open(".", O_RDONLY);
> 	if (ctx->orig_dirfd < 0)
> 		... error handling ...
> 	...
> 	if (ctx->orig_dirfd >= 0) {
> 		if (fchdir(ctx->orig_dirfd))
> 			die_errno("unable to restore original working directory");
> 		close(ctx->orig_dirfd);
> 	}

Yeah, I started by using fchdir, but noticed that we don't use it
anywhere else and didn't want to create a portability problem. It does
fix the "somebody deleted your cwd while you were gone from it" problem.
But if you have no cwd at all, the open call will still fail.

Still, it would be slightly more robust. I wonder how portable fchdir
is in practice (I guess we could always fall back to the getcwd code
path). Do you want to prepare a patch on top?

> [...]
> > +		dir = path;
> > +		dir_len = slash - path;
> [...]
> > +		if (chdir_len(dir, dir_len) < 0)
> > +			return -1;
> 
> Could avoid some complication by eliminating the dir_len var.
> 
> 		if (chdir_len(dir, slash - dir))
> 			return -1;

Ah, yeah. Originally I had written it so that "slash" didn't survive
untouched to there, but in the current code, that would work.

Junio, if you haven't merged it to next yet, it might be worth squashing
in the patch below. Otherwise I wouldn't worry about it.

> Neither seems worth holding up the patch, so
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for the review (and for, as usual, a well-written bug report).

---
diff --git a/unix-socket.c b/unix-socket.c
index 91ed9dc..e8f19c6 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -43,7 +43,6 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
 	if (size > sizeof(sa->sun_path)) {
 		const char *slash = find_last_dir_sep(path);
 		const char *dir;
-		int dir_len;
 
 		if (!slash) {
 			errno = ENAMETOOLONG;
@@ -51,8 +50,6 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
 		}
 
 		dir = path;
-		dir_len = slash - path;
-
 		path = slash + 1;
 		size = strlen(path) + 1;
 		if (size > sizeof(sa->sun_path)) {
@@ -64,7 +61,7 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
 			errno = ENAMETOOLONG;
 			return -1;
 		}
-		if (chdir_len(dir, dir_len) < 0)
+		if (chdir_len(dir, slash - dir) < 0)
 			return -1;
 	}
 
