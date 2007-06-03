From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make the installation target of git-gui a little less chatty
Date: Sun, 3 Jun 2007 15:08:54 +0200
Message-ID: <20070603130854.GD2495@steel.home>
References: <20070603010044.GA4507@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 15:09:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuppN-0000U5-EZ
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 15:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbXFCNI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 09:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbXFCNI5
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 09:08:57 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:41156 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbXFCNI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 09:08:56 -0400
Received: from tigra.home (Fad9e.f.strato-dslnet.de [195.4.173.158])
	by post.webmailer.de (mrclete mo61) (RZmta 7.1)
	with ESMTP id D06fdej53B5sNQ ; Sun, 3 Jun 2007 15:08:54 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5607C277BD;
	Sun,  3 Jun 2007 15:08:54 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 568A2BE86; Sun,  3 Jun 2007 15:08:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070603010044.GA4507@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFkeiE=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48988>


Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Almost the same as Shawn's. Sending just for completeness.

 git-gui/Makefile |   34 ++++++++++++++++++++++++++++------
 1 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index 3de0de1..dfed1a1 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -2,6 +2,10 @@ all::
 
 # Define V=1 to have a more verbose compile.
 #
+QUIET =
+ifndef V
+    QUIET = @
+endif
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -108,13 +112,31 @@ GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
 
 all:: $(ALL_PROGRAMS) lib/tclIndex
 
+ifeq ($(QUIET),@)
+INST_0   = arg=
+INST_1   = &&echo  "    INSTALL $$mode $$arg"&&$(INSTALL) $$mode "$$arg" # space
+BSETUP_0 = arg=
+BSETUP_1 = &&echo  "    GIT-GUI BUILTIN $$arg"&& \
+	   rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/'"$$arg" && \
+	   ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' \
+	   '$(DESTDIR_SQ)$(gitexecdir_SQ)/'"$$arg" # space
+else
+INST_0   = $(INSTALL) $$mode # space to separate "install" and its first arg
+INST_1   =
+BSETUP_0 = arg=
+BSETUP_1 = &&rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/'"$$arg" && \
+	   ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' \
+	   '$(DESTDIR_SQ)$(gitexecdir_SQ)/'"$$arg" # space
+endif
+
 install: all
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) git-gui '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(foreach p,$(GITGUI_BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(libdir_SQ)'
-	$(INSTALL) -m644 lib/tclIndex '$(DESTDIR_SQ)$(libdir_SQ)'
-	$(foreach p,$(ALL_LIBFILES), $(INSTALL) -m644 $p '$(DESTDIR_SQ)$(libdir_SQ)' ;)
+	$(QUIET)$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)mode=;$(INST_0)git-gui $(INST_1)'$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS),$(BSETUP_0)$p $(BSETUP_1) &&):
+	$(QUIET)$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(libdir_SQ)'
+	$(QUIET)mode=-m644; \
+	    $(foreach p,lib/tclIndex $(ALL_LIBFILES), \
+	    $(INST_0)$p $(INST_1) '$(DESTDIR_SQ)$(libdir_SQ)' &&):
 
 dist-version:
 	@mkdir -p $(TARDIR)
-- 
1.5.2.182.ged6b
