From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git-gui: Build even if tclsh is not available
Date: Thu, 17 May 2007 04:14:48 +0200
Message-ID: <20070517021448.24022.8282.stgit@rover>
References: <20070517020616.4722.33946.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 04:14:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoVW3-0001oH-Id
	for gcvg-git@gmane.org; Thu, 17 May 2007 04:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757575AbXEQCOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 22:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758257AbXEQCOu
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 22:14:50 -0400
Received: from rover.dkm.cz ([62.24.64.27]:47768 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757575AbXEQCOu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 22:14:50 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id C43418B4BF;
	Thu, 17 May 2007 04:14:48 +0200 (CEST)
In-Reply-To: <20070517020616.4722.33946.stgit@rover>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47482>

As of now, git fails to build with default config if tclsh is not
available, thus requiring manual config tweaking just because of some
optimizations done at build time; this is a needless hassle when building
git on any kind of a server.

This patch makes git-gui's build process to handle this gracefully; unless
TCL_PATH is explicitly set, if tclsh cannot be executed only a warning is
printed and the build goes on. I have tested this only on that server with
no tclsh, but hopefully it shouldn't break the build process with tclsh
available either.

Version 2, sorry - the previous version of the patch had the install hunk
missing. And apologies for the duplicate submission... :-)

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Makefile         |    8 +++++---
 git-gui/Makefile |    4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 07411ff..ed12577 100644
--- a/Makefile
+++ b/Makefile
@@ -178,10 +178,12 @@ AR = ar
 TAR = tar
 INSTALL = install
 RPMBUILD = rpmbuild
-TCL_PATH = tclsh
-TCLTK_PATH = wish
 
-export TCL_PATH TCLTK_PATH
+# If TCL_PATH is not defined here, it will default to tclsh later
+# with the exception that if tclsh cannot be executed, the optimization
+# step is skipped.
+# export TCL_PATH = tclsh
+export TCLTK_PATH = wish
 
 # sparse is architecture-neutral, which means that we need to tell it
 # explicitly what architecture to check for. Fix this up for yours..
diff --git a/git-gui/Makefile b/git-gui/Makefile
index e73b645..be3cfbb 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -34,7 +34,7 @@ ifndef V
 	QUIET_INDEX    = @echo '   ' INDEX $(dir $@);
 endif
 
-TCL_PATH   ?= tclsh
+TCL_PATH   ?= tclsh || echo "Warning: Cannot execute tclsh, not optimizing git-gui" >&2
 TCLTK_PATH ?= wish
 
 ifeq ($(findstring $(MAKEFLAGS),s),s)
@@ -92,7 +92,7 @@ install: all
 	$(INSTALL) git-gui '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(foreach p,$(GITGUI_BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(libdir_SQ)'
-	$(INSTALL) -m644 lib/tclIndex '$(DESTDIR_SQ)$(libdir_SQ)'
+	[ ! -e lib/tclIndex ] || $(INSTALL) -m644 lib/tclIndex '$(DESTDIR_SQ)$(libdir_SQ)'
 	$(foreach p,$(ALL_LIBFILES), $(INSTALL) -m644 $p '$(DESTDIR_SQ)$(libdir_SQ)' ;)
 
 dist-version:
