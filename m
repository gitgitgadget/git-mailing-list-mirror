From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/4] gitk-git/Makefile: track TCLTK_PATH as it used to be
 tracked
Date: Mon, 17 Dec 2012 08:17:14 +0100
Message-ID: <20121217071716.26209.54407.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:20:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkV03-0004N7-89
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042Ab2LQHUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:20:09 -0500
Received: from [194.158.122.56] ([194.158.122.56]:44316 "EHLO mail-1d.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750976Ab2LQHUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:20:08 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1d.bbox.fr (Postfix) with ESMTP id 7A3D6E6;
	Mon, 17 Dec 2012 08:19:47 +0100 (CET)
X-git-sha1: 1f94075878e96f10720833d8433e535899df9457 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211641>

In 62ba514 (Move gitk to its own subdirectory, 2007-11-17) some
code used to track TCLTK_PATH was left in the main Makefile instead
of being moved to the new Makefile that was created in gitk-git/.

The code left in the main Makefile should have been removed by a
previous patch in the same series as this one.

And this patch puts some code back to track TCLTK_PATH properly
where it should be, that is in gitk-git/Makefile.

Note that there is already some code to do that in git-gui/Makefile.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .gitignore          |  1 -
 gitk-git/.gitignore |  2 ++
 gitk-git/Makefile   | 16 ++++++++++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)
 create mode 100644 gitk-git/.gitignore

diff --git a/.gitignore b/.gitignore
index 086c5af..56a4b2b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -171,7 +171,6 @@
 /git-whatchanged
 /git-write-tree
 /git-core-*/?*
-/gitk-git/gitk-wish
 /gitweb/GITWEB-BUILD-OPTIONS
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
diff --git a/gitk-git/.gitignore b/gitk-git/.gitignore
new file mode 100644
index 0000000..d7ebcaf
--- /dev/null
+++ b/gitk-git/.gitignore
@@ -0,0 +1,2 @@
+/GIT-TCLTK-VARS
+/gitk-wish
diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index e1b6045..5acdc90 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -17,6 +17,16 @@ DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
+### Detect Tck/Tk interpreter path changes
+TRACK_TCLTK = $(subst ','\'',-DTCLTK_PATH='$(TCLTK_PATH_SQ)')
+
+GIT-TCLTK-VARS: FORCE
+	@VARS='$(TRACK_TCLTK)'; \
+		if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
+			echo 1>&2 "    * new Tcl/Tk interpreter location"; \
+			echo "$$VARS" >$@; \
+		fi
+
 ## po-file creation rules
 XGETTEXT   ?= xgettext
 ifdef NO_MSGFMT
@@ -49,9 +59,9 @@ uninstall::
 	$(RM) '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
 
 clean::
-	$(RM) gitk-wish po/*.msg
+	$(RM) gitk-wish po/*.msg GIT-TCLTK-VARS
 
-gitk-wish: gitk
+gitk-wish: gitk GIT-TCLTK-VARS
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' <gitk >$@+ && \
 	chmod +x $@+ && \
@@ -65,3 +75,5 @@ $(ALL_MSGFILES): %.msg : %.po
 	@echo Generating catalog $@
 	$(MSGFMT) --statistics --tcl $< -l $(basename $(notdir $<)) -d $(dir $@)
 
+.PHONY: all install uninstall clean update-po
+.PHONY: FORCE
-- 
1.8.1.rc1.2.g8740035
