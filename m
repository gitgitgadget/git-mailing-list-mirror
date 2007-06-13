From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] Add --with-tclsh argument to configure script.
Date: Wed, 13 Jun 2007 09:44:06 +0400
Message-ID: <20070613054406.GO86872@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 08:02:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyLvZ-0003Ef-JQ
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 08:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbXFMGB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 02:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753449AbXFMGB4
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 02:01:56 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:58532 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbXFMGBz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 02:01:55 -0400
X-Greylist: delayed 1160 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2007 02:01:55 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Message-ID:MIME-Version:Content-Type:Content-Disposition:Sender:X-Spam-Status:Subject;
	b=S/Kh/UVI9wLgD8ITShLMJA6A5wOcssD4kpVHA67b/TXjoZByJ0MzPL/k/DGojju1w6Fgqb2N2QQvUfwpkJHn4eVaj4vUvzE2QSb8+RJtLLbvi9jl3F/jtUZTAtpbdPsjxO+S2MkjiixND1eI49V4Nuv+RL8Gs1J3YjISl0KUHYc=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HyLeN-000Ca3-SO for git@vger.kernel.org; Wed, 13 Jun 2007 09:44:12 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=4.0 tests=ALL_TRUSTED,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50017>

We have Tcl/Tk interpreter detection, so we should have Tcl interpreter
detection.  It is used just at the build time now, but it produces
the index that speeds up the git-gui loading.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 config.mak.in |    1 +
 configure.ac  |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index a3032e3..7601881 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -7,6 +7,7 @@ AR = @AR@
 TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
 TCLTK_PATH = @TCLTK_PATH@
+TCL_PATH = @TCLSH_PATH@
 
 prefix = @prefix@
 exec_prefix = @exec_prefix@
diff --git a/configure.ac b/configure.ac
index fd1d241..184a466 100644
--- a/configure.ac
+++ b/configure.ac
@@ -85,6 +85,16 @@ AS_HELP_STRING([],[Bare --with-tcltk will make the GUI part only if])
 AS_HELP_STRING([],[Tcl/Tk interpreter will be found in a system.]),\
 GIT_PARSE_WITH(tcltk))
 #
+# Declare the with-tclsh/without-tclsh options.
+AC_ARG_WITH(tclsh,
+AS_HELP_STRING([--with-tclsh],[Tcl interpreter path])
+AS_HELP_STRING([],[ARG is the full path to the Tcl interpreter that])
+AS_HELP_STRING([],[is needed only during the compilation time.])
+AS_HELP_STRING([],[Bare --with-tclsh will search for the Tcl])
+AS_HELP_STRING([],[interpreter and use it.  If no interpreter])
+AS_HELP_STRING([],[will be found, then the default one will be used]),\
+GIT_PARSE_WITH(tclsh))
+#
 
 
 ## Checks for programs.
@@ -110,6 +120,30 @@ if test -z "$NO_TCLTK"; then
     AC_SUBST(TCLTK_PATH)
   fi
 fi
+# TCLSH_PATH will be set to the name of the Tcl interpreter.
+# Possibly the name will be the fully qualified path, but
+# it can be just the interpreter name.  TCLSH_PATH will be
+# empty only in one case: when NO_TCLTK is defined.
+if test -z "$NO_TCLTK"; then
+  if test "$with_tclsh" = ""; then
+  # No Tcl interpreter switches given.
+  # Do not check for Tcl interpreter, use bare 'tclsh'.
+    TCLSH_PATH=${__GIT_DEFAULT_TCLSH_NAME}
+    AC_SUBST(TCLSH_PATH)
+  elif test "$with_tclsh" = "yes"; then
+  # Tcl interpreter check requested.
+    AC_CHECK_PROGS(TCLSH_PATH, [tclsh], )
+    if test -z "$TCLSH_PATH"; then
+      AC_MSG_RESULT([Tcl interpreter was not found in the PATH.  Using bare '${__GIT_DEFAULT_TCLSH_NAME}'])
+      TCLSH_PATH=${__GIT_DEFAULT_TCLSH_NAME}
+      AC_SUBST(TCLSH_PATH)
+    fi
+  else
+    AC_MSG_RESULT([Using Tcl interpreter $with_tclsh])
+    TCLSH_PATH="$with_tclsh"
+    AC_SUBST(TCLSH_PATH)
+  fi
+fi
 
 ## Checks for libraries.
 AC_MSG_NOTICE([CHECKS for libraries])
-- 
1.5.2.1
