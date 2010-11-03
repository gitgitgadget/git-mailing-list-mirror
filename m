From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 01/16] mingw: add network-wrappers for daemon
Date: Wed,  3 Nov 2010 17:31:19 +0100
Message-ID: <1288801894-1168-2-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:32:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgFn-0001tf-96
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780Ab0KCQbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:31:46 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55502 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab0KCQbp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:31:45 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so386169eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2nskjnH2qYxuCiKJRNnA0ti5NsP1lrChnS8aIG3lLDE=;
        b=PT74aIkRBk/bgcKi1g8Drq3sGjdtCKlqxcCAP973b/wGXZMvYRcfo+zh9neOEPrXEA
         kzmgtsVKryEB8TCUKmbiFjHTVYOe7OFbadzg0zKRf0GW/MSd9/u7O6lBKmD49WpGWeu5
         A7Kwiwzvr5D3/YZCpPsW3ChnNjet92c2Zioiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nRN9314+yu01mdUzdeVjG5zXnLycLltLaH+z4Tzzy2xgddXauwIHaHFZnKCCG7gcxS
         qVxYnGmoqTyjuOpPI9ZnQLXLDcbxjWvpqedZOhYF/QCTmnf0S9JOAAFf5sO4NApU6ra7
         Yw6qQljoMDwxJZKinhVc2mCc7cgyB+2Z9bgGs=
Received: by 10.213.19.203 with SMTP id c11mr4742926ebb.31.1288801904189;
        Wed, 03 Nov 2010 09:31:44 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id q58sm6709383eeh.21.2010.11.03.09.31.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:31:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160611>

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
1.7.3.2.161.gd6e00
