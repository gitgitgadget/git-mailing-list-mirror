From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] log-tree: separate major part of diff-tree.
Date: Sun, 09 Apr 2006 02:03:29 -0700
Message-ID: <7vd5frce8u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 11:03:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSVpl-0004gJ-Q0
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 11:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWDIJDc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 05:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWDIJDc
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 05:03:32 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:48826 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750703AbWDIJDb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 05:03:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060409090330.FXLJ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Apr 2006 05:03:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18542>

This separates out the part that deals with one-commit diff-tree
(and --stdin form) into a separate log-tree module.

There are two goals with this.  The more important one is to be
able to make this part available to "git log --diff", so that we
can have a native "git whatchanged" command.  Another is to
simplify the commit log generation part simpler.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I tried to be very careful while doing this, to make sure
   there is no behaviour change.  This is a preparation step for
   the next one, which is...

 Makefile    |    4 +
 diff-tree.c |  226 ++++++-----------------------------------------------------
 log-tree.c  |  175 ++++++++++++++++++++++++++++++++++++++++++++++
 log-tree.h  |   23 ++++++
 4 files changed, 224 insertions(+), 204 deletions(-)
 create mode 100644 log-tree.c
 create mode 100644 log-tree.h

5f1c3f07b7f4a8436c7773b8e7a04998190c125e
diff --git a/Makefile b/Makefile
index 6b10eaa..b272146 100644
--- a/Makefile
+++ b/Makefile
@@ -194,12 +194,12 @@ LIB_H = \
 	blob.h cache.h commit.h csum-file.h delta.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
-	tree-walk.h
+	tree-walk.h log-tree.h
 
 DIFF_OBJS = \
 	diff.o diffcore-break.o diffcore-order.o diffcore-pathspec.o \
 	diffcore-pickaxe.o diffcore-rename.o tree-diff.o combine-diff.o \
-	diffcore-delta.o
+	diffcore-delta.o log-tree.o
 
 LIB_OBJS = \
 	blob.o commit.o connect.o csum-file.o \
diff --git a/diff-tree.c b/diff-tree.c
index d1265d7..2a088d1 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -1,152 +1,16 @@
 #include "cache.h"
 #include "diff.h"
 #include "commit.h"
+#include "log-tree.h"
 
-static int show_root_diff = 0;
-static int no_commit_id = 0;
-static int verbose_header = 0;
-static int ignore_merges = 1;
-static int combine_merges = 0;
-static int dense_combined_merges = 0;
-static int read_stdin = 0;
-static int always_show_header = 0;
+static struct log_tree_opt log_tree_opt;
 
-static const char *header = NULL;
-static const char *header_prefix = "";
-static enum cmit_fmt commit_format = CMIT_FMT_RAW;
-
-static struct diff_options diff_options;
-
-static int call_diff_flush(void)
-{
-	diffcore_std(&diff_options);
-	if (diff_queue_is_empty()) {
-		int saved_fmt = diff_options.output_format;
-		diff_options.output_format = DIFF_FORMAT_NO_OUTPUT;
-		diff_flush(&diff_options);
-		diff_options.output_format = saved_fmt;
-		return 0;
-	}
-	if (header) {
-		if (!no_commit_id)
-			printf("%s%c", header, diff_options.line_termination);
-		header = NULL;
-	}
-	diff_flush(&diff_options);
-	return 1;
-}
-
-static int diff_tree_sha1_top(const unsigned char *old,
-			      const unsigned char *new, const char *base)
-{
-	int ret;
-
-	ret = diff_tree_sha1(old, new, base, &diff_options);
-	call_diff_flush();
-	return ret;
-}
-
-static int diff_root_tree(const unsigned char *new, const char *base)
-{
-	int retval;
-	void *tree;
-	struct tree_desc empty, real;
-
-	tree = read_object_with_reference(new, tree_type, &real.size, NULL);
-	if (!tree)
-		die("unable to read root tree (%s)", sha1_to_hex(new));
-	real.buf = tree;
-
-	empty.buf = "";
-	empty.size = 0;
-	retval = diff_tree(&empty, &real, base, &diff_options);
-	free(tree);
-	call_diff_flush();
-	return retval;
-}
-
-static const char *generate_header(const unsigned char *commit_sha1,
-				   const unsigned char *parent_sha1,
-				   const struct commit *commit)
-{
-	static char this_header[16384];
-	int offset;
-	unsigned long len;
-	int abbrev = diff_options.abbrev;
-	const char *msg = commit->buffer;
-
-	if (!verbose_header)
-		return sha1_to_hex(commit_sha1);
-
-	len = strlen(msg);
-
-	offset = sprintf(this_header, "%s%s ",
-			 header_prefix,
-			 diff_unique_abbrev(commit_sha1, abbrev));
-	if (commit_sha1 != parent_sha1)
-		offset += sprintf(this_header + offset, "(from %s)\n",
-				  parent_sha1
-				  ? diff_unique_abbrev(parent_sha1, abbrev)
-				  : "root");
-	else
-		offset += sprintf(this_header + offset, "(from parents)\n");
-	offset += pretty_print_commit(commit_format, commit, len,
-				      this_header + offset,
-				      sizeof(this_header) - offset, abbrev);
-	if (always_show_header) {
-		puts(this_header);
-		return NULL;
-	}
-	return this_header;
-}
-
-static int diff_tree_commit(struct commit *commit)
-{
-	struct commit_list *parents;
-	unsigned const char *sha1 = commit->object.sha1;
-
-	/* Root commit? */
-	if (show_root_diff && !commit->parents) {
-		header = generate_header(sha1, NULL, commit);
-		diff_root_tree(sha1, "");
-	}
-
-	/* More than one parent? */
-	if (commit->parents && commit->parents->next) {
-		if (ignore_merges)
-			return 0;
-		else if (combine_merges) {
-			header = generate_header(sha1, sha1, commit);
-			header = diff_tree_combined_merge(sha1, header,
-							dense_combined_merges,
-							&diff_options);
-			if (!header && verbose_header)
-				header_prefix = "\ndiff-tree ";
-			return 0;
-		}
-	}
-
-	for (parents = commit->parents; parents; parents = parents->next) {
-		struct commit *parent = parents->item;
-		header = generate_header(sha1, parent->object.sha1, commit);
-		diff_tree_sha1_top(parent->object.sha1, sha1, "");
-		if (!header && verbose_header) {
-			header_prefix = "\ndiff-tree ";
-			/*
-			 * Don't print multiple merge entries if we
-			 * don't print the diffs.
-			 */
-		}
-	}
-	return 0;
-}
-
 static int diff_tree_commit_sha1(const unsigned char *sha1)
 {
 	struct commit *commit = lookup_commit_reference(sha1);
 	if (!commit)
 		return -1;
-	return diff_tree_commit(commit);
+	return log_tree_commit(&log_tree_opt, commit);
 }
 
 static int diff_tree_stdin(char *line)
@@ -184,7 +48,7 @@ static int diff_tree_stdin(char *line)
 			pos += 41;
 		}
 	}
-	return diff_tree_commit(commit);
+	return log_tree_commit(&log_tree_opt, commit);
 }
 
 static const char diff_tree_usage[] =
@@ -200,13 +64,15 @@ int main(int argc, const char **argv)
 	char line[1000];
 	unsigned char sha1[2][20];
 	const char *prefix = setup_git_directory();
+	static struct log_tree_opt *opt = &log_tree_opt;
+	int read_stdin = 0;
 
 	git_config(git_diff_config);
 	nr_sha1 = 0;
-	diff_setup(&diff_options);
+	init_log_tree_opt(opt);
 
 	for (;;) {
-		int diff_opt_cnt;
+		int opt_cnt;
 		const char *arg;
 
 		argv++;
@@ -223,84 +89,39 @@ int main(int argc, const char **argv)
 			break;
 		}
 
-		diff_opt_cnt = diff_opt_parse(&diff_options, argv, argc);
-		if (diff_opt_cnt < 0)
+		opt_cnt = log_tree_opt_parse(opt, argv, argc);
+		if (opt_cnt < 0)
 			usage(diff_tree_usage);
-		else if (diff_opt_cnt) {
-			argv += diff_opt_cnt - 1;
-			argc -= diff_opt_cnt - 1;
+		else if (opt_cnt) {
+			argv += opt_cnt - 1;
+			argc -= opt_cnt - 1;
 			continue;
 		}
 
-
 		if (!strcmp(arg, "--")) {
 			argv++;
 			argc--;
 			break;
-		}
-		if (!strcmp(arg, "-r")) {
-			diff_options.recursive = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-t")) {
-			diff_options.recursive = 1;
-			diff_options.tree_in_recursive = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-m")) {
-			ignore_merges = 0;
-			continue;
 		}
-		if (!strcmp(arg, "-c")) {
-			combine_merges = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--cc")) {
-			dense_combined_merges = combine_merges = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-v")) {
-			verbose_header = 1;
-			header_prefix = "diff-tree ";
-			continue;
-		}
-		if (!strncmp(arg, "--pretty", 8)) {
-			verbose_header = 1;
-			header_prefix = "diff-tree ";
-			commit_format = get_commit_format(arg+8);
-			continue;
-		}
 		if (!strcmp(arg, "--stdin")) {
 			read_stdin = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--root")) {
-			show_root_diff = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--no-commit-id")) {
-			no_commit_id = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--always")) {
-			always_show_header = 1;
 			continue;
 		}
 		usage(diff_tree_usage);
 	}
 
-	if (combine_merges)
-		ignore_merges = 0;
+	if (opt->combine_merges)
+		opt->ignore_merges = 0;
 
 	/* We can only do dense combined merges with diff output */
-	if (dense_combined_merges)
-		diff_options.output_format = DIFF_FORMAT_PATCH;
+	if (opt->dense_combined_merges)
+		opt->diffopt.output_format = DIFF_FORMAT_PATCH;
 
-	if (diff_options.output_format == DIFF_FORMAT_PATCH)
-		diff_options.recursive = 1;
+	if (opt->diffopt.output_format == DIFF_FORMAT_PATCH)
+		opt->diffopt.recursive = 1;
 
 	diff_tree_setup_paths(get_pathspec(prefix, argv));
-	diff_setup_done(&diff_options);
+	diff_setup_done(&opt->diffopt);
 
 	switch (nr_sha1) {
 	case 0:
@@ -311,15 +132,16 @@ int main(int argc, const char **argv)
 		diff_tree_commit_sha1(sha1[0]);
 		break;
 	case 2:
-		diff_tree_sha1_top(sha1[0], sha1[1], "");
+		diff_tree_sha1(sha1[0], sha1[1], "", &opt->diffopt);
+		log_tree_diff_flush(opt);
 		break;
 	}
 
 	if (!read_stdin)
 		return 0;
 
-	if (diff_options.detect_rename)
-		diff_options.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
+	if (opt->diffopt.detect_rename)
+		opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
 				       DIFF_SETUP_USE_CACHE);
 	while (fgets(line, sizeof(line), stdin))
 		diff_tree_stdin(line);
diff --git a/log-tree.c b/log-tree.c
new file mode 100644
index 0000000..3d40482
--- /dev/null
+++ b/log-tree.c
@@ -0,0 +1,175 @@
+#include "cache.h"
+#include "diff.h"
+#include "commit.h"
+#include "log-tree.h"
+
+void init_log_tree_opt(struct log_tree_opt *opt)
+{
+	memset(opt, 0, sizeof *opt);
+	opt->ignore_merges = 1;
+	opt->header_prefix = "";
+	opt->commit_format = CMIT_FMT_RAW;
+	diff_setup(&opt->diffopt);
+}
+
+int log_tree_opt_parse(struct log_tree_opt *opt, const char **av, int ac)
+{
+	const char *arg;
+	int cnt = diff_opt_parse(&opt->diffopt, av, ac);
+	if (0 < cnt)
+		return cnt;
+	arg = *av;
+	if (!strcmp(arg, "-r"))
+		opt->diffopt.recursive = 1;
+	else if (!strcmp(arg, "-t")) {
+		opt->diffopt.recursive = 1;
+		opt->diffopt.tree_in_recursive = 1;
+	}
+	else if (!strcmp(arg, "-m"))
+		opt->ignore_merges = 0;
+	else if (!strcmp(arg, "-c"))
+		opt->combine_merges = 1;
+	else if (!strcmp(arg, "--cc")) {
+		opt->dense_combined_merges = 1;
+		opt->combine_merges = 1;
+	}
+	else if (!strcmp(arg, "-v")) {
+		opt->verbose_header = 1;
+		opt->header_prefix = "diff-tree ";
+	}
+	else if (!strncmp(arg, "--pretty", 8)) {
+		opt->verbose_header = 1;
+		opt->header_prefix = "diff-tree ";
+		opt->commit_format = get_commit_format(arg+8);
+	}
+	else if (!strcmp(arg, "--root"))
+		opt->show_root_diff = 1;
+	else if (!strcmp(arg, "--no-commit-id"))
+		opt->no_commit_id = 1;
+	else if (!strcmp(arg, "--always"))
+		opt->always_show_header = 1;
+	else
+		return 0;
+	return 1;
+}
+
+int log_tree_diff_flush(struct log_tree_opt *opt)
+{
+	diffcore_std(&opt->diffopt);
+	if (diff_queue_is_empty()) {
+		int saved_fmt = opt->diffopt.output_format;
+		opt->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
+		diff_flush(&opt->diffopt);
+		opt->diffopt.output_format = saved_fmt;
+		return 0;
+	}
+	if (opt->header) {
+		if (!opt->no_commit_id)
+			printf("%s%c", opt->header,
+			       opt->diffopt.line_termination);
+		opt->header = NULL;
+	}
+	diff_flush(&opt->diffopt);
+	return 1;
+}
+
+static int diff_root_tree(struct log_tree_opt *opt,
+			  const unsigned char *new, const char *base)
+{
+	int retval;
+	void *tree;
+	struct tree_desc empty, real;
+
+	tree = read_object_with_reference(new, tree_type, &real.size, NULL);
+	if (!tree)
+		die("unable to read root tree (%s)", sha1_to_hex(new));
+	real.buf = tree;
+
+	empty.buf = "";
+	empty.size = 0;
+	retval = diff_tree(&empty, &real, base, &opt->diffopt);
+	free(tree);
+	log_tree_diff_flush(opt);
+	return retval;
+}
+
+static const char *generate_header(struct log_tree_opt *opt,
+				   const unsigned char *commit_sha1,
+				   const unsigned char *parent_sha1,
+				   const struct commit *commit)
+{
+	static char this_header[16384];
+	int offset;
+	unsigned long len;
+	int abbrev = opt->diffopt.abbrev;
+	const char *msg = commit->buffer;
+
+	if (!opt->verbose_header)
+		return sha1_to_hex(commit_sha1);
+
+	len = strlen(msg);
+
+	offset = sprintf(this_header, "%s%s ",
+			 opt->header_prefix,
+			 diff_unique_abbrev(commit_sha1, abbrev));
+	if (commit_sha1 != parent_sha1)
+		offset += sprintf(this_header + offset, "(from %s)\n",
+				  parent_sha1
+				  ? diff_unique_abbrev(parent_sha1, abbrev)
+				  : "root");
+	else
+		offset += sprintf(this_header + offset, "(from parents)\n");
+	offset += pretty_print_commit(opt->commit_format, commit, len,
+				      this_header + offset,
+				      sizeof(this_header) - offset, abbrev);
+	if (opt->always_show_header) {
+		puts(this_header);
+		return NULL;
+	}
+	return this_header;
+}
+
+static int do_diff_combined(struct log_tree_opt *opt, struct commit *commit)
+{
+	unsigned const char *sha1 = commit->object.sha1;
+
+	opt->header = generate_header(opt, sha1, sha1, commit);
+	opt->header = diff_tree_combined_merge(sha1, opt->header,
+						opt->dense_combined_merges,
+						&opt->diffopt);
+	if (!opt->header && opt->verbose_header)
+		opt->header_prefix = "\ndiff-tree ";
+	return 0;
+}
+
+int log_tree_commit(struct log_tree_opt *opt, struct commit *commit)
+{
+	struct commit_list *parents;
+	unsigned const char *sha1 = commit->object.sha1;
+
+	/* Root commit? */
+	if (opt->show_root_diff && !commit->parents) {
+		opt->header = generate_header(opt, sha1, NULL, commit);
+		diff_root_tree(opt, sha1, "");
+	}
+
+	/* More than one parent? */
+	if (commit->parents && commit->parents->next) {
+		if (opt->ignore_merges)
+			return 0;
+		else if (opt->combine_merges)
+			return do_diff_combined(opt, commit);
+	}
+
+	for (parents = commit->parents; parents; parents = parents->next) {
+		struct commit *parent = parents->item;
+		unsigned const char *psha1 = parent->object.sha1;
+		opt->header = generate_header(opt, sha1, psha1, commit);
+		diff_tree_sha1(psha1, sha1, "", &opt->diffopt);
+		log_tree_diff_flush(opt);		
+
+		if (!opt->header && opt->verbose_header)
+			opt->header_prefix = "\ndiff-tree ";
+	}
+	return 0;
+}
diff --git a/log-tree.h b/log-tree.h
new file mode 100644
index 0000000..da166c6
--- /dev/null
+++ b/log-tree.h
@@ -0,0 +1,23 @@
+#ifndef LOG_TREE_H
+#define LOG_TREE_H
+
+struct log_tree_opt {
+	struct diff_options diffopt;
+	int show_root_diff;
+	int no_commit_id;
+	int verbose_header;
+	int ignore_merges;
+	int combine_merges;
+	int dense_combined_merges;
+	int always_show_header;
+	const char *header_prefix;
+	const char *header;
+	enum cmit_fmt commit_format;
+};
+
+void init_log_tree_opt(struct log_tree_opt *);
+int log_tree_diff_flush(struct log_tree_opt *);
+int log_tree_commit(struct log_tree_opt *, struct commit *);
+int log_tree_opt_parse(struct log_tree_opt *, const char **, int);
+
+#endif
-- 
1.2.6.gad0b
