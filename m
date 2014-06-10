From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] index-helper: add Windows support
Date: Tue, 10 Jun 2014 20:24:23 +0700
Message-ID: <1402406665-27988-4-git-send-email-pclouds@gmail.com>
References: <1402406665-27988-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 15:26:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuM4Z-0004GU-Ln
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 15:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbaFJN0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 09:26:39 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:55698 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbaFJN0i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 09:26:38 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so6126040pdj.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 06:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GrIwrVyvSrDope9pF56pvNJboqF+c8VTsCTljDG1xjE=;
        b=clxhduAULPFgkMUrEHmGWVXgm7C19g+hjrdZytLum0o/RCpXU2bsBaFiG/Ki/yp3BX
         y/qs1exheTP5GOEucox2Yf6eHo8TCvLRlKaIAHYd2986Yf/KeyDHhPQr+TS9Invb+sjH
         alS2P2sGY9KuX5mjs4QWEo1MLLEVy7mkFfc6HSXNbVutM0vCI/Hp9BMF9GV0OV6gBU9U
         6VJ5M1oT/MZD1Sx2RtM7ZVMOJuf7XU8ylKL89Y2TkLJWlKf++xpp/5SxZj/uqCPecWZ1
         Od6G/x/LwDy8cqgB5p2zBM3E8hIqc79HkUkjIxEkjdOMUSKrHV4hsUzruDmU/U2ocsDV
         rwvg==
X-Received: by 10.66.253.170 with SMTP id ab10mr5551889pad.53.1402406797795;
        Tue, 10 Jun 2014 06:26:37 -0700 (PDT)
Received: from lanh ([115.73.243.79])
        by mx.google.com with ESMTPSA id av2sm69637416pbc.16.2014.06.10.06.26.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jun 2014 06:26:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 Jun 2014 20:26:33 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402406665-27988-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251189>

Windows supports shared memory, but a bit different that POSIX
shm. The most noticeable thing is there's no way to get the shared
memory's size from the reader. So the size is added near the end in
the shared memory, hidden away from shm users (storing it in headers
would cause more problems with munmap, storing it as a separate shm is
even worse).

PostMessage is used instead of UNIX signals for
notification. Lightweight (at least code-wise) on the client side.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-index-helper.txt |  2 +-
 config.mak.uname                   |  2 +
 index-helper.c                     | 49 +++++++++++++++++++
 read-cache.c                       |  6 +++
 shm.c                              | 96 ++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index d0b1365..afeb334 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -14,7 +14,7 @@ DESCRIPTION
 -----------
 Keep the index file in memory for faster access. This daemon is per
 repository. This daemon is only available on POSIX system with
-shared memory support (e.g. Linux)
+shared memory support (e.g. Linux or Windows)
=20
 OPTIONS
 -------
diff --git a/config.mak.uname b/config.mak.uname
index 8de61a4..17d35e3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -376,6 +376,7 @@ ifndef DEBUG
 else
 	BASIC_CFLAGS +=3D -Zi -MTd
 endif
+	PROGRAM_OBJS +=3D index-helper.o
 	X =3D .exe
 endif
 ifeq ($(uname_S),Interix)
@@ -529,6 +530,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 else
 	NO_CURL =3D YesPlease
 endif
+	PROGRAM_OBJS +=3D index-helper.o
 endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS +=3D -DSA_RESTART=3D0
diff --git a/index-helper.c b/index-helper.c
index e10d0c3..f92326a 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -95,6 +95,52 @@ static void loop(const char *pid_file, int idle_in_s=
econds)
 		utime(git_path("read-cache--daemon.pid"), NULL);
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
+	wc.lpszClassName =3D "git-read-cache--daemon";
+	if (!RegisterClass(&wc))
+		die_errno("could not register new window class");
+
+	hwnd =3D CreateWindow("git-read-cache--daemon", pid_file,
+			    0, 0, 0, 1, 1, NULL, NULL, hinst, NULL);
+	if (!hwnd)
+		die_errno("could not register new window");
+
+	refresh(0);
+	while (1) {
+		timer =3D SetTimer(hwnd, timer, idle_in_seconds * 1000, NULL);
+		if (!timer)
+			die("no timer!");
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
+		utime(git_path("read-cache--daemon.pid"), NULL);
+	}
+}
+
 #else
=20
 static void loop(const char *pid_file, int idle_in_seconds)
@@ -129,6 +175,9 @@ int main(int argc, char **argv)
 				       git_path("read-cache--daemon.pid"),
 				       LOCK_DIE_ON_ERROR);
 	strbuf_addf(&sb,
+#ifdef GIT_WINDOWS_NATIVE
+		    "HWND"
+#endif
 		    "%" PRIuMAX, (uintmax_t) getpid());
 	write_in_full(fd, sb.buf, sb.len);
 	commit_lock_file(&lock);
diff --git a/read-cache.c b/read-cache.c
index f9df984..8001c29 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1483,6 +1483,12 @@ static void poke_daemon(struct stat *st, int ref=
resh_cache)
 		pid_t pid =3D strtoul(sb.buf, &end, 10);
 		if (end && !*end)
 			kill(pid, refresh_cache ? SIGHUP : SIGUSR1);
+#elif defined(GIT_WINDOWS_NATIVE)
+		if (starts_with(sb.buf, "HWND")) {
+			HWND hwnd =3D FindWindow("git-read-cache--daemon", sb.buf);
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
1.9.1.346.ga2b5940
