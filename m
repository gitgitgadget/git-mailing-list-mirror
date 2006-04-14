From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 16:52:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604141637230.3701@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 15 01:53:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUY5x-0006j7-Ln
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 01:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWDNXwy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 19:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWDNXwy
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 19:52:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7602 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751282AbWDNXwx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 19:52:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3ENqLtH008170
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Apr 2006 16:52:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3ENqDRI016412;
	Fri, 14 Apr 2006 16:52:16 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18710>



On Fri, 14 Apr 2006, Junio C Hamano wrote:
> 
> * Message-ID: <Pine.LNX.4.64.0604121828370.14565@g5.osdl.org>
>   Common option parsing (Linus Torvalds)

Ok, here's a first cut at starting this.

This basically does a few things that are sadly somewhat interdependent, 
and nontrivial to split out

 - get rid of "struct log_tree_opt"

   The fields in "log_tree_opt" are moved into "struct rev_info", and all 
   users of log_tree_opt are changed to use the rev_info struct instead.

 - add the parsing for the log_tree_opt arguments to "setup_revision()"

 - make setup_revision set a flag (revs->diff) if the diff-related 
   arguments were used. This allows "git log" to decide whether it wants 
   to show diffs or not.

 - make setup_revision() also initialize the diffopt part of rev_info 
   (which we had from before, but we just didn't initialize it)

 - make setup_revision() do all the "finishing touches" on it all (it will 
   do the proper flag combination logic, and call "diff_setup_done()")

Now, that was the easy and straightforward part.

The slightly more involved part is that some of the programs that want to 
use the new-and-improved rev_info parsing don't actually want _commits_, 
they may want tree'ish arguments instead. That meant that I had to change 
setup_revision() to parse the arguments not into the "revs->commits" list, 
but into the "revs->pending_objects" list.

Then, when we do "prepare_revision_walk()", we walk that list, and create 
the sorted commit list from there. 

This actually cleaned some stuff up, but it's the less obvious part of the 
patch, and re-organized the "revision.c" logic somewhat. It actually paves 
the way for splitting argument parsing _entirely_ out of "revision.c", 
since now the argument parsing really is totally independent of the commit 
walking: that didn't use to be true, since there was lots of overlap with 
get_commit_reference() handling etc, now the _only_ overlap is the shared 
(and trivial) "add_pending_object()" thing.

However, I didn't do that file split, just because I wanted the diff 
itself to be smaller, and show the actual changes more clearly. If this 
gets accepted, I'll do further cleanups then - that includes the file 
split, but also using the new infrastructure to do a nicer "git diff" etc.

Even in this form, it actually ends up removing more lines than it adds.

It's nice to note how simple and straightforward this makes the built-in 
"git log" command, even though it continues to support all the diff flags 
too. It doesn't get much simpler that this.

I think this is worth merging soonish, because it does allow for future 
cleanup and even more sharing of code. However, it obviously touches 
"revision.c", which is subtle. I've tested that it passes all the tests we 
have, and it passes my "looks sane" detector, but somebody else should 
also give it a good look-over.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

 diff-tree.c |   91 ++++++++++++++++-------------------
 git.c       |   68 ++------------------------
 log-tree.c  |   60 ++---------------------
 log-tree.h  |   22 ++------
 revision.c  |  155 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 revision.h  |   18 +++++++
 6 files changed, 202 insertions(+), 212 deletions(-)

diff --git a/diff-tree.c b/diff-tree.c
index 2b79dd0..54157e4 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -3,7 +3,7 @@ #include "diff.h"
 #include "commit.h"
 #include "log-tree.h"
 
-static struct log_tree_opt log_tree_opt;
+static struct rev_info log_tree_opt;
 
 static int diff_tree_commit_sha1(const unsigned char *sha1)
 {
@@ -62,66 +62,55 @@ int main(int argc, const char **argv)
 {
 	int nr_sha1;
 	char line[1000];
-	unsigned char sha1[2][20];
-	const char *prefix = setup_git_directory();
-	static struct log_tree_opt *opt = &log_tree_opt;
+	struct object *tree1, *tree2;
+	static struct rev_info *opt = &log_tree_opt;
+	struct object_list *list;
 	int read_stdin = 0;
 
 	git_config(git_diff_config);
 	nr_sha1 = 0;
-	init_log_tree_opt(opt);
+	argc = setup_revisions(argc, argv, opt, NULL);
 
-	for (;;) {
-		int opt_cnt;
-		const char *arg;
+	while (--argc > 0) {
+		const char *arg = *++argv;
 
-		argv++;
-		argc--;
-		arg = *argv;
-		if (!arg)
-			break;
-
-		if (*arg != '-') {
-			if (nr_sha1 < 2 && !get_sha1(arg, sha1[nr_sha1])) {
-				nr_sha1++;
-				continue;
-			}
-			break;
-		}
-
-		opt_cnt = log_tree_opt_parse(opt, argv, argc);
-		if (opt_cnt < 0)
-			usage(diff_tree_usage);
-		else if (opt_cnt) {
-			argv += opt_cnt - 1;
-			argc -= opt_cnt - 1;
-			continue;
-		}
-
-		if (!strcmp(arg, "--")) {
-			argv++;
-			argc--;
-			break;
-		}
 		if (!strcmp(arg, "--stdin")) {
 			read_stdin = 1;
 			continue;
 		}
 		usage(diff_tree_usage);
 	}
-
-	if (opt->combine_merges)
-		opt->ignore_merges = 0;
-
-	/* We can only do dense combined merges with diff output */
-	if (opt->dense_combined_merges)
-		opt->diffopt.output_format = DIFF_FORMAT_PATCH;
-
-	if (opt->diffopt.output_format == DIFF_FORMAT_PATCH)
-		opt->diffopt.recursive = 1;
 
-	diff_tree_setup_paths(get_pathspec(prefix, argv), opt);
-	diff_setup_done(&opt->diffopt);
+	/*
+	 * NOTE! "setup_revisions()" will have inserted the revisions
+	 * it parsed in reverse order. So if you do
+	 *
+	 *	git-diff-tree a b
+	 *
+	 * the commit list will be "b" -> "a" -> NULL, so we reverse
+	 * the order of the objects if the first one is not marked
+	 * UNINTERESTING.
+	 */
+	nr_sha1 = 0;
+	list = opt->pending_objects;
+	if (list) {
+		nr_sha1++;
+		tree1 = list->item;
+		list = list->next;
+		if (list) {
+			nr_sha1++;
+			tree2 = tree1;
+			tree1 = list->item;
+			if (list->next)
+				usage(diff_tree_usage);
+			/* Switch them around if the second one was uninteresting.. */
+			if (tree2->flags & UNINTERESTING) {
+				struct object *tmp = tree2;
+				tree2 = tree1;
+				tree1 = tmp;
+			}
+		}
+	}
 
 	switch (nr_sha1) {
 	case 0:
@@ -129,10 +118,12 @@ int main(int argc, const char **argv)
 			usage(diff_tree_usage);
 		break;
 	case 1:
-		diff_tree_commit_sha1(sha1[0]);
+		diff_tree_commit_sha1(tree1->sha1);
 		break;
 	case 2:
-		diff_tree_sha1(sha1[0], sha1[1], "", &opt->diffopt);
+		diff_tree_sha1(tree1->sha1,
+			       tree2->sha1,
+			       "", &opt->diffopt);
 		log_tree_diff_flush(opt);
 		break;
 	}
diff --git a/git.c b/git.c
index 78ed403..e8d1fcc 100644
--- a/git.c
+++ b/git.c
@@ -287,74 +287,18 @@ static int cmd_log(int argc, const char 
 	int abbrev = DEFAULT_ABBREV;
 	int abbrev_commit = 0;
 	const char *commit_prefix = "commit ";
-	struct log_tree_opt opt;
 	int shown = 0;
-	int do_diff = 0;
-	int full_diff = 0;
 
-	init_log_tree_opt(&opt);
 	argc = setup_revisions(argc, argv, &rev, "HEAD");
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strncmp(arg, "--pretty", 8)) {
-			commit_format = get_commit_format(arg + 8);
-			if (commit_format == CMIT_FMT_ONELINE)
-				commit_prefix = "";
-		}
-		else if (!strcmp(arg, "--no-abbrev")) {
-			abbrev = 0;
-		}
-		else if (!strcmp(arg, "--abbrev")) {
-			abbrev = DEFAULT_ABBREV;
-		}
-		else if (!strcmp(arg, "--abbrev-commit")) {
-			abbrev_commit = 1;
-		}
-		else if (!strncmp(arg, "--abbrev=", 9)) {
-			abbrev = strtoul(arg + 9, NULL, 10);
-			if (abbrev && abbrev < MINIMUM_ABBREV)
-				abbrev = MINIMUM_ABBREV;
-			else if (40 < abbrev)
-				abbrev = 40;
-		}
-		else if (!strcmp(arg, "--full-diff")) {
-			do_diff = 1;
-			full_diff = 1;
-		}
-		else {
-			int cnt = log_tree_opt_parse(&opt, argv+1, argc-1);
-			if (0 < cnt) {
-				do_diff = 1;
-				argv += cnt;
-				argc -= cnt;
-				continue;
-			}
-			die("unrecognized argument: %s", arg);
-		}
+	if (argc > 1)
+		die("unrecognized argument: %s", argv[1]);
 
-		argc--; argv++;
-	}
-
-	if (do_diff) {
-		opt.diffopt.abbrev = abbrev;
-		opt.verbose_header = 0;
-		opt.always_show_header = 0;
-		opt.no_commit_id = 1;
-		if (opt.combine_merges)
-			opt.ignore_merges = 0;
-		if (opt.dense_combined_merges)
-			opt.diffopt.output_format = DIFF_FORMAT_PATCH;
-		if (opt.diffopt.output_format == DIFF_FORMAT_PATCH)
-			opt.diffopt.recursive = 1;
-		if (!full_diff && rev.prune_data)
-			diff_tree_setup_paths(rev.prune_data, &opt.diffopt);
-		diff_setup_done(&opt.diffopt);
-	}
+	rev.no_commit_id = 1;
 
 	prepare_revision_walk(&rev);
 	setup_pager();
 	while ((commit = get_revision(&rev)) != NULL) {
-		if (shown && do_diff && commit_format != CMIT_FMT_ONELINE)
+		if (shown && rev.diff && commit_format != CMIT_FMT_ONELINE)
 			putchar('\n');
 		fputs(commit_prefix, stdout);
 		if (abbrev_commit && abbrev)
@@ -388,8 +332,8 @@ static int cmd_log(int argc, const char 
 		pretty_print_commit(commit_format, commit, ~0, buf,
 				    LOGSIZE, abbrev);
 		printf("%s\n", buf);
-		if (do_diff)
-			log_tree_commit(&opt, commit);
+		if (rev.diff)
+			log_tree_commit(&rev, commit);
 		shown = 1;
 		free(commit->buffer);
 		commit->buffer = NULL;
diff --git a/log-tree.c b/log-tree.c
index 3d40482..04a68e0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -3,58 +3,8 @@ #include "diff.h"
 #include "commit.h"
 #include "log-tree.h"
 
-void init_log_tree_opt(struct log_tree_opt *opt)
+int log_tree_diff_flush(struct rev_info *opt)
 {
-	memset(opt, 0, sizeof *opt);
-	opt->ignore_merges = 1;
-	opt->header_prefix = "";
-	opt->commit_format = CMIT_FMT_RAW;
-	diff_setup(&opt->diffopt);
-}
-
-int log_tree_opt_parse(struct log_tree_opt *opt, const char **av, int ac)
-{
-	const char *arg;
-	int cnt = diff_opt_parse(&opt->diffopt, av, ac);
-	if (0 < cnt)
-		return cnt;
-	arg = *av;
-	if (!strcmp(arg, "-r"))
-		opt->diffopt.recursive = 1;
-	else if (!strcmp(arg, "-t")) {
-		opt->diffopt.recursive = 1;
-		opt->diffopt.tree_in_recursive = 1;
-	}
-	else if (!strcmp(arg, "-m"))
-		opt->ignore_merges = 0;
-	else if (!strcmp(arg, "-c"))
-		opt->combine_merges = 1;
-	else if (!strcmp(arg, "--cc")) {
-		opt->dense_combined_merges = 1;
-		opt->combine_merges = 1;
-	}
-	else if (!strcmp(arg, "-v")) {
-		opt->verbose_header = 1;
-		opt->header_prefix = "diff-tree ";
-	}
-	else if (!strncmp(arg, "--pretty", 8)) {
-		opt->verbose_header = 1;
-		opt->header_prefix = "diff-tree ";
-		opt->commit_format = get_commit_format(arg+8);
-	}
-	else if (!strcmp(arg, "--root"))
-		opt->show_root_diff = 1;
-	else if (!strcmp(arg, "--no-commit-id"))
-		opt->no_commit_id = 1;
-	else if (!strcmp(arg, "--always"))
-		opt->always_show_header = 1;
-	else
-		return 0;
-	return 1;
-}
-
-int log_tree_diff_flush(struct log_tree_opt *opt)
-{
 	diffcore_std(&opt->diffopt);
 	if (diff_queue_is_empty()) {
 		int saved_fmt = opt->diffopt.output_format;
@@ -73,7 +23,7 @@ int log_tree_diff_flush(struct log_tree_
 	return 1;
 }
 
-static int diff_root_tree(struct log_tree_opt *opt,
+static int diff_root_tree(struct rev_info *opt,
 			  const unsigned char *new, const char *base)
 {
 	int retval;
@@ -93,7 +43,7 @@ static int diff_root_tree(struct log_tre
 	return retval;
 }
 
-static const char *generate_header(struct log_tree_opt *opt,
+static const char *generate_header(struct rev_info *opt,
 				   const unsigned char *commit_sha1,
 				   const unsigned char *parent_sha1,
 				   const struct commit *commit)
@@ -129,7 +79,7 @@ static const char *generate_header(struc
 	return this_header;
 }
 
-static int do_diff_combined(struct log_tree_opt *opt, struct commit *commit)
+static int do_diff_combined(struct rev_info *opt, struct commit *commit)
 {
 	unsigned const char *sha1 = commit->object.sha1;
 
@@ -142,7 +92,7 @@ static int do_diff_combined(struct log_t
 	return 0;
 }
 
-int log_tree_commit(struct log_tree_opt *opt, struct commit *commit)
+int log_tree_commit(struct rev_info *opt, struct commit *commit)
 {
 	struct commit_list *parents;
 	unsigned const char *sha1 = commit->object.sha1;
diff --git a/log-tree.h b/log-tree.h
index da166c6..91a909b 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -1,23 +1,11 @@
 #ifndef LOG_TREE_H
 #define LOG_TREE_H
 
-struct log_tree_opt {
-	struct diff_options diffopt;
-	int show_root_diff;
-	int no_commit_id;
-	int verbose_header;
-	int ignore_merges;
-	int combine_merges;
-	int dense_combined_merges;
-	int always_show_header;
-	const char *header_prefix;
-	const char *header;
-	enum cmit_fmt commit_format;
-};
+#include "revision.h"
 
-void init_log_tree_opt(struct log_tree_opt *);
-int log_tree_diff_flush(struct log_tree_opt *);
-int log_tree_commit(struct log_tree_opt *, struct commit *);
-int log_tree_opt_parse(struct log_tree_opt *, const char **, int);
+void init_log_tree_opt(struct rev_info *);
+int log_tree_diff_flush(struct rev_info *);
+int log_tree_commit(struct rev_info *, struct commit *);
+int log_tree_opt_parse(struct rev_info *, const char **, int);
 
 #endif
diff --git a/revision.c b/revision.c
index 0505f3f..99077af 100644
--- a/revision.c
+++ b/revision.c
@@ -116,21 +116,27 @@ static void add_pending_object(struct re
 	add_object(obj, &revs->pending_objects, NULL, name);
 }
 
-static struct commit *get_commit_reference(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags)
+static struct object *get_reference(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags)
 {
 	struct object *object;
 
 	object = parse_object(sha1);
 	if (!object)
 		die("bad object %s", name);
+	object->flags |= flags;
+	return object;
+}
+
+static struct commit *handle_commit(struct rev_info *revs, struct object *object, const char *name)
+{
+	unsigned long flags = object->flags;
 
 	/*
 	 * Tag object? Look what it points to..
 	 */
 	while (object->type == tag_type) {
 		struct tag *tag = (struct tag *) object;
-		object->flags |= flags;
-		if (revs->tag_objects && !(object->flags & UNINTERESTING))
+		if (revs->tag_objects && !(flags & UNINTERESTING))
 			add_pending_object(revs, object, tag->tag);
 		object = parse_object(tag->tagged->sha1);
 		if (!object)
@@ -143,7 +149,6 @@ static struct commit *get_commit_referen
 	 */
 	if (object->type == commit_type) {
 		struct commit *commit = (struct commit *)object;
-		object->flags |= flags;
 		if (parse_commit(commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
@@ -449,14 +454,6 @@ static void limit_list(struct rev_info *
 		}
 	}
 	revs->commits = newlist;
-}
-
-static void add_one_commit(struct commit *commit, struct rev_info *revs)
-{
-	if (!commit || (commit->object.flags & SEEN))
-		return;
-	commit->object.flags |= SEEN;
-	commit_list_insert(commit, &revs->commits);
 }
 
 static int all_flags;
@@ -464,8 +461,8 @@ static struct rev_info *all_revs;
 
 static int handle_one_ref(const char *path, const unsigned char *sha1)
 {
-	struct commit *commit = get_commit_reference(all_revs, path, sha1, all_flags);
-	add_one_commit(commit, all_revs);
+	struct object *object = get_reference(all_revs, path, sha1, all_flags);
+	add_pending_object(all_revs, object, "");
 	return 0;
 }
 
@@ -494,6 +491,11 @@ void init_revisions(struct rev_info *rev
 
 	revs->topo_setter = topo_sort_default_setter;
 	revs->topo_getter = topo_sort_default_getter;
+
+	revs->header_prefix = "";
+	revs->commit_format = CMIT_FMT_RAW;
+
+	diff_setup(&revs->diffopt);
 }
 
 /*
@@ -526,13 +528,14 @@ int setup_revisions(int argc, const char
 
 	flags = 0;
 	for (i = 1; i < argc; i++) {
-		struct commit *commit;
+		struct object *object;
 		const char *arg = argv[i];
 		unsigned char sha1[20];
 		char *dotdot;
 		int local_flags;
 
 		if (*arg == '-') {
+			int opts;
 			if (!strncmp(arg, "--max-count=", 12)) {
 				revs->max_count = atoi(arg + 12);
 				continue;
@@ -638,6 +641,78 @@ int setup_revisions(int argc, const char
 			}
 			if (!strcmp(arg, "--unpacked")) {
 				revs->unpacked = 1;
+				continue;
+			}
+			if (!strcmp(arg, "-r")) {
+				revs->diff = 1;
+				revs->diffopt.recursive = 1;
+				continue;
+			}
+			if (!strcmp(arg, "-t")) {
+				revs->diff = 1;
+				revs->diffopt.recursive = 1;
+				revs->diffopt.tree_in_recursive = 1;
+				continue;
+			}
+			if (!strcmp(arg, "-m")) {
+				revs->ignore_merges = 0;
+				continue;
+			}
+			if (!strcmp(arg, "-c")) {
+				revs->diff = 1;
+				revs->combine_merges = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--cc")) {
+				revs->diff = 1;
+				revs->dense_combined_merges = 1;
+				revs->combine_merges = 1;
+				continue;
+			}
+			if (!strcmp(arg, "-v")) {
+				revs->verbose_header = 1;
+				revs->header_prefix = "diff-tree ";
+				continue;
+			}
+			if (!strncmp(arg, "--pretty", 8)) {
+				revs->verbose_header = 1;
+				revs->header_prefix = "diff-tree ";
+				revs->commit_format = get_commit_format(arg+8);
+				continue;
+			}
+			if (!strcmp(arg, "--root")) {
+				revs->show_root_diff = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--no-commit-id")) {
+				revs->no_commit_id = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--always")) {
+				revs->always_show_header = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--no-abbrev")) {
+				revs->abbrev = 0;
+				continue;
+			}
+			if (!strcmp(arg, "--abbrev")) {
+				revs->abbrev = DEFAULT_ABBREV;
+				continue;
+			}
+			if (!strcmp(arg, "--abbrev-commit")) {
+				revs->abbrev_commit = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--full-diff")) {
+				revs->diff = 1;
+				revs->full_diff = 1;
+				continue;
+			}
+			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
+			if (opts > 0) {
+				revs->diff = 1;
+				i += opts - 1;
 				continue;
 			}
 			*unrecognized++ = arg;
@@ -656,15 +731,15 @@ int setup_revisions(int argc, const char
 				this = "HEAD";
 			if (!get_sha1(this, from_sha1) &&
 			    !get_sha1(next, sha1)) {
-				struct commit *exclude;
-				struct commit *include;
+				struct object *exclude;
+				struct object *include;
 
-				exclude = get_commit_reference(revs, this, from_sha1, flags ^ UNINTERESTING);
-				include = get_commit_reference(revs, next, sha1, flags);
+				exclude = get_reference(revs, this, from_sha1, flags ^ UNINTERESTING);
+				include = get_reference(revs, next, sha1, flags);
 				if (!exclude || !include)
 					die("Invalid revision range %s..%s", arg, next);
-				add_one_commit(exclude, revs);
-				add_one_commit(include, revs);
+				add_pending_object(revs, exclude, this);
+				add_pending_object(revs, include, next);
 				continue;
 			}
 			*dotdot = '.';
@@ -689,16 +764,16 @@ int setup_revisions(int argc, const char
 			revs->prune_data = get_pathspec(revs->prefix, argv + i);
 			break;
 		}
-		commit = get_commit_reference(revs, arg, sha1, flags ^ local_flags);
-		add_one_commit(commit, revs);
+		object = get_reference(revs, arg, sha1, flags ^ local_flags);
+		add_pending_object(revs, object, arg);
 	}
-	if (def && !revs->commits) {
+	if (def && !revs->pending_objects) {
 		unsigned char sha1[20];
-		struct commit *commit;
+		struct object *object;
 		if (get_sha1(def, sha1) < 0)
 			die("bad default revision '%s'", def);
-		commit = get_commit_reference(revs, def, sha1, 0);
-		add_one_commit(commit, revs);
+		object = get_reference(revs, def, sha1, 0);
+		add_pending_object(revs, object, def);
 	}
 
 	if (revs->topo_order || revs->unpacked)
@@ -708,13 +783,37 @@ int setup_revisions(int argc, const char
 		diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
 		revs->prune_fn = try_to_simplify_commit;
 	}
+	if (revs->combine_merges) {
+		revs->ignore_merges = 0;
+		if (revs->dense_combined_merges)
+			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
+	}
+	if (revs->diffopt.output_format == DIFF_FORMAT_PATCH)
+		revs->diffopt.recursive = 1;
+	if (!revs->full_diff && revs->prune_data)
+		diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
+	diff_setup_done(&revs->diffopt);
 
 	return left;
 }
 
 void prepare_revision_walk(struct rev_info *revs)
 {
-	sort_by_date(&revs->commits);
+	struct object_list *list;
+
+	list = revs->pending_objects;
+	revs->pending_objects = NULL;
+	while (list) {
+		struct commit *commit = handle_commit(revs, list->item, list->name);
+		if (commit) {
+			if (!(commit->object.flags & SEEN)) {
+				commit->object.flags |= SEEN;
+				insert_by_date(commit, &revs->commits);
+			}
+		}
+		list = list->next;
+	}
+
 	if (revs->limited)
 		limit_list(revs);
 	if (revs->topo_order)
diff --git a/revision.h b/revision.h
index 8970b57..9a45986 100644
--- a/revision.h
+++ b/revision.h
@@ -38,6 +38,24 @@ struct rev_info {
 			boundary:1,
 			parents:1;
 
+	/* Diff flags */
+	unsigned int	diff:1,
+			full_diff:1,
+			show_root_diff:1,
+			no_commit_id:1,
+			verbose_header:1,
+			ignore_merges:1,
+			combine_merges:1,
+			dense_combined_merges:1,
+			always_show_header:1;
+
+	/* Format info */
+	unsigned int	abbrev_commit:1;
+	unsigned int	abbrev;
+	enum cmit_fmt	commit_format;
+	const char	*header_prefix;
+	const char	*header;
+
 	/* special limits */
 	int max_count;
 	unsigned long max_age;
