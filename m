From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/7] Windows: Add workaround for MSYS' path conversion
Date: Sun, 17 Aug 2008 14:44:37 +0200
Message-ID: <1218977083-14526-2-git-send-email-prohaska@zib.de>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 17 14:46:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUheJ-0001kf-BT
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 14:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbYHQMpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 08:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754258AbYHQMpR
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 08:45:17 -0400
Received: from mailer.zib.de ([130.73.108.11]:52108 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933AbYHQMpP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 08:45:15 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m7HCivPX022015;
	Sun, 17 Aug 2008 14:45:02 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m7HCihbO002872;
	Sun, 17 Aug 2008 14:44:43 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1218977083-14526-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92603>

MSYS' automatic path conversion causes problems when passing paths as '-D'
arguments to the compiler.  MSYS tries to be smart and converts absolute
paths to native Windows paths.  But we want the paths as we compute them in
the Makefile.

This commit adds a workaround by replacing "/" with its octal
representation "\057", effectively hiding the path from MSYS.  MSYS does no
longer see the absolute path and therefore leaves it alone.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 53ab4b5..9df5a9d 100644
--- a/Makefile
+++ b/Makefile
@@ -1042,6 +1042,12 @@ template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_SQ = $(subst ','\'',$(htmldir))
 prefix_SQ = $(subst ','\'',$(prefix))
 
+ETC_GITCONFIG_SQ_C = $(subst /,\057,$(ETC_GITCONFIG_SQ))
+bindir_SQ_C = $(subst /,\057,$(bindir_SQ))
+gitexecdir_SQ_C = $(subst /,\057,$(gitexecdir_SQ))
+htmldir_SQ_C = $(subst /,\057,$(htmldir_SQ))
+template_dir_SQ_C = $(subst /,\057,$(template_dir_SQ))
+
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
@@ -1093,7 +1099,7 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 
 help.o: help.c common-cmds.h GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
-		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
+		'-DGIT_HTML_PATH="$(htmldir_SQ_C)"' \
 		'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 		'-DGIT_INFO_PATH="$(infodir_SQ)"' $<
 
@@ -1197,12 +1203,12 @@ git.o git.spec \
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ_C)"' -DBINDIR='"$(bindir_SQ_C)"' $<
 builtin-init-db.o: builtin-init-db.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ_C)"' $<
 
 config.o: config.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"' $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ_C)"' $<
 
 http.o: http.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
-- 
1.6.0.rc3.22.g053fd
