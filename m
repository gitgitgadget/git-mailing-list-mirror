From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 10/13] credentials: add "cache" helper
Date: Tue, 17 Jan 2012 01:02:32 -0500
Message-ID: <20120117060232.GA27343@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103407.GJ16529@sigill.intra.peff.net>
 <20120110015038.GA17754@burratino>
 <20120110044430.GA23619@sigill.intra.peff.net>
 <20120110045733.GA12460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 07:02:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn283-0000wc-SZ
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 07:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217Ab2AQGCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 01:02:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39893
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab2AQGCh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 01:02:37 -0500
Received: (qmail 24002 invoked by uid 107); 17 Jan 2012 06:09:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jan 2012 01:09:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2012 01:02:32 -0500
Content-Disposition: inline
In-Reply-To: <20120110045733.GA12460@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188690>

On Mon, Jan 09, 2012 at 11:57:33PM -0500, Jeff King wrote:

> Subject: [PATCH] credential-cache: report more daemon connection errors
> 
> Originally, this code remained relatively silent when we
> failed to connect to the cache. The idea was that it was
> simply a cache, and we didn't want to bother the user with
> temporary failures (the worst case is that we would simply
> ask their password again).
> 
> However, if you have a configuration failure or other
> problem, it is helpful for the daemon to report those
> problems. Git will happily ignore the failed error code, but
> the extra information to stderr can help the user diagnose
> the problem.

This actually has a minor regression, fixed below.

-- >8 --
Subject: [PATCH] credential-cache: ignore "connection refused" errors

The credential-cache helper will try to connect to its
daemon over a unix socket. Originally, a failure to do so
was silently ignored, and we would either give up (if
performing a "get" or "erase" operation), or spawn a new
daemon (for a "store" operation).

But since 8ec6c8d, we try to report more errors. We detect a
missing daemon by checking for ENOENT on our connection
attempt.  If the daemon is missing, we continue as before
(giving up or spawning a new daemon). For any other error,
we die and report the problem.

However, checking for ENOENT is not sufficient for a missing
daemon. We might also get ECONNREFUSED if a dead daemon
process left a stale socket. This generally shouldn't
happen, as the daemon cleans up after itself, but the daemon
may not always be given a chance to do so (e.g., power loss,
"kill -9").

The resulting state is annoying not just because the helper
outputs an extra useless message, but because it actually
blocks the helper from spawning a new daemon to replace the
stale socket.

Fix it by checking for ECONNREFUSED.

Signed-off-by: Jeff King <peff@peff.net>
---
If we really want to go belt-and-suspenders, the logic should perhaps be
changed to:

  if (send_request(socket, &buf < 0) {
          /* if we're starting a new one, who cares why it didn't work */
          if (flags & FLAG_SPAWN) {
                  spawn_daemon(socket);
                  if (send_request(socket, &buf) < 0)
                          die_errno("unable to connect to spawned daemon");
          }
          /* otherwise, report any non-minor errors */
          else if(errno != ENOENT && errno != ECONNREFUSED)
                  die_errno("unable to connect to cache daemon");
          /* otherwise we are just missing the daemon, and we can ignore */
  }

but that implies there is some condition besides ENOENT and ECONNREFUSED
where actually starting a new daemon (which will try to unlink whatever
is there now!) would be a good idea. I'd rather be conservative and
see if anybody reports a real-world case.

 credential-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/credential-cache.c b/credential-cache.c
index 1933018..9a03792 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -72,7 +72,7 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	}
 
 	if (send_request(socket, &buf) < 0) {
-		if (errno != ENOENT)
+		if (errno != ENOENT && errno != ECONNREFUSED)
 			die_errno("unable to connect to cache daemon");
 		if (flags & FLAG_SPAWN) {
 			spawn_daemon(socket);
-- 
1.7.9.rc0.33.gd3c17
