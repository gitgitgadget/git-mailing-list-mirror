From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui cannot find share/git-gui under cygwin
Date: Tue, 19 Jun 2007 10:49:28 -0400
Message-ID: <20070619144928.GA8477@spearce.org>
References: <4677CBD7.9050606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 16:49:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0f1S-0001Qa-M4
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 16:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbXFSOtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 10:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbXFSOtd
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 10:49:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60013 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbXFSOtc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 10:49:32 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I0f1I-00029S-QZ; Tue, 19 Jun 2007 10:49:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0138E20FBAE; Tue, 19 Jun 2007 10:49:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4677CBD7.9050606@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50487>

Mark Levedahl <mlevedahl@gmail.com> wrote:
> Commit ea75ee3598ab6f8d0828f introduced logic to guess where 
> share/git-gui/lib is at runtime, and this is broken on Cygwin. The basic 
> problem is that:
> 
> /usr/bin = c:\cygwin\bin
> /usr/share = c:\cygwin\usr\share
> 
> The detection logic correctly finds the wish binary in c:\cygwin\bin, 
> and then assumes that the share directory is c:\cygwin\share rather than 
> c:\cygwin\usr\share. Given this, git-gui does not load as it cannot find 
> its share/git-gui/lib directory

Yuck.  I'm considering applying the following.  It works ok on Mac
OS X where the bug isn't triggered anyway.  ;-) I won't be able to
test on Cygwin until tomorrow.

-->8--
git-gui: Correctly install to /usr/bin on Cygwin

Mark Levedahl <mlevedahl@gmail.com> noted that installation on Cygwin
to /usr/bin can cause problems with the automatic guessing of our
library location.  The problem is that installation to /usr/bin
means we actually have:

  /usr/bin   = c:\cygwin\bin
  /usr/share = c:\cygwin\usr\share

So git-gui guesses that its library should be found within the
c:\cygwin\share directory, as that is where it should be relative
to the script itself in c:\cygwin\bin.

In this case we have to use `cygpath` during installation to find out
what the mapping is from the UNIX path we are seeing in GNU make,
to the Windows path we will actually see in our Tcl/Tk process.
After that mapping has been performed we can then test to see if
our share directory can be found by relative location, or if we
need to encode the absolute location.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 3de0de1..1c01c83 100644
--- a/Makefile
+++ b/Makefile
@@ -7,6 +7,8 @@ GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
+uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
+
 SCRIPT_SH = git-gui.sh
 GITGUI_BUILT_INS = git-citool
 ALL_PROGRAMS = $(GITGUI_BUILT_INS) $(patsubst %.sh,%,$(SCRIPT_SH))
@@ -58,14 +60,22 @@ exedir_SQ = $(subst ','\'',$(exedir))
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	$(QUIET_GEN)rm -f $@ $@+ && \
-	if test '$(exedir_SQ)' = '$(libdir_SQ)'; then \
+	A='$(exedir_SQ)' && \
+	B='$(libdir_SQ)' && \
+	if test "$(uname_O)" = Cygwin; then \
+		A="$$(cygpath -m -a "$$A")" && \
+		B="$$(cygpath -m -a "$$B")"; \
+	fi && \
+	if test "$$A" = "$$B"; then \
 		GITGUI_RELATIVE=1; \
+	else \
+		GITGUI_RELATIVE=; \
 	fi && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 		-e 's|^exec wish "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' \
 		-e 's/@@GITGUI_VERSION@@/$(GITGUI_VERSION)/g' \
 		-e 's|@@GITGUI_RELATIVE@@|'$$GITGUI_RELATIVE'|' \
-		-e $$GITGUI_RELATIVE's|@@GITGUI_LIBDIR@@|$(libdir_SQ)|' \
+		-e $$GITGUI_RELATIVE"s|@@GITGUI_LIBDIR@@|$$B|" \
 		$@.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
-- 
1.5.2.2.1012.ge05f4


-- 
Shawn.
