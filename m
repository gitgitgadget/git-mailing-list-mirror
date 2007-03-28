From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] Add --with-tcltk and --without-tcltk to configure.
Date: Wed, 28 Mar 2007 13:12:09 +0400
Message-ID: <20070328091209.GQ14837@codelabs.ru>
References: <20070326073250.GC44578@codelabs.ru> <200703261030.49382.jnareb@gmail.com> <7vmz20xuxq.fsf@assigned-by-dhcp.cox.net> <20070326100344.GV14837@codelabs.ru> <7vejnbtjdq.fsf@assigned-by-dhcp.cox.net> <20070327065940.GC51155@codelabs.ru> <20070327102437.GM14837@codelabs.ru> <7vtzw7nej6.fsf@assigned-by-dhcp.cox.net> <20070327110714.GA14837@codelabs.ru> <7vps6um8wv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 11:13:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWUD5-0007ph-Mr
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 11:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933948AbXC1JMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 05:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934015AbXC1JMW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 05:12:22 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:60107 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933948AbXC1JMU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 05:12:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=VjBDeSybv63ejfCmUdXWKf5bEww8CElkzg8TZvLVAv8c69lX5TRmIP8Pb6/1giEpzt8tSC+CgkXfJNCt32DBX8w1g1g3YDqPyDWtaTg+Iws89A9WKIIGVtfg2yT5PMRIiMK4YiCwj2wNPGuD7LYGly12fOzSAyKq/tKYbHBR7Ug=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HWUCT-000FCw-T0; Wed, 28 Mar 2007 13:12:14 +0400
Content-Disposition: inline
In-Reply-To: <7vps6um8wv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-2.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_05
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43362>

--with-tcltk enables the search of the Tcl/Tk interpreter. If no
interpreter is found then Tcl/Tk dependend parts are disabled.

--without-tcltk unconditionally disables Tcl/Tk dependent parts.

The original behaviour is not changed: bare './configure' just
installs the Tcl/Tk part doing no checks for the interpreter.

Makefile knob named NO_TCLTK was introduced. It prevents the build
and installation of the Tcl/Tk dependent parts.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 Makefile         |   31 +++++++++++++++++++++++++++++--
 config.mak.in    |    1 +
 configure.ac     |   26 ++++++++++++++++++++++++++
 git-gui/Makefile |    3 +++
 4 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a294ec8..bfde029 100644
--- a/Makefile
+++ b/Makefile
@@ -112,6 +112,12 @@ all::
 #
 # Define WITH_P4IMPORT to build and install Python git-p4import script.
 #
+# Define NO_TCLTK if you do not want Tcl/Tk GUI.
+#
+# The TCLTK_PATH variable governs the location of the Tck/Tk interpreter.
+# If not set it defaults to the bare 'wish'. If it is set to the empty
+# string then NO_TCLTK will be forced (this is used by configure script).
+#
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -161,6 +167,7 @@ AR = ar
 TAR = tar
 INSTALL = install
 RPMBUILD = rpmbuild
+TCLTK_PATH ?= wish
 
 # sparse is architecture-neutral, which means that we need to tell it
 # explicitly what architecture to check for. Fix this up for yours..
@@ -624,6 +631,10 @@ ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
 
+ifeq ($(TCLTK_PATH),)
+NO_TCLTK=YesPlease
+endif
+
 QUIET_SUBDIR0  = $(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -663,6 +674,7 @@ prefix_SQ = $(subst ','\'',$(prefix))
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
+TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
 
@@ -684,7 +696,9 @@ ifneq (,$X)
 endif
 
 all::
+ifndef NO_TCLTK
 	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) all
+endif
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
 
@@ -918,10 +932,15 @@ install: all
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) git$X gitk '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
+ifndef NO_TCLTK
+	$(INSTALL) gitk '$(DESTDIR_SQ)$(bindir_SQ)'
+endif
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix='$(prefix_SQ)' install
-	$(MAKE) -C git-gui install
+ifndef NO_TCLTK
+	$(MAKE) -C git-gui TCLTK_PATH='$(TCLTK_PATH_SQ)' install
+endif
 	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
 	then \
 		ln -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
@@ -955,11 +974,17 @@ dist: git.spec git-archive
 	@mkdir -p $(GIT_TARNAME)
 	@cp git.spec $(GIT_TARNAME)
 	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
+ifndef NO_TCLTK
 	@$(MAKE) -C git-gui TARDIR=../$(GIT_TARNAME)/git-gui dist-version
 	$(TAR) rf $(GIT_TARNAME).tar \
 		$(GIT_TARNAME)/git.spec \
 		$(GIT_TARNAME)/version \
 		$(GIT_TARNAME)/git-gui/version
+else
+	$(TAR) rf $(GIT_TARNAME).tar \
+		$(GIT_TARNAME)/git.spec \
+		$(GIT_TARNAME)/version
+endif
 	@rm -rf $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar
 
@@ -1000,7 +1025,9 @@ clean:
 	rm -f gitweb/gitweb.cgi
 	$(MAKE) -C Documentation/ clean
 	$(MAKE) -C perl clean
+ifndef NO_TCLTK
 	$(MAKE) -C git-gui clean
+endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
 	rm -f GIT-VERSION-FILE GIT-CFLAGS
diff --git a/config.mak.in b/config.mak.in
index 9a57840..eb9d7a5 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -6,6 +6,7 @@ CFLAGS = @CFLAGS@
 AR = @AR@
 TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
+TCLTK_PATH = @TCLTK_PATH@
 
 prefix = @prefix@
 exec_prefix = @exec_prefix@
diff --git a/configure.ac b/configure.ac
index 3a8e778..43a6769 100644
--- a/configure.ac
+++ b/configure.ac
@@ -75,6 +75,14 @@ GIT_ARG_SET_PATH(shell)
 # Define PERL_PATH to provide path to Perl.
 GIT_ARG_SET_PATH(perl)
 #
+# Declare the with-tcltk/without-tcltk options.
+AC_ARG_WITH(tcltk,
+AS_HELP_STRING([--with-tcltk],[use Tcl/Tk GUI (default is YES)])
+AS_HELP_STRING([],[ARG is the full path to the Tcl/Tk interpreter.])
+AS_HELP_STRING([],[Bare --with-tcltk will make the GUI part only if])
+AS_HELP_STRING([],[Tcl/Tk interpreter will be found in a system.]),\
+GIT_PARSE_WITH(tcltk))
+#
 
 
 ## Checks for programs.
@@ -84,6 +92,24 @@ AC_PROG_CC([cc gcc])
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOL(AR, ar, :)
 AC_CHECK_PROGS(TAR, [gtar tar])
+# TCLTK_PATH will be set to some value if we want Tcl/Tk
+# or will be empty otherwise.
+if test -z "$NO_TCLTK"; then
+  if test "$with_tcltk" = ""; then
+  # No Tcl/Tk switches given. Do not check for Tcl/Tk, use bare 'wish'.
+    TCLTK_PATH=wish
+    AC_SUBST(TCLTK_PATH)
+  elif test "$with_tcltk" = "yes"; then
+  # Tcl/Tk check requested.
+    AC_CHECK_PROGS(TCLTK_PATH, [wish], )
+  elif ! test -x "$with_tcltk"; then
+    AC_MSG_ERROR([Tcl/Tk interpreter was not found in $with_tcltk])
+  else
+    AC_MSG_RESULT([Using Tcl/Tk interpreter $with_tcltk])
+    TCLTK_PATH="$with_tcltk"
+    AC_SUBST(TCLTK_PATH)
+  fi
+fi
 
 ## Checks for libraries.
 AC_MSG_NOTICE([CHECKS for libraries])
diff --git a/git-gui/Makefile b/git-gui/Makefile
index b82789e..733c07e 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -28,6 +28,8 @@ ifndef V
 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
 endif
 
+TCLTK_PATH ?= wish
+
 ifeq ($(findstring $(MAKEFLAGS),s),s)
 QUIET_GEN =
 QUIET_BUILT_IN =
@@ -36,6 +38,7 @@ endif
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	$(QUIET_GEN)rm -f $@ $@+ && \
-- 
1.5.0.3-dirty
