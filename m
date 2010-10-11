From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4 01/15] mingw: add network-wrappers for daemon
Date: Mon, 11 Oct 2010 23:50:15 +0200
Message-ID: <1286833829-5116-2-git-send-email-kusmabite@gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com, Mike Pape <dotzenlabs@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 23:51:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5QHI-0005xW-Vj
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 23:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474Ab0JKVvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 17:51:14 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36668 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756431Ab0JKVvN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 17:51:13 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so833577ewy.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UCIGUKdESajhQU05sOJD6+yn4F5bdS5mN4woLWeAmeo=;
        b=n0LqFN3LP4YxuZtEo9sxLytQcFFiWOanimpF09yZiLNXw9sH5puIjWvvajVgw0752M
         a7Rh8agqmlqRZYUU+sY6h9UaohuODYghUsddkMplHiHDO1IX4G44lfzFUvPWpMDUqaBu
         dN33UI9sN80QyItLLdjgbMNziWnQv/L0HbUzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Q4oPd2XWonzeFypQ4VLaO72RP8MyT/Wo/QB1yL9Kk3DCAJk2rMD8NfhfQFqqD3wiB/
         JO2AuR8ceJgDIaAFkVsRuyLS/STXWzqiDyRtciFL+cWgiebdfUqrwT+eSY07QV53zyeV
         d4lAxsuLiTOPMhXIFtLO+KuYSnV+O80v+YWgY=
Received: by 10.14.47.140 with SMTP id t12mr3634250eeb.25.1286833872221;
        Mon, 11 Oct 2010 14:51:12 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm1574990eeh.17.2010.10.11.14.51.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 14:51:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158793>

From: Mike Pape <dotzenlabs@gmail.com>

git-daemon requires some socket-functionality that is not yet
supported in the Windows-port. This patch adds said functionality,
and makes sure WSAStartup gets called by socket(), since it is the
first network-call in git-daemon.

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   16 ++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6590f33..701a555 100644
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
@@ -1205,6 +1208,45 @@ int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz)
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
+		int err = errno;
+		closesocket(s2);
+		return error("unable to make a socket file descriptor: %s",
+			strerror(err));
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
1.7.3.1.199.g72340
