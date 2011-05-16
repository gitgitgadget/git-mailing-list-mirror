From: Rafael Gieschke <rafael@gieschke.de>
Subject: [PATCHv2] add Android support
Date: Tue, 17 May 2011 01:23:24 +0200
Message-ID: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 17 01:23:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM78X-0006zW-V3
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 01:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866Ab1EPXXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 19:23:37 -0400
Received: from smtp2.goneo.de ([212.90.139.82]:59148 "EHLO smtp2.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755129Ab1EPXXf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 19:23:35 -0400
Received: from smtp2.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id A06211D1E6B;
	Tue, 17 May 2011 01:23:34 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.825
X-Spam-Level: 
X-Spam-Status: No, score=-2.825 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=0.075, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
	by smtp2.goneo.de (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KiS23DQLPCZt; Tue, 17 May 2011 01:23:32 +0200 (CEST)
Received: from [10.151.107.254] (unknown [89.204.153.254])
	by smtp2-587.goneo.de (Postfix) with ESMTPSA id 19CE31D1C76;
	Tue, 17 May 2011 01:23:30 +0200 (CEST)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173774>


Currently, it is not possible to compile git for Android as the C library (Bionic)
is neither providing getpass nor pw_gecos in struct passwd. Therefore,
NO_GETPASS and NO_PW_GECOS are defined in Makefile. As code for Android can only
be cross-compiled, ANDROID is defined.

If NO_GETPASS is set, getpass is provided in compat/getpass.c from
https://github.com/CyanogenMod/android_external_dropbear/raw/master/netbsd_getpass.c

Signed-off-by: Rafael Gieschke <rafael@gieschke.de>
---
 Makefile          |   28 +++++++++++++
 compat/getpass.c  |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |    4 ++
 ident.c           |    8 +++-
 4 files changed, 154 insertions(+), 1 deletions(-)
 create mode 100644 compat/getpass.c

diff --git a/Makefile b/Makefile
index c4db5af..9b505c8 100644
--- a/Makefile
+++ b/Makefile
@@ -71,6 +71,11 @@ all::
 #
 # Define NO_STRTOK_R if you don't have strtok_r in the C library.
 #
+# Define NO_GETPASS if you don't have getpass in the C library.
+#
+# Define NO_PW_GECOS if you don't have pw_gecos in struct passwd
+# in the C library.
+#
 # Define NO_FNMATCH if you don't have fnmatch in the C library.
 #
 # Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
@@ -248,6 +253,8 @@ all::
 # dependency rules.
 #
 # Define NATIVE_CRLF if your platform uses CRLF for line endings.
+#
+# Define ANDROID if you are cross-compiling for Android.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -789,6 +796,20 @@ ifeq ($(uname_S),OSF1)
 	NO_STRTOULL = YesPlease
 	NO_NSEC = YesPlease
 endif
+ifdef ANDROID
+	uname_S := Linux
+	NO_GETPASS = YesPlease
+	NO_PW_GECOS = YesPlease
+	NO_NSEC = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_PTHREADS = YesPlease
+	NO_PERL = YesPlease
+	NO_OPENSSL = YesPlease
+	NO_CURL = YesPlease
+	NO_EXPAT = YesPlease
+	NO_TCLTK = YesPlease
+	NO_ICONV = YesPlease
+endif
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
@@ -1404,6 +1425,13 @@ ifdef NO_STRTOK_R
 	COMPAT_CFLAGS += -DNO_STRTOK_R
 	COMPAT_OBJS += compat/strtok_r.o
 endif
+ifdef NO_GETPASS
+	COMPAT_CFLAGS += -DNO_GETPASS
+	COMPAT_OBJS += compat/getpass.o
+endif
+ifdef NO_PW_GECOS
+	COMPAT_CFLAGS += -DNO_PW_GECOS
+endif
 ifdef NO_FNMATCH
 	COMPAT_CFLAGS += -Icompat/fnmatch
 	COMPAT_CFLAGS += -DNO_FNMATCH
diff --git a/compat/getpass.c b/compat/getpass.c
new file mode 100644
index 0000000..c62b7e4
--- /dev/null
+++ b/compat/getpass.c
@@ -0,0 +1,115 @@
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
+getpass(prompt)
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
+
diff --git a/git-compat-util.h b/git-compat-util.h
index e0bb81e..c1ba884 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -352,6 +352,10 @@ extern uintmax_t gitstrtoumax(const char *, char **, int);
 extern char *gitstrtok_r(char *s, const char *delim, char **save_ptr);
 #endif
 
+#ifdef NO_GETPASS
+extern char *getpass(const char *prompt);
+#endif
+
 #ifdef NO_HSTRERROR
 #define hstrerror githstrerror
 extern const char *githstrerror(int herror);
diff --git a/ident.c b/ident.c
index 1c4adb0..875d401 100644
--- a/ident.c
+++ b/ident.c
@@ -9,6 +9,12 @@
 
 static char git_default_date[50];
 
+#ifdef NO_PW_GECOS
+#define get_gecos(ignored) "&"
+#else
+#define get_gecos(struct_passwd) (struct_passwd->pw_gecos)
+#endif
+
 static void copy_gecos(const struct passwd *w, char *name, size_t sz)
 {
 	char *src, *dst;
@@ -20,7 +26,7 @@ static void copy_gecos(const struct passwd *w, char *name, size_t sz)
 	 * with commas.  Also & stands for capitalized form of the login name.
 	 */
 
-	for (len = 0, dst = name, src = w->pw_gecos; len < sz; src++) {
+	for (len = 0, dst = name, src = get_gecos(w); len < sz; src++) {
 		int ch = *src;
 		if (ch != '&') {
 			*dst++ = ch;
-- 
1.7.4
