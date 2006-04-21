From: Linus Torvalds <torvalds@osdl.org>
Subject: Split up builtin commands into separate files from git.c
Date: Fri, 21 Apr 2006 10:27:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604211022440.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Apr 21 19:27:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWzQ1-0005Gl-2R
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 19:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWDUR1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 13:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWDUR1m
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 13:27:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932098AbWDUR1l (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Apr 2006 13:27:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3LHRZtH008389
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Apr 2006 10:27:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3LHRY5h007915;
	Fri, 21 Apr 2006 10:27:35 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19022>


Right now it split it into "builtin-log.c" for log-related commands
("log", "show" and "whatchanged"), and "builtin-help.c" for the
informational commands (usage printing and "help" and "version").

This just makes things easier to read, I find.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

[ Hey, make of this what you will. There's no real code changes, except I 
  used that "git_version_string[]" variable to make things easier to 
  build, and I renamed "cmd_wc" to "cmd_whatchanged", since when it's 
  split up into another file, we don't want to have a gratuitous 
  short-hand that we have to remember across files.

  I find things easier to work with the more you split them up along 
  conceptual lines, and as we do more and more built-ins, git.c would end 
  up a horrible mess unless we do _something_ like this.

  But if people don't like it, it's not a big deal. Another throw-away 
  patch from me. ]

 Makefile       |    9 +-
 builtin-help.c |  241 ++++++++++++++++++++++++++++++++++++++++++++
 builtin-log.c  |   69 +++++++++++++
 builtin.h      |   23 ++++
 git.c          |  305 +-------------------------------------------------------
 5 files changed, 342 insertions(+), 305 deletions(-)

diff --git a/Makefile b/Makefile
index 3ecd674..a83c502 100644
--- a/Makefile
+++ b/Makefile
@@ -213,6 +213,9 @@ LIB_OBJS = \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
 	$(DIFF_OBJS)
 
+BUILTIN_OBJS = \
+	builtin-log.o builtin-help.o
+
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
 
@@ -462,10 +465,10 @@ all:
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
-git$X: git.c common-cmds.h $(GITLIBS)
+git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS)
 	$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
-		$(ALL_LDFLAGS) $(LIBS)
+		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
 $(BUILT_INS): git$X
 	rm -f $@ && ln git$X $@
@@ -565,7 +568,7 @@ init-db.o: init-db.c
 	$(CC) -c $(ALL_CFLAGS) \
 		-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $*.c
 
-$(LIB_OBJS): $(LIB_H)
+$(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(GITLIBS)
 $(DIFF_OBJS): diffcore.h
 
diff --git a/builtin-help.c b/builtin-help.c
new file mode 100644
index 0000000..10a59cc
--- /dev/null
+++ b/builtin-help.c
@@ -0,0 +1,241 @@
+/*
+ * builtin-help.c
+ *
+ * Builtin help-related commands (help, usage, version)
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "exec_cmd.h"
+#include "common-cmds.h"
+
+static const char git_usage[] =
+	"Usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ ARGS ]";
+
+/* most gui terms set COLUMNS (although some don't export it) */
+static int term_columns(void)
+{
+	char *col_string = getenv("COLUMNS");
+	int n_cols = 0;
+
+	if (col_string && (n_cols = atoi(col_string)) > 0)
+		return n_cols;
+
+#ifdef TIOCGWINSZ
+	{
+		struct winsize ws;
+		if (!ioctl(1, TIOCGWINSZ, &ws)) {
+			if (ws.ws_col)
+				return ws.ws_col;
+		}
+	}
+#endif
+
+	return 80;
+}
+
+static void oom(void)
+{
+	fprintf(stderr, "git: out of memory\n");
+	exit(1);
+}
+
+static inline void mput_char(char c, unsigned int num)
+{
+	while(num--)
+		putchar(c);
+}
+
+static struct cmdname {
+	size_t len;
+	char name[1];
+} **cmdname;
+static int cmdname_alloc, cmdname_cnt;
+
+static void add_cmdname(const char *name, int len)
+{
+	struct cmdname *ent;
+	if (cmdname_alloc <= cmdname_cnt) {
+		cmdname_alloc = cmdname_alloc + 200;
+		cmdname = realloc(cmdname, cmdname_alloc * sizeof(*cmdname));
+		if (!cmdname)
+			oom();
+	}
+	ent = malloc(sizeof(*ent) + len);
+	if (!ent)
+		oom();
+	ent->len = len;
+	memcpy(ent->name, name, len);
+	ent->name[len] = 0;
+	cmdname[cmdname_cnt++] = ent;
+}
+
+static int cmdname_compare(const void *a_, const void *b_)
+{
+	struct cmdname *a = *(struct cmdname **)a_;
+	struct cmdname *b = *(struct cmdname **)b_;
+	return strcmp(a->name, b->name);
+}
+
+static void pretty_print_string_list(struct cmdname **cmdname, int longest)
+{
+	int cols = 1, rows;
+	int space = longest + 1; /* min 1 SP between words */
+	int max_cols = term_columns() - 1; /* don't print *on* the edge */
+	int i, j;
+
+	if (space < max_cols)
+		cols = max_cols / space;
+	rows = (cmdname_cnt + cols - 1) / cols;
+
+	qsort(cmdname, cmdname_cnt, sizeof(*cmdname), cmdname_compare);
+
+	for (i = 0; i < rows; i++) {
+		printf("  ");
+
+		for (j = 0; j < cols; j++) {
+			int n = j * rows + i;
+			int size = space;
+			if (n >= cmdname_cnt)
+				break;
+			if (j == cols-1 || n + rows >= cmdname_cnt)
+				size = 1;
+			printf("%-*s", size, cmdname[n]->name);
+		}
+		putchar('\n');
+	}
+}
+
+static void list_commands(const char *exec_path, const char *pattern)
+{
+	unsigned int longest = 0;
+	char path[PATH_MAX];
+	int dirlen;
+	DIR *dir = opendir(exec_path);
+	struct dirent *de;
+
+	if (!dir) {
+		fprintf(stderr, "git: '%s': %s\n", exec_path, strerror(errno));
+		exit(1);
+	}
+
+	dirlen = strlen(exec_path);
+	if (PATH_MAX - 20 < dirlen) {
+		fprintf(stderr, "git: insanely long exec-path '%s'\n",
+			exec_path);
+		exit(1);
+	}
+
+	memcpy(path, exec_path, dirlen);
+	path[dirlen++] = '/';
+
+	while ((de = readdir(dir)) != NULL) {
+		struct stat st;
+		int entlen;
+
+		if (strncmp(de->d_name, "git-", 4))
+			continue;
+		strcpy(path+dirlen, de->d_name);
+		if (stat(path, &st) || /* stat, not lstat */
+		    !S_ISREG(st.st_mode) ||
+		    !(st.st_mode & S_IXUSR))
+			continue;
+
+		entlen = strlen(de->d_name);
+		if (4 < entlen && !strcmp(de->d_name + entlen - 4, ".exe"))
+			entlen -= 4;
+
+		if (longest < entlen)
+			longest = entlen;
+
+		add_cmdname(de->d_name + 4, entlen-4);
+	}
+	closedir(dir);
+
+	printf("git commands available in '%s'\n", exec_path);
+	printf("----------------------------");
+	mput_char('-', strlen(exec_path));
+	putchar('\n');
+	pretty_print_string_list(cmdname, longest - 4);
+	putchar('\n');
+}
+
+static void list_common_cmds_help(void)
+{
+	int i, longest = 0;
+
+	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
+		if (longest < strlen(common_cmds[i].name))
+			longest = strlen(common_cmds[i].name);
+	}
+
+	puts("The most commonly used git commands are:");
+	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
+		printf("    %s", common_cmds[i].name);
+		mput_char(' ', longest - strlen(common_cmds[i].name) + 4);
+		puts(common_cmds[i].help);
+	}
+	puts("(use 'git help -a' to get a list of all installed git commands)");
+}
+
+void cmd_usage(int show_all, const char *exec_path, const char *fmt, ...)
+{
+	if (fmt) {
+		va_list ap;
+
+		va_start(ap, fmt);
+		printf("git: ");
+		vprintf(fmt, ap);
+		va_end(ap);
+		putchar('\n');
+	}
+	else
+		puts(git_usage);
+
+	if (exec_path) {
+		putchar('\n');
+		if (show_all)
+			list_commands(exec_path, "git-*");
+		else
+			list_common_cmds_help();
+        }
+
+	exit(1);
+}
+
+static void show_man_page(const char *git_cmd)
+{
+	const char *page;
+
+	if (!strncmp(git_cmd, "git", 3))
+		page = git_cmd;
+	else {
+		int page_len = strlen(git_cmd) + 4;
+		char *p = malloc(page_len + 1);
+		strcpy(p, "git-");
+		strcpy(p + 4, git_cmd);
+		p[page_len] = 0;
+		page = p;
+	}
+
+	execlp("man", "man", page, NULL);
+}
+
+int cmd_version(int argc, const char **argv, char **envp)
+{
+	printf("git version %s\n", git_version_string);
+	return 0;
+}
+
+int cmd_help(int argc, const char **argv, char **envp)
+{
+	const char *help_cmd = argv[1];
+	if (!help_cmd)
+		cmd_usage(0, git_exec_path(), NULL);
+	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a"))
+		cmd_usage(1, git_exec_path(), NULL);
+	else
+		show_man_page(help_cmd);
+	return 0;
+}
+
+
diff --git a/builtin-log.c b/builtin-log.c
new file mode 100644
index 0000000..418101d
--- /dev/null
+++ b/builtin-log.c
@@ -0,0 +1,69 @@
+/*
+ * Builtin "git log" and related commands (show, whatchanged)
+ *
+ * (C) Copyright 2006 Linus Torvalds
+ *		 2006 Junio Hamano
+ */ 
+#include "cache.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+#include "log-tree.h"
+
+static int cmd_log_wc(int argc, const char **argv, char **envp,
+		      struct rev_info *rev)
+{
+	struct commit *commit;
+
+	rev->abbrev = DEFAULT_ABBREV;
+	rev->commit_format = CMIT_FMT_DEFAULT;
+	rev->verbose_header = 1;
+	argc = setup_revisions(argc, argv, rev, "HEAD");
+
+	if (argc > 1)
+		die("unrecognized argument: %s", argv[1]);
+
+	prepare_revision_walk(rev);
+	setup_pager();
+	while ((commit = get_revision(rev)) != NULL) {
+		log_tree_commit(rev, commit);
+		free(commit->buffer);
+		commit->buffer = NULL;
+	}
+	return 0;
+}
+
+int cmd_whatchanged(int argc, const char **argv, char **envp)
+{
+	struct rev_info rev;
+
+	init_revisions(&rev);
+	rev.diff = 1;
+	rev.diffopt.recursive = 1;
+	return cmd_log_wc(argc, argv, envp, &rev);
+}
+
+int cmd_show(int argc, const char **argv, char **envp)
+{
+	struct rev_info rev;
+
+	init_revisions(&rev);
+	rev.diff = 1;
+	rev.diffopt.recursive = 1;
+	rev.combine_merges = 1;
+	rev.dense_combined_merges = 1;
+	rev.always_show_header = 1;
+	rev.ignore_merges = 0;
+	rev.no_walk = 1;
+	return cmd_log_wc(argc, argv, envp, &rev);
+}
+
+int cmd_log(int argc, const char **argv, char **envp)
+{
+	struct rev_info rev;
+
+	init_revisions(&rev);
+	rev.always_show_header = 1;
+	rev.diffopt.recursive = 1;
+	return cmd_log_wc(argc, argv, envp, &rev);
+}
diff --git a/builtin.h b/builtin.h
new file mode 100644
index 0000000..47408a0
--- /dev/null
+++ b/builtin.h
@@ -0,0 +1,23 @@
+#ifndef BUILTIN_H
+#define BUILTIN_H
+
+#ifndef PATH_MAX
+# define PATH_MAX 4096
+#endif
+
+extern const char git_version_string[];
+
+void cmd_usage(int show_all, const char *exec_path, const char *fmt, ...)
+#ifdef __GNUC__
+	__attribute__((__format__(__printf__, 3, 4), __noreturn__))
+#endif
+	;
+
+extern int cmd_help(int argc, const char **argv, char **envp);
+extern int cmd_version(int argc, const char **argv, char **envp);
+
+extern int cmd_whatchanged(int argc, const char **argv, char **envp);
+extern int cmd_show(int argc, const char **argv, char **envp);
+extern int cmd_log(int argc, const char **argv, char **envp);
+
+#endif
diff --git a/git.c b/git.c
index 40b7e42..aa2b814 100644
--- a/git.c
+++ b/git.c
@@ -11,215 +11,8 @@ #include <stdarg.h>
 #include <sys/ioctl.h>
 #include "git-compat-util.h"
 #include "exec_cmd.h"
-#include "common-cmds.h"
 
-#include "cache.h"
-#include "commit.h"
-#include "diff.h"
-#include "revision.h"
-#include "log-tree.h"
-
-#ifndef PATH_MAX
-# define PATH_MAX 4096
-#endif
-
-static const char git_usage[] =
-	"Usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ ARGS ]";
-
-/* most gui terms set COLUMNS (although some don't export it) */
-static int term_columns(void)
-{
-	char *col_string = getenv("COLUMNS");
-	int n_cols = 0;
-
-	if (col_string && (n_cols = atoi(col_string)) > 0)
-		return n_cols;
-
-#ifdef TIOCGWINSZ
-	{
-		struct winsize ws;
-		if (!ioctl(1, TIOCGWINSZ, &ws)) {
-			if (ws.ws_col)
-				return ws.ws_col;
-		}
-	}
-#endif
-
-	return 80;
-}
-
-static void oom(void)
-{
-	fprintf(stderr, "git: out of memory\n");
-	exit(1);
-}
-
-static inline void mput_char(char c, unsigned int num)
-{
-	while(num--)
-		putchar(c);
-}
-
-static struct cmdname {
-	size_t len;
-	char name[1];
-} **cmdname;
-static int cmdname_alloc, cmdname_cnt;
-
-static void add_cmdname(const char *name, int len)
-{
-	struct cmdname *ent;
-	if (cmdname_alloc <= cmdname_cnt) {
-		cmdname_alloc = cmdname_alloc + 200;
-		cmdname = realloc(cmdname, cmdname_alloc * sizeof(*cmdname));
-		if (!cmdname)
-			oom();
-	}
-	ent = malloc(sizeof(*ent) + len);
-	if (!ent)
-		oom();
-	ent->len = len;
-	memcpy(ent->name, name, len);
-	ent->name[len] = 0;
-	cmdname[cmdname_cnt++] = ent;
-}
-
-static int cmdname_compare(const void *a_, const void *b_)
-{
-	struct cmdname *a = *(struct cmdname **)a_;
-	struct cmdname *b = *(struct cmdname **)b_;
-	return strcmp(a->name, b->name);
-}
-
-static void pretty_print_string_list(struct cmdname **cmdname, int longest)
-{
-	int cols = 1, rows;
-	int space = longest + 1; /* min 1 SP between words */
-	int max_cols = term_columns() - 1; /* don't print *on* the edge */
-	int i, j;
-
-	if (space < max_cols)
-		cols = max_cols / space;
-	rows = (cmdname_cnt + cols - 1) / cols;
-
-	qsort(cmdname, cmdname_cnt, sizeof(*cmdname), cmdname_compare);
-
-	for (i = 0; i < rows; i++) {
-		printf("  ");
-
-		for (j = 0; j < cols; j++) {
-			int n = j * rows + i;
-			int size = space;
-			if (n >= cmdname_cnt)
-				break;
-			if (j == cols-1 || n + rows >= cmdname_cnt)
-				size = 1;
-			printf("%-*s", size, cmdname[n]->name);
-		}
-		putchar('\n');
-	}
-}
-
-static void list_commands(const char *exec_path, const char *pattern)
-{
-	unsigned int longest = 0;
-	char path[PATH_MAX];
-	int dirlen;
-	DIR *dir = opendir(exec_path);
-	struct dirent *de;
-
-	if (!dir) {
-		fprintf(stderr, "git: '%s': %s\n", exec_path, strerror(errno));
-		exit(1);
-	}
-
-	dirlen = strlen(exec_path);
-	if (PATH_MAX - 20 < dirlen) {
-		fprintf(stderr, "git: insanely long exec-path '%s'\n",
-			exec_path);
-		exit(1);
-	}
-
-	memcpy(path, exec_path, dirlen);
-	path[dirlen++] = '/';
-
-	while ((de = readdir(dir)) != NULL) {
-		struct stat st;
-		int entlen;
-
-		if (strncmp(de->d_name, "git-", 4))
-			continue;
-		strcpy(path+dirlen, de->d_name);
-		if (stat(path, &st) || /* stat, not lstat */
-		    !S_ISREG(st.st_mode) ||
-		    !(st.st_mode & S_IXUSR))
-			continue;
-
-		entlen = strlen(de->d_name);
-		if (4 < entlen && !strcmp(de->d_name + entlen - 4, ".exe"))
-			entlen -= 4;
-
-		if (longest < entlen)
-			longest = entlen;
-
-		add_cmdname(de->d_name + 4, entlen-4);
-	}
-	closedir(dir);
-
-	printf("git commands available in '%s'\n", exec_path);
-	printf("----------------------------");
-	mput_char('-', strlen(exec_path));
-	putchar('\n');
-	pretty_print_string_list(cmdname, longest - 4);
-	putchar('\n');
-}
-
-static void list_common_cmds_help(void)
-{
-	int i, longest = 0;
-
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		if (longest < strlen(common_cmds[i].name))
-			longest = strlen(common_cmds[i].name);
-	}
-
-	puts("The most commonly used git commands are:");
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("    %s", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name) + 4);
-		puts(common_cmds[i].help);
-	}
-	puts("(use 'git help -a' to get a list of all installed git commands)");
-}
-
-#ifdef __GNUC__
-static void cmd_usage(int show_all, const char *exec_path, const char *fmt, ...)
-	__attribute__((__format__(__printf__, 3, 4), __noreturn__));
-#endif
-static void cmd_usage(int show_all, const char *exec_path, const char *fmt, ...)
-{
-	if (fmt) {
-		va_list ap;
-
-		va_start(ap, fmt);
-		printf("git: ");
-		vprintf(fmt, ap);
-		va_end(ap);
-		putchar('\n');
-	}
-	else
-		puts(git_usage);
-
-	if (exec_path) {
-		putchar('\n');
-		if (show_all)
-			list_commands(exec_path, "git-*");
-		else
-			list_common_cmds_help();
-        }
-
-	exit(1);
-}
+#include "builtin.h"
 
 static void prepend_to_path(const char *dir, int len)
 {
@@ -240,99 +33,7 @@ static void prepend_to_path(const char *
 	setenv("PATH", path, 1);
 }
 
-static void show_man_page(const char *git_cmd)
-{
-	const char *page;
-
-	if (!strncmp(git_cmd, "git", 3))
-		page = git_cmd;
-	else {
-		int page_len = strlen(git_cmd) + 4;
-		char *p = malloc(page_len + 1);
-		strcpy(p, "git-");
-		strcpy(p + 4, git_cmd);
-		p[page_len] = 0;
-		page = p;
-	}
-
-	execlp("man", "man", page, NULL);
-}
-
-static int cmd_version(int argc, const char **argv, char **envp)
-{
-	printf("git version %s\n", GIT_VERSION);
-	return 0;
-}
-
-static int cmd_help(int argc, const char **argv, char **envp)
-{
-	const char *help_cmd = argv[1];
-	if (!help_cmd)
-		cmd_usage(0, git_exec_path(), NULL);
-	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a"))
-		cmd_usage(1, git_exec_path(), NULL);
-	else
-		show_man_page(help_cmd);
-	return 0;
-}
-
-static int cmd_log_wc(int argc, const char **argv, char **envp,
-		      struct rev_info *rev)
-{
-	struct commit *commit;
-
-	rev->abbrev = DEFAULT_ABBREV;
-	rev->commit_format = CMIT_FMT_DEFAULT;
-	rev->verbose_header = 1;
-	argc = setup_revisions(argc, argv, rev, "HEAD");
-
-	if (argc > 1)
-		die("unrecognized argument: %s", argv[1]);
-
-	prepare_revision_walk(rev);
-	setup_pager();
-	while ((commit = get_revision(rev)) != NULL) {
-		log_tree_commit(rev, commit);
-		free(commit->buffer);
-		commit->buffer = NULL;
-	}
-	return 0;
-}
-
-static int cmd_wc(int argc, const char **argv, char **envp)
-{
-	struct rev_info rev;
-
-	init_revisions(&rev);
-	rev.diff = 1;
-	rev.diffopt.recursive = 1;
-	return cmd_log_wc(argc, argv, envp, &rev);
-}
-
-static int cmd_show(int argc, const char **argv, char **envp)
-{
-	struct rev_info rev;
-
-	init_revisions(&rev);
-	rev.diff = 1;
-	rev.diffopt.recursive = 1;
-	rev.combine_merges = 1;
-	rev.dense_combined_merges = 1;
-	rev.always_show_header = 1;
-	rev.ignore_merges = 0;
-	rev.no_walk = 1;
-	return cmd_log_wc(argc, argv, envp, &rev);
-}
-
-static int cmd_log(int argc, const char **argv, char **envp)
-{
-	struct rev_info rev;
-
-	init_revisions(&rev);
-	rev.always_show_header = 1;
-	rev.diffopt.recursive = 1;
-	return cmd_log_wc(argc, argv, envp, &rev);
-}
+const char git_version_string[] = GIT_VERSION;
 
 static void handle_internal_command(int argc, const char **argv, char **envp)
 {
@@ -344,7 +45,7 @@ static void handle_internal_command(int 
 		{ "version", cmd_version },
 		{ "help", cmd_help },
 		{ "log", cmd_log },
-		{ "whatchanged", cmd_wc },
+		{ "whatchanged", cmd_whatchanged },
 		{ "show", cmd_show },
 	};
 	int i;
