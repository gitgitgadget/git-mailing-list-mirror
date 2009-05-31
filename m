From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v6 1/3] compat: add a mkstemps() compatibility function
Date: Sat, 30 May 2009 21:37:53 -0700
Message-ID: <1243744675-24160-1-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net,
	David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 31 06:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAcoP-0008Bb-Vy
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 06:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbZEaEiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 00:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbZEaEiA
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 00:38:00 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:57197 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbZEaEh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 00:37:59 -0400
Received: by pzk7 with SMTP id 7so5426611pzk.33
        for <git@vger.kernel.org>; Sat, 30 May 2009 21:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=A+8E+oU3GseD1n2Lf7sb8+BzQq+N26CA3jFJskWazKM=;
        b=ExCKCl6Pov1HlF21OC4kpn92iR35im4IDrW1TJBefKwLUCngCsZ2QnsmhD7NaLWxK1
         tC3PvzaqSbWJPQ6Y+q7ANzfSLgZQPKEenwaq7T4ZshWjzxJ40cK4JZK3LzYIzW30jWKL
         32QlYM+rm7+b6/xlL3IkeuydO+uRzoC/Y3fD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xzVz2u7I3jnFy+rALr3UW4Wht9aCjNuo7Jves2m6XJU5CnkIZrhxnA4a+e977MJeqI
         dakO4906VilNzEYP4fnfF+w0l+6bCEDPjA30RbrNqm2Uo3zLavEF67j1pkEE28q7atSf
         MdfXN9QhiGNsrmOvqm4Og7YtqBf0vfHjseAHc=
Received: by 10.141.29.21 with SMTP id g21mr4191354rvj.198.1243744680594;
        Sat, 30 May 2009 21:38:00 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n9sm4182000wag.67.2009.05.30.21.37.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 May 2009 21:38:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.178.g5b6b2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120377>

mkstemps() is a BSD extension so provide an implementation
for cross-platform use.

Signed-off-by: David Aguilar <davvid@gmail.com>
Tested-by: Johannes Sixt <j6t@kdbg.org> (Windows)
---
 Makefile          |   19 ++++++++++++++++
 compat/mkstemps.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 config.mak.in     |    1 +
 configure.ac      |    7 ++++++
 git-compat-util.h |    9 +++++++
 5 files changed, 99 insertions(+), 0 deletions(-)
 create mode 100644 compat/mkstemps.c

diff --git a/Makefile b/Makefile
index eaae45d..a70b5f0 100644
--- a/Makefile
+++ b/Makefile
@@ -52,6 +52,8 @@ all::
 #
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
 #
+# Define NO_MKSTEMPS if you don't have mkstemps in the C library.
+#
 # Define NO_SYS_SELECT_H if you don't have sys/select.h.
 #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
@@ -636,10 +638,12 @@ EXTLIBS =
 
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
+	NO_MKSTEMPS = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
+	NO_MKSTEMPS = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),UnixWare)
@@ -651,6 +655,7 @@ ifeq ($(uname_S),UnixWare)
 	SHELL_PATH = /usr/local/bin/bash
 	NO_IPV6 = YesPlease
 	NO_HSTRERROR = YesPlease
+	NO_MKSTEMPS = YesPlease
 	BASIC_CFLAGS += -Kthread
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
@@ -674,6 +679,7 @@ ifeq ($(uname_S),SCO_SV)
 	SHELL_PATH = /usr/bin/bash
 	NO_IPV6 = YesPlease
 	NO_HSTRERROR = YesPlease
+	NO_MKSTEMPS = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 	NO_STRCASESTR = YesPlease
@@ -702,6 +708,7 @@ ifeq ($(uname_S),SunOS)
 	NO_MEMMEM = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_MKDTEMP = YesPlease
+	NO_MKSTEMPS = YesPlease
 	OLD_ICONV = UnfortunatelyYes
 	ifeq ($(uname_R),5.8)
 		NO_UNSETENV = YesPlease
@@ -724,6 +731,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_D_INO_IN_DIRENT = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
+	NO_MKSTEMPS = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
@@ -767,11 +775,13 @@ ifeq ($(uname_S),NetBSD)
 	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
 	THREADED_DELTA_SEARCH = YesPlease
 	USE_ST_TIMESPEC = YesPlease
+	NO_MKSTEMPS = YesPlease
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
+	NO_MKSTEMPS = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_NSEC = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
@@ -787,12 +797,14 @@ endif
 ifeq ($(uname_S),GNU)
 	# GNU/Hurd
 	NO_STRLCPY=YesPlease
+	NO_MKSTEMPS = YesPlease
 endif
 ifeq ($(uname_S),IRIX64)
 	NO_IPV6=YesPlease
 	NO_SETENV=YesPlease
 	NO_STRCASESTR=YesPlease
 	NO_MEMMEM = YesPlease
+	NO_MKSTEMPS = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_SOCKADDR_STORAGE=YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
@@ -805,6 +817,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_SETENV=YesPlease
 	NO_STRCASESTR=YesPlease
 	NO_MEMMEM = YesPlease
+	NO_MKSTEMPS = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_UNSETENV = YesPlease
@@ -834,6 +847,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_C99_FORMAT = YesPlease
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
+	NO_MKSTEMPS = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
@@ -853,6 +867,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
+	NO_MKSTEMPS = YesPlease
 endif
 
 -include config.mak.autogen
@@ -1011,6 +1026,10 @@ ifdef NO_MKDTEMP
 	COMPAT_CFLAGS += -DNO_MKDTEMP
 	COMPAT_OBJS += compat/mkdtemp.o
 endif
+ifdef NO_MKSTEMPS
+	COMPAT_CFLAGS += -DNO_MKSTEMPS
+	COMPAT_OBJS += compat/mkstemps.o
+endif
 ifdef NO_UNSETENV
 	COMPAT_CFLAGS += -DNO_UNSETENV
 	COMPAT_OBJS += compat/unsetenv.o
diff --git a/compat/mkstemps.c b/compat/mkstemps.c
new file mode 100644
index 0000000..9ce729b
--- /dev/null
+++ b/compat/mkstemps.c
@@ -0,0 +1,63 @@
+#include "../git-compat-util.h"
+
+/* Adapted from libiberty's mkstemp.c. */
+int gitmkstemps(char *pattern, int suffix_len)
+{
+	static const char letters[] =
+		"abcdefghijklmnopqrstuvwxyz"
+		"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+		"0123456789";
+	static const int num_letters = 62;
+	uint64_t value;
+	struct timeval tv;
+	char *template;
+	size_t len;
+	int fd, count;
+
+	len = strlen(pattern);
+
+	if (len < 6 + suffix_len) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	if (strncmp(&pattern[len - 6 - suffix_len], "XXXXXX", 6)) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/* Replace pattern's XXXXXX characters with randomness.
+	 * Try TMP_MAX different filenames.
+	 */
+	gettimeofday(&tv, NULL);
+	value = ((size_t)(tv.tv_usec << 16)) ^ tv.tv_sec ^ getpid();
+	template = &pattern[len - 6 - suffix_len];
+	for (count = 0; count < TMP_MAX; ++count) {
+		uint64_t v = value;
+		/* Fill in the random bits. */
+		template[0] = letters[v % num_letters]; v/= num_letters;
+		template[1] = letters[v % num_letters]; v/= num_letters;
+		template[2] = letters[v % num_letters]; v/= num_letters;
+		template[3] = letters[v % num_letters]; v/= num_letters;
+		template[4] = letters[v % num_letters]; v/= num_letters;
+		template[5] = letters[v % num_letters]; v/= num_letters;
+
+		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, 0600);
+		if (fd > 0)
+			return fd;
+		/* Fatal error (EPERM, ENOSPC etc).
+		 * It doesn't make sense to loop.
+		 */
+		if (errno != EEXIST)
+			break;
+		/* This is a random value.  It is only necessary that
+		 * the next TMP_MAX values generated by adding 7777 to
+		 * VALUE are different with (module 2^32).
+		 */
+		value += 7777;
+	}
+	/* We return the null string if we can't find a unique file name.  */
+	pattern[0] = '\0';
+	errno = EINVAL;
+	return -1;
+}
diff --git a/config.mak.in b/config.mak.in
index 7cce0c1..b6619af 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -46,6 +46,7 @@ NO_STRTOUMAX=@NO_STRTOUMAX@
 NO_SETENV=@NO_SETENV@
 NO_UNSETENV=@NO_UNSETENV@
 NO_MKDTEMP=@NO_MKDTEMP@
+NO_MKSTEMPS=@NO_MKSTEMPS@
 NO_ICONV=@NO_ICONV@
 OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
diff --git a/configure.ac b/configure.ac
index 4e728bc..953da07 100644
--- a/configure.ac
+++ b/configure.ac
@@ -677,6 +677,13 @@ GIT_CHECK_FUNC(mkdtemp,
 [NO_MKDTEMP=YesPlease])
 AC_SUBST(NO_MKDTEMP)
 #
+# Define NO_MKSTEMPS if you don't have mkstemps in the C library.
+GIT_CHECK_FUNC(mkstemps,
+[NO_MKSTEMPS=],
+[NO_MKSTEMPS=YesPlease])
+AC_SUBST(NO_MKSTEMPS)
+#
+#
 # Define NO_MMAP if you want to avoid mmap.
 #
 # Define NO_ICONV if your libc does not properly support iconv.
diff --git a/git-compat-util.h b/git-compat-util.h
index c7cf2d5..5a2d4e7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -113,6 +113,10 @@
 #define PATH_MAX 4096
 #endif
 
+#ifndef TMP_MAX
+#define TMP_MAX 16384
+#endif
+
 #ifndef PRIuMAX
 #define PRIuMAX "llu"
 #endif
@@ -232,6 +236,11 @@ extern int gitsetenv(const char *, const char *, int);
 extern char *gitmkdtemp(char *);
 #endif
 
+#ifdef NO_MKSTEMPS
+#define mkstemps gitmkstemps
+extern int gitmkstemps(char *, int);
+#endif
+
 #ifdef NO_UNSETENV
 #define unsetenv gitunsetenv
 extern void gitunsetenv(const char *);
-- 
1.6.3.1.178.g5b6b2
