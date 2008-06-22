From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Shrink the git binary a bit by avoiding unnecessary inline
 functions
Date: Sun, 22 Jun 2008 12:19:25 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806221159140.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 22 21:26:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAVCZ-00037o-Ii
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 21:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbYFVTZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 15:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755985AbYFVTZO
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 15:25:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55369 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754041AbYFVTZL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jun 2008 15:25:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5MJJQfI030155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jun 2008 12:19:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5MJJPlr024168;
	Sun, 22 Jun 2008 12:19:25 -0700
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.346 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85797>


So I was looking at the disgusting size of the git binary, and even with 
the debugging removed, and using -Os instead of -O2, the size of the text 
section was pretty high. In this day and age I guess almost a megabyte of 
text isn't really all that surprising, but it still doesn't exactly make 
me think "lean and mean".

With -Os, a surprising amount of text space is wasted on inline functions 
that end up just being replicated multiple times, and where performance 
really isn't a valid reason to inline them. In particular, the trivial 
wrapper functions like "xmalloc()" are used _everywhere_, and making them 
inline just duplicates the text (and the string we use to 'die()' on 
failure) unnecessarily.

So this just moves them into a "wrapper.c" file, getting rid of a tiny bit 
of unnecessary bloat. The following numbers are both with "CFLAGS=-Os":

Before:
	[torvalds@woody git]$ size git
	   text	   data	    bss	    dec	    hex	filename
	 700460	  15160	 292184	1007804	  f60bc	git

After:
	[torvalds@woody git]$ size git
	   text	   data	    bss	    dec	    hex	filename
	 670540	  15160	 292184	 977884	  eebdc	git

so it saves almost 30k of text-space (it actually saves more than that 
with the default -O2, but I don't think that's necessarily a very relevant 
number from a "try to shrink git" standpoint).

It might conceivably have a performance impact, but none of this should be 
_that_ performance critical. The real cost is not generally in the wrapper 
anyway, but in the code it wraps (ie the cost of "xread()" is all in the 
read itself, not in the trivial wrapping of it).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

There are probably other things we should do, but this was the obvious 
low-hanging fruit.

NOTE! When looking at the actual size of the binary on-disk, all the size 
issues are dwarfed by the cost of teh debug information, so don't be 
fooled by doing an "ls -l" unless you strip it first, or remove the "-g". 

If you just do a "ls -l git" with the default CFLAGS options, you'll think 
that the git binary is 3+MB in size:

	$ ls -lh git
	-rwxrwxr-x 88 torvalds torvalds 3.4M 2008-06-22 12:14 git

but that's mostly debug and symbol info:

	$ strip git
	$ ls -lh git
	-rwxrwxr-x 88 torvalds torvalds 811K 2008-06-22 12:15 git

so it's not wuite *that* scary. With -Os (this patch applied in all 
cases), it shrinks to

	$ ls -lh git
	-rwxrwxr-x 88 torvalds torvalds 2.9M 2008-06-22 12:17 git

	$ strip git
	$ ls -lh git
	-rwxrwxr-x 88 torvalds torvalds 680K 2008-06-22 12:18 git

respectively.

 Makefile          |    1 +
 git-compat-util.h |  167 ++++-------------------------------------------------
 wrapper.c         |  160 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+), 155 deletions(-)

diff --git a/Makefile b/Makefile
index 6a31c9f..408ec33 100644
--- a/Makefile
+++ b/Makefile
@@ -467,6 +467,7 @@ LIB_OBJS += unpack-trees.o
 LIB_OBJS += usage.o
 LIB_OBJS += utf8.o
 LIB_OBJS += walker.o
+LIB_OBJS += wrapper.o
 LIB_OBJS += write_or_die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
diff --git a/git-compat-util.h b/git-compat-util.h
index c04e8ba..6f94a81 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -240,161 +240,18 @@ static inline char *gitstrchrnul(const char *s, int c)
 
 extern void release_pack_memory(size_t, int);
 
-static inline char* xstrdup(const char *str)
-{
-	char *ret = strdup(str);
-	if (!ret) {
-		release_pack_memory(strlen(str) + 1, -1);
-		ret = strdup(str);
-		if (!ret)
-			die("Out of memory, strdup failed");
-	}
-	return ret;
-}
-
-static inline void *xmalloc(size_t size)
-{
-	void *ret = malloc(size);
-	if (!ret && !size)
-		ret = malloc(1);
-	if (!ret) {
-		release_pack_memory(size, -1);
-		ret = malloc(size);
-		if (!ret && !size)
-			ret = malloc(1);
-		if (!ret)
-			die("Out of memory, malloc failed");
-	}
-#ifdef XMALLOC_POISON
-	memset(ret, 0xA5, size);
-#endif
-	return ret;
-}
-
-/*
- * xmemdupz() allocates (len + 1) bytes of memory, duplicates "len" bytes of
- * "data" to the allocated memory, zero terminates the allocated memory,
- * and returns a pointer to the allocated memory. If the allocation fails,
- * the program dies.
- */
-static inline void *xmemdupz(const void *data, size_t len)
-{
-	char *p = xmalloc(len + 1);
-	memcpy(p, data, len);
-	p[len] = '\0';
-	return p;
-}
-
-static inline char *xstrndup(const char *str, size_t len)
-{
-	char *p = memchr(str, '\0', len);
-	return xmemdupz(str, p ? p - str : len);
-}
-
-static inline void *xrealloc(void *ptr, size_t size)
-{
-	void *ret = realloc(ptr, size);
-	if (!ret && !size)
-		ret = realloc(ptr, 1);
-	if (!ret) {
-		release_pack_memory(size, -1);
-		ret = realloc(ptr, size);
-		if (!ret && !size)
-			ret = realloc(ptr, 1);
-		if (!ret)
-			die("Out of memory, realloc failed");
-	}
-	return ret;
-}
-
-static inline void *xcalloc(size_t nmemb, size_t size)
-{
-	void *ret = calloc(nmemb, size);
-	if (!ret && (!nmemb || !size))
-		ret = calloc(1, 1);
-	if (!ret) {
-		release_pack_memory(nmemb * size, -1);
-		ret = calloc(nmemb, size);
-		if (!ret && (!nmemb || !size))
-			ret = calloc(1, 1);
-		if (!ret)
-			die("Out of memory, calloc failed");
-	}
-	return ret;
-}
-
-static inline void *xmmap(void *start, size_t length,
-	int prot, int flags, int fd, off_t offset)
-{
-	void *ret = mmap(start, length, prot, flags, fd, offset);
-	if (ret == MAP_FAILED) {
-		if (!length)
-			return NULL;
-		release_pack_memory(length, fd);
-		ret = mmap(start, length, prot, flags, fd, offset);
-		if (ret == MAP_FAILED)
-			die("Out of memory? mmap failed: %s", strerror(errno));
-	}
-	return ret;
-}
-
-/*
- * xread() is the same a read(), but it automatically restarts read()
- * operations with a recoverable error (EAGAIN and EINTR). xread()
- * DOES NOT GUARANTEE that "len" bytes is read even if the data is available.
- */
-static inline ssize_t xread(int fd, void *buf, size_t len)
-{
-	ssize_t nr;
-	while (1) {
-		nr = read(fd, buf, len);
-		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
-			continue;
-		return nr;
-	}
-}
-
-/*
- * xwrite() is the same a write(), but it automatically restarts write()
- * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
- * GUARANTEE that "len" bytes is written even if the operation is successful.
- */
-static inline ssize_t xwrite(int fd, const void *buf, size_t len)
-{
-	ssize_t nr;
-	while (1) {
-		nr = write(fd, buf, len);
-		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
-			continue;
-		return nr;
-	}
-}
-
-static inline int xdup(int fd)
-{
-	int ret = dup(fd);
-	if (ret < 0)
-		die("dup failed: %s", strerror(errno));
-	return ret;
-}
-
-static inline FILE *xfdopen(int fd, const char *mode)
-{
-	FILE *stream = fdopen(fd, mode);
-	if (stream == NULL)
-		die("Out of memory? fdopen failed: %s", strerror(errno));
-	return stream;
-}
-
-static inline int xmkstemp(char *template)
-{
-	int fd;
-
-	fd = mkstemp(template);
-	if (fd < 0)
-		die("Unable to create temporary file: %s", strerror(errno));
-	return fd;
-}
+extern char *xstrdup(const char *str);
+extern void *xmalloc(size_t size);
+extern void *xmemdupz(const void *data, size_t len);
+extern char *xstrndup(const char *str, size_t len);
+extern void *xrealloc(void *ptr, size_t size);
+extern void *xcalloc(size_t nmemb, size_t size);
+extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
+extern ssize_t xread(int fd, void *buf, size_t len);
+extern ssize_t xwrite(int fd, const void *buf, size_t len);
+extern int xdup(int fd);
+extern FILE *xfdopen(int fd, const char *mode);
+extern int xmkstemp(char *template);
 
 static inline size_t xsize_t(off_t len)
 {
diff --git a/wrapper.c b/wrapper.c
new file mode 100644
index 0000000..4e04f76
--- /dev/null
+++ b/wrapper.c
@@ -0,0 +1,160 @@
+/*
+ * Various trivial helper wrappers around standard functions
+ */
+#include "cache.h"
+
+char *xstrdup(const char *str)
+{
+	char *ret = strdup(str);
+	if (!ret) {
+		release_pack_memory(strlen(str) + 1, -1);
+		ret = strdup(str);
+		if (!ret)
+			die("Out of memory, strdup failed");
+	}
+	return ret;
+}
+
+void *xmalloc(size_t size)
+{
+	void *ret = malloc(size);
+	if (!ret && !size)
+		ret = malloc(1);
+	if (!ret) {
+		release_pack_memory(size, -1);
+		ret = malloc(size);
+		if (!ret && !size)
+			ret = malloc(1);
+		if (!ret)
+			die("Out of memory, malloc failed");
+	}
+#ifdef XMALLOC_POISON
+	memset(ret, 0xA5, size);
+#endif
+	return ret;
+}
+
+/*
+ * xmemdupz() allocates (len + 1) bytes of memory, duplicates "len" bytes of
+ * "data" to the allocated memory, zero terminates the allocated memory,
+ * and returns a pointer to the allocated memory. If the allocation fails,
+ * the program dies.
+ */
+void *xmemdupz(const void *data, size_t len)
+{
+	char *p = xmalloc(len + 1);
+	memcpy(p, data, len);
+	p[len] = '\0';
+	return p;
+}
+
+char *xstrndup(const char *str, size_t len)
+{
+	char *p = memchr(str, '\0', len);
+	return xmemdupz(str, p ? p - str : len);
+}
+
+void *xrealloc(void *ptr, size_t size)
+{
+	void *ret = realloc(ptr, size);
+	if (!ret && !size)
+		ret = realloc(ptr, 1);
+	if (!ret) {
+		release_pack_memory(size, -1);
+		ret = realloc(ptr, size);
+		if (!ret && !size)
+			ret = realloc(ptr, 1);
+		if (!ret)
+			die("Out of memory, realloc failed");
+	}
+	return ret;
+}
+
+void *xcalloc(size_t nmemb, size_t size)
+{
+	void *ret = calloc(nmemb, size);
+	if (!ret && (!nmemb || !size))
+		ret = calloc(1, 1);
+	if (!ret) {
+		release_pack_memory(nmemb * size, -1);
+		ret = calloc(nmemb, size);
+		if (!ret && (!nmemb || !size))
+			ret = calloc(1, 1);
+		if (!ret)
+			die("Out of memory, calloc failed");
+	}
+	return ret;
+}
+
+void *xmmap(void *start, size_t length,
+	int prot, int flags, int fd, off_t offset)
+{
+	void *ret = mmap(start, length, prot, flags, fd, offset);
+	if (ret == MAP_FAILED) {
+		if (!length)
+			return NULL;
+		release_pack_memory(length, fd);
+		ret = mmap(start, length, prot, flags, fd, offset);
+		if (ret == MAP_FAILED)
+			die("Out of memory? mmap failed: %s", strerror(errno));
+	}
+	return ret;
+}
+
+/*
+ * xread() is the same a read(), but it automatically restarts read()
+ * operations with a recoverable error (EAGAIN and EINTR). xread()
+ * DOES NOT GUARANTEE that "len" bytes is read even if the data is available.
+ */
+ssize_t xread(int fd, void *buf, size_t len)
+{
+	ssize_t nr;
+	while (1) {
+		nr = read(fd, buf, len);
+		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
+			continue;
+		return nr;
+	}
+}
+
+/*
+ * xwrite() is the same a write(), but it automatically restarts write()
+ * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
+ * GUARANTEE that "len" bytes is written even if the operation is successful.
+ */
+ssize_t xwrite(int fd, const void *buf, size_t len)
+{
+	ssize_t nr;
+	while (1) {
+		nr = write(fd, buf, len);
+		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
+			continue;
+		return nr;
+	}
+}
+
+int xdup(int fd)
+{
+	int ret = dup(fd);
+	if (ret < 0)
+		die("dup failed: %s", strerror(errno));
+	return ret;
+}
+
+FILE *xfdopen(int fd, const char *mode)
+{
+	FILE *stream = fdopen(fd, mode);
+	if (stream == NULL)
+		die("Out of memory? fdopen failed: %s", strerror(errno));
+	return stream;
+}
+
+int xmkstemp(char *template)
+{
+	int fd;
+
+	fd = mkstemp(template);
+	if (fd < 0)
+		die("Unable to create temporary file: %s", strerror(errno));
+	return fd;
+}
