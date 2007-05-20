From: skimo@liacs.nl
Subject: [PATCH 09/15] entry.c: optionally checkout submodules
Date: Sun, 20 May 2007 20:04:42 +0200
Message-ID: <11796842892490-git-send-email-skimo@liacs.nl>
References: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:05:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppmr-0007La-AU
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000AbXETSFM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757168AbXETSFM
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:05:12 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37218 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757000AbXETSFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:05:04 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4rtd007819;
	Sun, 20 May 2007 20:04:58 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 9F4F27DDA8; Sun, 20 May 2007 20:04:49 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47863>

From: Sven Verdoolaege <skimo@kotnet.org>

Use run_command_v_opt_cd, as proposed by Alex Riesen.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 entry.c |   32 ++++++++++++++++++++++++++++++--
 1 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 82bf725..8c70a47 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "blob.h"
+#include "run-command.h"
 
 static void create_directories(const char *path, const struct checkout *state)
 {
@@ -75,6 +76,34 @@ static void *read_blob_entry(struct cache_entry *ce, const char *path, unsigned
 	return NULL;
 }
 
+static int checkout_submodule(struct cache_entry *ce, const char *path, const struct checkout *state)
+{
+	const char *gitdirenv;
+	const char *args[10];
+	int argc;
+	int err;
+
+	if (!state->submodules)
+		return 0;
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
+	err = run_command_v_opt_cd(args, RUN_GIT_CMD, path);
+	setenv(GIT_DIR_ENVIRONMENT, gitdirenv, 1);
+
+	if (err)
+		return error("failed to run git-checkout in submodule '%s'", path);
+
+	return 0;
+}
+
 static int write_entry(struct cache_entry *ce, char *path, const struct checkout *state, int to_tempfile)
 {
 	int fd;
@@ -193,9 +222,8 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 		 */
 		unlink(path);
 		if (S_ISDIR(st.st_mode)) {
-			/* If it is a gitlink, leave it alone! */
 			if (S_ISDIRLNK(ntohl(ce->ce_mode)))
-				return 0;
+				return checkout_submodule(ce, path, state);
 			if (!state->force)
 				return error("%s is a directory", path);
 			remove_subtree(path);
-- 
1.5.2.rc3.815.g8fc2
