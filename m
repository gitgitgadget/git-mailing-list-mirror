From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] attempt connects in parallel for IPv6-capable builds
Date: Thu, 28 Jan 2016 11:57:21 +0000
Message-ID: <20160128115720.GA1827@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 12:57:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlCo-0007O1-0E
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 12:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935253AbcA1L5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 06:57:31 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43611 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935217AbcA1L5W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 06:57:22 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A5051F669;
	Thu, 28 Jan 2016 11:57:21 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285015>

getaddrinfo() may return multiple addresses, not all of which
are equally performant.  In some cases, a user behind a non-IPv6
capable network may get an IPv6 address which stalls connect().
Instead of waiting synchronously for a connect() to timeout, use
non-blocking connect() in parallel and take the first successful
connection.

This may increase network traffic and server load slightly, but
makes the worst-case user experience more bearable when one
lacks permissions to edit /etc/gai.conf to favor IPv4 addresses.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 connect.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 104 insertions(+), 14 deletions(-)

diff --git a/connect.c b/connect.c
index fd7ffe1..74d2bb5 100644
--- a/connect.c
+++ b/connect.c
@@ -14,6 +14,42 @@
 static char *server_capabilities;
 static const char *parse_feature_value(const char *, const char *, int *);
 
+#ifdef SOCK_NONBLOCK /* Linux-only flag */
+#  define GIT_SOCK_NONBLOCK SOCK_NONBLOCK
+#else
+#  define GIT_SOCK_NONBLOCK 0
+#endif
+
+static int socket_nb(int domain, int type, int protocol)
+{
+	static int flags = GIT_SOCK_NONBLOCK;
+	int fd = socket(domain, type | flags, protocol);
+
+	/* new headers, old kernel? */
+	if (fd < 0 && errno == EINVAL && flags != 0) {
+		flags = 0;
+		fd = socket(domain, type, protocol);
+	}
+
+	/* couldn't use SOCK_NONBLOCK, set non-blocking the old way */
+	if (flags == 0 && fd >= 0) {
+		int fl = fcntl(fd, F_GETFL);
+
+		if (fcntl(fd, F_SETFL, fl | O_NONBLOCK) < 0)
+			die_errno("failed to set nonblocking flag\n");
+	}
+
+	return fd;
+}
+
+static void set_blocking(int fd)
+{
+	int fl = fcntl(fd, F_GETFL);
+
+	if (fcntl(fd, F_SETFL, fl & ~O_NONBLOCK) < 0)
+		die_errno("failed to clear nonblocking flag\n");
+}
+
 static int check_ref(const char *name, unsigned int flags)
 {
 	if (!flags)
@@ -351,6 +387,9 @@ static int git_tcp_connect_sock(char *host, int flags)
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
 	int cnt = 0;
+	nfds_t n = 0, nfds = 0;
+	struct pollfd *fds = NULL;
+	struct addrinfo **inprogress = NULL;
 
 	get_host_and_port(&host, &port);
 	if (!*port)
@@ -371,20 +410,76 @@ static int git_tcp_connect_sock(char *host, int flags)
 		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
 
 	for (ai0 = ai; ai; ai = ai->ai_next, cnt++) {
-		sockfd = socket(ai->ai_family,
-				ai->ai_socktype, ai->ai_protocol);
-		if ((sockfd < 0) ||
-		    (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0)) {
+		size_t cur;
+		int fd = socket_nb(ai->ai_family, ai->ai_socktype,
+					ai->ai_protocol);
+		if (fd < 0) {
 			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
 				    host, cnt, ai_name(ai), strerror(errno));
-			if (0 <= sockfd)
-				close(sockfd);
-			sockfd = -1;
 			continue;
 		}
+
+		if (connect(fd, ai->ai_addr, ai->ai_addrlen) < 0 &&
+					errno != EINPROGRESS) {
+			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
+				host, cnt, ai_name(ai), strerror(errno));
+			close(fd);
+			continue;
+		}
+
 		if (flags & CONNECT_VERBOSE)
-			fprintf(stderr, "%s ", ai_name(ai));
-		break;
+			fprintf(stderr, "%s (started)\n", ai_name(ai));
+
+		nfds = n + 1;
+		cur = n;
+		ALLOC_GROW(fds, nfds, cur);
+		cur = n;
+		ALLOC_GROW(inprogress, nfds, cur);
+		inprogress[n] = ai;
+		fds[n].fd = fd;
+		fds[n].events = POLLIN|POLLOUT;
+		fds[n].revents = 0;
+		n = nfds;
+	}
+
+	/*
+	 * nfds is tiny, no need to limit loop based on poll() retval,
+	 * just do not let poll sleep forever if nfds is zero
+	 */
+	if (nfds > 0)
+		poll(fds, nfds, -1);
+
+	for (n = 0; n < nfds && sockfd < 0; n++) {
+		if (fds[n].revents & (POLLERR|POLLHUP))
+			continue;
+		if (fds[n].revents & POLLOUT) {
+			int err;
+			socklen_t len = (socklen_t)sizeof(err);
+			int rc = getsockopt(fds[n].fd, SOL_SOCKET, SO_ERROR,
+						&err, &len);
+			if (rc != 0)
+				die_errno("getsockopt errno=%s\n",
+					strerror(errno));
+			if (err == 0) { /* success! */
+				sockfd = fds[n].fd;
+				ai = inprogress[n];
+			}
+		}
+	}
+
+	/* cleanup */
+	for (n = 0; n < nfds; n++) {
+		if (fds[n].fd != sockfd)
+			close(fds[n].fd);
+	}
+	free(inprogress);
+	free(fds);
+
+	if (sockfd >= 0) {
+		enable_keepalive(sockfd);
+		set_blocking(sockfd); /* the rest of git expects blocking */
+		if (flags & CONNECT_VERBOSE)
+			fprintf(stderr, "%s done.\n", ai_name(ai));
 	}
 
 	freeaddrinfo(ai0);
@@ -392,11 +487,6 @@ static int git_tcp_connect_sock(char *host, int flags)
 	if (sockfd < 0)
 		die("unable to connect to %s:\n%s", host, error_message.buf);
 
-	enable_keepalive(sockfd);
-
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\n");
-
 	strbuf_release(&error_message);
 
 	return sockfd;
-- 
EW
