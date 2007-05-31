From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make the installation targets a little less chatty
Date: Fri, 1 Jun 2007 00:23:13 +0200
Message-ID: <20070531222313.GA12204@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 00:23:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htt3W-0003wE-E9
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 00:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbXEaWXR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 18:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbXEaWXR
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 18:23:17 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:60109 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758220AbXEaWXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 18:23:16 -0400
Received: from tigra.home (Fac85.f.strato-dslnet.de [195.4.172.133])
	by post.webmailer.de (fruni mo17) (RZmta 6.8)
	with ESMTP id E04b60j4VKZRnS ; Fri, 1 Jun 2007 00:23:13 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8DE28277BD;
	Fri,  1 Jun 2007 00:23:13 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5737BBE86; Fri,  1 Jun 2007 00:23:13 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFzytn4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48822>

by default. V=1 works as usual.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Now it quite quiet. I tried top show every installed file, but it
wasn't an improvement at all so I decided to just show what's being
done.

 Makefile           |   32 +++++++++++++++++++-------------
 templates/Makefile |    5 +++--
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index cac0a4a..fccc57b 100644
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
@@ -973,33 +976,36 @@ check: common-cmds.h
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
+	@echo installing programs
+	$(QUIET)$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
+	@echo setting up builtins
+	$(QUIET)$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
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
1.5.2.162.gbaa1f
