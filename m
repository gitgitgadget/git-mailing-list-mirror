From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 1/2] configure.ac: add new autoconf macro for checking valid compiler flags
Date: Mon,  3 Nov 2014 06:57:20 -0800
Message-ID: <1415026641-24767-2-git-send-email-gitter.spiros@gmail.com>
References: <1415026641-24767-1-git-send-email-gitter.spiros@gmail.com>
Cc: jnareb@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 15:57:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlJ4q-0004EQ-IR
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 15:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbaKCO5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 09:57:48 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34011 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbaKCO5h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 09:57:37 -0500
Received: by mail-pd0-f179.google.com with SMTP id g10so11524580pdj.24
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 06:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QDRAqYyM3Wp22zZm3BiXMpjrvp/L3gV+408wWY08+QA=;
        b=pJUEwmR7C1OrPsQCn0y7nk+ZyekRyGRiU7YW9r8b+brw5+iRBGUB8caEu0DLq4pwG9
         aNE4D6LqF4vEvaZ2nhqh8i/Mo0exA2MPkd86yqnYSKGRuVYA1RKWWPNJulk5NVHLKTon
         RUmTI1gagaFu19pmkudPBZ+ZhzInZ0XWAThyYT64SW9B1U1nBF5GdZLlu5iuLIO3Bppo
         pFaQtopz31zry2lw6wKbxrx64XVXsm/ZsffRvPl+bUYacYtApI0dIlKDDhykUa8+QhQE
         2fcHHVKi9R5MIlG7vZfBFjTF392nSTTqrwdSyR6ZqloHiS3wpeql+4uljW4uvyTdKYwK
         988Q==
X-Received: by 10.66.172.207 with SMTP id be15mr20070826pac.81.1415026657322;
        Mon, 03 Nov 2014 06:57:37 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id ri9sm17409373pbc.5.2014.11.03.06.57.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 06:57:36 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1415026641-24767-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add GIT_CC_CHECK_FLAG_APPEND, GIT_CC_CHECK_FLAGS_APPEND
and GIT_CC_CHECK_LDFLAGS autoconf macro.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Makefile     |    6 ++++--
 configure.ac |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 827006b..23485f1 100644
--- a/Makefile
+++ b/Makefile
@@ -344,10 +344,12 @@ GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
+GIT_CFLAGS  =
+GIT_LDFLAGS =
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -g -O2 -Wall
-LDFLAGS =
+CFLAGS = -g -O2 -Wall $(GIT_CFLAGS)
+LDFLAGS = $(GIT_LDFLAGS)
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
diff --git a/configure.ac b/configure.ac
index 6af9647..c67ca60 100644
--- a/configure.ac
+++ b/configure.ac
@@ -139,6 +139,51 @@ if test -n "$1"; then
 fi
 ])
 
+
+dnl Check if FLAG in ENV-VAR is supported by compiler and append it
+dnl to WHERE-TO-APPEND variable
+dnl GIT_CC_CHECK_FLAG_APPEND([WHERE-TO-APPEND], [ENV-VAR], [FLAG])
+
+AC_DEFUN([GIT_CC_CHECK_FLAG_APPEND], [
+  AC_CACHE_CHECK([if $CC supports flag $3 in envvar $2],
+                 AS_TR_SH([cc_cv_$2_$3]),
+          [eval "AS_TR_SH([cc_save_$2])='${$2}'"
+           eval "AS_TR_SH([$2])='-Werror $3'"
+           AC_LINK_IFELSE([AC_LANG_SOURCE([int a = 0; int main(void) { return a; } ])],
+                          [eval "AS_TR_SH([cc_cv_$2_$3])='yes'"],
+                          [eval "AS_TR_SH([cc_cv_$2_$3])='no'"])
+           eval "AS_TR_SH([$2])='$cc_save_$2'"])
+
+  AS_IF([eval test x$]AS_TR_SH([cc_cv_$2_$3])[ = xyes],
+        [eval "$1='${$1} $3'"])
+])
+
+dnl GIT_CC_CHECK_FLAGS_APPEND([WHERE-TO-APPEND], [ENV-VAR], [FLAG1 FLAG2])
+AC_DEFUN([GIT_CC_CHECK_FLAGS_APPEND], [
+  for flag in $3; do
+    GIT_CC_CHECK_FLAG_APPEND($1, $2, $flag)
+  done
+])
+
+dnl Check if the flag is supported by linker (cacheable)
+dnl GIT_CC_CHECK_LDFLAGS([FLAG], [ACTION-IF-FOUND],[ACTION-IF-NOT-FOUND])
+
+AC_DEFUN([GIT_CC_CHECK_LDFLAGS], [
+  AC_CACHE_CHECK([if $CC supports $1 flag],
+    AS_TR_SH([cc_cv_ldflags_$1]),
+    [ac_save_LDFLAGS="$LDFLAGS"
+     LDFLAGS="$LDFLAGS $1"
+     AC_LINK_IFELSE([int main() { return 1; }],
+       [eval "AS_TR_SH([cc_cv_ldflags_$1])='yes'"],
+       [eval "AS_TR_SH([cc_cv_ldflags_$1])="])
+     LDFLAGS="$ac_save_LDFLAGS"
+    ])
+
+  AS_IF([eval test x$]AS_TR_SH([cc_cv_ldflags_$1])[ = xyes],
+    [$2], [$3])
+])
+
+
 ## Configure body starts here.
 
 AC_PREREQ(2.59)
-- 
1.7.10.4
