From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] cherry-pick/revert: add support for -X/--strategy-option
Date: Fri, 10 Dec 2010 18:51:44 -0600
Message-ID: <20101211005144.GA6634@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Justin Frankel <justin@cockos.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 11 01:52:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRDh7-0005Pz-LJ
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 01:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360Ab0LKAwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 19:52:08 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57028 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539Ab0LKAwG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 19:52:06 -0500
Received: by ywl5 with SMTP id 5so2414535ywl.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 16:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=2yWdTyTRHOpoX/aDSunqzozfYOioxWOAAmbcXLeAnY8=;
        b=vqQHoU+oLs/hG6faexG1jZNwZJEP4ja2EGm9IubA5u0fl5By8VjbK2CXOfV9t5uBh4
         Xf3C4gsz4F0vQRWbaV+i3+oeXEgKAgd5zsZpKUaUumoJtxdwVEJlRR1QbqAmf0uR5J4u
         MZCiOoaWzwoy4hIszzVCikl5I29bXBKeRjGFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=wBGkg6x0mkjljoppE8OBvVJ5KutCNBqXU7vwbEIN3OLqqnXYp5MwLhuYLRybhGRiO0
         9gXz2MPe5DP+r0RqP+JosZYK5XpfOHdndgDUtTvexTNei1wA8DKcnHxmJxl/WzNORJzV
         jeJU4LS+86Hjigw8d2b74EWRGu3PXv9ixXL9A=
Received: by 10.150.97.1 with SMTP id u1mr2476787ybb.74.1292028725814;
        Fri, 10 Dec 2010 16:52:05 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id v4sm788340ybe.5.2010.12.10.16.52.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 16:52:04 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163453>

For example, this would allow cherry-picking or reverting patches from
a piece of history with a different end-of-line style, like so:

	$ git revert -Xrenormalize old-problematic-commit

Currently that is possible with manual use of merge-recursive but the
cherry-pick/revert porcelain does not expose the functionality.

While at it, document the existing support for --strategy.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thoughts?

 Documentation/git-cherry-pick.txt  |   32 ++++++++++++++++++++++++++++++++
 Documentation/git-revert.txt       |   10 ++++++++++
 builtin/merge.c                    |    6 ++++--
 builtin/revert.c                   |   29 ++++++++++++++++++++++-------
 contrib/examples/git-revert.sh     |   13 ++++++++++++-
 merge-recursive.h                  |    4 +++-
 t/t3032-merge-recursive-options.sh |   14 ++++++++++++++
 7 files changed, 97 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 7300870..749d68a 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -79,6 +79,16 @@ effect to your index in a row.
 	cherry-pick'ed commit, then a fast forward to this commit will
 	be performed.
 
+--strategy=<strategy>::
+	Use the given merge strategy.  Should only be used once.
+	See the MERGE STRATEGIES section in linkgit:git-merge[1]
+	for details.
+
+-X<option>::
+--strategy-option=<option>::
+	Pass the merge strategy-specific option through to the
+	merge strategy.  See linkgit:git-merge[1] for details.
+
 EXAMPLES
 --------
 git cherry-pick master::
@@ -120,6 +130,28 @@ git rev-list --reverse master \-- README | git cherry-pick -n --stdin::
 	so the result can be inspected and made into a single new
 	commit if suitable.
 
+The following sequence attempts to backport a patch, bails out because
+the code the patch applies to has changed too much, and then tries
+again, this time exercising more care about matching up context lines.
+
+------------
+$ git cherry-pick topic^             <1>
+$ git diff                           <2>
+$ git reset --merge ORIG_HEAD        <3>
+$ git cherry-pick -Xpatience topic^  <4>
+------------
+<1> apply the change that would be shown by `git show topic^`.
+In this example, the patch does not apply cleanly, so
+information about the conflict is written to the index and
+working tree and no new commit results.
+<2> summarize changes to be reconciled
+<3> cancel the cherry-pick.  In other words, return to the
+pre-cherry-pick state, preserving any local modifications you had in
+the working tree.
+<4> try to apply the change introduced by `topic^` again,
+spending extra time to avoid mistakes based on incorrectly matching
+context lines.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 752fc88..45be851 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -80,6 +80,16 @@ effect to your index in a row.
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
 
+--strategy=<strategy>::
+	Use the given merge strategy.  Should only be used once.
+	See the MERGE STRATEGIES section in linkgit:git-merge[1]
+	for details.
+
+-X<option>::
+--strategy-option=<option>::
+	Pass the merge strategy-specific option through to the
+	merge strategy.  See linkgit:git-merge[1] for details.
+
 EXAMPLES
 --------
 git revert HEAD~3::
diff --git a/builtin/merge.c b/builtin/merge.c
index 3921cd3..c57d06e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -582,7 +582,8 @@ static void write_tree_trivial(unsigned char *sha1)
 		die("git write-tree failed to write a tree");
 }
 
-int try_merge_command(const char *strategy, struct commit_list *common,
+int try_merge_command(const char *strategy, size_t xopts_nr,
+		      const char **xopts, struct commit_list *common,
 		      const char *head_arg, struct commit_list *remotes)
 {
 	const char **args;
@@ -680,7 +681,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		rollback_lock_file(lock);
 		return clean ? 0 : 1;
 	} else {
-		return try_merge_command(strategy, common, head_arg, remoteheads);
+		return try_merge_command(strategy, xopts_nr, xopts,
+						common, head_arg, remoteheads);
 	}
 }
 
diff --git a/builtin/revert.c b/builtin/revert.c
index bb6e9e8..dc1b702 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -44,7 +44,11 @@ static const char **commit_argv;
 static int allow_rerere_auto;
 
 static const char *me;
+
+/* Merge strategy. */
 static const char *strategy;
+static const char **xopts;
+static size_t xopts_nr, xopts_alloc;
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -55,6 +59,17 @@ static const char * const *revert_or_cherry_pick_usage(void)
 	return action == REVERT ? revert_usage : cherry_pick_usage;
 }
 
+static int option_parse_x(const struct option *opt,
+			  const char *arg, int unset)
+{
+	if (unset)
+		return 0;
+
+	ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
+	xopts[xopts_nr++] = xstrdup(arg);
+	return 0;
+}
+
 static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage();
@@ -67,6 +82,8 @@ static void parse_args(int argc, const char **argv)
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 		OPT_STRING(0, "strategy", &strategy, "strategy", "merge strategy"),
+		OPT_CALLBACK('X', "strategy-option", &xopts, "option",
+			"option for merge strategy", option_parse_x),
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
@@ -311,18 +328,13 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
 	int clean, index_fd;
+	const char **xopt;
 	static struct lock_file index_lock;
 
 	index_fd = hold_locked_index(&index_lock, 1);
 
 	read_cache();
 
-	/*
-	 * NEEDSWORK: cherry-picking between branches with
-	 * different end-of-line normalization is a pain;
-	 * plumb in an option to set o.renormalize?
-	 * (or better: arbitrary -X options)
-	 */
 	init_merge_options(&o);
 	o.ancestor = base ? base_label : "(empty tree)";
 	o.branch1 = "HEAD";
@@ -332,6 +344,9 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	next_tree = next ? next->tree : empty_tree();
 	base_tree = base ? base->tree : empty_tree();
 
+	for (xopt = xopts; xopt != xopts + xopts_nr; xopt++)
+		parse_merge_opt(&o, *xopt);
+
 	clean = merge_trees(&o,
 			    head_tree,
 			    next_tree, base_tree, &result);
@@ -503,7 +518,7 @@ static int do_pick_commit(void)
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res = try_merge_command(strategy, common,
+		res = try_merge_command(strategy, xopts_nr, xopts, common,
 					sha1_to_hex(head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
diff --git a/contrib/examples/git-revert.sh b/contrib/examples/git-revert.sh
index 60a05a8..6bf155c 100755
--- a/contrib/examples/git-revert.sh
+++ b/contrib/examples/git-revert.sh
@@ -26,6 +26,7 @@ require_work_tree
 cd_to_toplevel
 
 no_commit=
+xopt=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -44,6 +45,16 @@ do
 	-x|--i-really-want-to-expose-my-private-commit-object-name)
 		replay=
 		;;
+	-X?*)
+		xopt="$xopt$(git rev-parse --sq-quote "--${1#-X}")"
+		;;
+	--strategy-option=*)
+		xopt="$xopt$(git rev-parse --sq-quote "--${1#--strategy-option=}")"
+		;;
+	-X|--strategy-option)
+		shift
+		xopt="$xopt$(git rev-parse --sq-quote "--$1")"
+		;;
 	-*)
 		usage
 		;;
@@ -159,7 +170,7 @@ export GITHEAD_$head GITHEAD_$next
 # and $prev on top of us (when reverting), or the change between
 # $prev and $commit on top of us (when cherry-picking or replaying).
 
-git-merge-recursive $base -- $head $next &&
+eval "git merge-recursive $xopt $base -- $head $next" &&
 result=$(git-write-tree 2>/dev/null) || {
 	mv -f .msg "$GIT_DIR/MERGE_MSG"
 	{
diff --git a/merge-recursive.h b/merge-recursive.h
index c8135b0..981ed6a 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -57,6 +57,8 @@ struct tree *write_tree_from_memory(struct merge_options *o);
 int parse_merge_opt(struct merge_options *out, const char *s);
 
 /* builtin/merge.c */
-int try_merge_command(const char *strategy, struct commit_list *common, const char *head_arg, struct commit_list *remotes);
+int try_merge_command(const char *strategy, size_t xopts_nr,
+		const char **xopts, struct commit_list *common,
+		const char *head_arg, struct commit_list *remotes);
 
 #endif
diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
index 2293797..796f616 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -107,6 +107,20 @@ test_expect_success '--ignore-space-change makes merge succeed' '
 	git merge-recursive --ignore-space-change HEAD^ -- HEAD remote
 '
 
+test_expect_success 'naive cherry-pick fails' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git cherry-pick --no-commit remote &&
+	git read-tree --reset -u HEAD &&
+	test_must_fail git cherry-pick remote &&
+	test_must_fail git update-index --refresh &&
+	grep "<<<<<<" text.txt
+'
+
+test_expect_success '-Xignore-space-change makes cherry-pick succeed' '
+	git read-tree --reset -u HEAD &&
+	git cherry-pick --no-commit -Xignore-space-change remote
+'
+
 test_expect_success '--ignore-space-change: our w/s-only change wins' '
 	q_to_cr <<-\EOF >expected &&
 	    justice and holiness and is the nurse of his age and theQ
-- 
1.7.2.4
