From: skimo@liacs.nl
Subject: [PATCH 11/22] entry.c: optionally checkout submodules
Date: Thu, 24 May 2007 00:23:00 +0200
Message-ID: <11799589922243-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:24:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFq-0003VS-0O
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757621AbXEWWYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758593AbXEWWX7
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:23:59 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33797 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757621AbXEWWXs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:48 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNGZL011568;
	Thu, 24 May 2007 00:23:21 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 8A3237DDA9; Thu, 24 May 2007 00:23:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48195>

From: Sven Verdoolaege <skimo@kotnet.org>

Use run_command_v_opt_cd, as proposed by Alex Riesen.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 entry.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index ae64764..7ba2241 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "blob.h"
+#include "run-command.h"
 
 static void create_directories(const char *path, const struct checkout *state)
 {
@@ -75,6 +76,31 @@ static void *read_blob_entry(struct cache_entry *ce, const char *path, unsigned
 	return NULL;
 }
 
+static int checkout_submodule(struct cache_entry *ce, const char *path, const struct checkout *state)
+{
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
+	err = run_command_v_opt_cd(args, RUN_GIT_CMD|RUN_COMMAND_CLEAR_GIT_ENV,
+				   path);
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
@@ -193,9 +219,8 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 		 */
 		unlink(path);
 		if (S_ISDIR(st.st_mode)) {
-			/* If it is a gitlink, leave it alone! */
 			if (S_ISGITLINK(ntohl(ce->ce_mode)))
-				return 0;
+				return checkout_submodule(ce, path, state);
 			if (!state->force)
 				return error("%s is a directory", path);
 			remove_subtree(path);
-- 
1.5.2.784.g5532e
