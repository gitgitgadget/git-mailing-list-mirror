From: Jeff King <peff@peff.net>
Subject: [PATCH 09/13] Makefile: add c-quote helper function
Date: Wed, 5 Feb 2014 12:58:09 -0500
Message-ID: <20140205175809.GI15218@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 18:58:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6jq-0004nt-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbaBER6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:58:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:45155 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753272AbaBER6L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:58:11 -0500
Received: (qmail 8101 invoked by uid 102); 5 Feb 2014 17:58:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:58:10 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:58:09 -0500
Content-Disposition: inline
In-Reply-To: <20140205174823.GA15070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241628>

We have to c-quote strings coming from Makefile variables
when we pass them to the compiler via "-D". Now that we can
use $(call) in our Makefile, we can factor out the quoting
to make things easier to read. We can also apply it more
consistently, as there were many spots that should have been
C-quoting but did not. For example:

  make prefix='foo\bar'

would produce an exec_cmd.o with a broken prefix.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 58 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index 868872f..b1c3fb4 100644
--- a/Makefile
+++ b/Makefile
@@ -1568,6 +1568,17 @@ endif
 sqi = $(subst ','\'',$1)
 sq = '$(call sqi,$1)'
 
+# usage: $(call cq,CONTENTS)
+#
+# Quote the value as appropriate for a C string literal.
+cq = "$(subst ",\",$(subst \,\\,$1))"
+
+# usage: $(call scq,CONTENTS)
+#
+# Quote the value as C string inside a shell string. Good for passing strings
+# on the command line via "-DFOO=$(call # scq,$(FOO))".
+scq = $(call sq,$(call cq,$1))
+
 # usage: $(eval $(call make-var,FN,DESC,CONTENTS))
 #
 # Create a rule to write $CONTENTS (which should come from a make variable)
@@ -1617,28 +1628,17 @@ LIB_OBJS += $(COMPAT_OBJS)
 # Quote for C
 
 ifdef DEFAULT_EDITOR
-DEFAULT_EDITOR_CQ = "$(subst ",\",$(subst \,\\,$(DEFAULT_EDITOR)))"
-DEFAULT_EDITOR_CQ_SQ = $(subst ','\'',$(DEFAULT_EDITOR_CQ))
-
-BASIC_CFLAGS += -DDEFAULT_EDITOR='$(DEFAULT_EDITOR_CQ_SQ)'
+BASIC_CFLAGS += -DDEFAULT_EDITOR=$(call scq,$(DEFAULT_EDITOR))
 endif
 
 ifdef DEFAULT_PAGER
-DEFAULT_PAGER_CQ = "$(subst ",\",$(subst \,\\,$(DEFAULT_PAGER)))"
-DEFAULT_PAGER_CQ_SQ = $(subst ','\'',$(DEFAULT_PAGER_CQ))
-
-BASIC_CFLAGS += -DDEFAULT_PAGER='$(DEFAULT_PAGER_CQ_SQ)'
+BASIC_CFLAGS += -DDEFAULT_PAGER=$(call scq,$(DEFAULT_PAGER))
 endif
 
 ifdef SHELL_PATH
-SHELL_PATH_CQ = "$(subst ",\",$(subst \,\\,$(SHELL_PATH)))"
-SHELL_PATH_CQ_SQ = $(subst ','\'',$(SHELL_PATH_CQ))
-
-BASIC_CFLAGS += -DSHELL_PATH='$(SHELL_PATH_CQ_SQ)'
+BASIC_CFLAGS += -DSHELL_PATH=$(call scq,$(SHELL_PATH))
 endif
 
-GIT_USER_AGENT_CQ = "$(subst ",\",$(subst \,\\,$(GIT_USER_AGENT)))"
-GIT_USER_AGENT_CQ_SQ = $(subst ','\'',$(GIT_USER_AGENT_CQ))
 $(eval $(call make-var,USER-AGENT,user agent string,$(GIT_USER_AGENT)))
 
 ifdef DEFAULT_HELP_FORMAT
@@ -1723,9 +1723,9 @@ strip: $(PROGRAMS) git$X
 
 git.sp git.s git.o: MAKE/PREFIX
 git.sp git.s git.o: EXTRA_CPPFLAGS = \
-	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
-	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
-	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
+	-DGIT_HTML_PATH=$(call scq,$(htmldir_relative)) \
+	-DGIT_MAN_PATH=$(call scq,$(mandir_relative)) \
+	-DGIT_INFO_PATH=$(call scq,$(infodir_relative))
 
 git$X: git.o MAKE/LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
@@ -1735,14 +1735,14 @@ help.sp help.s help.o: common-cmds.h
 
 builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h MAKE/PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
-	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
-	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
-	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
+	-DGIT_HTML_PATH=$(call scq,$(htmldir_relative)) \
+	-DGIT_MAN_PATH=$(call scq,$(mandir_relative)) \
+	-DGIT_INFO_PATH=$(call scq,$(infodir_relative))
 
 version.sp version.s version.o: GIT-VERSION-FILE MAKE/USER-AGENT
 version.sp version.s version.o: EXTRA_CPPFLAGS = \
-	'-DGIT_VERSION="$(GIT_VERSION)"' \
-	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)'
+	-DGIT_VERSION=$(call scq,$(GIT_VERSION)) \
+	-DGIT_USER_AGENT=$(call scq,$(GIT_USER_AGENT))
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
@@ -2020,25 +2020,25 @@ endif
 
 exec_cmd.sp exec_cmd.s exec_cmd.o: MAKE/PREFIX
 exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
-	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
-	'-DBINDIR="$(bindir_relative_SQ)"' \
-	'-DPREFIX="$(prefix_SQ)"'
+	-DGIT_EXEC_PATH=$(call scq,$(gitexecdir)) \
+	-DBINDIR=$(call scq,$(bindir_relative)) \
+	-DPREFIX=$(call scq,$(prefix))
 
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: MAKE/PREFIX
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
-	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
+	-DDEFAULT_GIT_TEMPLATE_DIR=$(call scq,$(template_dir))
 
 config.sp config.s config.o: MAKE/PREFIX
 config.sp config.s config.o: EXTRA_CPPFLAGS = \
-	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
+	-DETC_GITCONFIG=$(call scq,$(ETC_GITCONFIG))
 
 attr.sp attr.s attr.o: MAKE/PREFIX
 attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
-	-DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
+	-DETC_GITATTRIBUTES=$(call scq,$(ETC_GITATTRIBUTES))
 
 gettext.sp gettext.s gettext.o: MAKE/PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
-	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
+	-DGIT_LOCALE_PATH=$(call scq,$(localedir))
 
 http-push.sp http.sp http-walker.sp remote-curl.sp: SPARSE_FLAGS += \
 	-DCURL_DISABLE_TYPECHECK
-- 
1.8.5.2.500.g8060133
