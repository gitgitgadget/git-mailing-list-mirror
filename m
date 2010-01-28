From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH v2] Windows: improve performance by avoiding a static dependency on ws2_32.dll and advapi32.dll
Date: Thu, 28 Jan 2010 08:15:25 +0000
Message-ID: <1264666525-4956-1-git-send-email-michael.lukashov@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 09:16:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaPYE-0007Ve-IF
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 09:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab0A1IQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 03:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897Ab0A1IQX
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 03:16:23 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:55847 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab0A1IQW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 03:16:22 -0500
Received: by bwz19 with SMTP id 19so322215bwz.28
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 00:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=GNIAxKZIR+n9an0bGlRMoDd78FUjkal+lxR8FEWrByU=;
        b=wGyAbFm9N8q8K8piO4BAMPthKapQmKnOISFKw8YlmXyOnCTnBdmmRitav33mJkyXUX
         FXkeBMK11I6y8NEjO3QQEKSTw5B9FRWAUO7lLsCckHU2bRIKWZlcn5RRD30qVPCkjVkl
         vpzJa35IrK3KGkWad2F7MsZaQ4IOYy9qtTrTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wnD3JJkrI1Cb/43XZZIRfoVcpqquCLrQiRItid9cZNxLG720MditiGP5B70rKJ0hLl
         3zZyIYTMhBiYUslSpSbl6M/gYj/5GrCdDzHFJuNEioFdOljuMONbpZpgd2dLEAluldCH
         /MGvm/mMJC4kinXOGQ9gon+V0rkTwro6cl8Ik=
Received: by 10.204.32.137 with SMTP id c9mr1170686bkd.44.1264666580780;
        Thu, 28 Jan 2010 00:16:20 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 15sm294601bwz.8.2010.01.28.00.16.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 00:16:20 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc0.1466.g79f2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138225>

ws2_32.dll is used by limited subset of git commands, such as pull,
push, fetch, send-email, ... By looking up functions that we need
at runtime, we can avoid the startup costs of this DLL.
As a result, we can remove static dependency on advapi32.dll too.

A call to "git status" loaded

before:  8 DLL
after:   4 DLL

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 Makefile       |    1 -
 compat/bswap.h |   30 +++++++++
 compat/mingw.c |  193 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   49 +++++++++++++-
 4 files changed, 265 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index af08c8f..4a79eaa 100644
--- a/Makefile
+++ b/Makefile
@@ -1041,7 +1041,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
 		compat/win32/pthread.o
-	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
 	X = .exe
 ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
diff --git a/compat/bswap.h b/compat/bswap.h
index f3b8c44..08aea39 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -1,3 +1,6 @@
+#ifndef BSWAP_H
+#define BSWAP_H
+
 /*
  * Let's make sure we always have a sane definition for ntohl()/htonl().
  * Some libraries define those as a function call, just to perform byte
@@ -17,6 +20,12 @@ static inline uint32_t default_swab32(uint32_t val)
 		((val & 0x000000ff) << 24));
 }
 
+static inline uint16_t default_swab16(uint16_t val)
+{
+	return (((val & 0xff00) >>  8) |
+		((val & 0x00ff) << 8));
+}
+
 #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
 
 #define bswap32(x) ({ \
@@ -28,11 +37,21 @@ static inline uint32_t default_swab32(uint32_t val)
 	} \
 	__res; })
 
+#define bswap16(x) ({ \
+	uint16_t __res; \
+	if (__builtin_constant_p(x)) { \
+		__res = default_swab16(x); \
+	} else { \
+		__asm__("xchgb %b0, %h0" : "=q" (__res) : "0" ((uint16_t)(x))); \
+	} \
+	__res; })
+
 #elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
 
 #include <stdlib.h>
 
 #define bswap32(x) _byteswap_ulong(x)
+#define bswap16(x) _byteswap_ushort(x)
 
 #endif
 
@@ -44,3 +63,14 @@ static inline uint32_t default_swab32(uint32_t val)
 #define htonl(x) bswap32(x)
 
 #endif
+
+#ifdef bswap16
+
+#undef ntohs
+#undef htons
+#define ntohs(x) bswap16(x)
+#define htons(x) bswap16(x)
+
+#endif
+
+#endif
diff --git a/compat/mingw.c b/compat/mingw.c
index ab65f77..484cf7c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -891,6 +891,172 @@ char **make_augmented_environ(const char *const *vars)
 	return env;
 }
 
+static HMODULE ws2_32_dll = NULL;
+static LPFN_INET_NTOA ws2_32_inet_ntoa;
+static LPFN_CONNECT ws2_32_connect;
+static LPFN_SELECT ws2_32_select;
+static LPFN_CLOSESOCKET ws2_32_closesocket;
+static LPFN_GETSERVBYPORT ws2_32_getservbyport;
+static LPFN_GETSERVBYNAME ws2_32_getservbyname;
+static LPFN_GETHOSTBYADDR ws2_32_gethostbyaddr;
+static LPFN_GETHOSTNAME ws2_32_gethostname;
+static LPFN_GETHOSTBYNAME ws2_32_gethostbyname;
+static LPFN_WSASTARTUP ws2_32_WSAStartup;
+static LPFN_WSACLEANUP ws2_32_WSACleanup;
+static LPFN_WSAGETLASTERROR ws2_32_WSAGetLastError;
+static LPFN_WSASOCKETA ws2_32_WSASocketA;
+
+static void ws2_32_cleanup(void)
+{
+	if (ws2_32_dll)
+		FreeLibrary(ws2_32_dll);
+	ws2_32_dll = NULL;
+	ws2_32_inet_ntoa = NULL;
+	ws2_32_connect = NULL;
+	ws2_32_select = NULL;
+	ws2_32_closesocket = NULL;
+	ws2_32_getservbyport = NULL;
+	ws2_32_getservbyname = NULL;
+	ws2_32_gethostbyaddr = NULL;
+	ws2_32_gethostname = NULL;
+	ws2_32_gethostbyname = NULL;
+	ws2_32_WSAStartup = NULL;
+	ws2_32_WSACleanup = NULL;
+	ws2_32_WSAGetLastError = NULL;
+	ws2_32_WSASocketA = NULL;
+}
+
+static void ensure_ws2_32_initialization(void)
+{
+	static int ws2_32_initialized = 0;
+
+	if (ws2_32_initialized)
+		return;
+
+	ws2_32_dll = LoadLibrary("ws2_32.dll");
+	if (!ws2_32_dll)
+		die("cannot load ws2_32.dll");
+
+	ws2_32_inet_ntoa = (LPFN_INET_NTOA)
+		GetProcAddress(ws2_32_dll, "inet_ntoa");
+	ws2_32_connect = (LPFN_CONNECT)
+		GetProcAddress(ws2_32_dll, "connect");
+	ws2_32_select = (LPFN_SELECT)
+		GetProcAddress(ws2_32_dll, "select");
+	ws2_32_closesocket = (LPFN_CLOSESOCKET)
+		GetProcAddress(ws2_32_dll, "closesocket");
+	ws2_32_getservbyport = (LPFN_GETSERVBYPORT)
+		GetProcAddress(ws2_32_dll, "getservbyport");
+	ws2_32_getservbyname = (LPFN_GETSERVBYNAME)
+		GetProcAddress(ws2_32_dll, "getservbyname");
+	ws2_32_gethostbyaddr = (LPFN_GETHOSTBYADDR)
+		GetProcAddress(ws2_32_dll, "gethostbyaddr");
+	ws2_32_gethostname = (LPFN_GETHOSTNAME)
+		GetProcAddress(ws2_32_dll, "gethostname");
+	ws2_32_gethostbyname = (LPFN_GETHOSTBYNAME)
+		GetProcAddress(ws2_32_dll, "gethostbyname");
+	ws2_32_WSAStartup = (LPFN_WSASTARTUP)
+		GetProcAddress(ws2_32_dll, "WSAStartup");
+	ws2_32_WSACleanup = (LPFN_WSACLEANUP)
+		GetProcAddress(ws2_32_dll, "WSACleanup");
+	ws2_32_WSAGetLastError = (LPFN_WSAGETLASTERROR)
+		GetProcAddress(ws2_32_dll, "WSAGetLastError");
+	ws2_32_WSASocketA = (LPFN_WSASOCKETA)
+		GetProcAddress(ws2_32_dll, "WSASocketA");
+
+	if (!ws2_32_inet_ntoa || !ws2_32_connect || !ws2_32_select ||
+		!ws2_32_closesocket || !ws2_32_getservbyport || !ws2_32_getservbyname ||
+		!ws2_32_gethostbyaddr || !ws2_32_gethostname || !ws2_32_gethostbyname ||
+		!ws2_32_WSAStartup || !ws2_32_WSACleanup ||
+		!ws2_32_WSAGetLastError || !ws2_32_WSASocketA) {
+		FreeLibrary(ws2_32_dll);
+		ws2_32_dll = NULL;
+		die("cannot initialize ws2_32.dll");
+	}
+	atexit(ws2_32_cleanup);
+	ws2_32_initialized = 1;
+}
+
+char *mingw_inet_ntoa(struct in_addr in)
+{
+	ensure_ws2_32_initialization();
+	return ws2_32_inet_ntoa(in);
+}
+
+int mingw_closesocket(SOCKET s)
+{
+	ensure_ws2_32_initialization();
+	return ws2_32_closesocket(s);
+}
+
+int mingw_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
+			const struct timeval *timeout)
+{
+	ensure_ws2_32_initialization();
+	return ws2_32_select(nfds, readfds, writefds, exceptfds, timeout);
+}
+
+struct servent *mingw_getservbyport(int port, const char *proto)
+{
+	ensure_ws2_32_initialization();
+	return ws2_32_getservbyport(port, proto);
+}
+
+struct hostent *mingw_gethostbyaddr(const char *addr, int len, int type)
+{
+	ensure_ws2_32_initialization();
+	return ws2_32_gethostbyaddr(addr, len, type);
+}
+
+int mingw_gethostname(char *name, int namelen)
+{
+	ensure_ws2_32_initialization();
+	return ws2_32_gethostname(name, namelen);
+}
+
+struct servent *mingw_getservbyname(const char *name, const char *proto)
+{
+	ensure_ws2_32_initialization();
+	return ws2_32_getservbyname(name, proto);
+}
+
+int mingw_WSAStartup(WORD wVersionRequested, LPWSADATA lpWSAData)
+{
+	ensure_ws2_32_initialization();
+	return ws2_32_WSAStartup(wVersionRequested, lpWSAData);
+}
+
+int mingw_WSACleanup(void)
+{
+	ensure_ws2_32_initialization();
+	return ws2_32_WSACleanup();
+}
+
+int mingw_WSAGetLastError(void)
+{
+	ensure_ws2_32_initialization();
+	return ws2_32_WSAGetLastError();
+}
+
+SOCKET mingw_WSASocketA(int af, int type, int protocol,
+			LPWSAPROTOCOL_INFOA lpProtocolInfo,
+			GROUP g, DWORD dwFlags)
+{
+	ensure_ws2_32_initialization();
+	return ws2_32_WSASocketA(af, type, protocol, lpProtocolInfo, g, dwFlags);
+}
+
+static HMODULE advapi32_dll = NULL;
+static BOOL (WINAPI *advapi32_get_user_name)(char *, DWORD *);
+
+static void advapi32_cleanup(void)
+{
+	if (advapi32_dll)
+		FreeLibrary(advapi32_dll);
+	advapi32_dll = NULL;
+	advapi32_get_user_name = NULL;
+}
+
 /*
  * Note, this isn't a complete replacement for getaddrinfo. It assumes
  * that service contains a numerical port, or that it it is null. It
@@ -1057,11 +1223,13 @@ static void ensure_socket_initialization(void)
 struct hostent *mingw_gethostbyname(const char *host)
 {
 	ensure_socket_initialization();
-	return gethostbyname(host);
+	ensure_ws2_32_initialization();
+	return ws2_32_gethostbyname(host);
 }
 
 void mingw_freeaddrinfo(struct addrinfo *res)
 {
+	ensure_socket_initialization();
 	ipv6_freeaddrinfo(res);
 }
 
@@ -1110,7 +1278,8 @@ int mingw_socket(int domain, int type, int protocol)
 int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz)
 {
 	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
-	return connect(s, sa, sz);
+	ensure_ws2_32_initialization();
+	return ws2_32_connect(s, sa, sz);
 }
 
 #undef rename
@@ -1180,9 +1349,27 @@ struct passwd *getpwuid(int uid)
 {
 	static char user_name[100];
 	static struct passwd p;
+	static int advapi32_initialized = 0;
 
 	DWORD len = sizeof(user_name);
-	if (!GetUserName(user_name, &len))
+
+	if (!advapi32_initialized)
+	{
+		advapi32_dll = LoadLibrary("advapi32.dll");
+		if (!advapi32_dll)
+			die("cannot load advapi32.dll");
+		advapi32_get_user_name = (BOOL (WINAPI *)(char *, DWORD *))
+			GetProcAddress(advapi32_dll, "GetUserNameA");
+		if (!advapi32_get_user_name) {
+			FreeLibrary(advapi32_dll);
+			advapi32_dll = NULL;
+			die("cannot find GetUserNameA");
+		}
+		atexit(advapi32_cleanup);
+		advapi32_initialized = 1;
+	}
+
+	if (!advapi32_get_user_name(user_name, &len))
 		return NULL;
 	p.pw_name = user_name;
 	p.pw_gecos = "unknown";
diff --git a/compat/mingw.h b/compat/mingw.h
index e254fb4..466c473 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -1,5 +1,6 @@
 #include <winsock2.h>
 #include <ws2tcpip.h>
+#include "bswap.h"
 
 /*
  * things that are not available in header files
@@ -176,9 +177,53 @@ char *mingw_getcwd(char *pointer, int len);
 char *mingw_getenv(const char *name);
 #define getenv mingw_getenv
 
+/*
+ * wrappers for functions dynamically loaded from ws2_32.dll
+ */
+
+char *mingw_inet_ntoa(struct in_addr in);
+#define inet_ntoa mingw_inet_ntoa
+
+int mingw_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
+			const struct timeval *timeout);
+#define select mingw_select
+
+int mingw_closesocket(SOCKET s);
+#define closesocket mingw_closesocket
+
+struct servent *mingw_getservbyport(int port, const char *proto);
+#define getservbyport mingw_getservbyport
+
+struct servent *mingw_getservbyname(const char *name, const char *proto);
+#define getservbyname mingw_getservbyname
+
+struct hostent *mingw_gethostbyaddr(const char *addr, int len, int type);
+#define gethostbyaddr mingw_gethostbyaddr
+
+int mingw_gethostname(char *name, int namelen);
+#define gethostname mingw_gethostname
+
 struct hostent *mingw_gethostbyname(const char *host);
 #define gethostbyname mingw_gethostbyname
 
+int mingw_WSAStartup(WORD wVersionRequested, LPWSADATA lpWSAData);
+#define WSAStartup mingw_WSAStartup
+
+int mingw_WSACleanup(void);
+#define WSACleanup mingw_WSACleanup
+
+int mingw_WSAGetLastError(void);
+#define WSAGetLastError mingw_WSAGetLastError
+
+SOCKET mingw_WSASocketA(int af, int type, int protocol,
+			LPWSAPROTOCOL_INFOA lpProtocolInfo,
+			GROUP g, DWORD dwFlags);
+#define WSASocketA mingw_WSASocketA
+
+/*
+ * support for IPv6 on MinGW
+ */
+
 void mingw_freeaddrinfo(struct addrinfo *res);
 #define freeaddrinfo mingw_freeaddrinfo
 
@@ -227,10 +272,6 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
 void mingw_execvp(const char *cmd, char *const *argv);
 #define execvp mingw_execvp
 
-static inline unsigned int git_ntohl(unsigned int x)
-{ return (unsigned int)ntohl(x); }
-#define ntohl git_ntohl
-
 sig_handler_t mingw_signal(int sig, sig_handler_t handler);
 #define signal mingw_signal
 
-- 
1.7.0.rc0.1466.g79f2.dirty
