From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 9/9] index-helper: add Windows support
Date: Mon, 28 Jul 2014 19:03:15 +0700
Message-ID: <1406548995-28549-10-git-send-email-pclouds@gmail.com>
References: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 14:04:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBjfc-0003Bh-AS
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 14:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbaG1MEn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 08:04:43 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34399 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbaG1MEm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 08:04:42 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so10404047pad.39
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 05:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4q2NF81yZnsTGGB2Ea3jo3cHCO/bgGM/8fkD5kQVUws=;
        b=aKBeodhXM748whTgQavXKZJZ/lfuxaXFAWvdn2Ilz1xC1DG0HKtwvmhYbdkR4XWDn9
         TFQQcrZLHtigjngLZ5M2gw/8Hzuwg0o5BameZ2af/EhTVq2iBmEAVYriS2X8Lq3SFlUQ
         m9AiAx09652ksLwccySQUimuj3IRL93iadWBL/w94Fq7OXhVE3Qy04ZYP7VWACMrf0lz
         U14RICap45K2ugTVLGR7FqfUI6ZTwGtI0ME6IrZkcP9sUv70L8kA67shiqOHWEpCJtS2
         eAr1zyJ2HOECmXc4OEKj0iTL/X/Iwif10cBZaGBIyYzsQqvCjCQoyL28vaeZ5dRj5rh8
         lbXg==
X-Received: by 10.70.38.72 with SMTP id e8mr37691449pdk.33.1406549081438;
        Mon, 28 Jul 2014 05:04:41 -0700 (PDT)
Received: from lanh ([115.73.211.176])
        by mx.google.com with ESMTPSA id qf3sm20506813pdb.60.2014.07.28.05.04.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 05:04:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Jul 2014 19:04:44 +0700
X-Mailer: git-send-email 2.1.0.rc0.66.gb9187ad
In-Reply-To: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254323>

Windows supports shared memory, but the semantics is a bit different
than POSIX shm. The most noticeable thing is there's no way to get the
shared memory's size by the reader, and wrapping fstat to do that
would be hell. So the shm size is added near the end, hidden away from
shm users (storing it in headers would cause more problems with munmap,
storing it as a separate shm is even worse).

PostMessage is used instead of UNIX signals for notification.
Lightweight (at least code-wise) on the client side.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.mak.uname |  2 ++
 index-helper.c   | 48 ++++++++++++++++++++++++++++
 read-cache.c     |  6 ++++
 shm.c            | 96 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 152 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 7e66d80..74e764f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -377,6 +377,7 @@ ifndef DEBUG
 else
 	BASIC_CFLAGS +=3D -Zi -MDd
 endif
+	PROGRAM_OBJS +=3D index-helper.o
 	X =3D .exe
 endif
 ifeq ($(uname_S),Interix)
@@ -532,6 +533,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 else
 	NO_CURL =3D YesPlease
 endif
+	PROGRAM_OBJS +=3D index-helper.o
 endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS +=3D -DSA_RESTART=3D0
diff --git a/index-helper.c b/index-helper.c
index 4262678..7c2a0e7 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -147,6 +147,51 @@ static void loop(const char *pid_file, int idle_in=
_seconds)
 		; /* do nothing, all is handled by signal handlers already */
 }
=20
+#elif defined(GIT_WINDOWS_NATIVE)
+
+static void loop(const char *pid_file, int idle_in_seconds)
+{
+	HWND hwnd;
+	UINT_PTR timer =3D 0;
+	MSG msg;
+	HINSTANCE hinst =3D GetModuleHandle(NULL);
+	WNDCLASS wc;
+
+	/*
+	 * Emulate UNIX signals by sending WM_USER+x to a
+	 * window. Register window class and create a new window to
+	 * catch these messages.
+	 */
+	memset(&wc, 0, sizeof(wc));
+	wc.lpfnWndProc	 =3D DefWindowProc;
+	wc.hInstance	 =3D hinst;
+	wc.lpszClassName =3D "git-index-helper";
+	if (!RegisterClass(&wc))
+		die_errno(_("could not register new window class"));
+
+	hwnd =3D CreateWindow("git-index-helper", pid_file,
+			    0, 0, 0, 1, 1, NULL, NULL, hinst, NULL);
+	if (!hwnd)
+		die_errno(_("could not register new window"));
+
+	refresh(0);
+	while (1) {
+		timer =3D SetTimer(hwnd, timer, idle_in_seconds * 1000, NULL);
+		if (!timer)
+			die(_("no timer!"));
+		if (!GetMessage(&msg, hwnd, 0, 0) || msg.message =3D=3D WM_TIMER)
+			break;
+		switch (msg.message) {
+		case WM_USER:
+			refresh(0);
+			break;
+		default:
+			/* just reset the timer */
+			break;
+		}
+	}
+}
+
 #else
=20
 static void loop(const char *pid_file, int idle_in_seconds)
@@ -192,6 +237,9 @@ int main(int argc, char **argv)
 				       git_path("index-helper.pid"),
 				       LOCK_DIE_ON_ERROR);
 	strbuf_addf(&sb,
+#ifdef GIT_WINDOWS_NATIVE
+		    "HWND"
+#endif
 		    "%" PRIuMAX, (uintmax_t) getpid());
 	write_in_full(fd, sb.buf, sb.len);
 	commit_lock_file(&lock);
diff --git a/read-cache.c b/read-cache.c
index d6eb17f..0ca3345 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1489,6 +1489,12 @@ static void poke_daemon(const struct stat *st, i=
nt refresh_cache)
 		pid_t pid =3D strtoul(sb.buf, &end, 10);
 		if (end && sb.buf + st->st_size =3D=3D end)
 			kill(pid, refresh_cache ? SIGHUP : SIGUSR1);
+#elif defined(GIT_WINDOWS_NATIVE)
+		if (starts_with(sb.buf, "HWND")) {
+			HWND hwnd =3D FindWindow("git-index-helper", sb.buf);
+			PostMessage(hwnd, refresh_cache ? WM_USER : WM_USER + 1,
+				    0, 0);
+		}
 #endif
 	}
 	close(fd);
diff --git a/shm.c b/shm.c
index 4ec1a00..04d8a35 100644
--- a/shm.c
+++ b/shm.c
@@ -52,6 +52,102 @@ void git_shm_unlink(const char *fmt, ...)
 	shm_unlink(path);
 }
=20
+#elif defined(GIT_WINDOWS_NATIVE)
+
+#define SHM_PATH_LEN 82	/* a little bit longer than POSIX because of "=
Local\\" */
+
+static ssize_t create_shm_map(int oflag, int perm, ssize_t length,
+			      void **mmap, int prot, int flags,
+			      const char *path, unsigned long page_size)
+{
+	size_t real_length;
+	void *last_page;
+	HANDLE h;
+
+	assert(perm   =3D=3D 0700);
+	assert(oflag  =3D=3D (O_CREAT | O_EXCL | O_RDWR));
+	assert(prot   =3D=3D (PROT_READ | PROT_WRITE));
+	assert(flags  =3D=3D MAP_SHARED);
+	assert(length >=3D 0);
+
+	real_length =3D length;
+	if (real_length % page_size)
+		real_length +=3D page_size - (real_length % page_size);
+	real_length +=3D page_size;
+	h =3D CreateFileMapping(INVALID_HANDLE_VALUE, NULL, PAGE_READWRITE, 0=
,
+			      real_length, path);
+	if (!h)
+		return -1;
+	*mmap =3D MapViewOfFile(h, FILE_MAP_ALL_ACCESS, 0, 0, real_length);
+	CloseHandle(h);
+	if (!*mmap)
+		return -1;
+	last_page =3D (unsigned char *)*mmap + real_length - page_size;
+	*(unsigned long *)last_page =3D length;
+	return length;
+}
+
+static ssize_t open_shm_map(int oflag, int perm, ssize_t length, void =
**mmap,
+			    int prot, int flags, const char *path,
+			    unsigned long page_size)
+{
+	void *last_page;
+	HANDLE h;
+
+	assert(perm   =3D=3D 0700);
+	assert(oflag  =3D=3D O_RDONLY);
+	assert(prot   =3D=3D PROT_READ);
+	assert(flags  =3D=3D MAP_SHARED);
+	assert(length <=3D 0);
+
+	h =3D OpenFileMapping(FILE_MAP_READ, FALSE, path);
+	if (!h)
+		return -1;
+	*mmap =3D MapViewOfFile(h, FILE_MAP_READ, 0, 0, 0);
+	CloseHandle(h);
+	if (!*mmap)
+		return -1;
+	if (length < 0) {
+		MEMORY_BASIC_INFORMATION mbi;
+		if (!VirtualQuery(*mmap, &mbi, sizeof(mbi))) {
+			UnmapViewOfFile(*mmap);
+			return -1;
+		}
+		if (mbi.RegionSize % page_size)
+			die("expected size %lu to be %lu aligned",
+				    mbi.RegionSize, page_size);
+		last_page =3D (unsigned char *)*mmap + mbi.RegionSize - page_size;
+		length =3D *(unsigned long *)last_page;
+	}
+	return length;
+}
+
+ssize_t git_shm_map(int oflag, int perm, ssize_t length, void **mmap,
+		    int prot, int flags, const char *fmt, ...)
+{
+	SYSTEM_INFO si;
+	va_list ap;
+	char path[SHM_PATH_LEN];
+
+	GetSystemInfo(&si);
+
+	strcpy(path, "Local\\");
+	va_start(ap, fmt);
+	vsprintf(path + strlen(path), fmt, ap);
+	va_end(ap);
+
+	if (oflag & O_CREAT)
+		return create_shm_map(oflag, perm, length, mmap, prot,
+				      flags, path, si.dwPageSize);
+	else
+		return open_shm_map(oflag, perm, length, mmap, prot,
+				    flags, path, si.dwPageSize);
+}
+
+void git_shm_unlink(const char *fmt, ...)
+{
+}
+
 #else
=20
 ssize_t git_shm_map(int oflag, int perm, ssize_t length, void **mmap,
--=20
2.1.0.rc0.66.gb9187ad
