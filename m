From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 3/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 14:36:44 +0200
Message-ID: <200707211436.44672.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707211433.29318.stimming@tuhh.de> <200707211434.56622.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 14:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICECM-0008Kt-9G
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 14:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761890AbXGUMgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 08:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758844AbXGUMgf
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 08:36:35 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:36368 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758492AbXGUMge convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 08:36:34 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6LCaToE031104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 21 Jul 2007 14:36:29 +0200
Received: from [192.168.2.102] (p549012DA.dip0.t-ipconnect.de [84.144.18.218])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6LCaRiB006863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 14:36:29 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <200707211434.56622.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53162>

>From cf68c8b36399d46f63e417e99c6783411213a55a Mon Sep 17 00:00:00 2001
From: Christian Stimming <chs@ckiste.goetheallee>
Date: Sat, 21 Jul 2007 14:17:07 +0200
Subject: [PATCH] Makefile rules for translation catalog generation and installation.


Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
As discussed I've replaced the shell for() by the GNU make foreach. Also, there 
isn't an ALL_LINGUAS variable anymore; we simply use all *.po files under po/.

 Makefile |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 1bac6fe..52975a7 100644
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
+	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) )
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
@@ -145,6 +160,8 @@ install: all
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(libdir_SQ)' $(INSTALL_D1)
 	$(QUIET)$(INSTALL_R0)lib/tclIndex $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)'
 	$(QUIET)$(foreach p,$(ALL_LIBFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)' &&) true
+	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(msgsdir_SQ)' $(INSTALL_D1)
+	$(QUIET)$(foreach p,$(ALL_MSGFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
 
 dist-version:
 	@mkdir -p $(TARDIR)
-- 
1.5.2
