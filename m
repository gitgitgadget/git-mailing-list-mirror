From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 07/16] mingw: add kill emulation
Date: Wed,  3 Nov 2010 17:31:25 +0100
Message-ID: <1288801894-1168-8-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:32:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgGS-0002aC-T0
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab0KCQcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:32:03 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37501 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab0KCQcB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:32:01 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so391724ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eX7yVUgHtVTsfDbqMqfI691QIRnPfcPecJhxGGBnH9c=;
        b=VRtdJQrTguRl742NkAwFx9ReF7Cw3WmrX4rhn2GN/h44Y28olyuQnmi1jBAKqW7kP4
         /rXQqqcOi6dtMBGfmVhywUmXovG/fyiFkVmx0MI3eqmnCWCgj8DAmFI0vC+mMD38YMOE
         mK8UmgDadHAKohi6lbnKpEAStz/gOuOhQsNEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xejr27qY/uOLfDsN7DKz8Utjgoyb0T4gpr5pqON3GoNbSc/BvuDc4ovqPo0cJ1pMiV
         sHm5UGwroxg7jNvY5TpUJ8XlHbuR+sJrLbayNx3FgiXyClvauxGCroLdJ9cZPpIT4RBJ
         8K7VCLJvkNFpH2V94UxmaSS/qu9u35PxoVzeg=
Received: by 10.14.127.198 with SMTP id d46mr818236eei.38.1288801921229;
        Wed, 03 Nov 2010 09:32:01 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id x54sm6708521eeh.5.2010.11.03.09.32.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:32:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160620>

This is a quite limited kill-emulation; it can only handle
SIGTERM on positive pids. However, it's enough for git-daemon.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |   19 +++++++++++++++++++
 compat/mingw.h |    3 +++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2e7c644..21d1c2c 100644
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
1.7.3.2.161.gd6e00
