From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Make update-ref a builtin.
Date: Mon, 29 May 2006 03:15:57 -0400
Message-ID: <20060529071557.GB6061@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 09:16:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkbyw-0002sM-85
	for gcvg-git@gmane.org; Mon, 29 May 2006 09:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWE2HQD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 03:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWE2HQD
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 03:16:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38546 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750710AbWE2HQB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 03:16:01 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fkbyo-0005W3-Bc; Mon, 29 May 2006 03:15:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9AB6020E445; Mon, 29 May 2006 03:15:57 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20927>


Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 This is applied on top of `next` and my other reflog changes.
 I put it together just to reduce the disk usage - as Linus noted
 PowerPC ain't too slim on its executables...

 Makefile                             |    6 +++---
 update-ref.c => builtin-update-ref.c |    9 +++++----
 builtin.h                            |    1 +
 git.c                                |    1 +
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 5f8ea18..7dfeb97 100644
--- a/Makefile
+++ b/Makefile
@@ -161,7 +161,7 @@ PROGRAMS = \
 	git-ssh-upload$X git-unpack-file$X \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
-	git-update-ref$X git-symbolic-ref$X \
+	git-symbolic-ref$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
 	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X
 
@@ -172,7 +172,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-init-db$X git-tar-tree$X git-upload-tar$X git-format-patch$X \
 	git-ls-files$X git-ls-tree$X \
 	git-read-tree$X git-commit-tree$X \
-	git-apply$X git-show-branch$X git-diff-files$X \
+	git-update-ref$X git-apply$X git-show-branch$X git-diff-files$X \
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
@@ -228,7 +228,7 @@ BUILTIN_OBJS = \
 	builtin-read-tree.o builtin-commit-tree.o \
 	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
-	builtin-cat-file.o
+	builtin-update-ref.o builtin-cat-file.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/update-ref.c b/builtin-update-ref.c
similarity index 85%
rename from update-ref.c
rename to builtin-update-ref.c
index a1e6bb9..2c62286 100644
--- a/update-ref.c
+++ b/builtin-update-ref.c
@@ -1,10 +1,11 @@
 #include "cache.h"
 #include "refs.h"
+#include "builtin.h"
 
-static const char git_update_ref_usage[] =
+static const char builtin_update_ref_usage[] =
 "git-update-ref <refname> <value> [<oldval>] [-m <reason>]";
 
-int main(int argc, char **argv)
+int cmd_update_ref(int argc, const char **argv, char **envp)
 {
 	const char *refname=NULL, *value=NULL, *oldval=NULL, *msg=NULL;
 	struct ref_lock *lock;
@@ -17,7 +18,7 @@ int main(int argc, char **argv)
 	for (i = 1; i < argc; i++) {
 		if (!strcmp("-m", argv[i])) {
 			if (i+1 >= argc)
-				usage(git_update_ref_usage);
+				usage(builtin_update_ref_usage);
 			msg = argv[++i];
 			if (!*msg)
 				die("Refusing to perform update with empty message.");
@@ -39,7 +40,7 @@ int main(int argc, char **argv)
 		}
 	}
 	if (!refname || !value)
-		usage(git_update_ref_usage);
+		usage(builtin_update_ref_usage);
 
 	if (get_sha1(value, sha1))
 		die("%s: not a valid SHA1", value);
diff --git a/builtin.h b/builtin.h
index 738ec3d..397b770 100644
--- a/builtin.h
+++ b/builtin.h
@@ -28,6 +28,7 @@ extern int cmd_grep(int argc, const char
 extern int cmd_rm(int argc, const char **argv, char **envp);
 extern int cmd_add(int argc, const char **argv, char **envp);
 extern int cmd_rev_list(int argc, const char **argv, char **envp);
+extern int cmd_update_ref(int argc, const char **argv, char **envp);
 extern int cmd_check_ref_format(int argc, const char **argv, char **envp);
 extern int cmd_init_db(int argc, const char **argv, char **envp);
 extern int cmd_tar_tree(int argc, const char **argv, char **envp);
diff --git a/git.c b/git.c
index 10ea934..f37b020 100644
--- a/git.c
+++ b/git.c
@@ -57,6 +57,7 @@ static void handle_internal_command(int 
 		{ "init-db", cmd_init_db },
 		{ "tar-tree", cmd_tar_tree },
 		{ "upload-tar", cmd_upload_tar },
+		{ "update-ref", cmd_update_ref },
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "ls-files", cmd_ls_files },
 		{ "ls-tree", cmd_ls_tree },
-- 
1.3.3.g45d8
