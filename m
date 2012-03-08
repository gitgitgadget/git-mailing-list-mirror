From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/5] transport: expose git_tcp_connect() and friends in new
 tcp.h
Date: Thu, 8 Mar 2012 07:03:04 -0600
Message-ID: <20120308130304.GA9426@burratino>
References: <20120308124857.GA7666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Wong <normalperson@yhbt.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 14:03:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5d05-0008QN-5p
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 14:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757615Ab2CHNDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 08:03:14 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:56348 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753995Ab2CHNDM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 08:03:12 -0500
Received: by obbuo6 with SMTP id uo6so633829obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 05:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YNRVzDiCGO5fYO5t/WAivIDfh11TEBiuS6Ypa2NOG/I=;
        b=gC8SYDL3Z+NYGvLVPhT4gMqqEtYIJhc5azbQRMbvKwWLgdRRCraT6zH6ujSvD7qWEO
         0uPNzygvVJ6t22aW2xvk8AdAfKsUPjM3NtLcMTIc4VxYUMZ7t1GaCJOgjz3nCH/ewaOz
         SuFQWtmeuXdOOMqxUOqf+L7LxIKeM0VOpbyz47DfurrepmboblTwhlx72oSKYXg23ILf
         KG/QNFYuXJeWs+t29yLpScl2Que5wftfer6LYmkF4JATrc7YIYeorUiK60ONqujtNL8R
         nTngjcHQJ4lKm5T28x/yMhKArjYE0vZCKY7ADoMFY+oYaKHZy73swsF6LvKyDDBPU+s3
         9/iA==
Received: by 10.182.12.74 with SMTP id w10mr2259746obb.51.1331211792004;
        Thu, 08 Mar 2012 05:03:12 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id s9sm914350oee.2.2012.03.08.05.03.10
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 05:03:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308124857.GA7666@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192590>

Date: Mon, 6 Jun 2011 04:37:14 -0500

Split off a new tcp.c with the functions git_tcp_connect() and
git_proxy_connect() that resolve and connect to a host.

Part of a series to teach git to respect DNS SRV records when making
new connections.  This is a preliminary step to make the connection
library easier to understand before changing it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
From http://thread.gmane.org/gmane.comp.version-control.git/175106/focus=175107

Reviewing mass code migration is a little tricky.  My current favorite
strategy is

	git show connect.c Makefile tcp.h
	git diff HEAD^:connect.c HEAD:tcp.c

to make sure nothing important was added or dropped.

 Makefile  |    2 +
 connect.c |  277 +-----------------------------------------------------------
 tcp.c     |  278 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tcp.h     |    8 ++
 4 files changed, 289 insertions(+), 276 deletions(-)
 create mode 100644 tcp.c
 create mode 100644 tcp.h

diff --git a/Makefile b/Makefile
index e4f8e0ef..0d0ac31d 100644
--- a/Makefile
+++ b/Makefile
@@ -736,6 +736,7 @@ LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
+LIB_OBJS += tcp.o
 LIB_OBJS += trace.o
 LIB_OBJS += transport.o
 LIB_OBJS += transport-helper.o
@@ -2148,6 +2149,7 @@ builtin/prune.o builtin/reflog.o reachable.o: reachable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o url.o http-backend.o: url.h
+connect.o tcp.o: tcp.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h url.h
 
diff --git a/connect.c b/connect.c
index 912cddee..962dc030 100644
--- a/connect.c
+++ b/connect.c
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "run-command.h"
 #include "remote.h"
+#include "tcp.h"
 #include "url.h"
 
 static char *server_capabilities;
@@ -145,282 +146,6 @@ static enum protocol get_protocol(const char *name)
 	die("I don't handle protocol '%s'", name);
 }
 
-#define STR_(s)	# s
-#define STR(s)	STR_(s)
-
-static void get_host_and_port(char **host, const char **port)
-{
-	char *colon, *end;
-
-	if (*host[0] == '[') {
-		end = strchr(*host + 1, ']');
-		if (end) {
-			*end = 0;
-			end++;
-			(*host)++;
-		} else
-			end = *host;
-	} else
-		end = *host;
-	colon = strchr(end, ':');
-
-	if (colon) {
-		*colon = 0;
-		*port = colon + 1;
-	}
-}
-
-static void enable_keepalive(int sockfd)
-{
-	int ka = 1;
-
-	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0)
-		fprintf(stderr, "unable to set SO_KEEPALIVE on socket: %s\n",
-			strerror(errno));
-}
-
-#ifndef NO_IPV6
-
-static const char *ai_name(const struct addrinfo *ai)
-{
-	static char addr[NI_MAXHOST];
-	if (getnameinfo(ai->ai_addr, ai->ai_addrlen, addr, sizeof(addr), NULL, 0,
-			NI_NUMERICHOST) != 0)
-		strcpy(addr, "(unknown)");
-
-	return addr;
-}
-
-/*
- * Returns a connected socket() fd, or else die()s.
- */
-static int git_tcp_connect_sock(char *host, int flags)
-{
-	struct strbuf error_message = STRBUF_INIT;
-	int sockfd = -1;
-	const char *port = STR(DEFAULT_GIT_PORT);
-	struct addrinfo hints, *ai0, *ai;
-	int gai;
-	int cnt = 0;
-
-	get_host_and_port(&host, &port);
-	if (!*port)
-		port = "<none>";
-
-	memset(&hints, 0, sizeof(hints));
-	hints.ai_socktype = SOCK_STREAM;
-	hints.ai_protocol = IPPROTO_TCP;
-
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "Looking up %s ... ", host);
-
-	gai = getaddrinfo(host, port, &hints, &ai);
-	if (gai)
-		die("Unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
-
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
-
-	for (ai0 = ai; ai; ai = ai->ai_next, cnt++) {
-		sockfd = socket(ai->ai_family,
-				ai->ai_socktype, ai->ai_protocol);
-		if ((sockfd < 0) ||
-		    (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0)) {
-			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
-				    host, cnt, ai_name(ai), strerror(errno));
-			if (0 <= sockfd)
-				close(sockfd);
-			sockfd = -1;
-			continue;
-		}
-		if (flags & CONNECT_VERBOSE)
-			fprintf(stderr, "%s ", ai_name(ai));
-		break;
-	}
-
-	freeaddrinfo(ai0);
-
-	if (sockfd < 0)
-		die("unable to connect to %s:\n%s", host, error_message.buf);
-
-	enable_keepalive(sockfd);
-
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\n");
-
-	strbuf_release(&error_message);
-
-	return sockfd;
-}
-
-#else /* NO_IPV6 */
-
-/*
- * Returns a connected socket() fd, or else die()s.
- */
-static int git_tcp_connect_sock(char *host, int flags)
-{
-	struct strbuf error_message = STRBUF_INIT;
-	int sockfd = -1;
-	const char *port = STR(DEFAULT_GIT_PORT);
-	char *ep;
-	struct hostent *he;
-	struct sockaddr_in sa;
-	char **ap;
-	unsigned int nport;
-	int cnt;
-
-	get_host_and_port(&host, &port);
-
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "Looking up %s ... ", host);
-
-	he = gethostbyname(host);
-	if (!he)
-		die("Unable to look up %s (%s)", host, hstrerror(h_errno));
-	nport = strtoul(port, &ep, 10);
-	if ( ep == port || *ep ) {
-		/* Not numeric */
-		struct servent *se = getservbyname(port,"tcp");
-		if ( !se )
-			die("Unknown port %s", port);
-		nport = se->s_port;
-	}
-
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
-
-	for (cnt = 0, ap = he->h_addr_list; *ap; ap++, cnt++) {
-		memset(&sa, 0, sizeof sa);
-		sa.sin_family = he->h_addrtype;
-		sa.sin_port = htons(nport);
-		memcpy(&sa.sin_addr, *ap, he->h_length);
-
-		sockfd = socket(he->h_addrtype, SOCK_STREAM, 0);
-		if ((sockfd < 0) ||
-		    connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
-			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
-				host,
-				cnt,
-				inet_ntoa(*(struct in_addr *)&sa.sin_addr),
-				strerror(errno));
-			if (0 <= sockfd)
-				close(sockfd);
-			sockfd = -1;
-			continue;
-		}
-		if (flags & CONNECT_VERBOSE)
-			fprintf(stderr, "%s ",
-				inet_ntoa(*(struct in_addr *)&sa.sin_addr));
-		break;
-	}
-
-	if (sockfd < 0)
-		die("unable to connect to %s:\n%s", host, error_message.buf);
-
-	enable_keepalive(sockfd);
-
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\n");
-
-	return sockfd;
-}
-
-#endif /* NO_IPV6 */
-
-
-static void git_tcp_connect(int fd[2], char *host, int flags)
-{
-	int sockfd = git_tcp_connect_sock(host, flags);
-
-	fd[0] = sockfd;
-	fd[1] = dup(sockfd);
-}
-
-
-static char *git_proxy_command;
-
-static int git_proxy_command_options(const char *var, const char *value,
-		void *cb)
-{
-	if (!strcmp(var, "core.gitproxy")) {
-		const char *for_pos;
-		int matchlen = -1;
-		int hostlen;
-		const char *rhost_name = cb;
-		int rhost_len = strlen(rhost_name);
-
-		if (git_proxy_command)
-			return 0;
-		if (!value)
-			return config_error_nonbool(var);
-		/* [core]
-		 * ;# matches www.kernel.org as well
-		 * gitproxy = netcatter-1 for kernel.org
-		 * gitproxy = netcatter-2 for sample.xz
-		 * gitproxy = netcatter-default
-		 */
-		for_pos = strstr(value, " for ");
-		if (!for_pos)
-			/* matches everybody */
-			matchlen = strlen(value);
-		else {
-			hostlen = strlen(for_pos + 5);
-			if (rhost_len < hostlen)
-				matchlen = -1;
-			else if (!strncmp(for_pos + 5,
-					  rhost_name + rhost_len - hostlen,
-					  hostlen) &&
-				 ((rhost_len == hostlen) ||
-				  rhost_name[rhost_len - hostlen -1] == '.'))
-				matchlen = for_pos - value;
-			else
-				matchlen = -1;
-		}
-		if (0 <= matchlen) {
-			/* core.gitproxy = none for kernel.org */
-			if (matchlen == 4 &&
-			    !memcmp(value, "none", 4))
-				matchlen = 0;
-			git_proxy_command = xmemdupz(value, matchlen);
-		}
-		return 0;
-	}
-
-	return git_default_config(var, value, cb);
-}
-
-static int git_use_proxy(const char *host)
-{
-	git_proxy_command = getenv("GIT_PROXY_COMMAND");
-	git_config(git_proxy_command_options, (void*)host);
-	return (git_proxy_command && *git_proxy_command);
-}
-
-static struct child_process *git_proxy_connect(int fd[2], char *host)
-{
-	const char *port = STR(DEFAULT_GIT_PORT);
-	const char **argv;
-	struct child_process *proxy;
-
-	get_host_and_port(&host, &port);
-
-	argv = xmalloc(sizeof(*argv) * 4);
-	argv[0] = git_proxy_command;
-	argv[1] = host;
-	argv[2] = port;
-	argv[3] = NULL;
-	proxy = xcalloc(1, sizeof(*proxy));
-	proxy->argv = argv;
-	proxy->in = -1;
-	proxy->out = -1;
-	if (start_command(proxy))
-		die("cannot start proxy %s", argv[0]);
-	fd[0] = proxy->out; /* read from proxy stdout */
-	fd[1] = proxy->in;  /* write to proxy stdin */
-	return proxy;
-}
-
 #define MAX_CMD_LEN 1024
 
 static char *get_port(char *host)
diff --git a/tcp.c b/tcp.c
new file mode 100644
index 00000000..f5e1ab37
--- /dev/null
+++ b/tcp.c
@@ -0,0 +1,278 @@
+#include "cache.h"
+#include "run-command.h"
+
+#define STR_(s)	# s
+#define STR(s)	STR_(s)
+
+static void get_host_and_port(char **host, const char **port)
+{
+	char *colon, *end;
+
+	if (*host[0] == '[') {
+		end = strchr(*host + 1, ']');
+		if (end) {
+			*end = 0;
+			end++;
+			(*host)++;
+		} else
+			end = *host;
+	} else
+		end = *host;
+	colon = strchr(end, ':');
+
+	if (colon) {
+		*colon = 0;
+		*port = colon + 1;
+	}
+}
+
+static void enable_keepalive(int sockfd)
+{
+	int ka = 1;
+
+	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0)
+		fprintf(stderr, "unable to set SO_KEEPALIVE on socket: %s\n",
+			strerror(errno));
+}
+
+#ifndef NO_IPV6
+
+static const char *ai_name(const struct addrinfo *ai)
+{
+	static char addr[NI_MAXHOST];
+	if (getnameinfo(ai->ai_addr, ai->ai_addrlen, addr, sizeof(addr), NULL, 0,
+			NI_NUMERICHOST) != 0)
+		strcpy(addr, "(unknown)");
+
+	return addr;
+}
+
+/*
+ * Returns a connected socket() fd, or else die()s.
+ */
+static int git_tcp_connect_sock(char *host, int flags)
+{
+	struct strbuf error_message = STRBUF_INIT;
+	int sockfd = -1;
+	const char *port = STR(DEFAULT_GIT_PORT);
+	struct addrinfo hints, *ai0, *ai;
+	int gai;
+	int cnt = 0;
+
+	get_host_and_port(&host, &port);
+	if (!*port)
+		port = "<none>";
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_socktype = SOCK_STREAM;
+	hints.ai_protocol = IPPROTO_TCP;
+
+	if (flags & CONNECT_VERBOSE)
+		fprintf(stderr, "Looking up %s ... ", host);
+
+	gai = getaddrinfo(host, port, &hints, &ai);
+	if (gai)
+		die("Unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
+
+	if (flags & CONNECT_VERBOSE)
+		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
+
+	for (ai0 = ai; ai; ai = ai->ai_next, cnt++) {
+		sockfd = socket(ai->ai_family,
+				ai->ai_socktype, ai->ai_protocol);
+		if ((sockfd < 0) ||
+		    (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0)) {
+			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
+				    host, cnt, ai_name(ai), strerror(errno));
+			if (0 <= sockfd)
+				close(sockfd);
+			sockfd = -1;
+			continue;
+		}
+		if (flags & CONNECT_VERBOSE)
+			fprintf(stderr, "%s ", ai_name(ai));
+		break;
+	}
+
+	freeaddrinfo(ai0);
+
+	if (sockfd < 0)
+		die("unable to connect to %s:\n%s", host, error_message.buf);
+
+	enable_keepalive(sockfd);
+
+	if (flags & CONNECT_VERBOSE)
+		fprintf(stderr, "done.\n");
+
+	strbuf_release(&error_message);
+
+	return sockfd;
+}
+
+#else /* NO_IPV6 */
+
+/*
+ * Returns a connected socket() fd, or else die()s.
+ */
+static int git_tcp_connect_sock(char *host, int flags)
+{
+	struct strbuf error_message = STRBUF_INIT;
+	int sockfd = -1;
+	const char *port = STR(DEFAULT_GIT_PORT);
+	char *ep;
+	struct hostent *he;
+	struct sockaddr_in sa;
+	char **ap;
+	unsigned int nport;
+	int cnt;
+
+	get_host_and_port(&host, &port);
+
+	if (flags & CONNECT_VERBOSE)
+		fprintf(stderr, "Looking up %s ... ", host);
+
+	he = gethostbyname(host);
+	if (!he)
+		die("Unable to look up %s (%s)", host, hstrerror(h_errno));
+	nport = strtoul(port, &ep, 10);
+	if ( ep == port || *ep ) {
+		/* Not numeric */
+		struct servent *se = getservbyname(port,"tcp");
+		if ( !se )
+			die("Unknown port %s", port);
+		nport = se->s_port;
+	}
+
+	if (flags & CONNECT_VERBOSE)
+		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
+
+	for (cnt = 0, ap = he->h_addr_list; *ap; ap++, cnt++) {
+		memset(&sa, 0, sizeof sa);
+		sa.sin_family = he->h_addrtype;
+		sa.sin_port = htons(nport);
+		memcpy(&sa.sin_addr, *ap, he->h_length);
+
+		sockfd = socket(he->h_addrtype, SOCK_STREAM, 0);
+		if ((sockfd < 0) ||
+		    connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
+			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
+				host,
+				cnt,
+				inet_ntoa(*(struct in_addr *)&sa.sin_addr),
+				strerror(errno));
+			if (0 <= sockfd)
+				close(sockfd);
+			sockfd = -1;
+			continue;
+		}
+		if (flags & CONNECT_VERBOSE)
+			fprintf(stderr, "%s ",
+				inet_ntoa(*(struct in_addr *)&sa.sin_addr));
+		break;
+	}
+
+	if (sockfd < 0)
+		die("unable to connect to %s:\n%s", host, error_message.buf);
+
+	enable_keepalive(sockfd);
+
+	if (flags & CONNECT_VERBOSE)
+		fprintf(stderr, "done.\n");
+
+	return sockfd;
+}
+
+#endif /* NO_IPV6 */
+
+
+void git_tcp_connect(int fd[2], char *host, int flags)
+{
+	int sockfd = git_tcp_connect_sock(host, flags);
+
+	fd[0] = sockfd;
+	fd[1] = dup(sockfd);
+}
+
+
+static char *git_proxy_command;
+
+static int git_proxy_command_options(const char *var, const char *value,
+		void *cb)
+{
+	if (!strcmp(var, "core.gitproxy")) {
+		const char *for_pos;
+		int matchlen = -1;
+		int hostlen;
+		const char *rhost_name = cb;
+		int rhost_len = strlen(rhost_name);
+
+		if (git_proxy_command)
+			return 0;
+		if (!value)
+			return config_error_nonbool(var);
+		/* [core]
+		 * ;# matches www.kernel.org as well
+		 * gitproxy = netcatter-1 for kernel.org
+		 * gitproxy = netcatter-2 for sample.xz
+		 * gitproxy = netcatter-default
+		 */
+		for_pos = strstr(value, " for ");
+		if (!for_pos)
+			/* matches everybody */
+			matchlen = strlen(value);
+		else {
+			hostlen = strlen(for_pos + 5);
+			if (rhost_len < hostlen)
+				matchlen = -1;
+			else if (!strncmp(for_pos + 5,
+					  rhost_name + rhost_len - hostlen,
+					  hostlen) &&
+				 ((rhost_len == hostlen) ||
+				  rhost_name[rhost_len - hostlen -1] == '.'))
+				matchlen = for_pos - value;
+			else
+				matchlen = -1;
+		}
+		if (0 <= matchlen) {
+			/* core.gitproxy = none for kernel.org */
+			if (matchlen == 4 &&
+			    !memcmp(value, "none", 4))
+				matchlen = 0;
+			git_proxy_command = xmemdupz(value, matchlen);
+		}
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
+int git_use_proxy(const char *host)
+{
+	git_proxy_command = getenv("GIT_PROXY_COMMAND");
+	git_config(git_proxy_command_options, (void*)host);
+	return (git_proxy_command && *git_proxy_command);
+}
+
+struct child_process *git_proxy_connect(int fd[2], char *host)
+{
+	const char *port = STR(DEFAULT_GIT_PORT);
+	const char **argv;
+	struct child_process *proxy;
+
+	get_host_and_port(&host, &port);
+
+	argv = xmalloc(sizeof(*argv) * 4);
+	argv[0] = git_proxy_command;
+	argv[1] = host;
+	argv[2] = port;
+	argv[3] = NULL;
+	proxy = xcalloc(1, sizeof(*proxy));
+	proxy->argv = argv;
+	proxy->in = -1;
+	proxy->out = -1;
+	if (start_command(proxy))
+		die("cannot start proxy %s", argv[0]);
+	fd[0] = proxy->out; /* read from proxy stdout */
+	fd[1] = proxy->in;  /* write to proxy stdin */
+	return proxy;
+}
diff --git a/tcp.h b/tcp.h
new file mode 100644
index 00000000..4de5f712
--- /dev/null
+++ b/tcp.h
@@ -0,0 +1,8 @@
+#ifndef TCP_H
+#define TCP_H
+
+extern int git_use_proxy(const char *host);
+extern void git_tcp_connect(int fd[2], char *host, int flags);
+extern struct child_process *git_proxy_connect(int fd[2], char *host);
+
+#endif
-- 
1.7.9.2
