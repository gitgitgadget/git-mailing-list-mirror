From: Benoit Sigoure <tsunanet@gmail.com>
Subject: [PATCH] Fix compilation on OS X.
Date: Sat, 20 Jul 2013 11:41:31 -0700
Message-ID: <1374345691-21834-1-git-send-email-tsunanet@gmail.com>
References: <51EA7D58.3050800@web.de>
Cc: Benoit Sigoure <tsunanet@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 20:42:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0c6r-0001EE-ID
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 20:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743Ab3GTSmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 14:42:21 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:58516 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723Ab3GTSmU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 14:42:20 -0400
Received: by mail-ee0-f52.google.com with SMTP id c50so3047573eek.11
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zIDZg04GXCF07F/nZeTwLmrDnoGpntltirxCvDlbrqo=;
        b=y+1KSiptUwZUyD6A7dN7ghZVw8jp6AZy9uC9bOYN7dGK1MJ/nLysJfS/9q/C/mbPGq
         y4TyUWKR+DkhpfGnI+nzrgV6w/zxbqb/u3DYmmMC8GYLnSoQ5uVGkEAs2AmgPmEHUM2r
         ErjBT90rOtJBok04CBrmCfScOGghkVO2DraQ2ILt5vV6CaBR4K341NiciHvJ/SjGtqip
         liK+TvFxFy2WFrLp8HcAHxa/u5fcu5+vfiXJba3CxbVy18xqkjgJ8NxBCFauiTFQ98tH
         USu+7t2MslzgLN3VG6qgsxKHW+pzQjUKL5Ay69abyEmoyhx+MR4MMnErYscXZwIui03r
         MHoA==
X-Received: by 10.14.9.70 with SMTP id 46mr12733657ees.44.1374345739659;
        Sat, 20 Jul 2013 11:42:19 -0700 (PDT)
Received: from magrathea.tsunanet.net (magrathea.tsunanet.net. [142.4.212.106])
        by mx.google.com with ESMTPSA id a4sm37278465eez.0.2013.07.20.11.42.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 11:42:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <51EA7D58.3050800@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230900>

On OS X libc headers don't define `environ', and since ec535cc2 removed
the redundant declaration this code no longer builds on OS X.
---
 Makefile          | 5 +++++
 config.mak.uname  | 1 +
 git-compat-util.h | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index 0600eb4..774db18 100644
--- a/Makefile
+++ b/Makefile
@@ -98,6 +98,8 @@ all::
 #
 # Define NO_UNSETENV if you don't have unsetenv in the C library.
 #
+# Define NO_EXT_ENVIRON if your C library doesn't define `environ'.
+#
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
 #
 # Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with trailing slash.
@@ -1307,6 +1309,9 @@ ifdef NO_UNSETENV
 	COMPAT_CFLAGS += -DNO_UNSETENV
 	COMPAT_OBJS += compat/unsetenv.o
 endif
+ifdef NO_EXT_ENVIRON
+	COMPAT_CFLAGS += -DNO_EXT_ENVIRON
+endif
 ifdef NO_SYS_SELECT_H
 	BASIC_CFLAGS += -DNO_SYS_SELECT_H
 endif
diff --git a/config.mak.uname b/config.mak.uname
index 7ac541e..ebcfbfd 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -93,6 +93,7 @@ ifeq ($(uname_S),Darwin)
 		NO_STRLCPY = YesPlease
 	endif
 	NO_MEMMEM = YesPlease
+        NO_EXT_ENVIRON = UnfortunatelyYes
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
 	NEEDS_CLIPPED_WRITE = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index ff193f4..3bac4e9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -408,6 +408,10 @@ extern ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
  */
 extern ssize_t read_in_full(int fd, void *buf, size_t count);
 
+#ifdef NO_EXT_ENVIRON
+extern char **environ;
+#endif
+
 #ifdef NO_SETENV
 #define setenv gitsetenv
 extern int gitsetenv(const char *, const char *, int);
-- 
1.8.2.1.539.g4196a96
