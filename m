From: Jeff King <peff@peff.net>
Subject: [PATCHv3 07/11] Makefile: split prefix flags from GIT-CFLAGS
Date: Wed, 20 Jun 2012 14:31:55 -0400
Message-ID: <20120620183155.GG30995@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:32:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPhT-0007dL-0k
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420Ab2FTScB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:32:01 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39019
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932404Ab2FTSb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:31:59 -0400
Received: (qmail 26909 invoked by uid 107); 20 Jun 2012 18:31:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 14:31:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 14:31:55 -0400
Content-Disposition: inline
In-Reply-To: <20120620182855.GA26948@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200323>

Most of the build targets do not care about the setting of
$prefix (or its derivative variables), but will be rebuilt
if the prefix changes. For most setups this doesn't matter
(they set prefix once and never change it), but for a setup
which puts each branch or version in its own prefix, this
unnecessarily causes a full rebuild whenever the branc is
changed.

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore |  1 +
 Makefile   | 30 ++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7329cfe..c60c5a3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,7 @@
 /GIT-CFLAGS
 /GIT-LDFLAGS
 /GIT-GUI-VARS
+/GIT-PREFIX
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
 /bin-wrappers/
diff --git a/Makefile b/Makefile
index 7518ad7..957b6a6 100644
--- a/Makefile
+++ b/Makefile
@@ -1977,6 +1977,7 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
+git.sp git.s git.o: GIT-PREFIX
 git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
@@ -1988,7 +1989,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: common-cmds.h
 
-builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h
+builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
@@ -2035,7 +2036,7 @@ $(SCRIPT_LIB) : % : %.sh
 ifndef NO_PERL
 $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 
-perl/perl.mak: GIT-CFLAGS perl/Makefile perl/Makefile.PL
+perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
@@ -2079,7 +2080,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
 endif # NO_PERL
 
 ifndef NO_PYTHON
-$(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS
+$(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS GIT-PREFIX
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
@@ -2248,20 +2249,25 @@ xdiff-interface.o $(XDIFF_OBJS): $(XDIFF_H)
 $(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) $(VCSSVN_H)
 endif
 
+exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
 exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
 
+builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
+config.sp config.s config.o: GIT-PREFIX
 config.sp config.s config.o: EXTRA_CPPFLAGS = \
 	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
+attr.sp attr.s attr.o: GIT-PREFIX
 attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
 	-DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
 
+gettext.sp gettext.s gettext.o: GIT-PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
 	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
 
@@ -2385,14 +2391,22 @@ cscope:
 	$(FIND_SOURCE_FILES) | xargs cscope -b
 
 ### Detect prefix changes
-TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS)):\
-             $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
-             $(localedir_SQ):$(USE_GETTEXT_SCHEME)
+TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
+		$(localedir_SQ)
+
+GIT-PREFIX: FORCE
+	@FLAGS='$(TRACK_PREFIX)'; \
+	if test x"$$FLAGS" != x"`cat GIT-PREFIX 2>/dev/null`" ; then \
+		echo 1>&2 "    * new prefix flags"; \
+		echo "$$FLAGS" >GIT-PREFIX; \
+	fi
+
+TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS)):$(USE_GETTEXT_SCHEME)
 
 GIT-CFLAGS: FORCE
 	@FLAGS='$(TRACK_CFLAGS)'; \
 	    if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
-		echo 1>&2 "    * new build flags or prefix"; \
+		echo 1>&2 "    * new build flags"; \
 		echo "$$FLAGS" >GIT-CFLAGS; \
             fi
 
@@ -2728,7 +2742,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
-	$(RM) GIT-USER-AGENT
+	$(RM) GIT-USER-AGENT GIT-PREFIX
 
 .PHONY: all install profile-clean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-- 
1.7.11.5.gc0eeaa8
