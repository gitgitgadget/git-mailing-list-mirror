From: Jeff King <peff@peff.net>
Subject: [PATCH 12/13] Makefile: teach scripts to include make variables
Date: Wed, 5 Feb 2014 13:05:47 -0500
Message-ID: <20140205180547.GL15218@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 19:05:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6rD-0001lP-1Z
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 19:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbaBESFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 13:05:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:45167 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752452AbaBESFt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 13:05:49 -0500
Received: (qmail 8532 invoked by uid 102); 5 Feb 2014 18:05:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 12:05:49 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 13:05:47 -0500
Content-Disposition: inline
In-Reply-To: <20140205174823.GA15070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241631>

The current scheme for getting build-time variables into a
shell script is to munge the script with sed, and stick the
munged variable into a special sentinel file so that "make"
knows about the dependency.

Instead, we can combine both functions by generating a shell
snippet with our value, and then "building" shell scripts by
concatenating their snippets. "make" then handles the
dependency automatically, and it's easy to generate tighter
dependencies.

We demonstrate here by moving the "DIFF" substitution into
its own snippet, which lets us rebuild only the single
affected file when it changes.

Signed-off-by: Jeff King <peff@peff.net>
---
The astute reader will notice that:

  MAKE_DIFF='diff'
  $MAKE_DIFF ...

that we end up with is not _quite_ the same as replacing "$MAKE_DIFF" in
the actual script text with "diff" at build-time. In particular, the way
that whitespace and quotes are treated is different. I'm not sure what
we would want to do here. Calling "eval" would work. Or we could have
the snippet produce a function, rather than a variable, like:

  DIFF() {
      diff "$@"
  }

 Makefile        | 18 +++++++++++++++---
 git-sh-setup.sh |  2 +-
 script/mksh     |  4 ++++
 3 files changed, 20 insertions(+), 4 deletions(-)
 create mode 100644 script/mksh

diff --git a/Makefile b/Makefile
index 203171d..ad3100d 100644
--- a/Makefile
+++ b/Makefile
@@ -1598,6 +1598,11 @@ MAKE/%-string.h: MAKE/% script/mkcstring
 		$(subst -,_,$*) <$< >$@+ && \
 		mv $@+ $@
 
+MAKE/%.sh: MAKE/% script/mksh
+	$(QUIET_GEN)$(SHELL_PATH) script/mksh \
+		$(subst -,_,$*) <$< >$@+ && \
+		mv $@+ $@
+
 LIBS = $(GITLIBS) $(EXTLIBS)
 
 BASIC_CFLAGS += -DSHA1_HEADER=$(call sq,$(SHA1_HEADER)) \
@@ -1734,7 +1739,6 @@ common-cmds.h: $(wildcard Documentation/git-*.txt)
 
 $(eval $(call make-var,SCRIPT-DEFINES,script parameters,\
 	:$(SHELL_PATH)\
-	:$(DIFF)\
 	:$(GIT_VERSION)\
 	:$(localedir)\
 	:$(NO_CURL)\
@@ -1743,18 +1747,24 @@ $(eval $(call make-var,SCRIPT-DEFINES,script parameters,\
 	:$(gitwebdir)\
 	:$(PERL_PATH)\
 ))
+$(eval $(call make-var,DIFF,diff command,$(DIFF)))
 define cmd_munge_script
 $(RM) $@ $@+ && \
+{ \
+includes="$(filter MAKE/%.sh,$^)"; \
+if ! test -z "$$includes"; then \
+	cat $$includes; \
+fi && \
 sed -e '1s|#!.*/sh|#!$(call sqi,$(SHELL_PATH))|' \
     -e 's|@SHELL_PATH@|$(call sqi,$(SHELL_PATH))|' \
-    -e 's|@@DIFF@@|$(call sqi,$(DIFF))|' \
     -e 's|@@LOCALEDIR@@|$(call sqi,$(localedir))|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
     -e $(BROKEN_PATH_FIX) \
     -e 's|@@GITWEBDIR@@|$(call sqi,$(gitwebdir))|g' \
     -e 's|@@PERL@@|$(call sqi,$(PERL_PATH))|g' \
-    $@.sh >$@+
+    $@.sh; \
+} >$@+
 endef
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh MAKE/SCRIPT-DEFINES
@@ -1766,6 +1776,8 @@ $(SCRIPT_LIB) : % : %.sh MAKE/SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	mv $@+ $@
 
+git-sh-setup: MAKE/DIFF.sh
+
 git.res: git.rc GIT-VERSION-FILE
 	$(QUIET_RC)$(RC) \
 	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index fffa3c7..627d289 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -285,7 +285,7 @@ clear_local_git_env() {
 # remove lines from $1 that are not in $2, leaving only common lines.
 create_virtual_base() {
 	sz0=$(wc -c <"$1")
-	@@DIFF@@ -u -La/"$1" -Lb/"$1" "$1" "$2" | git apply --no-add
+	$MAKE_DIFF -u -La/"$1" -Lb/"$1" "$1" "$2" | git apply --no-add
 	sz1=$(wc -c <"$1")
 
 	# If we do not have enough common material, it is not
diff --git a/script/mksh b/script/mksh
new file mode 100644
index 0000000..d41e77a
--- /dev/null
+++ b/script/mksh
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+name=$1; shift
+printf "MAKE_%s='%s'\n" "$name" "$(sed "s/'/'\\''/g")"
-- 
1.8.5.2.500.g8060133
