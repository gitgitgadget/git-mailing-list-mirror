From: "Shawn O. Pearce" <shawn.o.pearce@bankofamerica.com>
Subject: [PATCH] Allow gitk to start on Cygwin with native Win32 Tcl/Tk
Date: Sat, 22 Sep 2007 01:04:47 -0400
Message-ID: <20070922050446.GA28467@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 07:05:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYxAq-0005Tv-Oc
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 07:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbXIVFEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 01:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbXIVFEy
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 01:04:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38304 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbXIVFEx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 01:04:53 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IYxAc-0004br-EE; Sat, 22 Sep 2007 01:04:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D870720FBAE; Sat, 22 Sep 2007 01:04:47 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58916>

If TCLTK_PATH points at a pure Win32 Tcl/Tk implementation but you
are running git (and thus gitk) from within Cygwin the value of
$0 is a UNIX style Cygwin path which the native Tcl/Tk is unable
to open and parse.  In such a situation we need to switch to using
the Windows style path by running $0 through cygpath.

This doesn't have a negative impact when using the Cygwin based
Tcl/Tk build as that is still close enough to a native Win32
application that it can read the Windows style path when sourcing
gitk.  On any other platform we don't want gitk to do anything
different so we keep argv0=$0.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Yes, I admit this is an odd patch.  I can certainly carry it in
 my own tree (I already carry some other patches) but I wonder if
 we shouldn't include it as some users may actually try to do this,
 just like I did.  Latest git-gui `master` already has changes to its
 Makefile and shell startup boilerplate to handle this weird case.

 Makefile |    6 +++++-
 gitk     |    3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 0055eef..4fc6eb3 100644
--- a/Makefile
+++ b/Makefile
@@ -386,6 +386,7 @@ EXTLIBS =
 #
 # Platform specific tweaks
 #
+gitk_argv0 := $$0
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
@@ -443,6 +444,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_MMAP = YesPlease
 	NO_IPV6 = YesPlease
 	X = .exe
+	gitk_argv0 := `cygpath --windows --absolute "$(gitk_argv0)"`
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
@@ -763,7 +765,9 @@ strip: $(PROGRAMS) git$X
 
 gitk-wish: gitk GIT-GUI-VARS
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' <gitk >$@+ && \
+	sed -e '1,30s|^argv0=$$0|argv0=$(gitk_argv0)|' \
+	    -e '1,4s|^exec .* "$$argv0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$argv0"|' \
+	    <gitk >$@+ && \
 	chmod +x $@+ && \
 	mv -f $@+ $@
 
diff --git a/gitk b/gitk
index 300fdce..2366911 100755
--- a/gitk
+++ b/gitk
@@ -1,6 +1,7 @@
 #!/bin/sh
 # Tcl ignores the next line -*- tcl -*- \
-exec wish "$0" -- "$@"
+argv0=$0; \
+exec wish "$argv0" -- "$@"
 
 # Copyright (C) 2005-2006 Paul Mackerras.  All rights reserved.
 # This program is free software; it may be used, copied, modified
-- 
1.5.3.2.1036.gcd14a
