From: Jeff King <peff@peff.net>
Subject: [PATCH 08/13] Makefile: introduce sq function for shell-quoting
Date: Wed, 5 Feb 2014 12:57:41 -0500
Message-ID: <20140205175741.GH15218@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 18:57:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6jN-0004Rj-Af
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbaBER5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:57:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:45153 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753310AbaBER5n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:57:43 -0500
Received: (qmail 8051 invoked by uid 102); 5 Feb 2014 17:57:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:57:42 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:57:41 -0500
Content-Disposition: inline
In-Reply-To: <20140205174823.GA15070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241627>

Since we have recently abolished the prohibition on $(call)
in our Makefile, we can use it to factor out the repeated
shell-quoting we do. There are two upsides:

  1. It is much more readable than inline calls to
     $(subst ','\'').

  2. It is short enough that we can do away with the _SQ
     variants of many variables (note that we do not do this
     just yet, as there is a little more cleanup needed
     first).

Signed-off-by: Jeff King <peff@peff.net>
---
This is the one I am most on the fence about. I think (2) is nice. And
for (1), we do end up more readable in some instances (e.g., the
horrible inline subst calls in generating BUILD-OPTIONS go away). But
many instances are not really any more readable (e.g., see the first
hunk below).

Two things come to mind:

  1. If we really prefer reading $(FOO_SQ) but don't want to manually
     write each one, we could have a simple script that reads the
     Makefile and produces an _SQ variant of every variable, whether we
     need it or not.

  2. The later parts of the series introduce a new way of getting
     values into programs that does not involve the command-line. So in
     theory many of these quoted uses of variables would just go away in
     the long run (if we choose to pursue that direction).

 Makefile | 120 ++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 64 insertions(+), 56 deletions(-)

diff --git a/Makefile b/Makefile
index e12039f..868872f 100644
--- a/Makefile
+++ b/Makefile
@@ -506,11 +506,11 @@ build-python-script: $(SCRIPT_PYTHON_GEN)
 
 .PHONY: install-perl-script install-sh-script install-python-script
 install-sh-script: $(SCRIPT_SH_INS)
-	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $^ $(call sq,$(DESTDIR)$(gitexec_instdir))
 install-perl-script: $(SCRIPT_PERL_INS)
-	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $^ $(call sq,$(DESTDIR)$(gitexec_instdir))
 install-python-script: $(SCRIPT_PYTHON_INS)
-	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $^ $(call sq,$(DESTDIR)$(gitexec_instdir))
 
 .PHONY: clean-perl-script clean-sh-script clean-python-script
 clean-sh-script:
@@ -1040,7 +1040,7 @@ endif
 
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
-BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(SANE_TOOL_PATH_SQ)|'
+BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(call sqi,$(SANE_TOOL_PATH)|'
 PATH := $(SANE_TOOL_PATH):${PATH}
 else
 BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
@@ -1561,6 +1561,13 @@ ifneq ("$(PROFILE)","")
 endif
 endif
 
+# usage: $(call sq,CONTENTS)
+#
+# Quote the value as appropriate for the shell. Use "sqi" if you are
+# already "i"nside single-quotes.
+sqi = $(subst ','\'',$1)
+sq = '$(call sqi,$1)'
+
 # usage: $(eval $(call make-var,FN,DESC,CONTENTS))
 #
 # Create a rule to write $CONTENTS (which should come from a make variable)
@@ -1568,7 +1575,7 @@ endif
 # dependency on a Makefile variable. Prints $DESC to the user.
 define make-var
 MAKE/$1: FORCE
-	@VALUE='$$(subst ','\'',$3)'; \
+	@VALUE=$$(call sq,$3); \
 	if ! test -e $$@ || test x"$$$$VALUE" != x"`cat $$@`"; then \
 		echo >&2 "    * new $2"; \
 		printf '%s\n' "$$$$VALUE" >$$@+ && \
@@ -1603,7 +1610,7 @@ PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
 
-BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
+BASIC_CFLAGS += -DSHA1_HEADER=$(call sq,$(SHA1_HEADER)) \
 	$(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
 
@@ -1665,13 +1672,13 @@ endif
 
 all::
 ifndef NO_TCLTK
-	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir='$(gitexec_instdir_SQ)' all
+	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir=$(call sq,$(gitexec_instdir)) all
 	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
 endif
 ifndef NO_PERL
-	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' localedir='$(localedir_SQ)' all
+	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH=$(call sq,$(PERL_PATH)) prefix=$(call sq,$(prefix)) localedir=$(call sq,$(localedir)) all
 endif
-	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
+	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH=$(call sq,$(SHELL_PATH)) PERL_PATH=$(call sq,$(PERL_PATH))
 
 please_set_SHELL_PATH_to_a_more_modern_shell:
 	@$$(:)
@@ -1761,15 +1768,15 @@ $(eval $(call make-var,SCRIPT-DEFINES,script parameters,\
 ))
 define cmd_munge_script
 $(RM) $@ $@+ && \
-sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
-    -e 's|@@DIFF@@|$(DIFF_SQ)|' \
-    -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
+sed -e '1s|#!.*/sh|#!$(call sqi,$(SHELL_PATH))|' \
+    -e 's|@SHELL_PATH@|$(call sqi,$(SHELL_PATH))|' \
+    -e 's|@@DIFF@@|$(call sqi,$(DIFF))|' \
+    -e 's|@@LOCALEDIR@@|$(call sqi,$(localedir))|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
     -e $(BROKEN_PATH_FIX) \
-    -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
-    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
+    -e 's|@@GITWEBDIR@@|$(call sqi,$(gitwebdir))|g' \
+    -e 's|@@PERL@@|$(call sqi,$(PERL_PATH))|g' \
     $@.sh >$@+
 endef
 
@@ -1798,7 +1805,7 @@ perl/PM.stamp: FORCE
 	$(RM) $@+
 
 perl/perl.mak: MAKE/CFLAGS MAKE/PREFIX perl/Makefile perl/Makefile.PL
-	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
+	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH=$(call sq,$(PERL_PATH)) prefix=$(call sq,$(prefix)) $(@F)
 
 $(eval $(call make-var,PERL-DEFINES,perl-specific parameters,\
 	:$(PERL_PATH)\
@@ -1807,10 +1814,10 @@ $(eval $(call make-var,PERL-DEFINES,perl-specific parameters,\
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl perl/perl.mak MAKE/PERL-DEFINES GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
-	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
+	INSTLIBDIR_EXTRA=$(call sq,$(PERLLIB_EXTRA)) && \
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e '1{' \
-	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	    -e '	s|#!.*perl|#!$(call sqi,$(PERL_PATH))|' \
 	    -e '	h' \
 	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
 	    -e '	H' \
@@ -1833,7 +1840,7 @@ git-instaweb: git-instaweb.sh MAKE/SCRIPT-DEFINES
 else # NO_PERL
 $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	sed -e '1s|#!.*/sh|#!$(call sqi,$(SHELL_PATH))|' \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
@@ -1845,14 +1852,14 @@ $(eval $(call make-var,PYTHON-VARS,Python interpreter location,$(PYTHON_PATH)))
 $(SCRIPT_PYTHON_GEN): MAKE/CFLAGS MAKE/PREFIX MAKE/PYTHON-VARS
 $(SCRIPT_PYTHON_GEN): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
+	sed -e '1s|#!.*python|#!$(call sqi,$(PYTHON_PATH))|' \
 	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PYTHON
 $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	sed -e '1s|#!.*/sh|#!$(call sqi,$(SHELL_PATH))|' \
 	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
@@ -2174,42 +2181,43 @@ $(eval $(call make-var,LDFLAGS,link flags,$(ALL_LDFLAGS)))
 # We need to apply sq twice, once to protect from the shell
 # that runs MAKE/BUILD-OPTIONS, and then again to protect it
 # and the first level quoting from the shell that runs "echo".
+ssq = $(call sq,$(call sq,$1))
 MAKE/BUILD-OPTIONS: FORCE
-	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
-	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@
-	@echo DIFF=\''$(subst ','\'',$(subst ','\'',$(DIFF)))'\' >>$@
-	@echo PYTHON_PATH=\''$(subst ','\'',$(PYTHON_PATH_SQ))'\' >>$@
-	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
-	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
-	@echo USE_LIBPCRE=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@
-	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
-	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
-	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
+	@echo SHELL_PATH=$(call ssq,$(SHELL_PATH)) >$@
+	@echo PERL_PATH=$(call ssq,$(PERL_PATH)) >>$@
+	@echo DIFF=$(call ssq,$(DIFF)) >>$@
+	@echo PYTHON_PATH=$(call ssq,$(PYTHON_PATH)) >>$@
+	@echo TAR=$(call ssq,$(TAR)) >>$@
+	@echo NO_CURL=$(call ssq,$(NO_CURL)) >>$@
+	@echo USE_LIBPCRE=$(call ssq,$(USE_LIBPCRE)) >>$@
+	@echo NO_PERL=$(call ssq,$(NO_PERL)) >>$@
+	@echo NO_PYTHON=$(call ssq,$(NO_PYTHON)) >>$@
+	@echo NO_UNIX_SOCKETS=$(call ssq,$(NO_UNIX_SOCKETS)) >>$@
 ifdef TEST_OUTPUT_DIRECTORY
-	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@
+	@echo TEST_OUTPUT_DIRECTORY=$(call ssq,$(TEST_OUTPUT_DIRECTORY)) >>$@
 endif
 ifdef GIT_TEST_OPTS
-	@echo GIT_TEST_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_OPTS)))'\' >>$@
+	@echo GIT_TEST_OPTS=$(call ssq,$(GIT_TEST_OPTS)) >>$@
 endif
 ifdef GIT_TEST_CMP
-	@echo GIT_TEST_CMP=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_CMP)))'\' >>$@
+	@echo GIT_TEST_CMP=$(call ssq,$(GIT_TEST_CMP)) >>$@
 endif
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@
 endif
-	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@
-	@echo GETTEXT_POISON=\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POISON)))'\' >>$@
+	@echo NO_GETTEXT=$(call ssq,$(NO_GETTEXT)) >>$@
+	@echo GETTEXT_POISON=$(call ssq,$(GETTEXT_POISON)) >>$@
 ifdef GIT_PERF_REPEAT_COUNT
-	@echo GIT_PERF_REPEAT_COUNT=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_REPEAT_COUNT)))'\' >>$@
+	@echo GIT_PERF_REPEAT_COUNT=$(call ssq,$(GIT_PERF_REPEAT_COUNT)) >>$@
 endif
 ifdef GIT_PERF_REPO
-	@echo GIT_PERF_REPO=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_REPO)))'\' >>$@
+	@echo GIT_PERF_REPO=$(call ssq,$(GIT_PERF_REPO)) >>$@
 endif
 ifdef GIT_PERF_LARGE_REPO
-	@echo GIT_PERF_LARGE_REPO=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_LARGE_REPO)))'\' >>$@
+	@echo GIT_PERF_LARGE_REPO=$(call ssq,$(GIT_PERF_LARGE_REPO)) >>$@
 endif
 ifdef GIT_PERF_MAKE_OPTS
-	@echo GIT_PERF_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_MAKE_OPTS)))'\' >>$@
+	@echo GIT_PERF_MAKE_OPTS=$(call ssq,$(GIT_PERF_MAKE_OPTS)) >>$@
 endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
@@ -2219,7 +2227,7 @@ all:: $(NO_INSTALL)
 
 bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
-	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(call sqi,$(SHELL_PATH))|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
 	     -e 's|@@PROG@@|$(@F)|' < $< > $@ && \
 	chmod +x $@
@@ -2307,33 +2315,33 @@ mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
 
 install: all
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
-	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	$(INSTALL) -d -m 755 $(call sq,$(DESTDIR)$(bindir))
+	$(INSTALL) -d -m 755 $(call sq,$(DESTDIR)$(gitexec_instdir))
+	$(INSTALL) $(ALL_PROGRAMS) $(call sq,$(DESTDIR)$(gitexec_instdir))
+	$(INSTALL) -m 644 $(SCRIPT_LIB) $(call sq,$(DESTDIR)$(gitexec_instdir))
+	$(INSTALL) $(install_bindir_programs) $(call sq,$(DESTDIR)$(bindir))
+	$(MAKE) -C templates DESTDIR=$(call sq,$(DESTDIR)) install
+	$(INSTALL) -d -m 755 $(call sq,$(DESTDIR)$(mergetools_instdir))
+	$(INSTALL) -m 644 mergetools/* $(call sq,$(DESTDIR)$(mergetools_instdir))
 ifndef NO_GETTEXT
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
+	$(INSTALL) -d -m 755 $(call sq,$(DESTDIR)$(localedir))
 	(cd po/build/locale && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -)
+	(cd $(call sq,$(DESTDIR)$(localedir)) && umask 022 && $(TAR) xof -)
 endif
 ifndef NO_PERL
-	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
+	$(MAKE) -C perl prefix=$(call sq,$(prefix)) DESTDIR=$(call sq,$(DESTDIR)) install
 	$(MAKE) -C gitweb install
 endif
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
-	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
+	$(MAKE) -C git-gui gitexecdir=$(call sq,$(gitexec_instdir)) install
 endif
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test $(call sq,$(DESTDIR)$(gitexec_instdir)/$p) -ef $(call sq,$(DESTDIR)$(gitexec_instdir)/$p$X) || $(RM) $(call sq,$(DESTDIR)$(gitexec_instdir)/$p);)
 endif
 
-	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
-	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
+	bindir=$$(cd $(call sq,$(DESTDIR)$(bindir)) && pwd) && \
+	execdir=$$(cd $(call sq,$(DESTDIR)$(gitexec_instdir)) && pwd) && \
 	{ test "$$bindir/" = "$$execdir/" || \
 	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
 		$(RM) "$$execdir/$$p" && \
-- 
1.8.5.2.500.g8060133
