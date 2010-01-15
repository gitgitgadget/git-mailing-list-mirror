From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 2/7] Windows: boost startup by avoiding a static dependency on shell32.dll
Date: Fri, 15 Jan 2010 21:12:16 +0100
Message-ID: <3b94470985e76dccc0b19174452de4c97a8309b1.1263584975.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:13:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVsYM-0004sM-Bb
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 21:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758151Ab0AOUNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 15:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758145Ab0AOUNp
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 15:13:45 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:31592 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758137Ab0AOUNo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 15:13:44 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B2FB4A7EB2;
	Fri, 15 Jan 2010 21:13:41 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 272C419F60D;
	Fri, 15 Jan 2010 21:12:45 +0100 (CET)
X-Mailer: git-send-email 1.6.6.218.g3e6eb
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
In-Reply-To: <cover.1263584975.git.j6t@kdbg.org>
References: <cover.1263584975.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137108>

This DLL is only needed to invoke the browser in a "git help" call. By
looking up the only function that we need at runtime, we can avoid the
startup costs of this DLL.

DLL usage can be profiled with Microsoft's Dependency Walker. For example,
a call to "git diff-files" loaded

before:  19 DLLs
after:    9 DLLs

As a result, the runtime of 'make -j2 test' went down from 16:00min
to 12:40min on one of my boxes.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 No changes.

 compat/mingw.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0d73f15..2afc978 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3,8 +3,6 @@
 #include <conio.h>
 #include "../strbuf.h"
 
-#include <shellapi.h>
-
 static int err_win_to_posix(DWORD winerr)
 {
 	int error = ENOSYS;
@@ -1338,8 +1336,22 @@ static const char *make_backslash_path(const char *path)
 void mingw_open_html(const char *unixpath)
 {
 	const char *htmlpath = make_backslash_path(unixpath);
+	typedef HINSTANCE (WINAPI *T)(HWND, const char *,
+			const char *, const char *, const char *, INT);
+	T ShellExecute;
+	HMODULE shell32;
+
+	shell32 = LoadLibrary("shell32.dll");
+	if (!shell32)
+		die("cannot load shell32.dll");
+	ShellExecute = (T)GetProcAddress(shell32, "ShellExecuteA");
+	if (!ShellExecute)
+		die("cannot run browser");
+
 	printf("Launching default browser to display HTML ...\n");
 	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
+
+	FreeLibrary(shell32);
 }
 
 int link(const char *oldpath, const char *newpath)
-- 
1.6.6.218.g3e6eb
