From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] Added configure options --with-tcltk/--without-tcltk.
Date: Tue, 27 Mar 2007 14:24:37 +0400
Message-ID: <20070327102437.GM14837@codelabs.ru>
References: <etpuen$2uo$2@sea.gmane.org> <20070326073143.GB44578@codelabs.ru> <20070326073250.GC44578@codelabs.ru> <200703261030.49382.jnareb@gmail.com> <7vmz20xuxq.fsf@assigned-by-dhcp.cox.net> <20070326100344.GV14837@codelabs.ru> <7vejnbtjdq.fsf@assigned-by-dhcp.cox.net> <20070327065940.GC51155@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 12:25:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW8rY-0007Qe-DW
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbXC0KY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbXC0KY4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:24:56 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:65420 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbXC0KYy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:24:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=pa8vb/2CK48tm7YyPYu5BS5SRqyh3HPiwnt9g2h8Rv1wtfH+/0duUaWY3ASS2fz2z/b8dVNSKUeKzOILA/xBGKGq9wspPKln8tzePXcJhV4NXUEvUPHAnCmaErh+P0zi92nLAEKBBTFplX1jwdWpiKxMo+iovFZSn/ORk7pEYvc=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW8r4-000DZP-D8; Tue, 27 Mar 2007 14:24:43 +0400
Content-Disposition: inline
In-Reply-To: <20070327065940.GC51155@codelabs.ru>
X-Spam-Status: No, score=-2.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43247>

Configure's options --with-tcltk and --without-tcltk were added and
configure script teached to search for the Tcl/Tk interpreter.

The default behaviour to install Tcl/Tk dependant parts is left
intact: Tcl/Tk detection will be enabled only if --with-tcltk option
is given to configure.

Makefiles got two external options:
- TCLTK_PATH: the path to the Tcl/Tk interpreter.
- NO_TCLCK: disables the installation of Tcl/Tk dependend parts.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 Makefile         |   30 ++++++++++++++++++++++++++++--
 config.mak.in    |    1 +
 configure.ac     |   26 ++++++++++++++++++++++++++
 git-gui/Makefile |    3 +++
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a294ec8..06b6c6b 100644
--- a/Makefile
+++ b/Makefile
@@ -112,6 +112,11 @@ all::
 #
 # Define WITH_P4IMPORT to build and install Python git-p4import script.
 #
+# Define NO_TCLTK if you do not want Tcl/Tk GUI.
+#
+# The TCLTK_PATH variable governs the location of the Tck/Tk interpreter.
+# If not set it defaults to the bare 'wish'.
+#
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -161,6 +166,7 @@ AR = ar
 TAR = tar
 INSTALL = install
 RPMBUILD = rpmbuild
+TCLTK_PATH ?= wish
 
 # sparse is architecture-neutral, which means that we need to tell it
 # explicitly what architecture to check for. Fix this up for yours..
@@ -624,6 +630,10 @@ ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
 
+ifeq ($(TCLTK_PATH),)
+NO_TCLTK=YesPlease
+endif
+
 QUIET_SUBDIR0  = $(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -684,7 +694,9 @@ ifneq (,$X)
 endif
 
 all::
+ifndef NO_TCLTK
 	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) all
+endif
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
 
@@ -918,10 +930,16 @@ install: all
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) git$X gitk '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
+ifndef NO_TCLTK
+	sed -i .bak -e'1,3s|^exec .* "$$0"|exec '"$(TCLTK_PATH)"' "$$0"|' gitk && rm -f gitk.bak
+	$(INSTALL) gitk '$(DESTDIR_SQ)$(bindir_SQ)'
+endif
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix='$(prefix_SQ)' install
-	$(MAKE) -C git-gui install
+ifndef NO_TCLTK
+	$(MAKE) -C git-gui TCLTK_PATH='$(TCLTK_PATH)' install
+endif
 	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
 	then \
 		ln -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
@@ -955,11 +973,17 @@ dist: git.spec git-archive
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
 
@@ -1000,7 +1024,9 @@ clean:
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
index b82789e..2316b24 100644
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
@@ -55,6 +57,7 @@ all:: $(ALL_PROGRAMS)
 
 install: all
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	sed -i .bak -e'1,3s|^exec .* "$$0"|exec '"$(TCLTK_PATH)"' "$$0"|' git-gui && rm git-gui.bak
 	$(INSTALL) git-gui '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(foreach p,$(GITGUI_BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
 
-- 
1.5.0.3-dirty
