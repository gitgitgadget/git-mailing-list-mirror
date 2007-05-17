From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git-gui: Build even if tclsh is not available
Date: Thu, 17 May 2007 04:06:16 +0200
Message-ID: <20070517020616.4722.33946.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 04:06:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoVNm-0000ro-Dl
	for gcvg-git@gmane.org; Thu, 17 May 2007 04:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758235AbXEQCGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 22:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754789AbXEQCGS
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 22:06:18 -0400
Received: from rover.dkm.cz ([62.24.64.27]:49694 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758235AbXEQCGR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 22:06:17 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 691998B4BF;
	Thu, 17 May 2007 04:06:16 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47480>

As of now, git fails to build with default config if tclsh is not
available, thus requiring manual config tweaking just because of some
optimizations done at build time; this is a needless hassle when building
git on any kind of a server.

This patch makes git-gui's build process to handle this gracefully; unless
TCL_PATH is explicitly set, if tclsh cannot be executed only a warning is
printed and the build goes on. I have tested this only on that server with
no tclsh, but hopefully it shouldn't break the build process with tclsh
available either.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Makefile         |    8 +++++---
 git-gui/Makefile |    2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

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
index e73b645..2b1bc18 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -34,7 +34,7 @@ ifndef V
 	QUIET_INDEX    = @echo '   ' INDEX $(dir $@);
 endif
 
-TCL_PATH   ?= tclsh
+TCL_PATH   ?= tclsh || echo "Warning: Cannot execute tclsh, not optimizing git-gui" >&2
 TCLTK_PATH ?= wish
 
 ifeq ($(findstring $(MAKEFLAGS),s),s)
