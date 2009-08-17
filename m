From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 02/11] Fix declare variable at mid of function
Date: Tue, 18 Aug 2009 00:01:03 +0800
Message-ID: <1250524872-5148-2-git-send-email-lznuaa@gmail.com>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Aug 17 18:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4ew-0003gr-VI
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756451AbZHQQCC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756395AbZHQQCC
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:02:02 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:54061 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbZHQQCA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:02:00 -0400
Received: by pzk34 with SMTP id 34so1977419pzk.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3U2jYeRzod8uqzqj7PPROKCf+b6BIcpNrLaSmjVtDKg=;
        b=v5Yza1aItVBHRIm8q/FaEcWQ/4cHc9mfjXBzTR2hyArpQrzxpnMaqOLy+Gt2uyZBQ6
         w94nxIxI2rXejW6f1J7hYl/KrcxbIsMPNoL3Jqj4x4hXIa6MMePcp+v3O6rdvPVvulZp
         PGHUYn7jXHTK9bwN3TBnN9Zpb/cmTvmKQgi+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vEdwbPEQ+xlMOi53u7oc2iMgRSRQ4xXsZYRiZDgb4UQGcFtZeDsBloFQE1o6bx5dcz
         lKIAXxI4HrE0RpsSFia2gwz1htxps6dxfjVcFC7/WFLqRYc9Vtd2GYWUO4pGrV3HUphT
         w87CHzNzXi1kYLsRxxOTDfY++Hgldahthc2K4=
Received: by 10.140.201.9 with SMTP id y9mr981908rvf.225.1250524921633;
        Mon, 17 Aug 2009 09:02:01 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id g22sm28171075rvb.52.2009.08.17.09.01.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 09:02:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126202>

Some compiler such as MSVC can't support declear variable at mid of funtion at c file.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/mingw.c |   16 ++++++++++++----
 help.c         |    3 ++-
 run-command.c  |    2 ++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index bed4178..75c74b1 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -123,13 +123,17 @@ int mingw_open (const char *filename, int oflags, ...)
 {
 	va_list args;
 	unsigned mode;
+	int fd;
+
 	va_start(args, oflags);
 	mode = va_arg(args, int);
 	va_end(args);
 
 	if (!strcmp(filename, "/dev/null"))
 		filename = "nul";
-	int fd = open(filename, oflags, mode);
+
+	fd = open(filename, oflags, mode);
+
 	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
 		DWORD attrs = GetFileAttributes(filename);
 		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
@@ -580,10 +584,11 @@ static char **get_path_split(void)
 
 static void free_path_split(char **path)
 {
+	char **p = path;
+
 	if (!path)
 		return;
 
-	char **p = path;
 	while (*p)
 		free(*p++);
 	free(path);
@@ -1108,9 +1113,11 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 #undef signal
 sig_handler_t mingw_signal(int sig, sig_handler_t handler)
 {
+	sig_handler_t old;
+
 	if (sig != SIGALRM)
 		return signal(sig, handler);
-	sig_handler_t old = timer_fn;
+	old = timer_fn;
 	timer_fn = handler;
 	return old;
 }
@@ -1197,8 +1204,9 @@ struct dirent *mingw_readdir(DIR *dir)
 
 	if (dir->dd_handle == (long)INVALID_HANDLE_VALUE && dir->dd_stat == 0)
 	{
+		DWORD lasterr;
 		handle = FindFirstFileA(dir->dd_name, &buf);
-		DWORD lasterr = GetLastError();
+		lasterr = GetLastError();
 		dir->dd_handle = (long)handle;
 		if (handle == INVALID_HANDLE_VALUE && (lasterr != ERROR_NO_MORE_FILES)) {
 			errno = err_win_to_posix(lasterr);
diff --git a/help.c b/help.c
index 6c46d8b..399b0b4 100644
--- a/help.c
+++ b/help.c
@@ -127,7 +127,7 @@ static int is_executable(const char *name)
 		return 0;
 
 #ifdef __MINGW32__
-	/* cannot trust the executable bit, peek into the file instead */
+{	/* cannot trust the executable bit, peek into the file instead */
 	char buf[3] = { 0 };
 	int n;
 	int fd = open(name, O_RDONLY);
@@ -140,6 +140,7 @@ static int is_executable(const char *name)
 				st.st_mode |= S_IXUSR;
 		close(fd);
 	}
+}
 #endif
 	return st.st_mode & S_IXUSR;
 }
diff --git a/run-command.c b/run-command.c
index ff3d8e2..d1df7ab 100644
--- a/run-command.c
+++ b/run-command.c
@@ -123,6 +123,7 @@ int start_command(struct child_process *cmd)
 		exit(127);
 	}
 #else
+{
 	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
 	const char **sargv = cmd->argv;
 	char **env = environ;
@@ -186,6 +187,7 @@ int start_command(struct child_process *cmd)
 		dup2(s1, 1), close(s1);
 	if (s2 >= 0)
 		dup2(s2, 2), close(s2);
+}
 #endif
 
 	if (cmd->pid < 0) {
-- 
1.6.4.msysgit.0
