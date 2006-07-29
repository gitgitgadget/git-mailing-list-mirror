From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Call setup_git_directory() early
Date: Fri, 28 Jul 2006 22:44:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607282223320.4168@g5.osdl.org>
References: <Pine.LNX.4.64.0607281811580.4168@g5.osdl.org>
 <7v3bclkwfj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607282118230.4168@g5.osdl.org>
 <7vodv9j8yg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 29 07:44:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6hcs-0001Y3-6y
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 07:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWG2Foe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 01:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbWG2Foe
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 01:44:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57056 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422639AbWG2Fod (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 01:44:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6T5iRnW027155
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Jul 2006 22:44:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6T5iPsK031028;
	Fri, 28 Jul 2006 22:44:26 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodv9j8yg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.542 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24418>



On Fri, 28 Jul 2006, Junio C Hamano wrote:
> 
> Your patch makes a lot of sense.

I don't think they are mutually incompatible.

My patch moves the call to "setup_git_directory()" a _bit_ earlier, and if 
we just keep doing it, we'll end up with at least a subset of your patch. 

Anyway, this was what I came up with when I did that "incremental" thing. 
It's a bit like your patch, but a lot more invasive because it changes the 
calling convention for the builtin commands (but it's cleaner because of 
it, I think).

This is on top of my previous patch. What do you think? It does delete 
more lines than it adds..

		Linus

---
 35 files changed, 109 insertions(+), 114 deletions(-)


diff --git a/builtin-add.c b/builtin-add.c
index 3a73a17..0fa7dc1 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -123,11 +123,10 @@ static int add_file_to_index(const char 
 
 static struct lock_file lock_file;
 
-int cmd_add(int argc, const char **argv, char **envp)
+int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
 	int verbose = 0, show_only = 0;
-	const char *prefix = setup_git_directory();
 	const char **pathspec;
 	struct dir_struct dir;
 
diff --git a/builtin-apply.c b/builtin-apply.c
index d924ac3..c1ba99e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2222,7 +2222,7 @@ static int git_apply_config(const char *
 }
 
 
-int cmd_apply(int argc, const char **argv, char **envp)
+int cmd_apply(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int read_stdin = 1;
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 4d36817..d796431 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -94,7 +94,7 @@ static int pprint_tag(const unsigned cha
 	return 0;
 }
 
-int cmd_cat_file(int argc, const char **argv, char **envp)
+int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
 	unsigned char sha1[20];
 	char type[20];
diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index 4a23936..701de43 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -6,7 +6,7 @@ #include "cache.h"
 #include "refs.h"
 #include "builtin.h"
 
-int cmd_check_ref_format(int argc, const char **argv, char **envp)
+int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	if (argc != 2)
 		usage("git check-ref-format refname");
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index ec082bf..e6fb16d 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -77,7 +77,7 @@ static int new_parent(int idx)
 	return 1;
 }
 
-int cmd_commit_tree(int argc, const char **argv, char **envp)
+int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int parents = 0;
diff --git a/builtin-count.c b/builtin-count.c
index 5ee72df..1d3729a 100644
--- a/builtin-count.c
+++ b/builtin-count.c
@@ -67,7 +67,7 @@ static void count_objects(DIR *d, char *
 	}
 }
 
-int cmd_count_objects(int ac, const char **av, char **ep)
+int cmd_count_objects(int ac, const char **av, const char *prefix)
 {
 	int i;
 	int verbose = 0;
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index ea2936a..da51284 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -13,7 +13,7 @@ static const char diff_files_usage[] =
 "git-diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
-int cmd_diff_files(int argc, const char **argv, char **envp)
+int cmd_diff_files(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 	int silent = 0;
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index eeeee93..bedb90c 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -9,7 +9,7 @@ static const char diff_cache_usage[] =
 "[<common diff options>] <tree-ish> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
-int cmd_diff_index(int argc, const char **argv, char **envp)
+int cmd_diff_index(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 	int cached = 0;
diff --git a/builtin-diff-stages.c b/builtin-diff-stages.c
index 9c62702..5960e08 100644
--- a/builtin-diff-stages.c
+++ b/builtin-diff-stages.c
@@ -55,10 +55,9 @@ static void diff_stages(int stage1, int 
 	}
 }
 
-int cmd_diff_stages(int ac, const char **av, char **envp)
+int cmd_diff_stages(int ac, const char **av, const char *prefix)
 {
 	int stage1, stage2;
-	const char *prefix = setup_git_directory();
 	const char **pathspec = NULL;
 
 	git_config(git_default_config); /* no "diff" UI options */
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index f8215ea..816946b 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -59,7 +59,7 @@ static const char diff_tree_usage[] =
 "  --root        include the initial commit as diff against /dev/null\n"
 COMMON_DIFF_OPTIONS_HELP;
 
-int cmd_diff_tree(int argc, const char **argv, char **envp)
+int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 {
 	int nr_sha1;
 	char line[1000];
diff --git a/builtin-diff.c b/builtin-diff.c
index 7965c2c..4a592e6 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -221,13 +221,13 @@ void add_head(struct rev_info *revs)
 	add_pending_object(revs, obj, "HEAD");
 }
 
-int cmd_diff(int argc, const char **argv, char **envp)
+int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct rev_info rev;
 	struct object_array_entry ent[100];
 	int ents = 0, blobs = 0, paths = 0;
-	const char *path = NULL, *prefix;
+	const char *path = NULL;
 	struct blobinfo blob[2];
 
 	/*
@@ -250,7 +250,6 @@ int cmd_diff(int argc, const char **argv
 	 * Other cases are errors.
 	 */
 
-	prefix = setup_git_directory();
 	git_config(git_diff_ui_config);
 	init_revisions(&rev, prefix);
 
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 338f209..c84224e 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -242,7 +242,7 @@ static void shortlog(const char *name, u
 	free_list(&subjects);
 }
 
-int cmd_fmt_merge_msg(int argc, char **argv, char **envp)
+int cmd_fmt_merge_msg(int argc, char **argv, const char *prefix)
 {
 	int limit = 20, i = 0;
 	char line[1024];
@@ -250,7 +250,6 @@ int cmd_fmt_merge_msg(int argc, char **a
 	const char *sep = "";
 	unsigned char head_sha1[20];
 	const char *head, *current_branch;
-	const char *prefix = setup_git_directory();
 
 	git_config(fmt_merge_msg_config);
 
diff --git a/builtin-grep.c b/builtin-grep.c
index a79bac3..69b7c48 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -919,14 +919,13 @@ static const char emsg_missing_context_l
 static const char emsg_missing_argument[] =
 "option requires an argument -%s";
 
-int cmd_grep(int argc, const char **argv, char **envp)
+int cmd_grep(int argc, const char **argv, const char *prefix)
 {
 	int hit = 0;
 	int cached = 0;
 	int seen_dashdash = 0;
 	struct grep_opt opt;
 	struct object_array list = { 0, 0, NULL };
-	const char *prefix = setup_git_directory();
 	const char **paths = NULL;
 	int i;
 
diff --git a/builtin-help.c b/builtin-help.c
index 335fe5f..7f7701e 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -221,13 +221,13 @@ static void show_man_page(const char *gi
 	execlp("man", "man", page, NULL);
 }
 
-int cmd_version(int argc, const char **argv, char **envp)
+int cmd_version(int argc, const char **argv, const char *prefix)
 {
 	printf("git version %s\n", git_version_string);
 	return 0;
 }
 
-int cmd_help(int argc, const char **argv, char **envp)
+int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	const char *help_cmd = argv[1];
 	if (!help_cmd)
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 7fdd2fa..52473ed 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -250,7 +250,7 @@ static const char init_db_usage[] =
  * On the other hand, it might just make lookup slower and messier. You
  * be the judge.  The default case is to have one DB per managed directory.
  */
-int cmd_init_db(int argc, const char **argv, char **envp)
+int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
 	const char *sha1_dir;
diff --git a/builtin-log.c b/builtin-log.c
index 52064cd..82c69d1 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -16,7 +16,7 @@ #include <sys/time.h>
 /* this is in builtin-diff.c */
 void add_head(struct rev_info *revs);
 
-static void cmd_log_init(int argc, const char **argv, char **envp,
+static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
 	rev->abbrev = DEFAULT_ABBREV;
@@ -45,26 +45,24 @@ static int cmd_log_walk(struct rev_info 
 	return 0;
 }
 
-int cmd_whatchanged(int argc, const char **argv, char **envp)
+int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	const char *prefix = setup_git_directory();
 
 	git_config(git_diff_ui_config);
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
 	rev.simplify_history = 0;
-	cmd_log_init(argc, argv, envp, &rev);
+	cmd_log_init(argc, argv, prefix, &rev);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 	return cmd_log_walk(&rev);
 }
 
-int cmd_show(int argc, const char **argv, char **envp)
+int cmd_show(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	const char *prefix = setup_git_directory();
 
 	git_config(git_diff_ui_config);
 	init_revisions(&rev, prefix);
@@ -75,19 +73,18 @@ int cmd_show(int argc, const char **argv
 	rev.always_show_header = 1;
 	rev.ignore_merges = 0;
 	rev.no_walk = 1;
-	cmd_log_init(argc, argv, envp, &rev);
+	cmd_log_init(argc, argv, prefix, &rev);
 	return cmd_log_walk(&rev);
 }
 
-int cmd_log(int argc, const char **argv, char **envp)
+int cmd_log(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	const char *prefix = setup_git_directory();
 
 	git_config(git_diff_ui_config);
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
-	cmd_log_init(argc, argv, envp, &rev);
+	cmd_log_init(argc, argv, prefix, &rev);
 	return cmd_log_walk(&rev);
 }
 
@@ -181,14 +178,13 @@ static int get_patch_id(struct commit *c
 	return diff_flush_patch_id(options, sha1);
 }
 
-static void get_patch_ids(struct rev_info *rev, struct diff_options *options)
+static void get_patch_ids(struct rev_info *rev, struct diff_options *options, const char *prefix)
 {
 	struct rev_info check_rev;
 	struct commit *commit;
 	struct object *o1, *o2;
 	unsigned flags1, flags2;
 	unsigned char sha1[20];
-	const char *prefix = setup_git_directory();
 
 	if (rev->pending.nr != 2)
 		die("Need exactly one range.");
@@ -244,7 +240,7 @@ static void gen_message_id(char *dest, u
 		 (int)(email_end - email_start - 1), email_start + 1);
 }
 
-int cmd_format_patch(int argc, const char **argv, char **envp)
+int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
 	struct commit **list = NULL;
@@ -261,7 +257,6 @@ int cmd_format_patch(int argc, const cha
 	char *add_signoff = NULL;
 	char message_id[1024];
 	char ref_message_id[1024];
-	const char *prefix = setup_git_directory();
 
 	git_config(git_format_config);
 	init_revisions(&rev, prefix);
@@ -368,7 +363,7 @@ int cmd_format_patch(int argc, const cha
 	}
 
 	if (ignore_if_in_upstream)
-		get_patch_ids(&rev, &patch_id_opts);
+		get_patch_ids(&rev, &patch_id_opts, prefix);
 
 	if (!use_stdout)
 		realstdout = fdopen(dup(1), "w");
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 8dae9f7..e906c81 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -322,7 +322,7 @@ static const char ls_files_usage[] =
 	"[ --exclude-per-directory=<filename> ] [--full-name] [--abbrev] "
 	"[--] [<file>]*";
 
-int cmd_ls_files(int argc, const char **argv, char** envp)
+int cmd_ls_files(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int exc_given = 0;
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index b8d0d88..d31efe9 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -18,7 +18,7 @@ static int abbrev = 0;
 static int ls_options = 0;
 static const char **pathspec;
 static int chomp_prefix = 0;
-static const char *prefix;
+static const char *ls_tree_prefix;
 
 static const char ls_tree_usage[] =
 	"git-ls-tree [-d] [-r] [-t] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
@@ -71,7 +71,7 @@ static int show_tree(const unsigned char
 		return 0;
 
 	if (chomp_prefix &&
-	    (baselen < chomp_prefix || memcmp(prefix, base, chomp_prefix)))
+	    (baselen < chomp_prefix || memcmp(ls_tree_prefix, base, chomp_prefix)))
 		return 0;
 
 	if (!(ls_options & LS_NAME_ONLY))
@@ -85,13 +85,14 @@ static int show_tree(const unsigned char
 	return retval;
 }
 
-int cmd_ls_tree(int argc, const char **argv, char **envp)
+int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
 	unsigned char sha1[20];
 	struct tree *tree;
 
 	prefix = setup_git_directory();
 	git_config(git_default_config);
+	ls_tree_prefix = prefix;
 	if (prefix && *prefix)
 		chomp_prefix = strlen(prefix);
 	while (1 < argc && argv[1][0] == '-') {
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 05dc1bf..24a4fc6 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -836,7 +836,7 @@ int mailinfo(FILE *in, FILE *out, int ks
 static const char mailinfo_usage[] =
 	"git-mailinfo [-k] [-u | --encoding=<encoding>] msg patch <mail >info";
 
-int cmd_mailinfo(int argc, const char **argv, char **envp)
+int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	/* NEEDSWORK: might want to do the optional .git/ directory
 	 * discovery
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index e2a0058..91a699d 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -138,7 +138,7 @@ out:
 	free(name);
 	return ret;
 }
-int cmd_mailsplit(int argc, const char **argv, char **envp)
+int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 {
 	int nr = 0, nr_prec = 4, ret;
 	int allow_bare = 0;
diff --git a/builtin-prune.c b/builtin-prune.c
index 4ed1e1b..15bb650 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -217,7 +217,7 @@ static void add_cache_refs(void)
 		add_cache_tree(active_cache_tree);
 }
 
-int cmd_prune(int argc, const char **argv, char **envp)
+int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	int i;
 
diff --git a/builtin-push.c b/builtin-push.c
index 31cbfd7..a824171 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -270,7 +270,7 @@ static int do_push(const char *repo)
 	return 0;
 }
 
-int cmd_push(int argc, const char **argv, char **envp)
+int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	const char *repo = "origin";	/* default repository */
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 122b6f1..25ca69c 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -870,7 +870,7 @@ static const char read_tree_usage[] = "g
 
 static struct lock_file lock_file;
 
-int cmd_read_tree(int argc, const char **argv, char **envp)
+int cmd_read_tree(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd, stage = 0;
 	unsigned char sha1[20];
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 2b6691c..65b4d0c 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -306,7 +306,7 @@ static void mark_edges_uninteresting(str
 	}
 }
 
-int cmd_rev_list(int argc, const char **argv, char **envp)
+int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
 	int i;
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index b3e4386..aca4a36 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -209,11 +209,10 @@ static int try_difference(const char *ar
 	return 0;
 }
 
-int cmd_rev_parse(int argc, const char **argv, char **envp)
+int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0;
 	unsigned char sha1[20];
-	const char *prefix = setup_git_directory();
 
 	git_config(git_default_config);
 
diff --git a/builtin-rm.c b/builtin-rm.c
index bb810ba..92d205a 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -43,11 +43,10 @@ static int remove_file(const char *name)
 
 static struct lock_file lock_file;
 
-int cmd_rm(int argc, const char **argv, char **envp)
+int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
 	int verbose = 0, show_only = 0, force = 0;
-	const char *prefix = setup_git_directory();
 	const char **pathspec;
 	char *seen;
 
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 82f75b7..9c7f9f6 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -550,7 +550,7 @@ static int omit_in_dense(struct commit *
 	return 0;
 }
 
-int cmd_show_branch(int ac, const char **av, char **envp)
+int cmd_show_branch(int ac, const char **av, const char *prefix)
 {
 	struct commit *rev[MAX_REVS], *commit;
 	struct commit_list *list = NULL, *seen = NULL;
diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index 2ce1264..09cc910 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -54,7 +54,7 @@ void stripspace(FILE *in, FILE *out)
 		fputc('\n', out);
 }
 
-int cmd_stripspace(int argc, const char **argv, char **envp)
+int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
 	stripspace(stdin, stdout);
 	return 0;
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index e5aaded..637d22e 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -308,7 +308,7 @@ int git_tar_config(const char *var, cons
 	return git_default_config(var, value);
 }
 
-static int generate_tar(int argc, const char **argv, char** envp)
+static int generate_tar(int argc, const char **argv, const char *prefix)
 {
 	unsigned char sha1[20], tree_sha1[20];
 	struct commit *commit;
@@ -402,19 +402,19 @@ static int remote_tar(int argc, const ch
 	return !!ret;
 }
 
-int cmd_tar_tree(int argc, const char **argv, char **envp)
+int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 {
 	if (argc < 2)
 		usage(tar_tree_usage);
 	if (!strncmp("--remote=", argv[1], 9))
 		return remote_tar(argc, argv);
-	return generate_tar(argc, argv, envp);
+	return generate_tar(argc, argv, prefix);
 }
 
 /* ustar header + extended global header content */
 #define HEADERSIZE (2 * RECORDSIZE)
 
-int cmd_get_tar_commit_id(int argc, const char **argv, char **envp)
+int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 {
 	char buffer[HEADERSIZE];
 	struct ustar_header *header = (struct ustar_header *)buffer;
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 1a4200d..24dca47 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -476,12 +476,11 @@ static int do_reupdate(int ac, const cha
 	return 0;
 }
 
-int cmd_update_index(int argc, const char **argv, char **envp)
+int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd, entries, has_errors = 0, line_termination = '\n';
 	int allow_options = 1;
 	int read_from_stdin = 0;
-	const char *prefix = setup_git_directory();
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	char set_executable_bit = 0;
 	unsigned int refresh_flags = 0;
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 83094ab..acdf39a 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -5,7 +5,7 @@ #include "builtin.h"
 static const char git_update_ref_usage[] =
 "git-update-ref <refname> <value> [<oldval>] [-m <reason>]";
 
-int cmd_update_ref(int argc, const char **argv, char **envp)
+int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
 	const char *refname=NULL, *value=NULL, *oldval=NULL, *msg=NULL;
 	struct ref_lock *lock;
diff --git a/builtin-upload-tar.c b/builtin-upload-tar.c
index d4fa7b5..7b401bb 100644
--- a/builtin-upload-tar.c
+++ b/builtin-upload-tar.c
@@ -15,7 +15,7 @@ static int nak(const char *reason)
 	return 1;
 }
 
-int cmd_upload_tar(int argc, const char **argv, char **envp)
+int cmd_upload_tar(int argc, const char **argv, const char *prefix)
 {
 	int len;
 	const char *dir = argv[1];
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 449a4d1..0f2dd7c 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -60,7 +60,7 @@ int write_tree(unsigned char *sha1, int 
 	return 0;
 }
 
-int cmd_write_tree(int argc, const char **argv, char **envp)
+int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 {
 	int missing_ok = 0, ret;
 	const char *prefix = NULL;
diff --git a/builtin.h b/builtin.h
index 5339d86..de244cd 100644
--- a/builtin.h
+++ b/builtin.h
@@ -15,53 +15,53 @@ #ifdef __GNUC__
 #endif
 	;
 
-extern int cmd_help(int argc, const char **argv, char **envp);
-extern int cmd_version(int argc, const char **argv, char **envp);
+extern int cmd_help(int argc, const char **argv, const char *prefix);
+extern int cmd_version(int argc, const char **argv, const char *prefix);
 
-extern int cmd_whatchanged(int argc, const char **argv, char **envp);
-extern int cmd_show(int argc, const char **argv, char **envp);
-extern int cmd_log(int argc, const char **argv, char **envp);
-extern int cmd_diff(int argc, const char **argv, char **envp);
-extern int cmd_format_patch(int argc, const char **argv, char **envp);
-extern int cmd_count_objects(int argc, const char **argv, char **envp);
+extern int cmd_whatchanged(int argc, const char **argv, const char *prefix);
+extern int cmd_show(int argc, const char **argv, const char *prefix);
+extern int cmd_log(int argc, const char **argv, const char *prefix);
+extern int cmd_diff(int argc, const char **argv, const char *prefix);
+extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
+extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
 
-extern int cmd_prune(int argc, const char **argv, char **envp);
+extern int cmd_prune(int argc, const char **argv, const char *prefix);
 
-extern int cmd_push(int argc, const char **argv, char **envp);
-extern int cmd_grep(int argc, const char **argv, char **envp);
-extern int cmd_rm(int argc, const char **argv, char **envp);
-extern int cmd_add(int argc, const char **argv, char **envp);
-extern int cmd_rev_list(int argc, const char **argv, char **envp);
-extern int cmd_check_ref_format(int argc, const char **argv, char **envp);
-extern int cmd_init_db(int argc, const char **argv, char **envp);
-extern int cmd_tar_tree(int argc, const char **argv, char **envp);
-extern int cmd_upload_tar(int argc, const char **argv, char **envp);
-extern int cmd_get_tar_commit_id(int argc, const char **argv, char **envp);
-extern int cmd_ls_files(int argc, const char **argv, char **envp);
-extern int cmd_ls_tree(int argc, const char **argv, char **envp);
-extern int cmd_read_tree(int argc, const char **argv, char **envp);
-extern int cmd_commit_tree(int argc, const char **argv, char **envp);
-extern int cmd_apply(int argc, const char **argv, char **envp);
-extern int cmd_show_branch(int argc, const char **argv, char **envp);
-extern int cmd_diff_files(int argc, const char **argv, char **envp);
-extern int cmd_diff_index(int argc, const char **argv, char **envp);
-extern int cmd_diff_stages(int argc, const char **argv, char **envp);
-extern int cmd_diff_tree(int argc, const char **argv, char **envp);
-extern int cmd_cat_file(int argc, const char **argv, char **envp);
-extern int cmd_rev_parse(int argc, const char **argv, char **envp);
-extern int cmd_update_index(int argc, const char **argv, char **envp);
-extern int cmd_update_ref(int argc, const char **argv, char **envp);
-extern int cmd_fmt_merge_msg(int argc, const char **argv, char **envp);
+extern int cmd_push(int argc, const char **argv, const char *prefix);
+extern int cmd_grep(int argc, const char **argv, const char *prefix);
+extern int cmd_rm(int argc, const char **argv, const char *prefix);
+extern int cmd_add(int argc, const char **argv, const char *prefix);
+extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
+extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
+extern int cmd_init_db(int argc, const char **argv, const char *prefix);
+extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_upload_tar(int argc, const char **argv, const char *prefix);
+extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
+extern int cmd_ls_files(int argc, const char **argv, const char *prefix);
+extern int cmd_ls_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_apply(int argc, const char **argv, const char *prefix);
+extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
+extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
+extern int cmd_diff_stages(int argc, const char **argv, const char *prefix);
+extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
+extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
+extern int cmd_update_index(int argc, const char **argv, const char *prefix);
+extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
+extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
 
-extern int cmd_write_tree(int argc, const char **argv, char **envp);
+extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
 
-extern int cmd_mailsplit(int argc, const char **argv, char **envp);
+extern int cmd_mailsplit(int argc, const char **argv, const char *prefix);
 extern int split_mbox(const char **mbox, const char *dir, int allow_bare, int nr_prec, int skip);
 
-extern int cmd_mailinfo(int argc, const char **argv, char **envp);
+extern int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 extern int mailinfo(FILE *in, FILE *out, int ks, const char *encoding, const char *msg, const char *patch);
 
-extern int cmd_stripspace(int argc, const char **argv, char **envp);
+extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern void stripspace(FILE *in, FILE *out);
 #endif
diff --git a/git.c b/git.c
index ee5a0e8..e810d5c 100644
--- a/git.c
+++ b/git.c
@@ -157,25 +157,28 @@ static int handle_alias(int *argcp, cons
 
 const char git_version_string[] = GIT_VERSION;
 
+#define NEEDS_PREFIX 1
+
 static void handle_internal_command(int argc, const char **argv, char **envp)
 {
 	const char *cmd = argv[0];
 	static struct cmd_struct {
 		const char *cmd;
-		int (*fn)(int, const char **, char **);
+		int (*fn)(int, const char **, const char *);
+		int prefix;
 	} commands[] = {
 		{ "version", cmd_version },
 		{ "help", cmd_help },
-		{ "log", cmd_log },
-		{ "whatchanged", cmd_whatchanged },
-		{ "show", cmd_show },
+		{ "log", cmd_log, NEEDS_PREFIX },
+		{ "whatchanged", cmd_whatchanged, NEEDS_PREFIX },
+		{ "show", cmd_show, NEEDS_PREFIX },
 		{ "push", cmd_push },
-		{ "format-patch", cmd_format_patch },
+		{ "format-patch", cmd_format_patch, NEEDS_PREFIX },
 		{ "count-objects", cmd_count_objects },
-		{ "diff", cmd_diff },
-		{ "grep", cmd_grep },
-		{ "rm", cmd_rm },
-		{ "add", cmd_add },
+		{ "diff", cmd_diff, NEEDS_PREFIX },
+		{ "grep", cmd_grep, NEEDS_PREFIX },
+		{ "rm", cmd_rm, NEEDS_PREFIX },
+		{ "add", cmd_add, NEEDS_PREFIX },
 		{ "rev-list", cmd_rev_list },
 		{ "init-db", cmd_init_db },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
@@ -190,17 +193,17 @@ static void handle_internal_command(int 
 		{ "show-branch", cmd_show_branch },
 		{ "diff-files", cmd_diff_files },
 		{ "diff-index", cmd_diff_index },
-		{ "diff-stages", cmd_diff_stages },
+		{ "diff-stages", cmd_diff_stages, NEEDS_PREFIX },
 		{ "diff-tree", cmd_diff_tree },
 		{ "cat-file", cmd_cat_file },
-		{ "rev-parse", cmd_rev_parse },
+		{ "rev-parse", cmd_rev_parse, NEEDS_PREFIX },
 		{ "write-tree", cmd_write_tree },
 		{ "mailsplit", cmd_mailsplit },
 		{ "mailinfo", cmd_mailinfo },
 		{ "stripspace", cmd_stripspace },
-		{ "update-index", cmd_update_index },
+		{ "update-index", cmd_update_index, NEEDS_PREFIX },
 		{ "update-ref", cmd_update_ref },
-		{ "fmt-merge-msg", cmd_fmt_merge_msg },
+		{ "fmt-merge-msg", cmd_fmt_merge_msg, NEEDS_PREFIX },
 		{ "prune", cmd_prune },
 	};
 	int i;
@@ -213,9 +216,13 @@ static void handle_internal_command(int 
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands+i;
+		const char *prefix;
 		if (strcmp(p->cmd, cmd))
 			continue;
 
+		prefix = NULL;
+		if (p->prefix)
+			prefix = setup_git_directory();
 		if (getenv("GIT_TRACE")) {
 			int i;
 			fprintf(stderr, "trace: built-in: git");
@@ -227,7 +234,7 @@ static void handle_internal_command(int 
 			fflush(stderr);
 		}
 
-		exit(p->fn(argc, argv, envp));
+		exit(p->fn(argc, argv, prefix));
 	}
 }
 
