From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make the installation targets a little less chatty
Date: Sat, 2 Jun 2007 01:09:24 +0200
Message-ID: <20070601230924.GA6360@steel.home>
References: <20070531222313.GA12204@steel.home> <7v4pls1qjv.fsf@assigned-by-dhcp.cox.net> <81b0412b0706010035s5fc38dc6y6f985675cc3c069@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 02 01:09:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuGFU-0001qd-Ak
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 01:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758536AbXFAXJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 19:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758519AbXFAXJ2
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 19:09:28 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:56014 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758536AbXFAXJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 19:09:27 -0400
Received: from tigra.home (Fa970.f.strato-dslnet.de [195.4.169.112])
	by post.webmailer.de (mrclete mo47) (RZmta 6.8)
	with ESMTP id H01510j51MFcMp ; Sat, 2 Jun 2007 01:09:24 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id ADD8B277BD;
	Sat,  2 Jun 2007 01:09:24 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 6A518BE86; Sat,  2 Jun 2007 01:09:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0706010035s5fc38dc6y6f985675cc3c069@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNmRtBQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48896>

by default. V=1 works as usual.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Makefile           |   35 ++++++++++++++++++++++-------------
 templates/Makefile |    5 +++--
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index cac0a4a..f2c9b39 100644
--- a/Makefile
+++ b/Makefile
@@ -660,8 +660,10 @@ ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
 endif
 
+QUIET=
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
+QUIET_MSG      = :
 
 ifneq ($(findstring $(MAKEFLAGS),w),w)
 PRINT_DIR = --no-print-directory
@@ -671,6 +673,9 @@ endif
 
 ifneq ($(findstring $(MAKEFLAGS),s),s)
 ifndef V
+	QUIET = @
+
+	QUIET_MSG      = echo  '   '
 	QUIET_CC       = @echo '   ' CC $@;
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;
@@ -973,33 +978,37 @@ check: common-cmds.h
 ### Installation rules
 
 install: all
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
-	$(MAKE) -C perl prefix='$(prefix_SQ)' install
+	$(QUIET)$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(QUIET)$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)$(foreach p,$(ALL_PROGRAMS),$(QUIET_MSG)INSTALL $p;\
+	    $(INSTALL) '$p' '$(DESTDIR_SQ)$(gitexecdir_SQ)';)
+	$(QUIET)$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(QUIET)$(foreach p,$(BUILT_INS)   ,$(QUIET_MSG)SETUP BUILTIN $p;\
+	    rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && \
+	    ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
+	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) DESTDIR='$(DESTDIR_SQ)' install
+	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) prefix='$(prefix_SQ)' install
 ifndef NO_TCLTK
-	$(INSTALL) gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
-	$(MAKE) -C git-gui install
+	$(QUIET)$(INSTALL) gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) install
 endif
-	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
+	@if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
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
1.5.2.162.g8fc0
