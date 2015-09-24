From: Jeff King <peff@peff.net>
Subject: [PATCH 52/68] daemon: use cld->env_array when re-spawning
Date: Thu, 24 Sep 2015 17:08:00 -0400
Message-ID: <20150924210800.GW30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:09:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDlT-00032s-Cj
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbbIXVJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:09:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:36017 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754335AbbIXVID (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:08:03 -0400
Received: (qmail 12113 invoked by uid 102); 24 Sep 2015 21:08:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:08:03 -0500
Received: (qmail 29459 invoked by uid 107); 24 Sep 2015 21:08:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:08:00 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278614>

This avoids an ugly strcat into a fixed-size buffer. It's
not wrong (the buffer is plenty large enough for an IPv6
address plus some minor formatting), but it takes some
effort to verify that.

Unfortunately we are still stuck with some fixed-size
buffers to hold the output of inet_ntop. But at least we now
pass very easy-to-verify parameters, rather than doing a
manual computation to account for other data in the buffer.

As a side effect, this also fixes the case where we might
pass an uninitialized portbuf buffer through the
environment. This probably couldn't happen in practice, as
it would mean that addr->sa_family was neither AF_INET nor
AF_INET6 (and that is all we are listening on).

Signed-off-by: Jeff King <peff@peff.net>
---
 daemon.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/daemon.c b/daemon.c
index 5218a3f..56679a1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -811,8 +811,6 @@ static char **cld_argv;
 static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child_process cld = CHILD_PROCESS_INIT;
-	char addrbuf[300] = "REMOTE_ADDR=", portbuf[300];
-	char *env[] = { addrbuf, portbuf, NULL };
 
 	if (max_connections && live_children >= max_connections) {
 		kill_some_child();
@@ -826,27 +824,23 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 	}
 
 	if (addr->sa_family == AF_INET) {
+		char buf[128] = "";
 		struct sockaddr_in *sin_addr = (void *) addr;
-		inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf + 12,
-		    sizeof(addrbuf) - 12);
-		snprintf(portbuf, sizeof(portbuf), "REMOTE_PORT=%d",
-		    ntohs(sin_addr->sin_port));
+		inet_ntop(addr->sa_family, &sin_addr->sin_addr, buf, sizeof(buf));
+		argv_array_pushf(&cld.env_array, "REMOTE_ADDR=%s", buf);
+		argv_array_pushf(&cld.env_array, "REMOTE_PORT=%d",
+				 ntohs(sin_addr->sin_port));
 #ifndef NO_IPV6
 	} else if (addr->sa_family == AF_INET6) {
+		char buf[128] = "";
 		struct sockaddr_in6 *sin6_addr = (void *) addr;
-
-		char *buf = addrbuf + 12;
-		*buf++ = '['; *buf = '\0'; /* stpcpy() is cool */
-		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf,
-		    sizeof(addrbuf) - 13);
-		strcat(buf, "]");
-
-		snprintf(portbuf, sizeof(portbuf), "REMOTE_PORT=%d",
-		    ntohs(sin6_addr->sin6_port));
+		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(buf));
+		argv_array_pushf(&cld.env_array, "REMOTE_ADDR=[%s]", buf);
+		argv_array_pushf(&cld.env_array, "REMOTE_PORT=%d",
+				 ntohs(sin6_addr->sin6_port));
 #endif
 	}
 
-	cld.env = (const char **)env;
 	cld.argv = (const char **)cld_argv;
 	cld.in = incoming;
 	cld.out = dup(incoming);
-- 
2.6.0.rc3.454.g204ad51
