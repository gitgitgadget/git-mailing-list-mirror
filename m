From: Junio C Hamano <junkio@cox.net>
Subject: Re: Call setup_git_directory() early
Date: Sat, 29 Jul 2006 02:12:28 -0700
Message-ID: <7vzmesg4g3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607281811580.4168@g5.osdl.org>
	<7v3bclkwfj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607282118230.4168@g5.osdl.org>
	<7vodv9j8yg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607282223320.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 11:12:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6ks5-0003QA-Tk
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 11:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWG2JMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 05:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWG2JMa
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 05:12:30 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:25343 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750742AbWG2JMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 05:12:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060729091229.NBZF554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Jul 2006 05:12:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24420>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 28 Jul 2006, Junio C Hamano wrote:
>> 
>> Your patch makes a lot of sense.
>
> I don't think they are mutually incompatible.

I agree.  I was apologizing for the crap under t/trash in the
previous patch -- the rest were more or less in the same spirit
as yours.

> This is on top of my previous patch. What do you think? It does delete 
> more lines than it adds..

Let me understand what is going on here.

> +#define NEEDS_PREFIX 1
>...
>  		{ "init-db", cmd_init_db },

This is an oddball that wants to always use $GIT_DIR environment
or "./.git" if $GIT_DIR is not exported, and should never go
looking for GIT_DIR, so we should not give NEEDS_PREFIX, ever.

>  		{ "stripspace", cmd_stripspace },
>  		{ "mailsplit", cmd_mailsplit },
>  		{ "get-tar-commit-id", cmd_get_tar_commit_id },

These are the other extreme -- they really do not care about
operating in a git context.

  		{ "push", cmd_push },
  		{ "count-objects", cmd_count_objects },
		{ "check-ref-format", cmd_check_ref_format },

One rule seems to be that the commands that work at the while
repository level do not have NEEDS_PREFIX -- they will never
work from a subdirectory.

There is no technical reason not to let count-objects find
$GIT_DIR on its own, but the current implementation does not do
that and you are keeping the behaviour bug-to-bug compatible.

> +		{ "diff", cmd_diff, NEEDS_PREFIX },
> +		{ "grep", cmd_grep, NEEDS_PREFIX },
> +		{ "rm", cmd_rm, NEEDS_PREFIX },
> +		{ "add", cmd_add, NEEDS_PREFIX },
> +		{ "update-index", cmd_update_index, NEEDS_PREFIX },
> +		{ "rev-parse", cmd_rev_parse, NEEDS_PREFIX },
> +		{ "fmt-merge-msg", cmd_fmt_merge_msg, NEEDS_PREFIX },

Another rule: porcelain-ish should work from subdirectories, and
they do not have to call setup_git_directory() on their own.

>  		{ "rev-list", cmd_rev_list },

I think we should mark this with NEEDS_PREFIX, and lose the call
to setup_git_directory() it has here:

        ...
         int cmd_rev_list(int argc, const char **argv, const char *prefix)
         {
                 struct commit_list *list;
                 int i;

        -        init_revisions(&revs, setup_git_directory());
        +        init_revisions(&revs, prefix);
        ...

>  		{ "diff-files", cmd_diff_files },
>  		{ "diff-index", cmd_diff_index },
>  		{ "diff-tree", cmd_diff_tree },
>  		{ "prune", cmd_prune },
		{ "ls-files", cmd_ls_files },
		{ "ls-tree", cmd_ls_tree },
		{ "tar-tree", cmd_tar_tree },
		{ "read-tree", cmd_read_tree },
		{ "commit-tree", cmd_commit_tree },

Likewise with the above group.

>  		{ "show-branch", cmd_show_branch },
>  		{ "cat-file", cmd_cat_file },
>  		{ "write-tree", cmd_write_tree },
>  		{ "update-ref", cmd_update_ref },

These call setup_git_directory() on their own and discard the
resulting prefix; they do want to know where $GIT_DIR is to find
objects and refs, so maybe we would want to mark these with
NEEDS_PREFIX and lose their own setup_git_directory(), like the
previous group.  Perhaps you were thinking about splitting
setup_git_directory() into two independent functions, one for
finding out GIT_DIR, another for finding prefix and cd'ing up to
the project root?

Some of the above take configuration options, so even they are
not interested in finding out prefix they do need to know where
$GIT_DIR is (e.g. show-branch, update-ref, mailinfo).

>  		{ "mailinfo", cmd_mailinfo },
		{ "apply", cmd_apply },

These are tricky.  On the one hand, there is no strong reason to
forbid use of mailinfo or apply outside git context, but they do
want to use some configuration items when available (commitencoding
for mailinfo, whitespace for apply).

So here is on top of your two patches to reflect the above
comments.  Again it seems to pass our tests, so I'll put it in
"next" tonight.

--
 builtin-cat-file.c    |    1 -
 builtin-commit-tree.c |    2 --
 builtin-diff-files.c  |    2 +-
 builtin-diff-index.c  |    2 +-
 builtin-diff-tree.c   |    2 +-
 builtin-ls-files.c    |    1 -
 builtin-ls-tree.c     |    1 -
 builtin-prune.c       |    2 +-
 builtin-read-tree.c   |    1 -
 builtin-rev-list.c    |    2 +-
 builtin-show-branch.c |    1 -
 builtin-tar-tree.c    |    1 -
 builtin-update-ref.c  |    1 -
 builtin-write-tree.c  |    2 --
 git.c                 |   28 ++++++++++++++--------------
 15 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index d796431..814fb07 100644
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
index e6fb16d..9c98796 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -88,8 +88,6 @@ int cmd_commit_tree(int argc, const char
 	unsigned int size;
 
 	setup_ident();
-	setup_git_directory();
-
 	git_config(git_default_config);
 
 	if (argc < 2)
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index da51284..ac13db7 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -18,7 +18,7 @@ int cmd_diff_files(int argc, const char 
 	struct rev_info rev;
 	int silent = 0;
 
-	init_revisions(&rev, setup_git_directory());
+	init_revisions(&rev, prefix);
 	git_config(git_default_config); /* no "diff" UI options */
 	rev.abbrev = 0;
 
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index bedb90c..95a3db1 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -15,7 +15,7 @@ int cmd_diff_index(int argc, const char 
 	int cached = 0;
 	int i;
 
-	init_revisions(&rev, setup_git_directory());
+	init_revisions(&rev, prefix);
 	git_config(git_default_config); /* no "diff" UI options */
 	rev.abbrev = 0;
 
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 816946b..24cb2d7 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -67,7 +67,7 @@ int cmd_diff_tree(int argc, const char *
 	static struct rev_info *opt = &log_tree_opt;
 	int read_stdin = 0;
 
-	init_revisions(opt, setup_git_directory());
+	init_revisions(opt, prefix);
 	git_config(git_default_config); /* no "diff" UI options */
 	nr_sha1 = 0;
 	opt->abbrev = 0;
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index e906c81..79ffe8f 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -329,7 +329,6 @@ int cmd_ls_files(int argc, const char **
 	struct dir_struct dir;
 
 	memset(&dir, 0, sizeof(dir));
-	prefix = setup_git_directory();
 	if (prefix)
 		prefix_offset = strlen(prefix);
 	git_config(git_default_config);
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index d31efe9..261147f 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -90,7 +90,6 @@ int cmd_ls_tree(int argc, const char **a
 	unsigned char sha1[20];
 	struct tree *tree;
 
-	prefix = setup_git_directory();
 	git_config(git_default_config);
 	ls_tree_prefix = prefix;
 	if (prefix && *prefix)
diff --git a/builtin-prune.c b/builtin-prune.c
index 15bb650..6a86eb5 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -234,7 +234,7 @@ int cmd_prune(int argc, const char **arg
 	 * Set up revision parsing, and mark us as being interested
 	 * in all object types, not just commits.
 	 */
-	init_revisions(&revs, setup_git_directory());
+	init_revisions(&revs, prefix);
 	revs.tag_objects = 1;
 	revs.blob_objects = 1;
 	revs.tree_objects = 1;
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 25ca69c..49c10bf 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -882,7 +882,6 @@ int cmd_read_tree(int argc, const char *
 	state.quiet = 1;
 	state.refresh_cache = 1;
 
-	setup_git_directory();
 	git_config(git_default_config);
 
 	newfd = hold_lock_file_for_update(&lock_file, get_index_file());
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 65b4d0c..0dee173 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -311,7 +311,7 @@ int cmd_rev_list(int argc, const char **
 	struct commit_list *list;
 	int i;
 
-	init_revisions(&revs, setup_git_directory());
+	init_revisions(&revs, prefix);
 	revs.abbrev = 0;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 	argc = setup_revisions(argc, argv, &revs, NULL);
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 9c7f9f6..2a1b848 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -573,7 +573,6 @@ int cmd_show_branch(int ac, const char *
 	int topics = 0;
 	int dense = 1;
 
-	setup_git_directory();
 	git_config(git_show_branch_config);
 
 	/* If nothing is specified, try the default first */
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 637d22e..7c48db9 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -319,7 +319,6 @@ static int generate_tar(int argc, const 
 	current_path.alloc = PATH_MAX;
 	current_path.len = current_path.eof = 0;
 
-	setup_git_directory();
 	git_config(git_tar_config);
 
 	switch (argc) {
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index acdf39a..5bd7182 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -13,7 +13,6 @@ int cmd_update_ref(int argc, const char 
 	int i;
 
 	setup_ident();
-	setup_git_directory();
 	git_config(git_default_config);
 
 	for (i = 1; i < argc; i++) {
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 0f2dd7c..0289f59 100644
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
diff --git a/git.c b/git.c
index 34328c0..79db43e 100644
--- a/git.c
+++ b/git.c
@@ -236,32 +236,32 @@ static void handle_internal_command(int 
 		{ "grep", cmd_grep, NEEDS_PREFIX },
 		{ "rm", cmd_rm, NEEDS_PREFIX },
 		{ "add", cmd_add, NEEDS_PREFIX },
-		{ "rev-list", cmd_rev_list },
+		{ "rev-list", cmd_rev_list, NEEDS_PREFIX },
 		{ "init-db", cmd_init_db },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "upload-tar", cmd_upload_tar },
 		{ "check-ref-format", cmd_check_ref_format },
-		{ "ls-files", cmd_ls_files },
-		{ "ls-tree", cmd_ls_tree },
-		{ "tar-tree", cmd_tar_tree },
-		{ "read-tree", cmd_read_tree },
-		{ "commit-tree", cmd_commit_tree },
+		{ "ls-files", cmd_ls_files, NEEDS_PREFIX },
+		{ "ls-tree", cmd_ls_tree, NEEDS_PREFIX },
+		{ "tar-tree", cmd_tar_tree, NEEDS_PREFIX },
+		{ "read-tree", cmd_read_tree, NEEDS_PREFIX },
+		{ "commit-tree", cmd_commit_tree, NEEDS_PREFIX },
 		{ "apply", cmd_apply },
-		{ "show-branch", cmd_show_branch },
-		{ "diff-files", cmd_diff_files },
-		{ "diff-index", cmd_diff_index },
+		{ "show-branch", cmd_show_branch, NEEDS_PREFIX },
+		{ "diff-files", cmd_diff_files, NEEDS_PREFIX },
+		{ "diff-index", cmd_diff_index, NEEDS_PREFIX },
 		{ "diff-stages", cmd_diff_stages, NEEDS_PREFIX },
-		{ "diff-tree", cmd_diff_tree },
-		{ "cat-file", cmd_cat_file },
+		{ "diff-tree", cmd_diff_tree, NEEDS_PREFIX },
+		{ "cat-file", cmd_cat_file, NEEDS_PREFIX },
 		{ "rev-parse", cmd_rev_parse, NEEDS_PREFIX },
-		{ "write-tree", cmd_write_tree },
+		{ "write-tree", cmd_write_tree, NEEDS_PREFIX },
 		{ "mailsplit", cmd_mailsplit },
 		{ "mailinfo", cmd_mailinfo },
 		{ "stripspace", cmd_stripspace },
 		{ "update-index", cmd_update_index, NEEDS_PREFIX },
-		{ "update-ref", cmd_update_ref },
+		{ "update-ref", cmd_update_ref, NEEDS_PREFIX },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg, NEEDS_PREFIX },
-		{ "prune", cmd_prune },
+		{ "prune", cmd_prune, NEEDS_PREFIX },
 	};
 	int i;
 
