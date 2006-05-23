From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH 2/8] Builtin git-ls-tree.
Date: Tue, 23 May 2006 10:31:14 +0200
Message-ID: <10383.0593442128$1148373112@news.gmane.org>
References: <11483730802025-git-send-email->
Reply-To: Patches/0001-Builtin-git-ls-files.txt@bohr.gbar.dtu.dk
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue May 23 10:31:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiSIb-0001bZ-OI
	for gcvg-git@gmane.org; Tue, 23 May 2006 10:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWEWIbX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 04:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWEWIbX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 04:31:23 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:54251 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932117AbWEWIbW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 04:31:22 -0400
Received: (qmail 8458 invoked by uid 5842); 23 May 2006 10:31:20 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
In-Reply-To: <11483730802025-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20582>

From: Peter Eriksen <s022018@student.dtu.dk>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

419257801e5bc91fc435bd4ff9eb42aa8063ffbb
 Makefile          |    6 +-
 builtin-ls-tree.c |  156 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h         |    1 
 git.c             |    3 +
 ls-tree.c         |  155 -----------------------------------------------------
 5 files changed, 162 insertions(+), 159 deletions(-)
 create mode 100644 builtin-ls-tree.c
 delete mode 100644 ls-tree.c

419257801e5bc91fc435bd4ff9eb42aa8063ffbb
diff --git a/Makefile b/Makefile
index e522730..9b02264 100644
--- a/Makefile
+++ b/Makefile
@@ -155,7 +155,7 @@ PROGRAMS = \
 	git-diff-index$X git-diff-stages$X \
 	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
-	git-ls-tree$X git-mailinfo$X git-merge-base$X \
+	git-mailinfo$X git-merge-base$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
 	git-peek-remote$X git-prune-packed$X git-read-tree$X \
 	git-receive-pack$X git-rev-parse$X \
@@ -171,7 +171,7 @@ PROGRAMS = \
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
 	git-grep$X git-rev-list$X git-check-ref-format$X \
-	git-init-db$X git-ls-files$X
+	git-init-db$X git-ls-files$X git-ls-tree$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -220,7 +220,7 @@ LIB_OBJS = \
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
-	builtin-init-db.o builtin-ls-files.o
+	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
new file mode 100644
index 0000000..b515307
--- /dev/null
+++ b/builtin-ls-tree.c
@@ -0,0 +1,156 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Linus Torvalds, 2005
+ */
+#include "cache.h"
+#include "blob.h"
+#include "tree.h"
+#include "quote.h"
+#include "builtin.h"
+
+static int line_termination = '\n';
+#define LS_RECURSIVE 1
+#define LS_TREE_ONLY 2
+#define LS_SHOW_TREES 4
+#define LS_NAME_ONLY 8
+static int abbrev = 0;
+static int ls_options = 0;
+const char **pathspec;
+static int chomp_prefix = 0;
+static const char *prefix;
+
+static const char ls_tree_usage[] =
+	"git-ls-tree [-d] [-r] [-t] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
+
+static int show_recursive(const char *base, int baselen, const char *pathname)
+{
+	const char **s;
+
+	if (ls_options & LS_RECURSIVE)
+		return 1;
+
+	s = pathspec;
+	if (!s)
+		return 0;
+
+	for (;;) {
+		const char *spec = *s++;
+		int len, speclen;
+
+		if (!spec)
+			return 0;
+		if (strncmp(base, spec, baselen))
+			continue;
+		len = strlen(pathname);
+		spec += baselen;
+		speclen = strlen(spec);
+		if (speclen <= len)
+			continue;
+		if (memcmp(pathname, spec, len))
+			continue;
+		return 1;
+	}
+}
+
+static int show_tree(unsigned char *sha1, const char *base, int baselen,
+		     const char *pathname, unsigned mode, int stage)
+{
+	int retval = 0;
+	const char *type = blob_type;
+
+	if (S_ISDIR(mode)) {
+		if (show_recursive(base, baselen, pathname)) {
+			retval = READ_TREE_RECURSIVE;
+			if (!(ls_options & LS_SHOW_TREES))
+				return retval;
+		}
+		type = tree_type;
+	}
+	else if (ls_options & LS_TREE_ONLY)
+		return 0;
+
+	if (chomp_prefix &&
+	    (baselen < chomp_prefix || memcmp(prefix, base, chomp_prefix)))
+		return 0;
+
+	if (!(ls_options & LS_NAME_ONLY))
+		printf("%06o %s %s\t", mode, type,
+				abbrev ? find_unique_abbrev(sha1,abbrev)
+					: sha1_to_hex(sha1));
+	write_name_quoted(base + chomp_prefix, baselen - chomp_prefix,
+			  pathname,
+			  line_termination, stdout);
+	putchar(line_termination);
+	return retval;
+}
+
+int cmd_ls_tree(int argc, const char **argv, char **envp)
+{
+	unsigned char sha1[20];
+	struct tree *tree;
+
+	prefix = setup_git_directory();
+	git_config(git_default_config);
+	if (prefix && *prefix)
+		chomp_prefix = strlen(prefix);
+	while (1 < argc && argv[1][0] == '-') {
+		switch (argv[1][1]) {
+		case 'z':
+			line_termination = 0;
+			break;
+		case 'r':
+			ls_options |= LS_RECURSIVE;
+			break;
+		case 'd':
+			ls_options |= LS_TREE_ONLY;
+			break;
+		case 't':
+			ls_options |= LS_SHOW_TREES;
+			break;
+		case '-':
+			if (!strcmp(argv[1]+2, "name-only") ||
+			    !strcmp(argv[1]+2, "name-status")) {
+				ls_options |= LS_NAME_ONLY;
+				break;
+			}
+			if (!strcmp(argv[1]+2, "full-name")) {
+				chomp_prefix = 0;
+				break;
+			}
+			if (!strncmp(argv[1]+2, "abbrev=",7)) {
+				abbrev = strtoul(argv[1]+9, NULL, 10);
+				if (abbrev && abbrev < MINIMUM_ABBREV)
+					abbrev = MINIMUM_ABBREV;
+				else if (abbrev > 40)
+					abbrev = 40;
+				break;
+			}
+			if (!strcmp(argv[1]+2, "abbrev")) {
+				abbrev = DEFAULT_ABBREV;
+				break;
+			}
+			/* otherwise fallthru */
+		default:
+			usage(ls_tree_usage);
+		}
+		argc--; argv++;
+	}
+	/* -d -r should imply -t, but -d by itself should not have to. */
+	if ( (LS_TREE_ONLY|LS_RECURSIVE) ==
+	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
+		ls_options |= LS_SHOW_TREES;
+
+	if (argc < 2)
+		usage(ls_tree_usage);
+	if (get_sha1(argv[1], sha1))
+		die("Not a valid object name %s", argv[1]);
+
+	pathspec = get_pathspec(prefix, argv + 2);
+	tree = parse_tree_indirect(sha1);
+	if (!tree)
+		die("not a tree object");
+	read_tree_recursive(tree, "", 0, 0, pathspec, show_tree);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index a0713d3..951f206 100644
--- a/builtin.h
+++ b/builtin.h
@@ -28,5 +28,6 @@ extern int cmd_rev_list(int argc, const 
 extern int cmd_check_ref_format(int argc, const char **argv, char **envp);
 extern int cmd_init_db(int argc, const char **argv, char **envp);
 extern int cmd_ls_files(int argc, const char **argv, char **envp);
+extern int cmd_ls_tree(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 9cfa9eb..8574775 100644
--- a/git.c
+++ b/git.c
@@ -53,7 +53,8 @@ static void handle_internal_command(int 
 		{ "rev-list", cmd_rev_list },
 		{ "init-db", cmd_init_db },
 		{ "check-ref-format", cmd_check_ref_format },
-		{ "ls-files", cmd_ls_files }
+		{ "ls-files", cmd_ls_files },
+		{ "ls-tree", cmd_ls_tree }
 	};
 	int i;
 
diff --git a/ls-tree.c b/ls-tree.c
deleted file mode 100644
index f2b3bc1..0000000
--- a/ls-tree.c
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- * GIT - The information manager from hell
- *
- * Copyright (C) Linus Torvalds, 2005
- */
-#include "cache.h"
-#include "blob.h"
-#include "tree.h"
-#include "quote.h"
-
-static int line_termination = '\n';
-#define LS_RECURSIVE 1
-#define LS_TREE_ONLY 2
-#define LS_SHOW_TREES 4
-#define LS_NAME_ONLY 8
-static int abbrev = 0;
-static int ls_options = 0;
-const char **pathspec;
-static int chomp_prefix = 0;
-static const char *prefix;
-
-static const char ls_tree_usage[] =
-	"git-ls-tree [-d] [-r] [-t] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
-
-static int show_recursive(const char *base, int baselen, const char *pathname)
-{
-	const char **s;
-
-	if (ls_options & LS_RECURSIVE)
-		return 1;
-
-	s = pathspec;
-	if (!s)
-		return 0;
-
-	for (;;) {
-		const char *spec = *s++;
-		int len, speclen;
-
-		if (!spec)
-			return 0;
-		if (strncmp(base, spec, baselen))
-			continue;
-		len = strlen(pathname);
-		spec += baselen;
-		speclen = strlen(spec);
-		if (speclen <= len)
-			continue;
-		if (memcmp(pathname, spec, len))
-			continue;
-		return 1;
-	}
-}
-
-static int show_tree(unsigned char *sha1, const char *base, int baselen,
-		     const char *pathname, unsigned mode, int stage)
-{
-	int retval = 0;
-	const char *type = blob_type;
-
-	if (S_ISDIR(mode)) {
-		if (show_recursive(base, baselen, pathname)) {
-			retval = READ_TREE_RECURSIVE;
-			if (!(ls_options & LS_SHOW_TREES))
-				return retval;
-		}
-		type = tree_type;
-	}
-	else if (ls_options & LS_TREE_ONLY)
-		return 0;
-
-	if (chomp_prefix &&
-	    (baselen < chomp_prefix || memcmp(prefix, base, chomp_prefix)))
-		return 0;
-
-	if (!(ls_options & LS_NAME_ONLY))
-		printf("%06o %s %s\t", mode, type,
-				abbrev ? find_unique_abbrev(sha1,abbrev)
-					: sha1_to_hex(sha1));
-	write_name_quoted(base + chomp_prefix, baselen - chomp_prefix,
-			  pathname,
-			  line_termination, stdout);
-	putchar(line_termination);
-	return retval;
-}
-
-int main(int argc, const char **argv)
-{
-	unsigned char sha1[20];
-	struct tree *tree;
-
-	prefix = setup_git_directory();
-	git_config(git_default_config);
-	if (prefix && *prefix)
-		chomp_prefix = strlen(prefix);
-	while (1 < argc && argv[1][0] == '-') {
-		switch (argv[1][1]) {
-		case 'z':
-			line_termination = 0;
-			break;
-		case 'r':
-			ls_options |= LS_RECURSIVE;
-			break;
-		case 'd':
-			ls_options |= LS_TREE_ONLY;
-			break;
-		case 't':
-			ls_options |= LS_SHOW_TREES;
-			break;
-		case '-':
-			if (!strcmp(argv[1]+2, "name-only") ||
-			    !strcmp(argv[1]+2, "name-status")) {
-				ls_options |= LS_NAME_ONLY;
-				break;
-			}
-			if (!strcmp(argv[1]+2, "full-name")) {
-				chomp_prefix = 0;
-				break;
-			}
-			if (!strncmp(argv[1]+2, "abbrev=",7)) {
-				abbrev = strtoul(argv[1]+9, NULL, 10);
-				if (abbrev && abbrev < MINIMUM_ABBREV)
-					abbrev = MINIMUM_ABBREV;
-				else if (abbrev > 40)
-					abbrev = 40;
-				break;
-			}
-			if (!strcmp(argv[1]+2, "abbrev")) {
-				abbrev = DEFAULT_ABBREV;
-				break;
-			}
-			/* otherwise fallthru */
-		default:
-			usage(ls_tree_usage);
-		}
-		argc--; argv++;
-	}
-	/* -d -r should imply -t, but -d by itself should not have to. */
-	if ( (LS_TREE_ONLY|LS_RECURSIVE) ==
-	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
-		ls_options |= LS_SHOW_TREES;
-
-	if (argc < 2)
-		usage(ls_tree_usage);
-	if (get_sha1(argv[1], sha1))
-		die("Not a valid object name %s", argv[1]);
-
-	pathspec = get_pathspec(prefix, argv + 2);
-	tree = parse_tree_indirect(sha1);
-	if (!tree)
-		die("not a tree object");
-	read_tree_recursive(tree, "", 0, 0, pathspec, show_tree);
-
-	return 0;
-}
-- 
1.3.3.g288c
