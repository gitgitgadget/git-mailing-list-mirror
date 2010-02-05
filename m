From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 9/9] merge: use new "reset" function instead of running "git
	read-tree"
Date: Sat, 06 Feb 2010 00:11:11 +0100
Message-ID: <20100205231112.3689.34673.chriscool@tuxfamily.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:12:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXM3-0008WA-If
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318Ab0BEXMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:12:35 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53997 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757668Ab0BEXMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:12:03 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8132C81805A;
	Sat,  6 Feb 2010 00:11:52 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7181C818050;
	Sat,  6 Feb 2010 00:11:50 +0100 (CET)
X-git-sha1: 71bd52b70f6ae4c01491ac37f43ffbb1b8a89437 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139118>

This simplifies "git merge" code and make it more efficient in some
cases.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-merge.c |   31 +++++++++++--------------------
 1 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 3aaec7b..de2343a 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -25,6 +25,7 @@
 #include "help.h"
 #include "merge-recursive.h"
 #include "resolve-undo.h"
+#include "reset.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -231,24 +232,14 @@ static void save_state(void)
 		die("not a valid object: %s", buffer.buf);
 }
 
-static void reset_hard(unsigned const char *sha1, int verbose)
+static void reset_hard(const char *prefix, unsigned const char *sha1, int verbose)
 {
-	int i = 0;
-	const char *args[6];
-
-	args[i++] = "read-tree";
-	if (verbose)
-		args[i++] = "-v";
-	args[i++] = "--reset";
-	args[i++] = "-u";
-	args[i++] = sha1_to_hex(sha1);
-	args[i] = NULL;
-
-	if (run_command_v_opt(args, RUN_GIT_CMD))
-		die("read-tree failed");
+	int res = reset(sha1_to_hex(sha1), prefix, HARD, !verbose, 0, 0, NULL);
+	if (res)
+		die("hard reset failed");
 }
 
-static void restore_state(void)
+static void restore_state(const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
 	const char *args[] = { "stash", "apply", NULL, NULL };
@@ -256,7 +247,7 @@ static void restore_state(void)
 	if (is_null_sha1(stash))
 		return;
 
-	reset_hard(head, 1);
+	reset_hard(prefix, head, 1);
 
 	args[2] = sha1_to_hex(stash);
 
@@ -970,7 +961,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die("%s - not something we can merge", argv[0]);
 		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
 				DIE_ON_ERR);
-		reset_hard(remote_head->sha1, 0);
+		reset_hard(prefix, remote_head->sha1, 0);
 		return 0;
 	} else {
 		struct strbuf msg = STRBUF_INIT;
@@ -1167,7 +1158,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		int ret;
 		if (i) {
 			printf("Rewinding the tree to pristine...\n");
-			restore_state();
+			restore_state(prefix);
 		}
 		if (use_strategies_nr != 1)
 			printf("Trying merge strategy %s...\n",
@@ -1228,7 +1219,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * it up.
 	 */
 	if (!best_strategy) {
-		restore_state();
+		restore_state(prefix);
 		if (use_strategies_nr > 1)
 			fprintf(stderr,
 				"No merge strategy handled the merge.\n");
@@ -1240,7 +1231,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		; /* We already have its result in the working tree. */
 	else {
 		printf("Rewinding the tree to pristine...\n");
-		restore_state();
+		restore_state(prefix);
 		printf("Using the %s to prepare resolving by hand.\n",
 			best_strategy);
 		try_merge_strategy(best_strategy, common, head_arg);
-- 
1.6.6.1.557.g77031
