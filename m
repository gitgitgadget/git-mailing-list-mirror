From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH 2/3] configure.ac: check for clock_gettime and CLOCK_MONOTONIC
Date: Wed,  7 Jan 2015 12:23:55 -0800
Message-ID: <1420662236-27593-3-git-send-email-reubenhwk@gmail.com>
References: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
 <1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
Cc: Reuben Hawkins <reubenhwk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 21:24:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8x9g-0003GZ-9D
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 21:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbbAGUYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 15:24:32 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:61559 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbbAGUYb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 15:24:31 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so7061615pab.2
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 12:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J/knhOsxF3BlnoZ+jAUz+uC6IXCcNxEML+yvEO8KuEE=;
        b=0sKw1G1Js0HBuizNnyRj4FvwFECYoXg5c3Prv2jXLKY2vI1cOIldCsfP8J7/mJpAFw
         bbx5+WfoRUB0pecoTTKO33vD+Z/IGUVJa+UiZqvUmjf9pCoa56ls4y6LnS0Oe7geoE3q
         wk0dK2Qqbg7mcR0uvyAQa9SfBYHXMOSoNoqT7jVxVwO4s3NURsLLWMSAfcR9+j1iu5PA
         Fubukep4aNtKTv+Z4i0GrM3otnW3uG3ea0DUFs5aJ9JoYKOP7vn19SZjCKokGir26tAO
         LqN2eT4LL61tScq8Uu/CzcEKQ7dmbrct4clxkQzzaIcJzFNx1UE9e+s4xfupvO3jGC+0
         NXiw==
X-Received: by 10.68.69.106 with SMTP id d10mr8713515pbu.60.1420662270295;
        Wed, 07 Jan 2015 12:24:30 -0800 (PST)
Received: from zoidberg.san.rr.com (cpe-76-88-40-245.san.res.rr.com. [76.88.40.245])
        by mx.google.com with ESMTPSA id j15sm2585869pdk.49.2015.01.07.12.24.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Jan 2015 12:24:29 -0800 (PST)
X-Mailer: git-send-email 2.2.0.68.g8f72f0c.dirty
In-Reply-To: <1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262152>

CLOCK_MONOTONIC isn't available on RHEL3, but there are still RHEL3
systems being used in production.  This change makes compiling git
less tedious on older platforms without CLOCK_MONOTONIC.
---
 Makefile         |  4 ++++
 config.mak.uname |  1 +
 configure.ac     | 22 ++++++++++++++++++++++
 trace.c          |  2 +-
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7482a4d..af551a0 100644
--- a/Makefile
+++ b/Makefile
@@ -1382,6 +1382,10 @@ ifdef HAVE_CLOCK_GETTIME
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
index dcc4bf0..424dec5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -923,6 +923,28 @@ AC_CHECK_LIB([iconv], [locale_charset],
                      [CHARSET_LIB=-lcharset])])
 GIT_CONF_SUBST([CHARSET_LIB])
 #
+# Define HAVE_CLOCK_GETTIME=YesPlease if clock_gettime is available.
+GIT_CHECK_FUNC(clock_gettime,
+[HAVE_CLOCK_GETTIME=YesPlease],
+[HAVE_CLOCK_GETTIME=])
+GIT_CONF_SUBST([HAVE_CLOCK_GETTIME])
+
+AC_DEFUN([CLOCK_MONOTONIC_SRC], [
+AC_LANG_PROGRAM([[
+#include <time.h>
+clockid_t id = CLOCK_MONOTONIC;
+]], [])])
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
