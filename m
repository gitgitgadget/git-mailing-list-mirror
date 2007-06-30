From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] Makefile: USE_SYMLINK option
Date: Sat, 30 Jun 2007 20:14:56 +0200
Message-ID: <20070630181456.GA15035@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 30 20:15:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4hTK-0005vg-Ps
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 20:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbXF3SPB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 14:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753078AbXF3SPB
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 14:15:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:53198 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752844AbXF3SPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 14:15:00 -0400
Received: (qmail invoked by alias); 30 Jun 2007 18:14:58 -0000
Received: from pD9EB8ACF.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.207]
  by mail.gmx.net (mp038) with SMTP; 30 Jun 2007 20:14:58 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18OqEEKaZMOWAwtKjGhlVFAOZm0nJ5RHjTxvYshgK
	jr2Abh9qqPD4VN
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51238>

When USE_SYMLINK is defined symlinks will be used instead of hardlinks.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
I found no real drawback using symlinks and symlinks are sometimes
more practical, for example when copying/creating a tarball of the
installation.
---
 Makefile |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 4ea5e45..db0b818 100644
--- a/Makefile
+++ b/Makefile
@@ -181,6 +181,11 @@ INSTALL = install
 RPMBUILD = rpmbuild
 TCL_PATH = tclsh
 TCLTK_PATH = wish
+ifdef USE_SYMLINK
+LN = ln -s
+else
+LN = ln
+endif
 
 export TCL_PATH TCLTK_PATH
 
@@ -759,10 +764,10 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 help.o: common-cmds.h
 
 git-merge-subtree$X: git-merge-recursive$X
-	$(QUIET_BUILT_IN)rm -f $@ && ln git-merge-recursive$X $@
+	$(QUIET_BUILT_IN)rm -f $@ && $(LN) git-merge-recursive$X $@
 
 $(BUILT_INS): git$X
-	$(QUIET_BUILT_IN)rm -f $@ && ln git$X $@
+	$(QUIET_BUILT_IN)rm -f $@ && $(LN) git$X $@
 
 common-cmds.h: ./generate-cmdlist.sh
 
@@ -1004,12 +1009,16 @@ ifndef NO_TCLTK
 endif
 	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
 	then \
-		ln -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
+		$(LN) -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
 			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' || \
 		cp '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
 			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
 	fi
-	$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
+ifdef USE_SYMLINK
+	$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && $(LN) 'git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
+else
+	$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && $(LN) '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
+endif
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
 endif
-- 
1.5.0.3
