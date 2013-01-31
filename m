From: TJ <git@iam.tj>
Subject: [PATCH 1/1] Introduce new build variables INSTALL_MODE_EXECUTABLE
 and INSTALL_MODE_DATA.
Date: Thu, 31 Jan 2013 02:08:48 +0000
Message-ID: <5109D230.2030101@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 03:18:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0jjj-00078C-Jz
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 03:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab3AaCS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 21:18:26 -0500
Received: from yes.iam.tj ([109.74.197.121]:49804 "EHLO iam.tj"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751365Ab3AaCSY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 21:18:24 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2013 21:18:24 EST
Received: from [10.254.251.193] (jeeves.iam.tj [82.71.24.87])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by iam.tj (Postfix) with ESMTPSA id 90B717C435
	for <git@vger.kernel.org>; Thu, 31 Jan 2013 02:08:49 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215088>

Installation would fail if the target location had anything other than 755/644
file permissions. Therefore replace the hard-coded modes for each $(INSTALL)
with variables.

Default values are 755/644 but can be over-ridden on the make command line
e.g. "make INSTALL_MODE_EXECUTABLE=755 INSTALL_MODE_DATA=644 install".

Signed-off-by: TJ <git@iam.tj>
---
 Documentation/Makefile   | 20 ++++++++++----------
 Makefile                 | 17 +++++++++++------
 contrib/emacs/Makefile   |  2 +-
 contrib/subtree/Makefile |  4 ++--
 git-gui/Makefile         | 12 ++++++------
 gitk-git/Makefile        |  6 +++---
 gitweb/Makefile          |  8 ++++----
 templates/Makefile       |  2 +-
 8 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 971977b..913928c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -190,16 +190,16 @@ pdf: user-manual.pdf
 install: install-man
  install-man: man
-	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
-	$(INSTALL) -d -m 755 $(DESTDIR)$(man5dir)
-	$(INSTALL) -d -m 755 $(DESTDIR)$(man7dir)
-	$(INSTALL) -m 644 $(DOC_MAN1) $(DESTDIR)$(man1dir)
-	$(INSTALL) -m 644 $(DOC_MAN5) $(DESTDIR)$(man5dir)
-	$(INSTALL) -m 644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(man1dir)
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(man5dir)
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(man7dir)
+	$(INSTALL) -m $(INSTALL_MODE_DATA) $(DOC_MAN1) $(DESTDIR)$(man1dir)
+	$(INSTALL) -m $(INSTALL_MODE_DATA) $(DOC_MAN5) $(DESTDIR)$(man5dir)
+	$(INSTALL) -m $(INSTALL_MODE_DATA) $(DOC_MAN7) $(DESTDIR)$(man7dir)
  install-info: info
-	$(INSTALL) -d -m 755 $(DESTDIR)$(infodir)
-	$(INSTALL) -m 644 git.info gitman.info $(DESTDIR)$(infodir)
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(infodir)
+	$(INSTALL) -m $(INSTALL_MODE_DATA) git.info gitman.info $(DESTDIR)$(infodir)
 	if test -r $(DESTDIR)$(infodir)/dir; then \
 	  $(INSTALL_INFO) --info-dir=$(DESTDIR)$(infodir) git.info ;\
 	  $(INSTALL_INFO) --info-dir=$(DESTDIR)$(infodir) gitman.info ;\
@@ -208,8 +208,8 @@ install-info: info
 	fi
  install-pdf: pdf
-	$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
-	$(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(pdfdir)
+	$(INSTALL) -m $(INSTALL_MODE_DATA) user-manual.pdf $(DESTDIR)$(pdfdir)
  install-html: html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
diff --git a/Makefile b/Makefile
index 731b6a8..7a59202 100644
--- a/Makefile
+++ b/Makefile
@@ -354,6 +354,11 @@ ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 +# default installation file modes. Can be overridden from the 'make' command-line.
+# E.g. For allowing group write: "make INSTALL_MODE_EXECUTABLE=775 install"
+INSTALL_MODE_EXECUTABLE = 755
+INSTALL_MODE_DATA = 644
+
 # Among the variables below, these:
 #   gitexecdir
 #   template_dir
@@ -2257,16 +2262,16 @@ mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
  install: all
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) -m $(INSTALL_MODE_DATA) $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
-	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	$(INSTALL) -m $(INSTALL_MODE_DATA) mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 ifndef NO_GETTEXT
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) '$(DESTDIR_SQ)$(localedir_SQ)'
 	(cd po/build/locale && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -)
 endif
diff --git a/contrib/emacs/Makefile b/contrib/emacs/Makefile
index 24d9312..a405744 100644
--- a/contrib/emacs/Makefile
+++ b/contrib/emacs/Makefile
@@ -4,7 +4,7 @@ EMACS = emacs
  ELC = git.elc git-blame.elc
 INSTALL ?= install
-INSTALL_ELC = $(INSTALL) -m 644
+INSTALL_ELC = $(INSTALL) -m $(INSTALL_MODE_DATA)
 prefix ?= $(HOME)
 emacsdir = $(prefix)/share/emacs/site-lisp
 RM ?= rm -f
diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 05cdd5c..40d8d2f 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -30,12 +30,12 @@ $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
 doc: $(GIT_SUBTREE_DOC)
  install: $(GIT_SUBTREE)
-	$(INSTALL) -m 755 $(GIT_SUBTREE) $(libexecdir)
+	$(INSTALL) -m $(INSTALL_MODE_EXECUTABLE) $(GIT_SUBTREE) $(libexecdir)
  install-doc: install-man
  install-man: $(GIT_SUBTREE_DOC)
-	$(INSTALL) -m 644 $^ $(man1dir)
+	$(INSTALL) -m $(INSTALL_MODE_DATA) $^ $(man1dir)
  $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
 	xmlto -m $(MANPAGE_NORMAL_XSL)  man $^
diff --git a/git-gui/Makefile b/git-gui/Makefile
index e22ba5c..472a10c 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -48,11 +48,11 @@ endif
 RM_RF     ?= rm -rf
 RMDIR     ?= rmdir
 -INSTALL_D0 = $(INSTALL) -d -m 755 # space is required here
+INSTALL_D0 = $(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) # space is required here
 INSTALL_D1 =
-INSTALL_R0 = $(INSTALL) -m 644 # space is required here
+INSTALL_R0 = $(INSTALL) -m $(INSTALL_MODE_DATA) # space is required here
 INSTALL_R1 =
-INSTALL_X0 = $(INSTALL) -m 755 # space is required here
+INSTALL_X0 = $(INSTALL) -m $(INSTALL_MODE_EXECUTABLE) # space is required here
 INSTALL_X1 =
 INSTALL_A0 = find # space is required here
 INSTALL_A1 = | cpio -pud
@@ -76,11 +76,11 @@ ifndef V
 	QUIET_2DEVNULL = 2>/dev/null
  	INSTALL_D0 = dir=
-	INSTALL_D1 = && echo ' ' DEST $$dir && $(INSTALL) -d -m 755 "$$dir"
+	INSTALL_D1 = && echo ' ' DEST $$dir && $(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) "$$dir"
 	INSTALL_R0 = src=
-	INSTALL_R1 = && echo '   ' INSTALL 644 `basename $$src` && $(INSTALL) -m 644 $$src
+	INSTALL_R1 = && echo '   ' INSTALL $(INSTALL_MODE_DATA) `basename $$src` && $(INSTALL) -m $(INSTALL_MODE_DATA) $$src
 	INSTALL_X0 = src=
-	INSTALL_X1 = && echo '   ' INSTALL 755 `basename $$src` && $(INSTALL) -m 755 $$src
+	INSTALL_X1 = && echo '   ' INSTALL $(INSTALL_MODE_EXECUTABLE) `basename $$src` && $(INSTALL) -m $(INSTALL_MODE_EXECUTABLE) $$src
 	INSTALL_A0 = src=
 	INSTALL_A1 = && echo '   ' INSTALL '   ' `basename "$$src"` && find "$$src" | cpio -pud
 diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index e1b6045..bc18cce 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -40,9 +40,9 @@ endif
 all:: gitk-wish $(ALL_MSGFILES)
  install:: all
-	$(INSTALL) -m 755 gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(msgsdir_SQ)'
-	$(foreach p,$(ALL_MSGFILES), $(INSTALL) -m 644 $p '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
+	$(INSTALL) -m $(INSTALL_MODE_EXECUTABLE) gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) '$(DESTDIR_SQ)$(msgsdir_SQ)'
+	$(foreach p,$(ALL_MSGFILES), $(INSTALL) -m $(INSTALL_MODE_DATA) $p '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
  uninstall::
 	$(foreach p,$(ALL_MSGFILES), $(RM) '$(DESTDIR_SQ)$(msgsdir_SQ)'/$(notdir $p) &&) true
diff --git a/gitweb/Makefile b/gitweb/Makefile
index cd194d0..7d760b0 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -179,10 +179,10 @@ test-installed:
 ### Installation rules
  install: all
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
-	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
-	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
+	$(INSTALL) -m $(INSTALL_MODE_EXECUTABLE) $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
+	$(INSTALL) -m $(INSTALL_MODE_DATA) $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
  ### Cleaning rules
 diff --git a/templates/Makefile b/templates/Makefile
index d22a71a..3e7c7d2 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -61,6 +61,6 @@ clean:
 	$(RM) -r blt boilerplates.made
  install: all
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
+	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) '$(DESTDIR_SQ)$(template_instdir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xof -)
-- 
1.8.1.2.432.g070c57d.dirty
