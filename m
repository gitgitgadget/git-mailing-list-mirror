From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 1/2] Make templates honour SHELL_PATH and PERL_PATH
Date: Sat, 20 Mar 2010 10:48:08 -0400
Message-ID: <1269096489-12750-2-git-send-email-bwalton@artsci.utoronto.ca>
References: <1269096489-12750-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 15:48:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NszyW-0001K1-3I
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 15:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963Ab0CTOsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 10:48:24 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:53017 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab0CTOsW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 10:48:22 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:42662 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1NszyP-0002wx-Fl; Sat, 20 Mar 2010 10:48:21 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1NszyP-0003KE-Ew; Sat, 20 Mar 2010 10:48:21 -0400
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1269096489-12750-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142712>

The hook script templates were hard coded to use /bin/sh and perl.
This patch ensures that they use the same tools specified for the rest
of the suite.

The impetus for the change was noticing that, as shipped, some of the
hooks used shell constructs that wouldn't work under Solaris' /bin/sh
(eg: $(cmd...) substitutions).

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 Makefile                                   |    2 +-
 templates/Makefile                         |   17 +++++++++++++++--
 templates/hooks--pre-rebase.sample         |    2 +-
 templates/hooks--prepare-commit-msg.sample |    4 ++--
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 7c616f8..86638de 100644
--- a/Makefile
+++ b/Makefile
@@ -1469,7 +1469,7 @@ endif
 ifndef NO_PYTHON
 	$(QUIET_SUBDIR0)git_remote_helpers $(QUIET_SUBDIR1) PYTHON_PATH='$(PYTHON_PATH_SQ)' prefix='$(prefix_SQ)' all
 endif
-	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
+	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 
 please_set_SHELL_PATH_to_a_more_modern_shell:
 	@$$(:)
diff --git a/templates/Makefile b/templates/Makefile
index 408f013..d22a71a 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -11,6 +11,16 @@ prefix ?= $(HOME)
 template_instdir ?= $(prefix)/share/git-core/templates
 # DESTDIR=
 
+ifndef SHELL_PATH
+	SHELL_PATH = /bin/sh
+endif
+ifndef PERL_PATH
+	PERL_PATH = perl
+endif
+
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+
 # Shell quote (do not use $(call) to accommodate ancient setups);
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 template_instdir_SQ = $(subst ','\'',$(template_instdir))
@@ -33,8 +43,11 @@ boilerplates.made : $(bpsrc)
 		case "$$boilerplate" in \
 		*--) continue;; \
 		esac && \
-		cp $$boilerplate blt/$$dst && \
-		if test -x "blt/$$dst"; then rx=rx; else rx=r; fi && \
+		sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+		    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
+		    -e 's|@PERL_PATH@|$(PERL_PATH_SQ)|g' $$boilerplate > \
+			blt/$$dst && \
+		if test -x "$$boilerplate"; then rx=rx; else rx=r; fi && \
 		chmod a+$$rx "blt/$$dst" || exit; \
 	done && \
 	date >$@
diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
index be1b06e..ab1c4c8 100755
--- a/templates/hooks--pre-rebase.sample
+++ b/templates/hooks--pre-rebase.sample
@@ -65,7 +65,7 @@ then
 	fi
 else
 	not_in_next=`git-rev-list --pretty=oneline ^${publish} "$topic"`
-	perl -e '
+	@PERL_PATH@ -e '
 		my $topic = $ARGV[0];
 		my $msg = "* $topic has commits already merged to public branch:\n";
 		my (%not_in_next) = map {
diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 3652424..e8d1754 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -22,10 +22,10 @@
 
 case "$2,$3" in
   merge,)
-    perl -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
+    @PERL_PATH@ -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
 
 # ,|template,)
-#   perl -i.bak -pe '
+#   @PERL_PATH@ -i.bak -pe '
 #      print "\n" . `git diff --cached --name-status -r`
 #	 if /^#/ && $first++ == 0' "$1" ;;
 
-- 
1.7.0
