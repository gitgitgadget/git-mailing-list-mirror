From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] git_connect: use argv_array
Date: Thu, 15 May 2014 04:34:09 -0400
Message-ID: <20140515083409.GC26866@sigill.intra.peff.net>
References: <20140515082943.GA26473@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 10:34:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkr7K-0003YC-F3
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 10:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbaEOIeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 04:34:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:52059 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751304AbaEOIeL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 04:34:11 -0400
Received: (qmail 20297 invoked by uid 102); 15 May 2014 08:34:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 03:34:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 04:34:09 -0400
Content-Disposition: inline
In-Reply-To: <20140515082943.GA26473@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249070>

This avoids magic numbers when we allocate fixed-size argv
arrays, and makes it more obvious that we are not
overflowing.

It is also the first step to fixing a memory leak. When
git_connect returns a child_process struct, the argv array
in the struct is dynamically allocated, but the individual
strings are not (they are either owned elsewhere, or are
freed). Later, in finish_connect, we free the array but
leave the strings alone.

This works for the child_process created by git_connect, but
if we use transport_take_over, we may also end up with a
child_process created by transport-helper's get_helper.
In that case, the strings are freshly allocated, and we
would want to free them.  However, we have no idea in
finish_connect which type we have.

By consistently using run-command's internal argv-array, we
do not have to worry about this issue at all; finish_command
takes care of it for us, and we can drop our manual free
entirely.

Note that this actually makes the get_helper leak slightly
worse; now we are leaking both the strings and the array.
But when we adjust it in a future patch, that leak will go
away entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 connect.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/connect.c b/connect.c
index a983d06..94a6650 100644
--- a/connect.c
+++ b/connect.c
@@ -534,22 +534,18 @@ static int git_use_proxy(const char *host)
 static struct child_process *git_proxy_connect(int fd[2], char *host)
 {
 	const char *port = STR(DEFAULT_GIT_PORT);
-	const char **argv;
 	struct child_process *proxy;
 
 	get_host_and_port(&host, &port);
 
-	argv = xmalloc(sizeof(*argv) * 4);
-	argv[0] = git_proxy_command;
-	argv[1] = host;
-	argv[2] = port;
-	argv[3] = NULL;
 	proxy = xcalloc(1, sizeof(*proxy));
-	proxy->argv = argv;
+	argv_array_push(&proxy->args, git_proxy_command);
+	argv_array_push(&proxy->args, host);
+	argv_array_push(&proxy->args, port);
 	proxy->in = -1;
 	proxy->out = -1;
 	if (start_command(proxy))
-		die("cannot start proxy %s", argv[0]);
+		die("cannot start proxy %s", git_proxy_command);
 	fd[0] = proxy->out; /* read from proxy stdout */
 	fd[1] = proxy->in;  /* write to proxy stdin */
 	return proxy;
@@ -663,7 +659,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 	char *hostandport, *path;
 	struct child_process *conn = &no_fork;
 	enum protocol protocol;
-	const char **arg;
 	struct strbuf cmd = STRBUF_INIT;
 
 	/* Without this we cannot rely on waitpid() to tell
@@ -707,7 +702,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 		sq_quote_buf(&cmd, path);
 
 		conn->in = conn->out = -1;
-		conn->argv = arg = xcalloc(7, sizeof(*arg));
 		if (protocol == PROTO_SSH) {
 			const char *ssh = getenv("GIT_SSH");
 			int putty = ssh && strcasestr(ssh, "plink");
@@ -718,22 +712,21 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 			if (!ssh) ssh = "ssh";
 
-			*arg++ = ssh;
+			argv_array_push(&conn->args, ssh);
 			if (putty && !strcasestr(ssh, "tortoiseplink"))
-				*arg++ = "-batch";
+				argv_array_push(&conn->args, "-batch");
 			if (port) {
 				/* P is for PuTTY, p is for OpenSSH */
-				*arg++ = putty ? "-P" : "-p";
-				*arg++ = port;
+				argv_array_push(&conn->args, putty ? "-P" : "-p");
+				argv_array_push(&conn->args, port);
 			}
-			*arg++ = ssh_host;
+			argv_array_push(&conn->args, ssh_host);
 		} else {
 			/* remove repo-local variables from the environment */
 			conn->env = local_repo_env;
 			conn->use_shell = 1;
 		}
-		*arg++ = cmd.buf;
-		*arg = NULL;
+		argv_array_push(&conn->args, cmd.buf);
 
 		if (start_command(conn))
 			die("unable to fork");
@@ -759,7 +752,6 @@ int finish_connect(struct child_process *conn)
 		return 0;
 
 	code = finish_command(conn);
-	free(conn->argv);
 	free(conn);
 	return code;
 }
-- 
2.0.0.rc1.436.g03cb729
