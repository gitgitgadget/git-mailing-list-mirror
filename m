From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/4] Makefile: extract perl-related rules to make them available from other dirs
Date: Wed,  6 Feb 2013 19:11:29 +0100
Message-ID: <1360174292-14793-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
 <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 06 19:12:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39Tk-0007m9-LL
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab3BFSLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:11:47 -0500
Received: from mx2.imag.fr ([129.88.30.17]:53950 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212Ab3BFSLq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:11:46 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r16IBYFK029428
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2013 19:11:36 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U39T7-0005kP-0V; Wed, 06 Feb 2013 19:11:37 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U39T6-0003rd-TH; Wed, 06 Feb 2013 19:11:36 +0100
X-Mailer: git-send-email 1.8.1.2.526.gf51a757
In-Reply-To: <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 06 Feb 2013 19:11:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r16IBYFK029428
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1360779096.94948@XeTjIKSLifQC7VkYvIQF1Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215609>

The final goal is to make it easy to write Git commands in perl in the
contrib/ directory. It is currently possible to do so, but without the
benefits of Git's Makefile: adapt first line with $(PERL_PATH),
hardcode the path to Git.pm, ...

We make the perl-related part of the Makefile available from directories
other than the toplevel so that:

* Developers can include it, to avoid code duplication

* Users can get a consistent behavior of "make install"

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Makefile | 46 +---------------------------------------------
 perl.mak | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 45 deletions(-)
 create mode 100644 perl.mak

diff --git a/Makefile b/Makefile
index 731b6a8..f39d4a9 100644
--- a/Makefile
+++ b/Makefile
@@ -573,14 +573,10 @@ BINDIR_PROGRAMS_NO_X += git-cvsserver
 ifndef SHELL_PATH
 	SHELL_PATH = /bin/sh
 endif
-ifndef PERL_PATH
-	PERL_PATH = /usr/bin/perl
-endif
 ifndef PYTHON_PATH
 	PYTHON_PATH = /usr/bin/python
 endif
 
-export PERL_PATH
 export PYTHON_PATH
 
 LIB_FILE = libgit.a
@@ -1441,10 +1437,6 @@ ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
 
-ifeq ($(PERL_PATH),)
-NO_PERL = NoThanks
-endif
-
 ifeq ($(PYTHON_PATH),)
 NO_PYTHON = NoThanks
 endif
@@ -1522,7 +1514,6 @@ prefix_SQ = $(subst ','\'',$(prefix))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
-PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
@@ -1715,9 +1706,6 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	mv $@+ $@
 
-ifndef NO_PERL
-$(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
-
 perl/perl.mak: perl/PM.stamp
 
 perl/PM.stamp: FORCE
@@ -1728,39 +1716,7 @@ perl/PM.stamp: FORCE
 perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
-$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl GIT-VERSION-FILE
-	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
-	sed -e '1{' \
-	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	h' \
-	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
-	    -e '	H' \
-	    -e '	x' \
-	    -e '}' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.perl >$@+ && \
-	chmod +x $@+ && \
-	mv $@+ $@
-
-
-.PHONY: gitweb
-gitweb:
-	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
-
-git-instaweb: git-instaweb.sh gitweb GIT-SCRIPT-DEFINES
-	$(QUIET_GEN)$(cmd_munge_script) && \
-	chmod +x $@+ && \
-	mv $@+ $@
-else # NO_PERL
-$(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
-	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
-	    unimplemented.sh >$@+ && \
-	chmod +x $@+ && \
-	mv $@+ $@
-endif # NO_PERL
+include perl.mak
 
 ifndef NO_PYTHON
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
diff --git a/perl.mak b/perl.mak
new file mode 100644
index 0000000..8bbeef3
--- /dev/null
+++ b/perl.mak
@@ -0,0 +1,49 @@
+# Rules to build Git commands written in perl
+
+ifndef PERL_PATH
+	PERL_PATH = /usr/bin/perl
+endif
+export PERL_PATH
+PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+
+ifeq ($(PERL_PATH),)
+NO_PERL = NoThanks
+endif
+
+ifndef NO_PERL
+$(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
+
+
+$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl GIT-VERSION-FILE
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
+	sed -e '1{' \
+	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	    -e '	h' \
+	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
+	    -e '	H' \
+	    -e '	x' \
+	    -e '}' \
+	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    $@.perl >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
+
+
+.PHONY: gitweb
+gitweb:
+	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
+
+git-instaweb: git-instaweb.sh gitweb GIT-SCRIPT-DEFINES
+	$(QUIET_GEN)$(cmd_munge_script) && \
+	chmod +x $@+ && \
+	mv $@+ $@
+else # NO_PERL
+$(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
+	    unimplemented.sh >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
+endif # NO_PERL
-- 
1.8.1.2.526.gf51a757
