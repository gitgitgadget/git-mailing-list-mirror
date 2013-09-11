From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v2] configure.ac: move the private git m4 macros to a dedicated directory
Date: Wed, 11 Sep 2013 08:46:57 -0700
Message-ID: <1378914417-32605-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 17:47:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJmdP-0006zR-Sw
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 17:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367Ab3IKPrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 11:47:09 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:60898 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab3IKPrI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 11:47:08 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so7369517lab.8
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/1mbqyJIp9nsRK4fK0em7JuH/sWyo0ym7sGO7c35rSw=;
        b=qrI1huGe20nPwCDy0VWcqOcjZTwClEjuLcCKqbx/a0e/hbvnj5dFaOJIM9EazuGL9X
         CnwojP7iIz63aSXvIMH2NKiSS3nqGFDMKAnneWspLRJotLhsT1ezWv+bfkCdaAD8AMM9
         zVfEa2MZafXTrjFx4136uaf85TSMl2oI2Qk6EV7C2+zgUuywEa2CFiqpWQMFs2X6c9N2
         ZD2Nzdskqphrap8eMt4OSDTOSzh463cnT3v1b8/uMhRFAfyKYU4APLZJR7jj49CQKK10
         kadZ6bY6KjGYaaTE1trG0ftWzrvzpUzt5WMUADV6c3oMUZZLbqC1TsheXIueVlpNB+Go
         //Vg==
X-Received: by 10.112.52.225 with SMTP id w1mr2390917lbo.31.1378914426547;
        Wed, 11 Sep 2013 08:47:06 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id zw2sm1673212lbb.14.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Sep 2013 08:47:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234568>

Git use, as many project that use autoconf, private m4 macros.

When not using automake, and just relying on autoconf, the macro
files are not picked up by default.

A possibility, as git do today, is to put the private m4 macro
in the configure.ac file, so they will copied over the final configure
when calling autoreconf(that call also autoconf).
But this makes configure.ac difficult to read and maintain,
especially if you want to introduce new macros later. By separating
the definitions of the macros from configure.ac file the build system
would be more modular.

Starting from version 2.58, autoconf provide the macro AC_CONFIG_MACRO_DIR
to declare where additional macro files are to be put and found by aclocal.
The argument passed to this macro is commonly m4. Despite the documentation,
autoconf do nothing with it, only aclocal can use directly if invoked by
-I m4 or indirectly using automake. But autoreconf don't invoke aclocal
in this way. So in summary you can not use this macro in a useful
way if you only use autoconf, as git does.

Another historical possibility is to list all your macros in acinclude.m4.
This file will be included in aclocal.m4 when you run aclocal, and its macro(s)
will henceforth be visible to autoconf. However if it contains numerous macros,
it will rapidly become difficult to maintain, and for git this don't provide
any benefits or very little.

The actual autotool documentation recommend to write each
macro in its own file and gather all these files in a separate directory.

Given the limitations i mentioned earlier, the only possibility is to use the m4_include
for including every macro file. The m4_include directive works quite like the
#include directive of the C programming language, and simply copies over the content
of the file(s).

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is a second version of this patch http://article.gmane.org/gmane.comp.version-control.git/231984.
The first was plain wrong, my bad. I am sorry for the long delay. 
Sure it is something low-hanging fruit


 configure.ac                      |  148 +++----------------------------------
 m4/git_arg_set_path.m4            |   14 ++++
 m4/git_check_func.m4              |   13 ++++
 m4/git_conf_append_path.m4        |   30 ++++++++
 m4/git_conf_subst.m4              |   10 +++
 m4/git_conf_subst_init.m4         |   15 ++++
 m4/git_parse_with.m4              |   22 ++++++
 m4/git_parse_with_set_make_var.m4 |   20 +++++
 m4/git_stash_flags.m4             |   15 ++++
 m4/git_unstash_flags.m4           |   13 ++++
 10 files changed, 162 insertions(+), 138 deletions(-)
 create mode 100644 m4/git_arg_set_path.m4
 create mode 100644 m4/git_check_func.m4
 create mode 100644 m4/git_conf_append_path.m4
 create mode 100644 m4/git_conf_subst.m4
 create mode 100644 m4/git_conf_subst_init.m4
 create mode 100644 m4/git_parse_with.m4
 create mode 100644 m4/git_parse_with_set_make_var.m4
 create mode 100644 m4/git_stash_flags.m4
 create mode 100644 m4/git_unstash_flags.m4

diff --git a/configure.ac b/configure.ac
index 2f43393..81a876f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,144 +1,6 @@
 #                                               -*- Autoconf -*-
 # Process this file with autoconf to produce a configure script.
 
-## Definitions of private macros.
-
-# GIT_CONF_SUBST(VAL, VAR)
-# ------------------------
-# Cause the line "VAR=VAL" to be eventually appended to ${config_file}.
-AC_DEFUN([GIT_CONF_SUBST],
-[AC_REQUIRE([GIT_CONF_SUBST_INIT])
-config_appended_defs="$config_appended_defs${newline}dnl
-$1=m4_if([$#],[1],[${$1}],[$2])"])
-
-# GIT_CONF_SUBST_INIT
-# -------------------
-# Prepare shell variables and autoconf machine required by later calls
-# to GIT_CONF_SUBST.
-AC_DEFUN([GIT_CONF_SUBST_INIT],
-    [config_appended_defs=; newline='
-'
-    AC_CONFIG_COMMANDS([$config_file],
-                       [echo "$config_appended_defs" >> "$config_file"],
-                       [config_file=$config_file
-                        config_appended_defs="$config_appended_defs"])])
-
-# GIT_ARG_SET_PATH(PROGRAM)
-# -------------------------
-# Provide --with-PROGRAM=PATH option to set PATH to PROGRAM
-# Optional second argument allows setting NO_PROGRAM=YesPlease if
-# --without-PROGRAM version used.
-AC_DEFUN([GIT_ARG_SET_PATH],
-    [AC_ARG_WITH([$1],
-        [AS_HELP_STRING([--with-$1=PATH],
-                        [provide PATH to $1])],
-        [GIT_CONF_APPEND_PATH([$1], [$2])],
-        [])])
-
-# GIT_CONF_APPEND_PATH(PROGRAM)
-# -----------------------------
-# Parse --with-PROGRAM=PATH option to set PROGRAM_PATH=PATH
-# Used by GIT_ARG_SET_PATH(PROGRAM)
-# Optional second argument allows setting NO_PROGRAM=YesPlease if
-# --without-PROGRAM is used.
-AC_DEFUN([GIT_CONF_APPEND_PATH],
-    [m4_pushdef([GIT_UC_PROGRAM], m4_toupper([$1]))dnl
-    if test "$withval" = "no"; then
-	if test -n "$2"; then
-		GIT_UC_PROGRAM[]_PATH=$withval
-		AC_MSG_NOTICE([Disabling use of GIT_UC_PROGRAM])
-		GIT_CONF_SUBST([NO_]GIT_UC_PROGRAM, [YesPlease])
-		GIT_CONF_SUBST(GIT_UC_PROGRAM[]_PATH, [])
-	else
-		AC_MSG_ERROR([You cannot use git without $1])
-	fi
-    else
-	if test "$withval" = "yes"; then
-		AC_MSG_WARN([You should provide path for --with-$1=PATH])
-	else
-		GIT_UC_PROGRAM[]_PATH=$withval
-		AC_MSG_NOTICE([Setting GIT_UC_PROGRAM[]_PATH to $withval])
-		GIT_CONF_SUBST(GIT_UC_PROGRAM[]_PATH, [$withval])
-	fi
-    fi
-    m4_popdef([GIT_UC_PROGRAM])])
-
-# GIT_PARSE_WITH(PACKAGE)
-# -----------------------
-# For use in AC_ARG_WITH action-if-found, for packages default ON.
-# * Set NO_PACKAGE=YesPlease for --without-PACKAGE
-# * Set PACKAGEDIR=PATH for --with-PACKAGE=PATH
-# * Unset NO_PACKAGE for --with-PACKAGE without ARG
-AC_DEFUN([GIT_PARSE_WITH],
-    [m4_pushdef([GIT_UC_PACKAGE], m4_toupper([$1]))dnl
-    if test "$withval" = "no"; then
-	NO_[]GIT_UC_PACKAGE=YesPlease
-    elif test "$withval" = "yes"; then
-	NO_[]GIT_UC_PACKAGE=
-    else
-	NO_[]GIT_UC_PACKAGE=
-	GIT_UC_PACKAGE[]DIR=$withval
-	AC_MSG_NOTICE([Setting GIT_UC_PACKAGE[]DIR to $withval])
-	GIT_CONF_SUBST(GIT_UC_PACKAGE[DIR], [$withval])
-    fi
-    m4_popdef([GIT_UC_PACKAGE])])
-
-# GIT_PARSE_WITH_SET_MAKE_VAR(WITHNAME, VAR, HELP_TEXT)
-# -----------------------------------------------------
-# Set VAR to the value specied by --with-WITHNAME.
-# No verification of arguments is performed, but warnings are issued
-# if either 'yes' or 'no' is specified.
-# HELP_TEXT is presented when --help is called.
-# This is a direct way to allow setting variables in the Makefile.
-AC_DEFUN([GIT_PARSE_WITH_SET_MAKE_VAR],
-[AC_ARG_WITH([$1],
- [AS_HELP_STRING([--with-$1=VALUE], $3)],
- if test -n "$withval"; then
-  if test "$withval" = "yes" -o "$withval" = "no"; then
-    AC_MSG_WARN([You likely do not want either 'yes' or 'no' as]
-		     [a value for $1 ($2).  Maybe you do...?])
-  fi
-  AC_MSG_NOTICE([Setting $2 to $withval])
-  GIT_CONF_SUBST([$2], [$withval])
- fi)])# GIT_PARSE_WITH_SET_MAKE_VAR
-
-#
-# GIT_CHECK_FUNC(FUNCTION, IFTRUE, IFFALSE)
-# -----------------------------------------
-# Similar to AC_CHECK_FUNC, but on systems that do not generate
-# warnings for missing prototypes (e.g. FreeBSD when compiling without
-# -Wall), it does not work.  By looking for function definition in
-# libraries, this problem can be worked around.
-AC_DEFUN([GIT_CHECK_FUNC],[AC_CHECK_FUNC([$1],[
-  AC_SEARCH_LIBS([$1],,
-  [$2],[$3])
-],[$3])])
-
-#
-# GIT_STASH_FLAGS(BASEPATH_VAR)
-# -----------------------------
-# Allow for easy stashing of LDFLAGS and CPPFLAGS before running
-# tests that may want to take user settings into account.
-AC_DEFUN([GIT_STASH_FLAGS],[
-if test -n "$1"; then
-   old_CPPFLAGS="$CPPFLAGS"
-   old_LDFLAGS="$LDFLAGS"
-   CPPFLAGS="-I$1/include $CPPFLAGS"
-   LDFLAGS="-L$1/$lib $LDFLAGS"
-fi
-])
-
-dnl
-dnl GIT_UNSTASH_FLAGS(BASEPATH_VAR)
-dnl -----------------------------
-dnl Restore the stashed *FLAGS values.
-AC_DEFUN([GIT_UNSTASH_FLAGS],[
-if test -n "$1"; then
-   CPPFLAGS="$old_CPPFLAGS"
-   LDFLAGS="$old_LDFLAGS"
-fi
-])
-
 ## Configure body starts here.
 
 AC_PREREQ(2.59)
@@ -146,6 +8,16 @@ AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
 
 AC_CONFIG_SRCDIR([git.c])
 
+m4_include([m4/git_arg_set_path.m4])
+m4_include([m4/git_check_func.m4])
+m4_include([m4/git_conf_append_path.m4])
+m4_include([m4/git_conf_subst_init.m4])
+m4_include([m4/git_conf_subst.m4])
+m4_include([m4/git_parse_with.m4])
+m4_include([m4/git_parse_with_set_make_var.m4])
+m4_include([m4/git_stash_flags.m4])
+m4_include([m4/git_unstash_flags.m4])
+
 config_file=config.mak.autogen
 config_in=config.mak.in
 
diff --git a/m4/git_arg_set_path.m4 b/m4/git_arg_set_path.m4
new file mode 100644
index 0000000..112a52f
--- /dev/null
+++ b/m4/git_arg_set_path.m4
@@ -0,0 +1,14 @@
+
+## Definitions of git private macro.
+
+# GIT_ARG_SET_PATH(PROGRAM)
+# -------------------------
+# Provide --with-PROGRAM=PATH option to set PATH to PROGRAM
+# Optional second argument allows setting NO_PROGRAM=YesPlease if
+# --without-PROGRAM version used.
+AC_DEFUN([GIT_ARG_SET_PATH],
+    [AC_ARG_WITH([$1],
+        [AS_HELP_STRING([--with-$1=PATH],
+                        [provide PATH to $1])],
+        [GIT_CONF_APPEND_PATH([$1], [$2])],
+        [])])
diff --git a/m4/git_check_func.m4 b/m4/git_check_func.m4
new file mode 100644
index 0000000..7ea71d8
--- /dev/null
+++ b/m4/git_check_func.m4
@@ -0,0 +1,13 @@
+## Definitions of git private macro.
+
+#
+# GIT_CHECK_FUNC(FUNCTION, IFTRUE, IFFALSE)
+# -----------------------------------------
+# Similar to AC_CHECK_FUNC, but on systems that do not generate
+# warnings for missing prototypes (e.g. FreeBSD when compiling without
+# -Wall), it does not work.  By looking for function definition in
+# libraries, this problem can be worked around.
+AC_DEFUN([GIT_CHECK_FUNC],[AC_CHECK_FUNC([$1],[
+  AC_SEARCH_LIBS([$1],,
+  [$2],[$3])
+],[$3])])
diff --git a/m4/git_conf_append_path.m4 b/m4/git_conf_append_path.m4
new file mode 100644
index 0000000..e9e3cc8
--- /dev/null
+++ b/m4/git_conf_append_path.m4
@@ -0,0 +1,30 @@
+
+## Definitions of git private macro.
+
+# GIT_CONF_APPEND_PATH(PROGRAM)
+# -----------------------------
+# Parse --with-PROGRAM=PATH option to set PROGRAM_PATH=PATH
+# Used by GIT_ARG_SET_PATH(PROGRAM)
+# Optional second argument allows setting NO_PROGRAM=YesPlease if
+# --without-PROGRAM is used.
+AC_DEFUN([GIT_CONF_APPEND_PATH],
+    [m4_pushdef([GIT_UC_PROGRAM], m4_toupper([$1]))dnl
+    if test "$withval" = "no"; then
+	if test -n "$2"; then
+		GIT_UC_PROGRAM[]_PATH=$withval
+		AC_MSG_NOTICE([Disabling use of GIT_UC_PROGRAM])
+		GIT_CONF_SUBST([NO_]GIT_UC_PROGRAM, [YesPlease])
+		GIT_CONF_SUBST(GIT_UC_PROGRAM[]_PATH, [])
+	else
+		AC_MSG_ERROR([You cannot use git without $1])
+	fi
+    else
+	if test "$withval" = "yes"; then
+		AC_MSG_WARN([You should provide path for --with-$1=PATH])
+	else
+		GIT_UC_PROGRAM[]_PATH=$withval
+		AC_MSG_NOTICE([Setting GIT_UC_PROGRAM[]_PATH to $withval])
+		GIT_CONF_SUBST(GIT_UC_PROGRAM[]_PATH, [$withval])
+	fi
+    fi
+    m4_popdef([GIT_UC_PROGRAM])])
diff --git a/m4/git_conf_subst.m4 b/m4/git_conf_subst.m4
new file mode 100644
index 0000000..c625c81
--- /dev/null
+++ b/m4/git_conf_subst.m4
@@ -0,0 +1,10 @@
+
+## Definitions of git private macro.
+
+# GIT_CONF_SUBST(VAL, VAR)
+# ------------------------
+# Cause the line "VAR=VAL" to be eventually appended to ${config_file}.
+AC_DEFUN([GIT_CONF_SUBST],
+[AC_REQUIRE([GIT_CONF_SUBST_INIT])
+config_appended_defs="$config_appended_defs${newline}dnl
+$1=m4_if([$#],[1],[${$1}],[$2])"])
diff --git a/m4/git_conf_subst_init.m4 b/m4/git_conf_subst_init.m4
new file mode 100644
index 0000000..febf496
--- /dev/null
+++ b/m4/git_conf_subst_init.m4
@@ -0,0 +1,15 @@
+
+## Definitions of git private macro.
+
+# GIT_CONF_SUBST_INIT
+# -------------------
+# Prepare shell variables and autoconf machine required by later calls
+# to GIT_CONF_SUBST.
+AC_DEFUN([GIT_CONF_SUBST_INIT],
+    [config_appended_defs=; newline='
+'
+    AC_CONFIG_COMMANDS([$config_file],
+                       [echo "$config_appended_defs" >> "$config_file"],
+                       [config_file=$config_file
+                        config_appended_defs="$config_appended_defs"])])
+
diff --git a/m4/git_parse_with.m4 b/m4/git_parse_with.m4
new file mode 100644
index 0000000..67866ee
--- /dev/null
+++ b/m4/git_parse_with.m4
@@ -0,0 +1,22 @@
+
+## Definitions of git private macro.
+
+# GIT_PARSE_WITH(PACKAGE)
+# -----------------------
+# For use in AC_ARG_WITH action-if-found, for packages default ON.
+# * Set NO_PACKAGE=YesPlease for --without-PACKAGE
+# * Set PACKAGEDIR=PATH for --with-PACKAGE=PATH
+# * Unset NO_PACKAGE for --with-PACKAGE without ARG
+AC_DEFUN([GIT_PARSE_WITH],
+    [m4_pushdef([GIT_UC_PACKAGE], m4_toupper([$1]))dnl
+    if test "$withval" = "no"; then
+	NO_[]GIT_UC_PACKAGE=YesPlease
+    elif test "$withval" = "yes"; then
+	NO_[]GIT_UC_PACKAGE=
+    else
+	NO_[]GIT_UC_PACKAGE=
+	GIT_UC_PACKAGE[]DIR=$withval
+	AC_MSG_NOTICE([Setting GIT_UC_PACKAGE[]DIR to $withval])
+	GIT_CONF_SUBST(GIT_UC_PACKAGE[DIR], [$withval])
+    fi
+    m4_popdef([GIT_UC_PACKAGE])])
diff --git a/m4/git_parse_with_set_make_var.m4 b/m4/git_parse_with_set_make_var.m4
new file mode 100644
index 0000000..68523a6
--- /dev/null
+++ b/m4/git_parse_with_set_make_var.m4
@@ -0,0 +1,20 @@
+## Definitions of git private macro.
+
+# GIT_PARSE_WITH_SET_MAKE_VAR(WITHNAME, VAR, HELP_TEXT)
+# -----------------------------------------------------
+# Set VAR to the value specied by --with-WITHNAME.
+# No verification of arguments is performed, but warnings are issued
+# if either 'yes' or 'no' is specified.
+# HELP_TEXT is presented when --help is called.
+# This is a direct way to allow setting variables in the Makefile.
+AC_DEFUN([GIT_PARSE_WITH_SET_MAKE_VAR],
+[AC_ARG_WITH([$1],
+ [AS_HELP_STRING([--with-$1=VALUE], $3)],
+ if test -n "$withval"; then
+  if test "$withval" = "yes" -o "$withval" = "no"; then
+    AC_MSG_WARN([You likely do not want either 'yes' or 'no' as]
+		     [a value for $1 ($2).  Maybe you do...?])
+  fi
+  AC_MSG_NOTICE([Setting $2 to $withval])
+  GIT_CONF_SUBST([$2], [$withval])
+ fi)])# GIT_PARSE_WITH_SET_MAKE_VAR
diff --git a/m4/git_stash_flags.m4 b/m4/git_stash_flags.m4
new file mode 100644
index 0000000..7719d3e
--- /dev/null
+++ b/m4/git_stash_flags.m4
@@ -0,0 +1,15 @@
+## Definitions of git private macro.
+
+#
+# GIT_STASH_FLAGS(BASEPATH_VAR)
+# -----------------------------
+# Allow for easy stashing of LDFLAGS and CPPFLAGS before running
+# tests that may want to take user settings into account.
+AC_DEFUN([GIT_STASH_FLAGS],[
+if test -n "$1"; then
+   old_CPPFLAGS="$CPPFLAGS"
+   old_LDFLAGS="$LDFLAGS"
+   CPPFLAGS="-I$1/include $CPPFLAGS"
+   LDFLAGS="-L$1/$lib $LDFLAGS"
+fi
+])
diff --git a/m4/git_unstash_flags.m4 b/m4/git_unstash_flags.m4
new file mode 100644
index 0000000..0a2d4b2
--- /dev/null
+++ b/m4/git_unstash_flags.m4
@@ -0,0 +1,13 @@
+## Definitions of git private macro.
+
+dnl
+dnl GIT_UNSTASH_FLAGS(BASEPATH_VAR)
+dnl -----------------------------
+dnl Restore the stashed *FLAGS values.
+AC_DEFUN([GIT_UNSTASH_FLAGS],[
+if test -n "$1"; then
+   CPPFLAGS="$old_CPPFLAGS"
+   LDFLAGS="$old_LDFLAGS"
+fi
+])
+
-- 
1.7.9.5
