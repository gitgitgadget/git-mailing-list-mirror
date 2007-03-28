From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] Added Tcl/Tk interpreter path rewriting for the GUI tools.
Date: Wed, 28 Mar 2007 13:13:44 +0400
Message-ID: <20070328091344.GR14837@codelabs.ru>
References: <200703261030.49382.jnareb@gmail.com> <7vmz20xuxq.fsf@assigned-by-dhcp.cox.net> <20070326100344.GV14837@codelabs.ru> <7vejnbtjdq.fsf@assigned-by-dhcp.cox.net> <20070327065940.GC51155@codelabs.ru> <20070327102437.GM14837@codelabs.ru> <7vtzw7nej6.fsf@assigned-by-dhcp.cox.net> <20070327110714.GA14837@codelabs.ru> <7vps6um8wv.fsf@assigned-by-dhcp.cox.net> <20070328091209.GQ14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 11:14:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWUEO-00006P-Nm
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 11:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933816AbXC1JNw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 05:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934031AbXC1JNw
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 05:13:52 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:61781 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934018AbXC1JNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 05:13:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=cXOx2Ys8OenESw9HgLEZQ5iaA3qR6mromYftjk8N4BSu1lUnSRy2tXC8CDh4ZoShQcJ/7eOTL9pI915QT0l3KgNWlVO6nTQ/lB53oRsr1Kxqk0BMxiUOOKqZY1UUe/tGYaR+58G/yxmLy+xg8ueowkCEnGRIQ9XyBlqzJZaKFH8=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HWUE0-000FD7-Sk; Wed, 28 Mar 2007 13:13:49 +0400
Content-Disposition: inline
In-Reply-To: <20070328091209.GQ14837@codelabs.ru>
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43363>

--with-tcltk=/path/to/wish sets the TCLTK_PATH variable that is
used to substitute the location of the wish interpreter in the
Tcl/Tk programs.

New tracking file, GIT-GUI-VARS, was introduced: it tracks the
location of the Tcl/Tk interpreter and activates the GUI tools
rebuild if the interpreter path was changed. The separate tracker
is better than the GIT-CFLAGS: there is no need to rebuild the whole
git if the interpreter path was changed.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 Makefile         |   31 ++++++++++++++++++++++++++++---
 git-gui/Makefile |   17 +++++++++++++++--
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index bfde029..0034666 100644
--- a/Makefile
+++ b/Makefile
@@ -690,11 +690,15 @@ export prefix gitexecdir TAR INSTALL DESTDIR SHELL_PATH template_dir
 
 ### Build rules
 
-all:: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk gitweb/gitweb.cgi
+all:: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitweb/gitweb.cgi
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), rm -f '$p';)
 endif
 
+ifndef NO_TCLTK
+all:: gitk-wish
+endif
+
 all::
 ifndef NO_TCLTK
 	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) all
@@ -705,6 +709,12 @@ endif
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
+gitk-wish: gitk GIT-GUI-VARS
+	$(QUIET_GEN)rm -f $@ $@+ && \
+	sed -e'1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' < gitk > $@+ && \
+	chmod +x $@+ && \
+	mv -f $@+ $@
+
 git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS) GIT-CFLAGS
 	$(QUIET_LINK)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
@@ -892,6 +902,18 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 		echo "$$FLAGS" >GIT-CFLAGS; \
             fi
 
+### Detect Tck/Tk interpreter path changes
+ifndef NO_TCLTK
+TRACK_VARS = $(subst ','\'',-DTCLTK_PATH='$(TCLTK_PATH_SQ)')
+
+GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
+	@VARS='$(TRACK_VARS)'; \
+	    if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
+		echo 1>&2 "    * new Tcl/Tk interpreter location"; \
+		echo "$$VARS" >$@; \
+            fi
+endif
+
 ### Testing rules
 
 # GNU make supports exporting all variables by "export" without parameters.
@@ -934,7 +956,7 @@ install: all
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
 ifndef NO_TCLTK
-	$(INSTALL) gitk '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
 endif
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix='$(prefix_SQ)' install
@@ -1030,10 +1052,13 @@ ifndef NO_TCLTK
 endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
-	rm -f GIT-VERSION-FILE GIT-CFLAGS
+	rm -f GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS
 
 .PHONY: all install clean strip
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags .FORCE-GIT-CFLAGS
+ifndef NO_TCLTK
+.PHONY: .FORCE-GIT-GUI-VARS
+endif
 
 ### Check documentation
 #
diff --git a/git-gui/Makefile b/git-gui/Makefile
index 733c07e..4ef6fac 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -40,10 +40,13 @@ gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
+git-gui: GIT-GUI-VARS
+
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	$(QUIET_GEN)rm -f $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 		-e 's/@@GITGUI_VERSION@@/$(GITGUI_VERSION)/g' \
+		-e'1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' \
 		$@.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
@@ -66,7 +69,17 @@ dist-version:
 	@echo $(GITGUI_VERSION) > $(TARDIR)/version
 
 clean::
-	rm -f $(ALL_PROGRAMS) GIT-VERSION-FILE
+	rm -f $(ALL_PROGRAMS) GIT-VERSION-FILE GIT-GUI-VARS
+
+### Detect Tck/Tk interpreter path changes
+TRACK_VARS = $(subst ','\'',-DTCLTK_PATH='$(TCLTK_PATH_SQ)')
+
+GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
+	@VARS='$(TRACK_VARS)'; \
+	    if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
+		echo 1>&2 "    * new Tcl/Tk interpreter location"; \
+		echo "$$VARS" >$@; \
+            fi
 
 .PHONY: all install dist-version clean
-.PHONY: .FORCE-GIT-VERSION-FILE
+.PHONY: .FORCE-GIT-VERSION-FILE .FORCE-GIT-GUI-VARS
-- 
1.5.0.3-dirty
