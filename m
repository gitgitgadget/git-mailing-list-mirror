From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: quieter installs
Date: Sat, 2 Jun 2007 21:00:44 -0400
Message-ID: <20070603010044.GA4507@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 03:01:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HueSo-00053u-Px
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 03:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbXFCBAu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 21:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbXFCBAu
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 21:00:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59201 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbXFCBAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 21:00:49 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HueSR-00044e-VL; Sat, 02 Jun 2007 21:00:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 105B020FBAE; Sat,  2 Jun 2007 21:00:44 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48968>

So I'm looking at adding this to git-gui, to replace Alex's patch,
as it addresses most of the issues that Junio raised.  Thoughts?

I'm a little unhappy with how mess the install target is now, but
fortunately most of it is data driven through the other variables in
the Makefile, so hopefully I don't have to tweak it too frequently.
;-)

--8>--
git-gui: Quiet our installation process

Alex Riesen wanted a quieter installation process for git and its
contained git-gui.  His earlier patch to do this failed to work
properly when V=1, and didn't really give a great indication of
what the installation was doing.

These rules are a little bit on the messy side, as each of our
install actions is composed of at least two variables, but in the
V=1 case the text is identical to what we had before, while in the
non-V=1 case we use some more complex rules to show the interesting
details, and hide the less interesting bits.

We now can also set QUIET= (nothing) to see the rules that are used
when V= (nothing), so we can debug those too if we have to.  This is
actually a side-effect of how we insert the @ into the rules we use
for the "lists of things", like our builtins or our library files.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |   42 +++++++++++++++++++++++++++++++++---------
 1 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 3de0de1..a114a87 100644
--- a/Makefile
+++ b/Makefile
@@ -29,11 +29,35 @@ ifndef INSTALL
 	INSTALL = install
 endif
 
+INSTALL_D0 = $(INSTALL) -d -m755 # space is required here
+INSTALL_D1 =
+INSTALL_R0 = $(INSTALL) -m644 # space is required here
+INSTALL_R1 =
+INSTALL_X0 = $(INSTALL) -m755 # space is required here
+INSTALL_X1 =
+INSTALL_L0 = rm -f # space is required here
+INSTALL_L1 = && ln # space is required here
+INSTALL_L2 =
+INSTALL_L3 =
+
 ifndef V
-	QUIET_GEN      = @echo '   ' GEN $@;
-	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
-	QUIET_INDEX    = @echo '   ' INDEX $(dir $@);
+	QUIET          = @
+	QUIET_GEN      = $(QUIET)echo '   ' GEN $@ &&
+	QUIET_BUILT_IN = $(QUIET)echo '   ' BUILTIN $@ &&
+	QUIET_INDEX    = $(QUIET)echo '   ' INDEX $(dir $@) &&
 	QUIET_2DEVNULL = 2>/dev/null
+
+	INSTALL_D0 = dir=
+	INSTALL_D1 = && echo ' ' DEST $$dir && $(INSTALL) -d -m755 "$$dir"
+	INSTALL_R0 = src=
+	INSTALL_R1 = && echo '   ' INSTALL 644 `basename $$src` && $(INSTALL) -m644 $$src
+	INSTALL_X0 = src=
+	INSTALL_X1 = && echo '   ' INSTALL 755 `basename $$src` && $(INSTALL) -m755 $$src
+
+	INSTALL_L0 = dst=
+	INSTALL_L1 = && src=
+	INSTALL_L2 = && dst=
+	INSTALL_L3 = && echo '   ' 'LINK       ' `basename "$$dst"` '->' `basename "$$src"` && rm -f "$$dst" && ln "$$src" "$$dst"
 endif
 
 TCL_PATH   ?= tclsh
@@ -109,12 +133,12 @@ GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
 all:: $(ALL_PROGRAMS) lib/tclIndex
 
 install: all
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) git-gui '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(foreach p,$(GITGUI_BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(libdir_SQ)'
-	$(INSTALL) -m644 lib/tclIndex '$(DESTDIR_SQ)$(libdir_SQ)'
-	$(foreach p,$(ALL_LIBFILES), $(INSTALL) -m644 $p '$(DESTDIR_SQ)$(libdir_SQ)' ;)
+	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
+	$(QUIET)$(INSTALL_X0)git-gui $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(INSTALL_L0)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L1)'$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' $(INSTALL_L2)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L3) &&) true
+	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(libdir_SQ)' $(INSTALL_D1)
+	$(QUIET)$(INSTALL_R0)lib/tclIndex $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)'
+	$(QUIET)$(foreach p,$(ALL_LIBFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)' &&) true
 
 dist-version:
 	@mkdir -p $(TARDIR)
-- 
1.5.2.901.g27ad4

-- 
Shawn.
