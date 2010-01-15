From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 07/14] mingw: add kill emulation
Date: Fri, 15 Jan 2010 22:30:26 +0100
Message-ID: <1263591033-4992-8-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, j6t@kdbg.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Jan 15 22:31:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtlj-0005nP-LB
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 22:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758393Ab0AOVbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 16:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758391Ab0AOVbb
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 16:31:31 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:26410 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758389Ab0AOVba (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 16:31:30 -0500
Received: by ey-out-2122.google.com with SMTP id d26so192529eyd.19
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 13:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+IHJ82gmB9VDQReVRuFa9iW8iPPREErfTh/Ae7udfHY=;
        b=WeUi4tOh0WRCEJjHreVuuLnNW453DAyeoxtn7oWRQ7+qya1Rgx6GPZlqtcpco+OYl5
         vlij37YrmwOsZYQ3Uq6JQUCi6Q+EptgJWqNZst2VCvUBYNsnz0RPyXLyHs3sPFboG6e5
         DWtwnhQA3ISgrN6UgFrF//hLEYCRDELKkqeDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K2Jb64joJS5jyR2nPqyYdQC3XTyF81GrhSZcOxBfBGh7RHslsN46majan2lvQnJq3+
         Eyyyf+pDv0p1fq/iw21I4ZXeeV4DrTkSYR6AxoqwRM8iLBEJ4jcvQ8hyxeJIJJY8Dbiu
         6vtjXaD+SHec84XOFKnaZd8Zfzo8XOovx42uU=
Received: by 10.213.42.81 with SMTP id r17mr2975529ebe.3.1263591089905;
        Fri, 15 Jan 2010 13:31:29 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 16sm1810892ewy.2.2010.01.15.13.31.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:31:29 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137126>

This is a quite limited kill-emulation; it can only handle
SIGTERM on positive pids. However, it's enough for git-daemon.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |   19 +++++++++++++++++++
 compat/mingw.h |    3 +++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ce4f829..89b9b89 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -829,6 +829,25 @@ void mingw_execvp(const char *cmd, char *const *argv)
 	free_path_split(path);
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
+		CloseHandle(h);
+		errno = err_win_to_posix(GetLastError());
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
index ff4a76b..e72c2ee 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -176,6 +176,9 @@ static inline int waitpid(pid_t pid, int *status, unsigned options)
 	return -1;
 }
 
+#define kill mingw_kill
+int mingw_kill(pid_t pid, int sig);
+
 #ifndef NO_OPENSSL
 #include <openssl/ssl.h>
 static inline int mingw_SSL_set_fd(SSL *ssl, int fd)
-- 
1.6.6.211.g26720
