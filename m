From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/6] tcp: unify ipv4 and ipv6 code paths
Date: Mon, 6 Jun 2011 04:41:28 -0500
Message-ID: <20110606094128.GJ8015@elie>
References: <20110524202249.GA5889@elie>
 <20110524230900.GA9440@radis.liafa.jussieu.fr>
 <20110606093019.GD8015@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Julien Cristau <jcristau@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 11:41:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTWJX-0003lK-Lv
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 11:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab1FFJle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 05:41:34 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49924 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab1FFJld (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 05:41:33 -0400
Received: by iyb14 with SMTP id 14so2955328iyb.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/PeFz1e3D9L5H1MNgDoV/OLmjSNiDDY7eXBxR5Nq7yc=;
        b=NFq23v/ysjqLwU84FbSTGRVc+hMFM2Run7SSOU3IeC//ppzaMtXZhghtjZs4TL+sw2
         k24Tew420Pc4gVBgBtNCSYFE0pEzRpEnT/MgTWod93PtJD5fUusar9KQU/XLH/uoW9NH
         AQFALftzaABY8CShmqdj6r1Lsuy7QzsweSgLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nXpVmGqHYvvz0JehrhmqqpqH2IFbSljzvdcWBCWXn2WNrT1JZ02hEFhKWaSZzSRIMB
         MbaCUkd8TSqWSt4vZQE4RcvUFbTiapMiRXL1vcEDp/qufTr2KU2tRKlXeIbAb8VfQz6L
         yPJ9MEzC6rhE5Uj8A63zLScs04gZFxtZL6hXo=
Received: by 10.42.161.131 with SMTP id t3mr9345874icx.345.1307353292664;
        Mon, 06 Jun 2011 02:41:32 -0700 (PDT)
Received: from elie (adsl-68-255-97-40.dsl.chcgil.ameritech.net [68.255.97.40])
        by mx.google.com with ESMTPS id y1sm2654427ica.4.2011.06.06.02.41.30
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 02:41:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110606093019.GD8015@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175111>

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

In the !NO_IPV6 codepath, the git_locate_host function used to find
the canonical IP and hostname for a git server's public address (for
virtual hosting) tells getaddrinfo to restrict attention to TCP
services after this patch.  That should make a difference because the
service parameter is NULL.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile   |    5 ++
 dns-ipv4.c |   33 +++++++++++
 dns-ipv4.h |   65 ++++++++++++++++++++++
 dns-ipv6.c |   45 +++++++++++++++
 dns-ipv6.h |   31 ++++++++++
 tcp.c      |  180 +++++++++++-------------------------------------------------
 6 files changed, 211 insertions(+), 148 deletions(-)
 create mode 100644 dns-ipv4.c
 create mode 100644 dns-ipv4.h
 create mode 100644 dns-ipv6.c
 create mode 100644 dns-ipv6.h

diff --git a/Makefile b/Makefile
index df84157..7d3cb41 100644
--- a/Makefile
+++ b/Makefile
@@ -1474,6 +1474,11 @@ ifdef NO_TRUSTABLE_FILEMODE
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
index 0000000..39849c3
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
+	if (!he && (flags & RESOLVE_IGNORE_ERROR))
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
index 0000000..ef7208f
--- /dev/null
+++ b/dns-ipv4.h
@@ -0,0 +1,65 @@
+#ifndef DNS_IPV4_H
+#define DNS_IPV4_H
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
+	RESOLVE_IGNORE_ERROR = 2
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
index 0000000..b5f298a
--- /dev/null
+++ b/dns-ipv6.c
@@ -0,0 +1,45 @@
+#include "cache.h"
+#include "dns-ipv6.h"
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
+	if (gai && (flags & RESOLVE_IGNORE_ERROR))
+		return -1;
+	if (gai)
+		die("Unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
+
+	return 0;
+}
diff --git a/dns-ipv6.h b/dns-ipv6.h
new file mode 100644
index 0000000..339877f
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
+	RESOLVE_IGNORE_ERROR = 2
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
index 9916272..aacc2d1 100644
--- a/tcp.c
+++ b/tcp.c
@@ -1,6 +1,12 @@
 #include "cache.h"
 #include "run-command.h"
 
+#ifndef NO_IPV6
+#include "dns-ipv6.h"
+#else
+#include "dns-ipv4.h"
+#endif
+
 #define STR_(s)	# s
 #define STR(s)	STR_(s)
 
@@ -85,44 +91,27 @@ static void get_host_and_port(char **host, const char **port)
 	}
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
+			RESOLVE_CANONNAME | RESOLVE_IGNORE_ERROR, &ai))
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
@@ -132,52 +121,48 @@ static int git_tcp_connect_sock(char *host, int flags)
 {
 	int sockfd = -1, saved_errno = 0;
 	const char *port = STR(DEFAULT_GIT_PORT);
-	struct addrinfo hints, *ai0, *ai;
-	int gai;
-	int cnt;
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
 
-	for (cnt = 0, ai0 = ai; ai; ai = ai->ai_next, cnt++) {
-		sockfd = socket(ai->ai_family,
-				ai->ai_socktype, ai->ai_protocol);
+	for_each_address(i, ai) {
+		cnt++;
+		sockfd = socket(dns_family(i, ai),
+				dns_socktype(i, ai), dns_protocol(i, ai));
 		if (sockfd < 0) {
 			saved_errno = errno;
 			continue;
 		}
-		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
+		if (connect(sockfd, dns_addr(i, ai), dns_addrlen(i, ai)) < 0) {
 			saved_errno = errno;
 			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
 				host,
 				cnt,
-				ai_name(ai),
+				dns_name(&i),
 				strerror(saved_errno));
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
 		die("unable to connect a socket (%s)", strerror(saved_errno));
@@ -188,107 +173,6 @@ static int git_tcp_connect_sock(char *host, int flags)
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
 void git_tcp_connect(int fd[2], char *host, int flags)
 {
 	int sockfd = git_tcp_connect_sock(host, flags);
-- 
1.7.5.3
