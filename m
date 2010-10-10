From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 01/14] mingw: add network-wrappers for daemon
Date: Sun, 10 Oct 2010 15:20:41 +0200
Message-ID: <1286716854-5744-2-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:21:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vqa-0004eR-1H
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab0JJNVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:21:30 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab0JJNV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:21:29 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LaNveYxXmduqM3V+YjqDwxz3yYggHNE0tzYrvr2DSoI=;
        b=CQbXSZc3Lboufa70fCY44xI3ZXSuBmQbOOqt+KJRkySC/F69o1kEc3+TtC4cB5XeNK
         1q1aZ3ty2NTpmkBNXni+CdEmdvJcABcNsy9gyajN05pyAm5adVfAP2+g/F8kh+xa6/zI
         10fL2rncCeTRXxKtKPn/frVQseUQqkbbGb4kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GadBW3TrMBcH3Qac9VxdMHPCcCmVpX/Wq0OgirG72neRPTPSdYOdV+tTtAy9prruPk
         NPgAoIkz/vY76FJjQmhJ9hjrm0B0UpUZ0MThen6wwTZlsREgJDJEUZc+SrMc7zt6ZIKf
         ndOSSVjL492FW5cEOTGCeK2jSrPtC0IFl6v+o=
Received: by 10.213.16.212 with SMTP id p20mr1234738eba.17.1286716888601;
        Sun, 10 Oct 2010 06:21:28 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v8sm9035513eeh.2.2010.10.10.06.21.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:21:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158660>

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
 compat/mingw.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   16 ++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6590f33..563ef1f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1175,7 +1175,10 @@ int mingw_getnameinfo(const struct sockaddr *sa, socklen_t salen,
 int mingw_socket(int domain, int type, int protocol)
 {
 	int sockfd;
-	SOCKET s = WSASocket(domain, type, protocol, NULL, 0, 0);
+	SOCKET s;
+
+	ensure_socket_initialization();
+	s = WSASocket(domain, type, protocol, NULL, 0, 0);
 	if (s == INVALID_SOCKET) {
 		/*
 		 * WSAGetLastError() values are regular BSD error codes
@@ -1205,6 +1208,44 @@ int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz)
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
index 83e35e8..a5bde82 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -7,6 +7,7 @@
 
 typedef int pid_t;
 typedef int uid_t;
+typedef int socklen_t;
 #define hstrerror strerror
 
 #define S_IFLNK    0120000 /* Symbolic link */
@@ -47,6 +48,9 @@ typedef int uid_t;
 #define F_SETFD 2
 #define FD_CLOEXEC 0x1
 
+#define EAFNOSUPPORT WSAEAFNOSUPPORT
+#define ECONNABORTED WSAECONNABORTED
+
 struct passwd {
 	char *pw_name;
 	char *pw_gecos;
@@ -225,6 +229,18 @@ int mingw_socket(int domain, int type, int protocol);
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
1.7.3.1.51.ge462f.dirty
