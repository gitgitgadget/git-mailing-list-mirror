From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 10/13] credentials: add "cache" helper
Date: Mon, 9 Jan 2012 23:57:33 -0500
Message-ID: <20120110045733.GA12460@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103407.GJ16529@sigill.intra.peff.net>
 <20120110015038.GA17754@burratino>
 <20120110044430.GA23619@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 05:58:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkTmh-0002Ds-IL
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 05:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab2AJE5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 23:57:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60894
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756074Ab2AJE5f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 23:57:35 -0500
Received: (qmail 6117 invoked by uid 107); 10 Jan 2012 05:04:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 00:04:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jan 2012 23:57:33 -0500
Content-Disposition: inline
In-Reply-To: <20120110044430.GA23619@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188216>

On Mon, Jan 09, 2012 at 11:44:30PM -0500, Jeff King wrote:

> Subject: [PATCH] unix-socket: handle long socket pathnames

And I think this should go on top. You were lucky enough that I used a
die() in the original code for your condition (because I thought it was
a "this could never happen, right?" condition). Had it simply returned
an error, the cache-daemon would have silently failed to do anything,
which would have been much more confusing for you. :)

We probably should have done this as part of Clemens' 98c2924, but I
didn't think of it then (but the same reasoning applies to both
patches).

-- >8 --
Subject: [PATCH] credential-cache: report more daemon connection errors

Originally, this code remained relatively silent when we
failed to connect to the cache. The idea was that it was
simply a cache, and we didn't want to bother the user with
temporary failures (the worst case is that we would simply
ask their password again).

However, if you have a configuration failure or other
problem, it is helpful for the daemon to report those
problems. Git will happily ignore the failed error code, but
the extra information to stderr can help the user diagnose
the problem.

Signed-off-by: Jeff King <peff@peff.net>
---
 credential-cache.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/credential-cache.c b/credential-cache.c
index b15a9a7..1933018 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -71,10 +71,14 @@ static void do_cache(const char *socket, const char *action, int timeout,
 			die_errno("unable to relay credential");
 	}
 
-	if (send_request(socket, &buf) < 0 && (flags & FLAG_SPAWN)) {
-		spawn_daemon(socket);
-		if (send_request(socket, &buf) < 0)
+	if (send_request(socket, &buf) < 0) {
+		if (errno != ENOENT)
 			die_errno("unable to connect to cache daemon");
+		if (flags & FLAG_SPAWN) {
+			spawn_daemon(socket);
+			if (send_request(socket, &buf) < 0)
+				die_errno("unable to connect to cache daemon");
+		}
 	}
 	strbuf_release(&buf);
 }
-- 
1.7.9.rc0.33.g15ced5
