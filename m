From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 0/6] {checkout,reset,stash} --patch
Date: Tue, 18 Aug 2009 12:48:26 -0400
Message-ID: <20090818164826.GA27377@coredump.intra.peff.net>
References: <200908101136.34660.trast@student.ethz.ch>
 <cover.1250164190.git.trast@student.ethz.ch>
 <20090815065125.GA23068@coredump.intra.peff.net>
 <200908151204.36709.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:48:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRrl-000089-Ug
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759386AbZHRQs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759381AbZHRQs0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:48:26 -0400
Received: from peff.net ([208.65.91.99]:44597 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759371AbZHRQsY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:48:24 -0400
Received: (qmail 11659 invoked by uid 107); 18 Aug 2009 16:48:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 18 Aug 2009 12:48:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Aug 2009 12:48:26 -0400
Content-Disposition: inline
In-Reply-To: <200908151204.36709.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126415>

On Sat, Aug 15, 2009 at 12:04:35PM +0200, Thomas Rast wrote:

> > Getting greedy, is there a reason not to have "stash apply -p" as well?
> 
> Should be doable, I'll look at it.

I took a look at this today. It is actually a bit harder than I had
hoped. The problem is that a stash is not a _state_, but rather two
states whose difference is of interest to us.

So it's not right to just pick hunks out of the stash as compared with
the current tree. You will get "false" hunks for the changes between
the current tree and the base upon which the stash was created. In fact,
we actually do a full 3-way merge with the current state and the new
state with the stash base as the ancestor.

The strategy I employ in the patch below is to actually just prune the
stash tree against the base, and then use that result to do the merge.
For example, consider the following situation:

  $ echo base >file && git add file && git commit -m base
  $ echo stash >file && git stash
  $ echo tree >file && git add file

Now you have a stash whose base has 'base' and whose content has
'stash', and your current tree has 'tree'. Applying the stash should
therefore cause a conflict (but I am using such a simple example because
we can still illustrate what's happening).

You can see that ignoring the base creates an incorrect result. You
would see that the stash has 'stash' and we have 'tree', and ask about
applying the hunk

  -tree
  +stash

but that's not right. We should have a conflict.

So what I do instead is to load the base tree into a temporary index,
then git-add--interactive the changes from the stashed tree, then put
write the result into a new tree, which becomes our new merge point. So
you will be asked if you want to apply the hunk

  -base
  +stash

If not, then the resulting tree will have 'base'. Since the base also
has 'base', the stash has done nothing, and the 3-way merge will keep
your tree contents. If you do, then the resulting tree will have
'stash', and you will have a 3-way merge with a conflict.

Now there is a slight problem with that. What if you had already applied
or recreated part of the stash? In other words, instead of 'tree' in
your current content, you had 'stash'? We would _still_ ask if you
wanted to replace 'base' with 'stash', even though when we get to the
three-way merge, it will be a no-op.

Hmm. I was about to write "so we need some clever way of integrating the
interactive hunk selection with a 3-way merge". But I just had a
thought: we should do it in the reverse order. We do the three-way merge
into a temporary index, and then ask the user to apply the result of
_that_ tree into the working tree. Or maybe I am missing something else
obvious and you can enlighten me.

I'll try to experiment with merging first, though I doubt I will have
any more time for the next day or two. In the meantime, you can peek at
the current patch I have below. It has two additional problems:

  1. For --index mode, it actually invokes add--interactive twice. It
     would be nice to do both passes at the same time, but I don't think
     it is possible with the current add--interactive infrastructure.

  2. You will notice a hack-ish 'sleep' in the test; because of the
     double add--interactive, when piping from stdin, the first one eats
     the responses in its input buffer and the second one never sees
     them.

-Peff

---
 git-add--interactive.perl    |   28 ++++++++++++++++++++++++++++
 git-stash.sh                 |   35 +++++++++++++++++++++++++++++------
 t/t3905-stash-apply-patch.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 6 deletions(-)
 create mode 100755 t/t3905-stash-apply-patch.sh

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 392efb9..cbbf0a7 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -97,6 +97,28 @@ my %patch_modes = (
 		PARTICIPLE => 'stashing',
 		FILTER => undef,
 	},
+	'stash-apply-tree' => {
+		DIFF => 'diff-index -R -p --cached',
+		APPLY => sub {
+			apply_patch 'apply --cached', $patch_mode_revision, @_;
+		},
+		APPLY_CHECK => 'apply --cached',
+		VERB => 'Apply',
+		TARGET => ' to working tree',
+		PARTICIPLE => 'applying',
+		FILTER => undef,
+	},
+	'stash-apply-index' => {
+		DIFF => 'diff-index -R -p --cached',
+		APPLY => sub {
+			apply_patch 'apply --cached', $patch_mode_revision, @_;
+		},
+		APPLY_CHECK => 'apply --cached',
+		VERB => 'Apply',
+		TARGET => ' to index',
+		PARTICIPLE => 'applying',
+		FILTER => undef,
+	},
 	'reset_head' => {
 		DIFF => 'diff-index -p --cached',
 		APPLY => sub { apply_patch 'apply -R --cached', @_; },
@@ -1507,6 +1529,12 @@ sub process_args {
 						       'checkout_head' : 'checkout_nothead');
 					$arg = shift @ARGV or die "missing --";
 				}
+			} elsif ($1 eq 'stash-apply-tree'
+					|| $1 eq 'stash-apply-index') {
+				$patch_mode = $1;
+				$arg = shift @ARGV or die "missing --";
+				$patch_mode_revision = $arg;
+				$arg = shift @ARGV or die "missing --";
 			} elsif ($1 eq 'stage' or $1 eq 'stash') {
 				$patch_mode = $1;
 				$arg = shift @ARGV or die "missing --";
diff --git a/git-stash.sh b/git-stash.sh
index 9efc46d..8090bbf 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -214,8 +214,19 @@ show_stash () {
 	git diff $flags $b_commit $w_commit
 }
 
+munge_tree_interactive () {
+	(
+	 GIT_INDEX_FILE="$TMP-index"
+	 export GIT_INDEX_FILE
+	 git read-tree --reset "$2" &&
+	 git add--interactive --patch=stash-apply-$1 "$3" -- >&3 &&
+	 git write-tree
+	)
+}
+
 apply_stash () {
 	unstash_index=
+	patch_mode=
 
 	while test $# != 0
 	do
@@ -226,6 +237,9 @@ apply_stash () {
 		-q|--quiet)
 			GIT_QUIET=t
 			;;
+		-p|--patch)
+			patch_mode=t
+			;;
 		*)
 			break
 			;;
@@ -258,12 +272,21 @@ apply_stash () {
 	if test -n "$unstash_index" && test "$b_tree" != "$i_tree" &&
 			test "$c_tree" != "$i_tree"
 	then
-		git diff-tree --binary $s^2^..$s^2 | git apply --cached
-		test $? -ne 0 &&
-			die 'Conflicts in index. Try without --index.'
-		unstashed_index_tree=$(git write-tree) ||
-			die 'Could not save index tree'
-		git reset
+		if test -n "$patch_mode"; then
+			i_tree=`munge_tree_interactive index $b_tree $i_tree` 3>&1
+		fi
+		if test "$b_tree" != "$i_tree"; then
+			git diff-tree --binary $b_tree $i_tree | git apply --cached
+			test $? -ne 0 &&
+				die 'Conflicts in index. Try without --index.'
+			unstashed_index_tree=$(git write-tree) ||
+				die 'Could not save index tree'
+			git reset
+		fi
+	fi
+
+	if test -n "$patch_mode"; then
+		w_tree=`munge_tree_interactive tree $b_tree $w_tree` 3>&1
 	fi
 
 	eval "
diff --git a/t/t3905-stash-apply-patch.sh b/t/t3905-stash-apply-patch.sh
new file mode 100755
index 0000000..07cd69b
--- /dev/null
+++ b/t/t3905-stash-apply-patch.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='git stash apply --patch'
+. ./lib-patch-mode.sh
+
+test_expect_success 'setup' '
+	test_commit one bar bar_head &&
+	test_commit two foo foo_head &&
+	set_state bar bar_work bar_index &&
+	set_state foo foo_work foo_index &&
+	save_head &&
+	git stash
+'
+
+test_expect_success 'saying "n" does nothing' '
+	git reset --hard &&
+	(echo n; echo n) | git stash apply -p &&
+	verify_state bar bar_head bar_head &&
+	verify_state foo foo_head foo_head
+'
+
+# n/y will apply foo but not bar
+test_expect_success 'git stash apply -p' '
+	git reset --hard &&
+	(echo n; echo y) | git stash apply -p &&
+	verify_state bar bar_head bar_head &&
+	verify_state foo foo_work foo_head
+'
+
+# we need two per file, for index and working tree
+test_expect_success 'git stash apply -p --index' '
+	git reset --hard &&
+	(echo n; echo y; sleep 2; echo n; echo y) | git stash apply -p --index &&
+	verify_state bar bar_head bar_head &&
+	verify_state foo foo_work foo_index
+'
+
+test_expect_success 'none of this moved HEAD' '
+	verify_saved_head
+'
+
+test_done
-- 
1.6.4.304.ge0c3be.dirty
