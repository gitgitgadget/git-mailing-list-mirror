Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9B81FF7F
	for <e@80x24.org>; Sun, 11 Dec 2016 11:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbcLKLRI (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 06:17:08 -0500
Received: from mout.gmx.net ([212.227.17.22]:64593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752208AbcLKLRH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 06:17:07 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLi1v-1cGJF117at-000qgH; Sun, 11
 Dec 2016 12:17:00 +0100
Date:   Sun, 11 Dec 2016 12:16:57 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 1/1] mingw: intercept isatty() to handle /dev/null as Git
 expects it
In-Reply-To: <cover.1481454992.git.johannes.schindelin@gmx.de>
Message-ID: <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>
References: <cover.1481454992.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Il99fdHj4JO59IhufdoXhlIH4VmV34zxNyU3fxLxXHDkxlBfG3+
 5m5rCqyC0sS2KKF4ZEhQ003bj+j8pcZfuDInXfm2qipVcnup5mFoAh6wV/pgCWACrkUfzMb
 tWSyO5Ppo+IytkD/Ar27qMVJamwxXVJ1HEgZAU2rM3ia1i+9Ztvgm1bjy57smxXIn+OGKNp
 lqIyITldwTdRMkeHsyObg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oI4X3G/xeZE=:TV3RdZS9cpVwfUrvnHNaFt
 bnv8J077jAnrtMihp/6PqPPCJ11Gh3PWogS38zNoAcWTtaZk/ayPMmOcc4zb/XumhenyvHC8E
 RxZwN7k4W/bM8wKVJ74LSco6DT9c8SToOIEPZuXju5sP81NIxXlhIGjk7pKxxiCgYvKbwWLuK
 Abn8TfA4j49UU06VFkfxmMEBt0ILDmFMWQX0sgw2YWptG3JIE4UIb3sMK6FkJ7OiFe+FF9mOb
 H8bdvmr7TaR0zxjFprHOaA3v77MVoar8KlDX0ayBz1OBvbN45ZZqqnE6zqyCRMcQIBm3iSqFs
 edyc7RdeaxRFbPU/JuebS66C5lEg6bQFmxALbq2o3jIt0ql27FTHyZj1HDBQkUHMr/5gfXOV3
 NMc2KfITCw7g8fSDESH8al5sUF11dHxlbTZtFgOtWjAleTAL2tbkQPvVoBJnZZKsbYRtkk6Y6
 FO+Uj0xGk8IiK9lpTZhzhdwhL2jjRl23cdE+W7oshjIlJ/bem+oWxtIpkQtfbd7WjABtYWFpf
 n8AcJbzHEUhxZYtL/qnbLYYuNH16XKoLSibv74GV6hD5yBofZjjVoyDSYd8SXAKxDVMqqzmAK
 7NTGryf3Feu06Gadn3YGt14I4lFd+yLE6X3qE1JRsNV2Acsrqf/zLpB9t59BxxpS6B76qejLH
 evyfFWhq9rq8TISyHnDrP3+mLgZyL+zdv9I9eKh2+yz5uNl9FFTZVavshch+UsL5ZuVo1V4q6
 oRy2CW2gd4a6/Dg5p17Tr/+okKZ3giTrVzg6UL1s3aBoAoYBw4Z7gizktz9OFFK3GIOl48bjs
 iy0XXKG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When Git's source code calls isatty(), it really asks whether the
respective file descriptor is connected to an interactive terminal.

Windows' _isatty() function, however, determines whether the file
descriptor is associated with a character device. And NUL, Windows'
equivalent of /dev/null, is a character device.

Which means that for years, Git mistakenly detected an associated
interactive terminal when being run through the test suite, which
almost always redirects stdin, stdout and stderr to /dev/null.

This bug only became obvious, and painfully so, when the new
bisect--helper entered the `pu` branch and made the automatic build & test
time out because t6030 was waiting for an answer.

For details, see

	https://msdn.microsoft.com/en-us/library/f4s0ddew.aspx

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h   |  3 +++
 compat/winansi.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index 034fff9479..3350169555 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -384,6 +384,9 @@ int mingw_raise(int sig);
  * ANSI emulation wrappers
  */
 
+int winansi_isatty(int fd);
+#define isatty winansi_isatty
+
 void winansi_init(void);
 HANDLE winansi_get_osfhandle(int fd);
 
diff --git a/compat/winansi.c b/compat/winansi.c
index db4a5b0a37..cb725fb02f 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -7,6 +7,9 @@
 #include <wingdi.h>
 #include <winreg.h>
 
+/* In this file, we actually want to use Windows' own isatty(). */
+#undef isatty
+
 /*
  ANSI codes used by git: m, K
 
@@ -570,6 +573,36 @@ static void detect_msys_tty(int fd)
 
 #endif
 
+int winansi_isatty(int fd)
+{
+	int res = isatty(fd);
+
+	if (res) {
+		/*
+		 * Make sure that /dev/null is not fooling Git into believing
+		 * that we are connected to a terminal, as "_isatty() returns a
+		 * nonzero value if the descriptor is associated with a
+		 * character device."; for more information, see
+		 *
+		 * https://msdn.microsoft.com/en-us/library/f4s0ddew.aspx
+		 */
+		HANDLE handle = (HANDLE)_get_osfhandle(fd);
+		if (fd == STDIN_FILENO) {
+			DWORD dummy;
+
+			if (!GetConsoleMode(handle, &dummy))
+				res = 0;
+		} else if (fd == STDOUT_FILENO || fd == STDERR_FILENO) {
+			CONSOLE_SCREEN_BUFFER_INFO dummy;
+
+			if (!GetConsoleScreenBufferInfo(handle, &dummy))
+				res = 0;
+		}
+	}
+
+	return res;
+}
+
 void winansi_init(void)
 {
 	int con1, con2;
-- 
2.11.0.rc3.windows.1
