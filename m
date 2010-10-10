From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 07/14] mingw: add kill emulation
Date: Sun, 10 Oct 2010 15:20:47 +0200
Message-ID: <1286716854-5744-8-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:22:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vrN-00053F-0y
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708Ab0JJNWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:22:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757697Ab0JJNWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:22:24 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xReoKxWgrNAd7JU4t40oRFixkVzMECU2pntuMa50fBc=;
        b=v3aBpHUcgXD6AWhLWMFa40rUNXbNybf4FgTxUFvJuNg79vqHp+RSVZuSsmyimG7M10
         ZVTrXfPwzzlOJqeA4uHy48ieGt4OvK2GbFeuHd84TSrTv4l3WDbHRLYU9Cd3vvv/nJus
         yCq0lpohj5LK+OclySPVbGTsB0ioMLa8JTADQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NBLsvQY+dH1ednop/D+2ILO+awCs2qnnoMl8VrMFb8K5BQInkSvfjjzUhTClC3pJX6
         hf+xol95lUe+3lFLzbCwP0T1F8gtc/2bRjPLtVvInIcYM17SSq/zRpxsQfGsWomr/uFt
         SS3Mauc3mul6z2w803Ft64EjjJUro75ZCy64k=
Received: by 10.14.37.7 with SMTP id x7mr1408964eea.23.1286716943496;
        Sun, 10 Oct 2010 06:22:23 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id p53sm1609084eeh.7.2010.10.10.06.22.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:22:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158667>

This is a quite limited kill-emulation; it can only handle
SIGTERM on positive pids. However, it's enough for git-daemon.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |   19 +++++++++++++++++++
 compat/mingw.h |    3 +++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 55ea250..44ea419 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -932,6 +932,25 @@ void mingw_execv(const char *cmd, char *const *argv)
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
index 6d7a3f6..2218043 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -156,6 +156,9 @@ static inline int mingw_unlink(const char *pathname)
 #define WNOHANG 1
 pid_t waitpid(pid_t pid, int *status, unsigned options);
 
+#define kill mingw_kill
+int mingw_kill(pid_t pid, int sig);
+
 #ifndef NO_OPENSSL
 #include <openssl/ssl.h>
 static inline int mingw_SSL_set_fd(SSL *ssl, int fd)
-- 
1.7.3.1.51.ge462f.dirty
