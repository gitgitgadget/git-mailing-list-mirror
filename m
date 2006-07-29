From: Linus Torvalds <torvalds@osdl.org>
Subject: Call setup_git_directory() early
Date: Fri, 28 Jul 2006 21:21:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607282118230.4168@g5.osdl.org>
References: <Pine.LNX.4.64.0607281811580.4168@g5.osdl.org>
 <7v3bclkwfj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 29 06:22:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6gL6-0005ui-Cf
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 06:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbWG2EVz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 00:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWG2EVz
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 00:21:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161441AbWG2EVy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 00:21:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6T4LnnW023066
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Jul 2006 21:21:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6T4LmDA028220;
	Fri, 28 Jul 2006 21:21:49 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bclkwfj.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.544 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24414>


Any git command that expects to work in a subdirectory of a project, and 
that reads the git config files (which is just about all of them) needs to 
make sure that it does the "setup_git_directory()" call before it tries to 
read the config file.

This means, among other things, that we need to move the call out of 
"init_revisions()", and into the caller.

This does the mostly trivial conversion to do that.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----


On Fri, 28 Jul 2006, Junio C Hamano wrote:
> 
> No clever ideas, but I agree it would be _very_ nice if we could
> do the setup unconditionally and early.  Some commands that call
> setup want to know prefix, so we would need to introduce a
> global to hold the prefix for them.

Ho humm. In the meantime, how about this? It fixes the places I noticed, 
but is mostly just a totally mindless conversion to move the call to 
"setup_git_directory()" into the caller.

diff --git a/blame.c b/blame.c
index b04b8f5..76712b5 100644
--- a/blame.c
+++ b/blame.c
@@ -834,7 +834,7 @@ int main(int argc, const char **argv)
 	}
 
 
-	init_revisions(&rev);
+	init_revisions(&rev, setup_git_directory());
 	rev.remove_empty_trees = 1;
 	rev.topo_order = 1;
 	rev.prune_fn = simplify_commit;
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 2e10118..ea2936a 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -18,7 +18,7 @@ int cmd_diff_files(int argc, const char 
 	struct rev_info rev;
 	int silent = 0;
 
-	init_revisions(&rev);
+	init_revisions(&rev, setup_git_directory());
 	git_config(git_default_config); /* no "diff" UI options */
 	rev.abbrev = 0;
 
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index dc52c05..eeeee93 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -15,7 +15,7 @@ int cmd_diff_index(int argc, const char 
 	int cached = 0;
 	int i;
 
-	init_revisions(&rev);
+	init_revisions(&rev, setup_git_directory());
 	git_config(git_default_config); /* no "diff" UI options */
 	rev.abbrev = 0;
 
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 8957b45..f8215ea 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -67,7 +67,7 @@ int cmd_diff_tree(int argc, const char *
 	static struct rev_info *opt = &log_tree_opt;
 	int read_stdin = 0;
 
-	init_revisions(opt);
+	init_revisions(opt, setup_git_directory());
 	git_config(git_default_config); /* no "diff" UI options */
 	nr_sha1 = 0;
 	opt->abbrev = 0;
diff --git a/builtin-diff.c b/builtin-diff.c
index 7d5ad62..7965c2c 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -227,7 +227,7 @@ int cmd_diff(int argc, const char **argv
 	struct rev_info rev;
 	struct object_array_entry ent[100];
 	int ents = 0, blobs = 0, paths = 0;
-	const char *path = NULL;
+	const char *path = NULL, *prefix;
 	struct blobinfo blob[2];
 
 	/*
@@ -250,9 +250,9 @@ int cmd_diff(int argc, const char **argv
 	 * Other cases are errors.
 	 */
 
-	init_revisions(&rev);
+	prefix = setup_git_directory();
 	git_config(git_diff_ui_config);
-	diff_setup(&rev.diffopt);
+	init_revisions(&rev, prefix);
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format) {
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index f20b27b..338f209 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -250,6 +250,7 @@ int cmd_fmt_merge_msg(int argc, char **a
 	const char *sep = "";
 	unsigned char head_sha1[20];
 	const char *head, *current_branch;
+	const char *prefix = setup_git_directory();
 
 	git_config(fmt_merge_msg_config);
 
@@ -342,7 +343,7 @@ int cmd_fmt_merge_msg(int argc, char **a
 		struct rev_info rev;
 
 		head = lookup_commit(head_sha1);
-		init_revisions(&rev);
+		init_revisions(&rev, prefix);
 		rev.commit_format = CMIT_FMT_ONELINE;
 		rev.ignore_merges = 1;
 		rev.limited = 1;
diff --git a/builtin-log.c b/builtin-log.c
index 88c835a..52064cd 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -48,10 +48,10 @@ static int cmd_log_walk(struct rev_info 
 int cmd_whatchanged(int argc, const char **argv, char **envp)
 {
 	struct rev_info rev;
+	const char *prefix = setup_git_directory();
 
-	init_revisions(&rev);
 	git_config(git_diff_ui_config);
-	diff_setup(&rev.diffopt);
+	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
 	rev.simplify_history = 0;
@@ -64,10 +64,10 @@ int cmd_whatchanged(int argc, const char
 int cmd_show(int argc, const char **argv, char **envp)
 {
 	struct rev_info rev;
+	const char *prefix = setup_git_directory();
 
-	init_revisions(&rev);
 	git_config(git_diff_ui_config);
-	diff_setup(&rev.diffopt);
+	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
 	rev.combine_merges = 1;
@@ -82,10 +82,10 @@ int cmd_show(int argc, const char **argv
 int cmd_log(int argc, const char **argv, char **envp)
 {
 	struct rev_info rev;
+	const char *prefix = setup_git_directory();
 
-	init_revisions(&rev);
 	git_config(git_diff_ui_config);
-	diff_setup(&rev.diffopt);
+	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
 	cmd_log_init(argc, argv, envp, &rev);
 	return cmd_log_walk(&rev);
@@ -188,6 +188,7 @@ static void get_patch_ids(struct rev_inf
 	struct object *o1, *o2;
 	unsigned flags1, flags2;
 	unsigned char sha1[20];
+	const char *prefix = setup_git_directory();
 
 	if (rev->pending.nr != 2)
 		die("Need exactly one range.");
@@ -206,7 +207,7 @@ static void get_patch_ids(struct rev_inf
 		die("diff_setup_done failed");
 
 	/* given a range a..b get all patch ids for b..a */
-	init_revisions(&check_rev);
+	init_revisions(&check_rev, prefix);
 	o1->flags ^= UNINTERESTING;
 	o2->flags ^= UNINTERESTING;
 	add_pending_object(&check_rev, o1, "o1");
@@ -260,9 +261,10 @@ int cmd_format_patch(int argc, const cha
 	char *add_signoff = NULL;
 	char message_id[1024];
 	char ref_message_id[1024];
+	const char *prefix = setup_git_directory();
 
 	git_config(git_format_config);
-	init_revisions(&rev);
+	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
 	rev.diff = 1;
diff --git a/builtin-prune.c b/builtin-prune.c
index d196c41..4ed1e1b 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -234,7 +234,7 @@ int cmd_prune(int argc, const char **arg
 	 * Set up revision parsing, and mark us as being interested
 	 * in all object types, not just commits.
 	 */
-	init_revisions(&revs);
+	init_revisions(&revs, setup_git_directory());
 	revs.tag_objects = 1;
 	revs.blob_objects = 1;
 	revs.tree_objects = 1;
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 8f32871..2b6691c 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -311,7 +311,7 @@ int cmd_rev_list(int argc, const char **
 	struct commit_list *list;
 	int i;
 
-	init_revisions(&revs);
+	init_revisions(&revs, setup_git_directory());
 	revs.abbrev = 0;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 	argc = setup_revisions(argc, argv, &revs, NULL);
diff --git a/http-push.c b/http-push.c
index 4768619..4021e7d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2521,7 +2521,7 @@ int main(int argc, char **argv)
 			commit_argv[3] = old_sha1_hex;
 			commit_argc++;
 		}
-		init_revisions(&revs);
+		init_revisions(&revs, setup_git_directory());
 		setup_revisions(commit_argc, commit_argv, &revs, NULL);
 		free(new_sha1_hex);
 		if (old_sha1_hex) {
diff --git a/revision.c b/revision.c
index 874e349..a58257a 100644
--- a/revision.c
+++ b/revision.c
@@ -509,7 +509,7 @@ static int add_parents_only(struct rev_i
 	return 1;
 }
 
-void init_revisions(struct rev_info *revs)
+void init_revisions(struct rev_info *revs, const char *prefix)
 {
 	memset(revs, 0, sizeof(*revs));
 
@@ -521,7 +521,7 @@ void init_revisions(struct rev_info *rev
 	revs->pruning.change = file_change;
 	revs->lifo = 1;
 	revs->dense = 1;
-	revs->prefix = setup_git_directory();
+	revs->prefix = prefix;
 	revs->max_age = -1;
 	revs->min_age = -1;
 	revs->max_count = -1;
diff --git a/revision.h b/revision.h
index e23ec8f..0c3b8d9 100644
--- a/revision.h
+++ b/revision.h
@@ -87,7 +87,7 @@ #define REV_TREE_DIFFERENT	2
 extern int rev_same_tree_as_empty(struct rev_info *, struct tree *t1);
 extern int rev_compare_tree(struct rev_info *, struct tree *t1, struct tree *t2);
 
-extern void init_revisions(struct rev_info *revs);
+extern void init_revisions(struct rev_info *revs, const char *prefix);
 extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
 extern void prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
