From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Makefile: track TCLTK_PATH as it used to be tracked
Date: Tue, 18 Dec 2012 15:57:52 +0100
Message-ID: <20121218145753.28253.98431.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 16:04:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkyiw-0004lv-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 16:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab2LRPEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 10:04:10 -0500
Received: from mail-1d.bbox.fr ([194.158.122.56]:34984 "EHLO mail-1d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755176Ab2LRPEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 10:04:08 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1d.bbox.fr (Postfix) with ESMTP id 4ECC7EC;
	Tue, 18 Dec 2012 16:04:05 +0100 (CET)
X-git-sha1: 700c92cf33f52a12b2e3969d3fdb7356e0d4b2f0 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211750>

A long time ago, gitk used to live at the root of the git.git
repository. In 62ba514 (Move gitk to its own subdirectory,
2007-11-17) it was moved to a subdirectory, but some code used
to track TCLTK_PATH was left in the main Makefile instead
of being moved to the new Makefile that was created in gitk-git/.

The code left in the main Makefile in git.git should now have
been removed because it was found useless.

And this patch puts some code back to track TCLTK_PATH properly
where it should be.

Note that there is already some code to do that in git-gui.

At the same time this patch creates a .gitignore and also marks
some targets in the Makefile as PHONY.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
Hi Paul,

In this thread:

http://thread.gmane.org/gmane.comp.version-control.git/211641

Junio asked me to send you this patch.
So here it is, for you to apply to your tree.

Thanks,
Christian.

 .gitignore |  2 ++
 Makefile   | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 .gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..d7ebcaf
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,2 @@
+/GIT-TCLTK-VARS
+/gitk-wish
diff --git a/Makefile b/Makefile
index e1b6045..5acdc90 100644
--- a/Makefile
+++ b/Makefile
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
