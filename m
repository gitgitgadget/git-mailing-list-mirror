From: skimo@liacs.nl
Subject: [PATCH 09/16] entry.c: optionally checkout submodules
Date: Fri, 18 May 2007 21:24:58 +0200
Message-ID: <1179516307425-git-send-email-skimo@liacs.nl>
References: <11795163053812-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 21:25:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp856-0002MY-NQ
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685AbXERTZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757917AbXERTZh
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:25:37 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:55763 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757828AbXERTZY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:25:24 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4IJPDJi005203;
	Fri, 18 May 2007 21:25:18 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 205ED7DDA8; Fri, 18 May 2007 21:25:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11795163053812-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47643>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 entry.c |   42 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 82bf725..96a4a60 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "blob.h"
+#include "run-command.h"
 
 static void create_directories(const char *path, const struct checkout *state)
 {
@@ -163,6 +164,44 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 	return 0;
 }
 
+static int checkout_submodule(const char *path, struct cache_entry *ce, const struct checkout *state)
+{
+	static char cwd[PATH_MAX];
+	const char *gitdirenv;
+	const char *args[10];
+	int argc;
+	int err;
+
+	if (!state->submodules)
+		return 0;
+
+	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
+		die("Unable to read current working directory");
+
+	if (chdir(path))
+		die("Cannot move to '%s'", path);
+
+	argc = 0;
+	args[argc++] = "checkout";
+	if (state->force)
+	    args[argc++] = "-f";
+	args[argc++] = sha1_to_hex(ce->sha1);
+	args[argc] = NULL;
+
+	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
+	unsetenv(GIT_DIR_ENVIRONMENT);
+	err = run_command_v_opt(args, RUN_GIT_CMD);
+	setenv(GIT_DIR_ENVIRONMENT, gitdirenv, 1);
+
+	if (chdir(cwd))
+		die("Cannot come back to cwd");
+
+	if (err)
+		return error("failed to run git-checkout in submodule '%s'", path);
+
+	return 0;
+}
+
 int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath)
 {
 	static char path[PATH_MAX + 1];
@@ -193,9 +232,8 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 		 */
 		unlink(path);
 		if (S_ISDIR(st.st_mode)) {
-			/* If it is a gitlink, leave it alone! */
 			if (S_ISDIRLNK(ntohl(ce->ce_mode)))
-				return 0;
+				return checkout_submodule(path, ce, state);
 			if (!state->force)
 				return error("%s is a directory", path);
 			remove_subtree(path);
-- 
1.5.2.rc3.783.gc7476-dirty
