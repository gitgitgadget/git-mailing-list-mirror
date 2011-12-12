From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] Guard memory overwriting in resolve_ref's static buffer
Date: Mon, 12 Dec 2011 18:20:31 +0700
Message-ID: <1323688832-32016-3-git-send-email-pclouds@gmail.com>
References: <1323688832-32016-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 12:22:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra3xc-0000OJ-He
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 12:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632Ab1LLLWP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 06:22:15 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52734 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1LLLWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 06:22:14 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so3065808iae.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 03:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5icsHWZXAQOc8OJQ3yzYfdFtALJX2b9Fvsv4wyOkOvA=;
        b=TcHlMUIHEcZl603QQof6+eGOpv/vLULjPPWTdUCo+nUOEjNHh/SAbEIPqQ4aHhxUcX
         1RoiHn6w2C/Dl+6br/g7aQGzXnVP71VW55u4IaFA9tN1izDu9H0Hc+MSEB0RW7EJrCMa
         bA/aXzs7HIr2uAX/5NSfqHo3uEE3y2ckGDWk8=
Received: by 10.50.202.65 with SMTP id kg1mr14591789igc.1.1323688932396;
        Mon, 12 Dec 2011 03:22:12 -0800 (PST)
Received: from tre ([115.74.36.175])
        by mx.google.com with ESMTPS id wo4sm40130911igc.5.2011.12.12.03.22.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 03:22:11 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 12 Dec 2011 18:20:48 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1323688832-32016-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186907>

There is a potential problem with resolve_ref() and some other
functions in git. The return value returned by resolve_ref() may
be changed when the function is called again. Callers must make sure th=
e
next call won't happen as long as the value is still being used.

It's usually hard to track down this kind of problem.  Michael Haggerty
has an idea [1] that, instead of passing the same static buffer to
caller every time the function is called, we free the old buffer and
allocate the new one. This way access to the old (now invalid) buffer
may be caught.

This patch applies the same principle for resolve_ref() with a
few modifications:

 - This behavior is enabled when GIT_DEBUG_MEMCHECK is set. The ability
   is always available. We may be able to ask users to rerun with this
   flag on in suspicious cases.

 - Rely on mmap/mprotect to catch illegal access. We need valgrind or
   some other memory tracking tool to reliably catch this in Michael's
   approach.

 - Because mprotect is used instead of munmap, we definitely leak
   memory. Hopefully callers will not put resolve_ref() in a
   loop that runs 1 million times.

 - Save caller location in the allocated buffer so we know who made thi=
s
   call in the core dump.

Also introduce a new target, "make memcheck", that runs tests with this
flag on.

[1] http://comments.gmane.org/gmane.comp.version-control.git/182209

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Changes include:

  - __FUNCTION__ to __FILE__ for compiler compatibility
  - x{malloc,free}_mmap() now put call site information in a struct,
    it's clearer this way and hopefully will avoid platform issues
  - update t0071 to follow '&&' convention
  - add notes where to get caller site info in git-compat-util.h

 .gitignore          |    1 +
 Makefile            |    4 ++++
 cache.h             |    3 ++-
 git-compat-util.h   |   20 ++++++++++++++++++++
 refs.c              |   13 +++++++++++--
 t/t0071-memcheck.sh |   11 +++++++++++
 test-resolve-ref.c  |   18 ++++++++++++++++++
 wrapper.c           |   27 +++++++++++++++++++++++++++
 8 files changed, 94 insertions(+), 3 deletions(-)
 create mode 100755 t/t0071-memcheck.sh
 create mode 100644 test-resolve-ref.c

diff --git a/.gitignore b/.gitignore
index 8572c8c..470e452 100644
--- a/.gitignore
+++ b/.gitignore
@@ -179,6 +179,7 @@
 /test-obj-pool
 /test-parse-options
 /test-path-utils
+/test-resolve-ref
 /test-run-command
 /test-sha1
 /test-sigchain
diff --git a/Makefile b/Makefile
index ed82320..d71cf04 100644
--- a/Makefile
+++ b/Makefile
@@ -444,6 +444,7 @@ TEST_PROGRAMS_NEED_X +=3D test-obj-pool
 TEST_PROGRAMS_NEED_X +=3D test-parse-options
 TEST_PROGRAMS_NEED_X +=3D test-path-utils
 TEST_PROGRAMS_NEED_X +=3D test-run-command
+TEST_PROGRAMS_NEED_X +=3D test-resolve-ref
 TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-string-pool
@@ -2241,6 +2242,9 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
=20
+memcheck: all
+	GIT_DEBUG_MEMCHECK=3D1 $(MAKE) -C t/ all
+
 test-ctype$X: ctype.o
=20
 test-date$X: date.o ctype.o
diff --git a/cache.h b/cache.h
index 4887a3e..ba5e911 100644
--- a/cache.h
+++ b/cache.h
@@ -865,7 +865,8 @@ extern int read_ref(const char *filename, unsigned =
char *sha1);
  *
  * errno is sometimes set on errors, but not always.
  */
-extern const char *resolve_ref(const char *ref, unsigned char *sha1, i=
nt reading, int *flag);
+#define resolve_ref(ref, sha1, reading, flag) resolve_ref_real(ref, sh=
a1, reading, flag, __FILE__, __LINE__)
+extern const char *resolve_ref_real(const char *ref, unsigned char *sh=
a1, int reading, int *flag, const char *file, int line);
 extern char *resolve_refdup(const char *ref, unsigned char *sha1, int =
reading, int *flag);
=20
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, cha=
r **ref);
diff --git a/git-compat-util.h b/git-compat-util.h
index 77062ed..0cb6e34 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -433,6 +433,26 @@ extern char *xstrndup(const char *str, size_t len)=
;
 extern void *xrealloc(void *ptr, size_t size);
 extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, in=
t fd, off_t offset);
+
+/*
+ * These functions are used to allocate new memory blocks and catch
+ * invalid use after they are released (though the memory is never
+ * returned to system, so do not allocate too much this way).
+ *
+ * mprotect() is used to remove all access to memory when xfree_mmap()
+ * is called. Invalid access will cause sigsegv. The memory block is
+ * preceded by struct alloc_header, describing where it is
+ * allocated. This information can be found in the core dump.
+ */
+struct alloc_header {
+	const char *file;
+	int line;
+	int size;
+	char buf[FLEX_ARRAY];
+};
+extern void *xmalloc_mmap(size_t, const char *file, int line);
+extern void xfree_mmap(void *);
+
 extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern int xdup(int fd);
diff --git a/refs.c b/refs.c
index 8ffb32f..cf8dfcc 100644
--- a/refs.c
+++ b/refs.c
@@ -497,12 +497,21 @@ static int get_packed_ref(const char *ref, unsign=
ed char *sha1)
 	return -1;
 }
=20
-const char *resolve_ref(const char *ref, unsigned char *sha1, int read=
ing, int *flag)
+const char *resolve_ref_real(const char *ref, unsigned char *sha1,
+			     int reading, int *flag, const char *file, int line)
 {
 	int depth =3D MAXDEPTH;
 	ssize_t len;
 	char buffer[256];
-	static char ref_buffer[256];
+	static char real_ref_buffer[256];
+	static char *ref_buffer;
+
+	if (!ref_buffer && !getenv("GIT_DEBUG_MEMCHECK"))
+		ref_buffer =3D real_ref_buffer;
+	if (ref_buffer !=3D real_ref_buffer) {
+		xfree_mmap(ref_buffer);
+		ref_buffer =3D xmalloc_mmap(256, file, line);
+	}
=20
 	if (flag)
 		*flag =3D 0;
diff --git a/t/t0071-memcheck.sh b/t/t0071-memcheck.sh
new file mode 100755
index 0000000..8904369
--- /dev/null
+++ b/t/t0071-memcheck.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+test_description=3D'test that GIT_DEBUG_MEMCHECK works correctly'
+. ./test-lib.sh
+
+test_expect_success 'test-resolve-ref must crash' '
+	test-resolve-ref &&
+	GIT_DEBUG_MEMCHECK=3D1 test_expect_code 139 test-resolve-ref
+'
+
+test_done
diff --git a/test-resolve-ref.c b/test-resolve-ref.c
new file mode 100644
index 0000000..b772038
--- /dev/null
+++ b/test-resolve-ref.c
@@ -0,0 +1,18 @@
+#include "cache.h"
+
+int main(int argc, char **argv)
+{
+	unsigned char sha1[20];
+	const char *ref1, *ref2;
+	setup_git_directory();
+
+	/*
+	 * This is an invalid use of resolve_ref_unsafe(). This
+	 * function returns a shared buffer, so by the time the second
+	 * call is made, ref1 must _not_ be accessed any more.
+	 */
+	ref1 =3D resolve_ref("HEAD", sha1, 0, NULL);
+	ref2 =3D resolve_ref("HEAD", sha1, 0, NULL);
+	printf("ref1 =3D %s\nref2 =3D %s\n", ref1, ref2);
+	return 0;
+}
diff --git a/wrapper.c b/wrapper.c
index 85f09df..02b6c81 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -60,6 +60,33 @@ void *xmallocz(size_t size)
 	return ret;
 }
=20
+void *xmalloc_mmap(size_t size, const char *file, int line)
+{
+	struct alloc_header *block;
+	size +=3D offsetof(struct alloc_header,buf);
+	block =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
+		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (block =3D=3D (struct alloc_header*)-1)
+		die_errno("unable to mmap %lu bytes anonymously",
+			  (unsigned long)size);
+
+	block->file =3D file;
+	block->line =3D line;
+	block->size =3D size;
+	return block->buf;
+}
+
+void xfree_mmap(void *p)
+{
+	struct alloc_header *block;
+
+	if (!p)
+		return;
+	block =3D (struct alloc_header *)((char*)p - offsetof(struct alloc_he=
ader,buf));
+	if (mprotect(block, block->size, PROT_NONE) =3D=3D -1)
+		die_errno("unable to remove memory access");
+}
+
 /*
  * xmemdupz() allocates (len + 1) bytes of memory, duplicates "len" by=
tes of
  * "data" to the allocated memory, zero terminates the allocated memor=
y,
--=20
1.7.8.36.g69ee2
