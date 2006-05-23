From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH 5/8] Builtin git-commit-tree.
Date: Tue, 23 May 2006 10:31:17 +0200
Message-ID: <34511.6158518524$1148373111@news.gmane.org>
References: <11483730804133-git-send-email->
Reply-To: Patches/0001-Builtin-git-ls-files.txt@bohr.gbar.dtu.dk
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue May 23 10:31:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiSId-0001bZ-L6
	for gcvg-git@gmane.org; Tue, 23 May 2006 10:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWEWIb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 04:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWEWIb0
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 04:31:26 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:55019 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932122AbWEWIbW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 04:31:22 -0400
Received: (qmail 8467 invoked by uid 5842); 23 May 2006 10:31:21 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
In-Reply-To: <11483730804133-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20581>

From: Peter Eriksen <s022018@student.dtu.dk>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

762e5a2efcde796d84c573fe8bf3224c9fbf3588
 Makefile              |    6 +-
 builtin-commit-tree.c |  140 +++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h             |    1 
 commit-tree.c         |  139 -------------------------------------------------
 git.c                 |    3 +
 5 files changed, 146 insertions(+), 143 deletions(-)
 create mode 100644 builtin-commit-tree.c
 delete mode 100644 commit-tree.c

762e5a2efcde796d84c573fe8bf3224c9fbf3588
diff --git a/Makefile b/Makefile
index 667fa5d..a5efbc7 100644
--- a/Makefile
+++ b/Makefile
@@ -150,7 +150,7 @@ SIMPLE_PROGRAMS = \
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
 	git-apply$X git-cat-file$X \
-	git-checkout-index$X git-clone-pack$X git-commit-tree$X \
+	git-checkout-index$X git-clone-pack$X \
 	git-convert-objects$X git-diff-files$X \
 	git-diff-index$X git-diff-stages$X \
 	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
@@ -172,7 +172,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-count-objects$X git-diff$X git-push$X \
 	git-grep$X git-rev-list$X git-check-ref-format$X \
 	git-init-db$X git-ls-files$X git-ls-tree$X \
-	git-tar-tree$X git-read-tree$X
+	git-tar-tree$X git-read-tree$X git-commit-tree$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -222,7 +222,7 @@ BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
 	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o \
-        builtin-tar-tree.o builtin-read-tree.o
+        builtin-tar-tree.o builtin-read-tree.o builtin-commit-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
new file mode 100644
index 0000000..4ccdbec
--- /dev/null
+++ b/builtin-commit-tree.c
@@ -0,0 +1,140 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Linus Torvalds, 2005
+ */
+#include "cache.h"
+#include "commit.h"
+#include "tree.h"
+#include "builtin.h"
+
+#define BLOCKING (1ul << 14)
+
+/*
+ * FIXME! Share the code with "write-tree.c"
+ */
+static void init_buffer(char **bufp, unsigned int *sizep)
+{
+	char *buf = xmalloc(BLOCKING);
+	*sizep = 0;
+	*bufp = buf;
+}
+
+static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
+{
+	char one_line[2048];
+	va_list args;
+	int len;
+	unsigned long alloc, size, newsize;
+	char *buf;
+
+	va_start(args, fmt);
+	len = vsnprintf(one_line, sizeof(one_line), fmt, args);
+	va_end(args);
+	size = *sizep;
+	newsize = size + len;
+	alloc = (size + 32767) & ~32767;
+	buf = *bufp;
+	if (newsize > alloc) {
+		alloc = (newsize + 32767) & ~32767;
+		buf = xrealloc(buf, alloc);
+		*bufp = buf;
+	}
+	*sizep = newsize;
+	memcpy(buf + size, one_line, len);
+}
+
+static void check_valid(unsigned char *sha1, const char *expect)
+{
+	char type[20];
+
+	if (sha1_object_info(sha1, type, NULL))
+		die("%s is not a valid object", sha1_to_hex(sha1));
+	if (expect && strcmp(type, expect))
+		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
+		    expect);
+}
+
+/*
+ * Having more than two parents is not strange at all, and this is
+ * how multi-way merges are represented.
+ */
+#define MAXPARENT (16)
+static unsigned char parent_sha1[MAXPARENT][20];
+
+static const char commit_tree_usage[] = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
+
+static int new_parent(int idx)
+{
+	int i;
+	unsigned char *sha1 = parent_sha1[idx];
+	for (i = 0; i < idx; i++) {
+		if (!memcmp(parent_sha1[i], sha1, 20)) {
+			error("duplicate parent %s ignored", sha1_to_hex(sha1));
+			return 0;
+		}
+	}
+	return 1;
+}
+
+int cmd_commit_tree(int argc, const char **argv, char **envp)
+{
+	int i;
+	int parents = 0;
+	unsigned char tree_sha1[20];
+	unsigned char commit_sha1[20];
+	char comment[1000];
+	char *buffer;
+	unsigned int size;
+
+	setup_ident();
+	setup_git_directory();
+
+	git_config(git_default_config);
+
+	if (argc < 2)
+		usage(commit_tree_usage);
+	if (get_sha1(argv[1], tree_sha1))
+		die("Not a valid object name %s", argv[1]);
+
+	check_valid(tree_sha1, tree_type);
+	for (i = 2; i < argc; i += 2) {
+		char *a, *b;
+		a = argv[i]; b = argv[i+1];
+		if (!b || strcmp(a, "-p"))
+			usage(commit_tree_usage);
+		if (get_sha1(b, parent_sha1[parents]))
+			die("Not a valid object name %s", b);
+		check_valid(parent_sha1[parents], commit_type);
+		if (new_parent(parents))
+			parents++;
+	}
+	if (!parents)
+		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
+
+	init_buffer(&buffer, &size);
+	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
+
+	/*
+	 * NOTE! This ordering means that the same exact tree merged with a
+	 * different order of parents will be a _different_ changeset even
+	 * if everything else stays the same.
+	 */
+	for (i = 0; i < parents; i++)
+		add_buffer(&buffer, &size, "parent %s\n", sha1_to_hex(parent_sha1[i]));
+
+	/* Person/date information */
+	add_buffer(&buffer, &size, "author %s\n", git_author_info(1));
+	add_buffer(&buffer, &size, "committer %s\n\n", git_committer_info(1));
+
+	/* And add the comment */
+	while (fgets(comment, sizeof(comment), stdin) != NULL)
+		add_buffer(&buffer, &size, "%s", comment);
+
+	if (!write_sha1_file(buffer, size, commit_type, commit_sha1)) {
+		printf("%s\n", sha1_to_hex(commit_sha1));
+		return 0;
+	}
+	else
+		return 1;
+}
diff --git a/builtin.h b/builtin.h
index 88b3523..c6b07d9 100644
--- a/builtin.h
+++ b/builtin.h
@@ -31,5 +31,6 @@ extern int cmd_ls_files(int argc, const 
 extern int cmd_ls_tree(int argc, const char **argv, char **envp);
 extern int cmd_tar_tree(int argc, const char **argv, char **envp);
 extern int cmd_read_tree(int argc, const char **argv, char **envp);
+extern int cmd_commit_tree(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/commit-tree.c b/commit-tree.c
deleted file mode 100644
index 0320036..0000000
--- a/commit-tree.c
+++ /dev/null
@@ -1,139 +0,0 @@
-/*
- * GIT - The information manager from hell
- *
- * Copyright (C) Linus Torvalds, 2005
- */
-#include "cache.h"
-#include "commit.h"
-#include "tree.h"
-
-#define BLOCKING (1ul << 14)
-
-/*
- * FIXME! Share the code with "write-tree.c"
- */
-static void init_buffer(char **bufp, unsigned int *sizep)
-{
-	char *buf = xmalloc(BLOCKING);
-	*sizep = 0;
-	*bufp = buf;
-}
-
-static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
-{
-	char one_line[2048];
-	va_list args;
-	int len;
-	unsigned long alloc, size, newsize;
-	char *buf;
-
-	va_start(args, fmt);
-	len = vsnprintf(one_line, sizeof(one_line), fmt, args);
-	va_end(args);
-	size = *sizep;
-	newsize = size + len;
-	alloc = (size + 32767) & ~32767;
-	buf = *bufp;
-	if (newsize > alloc) {
-		alloc = (newsize + 32767) & ~32767;
-		buf = xrealloc(buf, alloc);
-		*bufp = buf;
-	}
-	*sizep = newsize;
-	memcpy(buf + size, one_line, len);
-}
-
-static void check_valid(unsigned char *sha1, const char *expect)
-{
-	char type[20];
-
-	if (sha1_object_info(sha1, type, NULL))
-		die("%s is not a valid object", sha1_to_hex(sha1));
-	if (expect && strcmp(type, expect))
-		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
-		    expect);
-}
-
-/*
- * Having more than two parents is not strange at all, and this is
- * how multi-way merges are represented.
- */
-#define MAXPARENT (16)
-static unsigned char parent_sha1[MAXPARENT][20];
-
-static const char commit_tree_usage[] = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
-
-static int new_parent(int idx)
-{
-	int i;
-	unsigned char *sha1 = parent_sha1[idx];
-	for (i = 0; i < idx; i++) {
-		if (!memcmp(parent_sha1[i], sha1, 20)) {
-			error("duplicate parent %s ignored", sha1_to_hex(sha1));
-			return 0;
-		}
-	}
-	return 1;
-}
-
-int main(int argc, char **argv)
-{
-	int i;
-	int parents = 0;
-	unsigned char tree_sha1[20];
-	unsigned char commit_sha1[20];
-	char comment[1000];
-	char *buffer;
-	unsigned int size;
-
-	setup_ident();
-	setup_git_directory();
-
-	git_config(git_default_config);
-
-	if (argc < 2)
-		usage(commit_tree_usage);
-	if (get_sha1(argv[1], tree_sha1))
-		die("Not a valid object name %s", argv[1]);
-
-	check_valid(tree_sha1, tree_type);
-	for (i = 2; i < argc; i += 2) {
-		char *a, *b;
-		a = argv[i]; b = argv[i+1];
-		if (!b || strcmp(a, "-p"))
-			usage(commit_tree_usage);
-		if (get_sha1(b, parent_sha1[parents]))
-			die("Not a valid object name %s", b);
-		check_valid(parent_sha1[parents], commit_type);
-		if (new_parent(parents))
-			parents++;
-	}
-	if (!parents)
-		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
-
-	init_buffer(&buffer, &size);
-	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
-
-	/*
-	 * NOTE! This ordering means that the same exact tree merged with a
-	 * different order of parents will be a _different_ changeset even
-	 * if everything else stays the same.
-	 */
-	for (i = 0; i < parents; i++)
-		add_buffer(&buffer, &size, "parent %s\n", sha1_to_hex(parent_sha1[i]));
-
-	/* Person/date information */
-	add_buffer(&buffer, &size, "author %s\n", git_author_info(1));
-	add_buffer(&buffer, &size, "committer %s\n\n", git_committer_info(1));
-
-	/* And add the comment */
-	while (fgets(comment, sizeof(comment), stdin) != NULL)
-		add_buffer(&buffer, &size, "%s", comment);
-
-	if (!write_sha1_file(buffer, size, commit_type, commit_sha1)) {
-		printf("%s\n", sha1_to_hex(commit_sha1));
-		return 0;
-	}
-	else
-		return 1;
-}
diff --git a/git.c b/git.c
index 300e2b2..4c2c062 100644
--- a/git.c
+++ b/git.c
@@ -56,7 +56,8 @@ static void handle_internal_command(int 
 		{ "ls-files", cmd_ls_files },
 		{ "ls-tree", cmd_ls_tree },
 		{ "tar-tree", cmd_tar_tree },
-		{ "read-tree", cmd_read_tree }
+		{ "read-tree", cmd_read_tree },
+		{ "commit-tree", cmd_commit_tree }
 	};
 	int i;
 
-- 
1.3.3.g288c
