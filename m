From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v5 07/16] mingw: add kill emulation
Date: Fri, 22 Oct 2010 02:35:18 +0200
Message-ID: <1287707727-5780-8-git-send-email-kusmabite@gmail.com>
References: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCPuYPmBBoEJcNaSA@googlegroups.com Fri Oct 22 02:36:56 2010
Return-path: <msysgit+bncCOPdven-DxCPuYPmBBoEJcNaSA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCPuYPmBBoEJcNaSA@googlegroups.com>)
	id 1P95ct-0002V4-EL
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:36:55 +0200
Received: by mail-wy0-f186.google.com with SMTP id 11sf139996wyi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=ib0hoq9tABZJUxdSP6XAazRk45lkbqD5mchhGyi5F3E=;
        b=KWf9LsyArdU8sOLAUzUPYkDL/RmdAtQQPXYe7ZpJVWTPyKPgg9wCh4c0+01N4D2+5r
         48+pQtFzLFZJ37L5gwjlxpxr52ZFnjc82tM47A4uLiXhKc1tvKVP5t53jizeNnYMj8ME
         9MNCWcJ1pQJEw+aytW2plrDyY9aAISuqyBIkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=dc9LZvdoCeZdg/6Mb+m8ZWLzG86I+1u/pKTm4qeVPohP4adaDklPGc4Y5cUdmnzwpt
         USgpmE4RH5sUvPmyRobhLpk+m3qlqOjFWu7GiS/zFX5UPxpXDt/aKbb9fYwCvlYJHhPp
         eyTSzQLPWQlNTHr0FJGgLquZZ99GxQgj/SNes=
Received: by 10.216.59.135 with SMTP id s7mr237936wec.19.1287707791562;
        Thu, 21 Oct 2010 17:36:31 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.10.153 with SMTP id 25ls270802eev.3.p; Thu, 21 Oct 2010
 17:36:30 -0700 (PDT)
Received: by 10.14.119.141 with SMTP id n13mr151129eeh.1.1287707790704;
        Thu, 21 Oct 2010 17:36:30 -0700 (PDT)
Received: by 10.14.119.141 with SMTP id n13mr151128eeh.1.1287707790681;
        Thu, 21 Oct 2010 17:36:30 -0700 (PDT)
Received: from mail-ew0-f43.google.com (mail-ew0-f43.google.com [209.85.215.43])
        by gmr-mx.google.com with ESMTP id z6si1453609eeh.2.2010.10.21.17.36.29;
        Thu, 21 Oct 2010 17:36:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.43 as permitted sender) client-ip=209.85.215.43;
Received: by ewy20 with SMTP id 20so261660ewy.30
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:36:29 -0700 (PDT)
Received: by 10.213.11.18 with SMTP id r18mr8779366ebr.44.1287707789534;
        Thu, 21 Oct 2010 17:36:29 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q51sm2487661eeh.4.2010.10.21.17.36.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:36:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.43 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159618>

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
