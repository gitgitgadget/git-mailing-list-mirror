From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make the installation targets a little less chatty
Date: Sun, 3 Jun 2007 15:07:45 +0200
Message-ID: <20070603130745.GC2495@steel.home>
References: <20070603010044.GA4507@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 15:07:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HupoH-0000JC-2h
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 15:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbXFCNHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 09:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbXFCNHs
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 09:07:48 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:27778 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbXFCNHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 09:07:47 -0400
Received: from tigra.home (Fad9e.f.strato-dslnet.de [195.4.173.158])
	by post.webmailer.de (klopstock mo7) (RZmta 7.1)
	with ESMTP id R007f1j53B1kz2 ; Sun, 3 Jun 2007 15:07:45 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6BE54277BD;
	Sun,  3 Jun 2007 15:07:45 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 49DC5BE86; Sun,  3 Jun 2007 15:07:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070603010044.GA4507@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFkeiE=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48987>

by default. V=1 works as usual.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Updated. BTW, where does "no $(call) in Makefile" came from?
It could simplify the thing a lot

 Makefile           |   44 +++++++++++++++++++++++++++++++++-----------
 templates/Makefile |    5 +++--
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index cac0a4a..6409b9c 100644
--- a/Makefile
+++ b/Makefile
@@ -660,6 +660,7 @@ ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
 endif
 
+QUIET=
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -671,6 +672,8 @@ endif
 
 ifneq ($(findstring $(MAKEFLAGS),s),s)
 ifndef V
+	QUIET = @
+
 	QUIET_CC       = @echo '   ' CC $@;
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;
@@ -972,34 +975,53 @@ check: common-cmds.h
 
 ### Installation rules
 
+ifeq ($(QUIET),@)
+INST_0   = arg=
+INST_1   = &&echo  "    INSTALL $$arg"&&$(INSTALL) "$$arg" # space
+BSETUP_0 = arg=
+BSETUP_1 = &&echo  "    SETUP BUILTIN $$arg"&& \
+	   rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/'"$$arg" && \
+	   ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$(X)' \
+	   '$(DESTDIR_SQ)$(gitexecdir_SQ)/'"$$arg" # space
+else
+INST_0   = $(INSTALL) # space to separate "install" and its first arg
+INST_1   =
+BSETUP_0 = arg=
+BSETUP_1 = &&rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/'"$$arg" && \
+	   ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$(X)' \
+	   '$(DESTDIR_SQ)$(gitexecdir_SQ)/'"$$arg" # space
+endif
+
 install: all
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
-	$(MAKE) -C perl prefix='$(prefix_SQ)' install
+	$(QUIET)$(foreach p,$(ALL_PROGRAMS),\
+	    $(INST_0)'$p' $(INST_1)'$(DESTDIR_SQ)$(gitexecdir_SQ)' &&):
+	$(QUIET)$(INST_0)git$X $(INST_1)'$(DESTDIR_SQ)$(bindir_SQ)'
+	$(QUIET)$(foreach p,$(BUILT_INS),$(BSETUP_0)$p $(BSETUP_1)&&):
+	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) DESTDIR='$(DESTDIR_SQ)' install
+	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) prefix='$(prefix_SQ)' install
 ifndef NO_TCLTK
-	$(INSTALL) gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
-	$(MAKE) -C git-gui install
+	$(QUIET)$(INST_0)gitk-wish $(INST_1)'$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) install
 endif
-	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
+	$(QUIET)if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
 	then \
 		ln -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
 			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' || \
 		cp '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
 			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
 	fi
-	$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
+	@echo cleaning '$(DESTDIR_SQ)$(gitexecdir_SQ)' of old scripts
+	$(QUIET)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
 endif
 
 install-doc:
-	$(MAKE) -C Documentation install
+	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) install
 
 quick-install-doc:
-	$(MAKE) -C Documentation quick-install
+	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) quick-install
 
 
 
diff --git a/templates/Makefile b/templates/Makefile
index b8352e7..b9a39e2 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -45,6 +45,7 @@ clean:
 	rm -rf blt boilerplates.made
 
 install: all
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(template_dir_SQ)'
-	(cd blt && $(TAR) cf - .) | \
+	@echo installing templates
+	$(QUIET)$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(template_dir_SQ)'
+	$(QUIET)(cd blt && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(template_dir_SQ)' && $(TAR) xf -)
-- 
1.5.2.182.ged6b
