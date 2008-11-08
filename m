From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/7 v3] bisect: add "git bisect replace" subcommand
Date: Sat, 8 Nov 2008 08:48:34 +0100
Message-ID: <20081108084834.833ddefe.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 08 08:48:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyiYV-0007sl-1I
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 08:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbYKHHqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 02:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbYKHHqQ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 02:46:16 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:58335 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575AbYKHHqP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 02:46:15 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 5FD19197AF;
	Sat,  8 Nov 2008 08:46:12 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id 15E8319741;
	Sat,  8 Nov 2008 08:46:11 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100384>

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

and a branch will be created that points to commit Yn and that has a
special name like: "bisect-replace-B"

When bisecting, the branch names will be scanned and each branch named
"bisect-replace-X" and pointing to commit Y will be grafted so that
X will only have Y as parent.

In the example above, that means that instead of the above graph, the
following graph will be bisected:

        C--Y1--Y2--...--Yn
      /                   \
...--O                     B--...

This means that the bisections on this branch will be much easier
because the bug introduced by commit A and fixed by commit B will not
annoy you anymore.

As the branches created by "git bisect replace" can be shared between
developers, this feature might be especially usefull on big projects
where many people often bisect the same code base.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh      |   37 +++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 3 deletions(-)

	Changes since the previous series are the following:

	- don't create a tag anymore and use the "bisect-replace-*"
	branch to replace to detect grafts that should be created,
	- tried to move "replace" subcommand before "run" subcommand,
	- added patches from 4 to 7

	Perhaps a few more tests are needed for latter patches
	especially patch 7.

	I wonder about the following:

	- perhaps "git bisect replace" should have a "NAME" argument
	so that the branch names could be like "bisect-rename-X-NAME"
	which could be more descriptive,
	- maybe a way to check that the replace branches all point to
	existing commits would be useful,
	- perhaps bisect log/replay could be improved to handle
	replace branches

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 06cdeb7..c0717f6 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -574,6 +574,72 @@ static struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
+static void replace_parents(struct commit *commit,
+			    const char *refname,
+			    const unsigned char *sha1)
+{
+	struct commit *new_parent = lookup_commit(sha1);
+	if (!new_parent) {
+		warning("branch '%s' points to unknown commit '%s'",
+			refname, sha1_to_hex(sha1));
+		return;
+	}
+
+	free_commit_list(commit->parents);
+	commit->parents = NULL;
+	commit_list_insert(new_parent, &commit->parents);
+}
+
+static int bisect_replace(const char *refname, const unsigned char *sha1,
+			  int flag, void *cb_data)
+{
+	unsigned char child[20];
+	struct object *obj;
+	struct commit_graft *graft;
+
+	if (prefixcmp(refname, "bisect-replace-"))
+		return 0;
+
+	if (get_sha1_hex(refname + 15, child)) {
+		warning("bad sha1 in branch name '%s'", refname);
+		return 0;
+	}
+
+	/* Check if child commit exist and is already parsed */
+
+	obj = lookup_object(child);
+	if (obj) {
+		struct commit *commit;
+		if (obj->type != OBJ_COMMIT) {
+			warning("branch name '%s' refers to non commit '%s'",
+				refname, refname + 15);
+			return 0;
+		}
+		commit = (struct commit *) obj;
+		if (commit->object.parsed) {
+			replace_parents(commit, refname, sha1);
+			return 0;
+		}
+	}
+
+	/* Create a graft to replace child commit parents */
+
+	graft = xmalloc(sizeof(*graft) + 20);
+
+	hashcpy(graft->sha1, child);
+	graft->nr_parent = 1;
+	hashcpy(graft->parent[0], sha1);
+
+	register_commit_graft(graft, 1);
+
+	return 0;
+}
+
+static void bisect_replace_all(void)
+{
+	for_each_branch_ref(bisect_replace, NULL);
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
@@ -646,8 +712,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = revs.verbose_header ||
 		revs.grep_filter.pattern_list;
-	if (bisect_list)
+
+	if (bisect_list) {
+		bisect_replace_all();
 		revs.limited = 1;
+	}
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
diff --git a/git-bisect.sh b/git-bisect.sh
index 79de701..1daa81c 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
+USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|replace|run]'
 LONG_USAGE='git bisect help
         print this long help message.
 git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
@@ -21,6 +21,8 @@ git bisect replay <logfile>
         replay bisection log.
 git bisect log
         show bisect log.
+git bisect replace <rev> [<rev>]
+        use another branch for bisection.
 git bisect run <cmd>...
         use <cmd>... to automatically bisect.
 
@@ -566,6 +568,36 @@ bisect_replay () {
 	bisect_auto_next
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
+    # Create branch for the target commit
+    tgt_branch="bisect-replace-$src_commit"
+    git branch "$tgt_branch" "$tgt_commit"
+}
+
 bisect_run () {
     bisect_next_check fail
 
@@ -618,7 +650,6 @@ bisect_run () {
     done
 }
 
-
 case "$#" in
 0)
     usage ;;
@@ -645,6 +676,8 @@ case "$#" in
 	cat "$GIT_DIR/BISECT_LOG" ;;
     run)
         bisect_run "$@" ;;
+    replace)
+        bisect_replace "$@" ;;
     *)
         usage ;;
     esac
-- 
1.6.0.3.619.g9a6a
