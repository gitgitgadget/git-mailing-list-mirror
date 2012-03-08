From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/5] tcp: unify ipv4 and ipv6 code paths
Date: Thu, 8 Mar 2012 07:09:13 -0600
Message-ID: <20120308130913.GD9426@burratino>
References: <20120308124857.GA7666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Wong <normalperson@yhbt.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 14:09:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5d64-00074x-1e
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 14:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab2CHNJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 08:09:23 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43093 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab2CHNJT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 08:09:19 -0500
Received: by gghe5 with SMTP id e5so151267ggh.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 05:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y4SdMZcmusrU1xbwZKIbKxFYv9s1r5iuqfEisGhJqKg=;
        b=svTlQ92VyRdsA7ffmXO/VICXLFcZ0zphT4nXoQKayY99Q0tvtboJO02VpC0wpnZHij
         LQqjk3zH7dVW70rvKS7YxH1y+Xk8/bwYy0mgBYrHnodZjAbEKQq6V4lVh0TfJoIfOXfN
         F4xgIbl+ZMHmBPSDLqAhX7Yv0/K+tUT/gJaZeltqP+AZOQ9KG+qVJblJVQ66lHZqQ2z4
         jjFP27x+QBTQKJm2wZ7yCTveciWqPX6b97REqE7x73XTZ8QgvC+Bf8OVshEWGwQAupd7
         Kt19uuWEgwZ5BWIDDYbv3tsqY6Vdl+UPb1ARKbaROUK9lxZ2Re2XDdLdNnbz98stH504
         9d1w==
Received: by 10.60.25.37 with SMTP id z5mr2321129oef.69.1331212158666;
        Thu, 08 Mar 2012 05:09:18 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q6sm2495887obz.17.2012.03.08.05.09.17
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 05:09:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308124857.GA7666@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192593>

Date: Mon, 6 Jun 2011 04:41:28 -0500

The new DNS API abstracts away differences between the gethostbyname-
and getaddrinfo-centric interfaces for looking up a host, making the
code to use them in connect.c a little easier to read.

To make a lookup:

	resolver_result ai;
	dns_resolve(host, port, 0, &ai);
	...
	dns_free(ai);

To iterate over responses:

	resolved_address i;
	for_each_address(i, ai) {
		...
	}

In the !NO_IPV6 codepath, the git_locate_host function that is used to
find the canonical IP and hostname for a git server's public address
(for virtual hosting) tells getaddrinfo to restrict attention to TCP
services after this patch.  That should make no difference because the
service parameter is NULL.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is the title feature, corresponding to
http://thread.gmane.org/gmane.comp.version-control.git/175106/focus=175111

It needed changes to adjust to released changes in the code it touches,
but nothing is fundamentally different from v1.

 Makefile   |    5 ++
 dns-ipv4.c |   33 +++++++++++
 dns-ipv4.h |   69 +++++++++++++++++++++++
 dns-ipv6.c |   49 ++++++++++++++++
 dns-ipv6.h |   31 +++++++++++
 tcp.c      |  182 +++++++++++-------------------------------------------------
 6 files changed, 218 insertions(+), 151 deletions(-)
 create mode 100644 dns-ipv4.c
 create mode 100644 dns-ipv4.h
 create mode 100644 dns-ipv6.c
 create mode 100644 dns-ipv6.h

diff --git a/Makefile b/Makefile
index 927a079a..8b603895 100644
--- a/Makefile
+++ b/Makefile
@@ -1612,6 +1612,11 @@ ifdef NO_TRUSTABLE_FILEMODE
 endif
 ifdef NO_IPV6
 	BASIC_CFLAGS += -DNO_IPV6
+	LIB_OBJS += dns-ipv4.o
+	LIB_H += dns-ipv4.h
+else
+	LIB_OBJS += dns-ipv6.o
+	LIB_H += dns-ipv6.h
 endif
 ifdef NO_UINTMAX_T
 	BASIC_CFLAGS += -Duintmax_t=uint32_t
diff --git a/dns-ipv4.c b/dns-ipv4.c
new file mode 100644
index 00000000..911a8569
--- /dev/null
+++ b/dns-ipv4.c
@@ -0,0 +1,33 @@
+#include "cache.h"
+#include "dns-ipv4.h"
+
+int dns_resolve(const char *host, const char *port, int flags,
+		resolver_result *res)
+{
+	char *ep;
+	struct hostent *he;
+	unsigned int nport;
+
+	he = gethostbyname(host);
+	if (!he && (flags & RESOLVE_FAIL_QUIETLY))
+		return -1;
+	if (!he)
+		die("Unable to look up %s (%s)", host, hstrerror(h_errno));
+
+	if (!port) {
+		nport = 0;
+		goto done;
+	}
+	nport = strtoul(port, &ep, 10);
+	if ( ep == port || *ep ) {
+		/* Not numeric */
+		struct servent *se = getservbyname(port,"tcp");
+		if ( !se )
+			die("Unknown port %s", port);
+		nport = se->s_port;
+	}
+done:
+	res->he = he;
+	res->port = nport;
+	return 0;
+}
diff --git a/dns-ipv4.h b/dns-ipv4.h
new file mode 100644
index 00000000..6803bcba
--- /dev/null
+++ b/dns-ipv4.h
@@ -0,0 +1,69 @@
+#ifndef DNS_IPV4_H
+#define DNS_IPV4_H
+
+#ifndef HOST_NAME_MAX
+#define HOST_NAME_MAX 256
+#endif
+
+struct ipv4_address {
+	char **ap;
+	struct sockaddr_in sa;
+};
+
+struct ipv4_addrinfo {
+	struct hostent *he;
+	unsigned int port;
+};
+
+typedef struct ipv4_addrinfo resolver_result;
+typedef struct ipv4_address resolved_address;
+
+enum {
+	RESOLVE_CANONNAME = 1,
+	RESOLVE_FAIL_QUIETLY = 2
+};
+extern int dns_resolve(const char *host, const char *port, int flags,
+			resolver_result *res);
+
+static inline const char *dns_name(const resolved_address *addr)
+{
+	return inet_ntoa(*(struct in_addr *)&addr->sa.sin_addr);
+}
+
+static inline char *dns_ip_address(const resolved_address *addr,
+					const resolver_result *ai)
+{
+	char addrbuf[HOST_NAME_MAX + 1];
+	inet_ntop(ai->he->h_addrtype, &addr->sa.sin_addr,
+		  addrbuf, sizeof(addrbuf));
+	return xstrdup(addrbuf);
+}
+
+static inline int dns_fill_sockaddr_(char *ap,
+		const struct ipv4_addrinfo *ai, struct sockaddr_in *sa)
+{
+	if (!ap)	/* done. */
+		return -1;
+
+	memset(sa, 0, sizeof(*sa));
+	sa->sin_family = ai->he->h_addrtype;
+	sa->sin_port = htons(ai->port);
+	memcpy(&sa->sin_addr, ap, ai->he->h_length);
+	return 0;
+}
+
+#define for_each_address(addr, ai) \
+	for ((addr).ap = (ai).he->h_addr_list; \
+	     !dns_fill_sockaddr_(*(addr).ap, &(ai), &(addr).sa); \
+	     (addr).ap++)
+
+#define dns_family(addr, ai) ((ai).he->h_addrtype)
+#define dns_socktype(addr, ai) SOCK_STREAM
+#define dns_protocol(addr, ai) 0
+#define dns_addr(addr, ai) ((struct sockaddr *) &(addr).sa)
+#define dns_addrlen(addr, ai) sizeof((addr).sa)
+#define dns_canonname(addr, ai) ((ai).he->h_name)
+
+#define dns_free(ai) do { /* nothing */ } while (0)
+
+#endif
diff --git a/dns-ipv6.c b/dns-ipv6.c
new file mode 100644
index 00000000..ca59ff91
--- /dev/null
+++ b/dns-ipv6.c
@@ -0,0 +1,49 @@
+#include "cache.h"
+#include "dns-ipv6.h"
+
+#ifndef HOST_NAME_MAX
+#define HOST_NAME_MAX 256
+#endif
+
+const char *dns_name(const resolved_address *i)
+{
+	const struct addrinfo *ai = *i;
+	static char addr[NI_MAXHOST];
+	if (getnameinfo(ai->ai_addr, ai->ai_addrlen, addr, sizeof(addr), NULL, 0,
+			NI_NUMERICHOST) != 0)
+		strcpy(addr, "(unknown)");
+
+	return addr;
+}
+
+char *dns_ip_address(const resolved_address *i, const resolver_result *ai0)
+{
+	const struct addrinfo *ai = *i;
+	char addrbuf[HOST_NAME_MAX + 1];
+	struct sockaddr_in *sin_addr;
+
+	sin_addr = (void *)ai->ai_addr;
+	inet_ntop(AF_INET, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
+	return xstrdup(addrbuf);
+}
+
+int dns_resolve(const char *host, const char *port, int flags,
+		resolver_result *res)
+{
+	struct addrinfo hints;
+	int gai;
+
+	memset(&hints, 0, sizeof(hints));
+	if (flags & RESOLVE_CANONNAME)
+		hints.ai_flags = AI_CANONNAME;
+	hints.ai_socktype = SOCK_STREAM;
+	hints.ai_protocol = IPPROTO_TCP;
+
+	gai = getaddrinfo(host, port, &hints, res);
+	if (gai && (flags & RESOLVE_FAIL_QUIETLY))
+		return -1;
+	if (gai)
+		die("Unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
+
+	return 0;
+}
diff --git a/dns-ipv6.h b/dns-ipv6.h
new file mode 100644
index 00000000..16bf84b5
--- /dev/null
+++ b/dns-ipv6.h
@@ -0,0 +1,31 @@
+#ifndef DNS_IPV6_H
+#define DNS_IPV6_H
+
+typedef struct addrinfo *resolver_result;
+typedef const struct addrinfo *resolved_address;
+
+enum {
+	RESOLVE_CANONNAME = 1,
+	RESOLVE_FAIL_QUIETLY = 2
+};
+extern int dns_resolve(const char *host, const char *port, int flags,
+			resolver_result *res);
+/* result is in static buffer */
+extern const char *dns_name(const resolved_address *i);
+/* result is in malloc'ed buffer */
+extern char *dns_ip_address(const resolved_address *i,
+				const resolver_result *ai);
+
+#define for_each_address(i, ai) \
+	for (i = ai; i; i = (i)->ai_next)
+
+#define dns_family(i, ai) ((i)->ai_family)
+#define dns_socktype(i, ai) ((i)->ai_socktype)
+#define dns_protocol(i, ai) ((i)->ai_protocol)
+#define dns_addr(i, ai) ((i)->ai_addr)
+#define dns_addrlen(i, ai) ((i)->ai_addrlen)
+#define dns_canonname(i, ai) ((i)->ai_canonname)
+
+#define dns_free(ai) freeaddrinfo(ai)
+
+#endif
diff --git a/tcp.c b/tcp.c
index 9263e0d2..4239daf3 100644
--- a/tcp.c
+++ b/tcp.c
@@ -1,8 +1,10 @@
 #include "cache.h"
 #include "run-command.h"
 
-#ifndef HOST_NAME_MAX
-#define HOST_NAME_MAX 256
+#ifndef NO_IPV6
+#include "dns-ipv6.h"
+#else
+#include "dns-ipv4.h"
 #endif
 
 #define STR_(s)	# s
@@ -39,44 +41,27 @@ static void enable_keepalive(int sockfd)
 			strerror(errno));
 }
 
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
 void git_locate_host(const char *hostname, char **ip_address,
 					char **canon_hostname)
 {
-	struct addrinfo hints;
-	struct addrinfo *ai;
-	int gai;
-	static char addrbuf[HOST_NAME_MAX + 1];
-	struct sockaddr_in *sin_addr;
+	resolver_result ai;
+	resolved_address i;
 
-	memset(&hints, 0, sizeof(hints));
-	hints.ai_flags = AI_CANONNAME;
-
-	gai = getaddrinfo(hostname, NULL, &hints, &ai);
-	if (gai)
+	if (dns_resolve(hostname, NULL,
+			RESOLVE_CANONNAME | RESOLVE_FAIL_QUIETLY, &ai))
 		return;
 
-	sin_addr = (void *)ai->ai_addr;
-	inet_ntop(AF_INET, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
-	free(*ip_address);
-	*ip_address = xstrdup(addrbuf);
+	for_each_address(i, ai) {
+		free(*ip_address);
+		*ip_address = dns_ip_address(&i, &ai);
 
-	free(*canon_hostname);
-	*canon_hostname = xstrdup(ai->ai_canonname ?
-				  ai->ai_canonname : *ip_address);
+		free(*canon_hostname);
+		*canon_hostname = xstrdup(dns_canonname(i, ai) ?
+					dns_canonname(i, ai) : *ip_address);
+		break;
+	}
 
-	freeaddrinfo(ai);
+	dns_free(ai);
 }
 
 /*
@@ -87,46 +72,42 @@ static int git_tcp_connect_sock(char *host, int flags)
 	struct strbuf error_message = STRBUF_INIT;
 	int sockfd = -1;
 	const char *port = STR(DEFAULT_GIT_PORT);
-	struct addrinfo hints, *ai0, *ai;
-	int gai;
-	int cnt = 0;
+	resolver_result ai;
+	resolved_address i;
+	int cnt = -1;
 
 	get_host_and_port(&host, &port);
 	if (!*port)
 		port = "<none>";
 
-	memset(&hints, 0, sizeof(hints));
-	hints.ai_socktype = SOCK_STREAM;
-	hints.ai_protocol = IPPROTO_TCP;
-
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "Looking up %s ... ", host);
 
-	gai = getaddrinfo(host, port, &hints, &ai);
-	if (gai)
-		die("Unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
+	if (dns_resolve(host, port, 0, &ai))
+		die("BUG: dns_resolve returned error?");
 
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
 
-	for (ai0 = ai; ai; ai = ai->ai_next, cnt++) {
-		sockfd = socket(ai->ai_family,
-				ai->ai_socktype, ai->ai_protocol);
-		if ((sockfd < 0) ||
-		    (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0)) {
+	for_each_address(i, ai) {
+		cnt++;
+		sockfd = socket(dns_family(i, ai),
+				dns_socktype(i, ai), dns_protocol(i, ai));
+		if (sockfd < 0 ||
+		    connect(sockfd, dns_addr(i, ai), dns_addrlen(i, ai)) < 0) {
 			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
-				    host, cnt, ai_name(ai), strerror(errno));
+				    host, cnt, dns_name(&i), strerror(errno));
 			if (0 <= sockfd)
 				close(sockfd);
 			sockfd = -1;
 			continue;
 		}
 		if (flags & CONNECT_VERBOSE)
-			fprintf(stderr, "%s ", ai_name(ai));
+			fprintf(stderr, "%s ", dns_name(&i));
 		break;
 	}
 
-	freeaddrinfo(ai0);
+	dns_free(ai);
 
 	if (sockfd < 0)
 		die("unable to connect to %s:\n%s", host, error_message.buf);
@@ -141,107 +122,6 @@ static int git_tcp_connect_sock(char *host, int flags)
 	return sockfd;
 }
 
-#else /* NO_IPV6 */
-
-void git_locate_host(const char *hostname, char **ip_address,
-					char **canon_hostname)
-{
-	struct hostent *hent;
-	struct sockaddr_in sa;
-	char **ap;
-	static char addrbuf[HOST_NAME_MAX + 1];
-
-	hent = gethostbyname(hostname);
-
-	ap = hent->h_addr_list;
-	memset(&sa, 0, sizeof sa);
-	sa.sin_family = hent->h_addrtype;
-	sa.sin_port = htons(0);
-	memcpy(&sa.sin_addr, *ap, hent->h_length);
-
-	inet_ntop(hent->h_addrtype, &sa.sin_addr,
-		  addrbuf, sizeof(addrbuf));
-
-	free(*canon_hostname);
-	*canon_hostname = xstrdup(hent->h_name);
-	free(*ip_address);
-	*ip_address = xstrdup(addrbuf);
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
 void git_tcp_connect(int fd[2], char *host, int flags)
 {
 	int sockfd = git_tcp_connect_sock(host, flags);
-- 
1.7.9.2
