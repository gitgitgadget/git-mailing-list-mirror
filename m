From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] autoconf: Add support for setting SHELL_PATH and PERL_PATH
Date: Thu, 3 Aug 2006 00:38:11 +0200
Message-ID: <200608030038.11553.jnareb@gmail.com>
References: <200608030036.56298.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 03 00:40:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8POA-000679-Au
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 00:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWHBWk1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 18:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWHBWk1
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 18:40:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:45880 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932289AbWHBWk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 18:40:26 -0400
Received: by nf-out-0910.google.com with SMTP id o25so783657nfa
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 15:40:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=i0e02x3rZY7IQNAb93enBKmN7zHd90uVV4KLN79U3yYyiEaJV/h+aegXkFeb8fXwxHHvgd0i49zGcLPzNVlRTNGjqmC5b7b0fzjKI4oAu6lhR7p7n2A42Er+QK+knh7k0j0YCQGILGKXg6JexSR1B6qEaNZ4tepPqMZBx66RY60=
Received: by 10.49.8.10 with SMTP id l10mr2975340nfi;
        Wed, 02 Aug 2006 15:40:25 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id m15sm151205nfc.2006.08.02.15.40.24;
        Wed, 02 Aug 2006 15:40:24 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608030036.56298.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24696>

This patch adds support for setting SHELL_PATH and PERL_PATH to
autoconf generated ./configure script via --with-shell=PATH and
--with-perl=PATH options.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |   35 +++++++++++++++++++++++++++++++++--
 1 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index c1f7751..4688e97 100644
--- a/configure.ac
+++ b/configure.ac
@@ -19,17 +19,47 @@ # --------------------------
 # Append LINE to file ${config_append}
 AC_DEFUN([GIT_CONF_APPEND_LINE],
 [echo "$1" >> "${config_append}"])# GIT_CONF_APPEND_LINE
+#
+# GIT_ARG_SET_PATH(PROGRAM)
+# -------------------------
+# Provide --with-PROGRAM=PATH option to set PATH to PROGRAM
+AC_DEFUN([GIT_ARG_SET_PATH],
+[AC_ARG_WITH([$1],
+ [AS_HELP_STRING([--with-$1=PATH],
+                 [provide PATH to $1])],
+ [GIT_CONF_APPEND_PATH($1)],[])
+])# GIT_ARG_SET_PATH
+#
+# GIT_CONF_APPEND_PATH(PROGRAM)
+# ------------------------------
+# Parse --with-PROGRAM=PATH option to set PROGRAM_PATH=PATH
+# Used by GIT_ARG_SET_PATH(PROGRAM)
+AC_DEFUN([GIT_CONF_APPEND_PATH],
+[PROGRAM=m4_toupper($1); \
+if test "$withval" = "no"; then \
+	AC_MSG_WARN([You cannot use git without $1]); \
+else \
+	if test "$withval" = "yes"; then \
+		AC_MSG_WARN([You should provide path for --with-$1=PATH]); \
+	else \
+		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=$withval); \
+	fi; \
+fi; \
+]) # GIT_CONF_APPEND_PATH
 
 
 ## Checks for programs.
 AC_MSG_NOTICE([CHECKS for programs])
 #
+GIT_ARG_SET_PATH(shell)
+GIT_ARG_SET_PATH(perl)
+#
+# Define NO_PYTHON if you want to lose all benefits of the recursive merge.
+# Define PYTHON_PATH to provide path to Python.
 AC_PROG_CC
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOL(AR, ar, :)
 AC_CHECK_PROGS(TAR, [gtar tar])
-#
-# Define NO_PYTHON if you want to lose all benefits of the recursive merge.
 
 
 ## Checks for libraries.
@@ -127,6 +157,7 @@ # a missing newline at the end of the fi
 
 ## Site configuration
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
+#
 # Define NO_SVN_TESTS if you want to skip time-consuming SVN interopability
 # tests.  These tests take up a significant amount of the total test time
 # but are not needed unless you plan to talk to SVN repos.
-- 
1.4.1.1
