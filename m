From: Jeff King <peff@peff.net>
Subject: [PATCH 06/13] Makefile: store GIT-* sentinel files in MAKE/
Date: Wed, 5 Feb 2014 12:52:22 -0500
Message-ID: <20140205175222.GF15218@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 18:52:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6eE-0000Q2-5s
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbaBERwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:52:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:45145 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752757AbaBERwY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:52:24 -0500
Received: (qmail 7733 invoked by uid 102); 5 Feb 2014 17:52:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:52:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:52:22 -0500
Content-Disposition: inline
In-Reply-To: <20140205174823.GA15070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241624>

The Makefile creates files like GIT-CFLAGS to keep track of
the make variables used in the last build. We have a number
of these files now, all starting with GIT-*. Let's move them
into their own subdirectory, which has two advantages:

  1. It's less clutter in the main directory.

  2. Each file needs to be marked separately in .gitignore.
     With a subdirectory, we can easily mark them all with a
     wildcard (we cannot do a wildcard for GIT-* because
     of precious files like GIT-VERSION-GEN).

This patch moves all of the generated GIT-* files into
MAKE/*, with one exception: GIT-VERSION-FILE. This could be
moved along with the rest, but there is a reasonable chance
that there are some out-of-tree scripts that may peek at it
(whereas things like GIT-CFLAGS are purely internal, and we
update all internal references).

Signed-off-by: Jeff King <peff@peff.net>
---
I'm not married to the name "MAKE", but I do think the separate
directory is a win for simplicity and avoiding repetition (as you can
see in the diffstat). Other suggestions welcome.

 .gitignore            |  8 -------
 MAKE/.gitignore       |  1 +
 Makefile              | 66 +++++++++++++++++++++++++--------------------------
 perl/Makefile         | 10 ++++----
 t/perf/run            |  2 +-
 t/test-lib.sh         |  2 +-
 t/valgrind/analyze.sh |  4 ++--
 7 files changed, 42 insertions(+), 51 deletions(-)
 create mode 100644 MAKE/.gitignore

diff --git a/.gitignore b/.gitignore
index b5f9def..586a067 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,11 +1,3 @@
-/GIT-BUILD-OPTIONS
-/GIT-CFLAGS
-/GIT-LDFLAGS
-/GIT-PREFIX
-/GIT-PERL-DEFINES
-/GIT-PYTHON-VARS
-/GIT-SCRIPT-DEFINES
-/GIT-USER-AGENT
 /GIT-VERSION-FILE
 /bin-wrappers/
 /git
diff --git a/MAKE/.gitignore b/MAKE/.gitignore
new file mode 100644
index 0000000..72e8ffc
--- /dev/null
+++ b/MAKE/.gitignore
@@ -0,0 +1 @@
+*
diff --git a/Makefile b/Makefile
index 60dc53b..7fecdf1 100644
--- a/Makefile
+++ b/Makefile
@@ -1564,10 +1564,10 @@ endif
 # usage: $(eval $(call make-var,FN,DESC,CONTENTS))
 #
 # Create a rule to write $CONTENTS (which should come from a make variable)
-# to GIT-$FN, but only if not already there. This can be used to create a
+# to MAKE/$FN, but only if not already there. This can be used to create a
 # dependency on a Makefile variable. Prints $DESC to the user.
 define make-var
-GIT-$1: FORCE
+MAKE/$1: FORCE
 	@VALUE='$$(subst ','\'',$3)'; \
 	if test x"$$$$VALUE" != x"`cat $$@ 2>/dev/null`"; then \
 		echo >&2 "    * new $2"; \
@@ -1658,7 +1658,7 @@ all:: profile-clean
 endif
 endif
 
-all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
+all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) MAKE/BUILD-OPTIONS
 ifneq (,$X)
 	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
 endif
@@ -1714,25 +1714,25 @@ strip: $(PROGRAMS) git$X
 #   dependencies here will not need to change if the force-build
 #   details change some day.
 
-git.sp git.s git.o: GIT-PREFIX
+git.sp git.s git.o: MAKE/PREFIX
 git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
-git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.o MAKE/LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
 help.sp help.s help.o: common-cmds.h
 
-builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h GIT-PREFIX
+builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h MAKE/PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
-version.sp version.s version.o: GIT-VERSION-FILE GIT-USER-AGENT
+version.sp version.s version.o: GIT-VERSION-FILE MAKE/USER-AGENT
 version.sp version.s version.o: EXTRA_CPPFLAGS = \
 	'-DGIT_VERSION="$(GIT_VERSION)"' \
 	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)'
@@ -1773,12 +1773,12 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     $@.sh >$@+
 endef
 
-$(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh GIT-SCRIPT-DEFINES
+$(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh MAKE/SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
-$(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
+$(SCRIPT_LIB) : % : %.sh MAKE/SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	mv $@+ $@
 
@@ -1797,14 +1797,14 @@ perl/PM.stamp: FORCE
 	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; } && \
 	$(RM) $@+
 
-perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
+perl/perl.mak: MAKE/CFLAGS MAKE/PREFIX perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
 $(eval $(call make-var,PERL-DEFINES,perl-specific parameters,\
 	:$(PERL_PATH)\
 	:$(PERLLIB_EXTRA)\
 ))
-$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERSION-FILE
+$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl perl/perl.mak MAKE/PERL-DEFINES GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
@@ -1826,7 +1826,7 @@ gitweb:
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
 all:: gitweb
 
-git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
+git-instaweb: git-instaweb.sh MAKE/SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
 	mv $@+ $@
@@ -1842,7 +1842,7 @@ endif # NO_PERL
 
 ifndef NO_PYTHON
 $(eval $(call make-var,PYTHON-VARS,Python interpreter location,$(PYTHON_PATH)))
-$(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
+$(SCRIPT_PYTHON_GEN): MAKE/CFLAGS MAKE/PREFIX MAKE/PYTHON-VARS
 $(SCRIPT_PYTHON_GEN): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
@@ -1984,13 +1984,13 @@ endif
 endif
 
 ifndef CHECK_HEADER_DEPENDENCIES
-$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs)
+$(C_OBJ): %.o: %.c MAKE/CFLAGS $(missing_dep_dirs)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
-$(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
+$(ASM_OBJ): %.o: %.S MAKE/CFLAGS $(missing_dep_dirs)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 endif
 
-%.s: %.c GIT-CFLAGS FORCE
+%.s: %.c MAKE/CFLAGS FORCE
 	$(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
 ifdef USE_COMPUTED_HEADER_DEPENDENCIES
@@ -2011,25 +2011,25 @@ else
 $(OBJECTS): $(LIB_H)
 endif
 
-exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
+exec_cmd.sp exec_cmd.s exec_cmd.o: MAKE/PREFIX
 exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
 
-builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
+builtin/init-db.sp builtin/init-db.s builtin/init-db.o: MAKE/PREFIX
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
-config.sp config.s config.o: GIT-PREFIX
+config.sp config.s config.o: MAKE/PREFIX
 config.sp config.s config.o: EXTRA_CPPFLAGS = \
 	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
-attr.sp attr.s attr.o: GIT-PREFIX
+attr.sp attr.s attr.o: MAKE/PREFIX
 attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
 	-DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
 
-gettext.sp gettext.s gettext.o: GIT-PREFIX
+gettext.sp gettext.s gettext.o: MAKE/PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
 	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
 
@@ -2051,21 +2051,21 @@ compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
 compat/nedmalloc/nedmalloc.sp: SPARSE_FLAGS += -Wno-non-pointer-null
 endif
 
-git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
+git-%$X: %.o MAKE/LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o GIT-LDFLAGS $(GITLIBS)
+git-imap-send$X: imap-send.o MAKE/LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
-git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
+git-http-fetch$X: http.o http-walker.o http-fetch.o MAKE/LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL)
-git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
+git-http-push$X: http.o http-push.o MAKE/LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
+git-remote-testsvn$X: remote-testsvn.o MAKE/LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
 	$(VCSSVN_LIB)
 
@@ -2075,7 +2075,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
+$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o MAKE/LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
@@ -2172,9 +2172,9 @@ $(eval $(call make-var,CFLAGS,build flags,$(ALL_CFLAGS)))
 $(eval $(call make-var,LDFLAGS,link flags,$(ALL_LDFLAGS)))
 
 # We need to apply sq twice, once to protect from the shell
-# that runs GIT-BUILD-OPTIONS, and then again to protect it
+# that runs MAKE/BUILD-OPTIONS, and then again to protect it
 # and the first level quoting from the shell that runs "echo".
-GIT-BUILD-OPTIONS: FORCE
+MAKE/BUILD-OPTIONS: FORCE
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
 	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@
 	@echo DIFF=\''$(subst ','\'',$(subst ','\'',$(DIFF)))'\' >>$@
@@ -2255,7 +2255,7 @@ test-svn-fe$X: vcs-svn/lib.a
 
 .PRECIOUS: $(TEST_OBJS)
 
-test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
+test-%$X: test-%.o MAKE/LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: test-sha1$X
@@ -2263,7 +2263,7 @@ check-sha1:: test-sha1$X
 
 SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
 
-$(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
+$(SP_OBJ): %.sp: %.c MAKE/CFLAGS FORCE
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
 		$(SPARSE_FLAGS) $<
 
@@ -2477,9 +2477,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C gitk-git clean
 	$(MAKE) -C git-gui clean
 endif
-	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
-	$(RM) GIT-USER-AGENT GIT-PREFIX
-	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PYTHON-VARS
+	$(RM) GIT-VERSION-FILE MAKE/*
 
 .PHONY: all install profile-clean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
diff --git a/perl/Makefile b/perl/Makefile
index 15d96fc..b27420e 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -41,7 +41,7 @@ modules += Git/SVN/Prompt
 modules += Git/SVN/Ra
 modules += Git/SVN/Utils
 
-$(makfile): ../GIT-CFLAGS Makefile
+$(makfile): ../MAKE/CFLAGS Makefile
 	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
 	set -e; \
 	for i in $(modules); \
@@ -79,11 +79,11 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo instlibdir: >> $@
 	echo '	echo $(instdir_SQ)' >> $@
 else
-$(makfile): Makefile.PL ../GIT-CFLAGS
+$(makfile): Makefile.PL ../MAKE/CFLAGS
 	$(PERL_PATH) $< PREFIX='$(prefix_SQ)' INSTALL_BASE='' --localedir='$(localedir_SQ)'
 endif
 
 # this is just added comfort for calling make directly in perl dir
-# (even though GIT-CFLAGS aren't used yet. If ever)
-../GIT-CFLAGS:
-	$(MAKE) -C .. GIT-CFLAGS
+# (even though MAKE/CFLAGS aren't used yet. If ever)
+../MAKE/CFLAGS:
+	$(MAKE) -C .. MAKE/CFLAGS
diff --git a/t/perf/run b/t/perf/run
index cfd7012..489d6cb 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -73,7 +73,7 @@ GIT_PERF_AGGREGATING_LATER=t
 export GIT_PERF_AGGREGATING_LATER
 
 cd "$(dirname $0)"
-. ../../GIT-BUILD-OPTIONS
+. ../../MAKE/BUILD-OPTIONS
 
 if test $# = 0 -o "$1" = -- -o -f "$1"; then
 	set -- . "$@"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1531c24..2c1ce73 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -48,7 +48,7 @@ then
 	exit 1
 fi
 
-. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+. "$GIT_BUILD_DIR"/MAKE/BUILD-OPTIONS
 export PERL_PATH SHELL_PATH
 
 # if --tee was passed, write the output not only to the terminal, but
diff --git a/t/valgrind/analyze.sh b/t/valgrind/analyze.sh
index 2ffc80f..346e0ff 100755
--- a/t/valgrind/analyze.sh
+++ b/t/valgrind/analyze.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
-# Get TEST_OUTPUT_DIRECTORY from GIT-BUILD-OPTIONS if it's there...
-. "$(dirname "$0")/../../GIT-BUILD-OPTIONS"
+# Get TEST_OUTPUT_DIRECTORY from MAKE/BUILD-OPTIONS if it's there...
+. "$(dirname "$0")/../../MAKE/BUILD-OPTIONS"
 # ... otherwise set it to the default value.
 : ${TEST_OUTPUT_DIRECTORY=$(dirname "$0")/..}
 
-- 
1.8.5.2.500.g8060133
