From: Linus Torvalds <torvalds@osdl.org>
Subject: Log message printout cleanups
Date: Mon, 17 Apr 2006 11:59:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604171149330.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
 <7vbqv1oxie.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 17 21:00:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVYxL-0006Bc-KS
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 21:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWDQTAE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 15:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWDQTAE
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 15:00:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23436 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751210AbWDQTAC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Apr 2006 15:00:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3HIxXtH029292
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Apr 2006 11:59:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3HIxWoU018235;
	Mon, 17 Apr 2006 11:59:33 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqv1oxie.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18831>



On Sun, 16 Apr 2006, Junio C Hamano wrote:
> 
> In the mid-term, I am hoping we can drop the generate_header()
> callchain _and_ the custom code that formats commit log in-core,
> found in cmd_log_wc().

Ok, this was nastier than expected, just because the dependencies between 
the different log-printing stuff were absolutely _everywhere_, but here's 
a patch that does exactly that.

The patch is not very easy to read, and the "--patch-with-stat" thing is 
still broken (it does not call the "show_log()" thing properly for 
merges). That's not a new bug. In the new world order it _should_ do 
something like

	if (rev->logopt)
		show_log(rev, rev->logopt, "---\n");

but it doesn't. I haven't looked at the --with-stat logic, so I left it 
alone.

That said, this patch removes more lines than it adds, and in particular, 
the "cmd_log_wc()" loop is now a very clean:

	while ((commit = get_revision(rev)) != NULL) {
		log_tree_commit(rev, commit);
		free(commit->buffer);
		commit->buffer = NULL;
	}

so it doesn't get much prettier than this. All the complexity is entirely 
hidden in log-tree.c, and any code that needs to flush the log literally 
just needs to do the "if (rev->logopt) show_log(...)" incantation.

I had to make the combined_diff() logic take a "struct rev_info" instead 
of just a "struct diff_options", but that part is pretty clean.

This does change "git whatchanged" from using "diff-tree" as the commit 
descriptor to "commit", and I changed one of the tests to reflect that new 
reality. Otherwise everything still passes, and my other tests look fine 
too.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 combine-diff.c      |   47 ++++++--------
 diff-files.c        |   27 ++++----
 diff-tree.c         |    1 
 diff.h              |    8 +-
 git.c               |   57 +----------------
 log-tree.c          |  167 ++++++++++++++++++++++++++++-----------------------
 log-tree.h          |    5 ++
 rev-list.c          |    9 ++-
 revision.c          |    3 -
 revision.h          |    8 +-
 t/t1200-tutorial.sh |    4 +
 11 files changed, 151 insertions(+), 185 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 9bd27f8..b4fa9c9 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -5,6 +5,7 @@ #include "diff.h"
 #include "diffcore.h"
 #include "quote.h"
 #include "xdiff-interface.h"
+#include "log-tree.h"
 
 static int uninteresting(struct diff_filepair *p)
 {
@@ -585,9 +586,9 @@ static void reuse_combine_diff(struct sl
 }
 
 static int show_patch_diff(struct combine_diff_path *elem, int num_parent,
-			   int dense, const char *header,
-			   struct diff_options *opt)
+			   int dense, struct rev_info *rev)
 {
+	struct diff_options *opt = &rev->diffopt;
 	unsigned long result_size, cnt, lno;
 	char *result, *cp, *ep;
 	struct sline *sline; /* survived lines */
@@ -689,10 +690,8 @@ static int show_patch_diff(struct combin
 	if (show_hunks || mode_differs || working_tree_file) {
 		const char *abb;
 
-		if (header) {
-			shown_header++;
-			printf("%s%c", header, opt->line_termination);
-		}
+		if (rev->loginfo)
+			show_log(rev, rev->loginfo, "\n");
 		printf("diff --%s ", dense ? "cc" : "combined");
 		if (quote_c_style(elem->path, NULL, NULL, 0))
 			quote_c_style(elem->path, NULL, stdout, 0);
@@ -750,8 +749,9 @@ static int show_patch_diff(struct combin
 
 #define COLONS "::::::::::::::::::::::::::::::::"
 
-static void show_raw_diff(struct combine_diff_path *p, int num_parent, const char *header, struct diff_options *opt)
+static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct rev_info *rev)
 {
+	struct diff_options *opt = &rev->diffopt;
 	int i, offset, mod_type = 'A';
 	const char *prefix;
 	int line_termination, inter_name_termination;
@@ -761,8 +761,8 @@ static void show_raw_diff(struct combine
 	if (!line_termination)
 		inter_name_termination = 0;
 
-	if (header)
-		printf("%s%c", header, line_termination);
+	if (rev->loginfo)
+		show_log(rev, rev->loginfo, "\n");
 
 	for (i = 0; i < num_parent; i++) {
 		if (p->parent[i].mode)
@@ -810,31 +810,31 @@ static void show_raw_diff(struct combine
 	}
 }
 
-int show_combined_diff(struct combine_diff_path *p,
+void show_combined_diff(struct combine_diff_path *p,
 		       int num_parent,
 		       int dense,
-		       const char *header,
-		       struct diff_options *opt)
+		       struct rev_info *rev)
 {
+	struct diff_options *opt = &rev->diffopt;
 	if (!p->len)
-		return 0;
+		return;
 	switch (opt->output_format) {
 	case DIFF_FORMAT_RAW:
 	case DIFF_FORMAT_NAME_STATUS:
 	case DIFF_FORMAT_NAME:
-		show_raw_diff(p, num_parent, header, opt);
-		return 1;
+		show_raw_diff(p, num_parent, rev);
+		return;
 
 	default:
 	case DIFF_FORMAT_PATCH:
-		return show_patch_diff(p, num_parent, dense, header, opt);
+		show_patch_diff(p, num_parent, dense, rev);
 	}
 }
 
-const char *diff_tree_combined_merge(const unsigned char *sha1,
-			     const char *header, int dense,
-			     struct diff_options *opt)
+void diff_tree_combined_merge(const unsigned char *sha1,
+			     int dense, struct rev_info *rev)
 {
+	struct diff_options *opt = &rev->diffopt;
 	struct commit *commit = lookup_commit(sha1);
 	struct diff_options diffopts;
 	struct commit_list *parents;
@@ -874,17 +874,13 @@ const char *diff_tree_combined_merge(con
 			int saved_format = opt->output_format;
 			opt->output_format = DIFF_FORMAT_RAW;
 			for (p = paths; p; p = p->next) {
-				if (show_combined_diff(p, num_parent, dense,
-						       header, opt))
-					header = NULL;
+				show_combined_diff(p, num_parent, dense, rev);
 			}
 			opt->output_format = saved_format;
 			putchar(opt->line_termination);
 		}
 		for (p = paths; p; p = p->next) {
-			if (show_combined_diff(p, num_parent, dense,
-					       header, opt))
-				header = NULL;
+			show_combined_diff(p, num_parent, dense, rev);
 		}
 	}
 
@@ -894,5 +890,4 @@ const char *diff_tree_combined_merge(con
 		paths = paths->next;
 		free(tmp);
 	}
-	return header;
 }
diff --git a/diff-files.c b/diff-files.c
index 3e7f5f1..ffbef48 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -5,12 +5,14 @@
  */
 #include "cache.h"
 #include "diff.h"
+#include "commit.h"
+#include "revision.h"
 
 static const char diff_files_usage[] =
 "git-diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
-static struct diff_options diff_options;
+static struct rev_info rev;
 static int silent = 0;
 static int diff_unmerged_stage = 2;
 static int combine_merges = 0;
@@ -18,12 +20,12 @@ static int dense_combined_merges = 0;
 
 static void show_unmerge(const char *path)
 {
-	diff_unmerge(&diff_options, path);
+	diff_unmerge(&rev.diffopt, path);
 }
 
 static void show_file(int pfx, struct cache_entry *ce)
 {
-	diff_addremove(&diff_options, pfx, ntohl(ce->ce_mode),
+	diff_addremove(&rev.diffopt, pfx, ntohl(ce->ce_mode),
 		       ce->sha1, ce->name, NULL);
 }
 
@@ -31,7 +33,7 @@ static void show_modified(int oldmode, i
 			  const unsigned char *old_sha1, const unsigned char *sha1,
 			  char *path)
 {
-	diff_change(&diff_options, oldmode, mode, old_sha1, sha1, path, NULL);
+	diff_change(&rev.diffopt, oldmode, mode, old_sha1, sha1, path, NULL);
 }
 
 int main(int argc, const char **argv)
@@ -41,7 +43,7 @@ int main(int argc, const char **argv)
 	int entries, i;
 
 	git_config(git_diff_config);
-	diff_setup(&diff_options);
+	diff_setup(&rev.diffopt);
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "--")) {
 			argv++;
@@ -74,7 +76,7 @@ int main(int argc, const char **argv)
 			dense_combined_merges = combine_merges = 1;
 		else {
 			int diff_opt_cnt;
-			diff_opt_cnt = diff_opt_parse(&diff_options,
+			diff_opt_cnt = diff_opt_parse(&rev.diffopt,
 						      argv+1, argc-1);
 			if (diff_opt_cnt < 0)
 				usage(diff_files_usage);
@@ -89,13 +91,13 @@ int main(int argc, const char **argv)
 		argv++; argc--;
 	}
 	if (dense_combined_merges)
-		diff_options.output_format = DIFF_FORMAT_PATCH;
+		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 
 	/* Find the directory, and set up the pathspec */
 	pathspec = get_pathspec(prefix, argv + 1);
 	entries = read_cache();
 
-	if (diff_setup_done(&diff_options) < 0)
+	if (diff_setup_done(&rev.diffopt) < 0)
 		usage(diff_files_usage);
 
 	/* At this point, if argc == 1, then we are doing everything.
@@ -167,8 +169,7 @@ int main(int argc, const char **argv)
 			if (combine_merges && num_compare_stages == 2) {
 				show_combined_diff(&combine.p, 2,
 						   dense_combined_merges,
-						   NULL,
-						   &diff_options);
+						   &rev);
 				free(combine.p.path);
 				continue;
 			}
@@ -194,7 +195,7 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		changed = ce_match_stat(ce, &st, 0);
-		if (!changed && !diff_options.find_copies_harder)
+		if (!changed && !rev.diffopt.find_copies_harder)
 			continue;
 		oldmode = ntohl(ce->ce_mode);
 
@@ -207,7 +208,7 @@ int main(int argc, const char **argv)
 			      ce->sha1, (changed ? null_sha1 : ce->sha1),
 			      ce->name);
 	}
-	diffcore_std(&diff_options);
-	diff_flush(&diff_options);
+	diffcore_std(&rev.diffopt);
+	diff_flush(&rev.diffopt);
 	return 0;
 }
diff --git a/diff-tree.c b/diff-tree.c
index e578798..7207867 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -71,6 +71,7 @@ int main(int argc, const char **argv)
 	nr_sha1 = 0;
 	init_revisions(opt);
 	opt->abbrev = 0;
+	opt->diff = 1;
 	argc = setup_revisions(argc, argv, opt, NULL);
 
 	while (--argc > 0) {
diff --git a/diff.h b/diff.h
index f783bae..52fff66 100644
--- a/diff.h
+++ b/diff.h
@@ -6,6 +6,7 @@ #define DIFF_H
 
 #include "tree-walk.h"
 
+struct rev_info;
 struct diff_options;
 
 typedef void (*change_fn_t)(struct diff_options *options,
@@ -70,11 +71,10 @@ #define combine_diff_path_size(n, l) \
 	(sizeof(struct combine_diff_path) + \
 	 sizeof(struct combine_diff_parent) * (n) + (l) + 1)
 
-extern int show_combined_diff(struct combine_diff_path *elem, int num_parent,
-			      int dense, const char *header,
-			      struct diff_options *);
+extern void show_combined_diff(struct combine_diff_path *elem, int num_parent,
+			      int dense, struct rev_info *);
 
-extern const char *diff_tree_combined_merge(const unsigned char *sha1, const char *, int, struct diff_options *opt);
+extern void diff_tree_combined_merge(const unsigned char *sha1, int, struct rev_info *);
 
 extern void diff_addremove(struct diff_options *,
 			   int addremove,
diff --git a/git.c b/git.c
index fc4e429..016fa30 100644
--- a/git.c
+++ b/git.c
@@ -282,75 +282,22 @@ static int cmd_log_wc(int argc, const ch
 		      struct rev_info *rev)
 {
 	struct commit *commit;
-	char *buf = xmalloc(LOGSIZE);
-	const char *commit_prefix = "commit ";
-	int shown = 0;
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
+	rev->verbose_header = 1;
 	argc = setup_revisions(argc, argv, rev, "HEAD");
 
 	if (argc > 1)
 		die("unrecognized argument: %s", argv[1]);
-	if (rev->commit_format == CMIT_FMT_ONELINE)
-		commit_prefix = "";
 
 	prepare_revision_walk(rev);
 	setup_pager();
 	while ((commit = get_revision(rev)) != NULL) {
-		unsigned long ofs = 0;
-
-		if (shown && rev->diff &&
-		    rev->commit_format != CMIT_FMT_ONELINE)
-			putchar('\n');
-
-		ofs = sprintf(buf, "%s", commit_prefix);
-		if (rev->abbrev_commit && rev->abbrev)
-			ofs += sprintf(buf + ofs, "%s",
-				       find_unique_abbrev(commit->object.sha1,
-							  rev->abbrev));
-		else
-			ofs += sprintf(buf + ofs, "%s",
-				       sha1_to_hex(commit->object.sha1));
-		if (rev->parents) {
-			struct commit_list *parents = commit->parents;
-			while (parents) {
-				struct object *o = &(parents->item->object);
-				parents = parents->next;
-				if (o->flags & TMP_MARK)
-					continue;
-				ofs += sprintf(buf + ofs, " %s",
-					       sha1_to_hex(o->sha1));
-				o->flags |= TMP_MARK;
-			}
-			/* TMP_MARK is a general purpose flag that can
-			 * be used locally, but the user should clean
-			 * things up after it is done with them.
-			 */
-			for (parents = commit->parents;
-			     parents;
-			     parents = parents->next)
-				parents->item->object.flags &= ~TMP_MARK;
-		}
-		buf[ofs++] = 
-			(rev->commit_format == CMIT_FMT_ONELINE) ? ' ' : '\n';
-		ofs += pretty_print_commit(rev->commit_format, commit, ~0,
-					   buf + ofs,
-					   LOGSIZE - ofs - 20,
-					   rev->abbrev);
-
-		if (rev->diff) {
-			rev->use_precomputed_header = buf;
-			strcpy(buf + ofs, "\n---\n");
-			log_tree_commit(rev, commit);
-		}
-		else
-			printf("%s\n", buf);
-		shown = 1;
+		log_tree_commit(rev, commit);
 		free(commit->buffer);
 		commit->buffer = NULL;
 	}
-	free(buf);
 	return 0;
 }
 
diff --git a/log-tree.c b/log-tree.c
index af36f70..c0a4432 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,11 +1,51 @@
+
 #include "cache.h"
 #include "diff.h"
 #include "commit.h"
 #include "log-tree.h"
 
+void show_log(struct rev_info *opt, struct log_info *log, const char *sep)
+{
+	static char this_header[16384];
+	struct commit *commit = log->commit, *parent = log->parent;
+	int abbrev = opt->diffopt.abbrev;
+	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
+	int len;
+
+	opt->loginfo = NULL;
+	if (!opt->verbose_header) {
+		puts(sha1_to_hex(commit->object.sha1));
+		return;
+	}
+
+	/*
+	 * Whitespace between commit messages, unless we are oneline
+	 */
+	if (opt->shown_one && opt->commit_format != CMIT_FMT_ONELINE)
+		putchar('\n');
+	opt->shown_one = 1;
+
+	/*
+	 * Print header line of header..
+	 */
+	printf("%s%s",
+		opt->commit_format == CMIT_FMT_ONELINE ? "" : "commit ",
+		diff_unique_abbrev(commit->object.sha1, abbrev_commit));
+	if (parent) 
+		printf(" (from %s)", diff_unique_abbrev(parent->object.sha1, abbrev_commit));
+	putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
+
+	/*
+	 * And then the pretty-printed message itself
+	 */
+	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header, sizeof(this_header), abbrev);
+	printf("%s%s", this_header, sep);
+}
+
 int log_tree_diff_flush(struct rev_info *opt)
 {
 	diffcore_std(&opt->diffopt);
+
 	if (diff_queue_is_empty()) {
 		int saved_fmt = opt->diffopt.output_format;
 		opt->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -13,12 +53,9 @@ int log_tree_diff_flush(struct rev_info 
 		opt->diffopt.output_format = saved_fmt;
 		return 0;
 	}
-	if (opt->header) {
-		if (!opt->no_commit_id)
-			printf("%s%c", opt->header,
-			       opt->diffopt.line_termination);
-		opt->header = NULL;
-	}
+
+	if (opt->loginfo && !opt->no_commit_id)
+		show_log(opt, opt->loginfo, "\n");
 	diff_flush(&opt->diffopt);
 	return 1;
 }
@@ -43,96 +80,78 @@ static int diff_root_tree(struct rev_inf
 	return retval;
 }
 
-static const char *get_header(struct rev_info *opt,
-				   const unsigned char *commit_sha1,
-				   const unsigned char *parent_sha1,
-				   const struct commit *commit)
-{
-	static char this_header[16384];
-	int offset;
-	unsigned long len;
-	int abbrev = opt->diffopt.abbrev;
-	const char *msg = commit->buffer;
-
-	if (opt->use_precomputed_header)
-		return opt->use_precomputed_header;
-
-	if (!opt->verbose_header)
-		return sha1_to_hex(commit_sha1);
-
-	len = strlen(msg);
-
-	offset = sprintf(this_header, "%s%s ",
-			 opt->header_prefix,
-			 diff_unique_abbrev(commit_sha1, abbrev));
-	if (commit_sha1 != parent_sha1)
-		offset += sprintf(this_header + offset, "(from %s)\n",
-				  parent_sha1
-				  ? diff_unique_abbrev(parent_sha1, abbrev)
-				  : "root");
-	else
-		offset += sprintf(this_header + offset, "(from parents)\n");
-	offset += pretty_print_commit(opt->commit_format, commit, len,
-				      this_header + offset,
-				      sizeof(this_header) - offset, abbrev);
-	return this_header;
-}
-
-static const char *generate_header(struct rev_info *opt,
-					const unsigned char *commit_sha1,
-					const unsigned char *parent_sha1,
-					const struct commit *commit)
-{
-	const char *header = get_header(opt, commit_sha1, parent_sha1, commit);
-
-	if (opt->always_show_header) {
-		puts(header);
-		header = NULL;
-	}
-	return header;
-}
-
 static int do_diff_combined(struct rev_info *opt, struct commit *commit)
 {
 	unsigned const char *sha1 = commit->object.sha1;
 
-	opt->header = generate_header(opt, sha1, sha1, commit);
-	opt->header = diff_tree_combined_merge(sha1, opt->header,
-						opt->dense_combined_merges,
-						&opt->diffopt);
-	if (!opt->header && opt->verbose_header)
-		opt->header_prefix = "\ndiff-tree ";
-	return 0;
+	diff_tree_combined_merge(sha1, opt->dense_combined_merges, opt);
+	return !opt->loginfo;
 }
 
-int log_tree_commit(struct rev_info *opt, struct commit *commit)
+/*
+ * Show the diff of a commit.
+ *
+ * Return true if we printed any log info messages
+ */
+static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log_info *log)
 {
+	int showed_log;
 	struct commit_list *parents;
 	unsigned const char *sha1 = commit->object.sha1;
 
+	if (!opt->diff)
+		return 0;
+
 	/* Root commit? */
-	if (opt->show_root_diff && !commit->parents) {
-		opt->header = generate_header(opt, sha1, NULL, commit);
-		diff_root_tree(opt, sha1, "");
+	parents = commit->parents;
+	if (!parents) {
+		if (opt->show_root_diff)
+			diff_root_tree(opt, sha1, "");
+		return !opt->loginfo;
 	}
 
 	/* More than one parent? */
-	if (commit->parents && commit->parents->next) {
+	if (parents && parents->next) {
 		if (opt->ignore_merges)
 			return 0;
 		else if (opt->combine_merges)
 			return do_diff_combined(opt, commit);
+
+		/* If we show individual diffs, show the parent info */
+		log->parent = parents->item;
 	}
 
-	for (parents = commit->parents; parents; parents = parents->next) {
+	showed_log = 0;
+	for (;;) {
 		struct commit *parent = parents->item;
-		unsigned const char *psha1 = parent->object.sha1;
-		opt->header = generate_header(opt, sha1, psha1, commit);
-		diff_tree_sha1(psha1, sha1, "", &opt->diffopt);
-		log_tree_diff_flush(opt);		
 
-		if (!opt->header && opt->verbose_header)
-			opt->header_prefix = "\ndiff-tree ";
+		diff_tree_sha1(parent->object.sha1, sha1, "", &opt->diffopt);
+		log_tree_diff_flush(opt);
+
+		showed_log |= !opt->loginfo;
+
+		/* Set up the log info for the next parent, if any.. */
+		parents = parents->next;
+		if (!parents)
+			break;
+		log->parent = parents->item;
+		opt->loginfo = log;
+	}
+	return showed_log;
+}
+
+int log_tree_commit(struct rev_info *opt, struct commit *commit)
+{
+	struct log_info log;
+
+	log.commit = commit;
+	log.parent = NULL;
+	opt->loginfo = &log;
+
+	if (!log_tree_diff(opt, commit, &log) && opt->loginfo && opt->always_show_header) {
+		log.parent = NULL;
+		show_log(opt, opt->loginfo, "");
 	}
+	opt->loginfo = NULL;
 	return 0;
 }
diff --git a/log-tree.h b/log-tree.h
index 91a909b..a26e484 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -3,9 +3,14 @@ #define LOG_TREE_H
 
 #include "revision.h"
 
+struct log_info {
+	struct commit *commit, *parent;
+};
+
 void init_log_tree_opt(struct rev_info *);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 int log_tree_opt_parse(struct rev_info *, const char **, int);
+void show_log(struct rev_info *opt, struct log_info *log, const char *sep);
 
 #endif
diff --git a/rev-list.c b/rev-list.c
index b75da12..099373c 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -41,13 +41,14 @@ struct rev_info revs;
 static int bisect_list = 0;
 static int show_timestamp = 0;
 static int hdr_termination = 0;
+static const char *header_prefix;
 
 static void show_commit(struct commit *commit)
 {
 	if (show_timestamp)
 		printf("%lu ", commit->date);
-	if (*revs.header_prefix)
-		fputs(revs.header_prefix, stdout);
+	if (header_prefix)
+		fputs(header_prefix, stdout);
 	if (commit->object.flags & BOUNDARY)
 		putchar('-');
 	if (revs.abbrev_commit && revs.abbrev)
@@ -322,9 +323,9 @@ int main(int argc, const char **argv)
 		/* The command line has a --pretty  */
 		hdr_termination = '\n';
 		if (revs.commit_format == CMIT_FMT_ONELINE)
-			revs.header_prefix = "";
+			header_prefix = "";
 		else
-			revs.header_prefix = "commit ";
+			header_prefix = "commit ";
 	}
 
 	list = revs.commits;
diff --git a/revision.c b/revision.c
index 3cd6a2e..2976497 100644
--- a/revision.c
+++ b/revision.c
@@ -498,7 +498,6 @@ void init_revisions(struct rev_info *rev
 	revs->topo_setter = topo_sort_default_setter;
 	revs->topo_getter = topo_sort_default_getter;
 
-	revs->header_prefix = "";
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
 	diff_setup(&revs->diffopt);
@@ -675,12 +674,10 @@ int setup_revisions(int argc, const char
 			}
 			if (!strcmp(arg, "-v")) {
 				revs->verbose_header = 1;
-				revs->header_prefix = "diff-tree ";
 				continue;
 			}
 			if (!strncmp(arg, "--pretty", 8)) {
 				revs->verbose_header = 1;
-				revs->header_prefix = "diff-tree ";
 				revs->commit_format = get_commit_format(arg+8);
 				continue;
 			}
diff --git a/revision.h b/revision.h
index 872bcd8..48d7b4c 100644
--- a/revision.h
+++ b/revision.h
@@ -11,6 +11,7 @@ #define BOUNDARY_SHOW	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 
 struct rev_info;
+struct log_info;
 
 typedef void (prune_fn_t)(struct rev_info *revs, struct commit *commit);
 
@@ -52,12 +53,11 @@ struct rev_info {
 			always_show_header:1;
 
 	/* Format info */
-	unsigned int	abbrev_commit:1;
+	unsigned int	shown_one:1,
+			abbrev_commit:1;
 	unsigned int	abbrev;
 	enum cmit_fmt	commit_format;
-	const char	*header_prefix;
-	const char	*header;
-	const char	*use_precomputed_header;
+	struct log_info *loginfo;
 
 	/* special limits */
 	int max_count;
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 1002413..16b3ea9 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -49,7 +49,7 @@ #rm hello
 #test_expect_success 'git-read-tree --reset HEAD' "git-read-tree --reset HEAD ; test \"hello: needs update\" = \"$(git-update-index --refresh)\""
 
 cat > whatchanged.expect << EOF
-diff-tree VARIABLE (from root)
+commit VARIABLE
 Author: VARIABLE
 Date:   VARIABLE
 
@@ -72,7 +72,7 @@ index 0000000..557db03
 EOF
 
 git-whatchanged -p --root | \
-	sed -e "1s/^\(.\{10\}\).\{40\}/\1VARIABLE/" \
+	sed -e "1s/^\(.\{7\}\).\{40\}/\1VARIABLE/" \
 		-e "2,3s/^\(.\{8\}\).*$/\1VARIABLE/" \
 > whatchanged.output
 test_expect_success 'git-whatchanged -p --root' 'cmp whatchanged.expect whatchanged.output'
