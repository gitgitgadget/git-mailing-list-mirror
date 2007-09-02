From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 02/15] Makefile rules for translation catalog generation and
 installation.
Date: Sun, 2 Sep 2007 17:25:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021725080.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:25:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsGY-0003aC-Vc
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782AbXIBQZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756874AbXIBQZ3
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:25:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:53564 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755779AbXIBQZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:25:28 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:25:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 02 Sep 2007 18:25:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NxskuzfxNzuXSntKzwHuDJPHSXP8r2FvK98pz1L
	6jwIU758W38Gzk
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57347>


[jes: with fixes by the i18n team.]

Signed-off-by: Christian Stimming <stimming@tuhh.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1bac6fe..559e65e 100644
--- a/Makefile
+++ b/Makefile
@@ -103,6 +103,21 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 $(GITGUI_BUILT_INS): git-gui
 	$(QUIET_BUILT_IN)rm -f $@ && ln git-gui $@
 
+XGETTEXT   ?= xgettext
+msgsdir    ?= $(libdir)/msgs
+msgsdir_SQ  = $(subst ','\'',$(msgsdir))
+PO_TEMPLATE = po/git-gui.pot
+ALL_POFILES = $(wildcard po/*.po)
+ALL_MSGFILES = $(subst .po,.msg,$(ALL_POFILES))
+
+$(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
+	$(XGETTEXT) -kmc -LTcl -o $@ $(SCRIPT_SH) $(ALL_LIBFILES)
+update-po:: $(PO_TEMPLATE)
+	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
+$(ALL_MSGFILES): %.msg : %.po
+	@echo Generating catalog $@
+	msgfmt --statistics --tcl $< -l $(basename $(notdir $<)) -d $(dir $@)
+
 lib/tclIndex: $(ALL_LIBFILES)
 	$(QUIET_INDEX)if echo \
 	  $(foreach p,$(PRELOAD_FILES),source $p\;) \
@@ -136,7 +151,7 @@ GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
 		echo 1>$@ "$$VARS"; \
 	fi
 
-all:: $(ALL_PROGRAMS) lib/tclIndex
+all:: $(ALL_PROGRAMS) lib/tclIndex $(ALL_MSGFILES)
 
 install: all
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
@@ -145,13 +160,15 @@ install: all
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(libdir_SQ)' $(INSTALL_D1)
 	$(QUIET)$(INSTALL_R0)lib/tclIndex $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)'
 	$(QUIET)$(foreach p,$(ALL_LIBFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)' &&) true
+	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(msgsdir_SQ)' $(INSTALL_D1)
+	$(QUIET)$(foreach p,$(ALL_MSGFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
 
 dist-version:
 	@mkdir -p $(TARDIR)
 	@echo $(GITGUI_VERSION) > $(TARDIR)/version
 
 clean::
-	rm -f $(ALL_PROGRAMS) lib/tclIndex
+	rm -f $(ALL_PROGRAMS) lib/tclIndex po/*.msg
 	rm -f GIT-VERSION-FILE GIT-GUI-VARS
 
 .PHONY: all install dist-version clean
-- 
1.5.3.2.g46909
