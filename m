From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Tue, 11 Mar 2008 22:30:56 +0100
Message-ID: <200803112230.57004.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site> <200803052221.12495.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 22:31:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZC4W-0008Ke-DP
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 22:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbYCKVbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 17:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbYCKVbD
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 17:31:03 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:44780 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbYCKVbB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 17:31:01 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id B723397A0D;
	Tue, 11 Mar 2008 22:30:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E9D28609C6;
	Tue, 11 Mar 2008 22:30:57 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <200803052221.12495.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76900>

On Wednesday 05 March 2008 22:21, Johannes Sixt wrote:
> I've now created compat/mingw.h. Below is the interdiff. Of course, it
> mostly only moves code around. But you might want to look at at mkstemp,
> PATH_SEP, PRIuMAX, and has_dos_drive_prefix. Notice also that I include
> compat/mingw.h early in git-compat-util.h instead of late.

I must admit I was very sloppy with the previous round. I had to make 
has_dos_drive_prefix a macro; otherwise we would get numerous warnings 
about "undeclared function isalpha", because the declaration appears later in 
git-compat-util.h.

On the positive side, we can now reuse Michal's vsnprintf wrapper, which fixes 
snprintf, too, (which was not the case previously). Note that on Windows we 
have to adjust the size parameter.

There's also a change in the setup of stderr in start_command() that 
corresponds to ce2cf27adc. And I made is_dir_sep into a conditional macro 
similar to has_dos_drive_prefix to get rid of another #ifdef/#endif.

-- Hannes

Here's the interdiff:

diff --git a/Makefile b/Makefile
index 68d60e7..6619523 100644
--- a/Makefile
+++ b/Makefile
@@ -309,7 +309,7 @@ LIB_H = \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
 	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h fsck.h \
-	pack-revindex.h
+	pack-revindex.h compat/mingw.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -549,10 +549,12 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_C99_FORMAT = YesPlease
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
+	SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat
+	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o
 	EXTLIBS += -lws2_32
diff --git a/compat/mingw.c b/compat/mingw.c
index 6733727..7c8fd0e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -847,40 +847,6 @@ int mingw_rename(const char *pold, const char *pnew)
 	return -1;
 }
 
-#undef vsnprintf
-/* Note that the size parameter specifies the available space, i.e.
- * includes the trailing NUL byte; but Windows's vsnprintf expects the
- * number of characters to write without the trailing NUL.
- */
-
-/* This is out of line because it uses alloca() behind the scenes,
- * which must not be called in a loop (alloca() reclaims the allocations
- * only at function exit).
- */
-static int try_vsnprintf(size_t size, const char *fmt, va_list args)
-{
-	char buf[size];	/* gcc-ism */
-	return vsnprintf(buf, size-1, fmt, args);
-}
-
-int mingw_vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
-{
-	int len;
-	if (size > 0) {
-		len = vsnprintf(buf, size-1, fmt, args);
-		if (len >= 0)
-			return len;
-	}
-	/* ouch, buffer too small; need to compute the size */
-	if (size < 250)
-		size = 250;
-	do {
-		size *= 4;
-		len = try_vsnprintf(size, fmt, args);
-	} while (len < 0);
-	return len;
-}
-
 struct passwd *getpwuid(int uid)
 {
 	static char user_name[100];
diff --git a/compat/mingw.h b/compat/mingw.h
index d92c631..c7db345 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -174,9 +174,6 @@ int mingw_fstat(int fd, struct mingw_stat *buf);
 static inline int mingw_stat(const char *file_name, struct mingw_stat *buf)
 { return mingw_lstat(file_name, buf); }
 
-int mingw_vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
-#define vsnprintf mingw_vsnprintf
-
 pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env);
 void mingw_execvp(const char *cmd, char *const *argv);
 #define execvp mingw_execvp
@@ -192,12 +189,8 @@ sig_handler_t mingw_signal(int sig, sig_handler_t 
handler);
  * git specific compatibility
  */
 
-static inline int has_dos_drive_prefix(const char *path)
-{
-	return isalpha(*path) && path[1] == ':';
-}
-#define has_dos_drive_prefix has_dos_drive_prefix
-
+#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
+#define is_dir_sep(c) ((c) == '/' || (c) == '\\')
 #define PATH_SEP ';'
 #define PRIuMAX "I64u"
 
diff --git a/compat/snprintf.c b/compat/snprintf.c
index dbfc2d6..480b66f 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -1,12 +1,21 @@
 #include "../git-compat-util.h"
 
+/*
+ * The size parameter specifies the available space, i.e. includes
+ * the trailing NUL byte; but Windows's vsnprintf expects the
+ * number of characters to write without the trailing NUL.
+ */
+#ifndef SNPRINTF_SIZE_CORR
+#define SNPRINTF_SIZE_CORR 0
+#endif
+
 #undef vsnprintf
 int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
 {
 	char *s;
 	int ret;
 
-	ret = vsnprintf(str, maxsize, format, ap);
+	ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
 	if (ret != -1)
 		return ret;
 
@@ -20,7 +29,7 @@ int git_vsnprintf(char *str, size_t maxsize, const char 
*format, va_list ap)
 		if (! str)
 			break;
 		s = str;
-		ret = vsnprintf(str, maxsize, format, ap);
+		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
 	}
 	free(s);
 	return ret;
diff --git a/git-compat-util.h b/git-compat-util.h
index 08f764e..2889146 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -117,6 +117,10 @@
 #define has_dos_drive_prefix(path) 0
 #endif
 
+#ifndef is_dir_sep
+#define is_dir_sep(c) ((c) == '/')
+#endif
+
 #ifdef __GNUC__
 #define NORETURN __attribute__((__noreturn__))
 #else
diff --git a/run-command.c b/run-command.c
index aba2bf2..2ce8c2b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -132,6 +132,14 @@ int start_command(struct child_process *cmd)
 		dup2(cmd->in, 0);
 	}
 
+	if (cmd->no_stderr) {
+		s2 = dup(2);
+		dup_devnull(2);
+	} else if (need_err) {
+		s2 = dup(2);
+		dup2(fderr[1], 2);
+	}
+
 	if (cmd->no_stdout) {
 		s1 = dup(1);
 		dup_devnull(1);
@@ -146,14 +154,6 @@ int start_command(struct child_process *cmd)
 		dup2(cmd->out, 1);
 	}
 
-	if (cmd->no_stderr) {
-		s2 = dup(2);
-		dup_devnull(2);
-	} else if (need_err) {
-		s2 = dup(2);
-		dup2(fderr[1], 2);
-	}
-
 	if (cmd->dir)
 		die("chdir in start_command() not implemented");
 	if (cmd->env) {
diff --git a/setup.c b/setup.c
index d1a862e..eea1038 100644
--- a/setup.c
+++ b/setup.c
@@ -4,12 +4,6 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
-#ifdef __MINGW32__
-static inline int is_dir_sep(char c) { return c == '/' || c == '\\'; }
-#else
-static inline int is_dir_sep(char c) { return c == '/'; }
-#endif
-
 static int sanitary_path_copy(char *dst, const char *src)
 {
 	char *dst0;
