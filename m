From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 01/12] Avoid declaration after instruction
Date: Wed, 19 Aug 2009 23:52:36 +0800
Message-ID: <1250697167-5536-1-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:53:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdnTM-0001U8-Vo
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbZHSPw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbZHSPw7
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:52:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:41388 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbZHSPw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:52:58 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1310838rvb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=4K2IpKNCRsKatc4OrgXfgXASEEeO0VxebrehwTUiQm0=;
        b=F3mbG/0oseaqc2xWH2ySFYlw4nY9HgIXFLsg0FUgWY/xiNQGugLabInVbgfqlWxTy0
         UrSCq10wvD2ptCDgI74lsxLuwSu82Nxw5rz8R3QQbDlnlG4elwSIR2bWmeVtl9Q2UrYs
         ztCric5hcz+YMW1OBr7UO19ntoCuvwgjAgszI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aAcAnwPP9M1ZtqyLUF0IWOvhB1B1mj8izIK1hC6J0BWWFNZRrhgk6PdW9a0Pygsg6D
         Psum2K2+07rEv1U0SIalbWq/j/6QQUvdfD4HpC3BYs+1DE0/MGFyIqzzEuzg1vPAzkq0
         VgI4LEElUypsyWYUagk1i+a29X8gpY0xYGRvo=
Received: by 10.140.133.16 with SMTP id g16mr3736854rvd.202.1250697180101;
        Wed, 19 Aug 2009 08:53:00 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id g31sm1253256rvb.26.2009.08.19.08.52.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 08:52:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126551>

Microsoft Visual C++ does not understand this C99 style

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
