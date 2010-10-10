From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 05/14] mingw: use real pid
Date: Sun, 10 Oct 2010 15:20:45 +0200
Message-ID: <1286716854-5744-6-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vr3-0004u7-MD
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757661Ab0JJNWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:22:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757619Ab0JJNWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:22:07 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=G9ys3JGXb1lPItCgd2coCTkuKgzvTmnBqKETmqQbZ+w=;
        b=QYUTFhn9gXbgWfyc7jZK83Z8hH56oN5/QRJaMIAhQS4gd7hlxUai+3NFqkD6fJr2am
         F8k+DfWDZDInKZ1h8ugw3guEJ3c4kTePW7UqIkLHp/n7RUsLRef27mb3EZDjSwwKq25K
         jibTYOmJJiAKwdGVvRq4++jGMLvKlzJinJYPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Oxrd5QiMJLiocLpTWY5SzCvRvpzLME4v3GslqqUOheFbbNwVtYngGhiiz2EE3PGfyx
         b0V4BSAieJdGXI47Svu8zS5CbHLZH9lffASNI0pfJ8cMAHddJb5jRblvQmb6h6TAcumr
         Xlvn+UJ2gFFLcGXugPPIr/4EcPyeuy7DXYyfo=
Received: by 10.14.47.78 with SMTP id s54mr1155373eeb.19.1286716926575;
        Sun, 10 Oct 2010 06:22:06 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id u9sm9033453eeh.11.2010.10.10.06.22.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:22:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158665>

The Windows port so far used process handles as PID. However,
this does not work consistently with getpid.

Change the code to use the real PID, and use OpenProcess to
get a process-handle. Store the PID and the process handle
in a table protected by a critical section, so we can safely
close the process handle later.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   10 ++-----
 2 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index cc5eb2c..4582345 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -702,6 +702,13 @@ static int env_compare(const void *a, const void *b)
 	return strcasecmp(*ea, *eb);
 }
 
+struct {
+	pid_t pid;
+	HANDLE proc;
+} *pinfo;
+static int num_pinfo;
+CRITICAL_SECTION pinfo_cs;
+
 static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 			      const char *dir,
 			      int prepend_cmd, int fhin, int fhout, int fherr)
@@ -794,7 +801,23 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 		return -1;
 	}
 	CloseHandle(pi.hThread);
-	return (pid_t)pi.hProcess;
+
+	/*
+	 * The process ID is the human-readable identifier of the process
+	 * that we want to present in log and error messages. The handle
+	 * is not useful for this purpose. But we cannot close it, either,
+	 * because it is not possible to turn a process ID into a process
+	 * handle after the process terminated.
+	 * Keep the handle in a list for waitpid.
+	 */
+	EnterCriticalSection(&pinfo_cs);
+	num_pinfo++;
+	pinfo = xrealloc(pinfo, sizeof(*pinfo) * num_pinfo);
+	pinfo[num_pinfo - 1].pid = pi.dwProcessId;
+	pinfo[num_pinfo - 1].proc = pi.hProcess;
+	LeaveCriticalSection(&pinfo_cs);
+
+	return (pid_t)pi.dwProcessId;
 }
 
 static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
@@ -1577,6 +1600,51 @@ char *getpass(const char *prompt)
 	return strbuf_detach(&buf, NULL);
 }
 
+pid_t waitpid(pid_t pid, int *status, unsigned options)
+{
+	HANDLE h = OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFORMATION,
+	    FALSE, pid);
+	if (!h) {
+		errno = ECHILD;
+		return -1;
+	}
+
+	if (options == 0) {
+		int i;
+		if (WaitForSingleObject(h, INFINITE) != WAIT_OBJECT_0) {
+			CloseHandle(h);
+			return 0;
+		}
+
+		if (status)
+			GetExitCodeProcess(h, (LPDWORD)status);
+
+		EnterCriticalSection(&pinfo_cs);
+
+		for (i = 0; i < num_pinfo; ++i)
+			if (pinfo[i].pid == pid)
+				break;
+
+		if (i < num_pinfo) {
+			CloseHandle(pinfo[i].proc);
+			memmove(pinfo + i, pinfo + i + 1,
+			    sizeof(*pinfo) * (num_pinfo - i - 1));
+			num_pinfo--;
+			pinfo = xrealloc(pinfo,
+			    sizeof(*pinfo) * num_pinfo);
+		}
+
+		LeaveCriticalSection(&pinfo_cs);
+
+		CloseHandle(h);
+		return pid;
+	}
+	CloseHandle(h);
+
+	errno = EINVAL;
+	return -1;
+}
+
 #ifndef NO_MINGW_REPLACE_READDIR
 /* MinGW readdir implementation to avoid extra lstats for Git */
 struct mingw_DIR
diff --git a/compat/mingw.h b/compat/mingw.h
index bbfcc0c..96ed931 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -153,13 +153,7 @@ static inline int mingw_unlink(const char *pathname)
 }
 #define unlink mingw_unlink
 
-static inline pid_t waitpid(pid_t pid, int *status, unsigned options)
-{
-	if (options == 0)
-		return _cwait(status, pid, 0);
-	errno = EINVAL;
-	return -1;
-}
+pid_t waitpid(pid_t pid, int *status, unsigned options);
 
 #ifndef NO_OPENSSL
 #include <openssl/ssl.h>
@@ -336,11 +330,13 @@ void free_environ(char **env);
 static int mingw_main(); \
 int main(int argc, const char **argv) \
 { \
+	extern CRITICAL_SECTION pinfo_cs; \
 	_fmode = _O_BINARY; \
 	_setmode(_fileno(stdin), _O_BINARY); \
 	_setmode(_fileno(stdout), _O_BINARY); \
 	_setmode(_fileno(stderr), _O_BINARY); \
 	argv[0] = xstrdup(_pgmptr); \
+	InitializeCriticalSection(&pinfo_cs); \
 	return mingw_main(argc, argv); \
 } \
 static int mingw_main(c,v)
-- 
1.7.3.1.51.ge462f.dirty
