From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 19/40] Windows: Change the name of hook scripts to make them not executable.
Date: Wed, 27 Feb 2008 19:54:42 +0100
Message-ID: <1204138503-6126-20-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVZ-00022R-FY
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667AbYB0S4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755649AbYB0S4S
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:18 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40430 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbYB0SzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:09 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 6BDC3974B1;
	Wed, 27 Feb 2008 19:55:07 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75254>

Since on Windows there is no 'executable' bit whose absence would deny
execution of a script, we must change the hook scripts' names entirely
to inhibit that they can be invoked by the tools.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile           |    3 ++-
 templates/Makefile |    8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 069939f..7d4a591 100644
--- a/Makefile
+++ b/Makefile
@@ -547,6 +547,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o
 	EXTLIBS += -lws2_32
 	X = .exe
+	NOEXECTEMPL = .noexec
 endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
@@ -849,7 +850,7 @@ ifndef NO_TCLTK
 	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
 endif
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
-	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
+	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) NOEXECTEMPL='$(NOEXECTEMPL)'
 
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
diff --git a/templates/Makefile b/templates/Makefile
index ebd3a62..b341105 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -10,6 +10,8 @@ RM ?= rm -f
 prefix ?= $(HOME)
 template_dir ?= $(prefix)/share/git-core/templates
 # DESTDIR=
+# set NOEXECTEMPL to non-empty to change the names of hook scripts
+# so that the tools will not find them
 
 # Shell quote (do not use $(call) to accommodate ancient setups);
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
@@ -32,7 +34,11 @@ boilerplates.made : $(bpsrc)
 		mkdir -p blt/$$dir && \
 		case "$$boilerplate" in \
 		*--) ;; \
-		*) cp $$boilerplate blt/$$dst ;; \
+		*) if test -n "$$(sed -ne '/^#!\//p' -e '1q' < "$$boilerplate")"; then \
+			cp "$$boilerplate" "blt/$${dst}$(NOEXECTEMPL)"; \
+		   else \
+			cp "$$boilerplate" "blt/$$dst"; \
+		   fi ;; \
 		esac || exit; \
 	done && \
 	date >$@
-- 
1.5.4.1.126.ge5a7d
