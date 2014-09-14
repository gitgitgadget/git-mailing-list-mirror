From: Jeff King <peff@peff.net>
Subject: [PATCH] credential-cache: close stderr in daemon process
Date: Sun, 14 Sep 2014 03:35:06 -0400
Message-ID: <20140914073506.GA19667@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 09:35:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT4L6-0008Hk-6M
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 09:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbaINHfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 03:35:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:47945 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752443AbaINHfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 03:35:09 -0400
Received: (qmail 5000 invoked by uid 102); 14 Sep 2014 07:35:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Sep 2014 02:35:09 -0500
Received: (qmail 13528 invoked by uid 107); 14 Sep 2014 07:35:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Sep 2014 03:35:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Sep 2014 03:35:06 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256997>

If the stderr of "git credential-cache" is redirected to a
pipe, the reader on the other end of a pipe may be surprised
that the pipe remains open long after the process exits.
This happens because we may auto-spawn a daemon which is
long-lived, and which keeps stderr open.

We can solve this by redirecting the daemon's stderr to
/dev/null once we are ready to go into our event loop. We
would not want to do so before then, because we may want to
report errors about the setup (e.g., failure to establish
the listening socket).

This does mean that we will not report errors we encounter
for specific clients. That's acceptable, as such errors
should be rare (e.g., clients sending buggy requests).
However, we also provide an escape hatch: if you want to see
these later messages, you can provide the "--debug" option
to keep stderr open.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-credential-cache--daemon.txt |  6 +++++-
 credential-cache--daemon.c                     | 23 +++++++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-credential-cache--daemon.txt b/Documentation/git-credential-cache--daemon.txt
index d15db42..7051c6b 100644
--- a/Documentation/git-credential-cache--daemon.txt
+++ b/Documentation/git-credential-cache--daemon.txt
@@ -8,7 +8,7 @@ git-credential-cache--daemon - Temporarily store user credentials in memory
 SYNOPSIS
 --------
 [verse]
-git credential-cache--daemon <socket>
+git credential-cache--daemon [--debug] <socket>
 
 DESCRIPTION
 -----------
@@ -21,6 +21,10 @@ for `git-credential-cache` clients. Clients may store and retrieve
 credentials. Each credential is held for a timeout specified by the
 client; once no credentials are held, the daemon exits.
 
+If the `--debug` option is specified, the daemon does not close its
+stderr stream, and may output extra diagnostics to it even after it has
+begun listening for clients.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 3b370ca..c07a67c 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -2,6 +2,7 @@
 #include "credential.h"
 #include "unix-socket.h"
 #include "sigchain.h"
+#include "parse-options.h"
 
 static const char *socket_path;
 
@@ -201,7 +202,7 @@ static int serve_cache_loop(int fd)
 	return 1;
 }
 
-static void serve_cache(const char *socket_path)
+static void serve_cache(const char *socket_path, int debug)
 {
 	int fd;
 
@@ -211,6 +212,8 @@ static void serve_cache(const char *socket_path)
 
 	printf("ok\n");
 	fclose(stdout);
+	if (!debug)
+		freopen("/dev/null", "w", stderr);
 
 	while (serve_cache_loop(fd))
 		; /* nothing */
@@ -252,16 +255,28 @@ static void check_socket_directory(const char *path)
 
 int main(int argc, const char **argv)
 {
-	socket_path = argv[1];
+	static const char *usage[] = {
+		"git-credential-cache--daemon [opts] <socket_path>",
+		NULL
+	};
+	int debug = 0;
+	const struct option options[] = {
+		OPT_BOOL(0, "debug", &debug,
+			 N_("print debugging messages to stderr")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	socket_path = argv[0];
 
 	if (!socket_path)
-		die("usage: git-credential-cache--daemon <socket_path>");
+		usage_with_options(usage, options);
 	check_socket_directory(socket_path);
 
 	atexit(cleanup_socket);
 	sigchain_push_common(cleanup_socket_on_signal);
 
-	serve_cache(socket_path);
+	serve_cache(socket_path, debug);
 
 	return 0;
 }
-- 
2.1.0.373.g91ca799
