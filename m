From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 01/11] mingw: add network-wrappers for daemon
Date: Thu, 26 Nov 2009 00:44:10 +0000
Message-ID: <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSTD-00011M-P3
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbZKZAoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759714AbZKZAoN
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:44:13 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:46652 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759878AbZKZAoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:44:12 -0500
Received: by ewy19 with SMTP id 19so298499ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7kyDgnnkR5ZwPOr/ssT6r1+rJUQKLqNjLScpjQq6flc=;
        b=A6VlfZW+MdoOSEbncvslM8ZdcCAKJaJQwa8hf1f4CKe0F9U2oBp1PfHXUghyALXwsy
         fibdXSxss9ih6nMRfLF9n42crs2dWjOed37akIs0l/dgsaMicoSsu85EjsAGjLvnBvUa
         35Yn+va2FwyoWF3NeZorst04gEfSuwPH4mmn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kxPPyJ/p/OMF/oHjLQYyCQOYxbPPSgtGPX/ZGWtZQPSfNz83Qf7M0JcrG9NSogoYWa
         OZ9S8dWuaYpJ17mrVOC2Y/w0LO2C6pCyFkYxG/Q9ei5F2VRLw6l/MloZX/mzuAqDBMHi
         VmRgMRs+QELlK+GpSmiZkT+sPW6DNTjyaXTO0=
Received: by 10.213.23.75 with SMTP id q11mr7374778ebb.74.1259196257523;
        Wed, 25 Nov 2009 16:44:17 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 28sm392041eyg.12.2009.11.25.16.44.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:44:17 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133732>

From: Mike Pape <dotzenlabs@gmail.com>

git-daemon requires some socket-functionality that is not yet
supported in the Windows-port. This patch adds said functionality,
and makes sure WSAStartup gets called by socket(), since it is the
first network-call in git-daemon. In addition, a check is added to
prevent WSAStartup (and WSACleanup, though atexit) from being
called more than once, since git-daemon calls both socket() and
gethostbyname().

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 compat/mingw.h |   16 ++++++++++++++
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 10d6796..458021b 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -983,23 +983,37 @@ char **make_augmented_environ(const char *const *vars)
 	return env;
 }
 
-/* this is the first function to call into WS_32; initialize it */
-#undef gethostbyname
-struct hostent *mingw_gethostbyname(const char *host)
+static void wsa_init(void)
 {
+	static int initialized = 0;
 	WSADATA wsa;
 
+	if (initialized)
+		return;
+
 	if (WSAStartup(MAKEWORD(2,2), &wsa))
 		die("unable to initialize winsock subsystem, error %d",
 			WSAGetLastError());
 	atexit((void(*)(void)) WSACleanup);
+	initialized = 1;
+}
+
+/* this can be the first function to call into WS_32; initialize it */
+#undef gethostbyname
+struct hostent *mingw_gethostbyname(const char *host)
+{
+	wsa_init();
 	return gethostbyname(host);
 }
 
+/* this can be the first function to call into WS_32; initialize it */
 int mingw_socket(int domain, int type, int protocol)
 {
+	SOCKET s;
 	int sockfd;
-	SOCKET s = WSASocket(domain, type, protocol, NULL, 0, 0);
+
+	wsa_init();
+	s = WSASocket(domain, type, protocol, NULL, 0, 0);
 	if (s == INVALID_SOCKET) {
 		/*
 		 * WSAGetLastError() values are regular BSD error codes
@@ -1029,6 +1043,44 @@ int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz)
 	return connect(s, sa, sz);
 }
 
+#undef bind
+int mingw_bind(int sockfd, struct sockaddr *sa, size_t sz)
+{
+	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
+	return bind(s, sa, sz);
+}
+
+#undef setsockopt
+int mingw_setsockopt(int sockfd, int lvl, int optname, void *optval, int optlen)
+{
+	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
+	return setsockopt(s, lvl, optname, (const char*)optval, optlen);
+}
+
+#undef listen
+int mingw_listen(int sockfd, int backlog)
+{
+	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
+	return listen(s, backlog);
+}
+
+#undef accept
+int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
+{
+	int sockfd2;
+
+	SOCKET s1 = (SOCKET)_get_osfhandle(sockfd1);
+	SOCKET s2 = accept(s1, sa, sz);
+
+	/* convert into a file descriptor */
+	if ((sockfd2 = _open_osfhandle(s2, O_RDWR|O_BINARY)) < 0) {
+		closesocket(s2);
+		return error("unable to make a socket file descriptor: %s",
+			strerror(errno));
+	}
+	return sockfd2;
+}
+
 #undef rename
 int mingw_rename(const char *pold, const char *pnew)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index 1978f8a..f362f61 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -5,6 +5,7 @@
  */
 
 typedef int pid_t;
+typedef int socklen_t;
 #define hstrerror strerror
 
 #define S_IFLNK    0120000 /* Symbolic link */
@@ -33,6 +34,9 @@ typedef int pid_t;
 #define F_SETFD 2
 #define FD_CLOEXEC 0x1
 
+#define EAFNOSUPPORT WSAEAFNOSUPPORT
+#define ECONNABORTED WSAECONNABORTED
+
 struct passwd {
 	char *pw_name;
 	char *pw_gecos;
@@ -182,6 +186,18 @@ int mingw_socket(int domain, int type, int protocol);
 int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz);
 #define connect mingw_connect
 
+int mingw_bind(int sockfd, struct sockaddr *sa, size_t sz);
+#define bind mingw_bind
+
+int mingw_setsockopt(int sockfd, int lvl, int optname, void *optval, int optlen);
+#define setsockopt mingw_setsockopt
+
+int mingw_listen(int sockfd, int backlog);
+#define listen mingw_listen
+
+int mingw_accept(int sockfd, struct sockaddr *sa, socklen_t *sz);
+#define accept mingw_accept
+
 int mingw_rename(const char*, const char*);
 #define rename mingw_rename
 
-- 
1.6.5.rc2.7.g4f8d3
