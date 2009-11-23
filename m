From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: [PATCH 2/2] Enable support for IPv6 on MinGW
Date: Tue, 24 Nov 2009 00:55:50 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0911240055170.14228@cone.home.martin.st>
References: <alpine.DEB.2.00.0911240052440.14228@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 23:56:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NChpA-0000zx-Vr
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 23:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797AbZKWWzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 17:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756657AbZKWWzs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 17:55:48 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:35169 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756597AbZKWWzr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 17:55:47 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by jenni1.inet.fi (8.5.014)
        id 4A776AE604197FB3; Tue, 24 Nov 2009 00:55:53 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <alpine.DEB.2.00.0911240052440.14228@cone.home.martin.st>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133540>

The IPv6 support functions are loaded dynamically, to maintain backwards
compatibility with versions of Windows prior to XP, and fallback wrappers
are provided, implemented in terms of gethostbyname and gethostbyaddr.

Signed-off-by: Martin Storsjo <martin@martin.st>
---
 Makefile       |    1 -
 compat/mingw.c |  169 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   13 ++++
 3 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 25a9771..31db29d 100644
--- a/Makefile
+++ b/Makefile
@@ -982,7 +982,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
-	NO_IPV6 = YesPlease
 	NO_SETENV = YesPlease
 	NO_UNSETENV = YesPlease
 	NO_STRCASESTR = YesPlease
diff --git a/compat/mingw.c b/compat/mingw.c
index f9d82ff..0d73f15 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -903,10 +903,129 @@ char **make_augmented_environ(const char *const *vars)
 	return env;
 }
 
+/*
+ * Note, this isn't a complete replacement for getaddrinfo. It assumes
+ * that service contains a numerical port, or that it it is null. It
+ * does a simple search using gethostbyname, and returns one IPv4 host
+ * if one was found.
+ */
+static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
+				   const struct addrinfo *hints,
+				   struct addrinfo **res)
+{
+	struct hostent *h = gethostbyname(node);
+	struct addrinfo *ai;
+	struct sockaddr_in *sin;
+
+	if (!h)
+		return WSAGetLastError();
+
+	ai = xmalloc(sizeof(struct addrinfo));
+	*res = ai;
+	ai->ai_flags = 0;
+	ai->ai_family = AF_INET;
+	ai->ai_socktype = hints->ai_socktype;
+	switch (hints->ai_socktype) {
+	case SOCK_STREAM:
+		ai->ai_protocol = IPPROTO_TCP;
+		break;
+	case SOCK_DGRAM:
+		ai->ai_protocol = IPPROTO_UDP;
+		break;
+	default:
+		ai->ai_protocol = 0;
+		break;
+	}
+	ai->ai_addrlen = sizeof(struct sockaddr_in);
+	ai->ai_canonname = strdup(h->h_name);
+
+	sin = xmalloc(ai->ai_addrlen);
+	memset(sin, 0, ai->ai_addrlen);
+	sin->sin_family = AF_INET;
+	if (service)
+		sin->sin_port = htons(atoi(service));
+	sin->sin_addr = *(struct in_addr *)h->h_addr;
+	ai->ai_addr = (struct sockaddr *)sin;
+	ai->ai_next = 0;
+	return 0;
+}
+
+static void WSAAPI freeaddrinfo_stub(struct addrinfo *res)
+{
+	free(res->ai_canonname);
+	free(res->ai_addr);
+	free(res);
+}
+
+static int WSAAPI getnameinfo_stub(const struct sockaddr *sa, socklen_t salen,
+				   char *host, DWORD hostlen,
+				   char *serv, DWORD servlen, int flags)
+{
+	const struct sockaddr_in *sin = (const struct sockaddr_in *)sa;
+	if (sa->sa_family != AF_INET)
+		return EAI_FAMILY;
+	if (!host && !serv)
+		return EAI_NONAME;
+
+	if (host && hostlen > 0) {
+		struct hostent *ent = NULL;
+		if (!(flags & NI_NUMERICHOST))
+			ent = gethostbyaddr((const char *)&sin->sin_addr,
+					    sizeof(sin->sin_addr), AF_INET);
+
+		if (ent)
+			snprintf(host, hostlen, "%s", ent->h_name);
+		else if (flags & NI_NAMEREQD)
+			return EAI_NONAME;
+		else
+			snprintf(host, hostlen, "%s", inet_ntoa(sin->sin_addr));
+	}
+
+	if (serv && servlen > 0) {
+		struct servent *ent = NULL;
+		if (!(flags & NI_NUMERICSERV))
+			ent = getservbyport(sin->sin_port,
+					    flags & NI_DGRAM ? "udp" : "tcp");
+
+		if (ent)
+			snprintf(serv, servlen, "%s", ent->s_name);
+		else
+			snprintf(serv, servlen, "%d", ntohs(sin->sin_port));
+	}
+
+	return 0;
+}
+
+static HMODULE ipv6_dll = NULL;
+static void (WSAAPI *ipv6_freeaddrinfo)(struct addrinfo *res);
+static int (WSAAPI *ipv6_getaddrinfo)(const char *node, const char *service,
+				      const struct addrinfo *hints,
+				      struct addrinfo **res);
+static int (WSAAPI *ipv6_getnameinfo)(const struct sockaddr *sa, socklen_t salen,
+				      char *host, DWORD hostlen,
+				      char *serv, DWORD servlen, int flags);
+/*
+ * gai_strerror is an inline function in the ws2tcpip.h header, so we
+ * don't need to try to load that one dynamically.
+ */
+
+static void socket_cleanup(void)
+{
+	WSACleanup();
+	if (ipv6_dll)
+		FreeLibrary(ipv6_dll);
+	ipv6_dll = NULL;
+	ipv6_freeaddrinfo = freeaddrinfo_stub;
+	ipv6_getaddrinfo = getaddrinfo_stub;
+	ipv6_getnameinfo = getnameinfo_stub;
+}
+
 static void ensure_socket_initialization(void)
 {
 	WSADATA wsa;
 	static int initialized = 0;
+	const char *libraries[] = { "ws2_32.dll", "wship6.dll", NULL };
+	const char **name;
 
 	if (initialized)
 		return;
@@ -914,7 +1033,35 @@ static void ensure_socket_initialization(void)
 	if (WSAStartup(MAKEWORD(2,2), &wsa))
 		die("unable to initialize winsock subsystem, error %d",
 			WSAGetLastError());
-	atexit((void(*)(void)) WSACleanup);
+
+	for (name = libraries; *name; name++) {
+		ipv6_dll = LoadLibrary(*name);
+		if (!ipv6_dll)
+			continue;
+
+		ipv6_freeaddrinfo = (void (WSAAPI *)(struct addrinfo *))
+			GetProcAddress(ipv6_dll, "freeaddrinfo");
+		ipv6_getaddrinfo = (int (WSAAPI *)(const char *, const char *,
+						   const struct addrinfo *,
+						   struct addrinfo **))
+			GetProcAddress(ipv6_dll, "getaddrinfo");
+		ipv6_getnameinfo = (int (WSAAPI *)(const struct sockaddr *,
+						   socklen_t, char *, DWORD,
+						   char *, DWORD, int))
+			GetProcAddress(ipv6_dll, "getnameinfo");
+		if (!ipv6_freeaddrinfo || !ipv6_getaddrinfo || !ipv6_getnameinfo) {
+			FreeLibrary(ipv6_dll);
+			ipv6_dll = NULL;
+		} else
+			break;
+	}
+	if (!ipv6_freeaddrinfo || !ipv6_getaddrinfo || !ipv6_getnameinfo) {
+		ipv6_freeaddrinfo = freeaddrinfo_stub;
+		ipv6_getaddrinfo = getaddrinfo_stub;
+		ipv6_getnameinfo = getnameinfo_stub;
+	}
+
+	atexit(socket_cleanup);
 	initialized = 1;
 }
 
@@ -925,6 +1072,26 @@ struct hostent *mingw_gethostbyname(const char *host)
 	return gethostbyname(host);
 }
 
+void mingw_freeaddrinfo(struct addrinfo *res)
+{
+	ipv6_freeaddrinfo(res);
+}
+
+int mingw_getaddrinfo(const char *node, const char *service,
+		      const struct addrinfo *hints, struct addrinfo **res)
+{
+	ensure_socket_initialization();
+	return ipv6_getaddrinfo(node, service, hints, res);
+}
+
+int mingw_getnameinfo(const struct sockaddr *sa, socklen_t salen,
+		      char *host, DWORD hostlen, char *serv, DWORD servlen,
+		      int flags)
+{
+	ensure_socket_initialization();
+	return ipv6_getnameinfo(sa, salen, host, hostlen, serv, servlen, flags);
+}
+
 int mingw_socket(int domain, int type, int protocol)
 {
 	int sockfd;
diff --git a/compat/mingw.h b/compat/mingw.h
index 51993ef..b3d299f 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -1,4 +1,5 @@
 #include <winsock2.h>
+#include <ws2tcpip.h>
 
 /*
  * things that are not available in header files
@@ -178,6 +179,18 @@ char *mingw_getenv(const char *name);
 struct hostent *mingw_gethostbyname(const char *host);
 #define gethostbyname mingw_gethostbyname
 
+void mingw_freeaddrinfo(struct addrinfo *res);
+#define freeaddrinfo mingw_freeaddrinfo
+
+int mingw_getaddrinfo(const char *node, const char *service,
+		      const struct addrinfo *hints, struct addrinfo **res);
+#define getaddrinfo mingw_getaddrinfo
+
+int mingw_getnameinfo(const struct sockaddr *sa, socklen_t salen,
+		      char *host, DWORD hostlen, char *serv, DWORD servlen,
+		      int flags);
+#define getnameinfo mingw_getnameinfo
+
 int mingw_socket(int domain, int type, int protocol);
 #define socket mingw_socket
 
-- 
1.6.4.4
