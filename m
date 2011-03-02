From: Jeff King <peff@peff.net>
Subject: [RFC] git blame-tree
Date: Wed, 2 Mar 2011 11:40:32 -0500
Message-ID: <20110302164031.GA18233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 17:40:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pup6T-0003nw-0W
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 17:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022Ab1CBQkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 11:40:40 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:36056 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755952Ab1CBQki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 11:40:38 -0500
Received: (qmail 18650 invoked by uid 111); 2 Mar 2011 16:40:36 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 16:40:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 11:40:32 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168323>

[I know, I know, another RFC. I'll get to actually cleaning up and
submitting some of these patches soon.]

It's sometimes useful to get a list of files in a tree along with the
last commit that touched them. This is the default tree view shown on
github.com, but it can also be handy from the command line (there has
been talk lately of having a "git ls"), or as plumbing for a local
fancier tree view. E.g., something like:

     add.c 6e7293e git-add: make -A description clearer vs. -u
   apply.c fd03881 add description parameter to OPT__VERBOSE
   blame.c 9ca1169 parse-options: Don't call parse_options_check() so much
  branch.c 62270f6 branch_merged: fix grammar in warning
  bundle.c 62b4698 Use angles for placeholders consistently

The obvious naive way to do this is something like:

  for i in `git ls-tree --name-only HEAD`; do
    echo "`git rev-list -1 --no-merges HEAD -- $i` $i";
  done

which is really slow, because we end up traversing the same commits many
times (plus the startup overhead for each rev-list).  It takes about 35
seconds to run on git.git.

So the next obvious thing is to do one traversal, output the changed
files for each commit, and then mark each file as you see it. The perl
script below does this (though the careful reader will note it is
actually buggy with sub-trees; I didn't bother fixing it since it was
just a stage in the evolution):

-- >8 --
#!/usr/bin/perl

my $tree = shift;
my @revs = @ARGV;

my @files = `git ls-tree --name-only $tree`;
chomp @files;
my $num_interesting = @files;

open(my $fh, '-|', join(' ',
        "git rev-list --no-merges",
        @revs,
        "| git diff-tree --stdin --name-status")
) or die "unable to run rev-list: $!";

my %last = map { $_ => undef } @files;
while($num_interesting and $_ = <$fh>) {
        if (/^[0-9a-f]{40}$/) {
                $sha1 = $&;
        }
        elsif (/^.\t(.*)/) {
                next unless exists $last{$1};
                next if defined $last{$1};
                $last{$1} = $sha1;
                $num_interesting--;
        }
}

foreach my $file (sort keys(%last)) {
        print "$last{$file} $file\n";
}
-- 8< --

This runs in about 3 seconds. And besides the above-mentioned bug,
also doesn't properly handle things like filenames that need quoting.

So I wrote it in C, which drops the time down to about 1.5 seconds, and
of course doesn't have any parsing issues.  The patch is below.

I wasn't sure at first what to call it or what the calling conventions
should be. The initial thought was to make it part of "ls-tree". But
that feels wrong, as ls-tree otherwise never cares about traversal. The
combination of traversal and diff made me think of blame, and indeed, I
think this is really just about blaming a whole tree at the file-level,
rather than at the content-level. Thus I called it blame-tree, and I
used the same calling conventions as blame: "git blame-tree <path>
<rev opts>". See the test script for examples.

I have many thoughts on the patch already, but rather than put them
here, I'll include the patch without further ado, and put them inline in
a reply.

---
 .gitignore            |    1 +
 Makefile              |    3 +
 blame-tree.c          |  156 +++++++++++++++++++++++++++++++++++++++++++++++++
 blame-tree.h          |   25 ++++++++
 builtin.h             |    1 +
 builtin/blame-tree.c  |   34 +++++++++++
 git.c                 |    1 +
 t/t8010-blame-tree.sh |   90 ++++++++++++++++++++++++++++
 8 files changed, 311 insertions(+), 0 deletions(-)
 create mode 100644 blame-tree.c
 create mode 100644 blame-tree.h
 create mode 100644 builtin/blame-tree.c
 create mode 100755 t/t8010-blame-tree.sh

diff --git a/.gitignore b/.gitignore
index c460c66..20c6501 100644
--- a/.gitignore
+++ b/.gitignore
@@ -14,6 +14,7 @@
 /git-bisect
 /git-bisect--helper
 /git-blame
+/git-blame-tree
 /git-branch
 /git-bundle
 /git-cat-file
diff --git a/Makefile b/Makefile
index ade7923..918ce1a 100644
--- a/Makefile
+++ b/Makefile
@@ -494,6 +494,7 @@ VCSSVN_LIB=vcs-svn/lib.a
 LIB_H += advice.h
 LIB_H += archive.h
 LIB_H += attr.h
+LIB_H += blame-tree.h
 LIB_H += blob.h
 LIB_H += builtin.h
 LIB_H += cache.h
@@ -571,6 +572,7 @@ LIB_OBJS += archive-zip.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
+LIB_OBJS += blame-tree.o
 LIB_OBJS += blob.o
 LIB_OBJS += branch.o
 LIB_OBJS += bundle.o
@@ -683,6 +685,7 @@ BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
 BUILTIN_OBJS += builtin/bisect--helper.o
 BUILTIN_OBJS += builtin/blame.o
+BUILTIN_OBJS += builtin/blame-tree.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bundle.o
 BUILTIN_OBJS += builtin/cat-file.o
diff --git a/blame-tree.c b/blame-tree.c
new file mode 100644
index 0000000..79ceb7e
--- /dev/null
+++ b/blame-tree.c
@@ -0,0 +1,156 @@
+#include "cache.h"
+#include "blame-tree.h"
+#include "commit.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
+
+void blame_tree_init(struct blame_tree *bt)
+{
+	memset(bt, 0, sizeof(*bt));
+	bt->paths.strdup_strings = 1;
+	init_revisions(&bt->rev, NULL);
+	bt->rev.no_merges = 1;
+	bt->rev.def = "HEAD";
+}
+
+void blame_tree_release(struct blame_tree *bt)
+{
+	string_list_clear(&bt->paths, 0);
+	free(bt->prefix);
+}
+
+static int add_path(const unsigned char *sha1, const char *base, int baselen,
+		    const char *name, unsigned mode, int stage, void *data)
+{
+	struct string_list *paths = data;
+	string_list_append(paths, name);
+	return 0;
+}
+
+static int add_from_revs(struct blame_tree *bt)
+{
+	struct object_array_entry *obj;
+	unsigned char sha1[20];
+	unsigned mode;
+	struct tree *tree;
+
+	if (!bt->rev.pending.nr)
+		return error("no revisions specified");
+
+	obj = bt->rev.pending.objects;
+	if (get_tree_entry(obj->item->sha1, bt->prefix, sha1, &mode) < 0)
+		return error("no such path: %s:%s", obj->name, bt->prefix);
+
+	tree = parse_tree_indirect(sha1);
+	if (!tree)
+		return error("not a tree: %s:%s", obj->name, bt->prefix);
+
+	if (read_tree_recursive(tree, "", 0, 0, NULL, add_path, &bt->paths) < 0)
+		return error("unable to read tree object");
+
+	sort_string_list(&bt->paths);
+	return 0;
+}
+
+void blame_tree_set_path(struct blame_tree *bt, const char *path,
+			 const char *prefix)
+{
+	if (!path) {
+		bt->prefix = xstrdup("");
+		return;
+	}
+	bt->prefix = prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
+}
+
+void blame_tree_set_revs(struct blame_tree *bt, int argc, const char **argv)
+{
+	setup_revisions(argc, argv, &bt->rev, NULL);
+}
+
+struct blame_tree_callback_data {
+	struct commit *commit;
+	struct string_list *paths;
+	int num_interesting;
+
+	blame_tree_callback callback;
+	void *callback_data;
+};
+
+static void process_diff(struct diff_queue_struct *q,
+			 struct diff_options *opt, void *cbdata)
+{
+	struct blame_tree_callback_data *data = cbdata;
+	int i;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		const char *path = p->one->path;
+		struct string_list_item *item;
+
+		item = string_list_lookup(data->paths, path);
+		/* Not an interesting path to us */
+		if (!item)
+			continue;
+		/* We already found its latest commit */
+		if (item->util)
+			continue;
+
+		item->util = data->commit;
+		data->num_interesting--;
+		if (data->callback)
+			data->callback(path, data->commit, data->callback_data);
+	}
+}
+
+int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
+{
+	struct blame_tree_callback_data data;
+	struct commit *commit;
+
+	if (add_from_revs(bt) < 0)
+		return -1;
+
+	data.paths = &bt->paths;
+	data.num_interesting = bt->paths.nr;
+	data.callback = cb;
+	data.callback_data = cbdata;
+
+	bt->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	bt->rev.diffopt.format_callback = process_diff;
+	bt->rev.diffopt.format_callback_data = &data;
+	diff_setup_done(&bt->rev.diffopt);
+
+	prepare_revision_walk(&bt->rev);
+
+	while (data.num_interesting > 0 &&
+	       (commit = get_revision(&bt->rev)) != NULL) {
+		unsigned char to_sha1[20];
+		unsigned mode;
+
+		if (get_tree_entry(commit->object.sha1, bt->prefix,
+				   to_sha1, &mode) < 0)
+			continue;
+
+		data.commit = commit;
+
+		if (commit->parents) {
+			struct commit_list *p;
+			for (p = commit->parents; p; p = p->next) {
+				unsigned char from_sha1[20];
+				if (get_tree_entry(p->item->object.sha1,
+						   bt->prefix,
+						   from_sha1, &mode) < 0)
+					diff_root_tree_sha1(to_sha1, "",
+							    &bt->rev.diffopt);
+				else
+					diff_tree_sha1(from_sha1, to_sha1,
+						       "", &bt->rev.diffopt);
+			}
+		}
+		else
+			diff_root_tree_sha1(to_sha1, "", &bt->rev.diffopt);
+		diff_flush(&bt->rev.diffopt);
+	}
+	return 0;
+}
diff --git a/blame-tree.h b/blame-tree.h
new file mode 100644
index 0000000..c39f203
--- /dev/null
+++ b/blame-tree.h
@@ -0,0 +1,25 @@
+#ifndef BLAME_TREE_H
+#define BLAME_TREE_H
+
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+#include "string-list.h"
+
+struct blame_tree {
+	struct string_list paths;
+	char *prefix;
+	struct rev_info rev;
+};
+
+void blame_tree_init(struct blame_tree *);
+void blame_tree_release(struct blame_tree *);
+
+void blame_tree_set_path(struct blame_tree *, const char *path,
+			 const char *prefix);
+void blame_tree_set_revs(struct blame_tree *, int argc, const char **argv);
+
+typedef void (*blame_tree_callback)(const char *, const struct commit *, void *);
+int blame_tree_run(struct blame_tree *, blame_tree_callback, void *);
+
+#endif /* BLAME_TREE_H */
diff --git a/builtin.h b/builtin.h
index 0e9da90..01f7842 100644
--- a/builtin.h
+++ b/builtin.h
@@ -143,5 +143,6 @@ extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 extern int cmd_replace(int argc, const char **argv, const char *prefix);
+extern int cmd_blame_tree(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/builtin/blame-tree.c b/builtin/blame-tree.c
new file mode 100644
index 0000000..3f580c6
--- /dev/null
+++ b/builtin/blame-tree.c
@@ -0,0 +1,34 @@
+#include "cache.h"
+#include "blame-tree.h"
+#include "quote.h"
+#include "parse-options.h"
+
+static void show_entry(const char *path, const struct commit *commit, void *d)
+{
+	printf("%s\t", sha1_to_hex(commit->object.sha1));
+	write_name_quoted(path, stdout, '\n');
+	fflush(stdout);
+}
+
+int cmd_blame_tree(int argc, const char **argv, const char *prefix)
+{
+	struct blame_tree bt;
+	const char *path = NULL;
+
+	git_config(git_default_config, NULL);
+
+	if (argv[1]) {
+		path = argv[1];
+		argc--;
+		argv++;
+	}
+
+	blame_tree_init(&bt);
+	blame_tree_set_path(&bt, path, prefix);
+	blame_tree_set_revs(&bt, argc, argv);
+	if (blame_tree_run(&bt, show_entry, NULL) < 0)
+		die("error running blame-tree traversal");
+	blame_tree_release(&bt);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index ef598c3..54ad91d 100644
--- a/git.c
+++ b/git.c
@@ -318,6 +318,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "archive", cmd_archive },
 		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE },
 		{ "blame", cmd_blame, RUN_SETUP },
+		{ "blame-tree", cmd_blame_tree, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
diff --git a/t/t8010-blame-tree.sh b/t/t8010-blame-tree.sh
new file mode 100755
index 0000000..21833f3
--- /dev/null
+++ b/t/t8010-blame-tree.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+
+test_description='basic blame-tree tests'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit 1 file &&
+	mkdir sub &&
+	test_commit 2 sub/file &&
+	mkdir -p deep/sub/nesting &&
+	test_commit 3 deep/sub/nesting/file
+'
+
+cat >expect.root <<'EOF'
+1 file
+2 sub
+3 deep
+EOF
+
+echo 2 file >expect.sub
+echo 3 sub >expect.deep
+echo 3 nesting >expect.deep.sub
+echo 3 file >expect.deep.sub.nesting
+
+check() {
+	expect=$1; shift
+	git blame-tree "$@" >actual &&
+	git name-rev --stdin --name-only --tags <actual >tmp &&
+	mv tmp actual &&
+	tr '\t' ' ' <actual >tmp &&
+	mv tmp actual &&
+	sort <actual >tmp &&
+	mv tmp actual &&
+	test_cmp "$expect" actual
+}
+
+test_expect_success 'blame root' '
+	check expect.root . HEAD
+'
+
+test_expect_success 'blame subdir' '
+	check expect.sub sub HEAD
+'
+
+test_expect_success 'blame nested subdirs' '
+	check expect.deep deep HEAD &&
+	check expect.deep.sub deep/sub HEAD &&
+	check expect.deep.sub.nesting deep/sub/nesting
+'
+
+test_expect_success 'assume HEAD if no rev opts' '
+	check expect.root .
+'
+
+test_expect_success 'assume root if no path opt' '
+	check expect.root
+'
+
+test_expect_success 'blame from older revision' '
+	echo 1 file >expect &&
+	check expect . HEAD~2
+'
+
+test_expect_success 'rev limiting works' '
+	echo 3 deep >expect &&
+	check expect . -1
+'
+
+test_expect_success 'complaint about a bogus path' '
+	test_must_fail git blame-tree bogus HEAD
+'
+
+test_expect_success 'complain about a non-tree' '
+	test_must_fail git blame-tree file HEAD
+'
+
+test_expect_success 'blame from subdir defaults to root' '
+	(cd deep &&
+	 check ../expect.root
+	)
+'
+
+test_expect_success 'blame from subdir uses relative paths' '
+	(cd deep &&
+	 check ../expect.deep . &&
+	 check ../expect.deep.sub sub
+	)
+'
+
+test_done
-- 
1.7.4.rc1.11.g1c440
