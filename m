From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 3/5] Windows: boost startup by avoiding a static dependency on shell32.dll
Date: Thu,  7 Jan 2010 22:54:59 +0100
Message-ID: <f0b356b09f64c90ef81a32aa7e9da8698d5d5d16.1262895937.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 22:56:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT0Lb-000271-Tg
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 22:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab0AGV4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 16:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214Ab0AGV4q
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 16:56:46 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:50952 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754205Ab0AGV4p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 16:56:45 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 622CCCDF91;
	Thu,  7 Jan 2010 22:56:44 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E3B6D19F610;
	Thu,  7 Jan 2010 22:55:56 +0100 (CET)
X-Mailer: git-send-email 1.6.6.115.gd1ab3
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136392>

This DLL is only needed to invoke the browser in a "git help" call. By
looking up the only function that we need at runtime, we can avoid the
startup costs of this DLL.

DLL usage can be profiled with Microsoft's Dependency Walker. For example,
a call to "git diff-files" loaded

before:  19 DLLs
after:    9 DLLs

(The results depend on the OS; this is on Windows XP SP3.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index bc3dc74..dfb1f05 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3,8 +3,6 @@
 #include <conio.h>
 #include "../strbuf.h"
 
-#include <shellapi.h>
-
 int err_win_to_posix(DWORD winerr)
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
1.6.6.115.gd1ab3
