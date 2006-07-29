From: Junio C Hamano <junkio@cox.net>
Subject: An alternative: call setup_git_directory() early
Date: Fri, 28 Jul 2006 21:41:56 -0700
Message-ID: <7vslklja3v.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607281811580.4168@g5.osdl.org>
	<7v3bclkwfj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607282118230.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 06:42:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6geQ-0000dE-TO
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 06:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161469AbWG2El6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 00:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161467AbWG2El6
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 00:41:58 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42114 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161457AbWG2El5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 00:41:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060729044156.YEQB6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Jul 2006 00:41:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607282118230.4168@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 28 Jul 2006 21:21:48 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24416>

We classify built-in commands into three classes: ones that
require to know where the .git directory is, ones that could use
the knowledge of where the .git directory is but can operate
without, and ones that should not attempt any .git discovery.

Most of the commands fall within the first category.
apply, mailsplit and mailinfo falls within the second category
(e.g. patches can be applied to non-git files without --index),
and the last category includes init-db (which should never do
a discovery).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

> On Fri, 28 Jul 2006, Junio C Hamano wrote:
>> 
>> No clever ideas, but I agree it would be _very_ nice if we could
>> do the setup unconditionally and early.  Some commands that call
>> setup want to know prefix, so we would need to introduce a
>> global to hold the prefix for them.
>
> Ho humm. In the meantime, how about this? It fixes the places I noticed, 
> but is mostly just a totally mindless conversion to move the call to 
> "setup_git_directory()" into the caller.

I guess our mails crossed.  This seems to pass all the tests but
our test do not cover subdirectory operation that much.


diff --git a/builtin-add.c b/builtin-add.c
index 3a73a17..07a29bc 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -127,7 +127,7 @@ int cmd_add(int argc, const char **argv,
 {
 	int i, newfd;
 	int verbose = 0, show_only = 0;
-	const char *prefix = setup_git_directory();
+	const char *prefix = git_prefix;
 	const char **pathspec;
 	struct dir_struct dir;
 
diff --git a/builtin-apply.c b/builtin-apply.c
index d4381d9..fb06cc3 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2370,7 +2370,7 @@ int cmd_apply(int argc, const char **arg
 		}
 
 		if (check_index && prefix_length < 0) {
-			prefix = setup_git_directory();
+			prefix = git_prefix;
 			prefix_length = prefix ? strlen(prefix) : 0;
 			git_config(git_apply_config);
 			if (!whitespace_option && apply_default_whitespace)
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 4d36817..53b15ef 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -102,7 +102,6 @@ int cmd_cat_file(int argc, const char **
 	unsigned long size;
 	int opt;
 
-	setup_git_directory();
 	git_config(git_default_config);
 	if (argc != 3)
 		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index ec082bf..cae544b 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -88,8 +88,6 @@ int cmd_commit_tree(int argc, const char
 	unsigned int size;
 
 	setup_ident();
-	setup_git_directory();
-
 	git_config(git_default_config);
 
 	if (argc < 2)
diff --git a/builtin-diff-stages.c b/builtin-diff-stages.c
index 9c62702..9630a37 100644
--- a/builtin-diff-stages.c
+++ b/builtin-diff-stages.c
@@ -58,7 +58,7 @@ static void diff_stages(int stage1, int 
 int cmd_diff_stages(int ac, const char **av, char **envp)
 {
 	int stage1, stage2;
-	const char *prefix = setup_git_directory();
+	const char *prefix = git_prefix;
 	const char **pathspec = NULL;
 
 	git_config(git_default_config); /* no "diff" UI options */
diff --git a/builtin-grep.c b/builtin-grep.c
index a79bac3..713cca1 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -926,7 +926,7 @@ int cmd_grep(int argc, const char **argv
 	int seen_dashdash = 0;
 	struct grep_opt opt;
 	struct object_array list = { 0, 0, NULL };
-	const char *prefix = setup_git_directory();
+	const char *prefix = git_prefix;
 	const char **paths = NULL;
 	int i;
 
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 8dae9f7..49e848e 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -329,7 +329,7 @@ int cmd_ls_files(int argc, const char **
 	struct dir_struct dir;
 
 	memset(&dir, 0, sizeof(dir));
-	prefix = setup_git_directory();
+	prefix = git_prefix;
 	if (prefix)
 		prefix_offset = strlen(prefix);
 	git_config(git_default_config);
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index b8d0d88..5cd4964 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -90,7 +90,7 @@ int cmd_ls_tree(int argc, const char **a
 	unsigned char sha1[20];
 	struct tree *tree;
 
-	prefix = setup_git_directory();
+	prefix = git_prefix;
 	git_config(git_default_config);
 	if (prefix && *prefix)
 		chomp_prefix = strlen(prefix);
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 122b6f1..375347d 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -882,7 +882,6 @@ int cmd_read_tree(int argc, const char *
 	state.quiet = 1;
 	state.refresh_cache = 1;
 
-	setup_git_directory();
 	git_config(git_default_config);
 
 	newfd = hold_lock_file_for_update(&lock_file, get_index_file());
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index b3e4386..cca9b05 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -213,7 +213,7 @@ int cmd_rev_parse(int argc, const char *
 {
 	int i, as_is = 0, verify = 0;
 	unsigned char sha1[20];
-	const char *prefix = setup_git_directory();
+	const char *prefix = git_prefix;
 
 	git_config(git_default_config);
 
diff --git a/builtin-rm.c b/builtin-rm.c
index bb810ba..25d0da3 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -47,7 +47,7 @@ int cmd_rm(int argc, const char **argv, 
 {
 	int i, newfd;
 	int verbose = 0, show_only = 0, force = 0;
-	const char *prefix = setup_git_directory();
+	const char *prefix = git_prefix;
 	const char **pathspec;
 	char *seen;
 
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 82f75b7..43ab1f8 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -573,7 +573,6 @@ int cmd_show_branch(int ac, const char *
 	int topics = 0;
 	int dense = 1;
 
-	setup_git_directory();
 	git_config(git_show_branch_config);
 
 	/* If nothing is specified, try the default first */
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index e5aaded..3e6b736 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -319,7 +319,6 @@ static int generate_tar(int argc, const 
 	current_path.alloc = PATH_MAX;
 	current_path.len = current_path.eof = 0;
 
-	setup_git_directory();
 	git_config(git_tar_config);
 
 	switch (argc) {
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 1a4200d..c64506b 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -481,7 +481,7 @@ int cmd_update_index(int argc, const cha
 	int i, newfd, entries, has_errors = 0, line_termination = '\n';
 	int allow_options = 1;
 	int read_from_stdin = 0;
-	const char *prefix = setup_git_directory();
+	const char *prefix = git_prefix;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	char set_executable_bit = 0;
 	unsigned int refresh_flags = 0;
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 83094ab..8138eba 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -13,7 +13,6 @@ int cmd_update_ref(int argc, const char 
 	int i;
 
 	setup_ident();
-	setup_git_directory();
 	git_config(git_default_config);
 
 	for (i = 1; i < argc; i++) {
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 449a4d1..d987d0b 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -66,8 +66,6 @@ int cmd_write_tree(int argc, const char 
 	const char *prefix = NULL;
 	unsigned char sha1[20];
 
-	setup_git_directory();
-
 	while (1 < argc) {
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--missing-ok"))
diff --git a/cache.h b/cache.h
index eee5fc9..6c008f9 100644
--- a/cache.h
+++ b/cache.h
@@ -130,6 +130,8 @@ extern char *get_graft_file(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
+extern int gitdir_not_found;
+extern const char *git_prefix;
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/environment.c b/environment.c
index 42f39d6..2fb978d 100644
--- a/environment.c
+++ b/environment.c
@@ -23,6 +23,8 @@ int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace = NULL;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 int pager_in_use;
+int gitdir_not_found;
+const char *git_prefix;
 
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
 	*git_graft_file;
diff --git a/git.c b/git.c
index 885e1ce..a9d6340 100644
--- a/git.c
+++ b/git.c
@@ -220,45 +220,50 @@ static void handle_internal_command(int 
 	static struct cmd_struct {
 		const char *cmd;
 		int (*fn)(int, const char **, char **);
+		enum use_gitdir {
+			GITDIR_OPTIONAL,
+			GITDIR_REQUIRED,
+			GITDIR_DONTCARE,
+		} use_gitdir;
 	} commands[] = {
-		{ "version", cmd_version },
-		{ "help", cmd_help },
-		{ "log", cmd_log },
-		{ "whatchanged", cmd_whatchanged },
-		{ "show", cmd_show },
-		{ "push", cmd_push },
-		{ "format-patch", cmd_format_patch },
-		{ "count-objects", cmd_count_objects },
-		{ "diff", cmd_diff },
-		{ "grep", cmd_grep },
-		{ "rm", cmd_rm },
-		{ "add", cmd_add },
-		{ "rev-list", cmd_rev_list },
-		{ "init-db", cmd_init_db },
-		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "upload-tar", cmd_upload_tar },
-		{ "check-ref-format", cmd_check_ref_format },
-		{ "ls-files", cmd_ls_files },
-		{ "ls-tree", cmd_ls_tree },
-		{ "tar-tree", cmd_tar_tree },
-		{ "read-tree", cmd_read_tree },
-		{ "commit-tree", cmd_commit_tree },
-		{ "apply", cmd_apply },
-		{ "show-branch", cmd_show_branch },
-		{ "diff-files", cmd_diff_files },
-		{ "diff-index", cmd_diff_index },
-		{ "diff-stages", cmd_diff_stages },
-		{ "diff-tree", cmd_diff_tree },
-		{ "cat-file", cmd_cat_file },
-		{ "rev-parse", cmd_rev_parse },
-		{ "write-tree", cmd_write_tree },
-		{ "mailsplit", cmd_mailsplit },
-		{ "mailinfo", cmd_mailinfo },
-		{ "stripspace", cmd_stripspace },
-		{ "update-index", cmd_update_index },
-		{ "update-ref", cmd_update_ref },
-		{ "fmt-merge-msg", cmd_fmt_merge_msg },
-		{ "prune", cmd_prune },
+		{ "version", cmd_version, GITDIR_DONTCARE },
+		{ "help", cmd_help, GITDIR_DONTCARE },
+		{ "log", cmd_log, GITDIR_REQUIRED },
+		{ "whatchanged", cmd_whatchanged, GITDIR_REQUIRED },
+		{ "show", cmd_show, GITDIR_REQUIRED },
+		{ "push", cmd_push, GITDIR_REQUIRED },
+		{ "format-patch", cmd_format_patch, GITDIR_REQUIRED },
+		{ "count-objects", cmd_count_objects, GITDIR_REQUIRED },
+		{ "diff", cmd_diff, GITDIR_REQUIRED },
+		{ "grep", cmd_grep, GITDIR_REQUIRED },
+		{ "rm", cmd_rm, GITDIR_REQUIRED },
+		{ "add", cmd_add, GITDIR_REQUIRED },
+		{ "rev-list", cmd_rev_list, GITDIR_REQUIRED },
+		{ "init-db", cmd_init_db, GITDIR_DONTCARE },
+		{ "get-tar-commit-id", cmd_get_tar_commit_id, GITDIR_REQUIRED },
+		{ "upload-tar", cmd_upload_tar, GITDIR_REQUIRED },
+		{ "check-ref-format", cmd_check_ref_format, GITDIR_DONTCARE },
+		{ "ls-files", cmd_ls_files, GITDIR_REQUIRED },
+		{ "ls-tree", cmd_ls_tree, GITDIR_REQUIRED },
+		{ "tar-tree", cmd_tar_tree, GITDIR_REQUIRED },
+		{ "read-tree", cmd_read_tree, GITDIR_REQUIRED },
+		{ "commit-tree", cmd_commit_tree, GITDIR_REQUIRED },
+		{ "apply", cmd_apply, GITDIR_OPTIONAL },
+		{ "show-branch", cmd_show_branch, GITDIR_REQUIRED },
+		{ "diff-files", cmd_diff_files, GITDIR_REQUIRED },
+		{ "diff-index", cmd_diff_index, GITDIR_REQUIRED },
+		{ "diff-stages", cmd_diff_stages, GITDIR_REQUIRED },
+		{ "diff-tree", cmd_diff_tree, GITDIR_REQUIRED },
+		{ "cat-file", cmd_cat_file, GITDIR_REQUIRED },
+		{ "rev-parse", cmd_rev_parse, GITDIR_REQUIRED },
+		{ "write-tree", cmd_write_tree, GITDIR_REQUIRED },
+		{ "mailsplit", cmd_mailsplit, GITDIR_OPTIONAL },
+		{ "mailinfo", cmd_mailinfo, GITDIR_OPTIONAL },
+		{ "stripspace", cmd_stripspace, GITDIR_OPTIONAL },
+		{ "update-index", cmd_update_index, GITDIR_REQUIRED },
+		{ "update-ref", cmd_update_ref, GITDIR_REQUIRED },
+		{ "fmt-merge-msg", cmd_fmt_merge_msg, GITDIR_DONTCARE },
+		{ "prune", cmd_prune, GITDIR_REQUIRED },
 	};
 	int i;
 
@@ -284,6 +289,18 @@ static void handle_internal_command(int 
 			fflush(stderr);
 		}
 
+		gitdir_not_found = 0;
+		switch (p->use_gitdir) {
+		case GITDIR_REQUIRED:
+			git_prefix = setup_git_directory();
+			break;
+		case GITDIR_OPTIONAL:
+			git_prefix =
+				setup_git_directory_gently(&gitdir_not_found);
+			break;
+		case GITDIR_DONTCARE:
+			break;
+		}
 		exit(p->fn(argc, argv, envp));
 	}
 }
diff --git a/t/trash/path0 b/t/trash/path0
deleted file mode 100644
index f87290f..0000000
--- a/t/trash/path0
+++ /dev/null
@@ -1 +0,0 @@
-hello path0
diff --git a/t/trash/path0sym b/t/trash/path0sym
deleted file mode 120000
index 15a9843..0000000
--- a/t/trash/path0sym
+++ /dev/null
@@ -1 +0,0 @@
-hello path0
\ No newline at end of file
diff --git a/t/trash/path2/file2 b/t/trash/path2/file2
deleted file mode 100644
index 3feff94..0000000
--- a/t/trash/path2/file2
+++ /dev/null
@@ -1 +0,0 @@
-hello path2/file2
diff --git a/t/trash/path2/file2sym b/t/trash/path2/file2sym
deleted file mode 120000
index d8ce161..0000000
--- a/t/trash/path2/file2sym
+++ /dev/null
@@ -1 +0,0 @@
-hello path2/file2
\ No newline at end of file
diff --git a/t/trash/path3/file3 b/t/trash/path3/file3
deleted file mode 100644
index 0aa34ca..0000000
--- a/t/trash/path3/file3
+++ /dev/null
@@ -1 +0,0 @@
-hello path3/file3
diff --git a/t/trash/path3/file3sym b/t/trash/path3/file3sym
deleted file mode 120000
index 8599103..0000000
--- a/t/trash/path3/file3sym
+++ /dev/null
@@ -1 +0,0 @@
-hello path3/file3
\ No newline at end of file
diff --git a/t/trash/path3/subp3/file3 b/t/trash/path3/subp3/file3
deleted file mode 100644
index 00fb590..0000000
--- a/t/trash/path3/subp3/file3
+++ /dev/null
@@ -1 +0,0 @@
-hello path3/subp3/file3
diff --git a/t/trash/path3/subp3/file3sym b/t/trash/path3/subp3/file3sym
deleted file mode 120000
index 6649a1e..0000000
--- a/t/trash/path3/subp3/file3sym
+++ /dev/null
@@ -1 +0,0 @@
-hello path3/subp3/file3
\ No newline at end of file
