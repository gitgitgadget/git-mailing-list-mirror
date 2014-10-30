From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] git-compat-util.h: implement a different ARRAY_SIZE macro for for safely deriving the size of array
Date: Thu, 30 Oct 2014 03:56:12 -0700
Message-ID: <1414666572-4812-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 11:56:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjnOx-0002oK-0w
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 11:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758611AbaJ3K4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 06:56:19 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47028 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758111AbaJ3K4R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 06:56:17 -0400
Received: by mail-pa0-f46.google.com with SMTP id lf10so5239549pab.33
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 03:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EuolaJmVzDHucFokHOpN8QnQeryeRffiP7wicGHC6LY=;
        b=SuiPq4CzRgVvWpxZ6SxNt94837FcamDulJRURvGqmvkYL7OZesSwLffUpWL/WxFoNL
         jWklwd96PMnzA1nyj/oRgxx99n8Z7SZ2STZn9I7nLGV8FCILjkssqk6pBTalnyTCrODn
         LYAuGm4aON9Xfs4Mow5BlMEBZqy93vte5oczBxKdAeelKiEHT2ctjkWQdtUs8bcef8lX
         vtZ/pSm1Hfe94PWcYKHpopvyegYSySN5LLW2qgebm92kum7ujUoKZwPdqK7R9Puc+vo1
         ZeVX6gG/vGDBdtBwRDKZefBEI7d2wiS4tu5LZrlUGVxxsaDns3HTKAol0TMgy98r6WBS
         SEAg==
X-Received: by 10.70.118.165 with SMTP id kn5mr14069680pdb.140.1414666577249;
        Thu, 30 Oct 2014 03:56:17 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id dx10sm6829700pab.38.2014.10.30.03.56.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 Oct 2014 03:56:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To get number of elements in an array git use the ARRAY_SIZE macro defined as:

#define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))

The problem with it is a possibility of mistakenly passing to it a
pointer instead an array.

Use instead a different but compatible ARRAY_SIZE() macro,
which (given a good compiler) will also break compile if you try to
use it on a pointer.

This can ensure your code is robust to changes, without
needing a gratuitous macro or constant. A similar
ARRAY_SIZE implementation also exists in the linux kernel.

Credits to Rusty Russell and his ccan library.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Makefile          |    7 +++++++
 configure.ac      |   24 ++++++++++++++++++++++++
 git-compat-util.h |   36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 827006b..37eb1e1 100644
--- a/Makefile
+++ b/Makefile
@@ -339,6 +339,9 @@ all::
 # return NULL when it receives a bogus time_t.
 #
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime in librt.
+#
+# Define SUPPORT__BUILTIN_TYPES_COMPATIBLE_P if your compiler support 
+# the builtin function __builtin_types_compatible_
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1382,6 +1385,10 @@ ifdef HAVE_CLOCK_GETTIME
 	EXTLIBS += -lrt
 endif
 
+ifdef SUPPORT__BUILTIN_TYPES_COMPATIBLE_P
+	BASIC_CFLAGS += -DSUPPORT__BUILTIN_TYPES_COMPATIBLE_P
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/configure.ac b/configure.ac
index 6af9647..9d489c1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -139,6 +139,28 @@ if test -n "$1"; then
 fi
 ])
 
+AC_DEFUN([GIT_FUNC_TYPES_COMPATIBLE_P], [
+	AC_CACHE_CHECK([if compiler has __builtin_types_compatible_p function],
+		[cc_cv_func_types_compatible_p],
+		[ac_save_CFLAGS="$CFLAGS"
+		CFLAGS="$CFLAGS -Werror"
+		AC_COMPILE_IFELSE([AC_LANG_SOURCE(
+			[int some_function();
+			int some_function() {
+			return __builtin_types_compatible_p(char *, int) ? 1 : 0;
+			}])],
+			[cc_cv_func_types_compatible_p=yes],
+			[cc_cv_func_types_compatible_p=no])
+		CFLAGS="$ac_save_CFLAGS"
+	])
+
+	AS_IF([test "x$cc_cv_func_types_compatible_p" = "xyes"],
+		[GIT_CONF_SUBST([SUPPORT__BUILTIN_TYPES_COMPATIBLE_P], [YesPlease])],
+		[$2])
+])
+
+
+
 ## Configure body starts here.
 
 AC_PREREQ(2.59)
@@ -874,6 +896,8 @@ else
 fi
 GIT_CONF_SUBST([SNPRINTF_RETURNS_BOGUS])
 
+GIT_FUNC_TYPES_COMPATIBLE_P
+
 
 ## Checks for library functions.
 ## (in default C library and libraries checked by AC_CHECK_LIB)
diff --git a/git-compat-util.h b/git-compat-util.h
index 400e921..cb45886 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -25,7 +25,41 @@
 #endif
 #endif
 
-#define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
+
+/*
+ * BUILD_ASSERT_OR_ZERO - assert a build-time dependency, as an expression.
+ * @cond: the compile-time condition which must be true.
+ *
+ * Your compile will fail if the condition isn't true, or can't be evaluated
+ * by the compiler.  This can be used in an expression: its value is "0".
+ *
+ * Example:
+ *	#define foo_to_char(foo)					\
+ *		 ((char *)(foo)						\
+ *		  + BUILD_ASSERT_OR_ZERO(offsetof(struct foo, string) == 0))
+ */
+#define BUILD_ASSERT_OR_ZERO(cond) \
+	(sizeof(char [1 - 2*!(cond)]) - 1)
+
+
+#if SUPPORT__BUILTIN_TYPES_COMPATIBLE_P
+/* &arr[0] degrades to a pointer: a different type from an array */
+#define _array_size_chk(arr)						\
+	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(typeof(arr), \
+							typeof(&(arr)[0])))
+#else
+#define _array_size_chk(arr) 0
+#endif
+
+/*
+ * ARRAY_SIZE - get the number of elements in a visible array
+ *  <at> x: the array whose size you want.
+ *
+ * This does not work on pointers, or arrays declared as [], or
+ * function parameters.  With correct compiler support, such usage
+ * will cause a build error (see build_assert).
+ */
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]) + _array_size_chk(x))
 #define bitsizeof(x)  (CHAR_BIT * sizeof(x))
 
 #define maximum_signed_value_of_type(a) \
-- 
1.7.10.4
