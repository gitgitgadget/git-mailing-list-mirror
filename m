From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 1/2] bisect: add "git bisect replace" subcommand
Date: Sun, 2 Nov 2008 02:19:10 +0100
Message-ID: <20081102021910.fef1532e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 02:17:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwRbG-0006JK-2L
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 02:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbYKBBQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 21:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbYKBBQl
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 21:16:41 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:35994 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235AbYKBBQk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 21:16:40 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 9137912B6B8;
	Sun,  2 Nov 2008 02:16:37 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id 5B88512B6B3;
	Sun,  2 Nov 2008 02:16:37 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99795>

This new subcommand should be used when you have a branch or a part of
a branch that isn't easily bisectable because at some point, say A, a
bug as been introduced. The bug has been fixed latter at another point,
say B, but between these points the code is not easily testable because
of the bug, so it's not easy to bisect between these points.

In this case you can create a branch starting at the parent of A, say
O, that has a fixed history. In this fixed history for example, there
could be first a commit C that is the result of squashing A and B
together and then all the commit between A and B that have been
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

When bisecting, commit with those tags will be grafted so that their
parents will be replaced by the commit specified in the tag.

In the example above that means that instead of the above graph, the
following graph will be bisected:

        C--Y1--Y2--...--Yn
      /                   \
...--O                     B--...

This means that the bisections on this branch will be much easier
because the bug introduced by commit A and fixed by commit B will not
annoy you anymore.
---
 builtin-rev-list.c |   29 ++++++++++++++++++++++++++++-
 git-bisect.sh      |   40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 2 deletions(-)

	Thank you Junio for your help in designing this during the GitTogether,
	especially for the trick to change the parents of the commit fixing the
	bug.

	I know this is lacking documentation but I plan to work on it soon and
	send a documentation patch. The tests (in the following patch) are also
	a bit lacking, so I will improve them too.

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 06cdeb7..5569bb2 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -529,6 +529,30 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		return best_bisection_sorted(list, nr);
 }
 
+static int bisect_replace(const char *refname, const unsigned char *sha1,
+			  int flag, void *cb_data)
+{
+	struct commit_graft *graft;
+
+	if (prefixcmp(refname, "bisect-replace-with-"))
+		return 0;
+
+	/* Create a graft to replace current commit */
+
+	graft = xmalloc(sizeof(*graft) + 20);
+
+	hashcpy(graft->sha1, sha1);
+	graft->nr_parent = 1;
+	if (get_sha1_hex(refname + 20, graft->parent[0])) {
+		free(graft);
+		return 0;
+	}
+
+	register_commit_graft(graft, 1);
+
+	return 0;
+}
+
 static struct commit_list *find_bisection(struct commit_list *list,
 					  int *reaches, int *all,
 					  int find_all)
@@ -646,8 +670,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
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
1.6.0.3.531.gd12eb.dirty
