From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Make git-repo-config a builtin
Date: Wed,  2 Aug 2006 23:51:59 +0200
Message-ID: <11545555203975-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
X-From: git-owner@vger.kernel.org Wed Aug 02 23:52:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8OdZ-0006nT-5l
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 23:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWHBVwQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 17:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWHBVwQ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 17:52:16 -0400
Received: from mail17.bluewin.ch ([195.186.18.64]:31889 "EHLO
	mail17.bluewin.ch") by vger.kernel.org with ESMTP id S932226AbWHBVwQ
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 17:52:16 -0400
Received: from spinlock.ch (81.62.57.222) by mail17.bluewin.ch (Bluewin 7.3.110.2)
        id 44B3612F004B8DB1; Wed, 2 Aug 2006 21:52:11 +0000
Received: (nullmailer pid 19133 invoked by uid 1000);
	Wed, 02 Aug 2006 21:52:00 -0000
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2.rc2.g93b2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24691>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 Makefile                               |    7 ++++---
 repo-config.c => builtin-repo-config.c |    3 ++-
 builtin.h                              |    1 +
 git.c                                  |    1 +
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 704101d..8d38f1c 100644
--- a/Makefile
+++ b/Makefile
@@ -204,7 +204,7 @@ PROGRAMS = \
 	git-unpack-objects$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X \
 	git-symbolic-ref$X \
-	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
+	git-name-rev$X git-pack-redundant$X git-var$X \
 	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X \
 	git-merge-recur$X
 
@@ -217,7 +217,8 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-read-tree$X git-commit-tree$X git-write-tree$X \
 	git-apply$X git-show-branch$X git-diff-files$X git-update-index$X \
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X \
-	git-fmt-merge-msg$X git-prune$X git-mv$X git-prune-packed$X
+	git-fmt-merge-msg$X git-prune$X git-mv$X git-prune-packed$X \
+	git-repo-config$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -274,7 +275,7 @@ BUILTIN_OBJS = \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
 	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o \
-	builtin-mv.o builtin-prune-packed.o
+	builtin-mv.o builtin-prune-packed.o builtin-repo-config.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS = -lz
diff --git a/repo-config.c b/builtin-repo-config.c
similarity index 98%
rename from repo-config.c
rename to builtin-repo-config.c
index c7ed0ac..1d93739 100644
--- a/repo-config.c
+++ b/builtin-repo-config.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include <regex.h>
 
@@ -128,7 +129,7 @@ free_strings:
 	return ret;
 }
 
-int main(int argc, const char **argv)
+int cmd_repo_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = 0;
 	setup_git_directory_gently(&nongit);
diff --git a/builtin.h b/builtin.h
index 7ddfe28..26ebcaf 100644
--- a/builtin.h
+++ b/builtin.h
@@ -48,6 +48,7 @@ extern int cmd_update_index(int argc, co
 extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
+extern int cmd_repo_config(int argc, const char **argv, const char *prefix);
 
 extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
diff --git a/git.c b/git.c
index 5b50762..6e72a89 100644
--- a/git.c
+++ b/git.c
@@ -264,6 +264,7 @@ static void handle_internal_command(int 
 		{ "prune", cmd_prune, NEEDS_PREFIX },
 		{ "mv", cmd_mv, NEEDS_PREFIX },
 		{ "prune-packed", cmd_prune_packed, NEEDS_PREFIX },
+		{ "repo-config", cmd_repo_config },
 	};
 	int i;
 
-- 
1.4.2.rc2.g93b2c
