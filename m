From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/8] Guard memory overwriting in resolve_ref_unsafe's static buffer
Date: Thu, 17 Nov 2011 16:32:14 +0700
Message-ID: <1321522335-24193-8-git-send-email-pclouds@gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 10:29:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQyHz-0002wU-Ra
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 10:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab1KQJ3j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 04:29:39 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:65212 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab1KQJ3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 04:29:37 -0500
Received: by yenq3 with SMTP id q3so780085yen.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 01:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WUqYC8FlOmFUX9Zg+o6qJK4gyyW+XzMXs6782Qnd1L4=;
        b=uE/b2ZwGAN7ssTb0MlUFFF2cL9ukuNa3BZ8oD6wrsRdxvZ4dlv4z6FOvYQsdjJ5BA8
         boWqENRnWMCWcxCJgMPmTVRbvViG9V+utEh6IR6Ml/FElgFrgNvyT8wSyiE3I5J5veeC
         HD9VCLBvZBgYkcQciWCvJw1jvTMwAhNKTyFOA=
Received: by 10.42.147.65 with SMTP id m1mr40296001icv.27.1321522176642;
        Thu, 17 Nov 2011 01:29:36 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id eh34sm55732721ibb.5.2011.11.17.01.29.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 01:29:35 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 17 Nov 2011 16:33:13 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185587>

There is a potential problem with resolve_ref_unsafe() and some other
functions in git. The return value returned by resolve_ref_unsafe() may
be changed when the function is called again. Callers must make sure th=
e
next call won't happen as long as the value is still being used.

It's usually hard to track down this kind of problem.  Michael Haggerty
has an idea [1] that, instead of passing the same static buffer to
caller every time the function is called, we free the old buffer and
allocate the new one. This way access to the old (now invalid) buffer
may be caught.

This patch applies the same principle for resolve_ref_unsafe() with a
few modifications:

 - This behavior is enabled when GIT_DEBUG_MEMCHECK is set. The ability
   is always available. We may be able to ask users to rerun with this
   flag on in suspicious cases.

 - Rely on mmap/mprotect to catch illegal access. We need valgrind or
   some other memory tracking tool to reliably catch this in Michael's
   approach.

 - Because mprotect is used instead of munmap, we definitely leak
   memory. Hopefully callers will not put resolve_ref_unsafe() in a
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
 GIT_DEBUG_MEMCHECK should probably be ignored in Windows.

 Makefile          |    3 +++
 cache.h           |    3 ++-
 git-compat-util.h |    9 +++++++++
 refs.c            |   14 ++++++++++++--
 wrapper.c         |   21 +++++++++++++++++++++
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index ee34eab..d671c64 100644
--- a/Makefile
+++ b/Makefile
@@ -2220,6 +2220,9 @@ export NO_SVN_TESTS
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
index 6b8ac8b..feb44a5 100644
--- a/cache.h
+++ b/cache.h
@@ -866,7 +866,8 @@ extern int read_ref(const char *filename, unsigned =
char *sha1);
  *
  * errno is sometimes set on errors, but not always.
  */
-extern const char *resolve_ref_unsafe(const char *ref, unsigned char *=
sha1, int reading, int *flag);
+#define resolve_ref_unsafe(ref, sha1, reading, flag) resolve_ref_unsaf=
e_real(ref, sha1, reading, flag, __FUNCTION__, __LINE__)
+extern const char *resolve_ref_unsafe_real(const char *ref, unsigned c=
har *sha1, int reading, int *flag, const char *file, int line);
 extern char *resolve_ref(const char *ref, unsigned char *sha1, int rea=
ding, int *flag);
=20
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, cha=
r **ref);
diff --git a/git-compat-util.h b/git-compat-util.h
index 5ef8ff7..d00c9c6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -432,6 +432,15 @@ extern char *xstrndup(const char *str, size_t len)=
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
index 28496ed..62d8a37 100644
--- a/refs.c
+++ b/refs.c
@@ -497,12 +497,22 @@ static int get_packed_ref(const char *ref, unsign=
ed char *sha1)
 	return -1;
 }
=20
-const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1, i=
nt reading, int *flag)
+const char *resolve_ref_unsafe_real(const char *ref, unsigned char *sh=
a1,
+				    int reading, int *flag,
+				    const char *file, int line)
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
diff --git a/wrapper.c b/wrapper.c
index 85f09df..3120d97 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -60,6 +60,27 @@ void *xmallocz(size_t size)
 	return ret;
 }
=20
+void *xmalloc_mmap(size_t size, const char *file, int line)
+{
+	int *ret =3D mmap(NULL, size + sizeof(int*) * 3,
+			PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE,
+			-1, 0);
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
1.7.4.74.g639db
