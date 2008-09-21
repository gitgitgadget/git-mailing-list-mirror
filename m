From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/7] Windows: Add workaround for MSYS' path conversion
Date: Sun, 21 Sep 2008 18:24:32 +0200
Message-ID: <1222014278-11071-2-git-send-email-prohaska@zib.de>
References: <1222014278-11071-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 21 18:27:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhRm7-0001PG-4u
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 18:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbYIUQZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 12:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbYIUQZZ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 12:25:25 -0400
Received: from mailer.zib.de ([130.73.108.11]:50385 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbYIUQZY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 12:25:24 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m8LGOd3f004994;
	Sun, 21 Sep 2008 18:24:44 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m8LGOcxO015855;
	Sun, 21 Sep 2008 18:24:39 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1222014278-11071-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96402>

MSYS' automatic path conversion causes problems when passing paths as
defines ('-D' arguments to the compiler).  MSYS tries to be smart and
converts absolute paths to native Windows paths, e.g. if MSYS sees
"/bin" it converts it to "c:/msysgit/bin".  But we want completely
unmodified paths; e.g. if we set bindir in the Makefile to "/bin", the
define BINDIR shall expand to "/bin".  Conversion to absolute Windows
path will takes place later, during runtime.

This commit adds a workaround by replacing "/" with its octal
representation "\057", effectively hiding the path from MSYS' path
conversion mechanism.  MSYS does no longer see the absolute path and
therefore leaves it alone.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 3c0664a..140a2b2 100644
--- a/Makefile
+++ b/Makefile
@@ -1066,6 +1066,12 @@ template_dir_SQ = $(subst ','\'',$(template_dir))
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
@@ -1117,7 +1123,7 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 
 builtin-help.o: builtin-help.c common-cmds.h GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
-		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
+		'-DGIT_HTML_PATH="$(htmldir_SQ_C)"' \
 		'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 		'-DGIT_INFO_PATH="$(infodir_SQ)"' $<
 
@@ -1224,12 +1230,12 @@ git.o git.spec \
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
1.6.0.2.GIT
