From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 01/14] Avoid declaration after statement
Date: Tue, 15 Sep 2009 15:44:04 +0200
Message-ID: <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	raa.lkml@gmail.com, snaury@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Tue Sep 15 15:44:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYKx-0007Be-Di
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbZIONon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 09:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754022AbZIONok
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:44:40 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:59848 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbZIONog (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 09:44:36 -0400
Received: by ewy2 with SMTP id 2so473453ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=z19TPtsCjvMI//lw0Lp/gPQfhD3Q5s2LzpXUWGaVDVg=;
        b=QOAuFR/CGA0+pjXwW7k0v/QNPw/Jo/V79wU4lxGCdOnAAv3hhG9EotyfmLmzKTEPot
         0UuLZx5NiHomWNf7RYg1zfpnmnHWlqY7GmfF6JBTymU+cNERYdSJd5UvGwcOYl99Kn4B
         uJ0+Cwgh9ie0JK5hiUbpmaV48LovN4UrQR5Co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HbmSeRx1dbduB5ZPAADRbSQZswdPDACJ1kgarRYvQwlXi6CNfKFxZs/b/xDEhka5wv
         +3R1QjqW5wptZypnG/cySOQZiKMMb84UdjB9yrDPZoJA2nlsfo3pL6ETK+RiUVcNfy1m
         WQ8or/Wz+52/NYwtwBHj9VX645Mg/fdYtVBos=
Received: by 10.216.90.203 with SMTP id e53mr2145658wef.28.1253022276829;
        Tue, 15 Sep 2009 06:44:36 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.35
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 06:44:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <cover.1253021221.git.mstormo@gmail.com>
In-Reply-To: <cover.1253021728.git.mstormo@gmail.com>
References: <cover.1253021728.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128546>

From: Frank Li <lznuaa@gmail.com>

MSVC does not understand this C99 style

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c |   14 ++++++++++----
 help.c         |    3 ++-
 run-command.c  |    2 ++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 36ef8d3..5478b74 100644
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
@@ -1120,9 +1125,9 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 #undef signal
 sig_handler_t mingw_signal(int sig, sig_handler_t handler)
 {
+	sig_handler_t old = timer_fn;
 	if (sig != SIGALRM)
 		return signal(sig, handler);
-	sig_handler_t old = timer_fn;
 	timer_fn = handler;
 	return old;
 }
@@ -1209,8 +1214,9 @@ struct dirent *mingw_readdir(DIR *dir)
 
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
index 294337e..fd51b8e 100644
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
index ac314a5..02aaedf 100644
--- a/run-command.c
+++ b/run-command.c
@@ -134,6 +134,7 @@ fail_pipe:
 		error("cannot fork() for %s: %s", cmd->argv[0],
 			strerror(failed_errno = errno));
 #else
+{
 	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
 	const char **sargv = cmd->argv;
 	char **env = environ;
@@ -197,6 +198,7 @@ fail_pipe:
 		dup2(s1, 1), close(s1);
 	if (s2 >= 0)
 		dup2(s2, 2), close(s2);
+}
 #endif
 
 	if (cmd->pid < 0) {
-- 
1.6.2.1.418.g33d56.dirty
