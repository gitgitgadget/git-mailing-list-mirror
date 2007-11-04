From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Build in ls-remote
Date: Sun, 4 Nov 2007 15:51:17 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711041544200.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 21:51:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IomRU-0004nU-6c
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 21:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbXKDUvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 15:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbXKDUvU
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 15:51:20 -0500
Received: from iabervon.org ([66.92.72.58]:39098 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbXKDUvT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 15:51:19 -0500
Received: (qmail 5296 invoked by uid 1000); 4 Nov 2007 20:51:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2007 20:51:18 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63441>

This actually replaces peek-remote with ls-remote, since peek-remote
now handles everything. peek-remote remains an a second name for
ls-remote, although its help message now gives the "ls-remote" name.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
Keeping scripts in .../examples makes the diffstat much less compelling. 
This actually replaces a 142-line shell script with one line in git.c. I'm 
not actually sure if this one is even worth keeping as an example, since 
the git-specific portions just delegated to C code anyway.

 Makefile                                           |    3 +--
 builtin-peek-remote.c => builtin-ls-remote.c       |   10 +++++-----
 builtin.h                                          |    2 +-
 .../examples/git-ls-remote.sh                      |    0 
 git.c                                              |    3 ++-
 5 files changed, 9 insertions(+), 9 deletions(-)
 rename builtin-peek-remote.c => builtin-ls-remote.c (83%)
 rename git-ls-remote.sh => contrib/examples/git-ls-remote.sh (100%)

diff --git a/Makefile b/Makefile
index 3ec1876..470e54a 100644
--- a/Makefile
+++ b/Makefile
@@ -210,7 +210,6 @@ BASIC_LDFLAGS =
 SCRIPT_SH = \
 	git-bisect.sh git-checkout.sh \
 	git-clean.sh git-clone.sh git-commit.sh \
-	git-ls-remote.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
 	git-repack.sh git-request-pull.sh \
@@ -345,6 +344,7 @@ BUILTIN_OBJS = \
 	builtin-log.o \
 	builtin-ls-files.o \
 	builtin-ls-tree.o \
+	builtin-ls-remote.o \
 	builtin-mailinfo.o \
 	builtin-mailsplit.o \
 	builtin-merge-base.o \
@@ -352,7 +352,6 @@ BUILTIN_OBJS = \
 	builtin-mv.o \
 	builtin-name-rev.o \
 	builtin-pack-objects.o \
-	builtin-peek-remote.o \
 	builtin-prune.o \
 	builtin-prune-packed.o \
 	builtin-push.o \
diff --git a/builtin-peek-remote.c b/builtin-ls-remote.c
similarity index 83%
rename from builtin-peek-remote.c
rename to builtin-ls-remote.c
index b4106f5..003580c 100644
--- a/builtin-peek-remote.c
+++ b/builtin-ls-remote.c
@@ -3,10 +3,10 @@
 #include "transport.h"
 #include "remote.h"
 
-static const char peek_remote_usage[] =
-"git-peek-remote [--upload-pack=<git-upload-pack>] [<host>:]<directory>";
+static const char ls_remote_usage[] =
+"git-ls-remote [--upload-pack=<git-upload-pack>] [<host>:]<directory>";
 
-int cmd_peek_remote(int argc, const char **argv, const char *prefix)
+int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	const char *dest = NULL;
@@ -43,14 +43,14 @@ int cmd_peek_remote(int argc, const char **argv, const char *prefix)
 				flags |= REF_NORMAL;
 				continue;
 			}
-			usage(peek_remote_usage);
+			usage(ls_remote_usage);
 		}
 		dest = arg;
 		break;
 	}
 
 	if (!dest || i != argc - 1)
-		usage(peek_remote_usage);
+		usage(ls_remote_usage);
 
 	transport = transport_get(NULL, dest);
 	if (uploadpack != NULL)
diff --git a/builtin.h b/builtin.h
index 2335c01..525107f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -48,6 +48,7 @@ extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_ls_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 extern int cmd_mailsplit(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
@@ -55,7 +56,6 @@ extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
-extern int cmd_peek_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_pickaxe(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
diff --git a/git-ls-remote.sh b/contrib/examples/git-ls-remote.sh
similarity index 100%
rename from git-ls-remote.sh
rename to contrib/examples/git-ls-remote.sh
diff --git a/git.c b/git.c
index 19a2172..b173f22 100644
--- a/git.c
+++ b/git.c
@@ -326,6 +326,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
+		{ "ls-remote", cmd_ls_remote },
 		{ "mailinfo", cmd_mailinfo },
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
@@ -333,7 +334,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
-		{ "peek-remote", cmd_peek_remote },
+		{ "peek-remote", cmd_ls_remote },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
 		{ "prune", cmd_prune, RUN_SETUP },
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
-- 
1.5.3.4.1206.g5f96
