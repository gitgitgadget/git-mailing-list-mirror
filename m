From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Allow the built-in exec path to be relative to the command invocation path
Date: Sun, 13 Jul 2008 22:31:22 +0200
Message-ID: <1215981083-10815-5-git-send-email-johannes.sixt@telecom.at>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org>
 <1215981083-10815-1-git-send-email-johannes.sixt@telecom.at>
 <1215981083-10815-2-git-send-email-johannes.sixt@telecom.at>
 <1215981083-10815-3-git-send-email-johannes.sixt@telecom.at>
 <1215981083-10815-4-git-send-email-johannes.sixt@telecom.at>
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 22:32:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI8Fa-0005ZO-RA
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 22:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbYGMUbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 16:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755368AbYGMUbg
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 16:31:36 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:37020 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124AbYGMUb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 16:31:28 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 31B8834AB0;
	Sun, 13 Jul 2008 22:31:27 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.300.ga3a9
In-Reply-To: <1215981083-10815-4-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88334>

If GIT_EXEC_PATH (the macro that is defined in the Makefile) is relative,
it is interpreted relative to the command's invocation path, which usually
is $(bindir).

The Makefile rules were written with the assumption that $(gitexecdir) is
an absolute path. We introduce a separate variable that names the
(absolute) installation directory.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile   |   23 +++++++++++++++--------
 exec_cmd.c |   38 ++------------------------------------
 2 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/Makefile b/Makefile
index 2bdb9bf..3593e6f 100644
--- a/Makefile
+++ b/Makefile
@@ -1307,10 +1307,17 @@ template_instdir = $(template_dir)
 endif
 export template_instdir
 
+ifeq ($(firstword $(subst /, ,$(gitexecdir))),..)
+gitexec_instdir = $(shell cd '$(bindir_SQ)/$(gitexecdir_SQ)' && pwd)
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
@@ -1318,18 +1325,18 @@ ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
 	$(MAKE) -C git-gui install
 endif
-	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
+	if test 'z$(bindir_SQ)' != 'z$(gitexec_instdir_SQ)'; \
 	then \
 		ln -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
-			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' || \
+			'$(DESTDIR_SQ)$(gitexec_instdir_SQ)/git$X' || \
 		cp '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
-			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
+			'$(DESTDIR_SQ)$(gitexec_instdir_SQ)/git$X'; \
 	fi
-	$(foreach p,$(BUILT_INS), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
+	$(foreach p,$(BUILT_INS), $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' ;)
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
 endif
-	./check_bindir 'z$(bindir_SQ)' 'z$(gitexecdir_SQ)' '$(DESTDIR_SQ)$(bindir_SQ)/git-shell$X'
+	./check_bindir 'z$(bindir_SQ)' 'z$(gitexec_instdir_SQ)' '$(DESTDIR_SQ)$(bindir_SQ)/git-shell$X'
 
 install-doc:
 	$(MAKE) -C Documentation install
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
1.5.6.2.300.ga3a9
