From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 07/16] mingw: add kill emulation
Date: Thu,  4 Nov 2010 02:35:15 +0100
Message-ID: <1288834524-2400-8-git-send-email-kusmabite@gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:35:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDok2-00013V-ME
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452Ab0KDBfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 21:35:44 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51588 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab0KDBfm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:42 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so738623ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gYbRtE8xqvqFUmB27ldiqtSVLD/gd7e+gkuqBi81Dvc=;
        b=R7KkDQzeiWZ+6Ah3eeUwegR0WuZt7ntZ4IFZ+wUbHX2cm61ipDDN+zRDlJ8sOw2tB4
         zd5waY065NdsCkwCIrKOPCbzz6b5VU78GpZ43e/yOnqsZWqjjmPDKnFkYafNtMKzeku5
         7CvDdO5amjJBc3PU7BPnxJeLPNJONnyEEipUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vtb1nVpri0bjLCzPdb7ZD6HTxhJwk+IqNU+lUXFBXp58XMyHYjEm3gGwnntvgQZilz
         Wba/7YNFLLIaJk9CbWwSMOXXD/aZ9gxW8kjpfvKr27RPeD1MmQtFkwz5H6mWYNDa5x/n
         ja1n0IC+knSpgu9+QcFLAgOOM7G5UsnZ3nKEg=
Received: by 10.213.12.203 with SMTP id y11mr129681eby.99.1288834541396;
        Wed, 03 Nov 2010 18:35:41 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id w20sm7189075eeh.12.2010.11.03.18.35.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160668>

This is a quite limited kill-emulation; it can only handle
SIGTERM on positive pids. However, it's enough for git-daemon.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |   19 +++++++++++++++++++
 compat/mingw.h |    3 +++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 47a0e88..146a6ed 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -936,6 +936,25 @@ void mingw_execv(const char *cmd, char *const *argv)
 	mingw_execve(cmd, argv, environ);
 }
 
+int mingw_kill(pid_t pid, int sig)
+{
+	if (pid > 0 && sig == SIGTERM) {
+		HANDLE h = OpenProcess(PROCESS_TERMINATE, FALSE, pid);
+
+		if (TerminateProcess(h, -1)) {
+			CloseHandle(h);
+			return 0;
+		}
+
+		errno = err_win_to_posix(GetLastError());
+		CloseHandle(h);
+		return -1;
+	}
+
+	errno = EINVAL;
+	return -1;
+}
+
 static char **copy_environ(void)
 {
 	char **env;
diff --git a/compat/mingw.h b/compat/mingw.h
index 379d7bf..51fca2f 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -143,6 +143,9 @@ static inline int mingw_unlink(const char *pathname)
 #define WNOHANG 1
 pid_t waitpid(pid_t pid, int *status, unsigned options);
 
+#define kill mingw_kill
+int mingw_kill(pid_t pid, int sig);
+
 #ifndef NO_OPENSSL
 #include <openssl/ssl.h>
 static inline int mingw_SSL_set_fd(SSL *ssl, int fd)
-- 
1.7.3.2.162.g09d37
