From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] mingw: make isatty() recognize MSYS2's pseudo terminals
 (/dev/pty*)
Date: Wed, 27 Apr 2016 17:16:37 +0200 (CEST)
Message-ID: <f1408371e14ff10539990ad710681ef17f29fea1.1461770158.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Karsten Blees <blees@dcon.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 17:16:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avRCt-00006K-7x
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 17:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbcD0PQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 11:16:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:60440 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbcD0PQp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 11:16:45 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lr32V-1bZhZ72v7D-00eYpe; Wed, 27 Apr 2016 17:16:38
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:1ovr8UDhpgDrdxs2l5oKF1R4faijnMOVoTM0BHnu2VndYVxy2CE
 iFHVRu/9npjKGpe/KDoypp98N2MZeC1F8KaYOFBYG/ZnhHSGyt0vSSAhBNkUB2psAERp/xd
 6ZZd1vbCWgvmZ6nM2S+59pic5HENlZaY2Bed/lwACesHm7xVdm4OIX2D7t2ZqBaUpwoc+3Q
 acQL3eVY9HxVYb27pLpkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jxugHqtq8NU=:aGkpjTtJmX0naTXfA7Qsbv
 CMb52Lw4H0BVfZO9ui6JeYsD6Y6K1kQxfu8bnZ8tSzzHaVofqmMXhrLUgVDY4kr+lD7YQGzf7
 lwqz56642rmwsL0sak85xrr3xLcscoHBiMwCgTOzhihR25pJhmnaGXerqFothU5v8qKqj0kZa
 vaqZpQgrD8AbqKSlqDGvXI0+rPtv7Zvle0z74ybug/SKeeLUEtBASL44YIna2naScCTRVv7Rq
 JtCvqqg1bsDDY0ndy1vdTg7775uVJjvleTGzeNEd4PFICZnF9KhKjMHrAekqKVDPCfCWRAq5V
 6xV6pzIVrdWs+DmWeGgj9n939Bw/i/38Vc+gqQNzHQBPyJQxg08i9zyjg0XL68NF6mLtqBVcA
 bgyp1X5aE11yK1s2CBKZlz/wwirwrHe9hmeiSniVJZb0qcLhKZjGaQ/i4rnI+qDLi2SvNpS1y
 wcy6m466fnZfoTDUIIMBupKjE+0GNVH2dm4wVoBpVu9p8ck5Ck5LdHAeBXy33MVn4uTkCHpTt
 PjF7zMJQPrjb/+WTlXkioc/OVgCBfY9aDNtn7QaVkudwGDTxEGTr58RiNbaSJiedZoZ587mJD
 ZcrZIEhs6N1k6JSSXOlxgCS+sB0Zqg4GOTEBqKQM9qB4Gpjj8s2ngv9z4wh61kbXXBq6Eggvn
 fa/ObNGWTrHBrDbLC1o8To3iFx4wUKI4LMjRfCZzID8+AqalpjadO9DL2sYvEIM70XhlUYKI1
 MzQ4AhfNmTjFJU/JJiumwPAAmw2r5KoWqIAaxt+aNDTh9wD8RSJy0vaWEO8d9cQ3SryAXz3f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292731>

From: Karsten Blees <blees@dcon.de>

MSYS2 emulates pseudo terminals via named pipes, and isatty() returns 0
for such file descriptors. Therefore, some interactive functionality
(such as launching a pager, asking if a failed unlink should be repeated
etc.) doesn't work when run in a terminal emulator that uses MSYS2's
ptys (such as mintty).

However, MSYS2 uses special names for its pty pipes ('msys-*-pty*'),
which allows us to distinguish them from normal piped input / output.

On startup, check if stdin / stdout / stderr are connected to such pipes
using the NtQueryObject API from NTDll.dll. If the names match, adjust
the flags in MSVCRT's ioinfo structure accordingly.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/windows-isatty-v1
 compat/winansi.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 config.mak.uname |  3 ++-
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 5dfa5ed..3be60ce 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -483,6 +483,7 @@ static size_t sizeof_ioinfo = 0;
 #define IOINFO_L2E 5
 #define IOINFO_ARRAY_ELTS (1 << IOINFO_L2E)
 
+#define FPIPE 0x08
 #define FDEV  0x40
 
 static inline ioinfo* _pioinfo(int fd)
@@ -530,6 +531,45 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
 	return old_handle;
 }
 
+#ifdef DETECT_MSYS_TTY
+
+#include <winternl.h>
+#include <ntstatus.h>
+
+static void detect_msys_tty(int fd)
+{
+	ULONG result;
+	BYTE buffer[1024];
+	POBJECT_NAME_INFORMATION nameinfo = (POBJECT_NAME_INFORMATION) buffer;
+	PWSTR name;
+
+	/* check if fd is a pipe */
+	HANDLE h = (HANDLE) _get_osfhandle(fd);
+	if (GetFileType(h) != FILE_TYPE_PIPE)
+		return;
+
+	/* get pipe name */
+	if (!NT_SUCCESS(NtQueryObject(h, ObjectNameInformation,
+			buffer, sizeof(buffer) - 2, &result)))
+		return;
+	name = nameinfo->Name.Buffer;
+	name[nameinfo->Name.Length] = 0;
+
+	/* check if this could be a MSYS2 pty pipe ('msys-XXXX-ptyN-XX') */
+	if (!wcsstr(name, L"msys-") || !wcsstr(name, L"-pty"))
+		return;
+
+	/* init ioinfo size if we haven't done so */
+	if (init_sizeof_ioinfo())
+		return;
+
+	/* set FDEV flag, reset FPIPE flag */
+	_pioinfo(fd)->osflags &= ~FPIPE;
+	_pioinfo(fd)->osflags |= FDEV;
+}
+
+#endif
+
 void winansi_init(void)
 {
 	int con1, con2;
@@ -538,8 +578,15 @@ void winansi_init(void)
 	/* check if either stdout or stderr is a console output screen buffer */
 	con1 = is_console(1);
 	con2 = is_console(2);
-	if (!con1 && !con2)
+	if (!con1 && !con2) {
+#ifdef DETECT_MSYS_TTY
+		/* check if stdin / stdout / stderr are MSYS2 pty pipes */
+		detect_msys_tty(0);
+		detect_msys_tty(1);
+		detect_msys_tty(2);
+#endif
 		return;
+	}
 
 	/* create a named pipe to communicate with the console thread */
 	xsnprintf(name, sizeof(name), "\\\\.\\pipe\\winansi%lu", GetCurrentProcessId());
@@ -575,8 +622,11 @@ void winansi_init(void)
 HANDLE winansi_get_osfhandle(int fd)
 {
 	HANDLE hnd = (HANDLE) _get_osfhandle(fd);
-	if ((fd == 1 || fd == 2) && isatty(fd)
-	    && GetFileType(hnd) == FILE_TYPE_PIPE)
-		return (fd == 1) ? hconsole1 : hconsole2;
+	if (isatty(fd) && GetFileType(hnd) == FILE_TYPE_PIPE) {
+		if (fd == 1 && hconsole1)
+			return hconsole1;
+		else if (fd == 2 && hconsole2)
+			return hconsole2;
+	}
 	return hnd;
 }
diff --git a/config.mak.uname b/config.mak.uname
index 40d6b29..a88f139 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -557,7 +557,8 @@ else
 			BASIC_LDFLAGS += -Wl,--large-address-aware
 		endif
 		CC = gcc
-		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0
+		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY
+		EXTLIBS += -lntdll
 		INSTALL = /bin/install
 		NO_R_TO_GCC_LINKER = YesPlease
 		INTERNAL_QSORT = YesPlease
-- 
2.8.1.306.gff998f2
