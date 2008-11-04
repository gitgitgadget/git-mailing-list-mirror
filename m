From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3 v2] bisect: add "git bisect replace" subcommand
Date: Tue, 4 Nov 2008 18:35:06 +0100
Message-ID: <20081104183506.bb9af13a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 18:34:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxPmy-0001LZ-Bb
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 18:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbYKDRcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 12:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbYKDRcp
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 12:32:45 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:58196 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbYKDRco (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 12:32:44 -0500
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 4491512B9C4;
	Tue,  4 Nov 2008 18:32:41 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id 7CB4012BA43;
	Tue,  4 Nov 2008 18:32:38 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100092>

This subcommand should be used when you have a branch or a part of a
branch that isn't easily bisectable because of a bug that has been
fixed latter.

We suppose that a bug as been introduced at some point, say A, and
that it has been fixed latter at another point, say B, but that
between these points the code is not easily testable because of the
bug, so it's not easy to bisect between these points.

In this case you can create a branch starting at the parent of A, say
O, that has a fixed history. In this fixed history for example, there
could be first a commit C that is the result of squashing A and B
together and then all the commits between A and B that have been
cherry picked.

For example, let's say the commits between A and B are X1, X2, ... Xn
and they have been cherry picked after C as Y1, Y2, ... Yn:

        C--Y1--Y2--...--Yn
      /
...--O--A--X1--X2--...--Xn--B--...

By design, the last cherry picked commit (Yn) should point to the same
tree as commit B.

So in this case you can say:

$ git bisect replace B Yn

and commit B will be tagged with a special name like:
"bisect-replace-with-Yn"

(A branch that points to commit Yn will also be created with a name
like: "bisect-replace-B")

When bisecting, each commit with one of those tags will be grafted so
that its parents will be replaced by the commit specified in the tag.

In the example above that means that instead of the above graph, the
following graph will be bisected:

        C--Y1--Y2--...--Yn
      /                   \
...--O                     B--...

This means that the bisections on this branch will be much easier
because the bug introduced by commit A and fixed by commit B will not
annoy you anymore.

As the branches and tags created by "git bisect replace" can be shared
between developers, this feature might be especially usefull on big
projects where many people often bisect the same code base.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh      |   40 +++++++++++++++++++++++-
 2 files changed, 125 insertions(+), 2 deletions(-)

	Changes since previous series are the following:

	- replace parents of a commit that has already been created
	when bisect_replace() is called (1/1)
	- check that the new parent of a commit exists before using it
	to replace existing parents (1/1)
	- improve tests (2/3)
	- add a documentation patch (3/3)

	Thank you Junio for your help in designing this during the GitTogether,
	especially for the trick to change the parents of the commit fixing the
	bug.

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 06cdeb7..f29c548 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -529,6 +529,88 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		return best_bisection_sorted(list, nr);
 }
 
+static struct commit *check_replace_parents(unsigned char *parent,
+					    const char *refname,
+					    const unsigned char *sha1)
+{
+	struct commit *new_parent;
+	if (get_sha1_hex(refname + 20, parent)) {
+		warning("bad sha1 in tag name '%s'", refname);
+		return NULL;
+	}
+	new_parent = lookup_commit(parent);
+	if (!new_parent) {
+		warning("tag name '%s' refers to an unknown commit\n"
+			"Please make sure you have the branch "
+			"'bisect-replace-%s'.\n"
+			"Or delete tag '%s'.",
+			refname, sha1_to_hex(sha1), refname);
+		return NULL;
+	}
+	return new_parent;
+}
+
+static void replace_parents(struct commit *commit,
+			    const char *refname,
+			    const unsigned char *sha1)
+{
+	unsigned char parent[20];
+	struct commit *new_parent;
+
+	new_parent = check_replace_parents(parent, refname, sha1);
+
+	if (new_parent) {
+		free_commit_list(commit->parents);
+		commit->parents = NULL;
+		commit_list_insert(new_parent, &commit->parents);
+	}
+}
+
+static int bisect_replace(const char *refname, const unsigned char *sha1,
+			  int flag, void *cb_data)
+{
+	struct object *obj;
+	struct commit_graft *graft;
+	struct commit *new_parent;
+
+	if (prefixcmp(refname, "bisect-replace-with-"))
+		return 0;
+
+	/* See if we already have the commit */
+
+	obj = lookup_object(sha1);
+	if (obj) {
+		struct commit *commit;
+		if (obj->type != OBJ_COMMIT)
+			return 0;
+		commit = (struct commit *) obj;
+		if (commit->object.parsed) {
+			replace_parents(commit, refname, sha1);
+			return 0;
+		}
+	}
+
+	/* Create a graft to replace current commit */
+
+	graft = xmalloc(sizeof(*graft) + 20);
+
+	hashcpy(graft->sha1, sha1);
+	graft->nr_parent = 1;
+
+	/*
+	 * We create commits that we may not need
+	 * and cannot easily free, but at least it is safe.
+	 */
+	new_parent = check_replace_parents(graft->parent[0], refname, sha1);
+
+	if (new_parent)
+		register_commit_graft(graft, 1);
+	else
+		free(graft);
+
+	return 0;
+}
+
 static struct commit_list *find_bisection(struct commit_list *list,
 					  int *reaches, int *all,
 					  int find_all)
@@ -646,8 +728,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = revs.verbose_header ||
 		revs.grep_filter.pattern_list;
-	if (bisect_list)
+
+	if (bisect_list) {
+		for_each_tag_ref(bisect_replace, NULL);
 		revs.limited = 1;
+	}
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
diff --git a/git-bisect.sh b/git-bisect.sh
index 0d0e278..245435c 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
+USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run|replace]'
 LONG_USAGE='git bisect help
         print this long help message.
 git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
@@ -23,6 +23,8 @@ git bisect log
         show bisect log.
 git bisect run <cmd>...
         use <cmd>... to automatically bisect.
+git bisect replace <rev> [<rev>]
+        use another branch for bisection.
 
 Please use "git help bisect" to get the full man page.'
 
@@ -618,6 +620,40 @@ bisect_run () {
     done
 }
 
+bisect_replace() {
+    test "$#" -ge 1 -a "$#" -le 2 ||
+        die "'git bisect replace' accept one or two arguments"
+
+    source="$1"
+    target="${2:-HEAD}"
+
+    # Check arguments
+    src_commit=$(git rev-parse --verify "$source^{commit}") ||
+        die "Bad rev input: $source"
+    tgt_commit=$(git rev-parse --verify "$target^{commit}") ||
+        die "Bad rev input: $target"
+
+    test "$src_commit" != "tgt_commit" ||
+        die "source and target should be different commits"
+
+    # Check that trees from source and target are identical
+    src_tree=$(git rev-parse --verify "$src_commit^{tree}") ||
+        die "Could not get tree for source: $source"
+    tgt_tree=$(git rev-parse --verify "$tgt_commit^{tree}") ||
+        die "Could not get tree for target: $target"
+
+    test "$src_tree" = "$tgt_tree" ||
+        die "source and target should point to the same tree"
+
+    # Tag the source commit
+    src_tag="bisect-replace-with-$tgt_commit"
+    git tag "$src_tag" "$src_commit" || exit
+
+    # Create branch for the target commit
+    tgt_branch="bisect-replace-$src_commit"
+    git branch "$tgt_branch" "$tgt_commit" || exit
+}
+
 
 case "$#" in
 0)
@@ -645,6 +681,8 @@ case "$#" in
 	cat "$GIT_DIR/BISECT_LOG" ;;
     run)
         bisect_run "$@" ;;
+    replace)
+        bisect_replace "$@" ;;
     *)
         usage ;;
     esac
-- 
1.6.0.3.528.gad674
