From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] configure.ac: move the private git m4 macro to a dedicated directory
Date: Fri,  9 Aug 2013 07:37:25 -0700
Message-ID: <1376059045-14866-1-git-send-email-gitter.spiros@gmail.com>
Cc: stefano.lattarini@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 16:37:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7nov-0000PG-8d
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 16:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511Ab3HIOhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 10:37:33 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:64565 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030305Ab3HIOhc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 10:37:32 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so5011737pad.19
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cXb8LJadOw4CNFxTd9bRbxSFJqxRGrt6UJBWQV3JTQM=;
        b=wkJ5AUfKTx5oYSg5xdcxr1fwKHU2iNkqVBHG7TuYNjB/e8wOjJbYindV06OkzaZ+Sk
         jHZBW/FFXQL1QuKorqsyUGTINLuzNBJr1NZ4YL5ruosAPTygbqFgTQuL9RyFJluGJyap
         GkkH+zQMNPD+nKgQDV0wQJ7eC3bhA1JW0mF1F1suTRt/rM+hGMcdbdTbKNWnR3qCeL2j
         9BRlKpboZN0yao9iPEHrhMq720VrcaQeDGUZ3nOQTTDUOtG2H4d0ux7Ch9ka/CDQKAKM
         GPjLKMPR3wLoPApmGo7YQM9aLGXR7FtFwWdbSIWp07I/0lGofmGZ91oAPej/ESP5gHF1
         jp1w==
X-Received: by 10.68.137.170 with SMTP id qj10mr11799466pbb.31.1376059051834;
        Fri, 09 Aug 2013 07:37:31 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id s6sm22890454pan.12.2013.08.09.07.37.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 07:37:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231984>

Git use, as many project that use autoconf, private m4 macros.

When not using automake, and just relying on autoconf, the macro
files are not picked up by default.

A possibility, as git do today, is to put the private m4 macro
in the configure.ac file, so they will copied over  the final configure
when calling autoreconf(that call also autocon). But this makes configure.ac difficult
to read and maintain, especially if you want to introduce new macros later.

Starting from version 2.58, autoconf provide the macro AC_CONFIG_MACRO_DIR
to declare where additional macro files are to be put and found.
The argument passed to this macro is commonly m4.

This macro, for the longest time, has been used only by libtool
starting from version 2.0, to identify where to copy its own macro files
when using libtoolize --copy.

Starting from version 1.13, automake augments autoconf with a macro
called AC_CONFIG_MACRO_DIRS, that provides a space-separated list
of directories to use for looking up m4 files.
The same macro will be available as part of autoconf 2.70,
actually in development. Anyway also this version permit
to use AC_CONFIG_MACRO_DIR and not need automake.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 configure.ac |  139 +---------------------------------------------------------
 m4/git.m4    |  139 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+), 138 deletions(-)
 create mode 100644 m4/git.m4

diff --git a/configure.ac b/configure.ac
index 2f43393..b686c10 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,150 +1,13 @@
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
 AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
 
 AC_CONFIG_SRCDIR([git.c])
+AC_CONFIG_MACRO_DIR([m4])
 
 config_file=config.mak.autogen
 config_in=config.mak.in
diff --git a/m4/git.m4 b/m4/git.m4
new file mode 100644
index 0000000..5505b53
--- /dev/null
+++ b/m4/git.m4
@@ -0,0 +1,139 @@
+
+## Definitions of git private macros.
+
+# GIT_CONF_SUBST(VAL, VAR)
+# ------------------------
+# Cause the line "VAR=VAL" to be eventually appended to ${config_file}.
+AC_DEFUN([GIT_CONF_SUBST],
+[AC_REQUIRE([GIT_CONF_SUBST_INIT])
+config_appended_defs="$config_appended_defs${newline}dnl
+$1=m4_if([$#],[1],[${$1}],[$2])"])
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
