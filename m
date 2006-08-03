From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Make git-name-rev a builtin
Date: Thu,  3 Aug 2006 17:24:35 +0200
Message-ID: <11546186794129-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
X-From: git-owner@vger.kernel.org Thu Aug 03 17:26:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8f4T-0005Ri-JL
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 17:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWHCPY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 11:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWHCPY5
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 11:24:57 -0400
Received: from mail13.bluewin.ch ([195.186.18.62]:32651 "EHLO
	mail13.bluewin.ch") by vger.kernel.org with ESMTP id S964780AbWHCPY4
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 11:24:56 -0400
Received: from spinlock.ch (83.78.18.234) by mail13.bluewin.ch (Bluewin 7.3.110.2)
        id 44B36133004FC95E; Thu, 3 Aug 2006 15:24:51 +0000
Received: (nullmailer pid 5959 invoked by uid 1000);
	Thu, 03 Aug 2006 15:24:39 -0000
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2.rc2.g2e994
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24730>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 Makefile                         |    7 ++++---
 name-rev.c => builtin-name-rev.c |    4 ++--
 builtin.h                        |    1 +
 git.c                            |    1 +
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 1c1427e..67b6846 100644
--- a/Makefile
+++ b/Makefile
@@ -204,7 +204,7 @@ PROGRAMS = \
 	git-unpack-objects$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X \
 	git-symbolic-ref$X \
-	git-name-rev$X git-pack-redundant$X git-var$X \
+	git-pack-redundant$X git-var$X \
 	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X \
 	git-merge-recur$X
 
@@ -218,7 +218,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-apply$X git-show-branch$X git-diff-files$X git-update-index$X \
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X \
 	git-fmt-merge-msg$X git-prune$X git-mv$X git-prune-packed$X \
-	git-repo-config$X
+	git-repo-config$X git-name-rev$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -275,7 +275,8 @@ BUILTIN_OBJS = \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
 	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o \
-	builtin-mv.o builtin-prune-packed.o builtin-repo-config.o
+	builtin-mv.o builtin-prune-packed.o builtin-repo-config.o \
+	builtin-name-rev.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS = -lz
diff --git a/name-rev.c b/builtin-name-rev.c
similarity index 98%
rename from name-rev.c
rename to builtin-name-rev.c
index f92f14e..571bba4 100644
--- a/name-rev.c
+++ b/builtin-name-rev.c
@@ -1,4 +1,5 @@
 #include <stdlib.h>
+#include "builtin.h"
 #include "cache.h"
 #include "commit.h"
 #include "tag.h"
@@ -126,12 +127,11 @@ static const char* get_rev_name(struct o
 	return buffer;
 }
 
-int main(int argc, char **argv)
+int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = { 0, 0, NULL };
 	int as_is = 0, all = 0, transform_stdin = 0;
 
-	setup_git_directory();
 	git_config(git_default_config);
 
 	if (argc < 2)
diff --git a/builtin.h b/builtin.h
index 26ebcaf..d1d9dc1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -49,6 +49,7 @@ extern int cmd_update_ref(int argc, cons
 extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_repo_config(int argc, const char **argv, const char *prefix);
+extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 
 extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
diff --git a/git.c b/git.c
index 6e72a89..501a781 100644
--- a/git.c
+++ b/git.c
@@ -265,6 +265,7 @@ static void handle_internal_command(int 
 		{ "mv", cmd_mv, NEEDS_PREFIX },
 		{ "prune-packed", cmd_prune_packed, NEEDS_PREFIX },
 		{ "repo-config", cmd_repo_config },
+		{ "name-rev", cmd_name_rev, NEEDS_PREFIX },
 	};
 	int i;
 
-- 
1.4.2.rc2.g2e994
