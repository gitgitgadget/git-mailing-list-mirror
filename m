From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] connect: treat generic proxy processes like ssh processes
Date: Mon, 16 May 2011 02:46:07 -0400
Message-ID: <20110516064607.GA19078@sigill.intra.peff.net>
References: <20110516063944.GB25731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 16 08:46:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLrZI-0001HB-1r
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 08:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab1EPGqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 02:46:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45138
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab1EPGqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 02:46:10 -0400
Received: (qmail 11255 invoked by uid 107); 16 May 2011 06:48:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 02:48:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 02:46:07 -0400
Content-Disposition: inline
In-Reply-To: <20110516063944.GB25731@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173709>

The git_connect function returns two ends of a pipe for
talking with a remote, plus a struct child_process
representing the other end of the pipe. If we have a direct
socket connection, then this points to a special "no_fork"
child process.

The code path for doing git-over-pipes or git-over-ssh sets
up this child process to point to the child git command or
the ssh process. When we call finish_connect eventually, we
check wait() on the command and report its return value.

The code path for git://, on the other hand, always sets it
to no_fork. In the case of a direct TCP connection, this
makes sense; we have no child process. But in the case of a
proxy command (configured by core.gitproxy), we do have a
child process, but we throw away its pid, and therefore
ignore its return code.

Instead, let's keep that information in the proxy case, and
respect its return code, which can help catch some errors
(though depending on your proxy command, it will be errors
reported by the proxy command itself, and not propagated
from git commands. Still, it is probably better to propagate
such errors than to ignore them).

It also means that the child_process field can reliably be
used to determine whether the returned descriptors are
actually a full-duplex socket, which means we should be
using shutdown() instead of a simple close.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously I am interested mainly in the last bit for this series. But I
consider the rest of it a minor bugfix on its own.

 connect.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/connect.c b/connect.c
index db965c9..86ad150 100644
--- a/connect.c
+++ b/connect.c
@@ -403,12 +403,12 @@ static int git_use_proxy(const char *host)
 	return (git_proxy_command && *git_proxy_command);
 }
 
-static void git_proxy_connect(int fd[2], char *host)
+static struct child_process *git_proxy_connect(int fd[2], char *host)
 {
 	const char *port = STR(DEFAULT_GIT_PORT);
 	char *colon, *end;
 	const char *argv[4];
-	struct child_process proxy;
+	struct child_process *proxy;
 
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
@@ -431,14 +431,15 @@ static void git_proxy_connect(int fd[2], char *host)
 	argv[1] = host;
 	argv[2] = port;
 	argv[3] = NULL;
-	memset(&proxy, 0, sizeof(proxy));
-	proxy.argv = argv;
-	proxy.in = -1;
-	proxy.out = -1;
-	if (start_command(&proxy))
+	proxy = xcalloc(1, sizeof(*proxy));
+	proxy->argv = argv;
+	proxy->in = -1;
+	proxy->out = -1;
+	if (start_command(proxy))
 		die("cannot start proxy %s", argv[0]);
-	fd[0] = proxy.out; /* read from proxy stdout */
-	fd[1] = proxy.in;  /* write to proxy stdin */
+	fd[0] = proxy->out; /* read from proxy stdout */
+	fd[1] = proxy->in;  /* write to proxy stdin */
+	return proxy;
 }
 
 #define MAX_CMD_LEN 1024
@@ -553,9 +554,11 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		 */
 		char *target_host = xstrdup(host);
 		if (git_use_proxy(host))
-			git_proxy_connect(fd, host);
-		else
+			conn = git_proxy_connect(fd, host);
+		else {
 			git_tcp_connect(fd, host, flags);
+			conn = &no_fork;
+		}
 		/*
 		 * Separate original protocol components prog and path
 		 * from extended host header with a NUL byte.
@@ -571,7 +574,7 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		free(url);
 		if (free_path)
 			free(path);
-		return &no_fork;
+		return conn;
 	}
 
 	conn = xcalloc(1, sizeof(*conn));
-- 
1.7.5.1.13.g0ca09.dirty
