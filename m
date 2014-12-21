From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH 2/3] configure.ac,trace.c: check for CLOCK_MONOTONIC
Date: Sun, 21 Dec 2014 10:53:35 -0800
Message-ID: <1419188016-26134-2-git-send-email-reubenhwk@gmail.com>
References: <1419188016-26134-1-git-send-email-reubenhwk@gmail.com>
Cc: Reuben Hawkins <reubenhwk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 19:54:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2ldy-0001mW-DY
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 19:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbaLUSyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 13:54:15 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:47796 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbaLUSyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 13:54:13 -0500
Received: by mail-pd0-f174.google.com with SMTP id fp1so4455082pdb.33
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ikjoMMcOcW3NInayfipLdgqZ1eEyAGpcyWGsa0GcQgc=;
        b=qI1/RrEJF4BFQCfBdpFV3is6iJ0J8KZsYoPL3vt9wrtF7qWPvbBQwGj3WIf1a9JsxA
         aHoLnDwST4M+Xub1p6Tb92Ucb9inUoWI2Cb5RCKIXuMNYFf9i4q1UGTXc0+AQdVRZPTG
         Jwh3K24TE70FirTGgrbSp1jBBGfStPjW3r3lMLIW0SwMrYesLxfsFb5eW+oqtZcX4T+f
         1fmdd7AJJQE7BLtA8wuf6iJJG62aU5myAAQwAyqTFa02EThHKYIUJoAS/+FYIwxY7aZs
         wALDWIxYe4rbDYUGyQtLsgFP0KgKkSW7EugTtLESnLGM8D3Or5tenCSol86UVXd0YHBo
         KVhQ==
X-Received: by 10.66.236.36 with SMTP id ur4mr28644057pac.107.1419188053210;
        Sun, 21 Dec 2014 10:54:13 -0800 (PST)
Received: from zoidberg.san.rr.com (cpe-76-88-40-245.san.res.rr.com. [76.88.40.245])
        by mx.google.com with ESMTPSA id cm10sm15263211pad.46.2014.12.21.10.54.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Dec 2014 10:54:12 -0800 (PST)
X-Mailer: git-send-email 2.2.0.GIT
In-Reply-To: <1419188016-26134-1-git-send-email-reubenhwk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261621>

CLOCK_MONOTONIC isn't available on RHEL3, but there are still RHEL3
systems being used in production.  This change makes compiling git
less tedious on older platforms.
---
 configure.ac | 26 ++++++++++++++++++++++++++
 trace.c      |  2 +-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 3cfdd51..3900044 100644
--- a/configure.ac
+++ b/configure.ac
@@ -736,8 +736,10 @@ GIT_UNSTASH_FLAGS($ICONVDIR)
 
 GIT_CONF_SUBST([OLD_ICONV])
 
+
 ## Checks for typedefs, structures, and compiler characteristics.
 AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
+
 #
 TYPE_SOCKLEN_T
 case $ac_cv_type_socklen_t in
@@ -930,6 +932,30 @@ AC_CHECK_LIB([iconv], [locale_charset],
                      [CHARSET_LIB=-lcharset])])
 GIT_CONF_SUBST([CHARSET_LIB])
 #
+# Define NO_CLOCK_GETTIME if you don't have clock_gettime.
+GIT_CHECK_FUNC(clock_gettime,
+[HAVE_CLOCK_GETTIME=Yes],
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
+# Define NO_CLOCK_MONOTONIC on really old systems that are still in production
+# if you need GIT to compile but can't update the machine otherwise.
+AC_MSG_CHECKING([for CLOCK_MONOTONIC])
+AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
+	[AC_MSG_RESULT([yes])
+	HAVE_CLOCK_MONOTONIC=Yes],
+	[AC_MSG_RESULT([no])
+	HAVE_CLOCK_MONOTONIC=])
+
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
2.2.0.GIT
