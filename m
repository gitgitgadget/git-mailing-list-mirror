From: Kelvie Wong <kelvie@ieee.org>
Subject: [PATCH] Add an "-i" option to git-reset, to confirm a reset.
Date: Sat, 15 Dec 2007 19:26:36 -0800
Message-ID: <1197775596-14329-1-git-send-email-kelvie@ieee.org>
Cc: Kelvie Wong <kelvie@ieee.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 04:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3k8j-0007zw-AR
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 04:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808AbXLPDZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 22:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756963AbXLPDZl
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 22:25:41 -0500
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:30605 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783AbXLPDZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 22:25:40 -0500
Received: from pd4mr4so.prod.shaw.ca
 (pd4mr4so-qfe3.prod.shaw.ca [10.0.141.215]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JT400ML9HIR1430@l-daemon> for git@vger.kernel.org; Sat,
 15 Dec 2007 20:25:39 -0700 (MST)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
 by pd4mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JT400LIKHIQTZ40@pd4mr4so.prod.shaw.ca> for
 git@vger.kernel.org; Sat, 15 Dec 2007 20:25:40 -0700 (MST)
Received: from localhost.localdomain ([24.83.107.230])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JT4006C3HIQB650@l-daemon> for git@vger.kernel.org; Sat,
 15 Dec 2007 20:25:38 -0700 (MST)
X-Mailer: git-send-email 1.5.4-rc0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68426>

It shows a diffstat, and asks the user if they would like to continue, or
show a full diff of the things getting reset.

I know that many times, I do a reset --hard thinking I had commited a file
already, but it turns out that I hadn't; and so this makes sure I don't
lose any work when the caffeine wears off.

Maybe it should also be made that only hard resets take this option, as
I cannot see this being useful in other places.

Signed-off-by: Kelvie Wong <kelvie@ieee.org>
---
 Documentation/git-reset.txt |    4 +++
 builtin-reset.c             |   46 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 050e4ea..0323d9d 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -48,6 +48,10 @@ OPTIONS
 -q::
 	Be quiet, only report errors.
 
+-i::
+	Show what is about to be reset, and ask for confirmation before doing
+	so.
+
 <commit>::
 	Commit to make the current HEAD.
 
diff --git a/builtin-reset.c b/builtin-reset.c
index 713c2d5..1086817 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -18,7 +18,8 @@
 #include "tree.h"
 
 static const char builtin_reset_usage[] =
-"git-reset [--mixed | --soft | --hard] [-q] [<commit-ish>] [ [--] <paths>...]";
+"git-reset [--mixed | --soft | --hard] [-q] [-i] [<commit-ish>] [ [--] "
+"<paths>...]";
 
 static char *args_to_str(const char **argv)
 {
@@ -56,17 +57,47 @@ static int unmerged_files(void)
 	return 0;
 }
 
-static int reset_index_file(const unsigned char *sha1, int is_hard_reset)
+static int reset_index_file(const unsigned char *sha1, int is_hard_reset,
+			    int confirm_reset)
 {
 	int i = 0;
 	const char *args[6];
+	struct strbuf buf;
+	char result = 0;
+	const char *ref = sha1_to_hex(sha1);
+	const char *diffstat_args[] = { "diff", "--stat", ref, NULL };
+	const char *diff_args[] = { "diff", ref, NULL };
 
 	args[i++] = "read-tree";
 	args[i++] = "-v";
 	args[i++] = "--reset";
+
+	/* Show the user what is about to be reset, and in more detail, if they
+	 * like. */
+	if(confirm_reset) {
+		printf("The following files will be reset:\n");
+		run_command_v_opt(diffstat_args, RUN_GIT_CMD);
+		strbuf_init(&buf, 0);
+		while(result != 'y') {
+			printf("Continue? ((y)es/(n)o/view (d)iff)\n");
+			strbuf_getline(&buf, stdin, '\n');
+			result = tolower(buf.buf[0]);
+			switch(result) {
+			case 'd':
+				run_command_v_opt(diff_args, RUN_GIT_CMD);
+				break;
+			case 'n':
+				return 1;
+				break;
+			};
+		}
+		strbuf_release(&buf);
+        }
+
+
 	if (is_hard_reset)
 		args[i++] = "-u";
-	args[i++] = sha1_to_hex(sha1);
+	args[i++] = ref;
 	args[i] = NULL;
 
 	return run_command_v_opt(args, RUN_GIT_CMD);
@@ -181,7 +212,8 @@ static const char *reset_type_names[] = { "mixed", "soft", "hard", NULL };
 
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
-	int i = 1, reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int i = 1, reset_type = NONE, update_ref_status = 0, quiet = 0,
+		confirm = 0;
 	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
@@ -210,6 +242,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			quiet = 1;
 			i++;
 		}
+		else if (!strcmp(argv[i], "-i")) {
+			confirm = 1;
+			i++;
+		}
 		else
 			break;
 	}
@@ -251,7 +287,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		if (is_merge() || unmerged_files())
 			die("Cannot do a soft reset in the middle of a merge.");
 	}
-	else if (reset_index_file(sha1, (reset_type == HARD)))
+	else if (reset_index_file(sha1, (reset_type == HARD), confirm))
 		die("Could not reset index file to revision '%s'.", rev);
 
 	/* Any resets update HEAD to the head being switched to,
-- 
1.5.4-rc0.GIT
