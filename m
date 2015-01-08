From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH 2/3] configure.ac: check for clock_gettime and CLOCK_MONOTONIC
Date: Thu,  8 Jan 2015 12:00:56 -0800
Message-ID: <1420747257-16132-2-git-send-email-reubenhwk@gmail.com>
References: <1420747257-16132-1-git-send-email-reubenhwk@gmail.com>
Cc: Reuben Hawkins <reubenhwk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 21:02:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9JHM-0001oe-2Y
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 21:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbbAHUBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 15:01:39 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:49229 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174AbbAHUBa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 15:01:30 -0500
Received: by mail-pd0-f175.google.com with SMTP id g10so13045688pdj.6
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 12:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iVb5SnPzeIvN8ddje1YCEnWQlIn9OwcK5LaZf+drloE=;
        b=aH4Sc8oaDThCUsdKTpe1rts88Ygpq2aubeYZs2xtN8yc2Ml4xdAYAVn77Wfr8bGfQo
         nyhugOgDd7qj+ZPT5T4sAddOduzGcQcRQ7NHZovQzZwpJDOpo+Le0x541h1YYjwZ1tiN
         PZmGd9qC70LGx7MVndXOM9IAgv+arxSJ4Hw2erIzRW1P0vo78WGxOELnJurO161PF4K1
         RUVdXOuGpdV0BlxnoGhFAsN13njKTq13U+xJOkZUg47A8aGmp53jb+E7HnS7tDuXnp5y
         Vy0Godb8cL1wr90Qe9qqaQlHfOojfePSptJ2GMq5QAoaaf2IIWFDP4eHMb1ut/g6+JuF
         EFnA==
X-Received: by 10.66.253.197 with SMTP id ac5mr17534912pad.152.1420747289393;
        Thu, 08 Jan 2015 12:01:29 -0800 (PST)
Received: from zoidberg.san.rr.com (cpe-76-88-40-245.san.res.rr.com. [76.88.40.245])
        by mx.google.com with ESMTPSA id do3sm5248879pac.48.2015.01.08.12.01.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jan 2015 12:01:28 -0800 (PST)
X-Mailer: git-send-email 2.2.0.68.g8f72f0c.dirty
In-Reply-To: <1420747257-16132-1-git-send-email-reubenhwk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262217>

The checks will override and unset YesPlease settings for HAVE_CLOCK_GETTIME
and HAVE_CLOCK_MONOTONIC in config.mak.uname.

CLOCK_MONOTONIC isn't available on RHEL3, but there are still RHEL3 systems
being used in production.

Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
---
 Makefile         |  6 ++++++
 config.mak.uname |  1 +
 configure.ac     | 22 ++++++++++++++++++++++
 trace.c          |  2 +-
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7482a4d..57e33f2 100644
--- a/Makefile
+++ b/Makefile
@@ -339,6 +339,8 @@ all::
 # return NULL when it receives a bogus time_t.
 #
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime in librt.
+#
+# Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC in librt.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1382,6 +1384,10 @@ ifdef HAVE_CLOCK_GETTIME
 	EXTLIBS += -lrt
 endif
 
+ifdef HAVE_CLOCK_MONOTONIC
+	BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/config.mak.uname b/config.mak.uname
index a2f380f..926773e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -35,6 +35,7 @@ ifeq ($(uname_S),Linux)
 	LIBC_CONTAINS_LIBINTL = YesPlease
 	HAVE_DEV_TTY = YesPlease
 	HAVE_CLOCK_GETTIME = YesPlease
+	HAVE_CLOCK_MONOTONIC = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/configure.ac b/configure.ac
index 210eb4e..c3293b9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -924,6 +924,28 @@ AC_CHECK_LIB([iconv], [locale_charset],
                      [CHARSET_LIB=-lcharset])])
 GIT_CONF_SUBST([CHARSET_LIB])
 #
+# Define HAVE_CLOCK_GETTIME=YesPlease if clock_gettime is available.
+GIT_CHECK_FUNC(clock_gettime,
+	[HAVE_CLOCK_GETTIME=YesPlease],
+	[HAVE_CLOCK_GETTIME=])
+GIT_CONF_SUBST([HAVE_CLOCK_GETTIME])
+
+AC_DEFUN([CLOCK_MONOTONIC_SRC], [
+AC_LANG_PROGRAM([[
+#include <time.h>
+clockid_t id = CLOCK_MONOTONIC;
+]])])
+
+#
+# Define HAVE_CLOCK_MONOTONIC=YesPlease if CLOCK_MONOTONIC is available.
+AC_MSG_CHECKING([for CLOCK_MONOTONIC])
+AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
+	[AC_MSG_RESULT([yes])
+	HAVE_CLOCK_MONOTONIC=YesPlease],
+	[AC_MSG_RESULT([no])
+	HAVE_CLOCK_MONOTONIC=])
+GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])
+#
 # Define NO_SETITIMER if you don't have setitimer.
 GIT_CHECK_FUNC(setitimer,
 [NO_SETITIMER=],
diff --git a/trace.c b/trace.c
index 4778608..bfbd48f 100644
--- a/trace.c
+++ b/trace.c
@@ -324,7 +324,7 @@ int trace_want(struct trace_key *key)
 	return !!get_trace_fd(key);
 }
 
-#ifdef HAVE_CLOCK_GETTIME
+#if defined(HAVE_CLOCK_GETTIME) && defined(HAVE_CLOCK_MONOTONIC)
 
 static inline uint64_t highres_nanos(void)
 {
-- 
2.2.0.68.g8f72f0c.dirty
