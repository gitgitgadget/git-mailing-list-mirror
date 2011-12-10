From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] Guard memory overwriting in resolve_ref's static buffer
Date: Sat, 10 Dec 2011 19:53:49 +0700
Message-ID: <1323521631-24320-2-git-send-email-pclouds@gmail.com>
References: <1323521631-24320-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Tony Wang <wwwjfy@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 13:56:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZMTF-0003Fw-Jo
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 13:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178Ab1LJM4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 07:56:00 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59271 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1LJMz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 07:55:59 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so196423iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 04:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+z3ilGABQysoJobHxVeR39KF5PyVyJgRSHrHRdZRmR0=;
        b=XmkiBC+DlCzl3P4LSckgzwR/JZ4w8p3Hn+z0cgNoW+uvjz+ANpjP35MN3IpA2ba+Qk
         me54lFOHAdD9aVQMIneAR5zaeybh1ae87r0pBwqYYEGs6pRlRuJuIZ/pJhOFEJcsWBJv
         XggDagJQMIYtEyKqo94lgmZBmJkm3cQuYx9/M=
Received: by 10.50.77.137 with SMTP id s9mr7258291igw.66.1323521759479;
        Sat, 10 Dec 2011 04:55:59 -0800 (PST)
Received: from tre ([115.74.36.175])
        by mx.google.com with ESMTPS id k39sm23338725ibb.2.2011.12.10.04.55.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 04:55:58 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 10 Dec 2011 19:54:02 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1323521631-24320-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186770>

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
 .gitignore          |    1 +
 Makefile            |    4 ++++
 cache.h             |    3 ++-
 git-compat-util.h   |    9 +++++++++
 refs.c              |   13 +++++++++++--
 t/t0071-memcheck.sh |   12 ++++++++++++
 test-resolve-ref.c  |   12 ++++++++++++
 wrapper.c           |   22 ++++++++++++++++++++++
 8 files changed, 73 insertions(+), 3 deletions(-)
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
index 4887a3e..a63d890 100644
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
a1, reading, flag, __FUNCTION__, __LINE__)
+extern const char *resolve_ref_real(const char *ref, unsigned char *sh=
a1, int reading, int *flag, const char *file, int line);
 extern char *resolve_refdup(const char *ref, unsigned char *sha1, int =
reading, int *flag);
=20
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, cha=
r **ref);
diff --git a/git-compat-util.h b/git-compat-util.h
index 77062ed..9249fc2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -433,6 +433,15 @@ extern char *xstrndup(const char *str, size_t len)=
;
 extern void *xrealloc(void *ptr, size_t size);
 extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, in=
t fd, off_t offset);
+
+/*
+ * These functions are used to allocate new memory. When the memory
+ * area is no longer used, ban all access to it so any illegal access
+ * can be caught. xfree_mmap() does not really free memory.
+ */
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
index 0000000..b594732
--- /dev/null
+++ b/t/t0071-memcheck.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+test_description=3D'test that GIT_DEBUG_MEMCHECK works correctly'
+. ./test-lib.sh
+
+test_expect_success 'test-resolve-ref must crash' '
+	GIT_DEBUG_MEMCHECK=3D1 test-resolve-ref
+	exit_code=3D$? &&
+	test $exit_code -eq 139
+'
+
+test_done
diff --git a/test-resolve-ref.c b/test-resolve-ref.c
new file mode 100644
index 0000000..934d764
--- /dev/null
+++ b/test-resolve-ref.c
@@ -0,0 +1,12 @@
+#include "cache.h"
+
+int main(int argc, char **argv)
+{
+	unsigned char sha1[20];
+	const char *ref1, *ref2;
+	setup_git_directory();
+	ref1 =3D resolve_ref("HEAD", sha1, 0, NULL);
+	ref2 =3D resolve_ref("HEAD", sha1, 0, NULL);
+	printf("ref1 =3D %s\nref2 =3D %s\n", ref1, ref2);
+	return 0;
+}
diff --git a/wrapper.c b/wrapper.c
index 85f09df..407443a 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -60,6 +60,28 @@ void *xmallocz(size_t size)
 	return ret;
 }
=20
+void *xmalloc_mmap(size_t size, const char *file, int line)
+{
+	int *ret;
+	size +=3D sizeof(int*) * 3;
+	ret =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
+		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (ret =3D=3D (int*)-1)
+		die_errno("unable to mmap %lu bytes anonymously",
+			  (unsigned long)size);
+
+	ret[0] =3D (int)file;
+	ret[1] =3D line;
+	ret[2] =3D size;
+	return ret + 3;
+}
+
+void xfree_mmap(void *p)
+{
+	if (p && mprotect(((int*)p) - 3, ((int*)p)[-1], PROT_NONE) =3D=3D -1)
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
