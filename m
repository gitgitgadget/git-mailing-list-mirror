From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 05/16] mingw: use real pid
Date: Thu,  4 Nov 2010 02:35:13 +0100
Message-ID: <1288834524-2400-6-git-send-email-kusmabite@gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:35:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDok2-00013V-5t
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab0KDBfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 21:35:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51588 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424Ab0KDBfh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:37 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so738623ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=M8+0S4TlzW4tyUkh3ThbgI7hhjpWVZAvEs/ohrxVccI=;
        b=pw9SB/MBRJvOeBXp5v+gwkz41KUbw+laxDmWUatLU0zxLanw/4pl/RZkw9F07guJae
         b82MgtGIPdnOcYoC0/YoWdOr5LDHiXj38lqllPe9EQgwsShJ0wt+Ja1QgJYsIF4TyLqr
         tkr8Su4w+nxparlqFKUI9vIvKfCcb9plTaJn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XIorci2WZk+sH8Uu2EsJj1ZEZwFA0IYdMXSWn7p3QNyg/g9xjZD4xA3d7aOCA4FIvA
         XwIyc1B8QHHrBYDzC4Ktnvoxb1IJPpVfxPLQ7n/95SBY5Cu86zxbTYC73vq6rKTaXaf/
         kcc14+ABSSODLoE5Np+TA9eprnqr0R6bGXxeM=
Received: by 10.213.27.76 with SMTP id h12mr144754ebc.60.1288834537113;
        Wed, 03 Nov 2010 18:35:37 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id b52sm7189224eei.13.2010.11.03.18.35.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160667>

The Windows port have so far been using process handles in place
of PID. However, this is not work consistent with what getpid
returns.

PIDs are system-global identifiers, but process handles are local
to a process. Using PIDs instead of process handles allows, for
instance, a user to kill a hung process with the Task Manager,
something that would have been impossible with process handles.

Change the code to use the real PID, and use OpenProcess to get a
process-handle. Store the PID and the process handle in a linked
list protected by a critical section, so we can safely close the
process handle later.

Linked list code written by Pat Thoyts.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 compat/mingw.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   10 ++-----
 2 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 701a555..736d03f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -702,6 +702,14 @@ static int env_compare(const void *a, const void *b)
 	return strcasecmp(*ea, *eb);
 }
 
+struct pinfo_t {
+	struct pinfo_t *next;
+	pid_t pid;
+	HANDLE proc;
+} pinfo_t;
+struct pinfo_t *pinfo = NULL;
+CRITICAL_SECTION pinfo_cs;
+
 static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 			      const char *dir,
 			      int prepend_cmd, int fhin, int fhout, int fherr)
@@ -794,7 +802,26 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
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
+	{
+		struct pinfo_t *info = xmalloc(sizeof(struct pinfo_t));
+		info->pid = pi.dwProcessId;
+		info->proc = pi.hProcess;
+		info->next = pinfo;
+		pinfo = info;
+	}
+	LeaveCriticalSection(&pinfo_cs);
+
+	return (pid_t)pi.dwProcessId;
 }
 
 static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
@@ -1518,6 +1545,50 @@ char *getpass(const char *prompt)
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
+		struct pinfo_t **ppinfo;
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
+		ppinfo = &pinfo;
+		while (*ppinfo) {
+			struct pinfo_t *info = *ppinfo;
+			if (info->pid == pid) {
+				CloseHandle(info->proc);
+				*ppinfo = info->next;
+				free(info);
+				break;
+			}
+			ppinfo = &info->next;
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
index a5bde82..7c4eeea 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -140,13 +140,7 @@ static inline int mingw_unlink(const char *pathname)
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
@@ -321,11 +315,13 @@ void free_environ(char **env);
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
1.7.3.2.162.g09d37
