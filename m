From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 9/9] index-helper: add Windows support
Date: Sun,  1 Nov 2015 14:42:49 +0100
Message-ID: <1446385369-8669-10-git-send-email-pclouds@gmail.com>
References: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:43:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZssvL-00005z-ET
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbbKANnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:43:50 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34398 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbbKANnl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:43:41 -0500
Received: by wikq8 with SMTP id q8so36505338wik.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2nkY9uHtjcElrsh2bYq4w/ABdFPkz6JVIa3KAFRUE5g=;
        b=CJG16rr4LUZ+pJk7v47dIBHQmvveZGh8LZVH8R2xJTVTz8Yt6W0SI0w2BDgdoJ+K/U
         iRc9vGaNVB4uFavTxDxEBb6irW9JrNepslZ7hbZKbrtLgNhjlfYe1I+LSNbi93nh+IcE
         SHpocDH0MihOf95DGyWdJlQHBhWyQSk1RZYfrQ2cBoHDb075PqYnIk5RDh2C7mFYbAqV
         jBw1gB/4fsBbjeVIL/mPEQZ8hn5pHRqcpYYXb1dzcCXf7Ay1a0ND5Uac6NppXCbqMSRG
         hSzBLU82/QCYv1F2uGPpnQilFzoykt9POhsruwZCKa1v2RMDtZAXIYrN6XNTVjohFV3/
         R9lA==
X-Received: by 10.194.187.14 with SMTP id fo14mr18418354wjc.104.1446385420541;
        Sun, 01 Nov 2015 05:43:40 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id gd10sm17058028wjb.47.2015.11.01.05.43.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:43:39 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280625>

Windows supports shared memory, but the semantics is a bit different
than POSIX shm. The most noticeable thing is there's no way to get the
shared memory's size by the reader, and wrapping fstat to do that
would be hell. So the shm size is added near the end, hidden away from
shm users (storing it in headers would cause more problems with munmap,
storing it as a separate shm is even worse).

PostMessage is used instead of UNIX signals for
notification. Lightweight (at least code-wise) on the client side.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.mak.uname |  2 ++
 index-helper.c   | 48 ++++++++++++++++++++++++++++
 read-cache.c     | 13 ++++++++
 shm.c            | 96 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 159 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 3167e36..260fa82 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -391,6 +391,7 @@ ifndef DEBUG
 else
 	BASIC_CFLAGS +=3D -Zi -MDd
 endif
+	PROGRAM_OBJS +=3D index-helper.o
 	X =3D .exe
 endif
 ifeq ($(uname_S),Interix)
@@ -545,6 +546,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 else
 	NO_CURL =3D YesPlease
 endif
+	PROGRAM_OBJS +=3D index-helper.o
 endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS +=3D -DSA_RESTART=3D0
diff --git a/index-helper.c b/index-helper.c
index 4dd9656..cf26da7 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -155,6 +155,51 @@ static void loop(const char *pid_file, int idle_in=
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
@@ -198,6 +243,9 @@ int main(int argc, char **argv)
 	fd =3D hold_lock_file_for_update(&lock,
 				       git_path("index-helper.pid"),
 				       LOCK_DIE_ON_ERROR);
+#ifdef GIT_WINDOWS_NATIVE
+	strbuf_addstr(&sb, "HWND");
+#endif
 	strbuf_addf(&sb, "%" PRIuMAX, (uintmax_t) getpid());
 	write_in_full(fd, sb.buf, sb.len);
 	commit_lock_file(&lock);
diff --git a/read-cache.c b/read-cache.c
index 3ae2bc1..f609776 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1524,6 +1524,18 @@ static void check_ce_order(struct index_state *i=
state)
 	}
 }
=20
+#if defined(GIT_WINDOWS_NATIVE)
+static void do_poke(struct strbuf *sb, int refresh_cache)
+{
+	HWND hwnd;
+	if (!starts_with(sb->buf, "HWND"))
+		return;
+	hwnd =3D FindWindow("git-index-helper", sb->buf);
+	if (!hwnd)
+		return;
+	PostMessage(hwnd, refresh_cache ? WM_USER : WM_USER + 1, 0, 0);
+}
+#else
 static void do_poke(struct strbuf *sb, int refresh_cache)
 {
 	char	*start =3D sb->buf;
@@ -1533,6 +1545,7 @@ static void do_poke(struct strbuf *sb, int refres=
h_cache)
 		return;
 	kill(pid, refresh_cache ? SIGHUP : SIGUSR1);
 }
+#endif
=20
 static void poke_daemon(struct index_state *istate,
 			const struct stat *st, int refresh_cache)
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
2.2.0.513.g477eb31
