From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 4/5] Allow the built-in exec path to be relative to the command invocation path
Date: Mon, 14 Jul 2008 23:41:28 +0200
Message-ID: <1216071689-14823-5-git-send-email-johannes.sixt@telecom.at>
References: <1216025226.487b128a031fd@webmail.eunet.at>
 <1216071689-14823-1-git-send-email-johannes.sixt@telecom.at>
 <1216071689-14823-2-git-send-email-johannes.sixt@telecom.at>
 <1216071689-14823-3-git-send-email-johannes.sixt@telecom.at>
 <1216071689-14823-4-git-send-email-johannes.sixt@telecom.at>
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 23:42:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIVob-0002Di-0G
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 23:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991AbYGNVlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 17:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756983AbYGNVlj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 17:41:39 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:40593 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918AbYGNVlc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 17:41:32 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 847AB13AE06;
	Mon, 14 Jul 2008 23:41:31 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.3.323.g1e58
In-Reply-To: <1216071689-14823-4-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88469>

If GIT_EXEC_PATH (the macro that is defined in the Makefile) is relative,
it is interpreted relative to the command's invocation path, which usually
is $(bindir).

The Makefile rules were written with the assumption that $(gitexecdir) is
an absolute path. We introduce a separate variable that names the
(absolute) installation directory.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile   |   15 +++++++++++----
 exec_cmd.c |   38 ++------------------------------------
 2 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/Makefile b/Makefile
index b9ea0ea..4df6423 100644
--- a/Makefile
+++ b/Makefile
@@ -1307,10 +1307,17 @@ template_instdir = $(template_dir)
 endif
 export template_instdir
 
+ifeq ($(firstword $(subst /, ,$(gitexecdir))),..)
+gitexec_instdir = $(bindir)/$(gitexecdir)
+else
+gitexec_instdir = $(gitexecdir)
+endif
+gitexec_instdir_SQ = $(subst ','\'',$(gitexec_instdir))
+
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
@@ -1319,10 +1326,10 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui install
 endif
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
 endif
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
-	execdir=$$(cd '$(DESTDIR_SQ)$(gitexecdir_SQ)' && pwd) && \
+	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
 	if test "z$$bindir" != "z$$execdir"; \
 	then \
 		ln -f "$$bindir/git$X" "$$execdir/git$X" || \
diff --git a/exec_cmd.c b/exec_cmd.c
index 45f92eb..c236034 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -7,40 +7,6 @@ extern char **environ;
 static const char *argv_exec_path;
 static const char *argv0_path;
 
-static const char *builtin_exec_path(void)
-{
-#ifndef __MINGW32__
-	return GIT_EXEC_PATH;
-#else
-	int len;
-	char *p, *q, *sl;
-	static char *ep;
-	if (ep)
-		return ep;
-
-	len = strlen(_pgmptr);
-	if (len < 2)
-		return ep = ".";
-
-	p = ep = xmalloc(len+1);
-	q = _pgmptr;
-	sl = NULL;
-	/* copy program name, turn '\\' into '/', skip last part */
-	while ((*p = *q)) {
-		if (*q == '\\' || *q == '/') {
-			*p = '/';
-			sl = p;
-		}
-		p++, q++;
-	}
-	if (sl)
-		*sl = '\0';
-	else
-		ep[0] = '.', ep[1] = '\0';
-	return ep;
-#endif
-}
-
 const char *system_path(const char *path)
 {
 	if (!is_absolute_path(path) && argv0_path) {
@@ -75,7 +41,7 @@ const char *git_exec_path(void)
 		return env;
 	}
 
-	return builtin_exec_path();
+	return system_path(GIT_EXEC_PATH);
 }
 
 static void add_path(struct strbuf *out, const char *path)
@@ -99,7 +65,7 @@ void setup_path(void)
 
 	add_path(&new_path, argv_exec_path);
 	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
-	add_path(&new_path, builtin_exec_path());
+	add_path(&new_path, system_path(GIT_EXEC_PATH));
 	add_path(&new_path, argv0_path);
 
 	if (old_path)
-- 
1.5.6.3.323.g1e58
