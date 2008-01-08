From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: Update and fix Makefile
Date: Tue, 8 Jan 2008 21:54:20 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200801082154.21282.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 21:56:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCLUm-0000uq-Fr
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 21:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233AbYAHUz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 15:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754990AbYAHUz5
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 15:55:57 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:56180 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbYAHUz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 15:55:56 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m08Ktqsw011606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 8 Jan 2008 21:55:52 +0100
Received: from [192.168.2.102] (p54900B03.dip0.t-ipconnect.de [84.144.11.3])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m08KtpZj005373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 8 Jan 2008 21:55:52 +0100
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69921>

This Makefile uses the template provided at git.git/gitk-git/Makefile
by Junio and adds the rules for the i18n files.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
This patch is against master of git.kernel.org.
@Paul: Ignore my previous patch - "make install" didn't 
work there, but it does here.

 Makefile |   63 +++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/Makefile b/Makefile
index 38154b6..6158504 100644
--- a/Makefile
+++ b/Makefile
@@ -1,25 +1,52 @@
-# Set the installation directories; this section is needed only in
-# gitk.git but probably not in git.git.
-ifndef gitexecdir
-	gitexecdir := $(shell git --exec-path)
-endif
-ifndef sharedir
-	sharedir := $(dir $(gitexecdir))share
-endif
+# The default target of this Makefile is...
+all::
 
-# From here on, these are needed in git.git/gitk/Makefile.
+prefix ?= $(HOME)
+bindir ?= $(prefix)/bin
+sharedir ?= $(prefix)/share
 gitk_libdir   ?= $(sharedir)/gitk/lib
 msgsdir    ?= $(gitk_libdir)/msgs
 msgsdir_SQ  = $(subst ','\'',$(msgsdir))
 
-## Beginning of po-file creation rules
+TCLTK_PATH ?= wish
+INSTALL ?= install
+RM ?= rm -f
+
+DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
+bindir_SQ = $(subst ','\'',$(bindir))
+TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
+
+## po-file creation rules
 XGETTEXT   ?= xgettext
 MSGFMT     ?= msgfmt
 PO_TEMPLATE = po/gitk.pot
 ALL_POFILES = $(wildcard po/*.po)
 ALL_MSGFILES = $(subst .po,.msg,$(ALL_POFILES))
 
-all:: $(ALL_MSGFILES)
+ifndef V
+	QUIET          = @
+	QUIET_GEN      = $(QUIET)echo '   ' GEN $@ &&
+endif
+
+all:: gitk-wish $(ALL_MSGFILES)
+
+install:: all
+	$(INSTALL) gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	$(INSTALL) -d '$(DESTDIR_SQ)$(msgsdir_SQ)'
+	$(foreach p,$(ALL_MSGFILES), $(INSTALL) $p '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
+
+uninstall::
+	$(foreach p,$(ALL_MSGFILES), $(RM) '$(DESTDIR_SQ)$(msgsdir_SQ)'/$(notdir $p) &&) true
+	$(RM) '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+
+clean::
+	$(RM) gitk-wish po/*.msg
+
+gitk-wish: gitk
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	sed -e '1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' <gitk >$@+ && \
+	chmod +x $@+ && \
+	mv -f $@+ $@
 
 $(PO_TEMPLATE): gitk
 	$(XGETTEXT) -kmc -LTcl -o $@ gitk
@@ -29,17 +56,3 @@ $(ALL_MSGFILES): %.msg : %.po
 	@echo Generating catalog $@
 	$(MSGFMT) --statistics --tcl $< -l $(basename $(notdir $<)) -d $(dir $@)
 
-clean::
-	rm -f $(ALL_PROGRAMS) po/*.msg
-## End of po-file creation rules
-
-# Install rules for po-files
-install: all
-	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(msgsdir_SQ)' $(INSTALL_D1)
-	$(QUIET)$(foreach p,$(ALL_MSGFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
-
-uninstall:
-	$(QUIET)$(foreach p,$(ALL_MSGFILES), $(REMOVE_F0)'$(DESTDIR_SQ)$(msgsdir_SQ)'/$(notdir $p) $(REMOVE_F1) &&) true
-	$(QUIET)$(REMOVE_D0)'$(DESTDIR_SQ)$(msgsdir_SQ)' $(REMOVE_D1)
-	$(QUIET)$(REMOVE_D0)'$(DESTDIR_SQ)$(libdir_SQ)' $(REMOVE_D1)
-	$(QUIET)$(REMOVE_D0)`dirname '$(DESTDIR_SQ)$(libdir_SQ)'` $(REMOVE_D1)
-- 
1.5.3.4.206.g58ba4
