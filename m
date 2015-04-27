From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v2] git-compat-util.h: implement a different ARRAY_SIZE macro for for safely deriving the size of array
Date: Mon, 27 Apr 2015 15:11:09 +0200
Message-ID: <1430140269-11784-1-git-send-email-gitter.spiros@gmail.com>
Cc: gitster@pobox.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 15:11:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymiov-0004wn-4J
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 15:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbbD0NL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 09:11:28 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33045 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbbD0NL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 09:11:27 -0400
Received: by pacwv17 with SMTP id wv17so107007430pac.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mR8PMWBc9FRU2y+Zgqrw1318PIZphIA7zh6dR3mCnss=;
        b=jSMKrF3gZl3sIk1KVjh9UPj/HqXg0tI8dDRv1AEpzI9A2vnPL759l02Utq2ELzaF+0
         jDhrFEWUwDd6CmaG7ayftn5DaFjcpAMF0QmPOfC3ExoCxrVzp/1FlGZ9jvutknQ/7ocm
         ue1+qh158qON23TZwcf41KURMULiGdc+uqzUmsuvBzYM4S9DN9rfuqC4FxfCt6PgSlEW
         b4GrnYDeRRvqsvuWEYuPlkMddc2iaeGI/M29tXDhkReg4j2wDd+dacbBRP9Ks8gaaw1j
         rG5ZVr8fE5mNTcofLqKVzUffORwcbCRHFnPANVrzSOVPQpdBgZYKeOzfnhb0lAHwRhlG
         9Y8A==
X-Received: by 10.70.89.102 with SMTP id bn6mr22428875pdb.48.1430140286903;
        Mon, 27 Apr 2015 06:11:26 -0700 (PDT)
Received: from ubuntu14.nephoscale.com (141.195.207.67.nephoscale.net. [67.207.195.141])
        by mx.google.com with ESMTPSA id sw4sm19358179pbc.64.2015.04.27.06.11.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Apr 2015 06:11:26 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267854>

To get number of elements in an array git use the ARRAY_SIZE macro defined as:

       #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))

The problem with it is a possibility of mistakenly passing to it a
pointer instead an array. The ARRAY_SIZE macro as conventionally
defined does not provide good type-safety and the open-coded approach
is more fragile, more verbose and provides no improvement in type-safety.

Use instead a different but compatible ARRAY_SIZE() macro,
which will also break compile if you try to
use it on a pointer. This implemention revert to the original code if
the compiler doesn't know the typeof and __builtin_types_compatible_p
GCC extensions.

This can ensure our code is robust to changes, without
needing a gratuitous macro or constant. A similar
ARRAY_SIZE implementation also exists in the linux kernel.

Credits to Rusty Russell and his ccan library.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Makefile          |  7 +++++++
 configure.ac      | 24 ++++++++++++++++++++++++
 git-compat-util.h | 36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 1 deletion(-)

This is the second version of this patch. 
It had not been discussed before. In the second version, I just tried to clarify 
the comment in the commit. I resend it just in case you missed

diff --git a/Makefile b/Makefile
index 5f3987f..cb2a044 100644
--- a/Makefile
+++ b/Makefile
@@ -359,6 +359,9 @@ all::
 # compiler is detected to support it.
 #
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
+#
+# Define SUPPORT__BUILTIN_TYPES_COMPATIBLE_P if your compiler support
+# the builtin function __builtin_types_compatible_
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1437,6 +1440,10 @@ ifdef HAVE_BSD_SYSCTL
 	BASIC_CFLAGS += -DHAVE_BSD_SYSCTL
 endif
 
+ifdef SUPPORT__BUILTIN_TYPES_COMPATIBLE_P
+	BASIC_CFLAGS += -DSUPPORT__BUILTIN_TYPES_COMPATIBLE_P
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/configure.ac b/configure.ac
index bbdde85..151864d 100644
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
@@ -910,6 +932,8 @@ else
 fi
 GIT_CONF_SUBST([NEEDS_MODE_TRANSLATION])
 
+GIT_FUNC_TYPES_COMPATIBLE_P
+
 
 ## Checks for library functions.
 ## (in default C library and libraries checked by AC_CHECK_LIB)
diff --git a/git-compat-util.h b/git-compat-util.h
index bc8fc8c..8e9f6c2 100644
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
2.1.0
