From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/6] transport: expose git_tcp_connect and friends in new
 tcp.h
Date: Mon, 6 Jun 2011 04:37:14 -0500
Message-ID: <20110606093714.GF8015@elie>
References: <20110524202249.GA5889@elie>
 <20110524230900.GA9440@radis.liafa.jussieu.fr>
 <20110606093019.GD8015@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Julien Cristau <jcristau@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 11:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTWFX-0002Dk-Rf
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 11:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab1FFJh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 05:37:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35374 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265Ab1FFJhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 05:37:25 -0400
Received: by iwn34 with SMTP id 34so2969857iwn.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 02:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=EXo5NgwJULhcfEruZuUuIn1+4mEbO0MsCKhyX/DUVXk=;
        b=fFCFj8F2kK/gxcdNhbuHnOrT5DgKQ12OvUKSO1bkEaqLTLO0p+fGi5e3nlc3nUu2L3
         g6QcxLSVZhzVFjpKmDCROFl2TvFN8l3xfMEYKdTEVvUIl+tU+7RX6skvqLr67xHYOzz2
         b7ifgWM6evD9eWZ+yMoFfLtbtIWtqzNWPlXHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sZIvKzj3EcEi0iqU97ZYrxXWe2FnIS7QBSaw/WaRux1M+pcCIe2o9cQHs+ydHW9tso
         I7w0LSUMKyPcSScY4MoVeKe06svK0mmKARhNJbQZdEhpNM67uF1sIA6uCVZAL0wOgWF7
         p/HBUFvRAoDF/JJunlaNxznaiG8Q/Rbg6cMlc=
Received: by 10.43.50.9 with SMTP id vc9mr8593391icb.232.1307353044473;
        Mon, 06 Jun 2011 02:37:24 -0700 (PDT)
Received: from elie ([68.255.97.40])
        by mx.google.com with ESMTPS id w8sm1612703ibh.52.2011.06.06.02.37.19
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 02:37:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110606093019.GD8015@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175107>

Before adding functionality to them, let's move the functions
git_tcp_connect and git_proxy_connect used to resolve a hostname and
connect to it to a separate tcp.c file.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile  |    2 +
 connect.c |  270 +------------------------------------------------------------
 tcp.c     |  269 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tcp.h     |    8 ++
 4 files changed, 280 insertions(+), 269 deletions(-)
 create mode 100644 tcp.c
 create mode 100644 tcp.h

diff --git a/Makefile b/Makefile
index e40ac0c..fa3a47f 100644
--- a/Makefile
+++ b/Makefile
@@ -666,6 +666,7 @@ LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
+LIB_OBJS += tcp.o
 LIB_OBJS += trace.o
 LIB_OBJS += transport.o
 LIB_OBJS += transport-helper.o
@@ -1958,6 +1959,7 @@ builtin/prune.o builtin/reflog.o reachable.o: reachable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o http-backend.o: url.h
+connect.o tcp.o: tcp.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h url.h
 
diff --git a/connect.c b/connect.c
index 2119c3f..9dafcc8 100644
--- a/connect.c
+++ b/connect.c
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "run-command.h"
 #include "remote.h"
+#include "tcp.h"
 #include "url.h"
 
 static char *server_capabilities;
@@ -150,275 +151,6 @@ static enum protocol get_protocol(const char *name)
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
-	int sockfd = -1, saved_errno = 0;
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
-	for (ai0 = ai; ai; ai = ai->ai_next) {
-		sockfd = socket(ai->ai_family,
-				ai->ai_socktype, ai->ai_protocol);
-		if (sockfd < 0) {
-			saved_errno = errno;
-			continue;
-		}
-		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
-			saved_errno = errno;
-			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
-				host,
-				cnt,
-				ai_name(ai),
-				strerror(saved_errno));
-			close(sockfd);
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
-		die("unable to connect a socket (%s)", strerror(saved_errno));
-
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\n");
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
-	int sockfd = -1, saved_errno = 0;
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
-		sockfd = socket(he->h_addrtype, SOCK_STREAM, 0);
-		if (sockfd < 0) {
-			saved_errno = errno;
-			continue;
-		}
-
-		memset(&sa, 0, sizeof sa);
-		sa.sin_family = he->h_addrtype;
-		sa.sin_port = htons(nport);
-		memcpy(&sa.sin_addr, *ap, he->h_length);
-
-		if (connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
-			saved_errno = errno;
-			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
-				host,
-				cnt,
-				inet_ntoa(*(struct in_addr *)&sa.sin_addr),
-				strerror(saved_errno));
-			close(sockfd);
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
-		die("unable to connect a socket (%s)", strerror(saved_errno));
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
index 0000000..89f5c62
--- /dev/null
+++ b/tcp.c
@@ -0,0 +1,269 @@
+#include "cache.h"
+#include "run-command.h"
+
+#define STR_(s)	# s
+#define STR(s)	STR_(s)
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
+	int sockfd = -1, saved_errno = 0;
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
+	for (ai0 = ai; ai; ai = ai->ai_next) {
+		sockfd = socket(ai->ai_family,
+				ai->ai_socktype, ai->ai_protocol);
+		if (sockfd < 0) {
+			saved_errno = errno;
+			continue;
+		}
+		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
+			saved_errno = errno;
+			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
+				host,
+				cnt,
+				ai_name(ai),
+				strerror(saved_errno));
+			close(sockfd);
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
+		die("unable to connect a socket (%s)", strerror(saved_errno));
+
+	if (flags & CONNECT_VERBOSE)
+		fprintf(stderr, "done.\n");
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
+	int sockfd = -1, saved_errno = 0;
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
+		sockfd = socket(he->h_addrtype, SOCK_STREAM, 0);
+		if (sockfd < 0) {
+			saved_errno = errno;
+			continue;
+		}
+
+		memset(&sa, 0, sizeof sa);
+		sa.sin_family = he->h_addrtype;
+		sa.sin_port = htons(nport);
+		memcpy(&sa.sin_addr, *ap, he->h_length);
+
+		if (connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
+			saved_errno = errno;
+			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
+				host,
+				cnt,
+				inet_ntoa(*(struct in_addr *)&sa.sin_addr),
+				strerror(saved_errno));
+			close(sockfd);
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
+		die("unable to connect a socket (%s)", strerror(saved_errno));
+
+	if (flags & CONNECT_VERBOSE)
+		fprintf(stderr, "done.\n");
+
+	return sockfd;
+}
+
+#endif /* NO_IPV6 */
+
+void git_tcp_connect(int fd[2], char *host, int flags)
+{
+	int sockfd = git_tcp_connect_sock(host, flags);
+
+	fd[0] = sockfd;
+	fd[1] = dup(sockfd);
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
index 0000000..4de5f71
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
1.7.5.3
