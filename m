From: Eric Wong <normalperson@yhbt.net>
Subject: [RFC/PATCH] core.clientTimeout config for git:// fetches
Date: Wed, 7 Sep 2011 10:15:45 +0000
Message-ID: <20110907101545.GA9326@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 18:14:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1KlM-0006iM-R3
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056Ab1IGQNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:13:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52458 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755776Ab1IGQNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 12:13:23 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8796B2968AB;
	Wed,  7 Sep 2011 10:15:45 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180859>

This allows "git fetch" to exit after a preconfigured socket
timeout.  This is needed in case an undetected server or network
failure occurs.

The default timeout is 60 seconds.

http:// and rsync:// transports should be supported in future
changes, too.

So far, I've only tested (by hand) with a dummy server setup
using "nc -l $some_port".
---

  I run "git fetch" from cron to keep mirrors up-to-date.  I've
  noticed some cron processes running for hours/days at a time after
  network failures.  When I straced thoses processes, I saw they were
  stuck on read() syscalls to remote machines.

  I'm not familiar with this code and hope there's a better way to do
  this.  Changing wrapper.c like this in this way doesn't feel right,
  but neither does sprinkling alarm() calls in various places.

  Using a custom GIT_PROXY_COMMAND which implements timeouts on its own
  would also work, but I'd like to eventually have a consistent parameter
  unified across all remote transports for consistency and ease-of-use.

  The default 60s timeout could be too low on some slow servers
  with big repos, maybe the default should remain zero (no timeout).

 connect.c |   27 +++++++++++++++++++++++++++
 wrapper.c |   47 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index ee1d4b4..c1fa1ab 100644
--- a/connect.c
+++ b/connect.c
@@ -320,10 +320,37 @@ static int git_tcp_connect_sock(char *host, int flags)
 
 #endif /* NO_IPV6 */
 
+static int timeout_setup(const char *var, const char *value, void *cb)
+{
+	int *timeout = cb;
+
+	if (strcmp(var, "core.clienttimeout") == 0)
+		*timeout = git_config_int(var, value);
+
+	return 0;
+}
 
 static void git_tcp_connect(int fd[2], char *host, int flags)
 {
 	int sockfd = git_tcp_connect_sock(host, flags);
+	struct timeval tv;
+	int timeout = 60;
+
+	git_config(timeout_setup, &timeout);
+
+	if (timeout > 0) {
+		socklen_t len = sizeof(struct timeval);
+
+		tv.tv_sec = timeout;
+		tv.tv_usec = 0;
+		if (setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, &tv, len) < 0)
+			die_errno("could not set socket receive timeout");
+
+		tv.tv_sec = timeout;
+		tv.tv_usec = 0;
+		if (setsockopt(sockfd, SOL_SOCKET, SO_SNDTIMEO, &tv, len) < 0)
+			die_errno("could not set socket send timeout");
+	}
 
 	fd[0] = sockfd;
 	fd[1] = dup(sockfd);
diff --git a/wrapper.c b/wrapper.c
index 85f09df..09a31c6 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -109,6 +109,49 @@ void *xcalloc(size_t nmemb, size_t size)
 	return ret;
 }
 
+static int io_continuable(int fd, int optname)
+{
+	if (errno == EINTR)
+		return 1;
+
+	/*
+	 * If fd is a socket, a socket-level timeout could've been
+	 * set in git_tcp_connect().  Unfortunately EAGAIN alone
+	 * isn't enough to tell us if the timeout is user-specified
+	 * or not, so we have to try to figure it out.
+	 */
+	if (errno == EAGAIN) {
+		socklen_t len = sizeof(struct timeval);
+		struct timeval tv;
+		int flags;
+
+		/*
+		 * Let any non-blocking I/O users through.  Currently
+		 * git does not explicitly use non-blocking I/O anywhere,
+		 * but it could inherit a non-blocking descriptor.  We
+		 * rely on the fact that (currently) no sockets git itself
+		 * creates (and thus may set timeout on) also sets O_NONBLOCK.
+		 */
+		flags = fcntl(fd, F_GETFL);
+		if (flags < 0)
+			die_errno("fcntl failed to get file status flags");
+		if (flags & O_NONBLOCK)
+			return 1;
+
+		if (getsockopt(fd, SOL_SOCKET, optname, &tv, &len) < 0) {
+			if (errno == ENOTSOCK)
+				return 1;
+			die_errno("getsockopt failed to get socket option");
+		}
+		if (tv.tv_sec > 0 || tv.tv_usec > 0)
+			die("socket timed out");
+
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * xread() is the same a read(), but it automatically restarts read()
  * operations with a recoverable error (EAGAIN and EINTR). xread()
@@ -119,7 +162,7 @@ ssize_t xread(int fd, void *buf, size_t len)
 	ssize_t nr;
 	while (1) {
 		nr = read(fd, buf, len);
-		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
+		if (nr < 0 && io_continuable(fd, SO_RCVTIMEO))
 			continue;
 		return nr;
 	}
@@ -135,7 +178,7 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
 	ssize_t nr;
 	while (1) {
 		nr = write(fd, buf, len);
-		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
+		if (nr < 0 && io_continuable(fd, SO_SNDTIMEO))
 			continue;
 		return nr;
 	}
-- 
Eric Wong
