From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] add --simplify-combined-diff option
Date: Tue, 29 Jul 2014 08:00:56 -0400
Message-ID: <20140729120056.GA9175@peff.net>
References: <20140729115334.GA8976@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 14:01:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC65a-0007o0-Rr
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 14:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbaG2MBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 08:01:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:42412 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751296AbaG2MA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 08:00:59 -0400
Received: (qmail 13855 invoked by uid 102); 29 Jul 2014 12:00:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 07:00:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 08:00:56 -0400
Content-Disposition: inline
In-Reply-To: <20140729115334.GA8976@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254421>

When showing a combined diff, we are comparing two (or more)
parents to a final state, and some of these states may be
the same.  Here's a table of the possible contents for a
given path (for two parents, but we will generalize to more
in a moment; we also omit isomorphic cases where the parents
are swapped):

  case | M | P1 | P2
  -------------------
  1    | A | A  | A
  2    | A | A  | B
  3    | A | B  | B
  4    | A | B  | C

In case 1, the path was not relevant to the merge at all,
and we omit it as uninteresting. In case 2, we did resolve
the path, but in favor of one side. We also consider this
uninteresting and do not show the diff.

In case 4, we had a real content-level merge, and the
combined diff is interesting. We show it.

That leaves case 3, in which both parents are the same, but
the merge picks a new content. This should be rare in
normal merges, though it could happen if you updated an
unrelated file due to a resolution elsewhere (i.e., an evil
merge that crosses a file boundary). But it happens
frequently in the fake merge commits we create for stashes,
in which one parent is the base of the stash and the other
is the index (in which case it simply means that the index
entry for the path was not touched).

Right now, we treat it the same as case 4, and show a normal
combined diff. However, the result is harder to read, and
the combined nature of the diff gives no extra information;
every marker in the combined diff will be identical for both
parents.

This patch adds a new option, "--simplify-combined-diff",
which converts this case into a normal, non-combined diff.
It would not be correct to simply omit it, because there
really is an interesting change going from B..A. It's just
that there are not two interesting changes, which the
combined diff would show.

When generalizing this to more than two parents, we have two
options:

  1. Either simply to a single parent content, or not at all.

  2. Omit parents whose contents are duplicates of other
     parents.

For a case like "A B B C", option (2) would still result in
a combined diff, but one with fewer sources. However, it
would also be ambiguous. The parents in a combined diff are
marked only by their position, so omitting a position means
that a reader can no longer tell which line goes with which
parent.

Instead, we choose option (1). Either you get the full
combined diff, or you get a normal non-combined diff.

Signed-off-by: Jeff King <peff@peff.net>
---
The implementation just cuts the number of parents down to 1, but
otherwise runs through the same combined-diff code.  The resulting
pairwise combined-diff differs from a normal diff in a few ways:

  1. The header line is still "diff --combined" (or "--cc") instead of
     "diff --git", and it mentions the filename only once.

  2. The index lines do not contain the file mode; for combined diffs,
     we generate a separate mode line (but only when it has something
     interesting to show).

  3. The hunk header for a single-line change says "-1" in the regular
     code path, but "-1,1" in the combined code path.

Is there any value in keeping this as a pseudo-combined diff (i.e., with
the combined header, but only a single parent)? It should not be too
hard to just punt to the regular builtin_diff code path when
"num_parents == 1".

 Documentation/rev-list-options.txt |   8 +++
 combine-diff.c                     |  30 +++++++--
 revision.c                         |   4 ++
 revision.h                         |   1 +
 t/t4038-diff-combined.sh           | 134 +++++++++++++++++++++++++++++++++++++
 5 files changed, 173 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index deb8cca..7331bcc 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -805,6 +805,14 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 	in that case, the output represents the changes the merge
 	brought _into_ the then-current branch.
 
+--simplify-combined-diff::
+	When showing a combined diff with `-c` or `--cc`, if a given
+	path has identical content in all parents, show only a pairwise
+	diff from that content, rather than a true combined diff. This
+	is easier for humans to read, though it may confuse an automatic
+	parser (as some paths in the output may be combined diffs, and
+	others may not).
+
 -r::
 	Show recursive diffs.
 
diff --git a/combine-diff.c b/combine-diff.c
index f9975d2..60e54a7 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -955,6 +955,16 @@ static void show_combined_header(struct combine_diff_path *elem,
 				 line_prefix, c_meta, c_reset);
 }
 
+static int simplify_parents(struct combine_diff_path *p, int nr)
+{
+	int i;
+	for (i = 1; i < nr; i++)
+		if (p->parent[i].mode != p->parent[i-1].mode ||
+		    hashcmp(p->parent[i].sha1, p->parent[i-1].sha1))
+			return nr;
+	return 1;
+}
+
 static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			    int dense, int working_tree_file,
 			    struct rev_info *rev)
@@ -979,6 +989,9 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV))
 		textconv = userdiff_get_textconv(userdiff);
 
+	if (rev->simplify_combined_diff)
+		num_parent = simplify_parents(elem, num_parent);
+
 	/* Read the result of merge first */
 	if (!working_tree_file)
 		result = grab_blob(elem->sha1, elem->mode, &result_size,
@@ -1181,6 +1194,8 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 	if (rev->loginfo && !rev->no_commit_id)
 		show_log(rev);
 
+	if (rev->simplify_combined_diff)
+		num_parent = simplify_parents(p, num_parent);
 
 	if (opt->output_format & DIFF_FORMAT_RAW) {
 		printf("%s", line_prefix);
@@ -1247,12 +1262,16 @@ static void free_combined_pair(struct diff_filepair *pair)
  * but currently nobody uses it, so this should suffice for now.
  */
 static struct diff_filepair *combined_pair(struct combine_diff_path *p,
-					   int num_parent)
+					   int num_parent,
+					   struct rev_info *rev)
 {
 	int i;
 	struct diff_filepair *pair;
 	struct diff_filespec *pool;
 
+	if (rev->simplify_combined_diff)
+		num_parent = simplify_parents(p, num_parent);
+
 	pair = xmalloc(sizeof(*pair));
 	pool = xcalloc(num_parent + 1, sizeof(struct diff_filespec));
 	pair->one = pool + 1;
@@ -1277,7 +1296,8 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 static void handle_combined_callback(struct diff_options *opt,
 				     struct combine_diff_path *paths,
 				     int num_parent,
-				     int num_paths)
+				     int num_paths,
+				     struct rev_info *rev)
 {
 	struct combine_diff_path *p;
 	struct diff_queue_struct q;
@@ -1287,7 +1307,8 @@ static void handle_combined_callback(struct diff_options *opt,
 	q.alloc = num_paths;
 	q.nr = num_paths;
 	for (i = 0, p = paths; p; p = p->next)
-		q.queue[i++] = combined_pair(p, num_parent);
+		q.queue[i++] = combined_pair(p, num_parent, rev);
+
 	opt->format_callback(&q, opt, opt->format_callback_data);
 	for (i = 0; i < num_paths; i++)
 		free_combined_pair(q.queue[i]);
@@ -1498,7 +1519,8 @@ void diff_tree_combined(const unsigned char *sha1,
 			 (DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT))
 			needsep = 1;
 		else if (opt->output_format & DIFF_FORMAT_CALLBACK)
-			handle_combined_callback(opt, paths, num_parent, num_paths);
+			handle_combined_callback(opt, paths, num_parent,
+						 num_paths, rev);
 
 		if (opt->output_format & DIFF_FORMAT_PATCH) {
 			if (needsep)
diff --git a/revision.c b/revision.c
index 2571ada..a242485 100644
--- a/revision.c
+++ b/revision.c
@@ -1820,6 +1820,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diff = 1;
 		revs->dense_combined_merges = 1;
 		revs->combine_merges = 1;
+	} else if (!strcmp(arg, "--simplify-combined-diff")) {
+		revs->simplify_combined_diff = 1;
+	} else if (!strcmp(arg, "--no-simplify-combined-diff")) {
+		revs->simplify_combined_diff = 0;
 	} else if (!strcmp(arg, "-v")) {
 		revs->verbose_header = 1;
 	} else if (!strcmp(arg, "--pretty")) {
diff --git a/revision.h b/revision.h
index a620530..48cb16e 100644
--- a/revision.h
+++ b/revision.h
@@ -122,6 +122,7 @@ struct rev_info {
 			ignore_merges:1,
 			combine_merges:1,
 			dense_combined_merges:1,
+			simplify_combined_diff:1,
 			always_show_header:1;
 
 	/* Format info */
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 41913c3..d522474 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -401,4 +401,138 @@ test_expect_success 'combine diff missing delete bug' '
 	compare_diff_patch expected actual
 '
 
+# make a commit with contents "$1" and "$2" in the paths
+# "one" and "two" respectively, and parents $3, $4, etc
+#
+# If the content is of the form "mode:content", then the
+# mode for the given file is set (otherwise it defaults 100644).
+mkcommit() {
+	(
+		GIT_INDEX_FILE=tmp.index &&
+		export GIT_INDEX_FILE &&
+		for path in one two; do
+			case "$1" in
+			*:*)
+				mode=$(echo "$1" | cut -d: -f1)
+				content=$(echo "$1" | cut -d: -f2)
+				;;
+			*)
+				mode=100644
+				content=$1
+			esac
+			blob=$(echo "$content" | git hash-object -w --stdin) &&
+			git update-index --add --cacheinfo $mode,$blob,$path &&
+			shift || exit 1
+		done
+		tree=$(git write-tree) &&
+		parents=$(for p in "$@"; do echo "-p $p"; done) &&
+		git commit-tree $tree $parents </dev/null
+	)
+}
+
+# we create a merge commit where path "one" can be simplified, but
+# path "two" cannot
+test_expect_success 'simplify combined --raw' '
+	side1=$(mkcommit base content1) &&
+	side2=$(mkcommit base content2) &&
+	merge=$(mkcommit new new $side1 $side2) &&
+	cat >expect <<-\EOF &&
+
+	:100644 100644 df967b9... 3e75765... M	one
+	::100644 100644 100644 ac3e272... 637f034... 3e75765... MM	two
+	EOF
+
+	git diff-tree -c --simplify-combined-diff \
+		--abbrev --pretty=format: $merge >actual &&
+	test_cmp expect actual
+'
+
+# we do not use compare_diff_patch here because we want to
+# make sure we get the headers right, too
+test_expect_success 'simplify combined --patch' '
+	side1=$(mkcommit base content1) &&
+	side2=$(mkcommit base content2) &&
+	merge=$(mkcommit new new $side1 $side2) &&
+	cat >expect <<-\EOF &&
+
+	diff --combined one
+	index df967b9..3e75765
+	--- a/one
+	+++ b/one
+	@@ -1,1 +1,1 @@
+	-base
+	+new
+	diff --combined two
+	index ac3e272,637f034..3e75765
+	--- a/two
+	+++ b/two
+	@@@ -1,1 -1,1 +1,1 @@@
+	- content1
+	 -content2
+	++new
+	EOF
+
+	git diff-tree -c --simplify-combined-diff -p \
+		--pretty=format: $merge >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'do not simplify unless all parents are identical' '
+	side1=$(mkcommit base content1) &&
+	test_tick &&
+	side2=$(mkcommit base content1) &&
+	side3=$(mkcommit base content3) &&
+	merge=$(mkcommit new new $side1 $side2 $side3) &&
+	cat >expect <<-\EOF &&
+
+	diff --combined one
+	index df967b9..3e75765
+	--- a/one
+	+++ b/one
+	@@ -1,1 +1,1 @@
+	-base
+	+new
+	diff --combined two
+	index ac3e272,ac3e272,27d10cc..3e75765
+	--- a/two
+	+++ b/two
+	@@@@ -1,1 -1,1 -1,1 +1,1 @@@@
+	-- content1
+	  -content3
+	+++new
+	EOF
+
+	git diff-tree -c --simplify-combined-diff -p \
+		--pretty=format: $merge >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'do not simplify away mode changes' '
+	side1=$(mkcommit 100644:base 100644:base) &&
+	side2=$(mkcommit 100644:base 100755:base) &&
+	merge=$(mkcommit new new $side1 $side2) &&
+	cat >expect <<-\EOF &&
+
+	diff --combined one
+	index df967b9..3e75765
+	--- a/one
+	+++ b/one
+	@@ -1,1 +1,1 @@
+	-base
+	+new
+	diff --combined two
+	index df967b9,df967b9..3e75765
+	mode 100644,100755..100644
+	--- a/two
+	+++ b/two
+	@@@ -1,1 -1,1 +1,1 @@@
+	--base
+	++new
+	EOF
+
+	git diff-tree -c --simplify-combined-diff -p \
+		--pretty=format: $merge >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.1.0.rc0.286.g5c67d74
