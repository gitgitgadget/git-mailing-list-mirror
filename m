From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 26/40] Windows: Implement wrappers for gethostbyname(), socket(), and connect().
Date: Wed, 27 Feb 2008 19:54:49 +0100
Message-ID: <1204138503-6126-27-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVX-00022R-Gk
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbYB0S4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755547AbYB0S4L
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:11 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40453 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631AbYB0SzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:10 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id C7EAC974ED;
	Wed, 27 Feb 2008 19:55:08 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75283>

gethostbyname() is the first function that calls into the Winsock library,
and it is wrapped only to initialize the library.

socket() is wrapped for two reasons:
- Windows's socket() creates things that are like low-level file handles,
  and they must be converted into file descriptors first.
- And these handles cannot be used with plain ReadFile()/WriteFile()
  because they are opened for "overlapped IO". We have to use WSASocket()
  to create non-overlapped IO sockets.

connect() must be wrapped because Windows's connect() expects the low-level
sockets, not file descriptors, and we must first unwrap the file descriptor
before we can pass it on to Windows's connect().

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c    |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |    9 +++++++++
 2 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 837d741..1260be8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -436,6 +436,52 @@ char **env_setenv(char **env, const char *name)
 	return env;
 }
 
+/* this is the first function to call into WS_32; initialize it */
+#undef gethostbyname
+struct hostent *mingw_gethostbyname(const char *host)
+{
+	WSADATA wsa;
+
+	if (WSAStartup(MAKEWORD(2,2), &wsa))
+		die("unable to initialize winsock subsystem, error %d",
+			WSAGetLastError());
+	atexit((void(*)(void)) WSACleanup);
+	return gethostbyname(host);
+}
+
+int mingw_socket(int domain, int type, int protocol)
+{
+	int sockfd;
+	SOCKET s = WSASocket(domain, type, protocol, NULL, 0, 0);
+	if (s == INVALID_SOCKET) {
+		/*
+		 * WSAGetLastError() values are regular BSD error codes
+		 * biased by WSABASEERR.
+		 * However, strerror() does not know about networking
+		 * specific errors, which are values beginning at 38 or so.
+		 * Therefore, we choose to leave the biased error code
+		 * in errno so that _if_ someone looks up the code somewhere,
+		 * then it is at least the number that are usually listed.
+		 */
+		errno = WSAGetLastError();
+		return -1;
+	}
+	/* convert into a file descriptor */
+	if ((sockfd = _open_osfhandle(s, O_RDWR|O_BINARY)) < 0) {
+		closesocket(s);
+		return error("unable to make a socket file descriptor: %s",
+			strerror(errno));
+	}
+	return sockfd;
+}
+
+#undef connect
+int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz)
+{
+	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
+	return connect(s, sa, sz);
+}
+
 #undef rename
 int mingw_rename(const char *pold, const char *pnew)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index 046891d..0324789 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -596,6 +596,15 @@ int mingw_open (const char *filename, int oflags, ...);
 char *mingw_getcwd(char *pointer, int len);
 #define getcwd mingw_getcwd
 
+struct hostent *mingw_gethostbyname(const char *host);
+#define gethostbyname mingw_gethostbyname
+
+int mingw_socket(int domain, int type, int protocol);
+#define socket mingw_socket
+
+int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz);
+#define connect mingw_connect
+
 int mingw_rename(const char*, const char*);
 #define rename mingw_rename
 
-- 
1.5.4.1.126.ge5a7d
