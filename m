From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Thu, 19 Apr 2012 14:58:47 +0200
Message-ID: <CABPQNSZ6VdyoLcVUUJ4z5A2A7KGP8qBZAkzdx8zAtAs2mZN25w@mail.gmail.com>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org> <4F8E6A12.9090708@viscovery.net>
 <4F8F1BC1.3030607@ramsay1.demon.co.uk> <4F8FADCF.5000006@viscovery.net>
 <4F8FB4A0.7090403@viscovery.net> <20120419093608.GA19391@duynguyen-vnpc.dek-tpc.internal>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 14:59:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKqxo-0001n7-Vo
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 14:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453Ab2DSM72 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 08:59:28 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:65231 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab2DSM72 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 08:59:28 -0400
Received: by dake40 with SMTP id e40so11348371dak.11
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=4jdO+jnhUch0s185mzKi51FuA9mNZm2RqHMJMwgWU/Q=;
        b=z6xDhpOGikLoLHhCTeb1iiydOKaxyCrtaBK1sVmv/25Q23WHF33J7Rw2a5jAnN+0yR
         wuOm4JmLehnJzDK0ZT0qEjm1l1ERYoCsHs8dS6JfrnmnVFjUwXg8KyK0QO4QL+GMCv9A
         RVlNqcSjD8WE1sGRoLr3N3tS/RK1YBvT3QghUuzn7Pqj2mQfVoqOhfkTRNvwjEiwLw0F
         2dSmdYvft8IycLW36769Tf+/eVs2xdoQCGrx5koG17muzCGahC/5H1MDbXKLPik77LYe
         P0b+bXCpNc66ud5yzYQDkRTXHnxUg6ErJrWGs5QmEF9nHkFGk//ugrlgGpaWq6j0GCWs
         nD6A==
Received: by 10.68.237.163 with SMTP id vd3mr4790826pbc.33.1334840367378; Thu,
 19 Apr 2012 05:59:27 -0700 (PDT)
Received: by 10.68.236.105 with HTTP; Thu, 19 Apr 2012 05:58:47 -0700 (PDT)
In-Reply-To: <20120419093608.GA19391@duynguyen-vnpc.dek-tpc.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195939>

On Thu, Apr 19, 2012 at 11:36 AM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> On Thu, Apr 19, 2012 at 08:45:52AM +0200, Johannes Sixt wrote:
>> I don't see any mutual exclusion happening in this chain. Perhaps it=
 is
>> not needed, provided that the pread() call in get_data_from_pack is
>> atomic. But our git_pread() from compat/pread.c, which we use on Win=
dows,
>> is not atomic.
>
> OK assume it's Windows' pread thread-safe problem (it does look like
> so given how pread.c implements it), maybe this patch will help:
>
> -- 8< --
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 847dbb3..5d539cd 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -102,6 +102,10 @@ static pthread_mutex_t work_mutex;
> =A0#define work_lock() =A0 =A0 =A0 =A0 =A0 =A0lock_mutex(&work_mutex)
> =A0#define work_unlock() =A0 =A0 =A0 =A0 =A0unlock_mutex(&work_mutex)
>
> +#ifdef WIN32
> +static pthread_mutex_t pread_mutex;
> +#endif
> +
> =A0static pthread_key_t key;
>
> =A0static inline void lock_mutex(pthread_mutex_t *mutex)
> @@ -124,6 +128,9 @@ static void init_thread(void)
> =A0 =A0 =A0 =A0init_recursive_mutex(&read_mutex);
> =A0 =A0 =A0 =A0pthread_mutex_init(&counter_mutex, NULL);
> =A0 =A0 =A0 =A0pthread_mutex_init(&work_mutex, NULL);
> +#ifdef WIN32
> + =A0 =A0 =A0 pthread_mutex_init(&pread_mutex, NULL);
> +#endif
> =A0 =A0 =A0 =A0pthread_key_create(&key, NULL);
> =A0 =A0 =A0 =A0thread_data =3D xcalloc(nr_threads, sizeof(*thread_dat=
a));
> =A0 =A0 =A0 =A0threads_active =3D 1;
> @@ -137,6 +144,9 @@ static void cleanup_thread(void)
> =A0 =A0 =A0 =A0pthread_mutex_destroy(&read_mutex);
> =A0 =A0 =A0 =A0pthread_mutex_destroy(&counter_mutex);
> =A0 =A0 =A0 =A0pthread_mutex_destroy(&work_mutex);
> +#ifdef WIN32
> + =A0 =A0 =A0 pthread_mutex_destroy(&pread_mutex);
> +#endif
> =A0 =A0 =A0 =A0pthread_key_delete(key);
> =A0 =A0 =A0 =A0free(thread_data);
> =A0}
> @@ -456,6 +466,20 @@ static void *unpack_raw_entry(struct object_entr=
y *obj, union delta_base *delta_
> =A0 =A0 =A0 =A0return data;
> =A0}
>
> +#ifdef WIN32
> +/* pread is reimplemented in compat/pread.c and is not thread-safe *=
/
> +static ssize_t pread_threadsafe(int fd, void *buf, size_t count, off=
_t from)
> +{
> + =A0 =A0 =A0 ssize_t n;
> + =A0 =A0 =A0 lock_mutex(&pread_mutex);
> + =A0 =A0 =A0 n =3D pread(fd, buf, count, from);
> + =A0 =A0 =A0 unlock_mutex(&pread_mutex);
> + =A0 =A0 =A0 return n;
> +}
> +#else
> +#define pread_threadsafe(fd,buf,count,from) pread(fd, buf, count, fr=
om)
> +#endif
> +
> =A0static void *get_data_from_pack(struct object_entry *obj)
> =A0{
> =A0 =A0 =A0 =A0off_t from =3D obj[0].idx.offset + obj[0].hdr_size;
> @@ -474,7 +498,7 @@ static void *get_data_from_pack(struct object_ent=
ry *obj)
>
> =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ssize_t n =3D (len < 64*1024) ? len : =
64*1024;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 n =3D pread(pack_fd, inbuf, n, from);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n =3D pread_threadsafe(pack_fd, inbuf, =
n, from);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (n < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die_errno("cannot prea=
d pack file");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!n)
> -- 8< --

This approach has the problem that file-operations apart from pread
might (at least in theory) modify the position. To prevent that, we'd
either need to use the same locking-mechanism as the CRT use, or use
ReadFile with an OVERLAPPED struct, which allows us specify the offset
explicitly. The latter seems better to me, and should look something
like this (note: untested):

diff --git a/Makefile b/Makefile
index 2626216..31a5621 100644
--- a/Makefile
+++ b/Makefile
@@ -1153,7 +1153,6 @@ endif
 ifeq ($(uname_S),Windows)
 	GIT_VERSION :=3D $(GIT_VERSION).MSVC
 	pathsep =3D ;
-	NO_PREAD =3D YesPlease
 	NEEDS_CRYPTO_WITH_SSL =3D YesPlease
 	NO_LIBGEN_H =3D YesPlease
 	NO_SYS_POLL_H =3D YesPlease
@@ -1250,7 +1249,6 @@ ifeq ($(uname_S),Minix)
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep =3D ;
-	NO_PREAD =3D YesPlease
 	NEEDS_CRYPTO_WITH_SSL =3D YesPlease
 	NO_LIBGEN_H =3D YesPlease
 	NO_SYS_POLL_H =3D YesPlease
diff --git a/compat/mingw.c b/compat/mingw.c
index 309fa1d..63783db 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -617,6 +617,28 @@ static inline void time_t_to_filetime(time_t t,
=46ILETIME *ft)
 	ft->dwHighDateTime =3D winTime >> 32;
 }

+ssize_t mingw_pread(int fd, void *buf, size_t size, off_t offset)
+{
+	OVERLAPPED overlapped =3D { 0 };
+	DWORD ret;
+
+	HANDLE fh =3D (HANDLE)_get_osfhandle(fd);
+	if (fh =3D=3D INVALID_HANDLE_VALUE) {
+		errno =3D EBADF;
+		return -1;
+	}
+
+	overlapped.Offset =3D (DWORD)offset;
+	overlapped.OffsetHigh =3D (DWORD)(offset >> 32);
+
+	if (!ReadFile(fh, buf, size, &ret, &overlapped)) {
+		errno =3D err_win_to_posix(GetLastError());
+		return -1;
+	}
+
+	return ret;
+}
+
 int mingw_utime (const char *file_name, const struct utimbuf *times)
 {
 	FILETIME mft, aft;
diff --git a/compat/mingw.h b/compat/mingw.h
index c7b2cec..da47302 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -285,6 +285,9 @@ int mingw_fstat(int fd, struct stat *buf);
 #define _stati64(x,y) mingw_stat(x,y)
 #endif

+ssize_t mingw_pread(int fd, void *buf, size_t count, off_t offset);
+#define pread mingw_pread
+
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
