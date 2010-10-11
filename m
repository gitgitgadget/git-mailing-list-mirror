From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4 07/15] mingw: add kill emulation
Date: Mon, 11 Oct 2010 23:50:21 +0200
Message-ID: <1286833829-5116-8-git-send-email-kusmabite@gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 23:52:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5QI3-0006PT-Qo
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 23:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756579Ab0JKVwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 17:52:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36668 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134Ab0JKVwI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 17:52:08 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so833577ewy.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ib0hoq9tABZJUxdSP6XAazRk45lkbqD5mchhGyi5F3E=;
        b=ikvBYrcG3WIN4DlH5FDrM1GUBoB5AMGMlvqJXqyB7uLqV1kPRrPI2Bm3mnufgFD2R/
         jX7HvUulp2oabd2a13Xs4RVy+wl52BcwefhZxJsVLHcZli1Jqju/Z2RYo4zA4Q0tqF5g
         jybmB+YzjULlxPs8wLAbl1ylvSOR6FIaeWJY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AR/QSGYvDz2ji3YNYIEsmc1qdErjXTJFEJ6T9kNgUVeDyVA6eEgj7cD7N2fID/g0cy
         bw1lPmAFq/jOmoTn60MqwZSwQq5zqNf+MCNC/7gkWMQvxQB1NVN/RJuQNgrmbaH7jf2m
         6SyVOAS8cRG96wk4HaVM5B2+UQoFXnk+HOjL4=
Received: by 10.213.2.139 with SMTP id 11mr2002129ebj.81.1286833925128;
        Mon, 11 Oct 2010 14:52:05 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id p53sm4226327eeh.19.2010.10.11.14.52.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 14:52:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158799>

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
1.7.3.1.199.g72340
