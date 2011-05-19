From: Rafael Gieschke <rafael@gieschke.de>
Subject: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 13:37:57 +0200
Message-ID: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 13:38:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN1Yp-00029J-8E
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 13:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178Ab1ESLi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 07:38:27 -0400
Received: from smtp2.goneo.de ([212.90.139.82]:60061 "EHLO smtp2.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754326Ab1ESLi0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 07:38:26 -0400
Received: from smtp2.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id DEB9F1D22EF;
	Thu, 19 May 2011 13:38:24 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.829
X-Spam-Level: 
X-Spam-Status: No, score=-2.829 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=0.071, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
	by smtp2.goneo.de (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8LaHGsVcOCQn; Thu, 19 May 2011 13:38:22 +0200 (CEST)
Received: from [10.163.130.160] (unknown [89.204.137.160])
	by smtp2-587.goneo.de (Postfix) with ESMTPSA id 147B11D22A9;
	Thu, 19 May 2011 13:38:20 +0200 (CEST)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173953>


If NO_GETPASS is set, getpass is provided in compat/getpass.c from
https://github.com/CyanogenMod/android_external_dropbear/raw/master/netbsd_getpass.c
(getpass was renamed to gitgetpass).

Signed-off-by: Rafael Gieschke <rafael@gieschke.de>
---
 Makefile          |    6 +++
 compat/getpass.c  |  114 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |    5 ++
 3 files changed, 125 insertions(+), 0 deletions(-)
 create mode 100644 compat/getpass.c

diff --git a/Makefile b/Makefile
index d7147cf..e171fcd 100644
--- a/Makefile
+++ b/Makefile
@@ -71,6 +71,8 @@ all::
 #
 # Define NO_STRTOK_R if you don't have strtok_r in the C library.
 #
+# Define NO_GETPASS if you don't have getpass in the C library.
+#
 # Define NO_FNMATCH if you don't have fnmatch in the C library.
 #
 # Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
@@ -1406,6 +1408,10 @@ ifdef NO_STRTOK_R
 	COMPAT_CFLAGS += -DNO_STRTOK_R
 	COMPAT_OBJS += compat/strtok_r.o
 endif
+ifdef NO_GETPASS
+	COMPAT_CFLAGS += -DNO_GETPASS
+	COMPAT_OBJS += compat/getpass.o
+endif
 ifdef NO_FNMATCH
 	COMPAT_CFLAGS += -Icompat/fnmatch
 	COMPAT_CFLAGS += -DNO_FNMATCH
diff --git a/compat/getpass.c b/compat/getpass.c
new file mode 100644
index 0000000..e13f29f
--- /dev/null
+++ b/compat/getpass.c
@@ -0,0 +1,114 @@
+/*	$NetBSD: getpass.c,v 1.15 2003/08/07 16:42:50 agc Exp $	*/
+
+/*
+ * Copyright (c) 1988, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#if 0
+#include <sys/cdefs.h>
+#if defined(LIBC_SCCS) && !defined(lint)
+#if 0
+static char sccsid[] = "@(#)getpass.c	8.1 (Berkeley) 6/4/93";
+#else
+__RCSID("$NetBSD: getpass.c,v 1.15 2003/08/07 16:42:50 agc Exp $");
+#endif
+#endif /* LIBC_SCCS and not lint */
+
+#include "namespace.h"
+#endif
+
+#include <assert.h>
+#include <paths.h>
+#include <pwd.h>
+#include <signal.h>
+#include <stdio.h>
+#include <termios.h>
+#include <unistd.h>
+
+#if 0
+#ifdef __weak_alias
+__weak_alias(getpass,_getpass)
+#endif
+#endif
+
+char *
+gitgetpass(prompt)
+	const char *prompt;
+{
+	struct termios term;
+	int ch;
+	char *p;
+	FILE *fp, *outfp;
+	int echo;
+	static char buf[_PASSWORD_LEN + 1];
+	sigset_t oset, nset;
+
+#if 0
+	_DIAGASSERT(prompt != NULL);
+#endif
+
+	/*
+	 * read and write to /dev/tty if possible; else read from
+	 * stdin and write to stderr.
+	 */
+	if ((outfp = fp = fopen(_PATH_TTY, "w+")) == NULL) {
+		outfp = stderr;
+		fp = stdin;
+	}
+
+	/*
+	 * note - blocking signals isn't necessarily the
+	 * right thing, but we leave it for now.
+	 */
+	sigemptyset(&nset);
+	sigaddset(&nset, SIGINT);
+	sigaddset(&nset, SIGTSTP);
+	(void)sigprocmask(SIG_BLOCK, &nset, &oset);
+
+	(void)tcgetattr(fileno(fp), &term);
+	if ((echo = (term.c_lflag & ECHO)) != 0) {
+		term.c_lflag &= ~ECHO;
+		(void)tcsetattr(fileno(fp), TCSAFLUSH /*|TCSASOFT*/, &term);
+	}
+	if (prompt != NULL)
+		(void)fputs(prompt, outfp);
+	rewind(outfp);			/* implied flush */
+	for (p = buf; (ch = getc(fp)) != EOF && ch != '\n';)
+		if (p < buf + _PASSWORD_LEN)
+			*p++ = ch;
+	*p = '\0';
+	(void)write(fileno(outfp), "\n", 1);
+	if (echo) {
+		term.c_lflag |= ECHO;
+		(void)tcsetattr(fileno(fp), TCSAFLUSH/*|TCSASOFT*/, &term);
+	}
+	(void)sigprocmask(SIG_SETMASK, &oset, NULL);
+	if (fp != stdin)
+		(void)fclose(fp);
+	return(buf);
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index e0bb81e..2ea5ac9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -352,6 +352,11 @@ extern uintmax_t gitstrtoumax(const char *, char **, int);
 extern char *gitstrtok_r(char *s, const char *delim, char **save_ptr);
 #endif
 
+#ifdef NO_GETPASS
+#define getpass gitgetpass
+extern char *gitgetpass(const char *prompt);
+#endif
+
 #ifdef NO_HSTRERROR
 #define hstrerror githstrerror
 extern const char *githstrerror(int herror);
-- 
1.7.4
