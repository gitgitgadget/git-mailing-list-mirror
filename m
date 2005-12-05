From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Clean up compatibility definitions.
Date: Mon, 05 Dec 2005 12:22:42 -0800
Message-ID: <7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	<81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	<7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 05 21:24:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjMrL-0006rz-8P
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 21:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbVLEUWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 15:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbVLEUWq
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 15:22:46 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:58257 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751432AbVLEUWp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 15:22:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051205202210.KFXH3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Dec 2005 15:22:10 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13224>

This attempts to clean up the way various compatibility
functions are defined and used.

 - A new header file, git-compat-util.h, is introduced.  This
   looks at various NO_XXX and does necessary function name
   replacements, equivalent of -Dstrcasestr=gitstrcasestr in the
   Makefile.

 - Those function name replacements are removed from the Makefile.

 - Common features such as usage(), die(), xmalloc() are moved
   from cache.h to git-compat-util.h; cache.h includes
   git-compat-util.h itself.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  Junio C Hamano <junkio@cox.net> writes:

  > When I took setenv patch for git.c, I was thinking about
  > something similar.  It may be cleaner to split out the pieces so
  > that the functions like usage(), die(), xmalloc() and friends
  > could be linkable in git.c and others that want to link in only
  > the minimum set without including "cache.h" which has more
  > intimate knowledge of other git internals.

  Maybe something like this...

 Makefile            |   16 ++++---
 cache.h             |   96 -------------------------------------------
 compat/mmap.c       |    2 -
 compat/strcasestr.c |    3 -
 git-compat-util.h   |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++
 git.c               |   15 +++----
 mailinfo.c          |    4 --
 usage.c             |    2 -
 8 files changed, 132 insertions(+), 119 deletions(-)
 create mode 100644 git-compat-util.h

2823be66bb4a1f6a6b4240e24dfd402e4146c43c
diff --git a/Makefile b/Makefile
index df3c6eb..1f1088e 100644
--- a/Makefile
+++ b/Makefile
@@ -162,7 +162,7 @@ LIB_FILE=libgit.a
 LIB_H = \
 	blob.h cache.h commit.h count-delta.h csum-file.h delta.h \
 	diff.h epoch.h object.h pack.h pkt-line.h quote.h refs.h \
-	run-command.h strbuf.h tag.h tree.h
+	run-command.h strbuf.h tag.h tree.h git-compat-util.h
 
 DIFF_OBJS = \
 	diff.o diffcore-break.o diffcore-order.o diffcore-pathspec.o \
@@ -174,9 +174,11 @@ LIB_OBJS = \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
 	quote.o read-cache.o refs.o run-command.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
-	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
+	tag.o tree.o config.o environment.o copy.o \
 	$(DIFF_OBJS)
 
+COMPAT_OBJS = usage.o ctype.o
+
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
@@ -320,15 +322,15 @@ ifdef NEEDS_NSL
 	SIMPLE_LIB += -lnsl
 endif
 ifdef NO_STRCASESTR
-	COMPAT_CFLAGS += -Dstrcasestr=gitstrcasestr -DNO_STRCASESTR=1
+	COMPAT_CFLAGS += -DNO_STRCASESTR
 	COMPAT_OBJS += compat/strcasestr.o
 endif
 ifdef NO_SETENV
-	COMPAT_CFLAGS += -Dsetenv=gitsetenv -DNO_SETENV=1
+	COMPAT_CFLAGS += -DNO_SETENV
 	COMPAT_OBJS += compat/setenv.o
 endif
 ifdef NO_MMAP
-	COMPAT_CFLAGS += -Dmmap=gitfakemmap -Dmunmap=gitfakemunmap -DNO_MMAP
+	COMPAT_CFLAGS += -DNO_MMAP
 	COMPAT_OBJS += compat/mmap.o
 endif
 ifdef NO_IPV6
@@ -363,9 +365,9 @@ all: $(ALL_PROGRAMS)
 all:
 	$(MAKE) -C templates
 
-git$(X): git.c $(COMPAT_OBJS) Makefile
+git$X: git.c $(LIB_FILE) Makefile
 	$(CC) -DGIT_EXEC_PATH='"$(bindir)"' -DGIT_VERSION='"$(GIT_VERSION)"' \
-		$(CFLAGS) $(COMPAT_CFLAGS) -o $@ $(filter %.c,$^) $(filter %.o,$^)
+		$(CFLAGS) $(COMPAT_CFLAGS) -o $@ $(filter %.c,$^) $(LIB_FILE)
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	rm -f $@
diff --git a/cache.h b/cache.h
index f9b367f..86fc250 100644
--- a/cache.h
+++ b/cache.h
@@ -1,23 +1,7 @@
 #ifndef CACHE_H
 #define CACHE_H
 
-#include <unistd.h>
-#include <stdio.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <stddef.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <string.h>
-#include <errno.h>
-#include <limits.h>
-#ifndef NO_MMAP
-#include <sys/mman.h>
-#endif
-#include <sys/param.h>
-#include <netinet/in.h>
-#include <sys/types.h>
-#include <dirent.h>
+#include "git-compat-util.h"
 
 #include SHA1_HEADER
 #include <zlib.h>
@@ -36,15 +20,6 @@
 #define DTYPE(de)	DT_UNKNOWN
 #endif
 
-#ifdef __GNUC__
-#define NORETURN __attribute__((__noreturn__))
-#else
-#define NORETURN
-#ifndef __attribute__
-#define __attribute__(x)
-#endif
-#endif
-
 /*
  * Intensive research over the course of many years has shown that
  * port 9418 is totally unused by anything else. Or
@@ -250,11 +225,6 @@ extern const char *resolve_ref(const cha
 extern int create_symref(const char *git_HEAD, const char *refs_heads_master);
 extern int validate_symref(const char *git_HEAD);
 
-/* General helper functions */
-extern void usage(const char *err) NORETURN;
-extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
-extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
-
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
 
@@ -272,30 +242,6 @@ extern int setup_ident(void);
 extern const char *git_author_info(void);
 extern const char *git_committer_info(void);
 
-static inline void *xmalloc(size_t size)
-{
-	void *ret = malloc(size);
-	if (!ret)
-		die("Out of memory, malloc failed");
-	return ret;
-}
-
-static inline void *xrealloc(void *ptr, size_t size)
-{
-	void *ret = realloc(ptr, size);
-	if (!ret)
-		die("Out of memory, realloc failed");
-	return ret;
-}
-
-static inline void *xcalloc(size_t nmemb, size_t size)
-{
-	void *ret = calloc(nmemb, size);
-	if (!ret)
-		die("Out of memory, calloc failed");
-	return ret;
-}
-
 struct checkout {
 	const char *base_dir;
 	int base_dir_len;
@@ -373,20 +319,6 @@ extern void packed_object_info_detail(st
 /* Dumb servers support */
 extern int update_server_info(int);
 
-#ifdef NO_MMAP
-
-#ifndef PROT_READ
-#define PROT_READ 1
-#define PROT_WRITE 2
-#define MAP_PRIVATE 1
-#define MAP_FAILED ((void*)-1)
-#endif
-
-extern void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset);
-extern int gitfakemunmap(void *start, size_t length);
-
-#endif
-
 typedef int (*config_fn_t)(const char *, const char *);
 extern int git_default_config(const char *, const char *);
 extern int git_config_from_file(config_fn_t fn, const char *);
@@ -404,31 +336,5 @@ extern char git_default_name[MAX_GITNAME
 #define MAX_ENCODING_LENGTH 64
 extern char git_commit_encoding[MAX_ENCODING_LENGTH];
 
-/* Sane ctype - no locale, and works with signed chars */
-#undef isspace
-#undef isdigit
-#undef isalpha
-#undef isalnum
-#undef tolower
-#undef toupper
-extern unsigned char sane_ctype[256];
-#define GIT_SPACE 0x01
-#define GIT_DIGIT 0x02
-#define GIT_ALPHA 0x04
-#define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
-#define isspace(x) sane_istest(x,GIT_SPACE)
-#define isdigit(x) sane_istest(x,GIT_DIGIT)
-#define isalpha(x) sane_istest(x,GIT_ALPHA)
-#define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
-#define tolower(x) sane_case((unsigned char)(x), 0x20)
-#define toupper(x) sane_case((unsigned char)(x), 0)
-
-static inline int sane_case(int x, int high)
-{
-	if (sane_istest(x, GIT_ALPHA))
-		x = (x & ~0x20) | high;
-	return x;
-}
-
 extern int copy_fd(int ifd, int ofd);
 #endif /* CACHE_H */
diff --git a/compat/mmap.c b/compat/mmap.c
index a051c47..55cb120 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -2,7 +2,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
-#include "../cache.h"
+#include "../git-compat-util.h"
 
 void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset)
 {
diff --git a/compat/strcasestr.c b/compat/strcasestr.c
index b96414d..26896de 100644
--- a/compat/strcasestr.c
+++ b/compat/strcasestr.c
@@ -1,5 +1,4 @@
-#include <string.h>
-#include <ctype.h>
+#include "../git-compat-util.h"
 
 char *gitstrcasestr(const char *haystack, const char *needle)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
new file mode 100644
index 0000000..4185b12
--- /dev/null
+++ b/git-compat-util.h
@@ -0,0 +1,113 @@
+#ifndef GIT_COMPAT_UTIL_H
+#define GIT_COMPAT_UTIL_H
+
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <errno.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <netinet/in.h>
+#include <sys/types.h>
+#include <dirent.h>
+
+#ifdef __GNUC__
+#define NORETURN __attribute__((__noreturn__))
+#else
+#define NORETURN
+#ifndef __attribute__
+#define __attribute__(x)
+#endif
+#endif
+
+/* General helper functions */
+extern void usage(const char *err) NORETURN;
+extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
+extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
+
+#ifdef NO_MMAP
+
+#ifndef PROT_READ
+#define PROT_READ 1
+#define PROT_WRITE 2
+#define MAP_PRIVATE 1
+#define MAP_FAILED ((void*)-1)
+#endif
+
+#define mmap gitfakemmap
+#define munmap gitfakemunmap
+extern void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset);
+extern int gitfakemunmap(void *start, size_t length);
+
+#else /* NO_MMAP */
+
+#include <sys/mman.h>
+
+#endif /* NO_MMAP */
+
+#ifdef NO_SETENV
+#define setenv gitsetenv
+extern int gitsetenv(const char *, const char *, int);
+#endif
+
+#ifdef NO_STRCASESTR
+#define strcasestr gitstrcasestr
+extern char *gitstrcasestr(const char *haystack, const char *needle);
+#endif
+
+static inline void *xmalloc(size_t size)
+{
+	void *ret = malloc(size);
+	if (!ret)
+		die("Out of memory, malloc failed");
+	return ret;
+}
+
+static inline void *xrealloc(void *ptr, size_t size)
+{
+	void *ret = realloc(ptr, size);
+	if (!ret)
+		die("Out of memory, realloc failed");
+	return ret;
+}
+
+static inline void *xcalloc(size_t nmemb, size_t size)
+{
+	void *ret = calloc(nmemb, size);
+	if (!ret)
+		die("Out of memory, calloc failed");
+	return ret;
+}
+
+/* Sane ctype - no locale, and works with signed chars */
+#undef isspace
+#undef isdigit
+#undef isalpha
+#undef isalnum
+#undef tolower
+#undef toupper
+extern unsigned char sane_ctype[256];
+#define GIT_SPACE 0x01
+#define GIT_DIGIT 0x02
+#define GIT_ALPHA 0x04
+#define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
+#define isspace(x) sane_istest(x,GIT_SPACE)
+#define isdigit(x) sane_istest(x,GIT_DIGIT)
+#define isalpha(x) sane_istest(x,GIT_ALPHA)
+#define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
+#define tolower(x) sane_case((unsigned char)(x), 0x20)
+#define toupper(x) sane_case((unsigned char)(x), 0)
+
+static inline int sane_case(int x, int high)
+{
+	if (sane_istest(x, GIT_ALPHA))
+		x = (x & ~0x20) | high;
+	return x;
+}
+
+#endif
diff --git a/git.c b/git.c
index ee5048a..c26cac6 100644
--- a/git.c
+++ b/git.c
@@ -8,15 +8,12 @@
 #include <errno.h>
 #include <limits.h>
 #include <stdarg.h>
+#include "git-compat-util.h"
 
 #ifndef PATH_MAX
 # define PATH_MAX 4096
 #endif
 
-#ifdef NO_SETENV
-extern int gitsetenv(const char *, const char *, int);
-#endif
-
 static const char git_usage[] =
 	"Usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ ARGS ]";
 
@@ -156,10 +153,10 @@ static void list_commands(const char *ex
 }
 
 #ifdef __GNUC__
-static void usage(const char *exec_path, const char *fmt, ...)
+static void cmd_usage(const char *exec_path, const char *fmt, ...)
 	__attribute__((__format__(__printf__, 2, 3), __noreturn__));
 #endif
-static void usage(const char *exec_path, const char *fmt, ...)
+static void cmd_usage(const char *exec_path, const char *fmt, ...)
 {
 	if (fmt) {
 		va_list ap;
@@ -254,12 +251,12 @@ int main(int argc, char **argv, char **e
 		else if (!strcmp(arg, "help"))
 			show_help = 1;
 		else if (!show_help)
-			usage(NULL, NULL);
+			cmd_usage(NULL, NULL);
 	}
 
 	if (i >= argc || show_help) {
 		if (i >= argc)
-			usage(exec_path, NULL);
+			cmd_usage(exec_path, NULL);
 
 		show_man_page(argv[i]);
 	}
@@ -297,7 +294,7 @@ int main(int argc, char **argv, char **e
 	execve(git_command, &argv[i], envp);
 
 	if (errno == ENOENT)
-		usage(exec_path, "'%s' is not a git-command", argv[i]);
+		cmd_usage(exec_path, "'%s' is not a git-command", argv[i]);
 
 	fprintf(stderr, "Failed to run command '%s': %s\n",
 		git_command, strerror(errno));
diff --git a/mailinfo.c b/mailinfo.c
index 890e348..3b97a89 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -10,10 +10,6 @@
 #include <iconv.h>
 #include "cache.h"
 
-#ifdef NO_STRCASESTR
-extern char *gitstrcasestr(const char *haystack, const char *needle);
-#endif
-
 static FILE *cmitmsg, *patchfile;
 
 static int keep_subject = 0;
diff --git a/usage.c b/usage.c
index dfa87fe..1fa924c 100644
--- a/usage.c
+++ b/usage.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "git-compat-util.h"
 
 static void report(const char *prefix, const char *err, va_list params)
 {
-- 
0.99.9.GIT
