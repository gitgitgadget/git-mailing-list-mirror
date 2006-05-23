From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH 8/8] Builtin git-diff-files, git-diff-index, git-diff-stages, and git-diff-tree.
Date: Tue, 23 May 2006 14:15:36 +0200
Message-ID: <14374.1495711312$1148386590@news.gmane.org>
References: <11483865361243-git-send-email-1>
Reply-To: s022018@student.dtu.dk
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue May 23 14:16:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiVns-0002bL-RA
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWEWMPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWEWMPo
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:15:44 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:50879 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932196AbWEWMPi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:15:38 -0400
Received: (qmail 5927 invoked by uid 5842); 23 May 2006 14:15:37 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
In-Reply-To: <11483865361243-git-send-email-1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20594>

From: Peter Eriksen <s022018@student.dtu.dk>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

e2d2468b8550f2760b46a2eb461b051abfef4dff
 Makefile                               |   12 ++++++------
 diff-files.c => builtin-diff-files.c   |    3 ++-
 diff-index.c => builtin-diff-index.c   |    3 ++-
 diff-stages.c => builtin-diff-stages.c |    3 ++-
 diff-tree.c => builtin-diff-tree.c     |    3 ++-
 builtin.h                              |    5 +++++
 git.c                                  |    6 +++++-
 7 files changed, 24 insertions(+), 11 deletions(-)
 rename diff-files.c => builtin-diff-files.c (94%)
 rename diff-index.c => builtin-diff-index.c (91%)
 rename diff-stages.c => builtin-diff-stages.c (97%)
 rename diff-tree.c => builtin-diff-tree.c (98%)

e2d2468b8550f2760b46a2eb461b051abfef4dff
diff --git a/Makefile b/Makefile
index b438a90..9dc1326 100644
--- a/Makefile
+++ b/Makefile
@@ -151,9 +151,7 @@ # ... and all the rest that could be mov
 PROGRAMS = \
 	git-cat-file$X \
 	git-checkout-index$X git-clone-pack$X \
-	git-convert-objects$X git-diff-files$X \
-	git-diff-index$X git-diff-stages$X \
-	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
+	git-convert-objects$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-mailinfo$X git-merge-base$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
@@ -173,7 +171,8 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-grep$X git-rev-list$X git-check-ref-format$X \
 	git-init-db$X git-ls-files$X git-ls-tree$X \
 	git-tar-tree$X git-read-tree$X git-commit-tree$X \
-	git-apply$X git-show-branch$X
+	git-apply$X git-show-branch$X git-diff-files$X \
+	git-diff-index$X git-diff-stages$X git-diff-tree$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -223,8 +222,9 @@ BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
 	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o \
-        builtin-tar-tree.o builtin-read-tree.o builtin-commit-tree.o \
-	builtin-apply.o builtin-show-branch.o
+	builtin-tar-tree.o builtin-read-tree.o builtin-commit-tree.o \
+	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
+	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/diff-files.c b/builtin-diff-files.c
similarity index 94%
rename from diff-files.c
rename to builtin-diff-files.c
index b9d193d..cebda82 100644
--- a/diff-files.c
+++ b/builtin-diff-files.c
@@ -7,12 +7,13 @@ #include "cache.h"
 #include "diff.h"
 #include "commit.h"
 #include "revision.h"
+#include "builtin.h"
 
 static const char diff_files_usage[] =
 "git-diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
-int main(int argc, const char **argv)
+int cmd_diff_files(int argc, const char **argv, char **envp)
 {
 	struct rev_info rev;
 	int silent = 0;
diff --git a/diff-index.c b/builtin-diff-index.c
similarity index 91%
rename from diff-index.c
rename to builtin-diff-index.c
index 8c9f601..1958580 100644
--- a/diff-index.c
+++ b/builtin-diff-index.c
@@ -2,13 +2,14 @@ #include "cache.h"
 #include "diff.h"
 #include "commit.h"
 #include "revision.h"
+#include "builtin.h"
 
 static const char diff_cache_usage[] =
 "git-diff-index [-m] [--cached] "
 "[<common diff options>] <tree-ish> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
-int main(int argc, const char **argv)
+int cmd_diff_index(int argc, const char **argv, char **envp)
 {
 	struct rev_info rev;
 	int cached = 0;
diff --git a/diff-stages.c b/builtin-diff-stages.c
similarity index 97%
rename from diff-stages.c
rename to builtin-diff-stages.c
index dcd20e7..7c157ca 100644
--- a/diff-stages.c
+++ b/builtin-diff-stages.c
@@ -4,6 +4,7 @@
 
 #include "cache.h"
 #include "diff.h"
+#include "builtin.h"
 
 static struct diff_options diff_options;
 
@@ -54,7 +55,7 @@ static void diff_stages(int stage1, int 
 	}
 }
 
-int main(int ac, const char **av)
+int cmd_diff_stages(int ac, const char **av, char **envp)
 {
 	int stage1, stage2;
 	const char *prefix = setup_git_directory();
diff --git a/diff-tree.c b/builtin-diff-tree.c
similarity index 98%
rename from diff-tree.c
rename to builtin-diff-tree.c
index 69bb74b..cc53b81 100644
--- a/diff-tree.c
+++ b/builtin-diff-tree.c
@@ -2,6 +2,7 @@ #include "cache.h"
 #include "diff.h"
 #include "commit.h"
 #include "log-tree.h"
+#include "builtin.h"
 
 static struct rev_info log_tree_opt;
 
@@ -58,7 +59,7 @@ static const char diff_tree_usage[] =
 "  --root        include the initial commit as diff against /dev/null\n"
 COMMON_DIFF_OPTIONS_HELP;
 
-int main(int argc, const char **argv)
+int cmd_diff_tree(int argc, const char **argv, char **envp)
 {
 	int nr_sha1;
 	char line[1000];
diff --git a/builtin.h b/builtin.h
index 01882ec..7620984 100644
--- a/builtin.h
+++ b/builtin.h
@@ -34,5 +34,10 @@ extern int cmd_read_tree(int argc, const
 extern int cmd_commit_tree(int argc, const char **argv, char **envp);
 extern int cmd_apply(int argc, const char **argv, char **envp);
 extern int cmd_show_branch(int argc, const char **argv, char **envp);
+extern int cmd_diff_files(int argc, const char **argv, char **envp);
+extern int cmd_diff_index(int argc, const char **argv, char **envp);
+extern int cmd_diff_stages(int argc, const char **argv, char **envp);
+extern int cmd_diff_tree(int argc, const char **argv, char **envp);
+
 
 #endif
diff --git a/git.c b/git.c
index d29505c..8749748 100644
--- a/git.c
+++ b/git.c
@@ -59,7 +59,11 @@ static void handle_internal_command(int 
 		{ "read-tree", cmd_read_tree },
 		{ "commit-tree", cmd_commit_tree },
 		{ "apply", cmd_apply },
-		{ "show-branch", cmd_show_branch }
+		{ "show-branch", cmd_show_branch },
+		{ "diff-files", cmd_diff_files },
+		{ "diff-index", cmd_diff_index },
+		{ "diff-stages", cmd_diff_stages },
+		{ "diff-tree", cmd_diff_tree }
 	};
 	int i;
 
-- 
1.3.3.g288c
