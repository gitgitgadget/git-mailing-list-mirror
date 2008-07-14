From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 0/5] replacement for the part of js/more-win that is in pu
Date: Mon, 14 Jul 2008 23:41:24 +0200
Message-ID: <1216071689-14823-1-git-send-email-johannes.sixt@telecom.at>
References: <1216025226.487b128a031fd@webmail.eunet.at>
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 23:42:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIVoZ-0002Di-1k
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 23:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756965AbYGNVle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 17:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756957AbYGNVld
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 17:41:33 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:40581 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756438AbYGNVlc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 17:41:32 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id DDAAA13AB7B;
	Mon, 14 Jul 2008 23:41:29 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.3.323.g1e58
In-Reply-To: <1216025226.487b128a031fd@webmail.eunet.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88468>

The interdiff to js/more-win is below. It is mostly the changes
of 1/5.

Johannes Sixt (5):
      Makefile: Normalize $(bindir) and $(gitexecdir) before comparing
      Record the command invocation path early
      Fix relative built-in paths to be relative to the command
         invocation
      Allow the built-in exec path to be relative to the command
         invocation path
      Allow add_path() to add non-existent directories to the path


 Makefile       |   33 +++++++++++++++++-----------
 abspath.c      |   36 ++++++++++++++++++++++++++++++
 exec_cmd.c     |   54 +++++++++++----------------------------------
 exec_cmd.h     |    3 +-
 git.c          |    5 +--
 path.c         |   36 ------------------------------
 receive-pack.c |    2 +-
 shell.c        |    4 +-
 upload-pack.c  |    2 +-
 9 files changed, 77 insertions(+), 98 deletions(-)


diff --git a/Makefile b/Makefile
index 3593e6f..4df6423 100644
--- a/Makefile
+++ b/Makefile
@@ -1301,14 +1301,14 @@ remove-dashes:
 ### Installation rules
 
 ifeq ($(firstword $(subst /, ,$(template_dir))),..)
-template_instdir = $(shell cd '$(bindir_SQ)/$(template_dir_SQ)' && pwd)
+template_instdir = $(bindir)/$(template_dir)
 else
 template_instdir = $(template_dir)
 endif
 export template_instdir
 
 ifeq ($(firstword $(subst /, ,$(gitexecdir))),..)
-gitexec_instdir = $(shell cd '$(bindir_SQ)/$(gitexecdir_SQ)' && pwd)
+gitexec_instdir = $(bindir)/$(gitexecdir)
 else
 gitexec_instdir = $(gitexecdir)
 endif
@@ -1325,18 +1325,18 @@ ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
 	$(MAKE) -C git-gui install
 endif
-	if test 'z$(bindir_SQ)' != 'z$(gitexec_instdir_SQ)'; \
-	then \
-		ln -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
-			'$(DESTDIR_SQ)$(gitexec_instdir_SQ)/git$X' || \
-		cp '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
-			'$(DESTDIR_SQ)$(gitexec_instdir_SQ)/git$X'; \
-	fi
-	$(foreach p,$(BUILT_INS), $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' ;)
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
 endif
-	./check_bindir 'z$(bindir_SQ)' 'z$(gitexec_instdir_SQ)' '$(DESTDIR_SQ)$(bindir_SQ)/git-shell$X'
+	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
+	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
+	if test "z$$bindir" != "z$$execdir"; \
+	then \
+		ln -f "$$bindir/git$X" "$$execdir/git$X" || \
+		cp "$$bindir/git$X" "$$execdir/git$X"; \
+	fi && \
+	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/git$X" "$$execdir/$p" ;) } && \
+	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-shell$X"
 
 install-doc:
 	$(MAKE) -C Documentation install
