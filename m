From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-pack: work around thread-unsafe pread()
Date: Tue, 25 Mar 2014 20:41:41 +0700
Message-ID: <1395754901-19730-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8AYs0-rmGZz2_KEkT2ibW-sTpm=Q9FxFhNGRYd2b6R+sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Zager <szager@chromium.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 14:41:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSRbA-0004p1-LG
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 14:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbaCYNk4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 09:40:56 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:53552 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaCYNkz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 09:40:55 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so465768pab.10
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=o14n17C8zxUVbHNt29Dn6ZCE88ssvxwUWl5Xh9WQjMM=;
        b=GvLQkw8XehFeugk4ZclzssOWhN5/Mrah21aOU55AEJq4AoUKi4Dx41RZm177Cbno5N
         15Rkk798DZJdBgbTYPbADvhwlU8OQxE1Wwa6W4cTzZAvcUGAy/j40NruK4pp3YegO6EO
         ocIxOcV+weETyGDAitkLXL/s2/1fbaf3Kqd/8HcqJPREa/aRdMDdVy0HE832mvy/hPRY
         rIOD8PdnamR4oerpjgJIIf4YWkHDGpIh05TZ8GPpwAMKFYgvhHKf7YOBEDyleclIEA7H
         /QG2H9CG5FFo6JHigk3P9Wv5AqGrg/aqRH1b8ztX+jAnW5Z5r9wzKGXCdYxWUpA2C54F
         M99g==
X-Received: by 10.66.164.229 with SMTP id yt5mr79753240pab.67.1395754854840;
        Tue, 25 Mar 2014 06:40:54 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id kc9sm44875502pbc.25.2014.03.25.06.40.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 06:40:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 25 Mar 2014 20:41:47 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <CACsJy8AYs0-rmGZz2_KEkT2ibW-sTpm=Q9FxFhNGRYd2b6R+sA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245034>

pread() implementation for Cygwin and MSYS is not thread safe, which
led to multithreading being disabled in c0f8654 (index-pack: Disable
threading on cygwin - 2012-06-26). Work around it by opening one file
handle per thread, so parallel pread() (on different file handle)
can't step on each other. Also remove NO_THREAD_SAFE_PREAD that was
introduced in c0f8654 because it's no longer used anywhere.

This workaround is unconditional, even for platforms with thread-safe
pread() because the overhead is small (a couple file handles more) and
not worth fragmenting the code.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, Mar 21, 2014 at 8:51 AM, Duy Nguyen <pclouds@gmail.com> wrote:
 > On Thu, Mar 20, 2014 at 11:08 PM, Stefan Zager <szager@chromium.org>=
 wrote:
 >> Duy, would you like to re-post your patch without the new pread imp=
lementation?
 >
 > I will but let me try out the sliding window idea first. My quick
 > tests on git.git show me we may only need 21k mmap instead of 177k
 > pread. That hints some potential performance improvement.

 Here it is. But I still think it's worth measuring the simpler patch
 that protects pread() from the caller. I suspect we won't see any
 difference.

 Makefile             |  7 -------
 builtin/index-pack.c | 27 +++++++++++++++++----------
 config.mak.uname     |  1 -
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 3646391..0089fad 100644
--- a/Makefile
+++ b/Makefile
@@ -183,9 +183,6 @@ all::
 # Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
 # This also implies NO_SETITIMER
 #
-# Define NO_THREAD_SAFE_PREAD if your pread() implementation is not
-# thread-safe. (e.g. compat/pread.c or cygwin)
-#
 # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files =
is
 # generally faster on your platform than accessing the working directo=
ry.
 #
@@ -1336,10 +1333,6 @@ endif
 ifdef NO_PREAD
 	COMPAT_CFLAGS +=3D -DNO_PREAD
 	COMPAT_OBJS +=3D compat/pread.o
-	NO_THREAD_SAFE_PREAD =3D YesPlease
-endif
-ifdef NO_THREAD_SAFE_PREAD
-	BASIC_CFLAGS +=3D -DNO_THREAD_SAFE_PREAD
 endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS +=3D -DNO_FAST_WORKING_DIRECTORY
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a6b1c17..676d39d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -40,17 +40,13 @@ struct base_data {
 	int ofs_first, ofs_last;
 };
=20
-#if !defined(NO_PTHREADS) && defined(NO_THREAD_SAFE_PREAD)
-/* pread() emulation is not thread-safe. Disable threading. */
-#define NO_PTHREADS
-#endif
-
 struct thread_local {
 #ifndef NO_PTHREADS
 	pthread_t thread;
 #endif
 	struct base_data *base_cache;
 	size_t base_cache_used;
+	int pack_fd;
 };
=20
 /*
@@ -91,7 +87,8 @@ static off_t consumed_bytes;
 static unsigned deepest_delta;
 static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
-static int input_fd, output_fd, pack_fd;
+static int input_fd, output_fd;
+static const char *curr_pack;
=20
 #ifndef NO_PTHREADS
=20
@@ -134,6 +131,7 @@ static inline void unlock_mutex(pthread_mutex_t *mu=
tex)
  */
 static void init_thread(void)
 {
+	int i;
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
@@ -141,11 +139,18 @@ static void init_thread(void)
 		pthread_mutex_init(&deepest_delta_mutex, NULL);
 	pthread_key_create(&key, NULL);
 	thread_data =3D xcalloc(nr_threads, sizeof(*thread_data));
+	for (i =3D 0; i < nr_threads; i++) {
+		thread_data[i].pack_fd =3D open(curr_pack, O_RDONLY);
+		if (thread_data[i].pack_fd =3D=3D -1)
+			die_errno(_("unable to open %s"), curr_pack);
+	}
+
 	threads_active =3D 1;
 }
=20
 static void cleanup_thread(void)
 {
+	int i;
 	if (!threads_active)
 		return;
 	threads_active =3D 0;
@@ -154,6 +159,8 @@ static void cleanup_thread(void)
 	pthread_mutex_destroy(&work_mutex);
 	if (show_stat)
 		pthread_mutex_destroy(&deepest_delta_mutex);
+	for (i =3D 0; i < nr_threads; i++)
+		close(thread_data[i].pack_fd);
 	pthread_key_delete(key);
 	free(thread_data);
 }
@@ -288,13 +295,13 @@ static const char *open_pack_file(const char *pac=
k_name)
 			output_fd =3D open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
 		if (output_fd < 0)
 			die_errno(_("unable to create '%s'"), pack_name);
-		pack_fd =3D output_fd;
+		nothread_data.pack_fd =3D output_fd;
 	} else {
 		input_fd =3D open(pack_name, O_RDONLY);
 		if (input_fd < 0)
 			die_errno(_("cannot open packfile '%s'"), pack_name);
 		output_fd =3D -1;
-		pack_fd =3D input_fd;
+		nothread_data.pack_fd =3D input_fd;
 	}
 	git_SHA1_Init(&input_ctx);
 	return pack_name;
@@ -542,7 +549,7 @@ static void *unpack_data(struct object_entry *obj,
=20
 	do {
 		ssize_t n =3D (len < 64*1024) ? len : 64*1024;
-		n =3D pread(pack_fd, inbuf, n, from);
+		n =3D pread(get_thread_data()->pack_fd, inbuf, n, from);
 		if (n < 0)
 			die_errno(_("cannot pread pack file"));
 		if (!n)
@@ -1490,7 +1497,7 @@ static void show_pack_info(int stat_only)
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack =3D 0, verify =3D 0, stat_only =3D 0;
-	const char *curr_pack, *curr_index;
+	const char *curr_index;
 	const char *index_name =3D NULL, *pack_name =3D NULL;
 	const char *keep_name =3D NULL, *keep_msg =3D NULL;
 	char *index_name_buf =3D NULL, *keep_name_buf =3D NULL;
diff --git a/config.mak.uname b/config.mak.uname
index 6069a44..c9febe1 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -157,7 +157,6 @@ ifeq ($(uname_O),Cygwin)
 		NO_SYMLINK_HEAD =3D YesPlease
 		NO_IPV6 =3D YesPlease
 		OLD_ICONV =3D UnfortunatelyYes
-		NO_THREAD_SAFE_PREAD =3D YesPlease
 		# There are conflicting reports about this.
 		# On some boxes NO_MMAP is needed, and not so elsewhere.
 		# Try commenting this out if you suspect MMAP is more efficient
--=20
1.9.1.345.ga1a145c
