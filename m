From: Rafael Gieschke <rafael@gieschke.de>
Subject: [PATCHv2] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 19:01:36 +0200
Message-ID: <0301451F-9998-4208-8CE0-82B095DD5D32@gieschke.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 19:01:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN6bZ-0001c2-Gb
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 19:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933608Ab1ESRBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 13:01:41 -0400
Received: from smtp2.goneo.de ([212.90.139.82]:19392 "EHLO smtp2.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933552Ab1ESRBj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 13:01:39 -0400
Received: from smtp2.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id B03F51D220B;
	Thu, 19 May 2011 19:01:37 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -3.401
X-Spam-Level: 
X-Spam-Status: No, score=-3.401 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=-0.502, BAYES_00=-1.9, MIME_QP_LONG_LINE=0.001] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
	by smtp2.goneo.de (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 101limFJunzm; Thu, 19 May 2011 19:01:35 +0200 (CEST)
Received: from dhcp208-43.rz.uni-freiburg.de (dhcp208-43.rz.uni-freiburg.de [132.230.208.43])
	by smtp2-587.goneo.de (Postfix) with ESMTPSA id B79801D20B0;
	Thu, 19 May 2011 19:01:35 +0200 (CEST)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173968>


If NO_GETPASS is set, getpass is provided in compat/getpass.c from
http://git.uclibc.org/uClibc/plain/libc/unistd/getpass.c
(getpass() was renamed to gitgetpass()).

Signed-off-by: Rafael Gieschke <rafael@gieschke.de>
---
 Makefile          |    6 +++
 compat/getpass.c  |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |    5 +++
 3 files changed, 109 insertions(+), 0 deletions(-)
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
index 0000000..f5170e9
--- /dev/null
+++ b/compat/getpass.c
@@ -0,0 +1,98 @@
+/* Copyright (C) 1992-1999,2001,2003,2004,2005 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <stdio.h>
+#include <string.h>
+#include <termios.h>
+#include <unistd.h>
+
+#ifndef TCSASOFT
+#define TCSASOFT 0
+#endif
+#define PWD_BUFFER_SIZE 256
+
+char *gitgetpass(const char *prompt)
+{
+  FILE *in, *out;
+  struct termios s, t;
+  int tty_changed;
+  static char buf[PWD_BUFFER_SIZE];
+  int nread;
+
+  /* Try to write to and read from the terminal if we can.
+     If we can't open the terminal, use stderr and stdin.  */
+
+  in = fopen("/dev/tty", "r+");
+  if (in == NULL)
+    {
+      in = stdin;
+      out = stderr;
+    }
+  else
+    out = in;
+
+  /* Turn echoing off if it is on now.  */
+
+  if (tcgetattr(fileno(in), &t) == 0)
+    {
+      /* Save the old one. */
+      s = t;
+      /* Tricky, tricky. */
+      t.c_lflag &= ~(ECHO|ISIG);
+      tty_changed = (tcsetattr(fileno(in), TCSAFLUSH|TCSASOFT, &t) == 0);
+      if (in != stdin) {
+	/* Disable buffering for read/write FILE to prevent problems with
+	 * fseek and buffering for read/write auto-transitioning. */
+	setvbuf(in, NULL, _IONBF, 0);
+      }
+    }
+  else
+    tty_changed = 0;
+
+  /* Write the prompt.  */
+  fputs(prompt, out);
+  fflush(out);
+
+  /* Read the password.  */
+  fgets(buf, PWD_BUFFER_SIZE-1, in);
+  if (buf != NULL)
+    {
+      nread = strlen(buf);
+      if (nread < 0)
+	buf[0] = '\0';
+      else if (buf[nread - 1] == '\n')
+	{
+	  /* Remove the newline.  */
+	  buf[nread - 1] = '\0';
+	  if (tty_changed)
+	    /* Write the newline that was not echoed.  */
+	    putc('\n', out);
+	}
+    }
+
+  /* Restore the original setting.  */
+  if (tty_changed) {
+    (void) tcsetattr(fileno(in), TCSAFLUSH|TCSASOFT, &s);
+  }
+
+  if (in != stdin)
+    /* We opened the terminal; now close it.  */
+    fclose(in);
+
+  return buf;
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
