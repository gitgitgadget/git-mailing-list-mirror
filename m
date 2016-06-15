From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 05/16] mingw: use real pid
Date: Wed,  3 Nov 2010 17:31:23 +0100
Message-ID: <1288801894-1168-6-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:33:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgGV-0002aC-Gp
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098Ab0KCQcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:32:18 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51665 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab0KCQcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:32:12 -0400
Received: by eye27 with SMTP id 27so386627eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9eShgi9HR2e9IpLqVmhMSFv9txCxv5WOryH6vHHl54E=;
        b=EqwstuLxu5kqivkPDxO19THSA9jjKfiF4H1AybWDMpAnLlGVhI2rylFMwTNdlh33/v
         eF6ECqwj73d6Y4YWHYTmepMrUYt7ZH5vjWFs9ALn1KIi2ZmnIRwSPIuH+NIoFjJ714vs
         iqePmB2p+BmgTbVp+bFdQQVSnU+87uMjOfKZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fXVYjydlSfm975Dh4oJKk0a1oPRg6E4Bn2CG42/FX1I5yZUZLa6aNMvjeHZQG7rAfe
         VegI0ZvByLYLOwYZT9Dvs4/FECAFUhqZqMBbg5wvxV0V9VMyfL6wNLWYTcVvi3u5IxhB
         kyYOGirsxen3CkHFD+/K+YmLTOIDClRpZre8w=
Received: by 10.213.19.13 with SMTP id y13mr3134136eba.28.1288801916735;
        Wed, 03 Nov 2010 09:31:56 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id v51sm6712362eeh.4.2010.11.03.09.31.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:31:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160624>

The Windows port have so far been using process handles in place
of PID. However, this is not work consistent with what getpid
returns.

PIDs are system-global identifiers, but process handles are local
to a process. Using PIDs instead of process handles allows, for
instance, a user to kill a hung process with the Task Manager,
something that would have been impossible with process handles.

Change the code to use the real PID, and use OpenProcess to get a
process-handle. Store the PID and the process handle in a table
protected by a critical section, so we can safely close the
process handle later.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   10 ++-----
 2 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 701a555..e2e3c54 100644
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
@@ -1518,6 +1541,51 @@ char *getpass(const char *prompt)
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
1.7.3.2.161.gd6e00
