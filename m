From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 01/17] Avoid declaration after statement
Date: Mon, 14 Sep 2009 15:11:14 +0200
Message-ID: <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon Sep 14 15:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBML-0004Gq-EQ
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 15:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbZINNM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 09:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbZINNM3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 09:12:29 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:63892 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755186AbZINNM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 09:12:28 -0400
Received: by ey-out-2122.google.com with SMTP id 25so583393eya.19
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=1mWgANphLJ6Xnp5F/suQwQ+euJj+DOygIr2IacbJvt8=;
        b=OAtczzy0y0DcDNuq2SgQ+m13kBs2z+OQ0sWu3bQ9F61YLW7At3bmvUG9Nc4QRNwqku
         lpKXj19jZ+8jreODJcFKUBGkxL14jOiz/6zwuKV7D9Mj3DTJ2hl9EetnyzD1dBzgSA3+
         iMKPA4fxD3TZZBC/8wQH2Fnw/nANe6rLshvC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Jlao6r/cCZ6q2bQCDpjG+nW6uVLccCw825r8LCKnBtiNTCn7cS3FiLtOp1JVdEjuuc
         yp03MuflscnQmlDFGEu2PYhGL1BfYcocLOjk9jXx3zcrRdha7SGdknkS8Yd+VQj+6Sw5
         D8gTwO/Etgj98PnewD2NVSffpZG/vQecA4t34=
Received: by 10.210.156.15 with SMTP id d15mr2994573ebe.27.1252933946080;
        Mon, 14 Sep 2009 06:12:26 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.23
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Sep 2009 06:12:24 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128458>

From: Frank Li <lznuaa@gmail.com>

Microsoft Visual C++ does not understand this C99 style

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
