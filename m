From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cherry-pick dangles and forgets helpful advice in next
Date: Wed, 23 May 2012 16:22:29 -0700
Message-ID: <7v62bmzdmy.fsf@alter.siamese.dyndns.org>
References: <4FBD4904.9090000@cisco.com>
 <7vipfmzfel.fsf@alter.siamese.dyndns.org>
 <7vehqazf9d.fsf@alter.siamese.dyndns.org> <4FBD6EC2.3000804@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu May 24 01:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXKt4-0002Ss-Oo
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 01:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab2EWXWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 19:22:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab2EWXWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 19:22:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04C668790;
	Wed, 23 May 2012 19:22:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mDrjdpnLCtrMstXk2UT6uMXqgew=; b=jgliMi
	KwyiB6HzF4Aft3KxkO8bjdC7UP+mjKaOwxRdEK31ONBWDZCtUbIB7MP0WJ3GlSDn
	Ihnu6Kf1DZ03lBL5aEjaVApgVgqKYdtdch4AvrRTeWDabSgqAzmy+Cueqk2VFsET
	LcZyOfmNdEEVSRb9VBG9XeClKfe2ywobGcel8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vv5Kv+ZX0K6ijm8PMigIi/Tuk0gbM2qe
	hGv39TbvAdJvxgf1y9bI1EcRxFq9O87MZ5HlDCAVRbY37FtK0n2f4XBii/h8VLN7
	w2fWem1hp8JjLJzzkuX1otOvmYBkGx1RFkgsPu+4BKZIUJarnDw5+41MtQS78yg/
	MtFiEB1NqdI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF32C878E;
	Wed, 23 May 2012 19:22:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ECED878B; Wed, 23 May 2012
 19:22:30 -0400 (EDT)
In-Reply-To: <4FBD6EC2.3000804@cisco.com> (Phil Hord's message of "Wed, 23
 May 2012 19:12:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B42F108-A52E-11E1-9338-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198336>

Phil Hord <hordp@cisco.com> writes:

> This sequence fails to report an error as of this commit:
>
> commit b27cfb0d8d4cbb6d079c70ffeadac9c0dcfff250
> Author: Neil Horman <nhorman@tuxdriver.com>
> Date:   Fri Apr 20 10:36:15 2012 -0400
>
>     git-cherry-pick: Add keep-redundant-commits option

Yes, because it deliberately breaks sequencer.c::do_pick_commit() in this
particular case:

	if (!empty_commit && !opts->keep_redundant_commits && index_unchanged)
		/*
		 * The head tree and the index match
		 * meaning the commit is empty.  Since it wasn't created
		 * empty (based on the previous test), we can conclude
		 * the commit has been made redundant.  Since we don't
		 * want to keep redundant commits, we can just return
		 * here, skipping this commit
		 */
		return 0;

which is not quite right.  We do not want to keep redundant commits, so
this needs to error out as before.

I will queue the following in the meantime.

-- >8 --
Subject: [PATCH] Revert nh/empty-rebase topic

The topic breaks "git cherry-pick $commit" that results in no change
in the tree by not erroring out, which is a grave regression.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-cherry-pick.txt |  19 -------
 Documentation/git-rebase.txt      |   4 --
 builtin/revert.c                  |   8 ---
 git-rebase--am.sh                 |  19 ++-----
 git-rebase--interactive.sh        |  35 ++-----------
 git-rebase.sh                     |   5 --
 sequencer.c                       | 103 ++++----------------------------------
 sequencer.h                       |   2 -
 t/t3505-cherry-pick-empty.sh      |  25 +--------
 9 files changed, 19 insertions(+), 201 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 9f3dae6..06a0bfd 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -103,25 +103,6 @@ effect to your index in a row.
 	cherry-pick'ed commit, then a fast forward to this commit will
 	be performed.
 
---allow-empty::
-	By default, cherry-picking an empty commit will fail,
-	indicating that an explicit invocation of `git commit
-	--allow-empty` is required. This option overrides that
-	behavior, allowing empty commits to be preserved automatically
-	in a cherry-pick. Note that when "--ff" is in effect, empty
-	commits that meet the "fast-forward" requirement will be kept
-	even without this option.  Note also, that use of this option only
-	keeps commits that were initially empty (i.e. the commit recorded the
-	same tree as its parent).  Commits which are made empty due to a
-	previous commit are dropped.  To force the inclusion of those commits
-	use `--keep-redundant-commits`.
-
---keep-redundant-commits::
-	If a commit being cherry picked duplicates a commit already in the
-	current history, it will become empty.  By default these
-	redundant commits are ignored.  This option overrides that behavior and
-	creates an empty commit object.  Implies `--allow-empty`.
-
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
 	See the MERGE STRATEGIES section in linkgit:git-merge[1]
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 147fa1a..b0e13e5 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -238,10 +238,6 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	will be reset to where it was when the rebase operation was
 	started.
 
---keep-empty::
-	Keep the commits that do not change anything from its
-	parents in the result.
-
 --skip::
 	Restart the rebasing process by skipping the current patch.
 
diff --git a/builtin/revert.c b/builtin/revert.c
index 82d1bf8..5462e67 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -115,16 +115,12 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
-		OPT_END(),
-		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
-			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, "preserve initially empty commits"),
-			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_commits, "keep redundant, empty commits"),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
@@ -142,10 +138,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				"--abort", rollback,
 				NULL);
 
-	/* implies allow_empty */
-	if (opts->keep_redundant_commits)
-		opts->allow_empty = 1;
-
 	/* Set the subcommand */
 	if (remove_state)
 		opts->subcommand = REPLAY_REMOVE_STATE;
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 04d8941..c815a24 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -20,20 +20,11 @@ esac
 
 test -n "$rebase_root" && root_flag=--root
 
-if test -n "$keep_empty"
-then
-	# we have to do this the hard way.  git format-patch completely squashes
-	# empty commits and even if it didn't the format doesn't really lend
-	# itself well to recording empty patches.  fortunately, cherry-pick
-	# makes this easy
-	git cherry-pick --allow-empty "$revisions"
-else
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		--src-prefix=a/ --dst-prefix=b/ \
-		--no-renames $root_flag "$revisions" |
-	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg"
-fi && move_to_original_branch
-
+git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+	--src-prefix=a/ --dst-prefix=b/ \
+	--no-renames $root_flag "$revisions" |
+git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
+move_to_original_branch
 ret=$?
 test 0 != $ret -a -d "$state_dir" && write_basic_state
 exit $ret
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..2e13258 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -167,14 +167,6 @@ has_action () {
 	sane_grep '^[^#]' "$1" >/dev/null
 }
 
-is_empty_commit() {
-	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null ||
-		die "$1: not a commit that can be picked")
-	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null ||
-		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904)
-	test "$tree" = "$ptree"
-}
-
 # Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
 # GIT_AUTHOR_DATE exported from the current environment.
 do_with_author () {
@@ -199,19 +191,12 @@ git_sequence_editor () {
 
 pick_one () {
 	ff=--ff
-
 	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
 	case "$force_rebase" in '') ;; ?*) ff= ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
-
-	if is_empty_commit "$sha1"
-	then
-		empty_args="--allow-empty"
-	fi
-
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output git cherry-pick $empty_args $ff "$@"
+	output git cherry-pick $ff "$@"
 }
 
 pick_one_preserving_merges () {
@@ -795,17 +780,9 @@ git rev-list $merges_option --pretty=oneline --abbrev-commit \
 	sed -n "s/^>//p" |
 while read -r shortsha1 rest
 do
-
-	if test -z "$keep_empty" && is_empty_commit $shortsha1
-	then
-		comment_out="# "
-	else
-		comment_out=
-	fi
-
 	if test t != "$preserve_merges"
 	then
-		printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
+		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
 	else
 		sha1=$(git rev-parse $shortsha1)
 		if test -z "$rebase_root"
@@ -824,7 +801,7 @@ do
 		if test f = "$preserve"
 		then
 			touch "$rewritten"/$sha1
-			printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
+			printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
 		fi
 	fi
 done
@@ -876,12 +853,6 @@ cat >> "$todo" << EOF
 #
 EOF
 
-if test -z "$keep_empty"
-then
-	echo "# Note that empty commits are commented out" >>"$todo"
-fi
-
-
 has_action "$todo" ||
 	die_abort "Nothing to do"
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 24a2840..69c1374 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -43,7 +43,6 @@ s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
 m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
-k,keep-empty	   preserve empty commits during rebase
 f,force-rebase!    force rebase even if branch is up to date
 X,strategy-option=! pass the argument through to the merge strategy
 stat!              display a diffstat of what changed upstream
@@ -98,7 +97,6 @@ state_dir=
 action=
 preserve_merges=
 autosquash=
-keep_empty=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 
 read_basic_state () {
@@ -222,9 +220,6 @@ do
 	-i)
 		interactive_rebase=explicit
 		;;
-	-k)
-		keep_empty=yes
-		;;
 	-p)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
diff --git a/sequencer.c b/sequencer.c
index 3c384b9..81d8ace 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -13,7 +13,6 @@
 #include "rerere.h"
 #include "merge-recursive.h"
 #include "refs.h"
-#include "argv-array.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -252,38 +251,6 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	return !clean;
 }
 
-static int is_index_unchanged(void)
-{
-	unsigned char head_sha1[20];
-	struct commit *head_commit;
-
-	if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
-		return error(_("Could not resolve HEAD commit\n"));
-
-	head_commit = lookup_commit(head_sha1);
-
-	/*
-	 * If head_commit is NULL, check_commit, called from
-	 * lookup_commit, would have indicated that head_commit is not
-	 * a commit object already.  parse_commit() will return failure
-	 * without further complaints in such a case.  Otherwise, if
-	 * the commit is invalid, parse_commit() will complain.  So
-	 * there is nothing for us to say here.  Just return failure.
-	 */
-	if (parse_commit(head_commit))
-		return -1;
-
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
-
-	if (!cache_tree_fully_valid(active_cache_tree))
-		if (cache_tree_update(active_cache_tree, active_cache,
-				  active_nr, 0))
-			return error(_("Unable to update cache tree\n"));
-
-	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.sha1);
-}
-
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -293,46 +260,21 @@ static int is_index_unchanged(void)
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 {
-	struct argv_array array;
-	int rc;
-
-	argv_array_init(&array);
-	argv_array_push(&array, "commit");
-	argv_array_push(&array, "-n");
+	/* 6 is max possible length of our args array including NULL */
+	const char *args[6];
+	int i = 0;
 
+	args[i++] = "commit";
+	args[i++] = "-n";
 	if (opts->signoff)
-		argv_array_push(&array, "-s");
+		args[i++] = "-s";
 	if (!opts->edit) {
-		argv_array_push(&array, "-F");
-		argv_array_push(&array, defmsg);
+		args[i++] = "-F";
+		args[i++] = defmsg;
 	}
+	args[i] = NULL;
 
-	if (opts->allow_empty)
-		argv_array_push(&array, "--allow-empty");
-
-	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
-	argv_array_clear(&array);
-	return rc;
-}
-
-static int is_original_commit_empty(struct commit *commit)
-{
-	const unsigned char *ptree_sha1;
-
-	if (parse_commit(commit))
-		return error(_("Could not parse commit %s\n"),
-			     sha1_to_hex(commit->object.sha1));
-	if (commit->parents) {
-		struct commit *parent = commit->parents->item;
-		if (parse_commit(parent))
-			return error(_("Could not parse parent commit %s\n"),
-				sha1_to_hex(parent->object.sha1));
-		ptree_sha1 = parent->tree->object.sha1;
-	} else {
-		ptree_sha1 = EMPTY_TREE_SHA1_BIN; /* commit is root */
-	}
-
-	return !hashcmp(ptree_sha1, commit->tree->object.sha1);
+	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
 static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
@@ -344,8 +286,6 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res;
-	int empty_commit;
-	int index_unchanged;
 
 	if (opts->no_commit) {
 		/*
@@ -471,10 +411,6 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		free_commit_list(remotes);
 	}
 
-	empty_commit = is_original_commit_empty(commit);
-	if (empty_commit < 0)
-		return empty_commit;
-
 	/*
 	 * If the merge was clean or if it failed due to conflict, we write
 	 * CHERRY_PICK_HEAD for the subsequent invocation of commit to use.
@@ -495,25 +431,6 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		print_advice(res == 1, opts);
 		rerere(opts->allow_rerere_auto);
 	} else {
-		index_unchanged = is_index_unchanged();
-		/*
-		 * If index_unchanged is less than 0, that indicates we either
-		 * couldn't parse HEAD or the index, so error out here.
-		 */
-		if (index_unchanged < 0)
-			return index_unchanged;
-
-		if (!empty_commit && !opts->keep_redundant_commits && index_unchanged)
-			/*
-			 * The head tree and the index match
-			 * meaning the commit is empty.  Since it wasn't created
-			 * empty (based on the previous test), we can conclude
-			 * the commit has been made redundant.  Since we don't
-			 * want to keep redundant commits, we can just return
-			 * here, skipping this commit
-			 */
-			return 0;
-
 		if (!opts->no_commit)
 			res = run_git_commit(defmsg, opts);
 	}
diff --git a/sequencer.h b/sequencer.h
index aa5f17c..bb4b138 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -29,8 +29,6 @@ struct replay_opts {
 	int signoff;
 	int allow_ff;
 	int allow_rerere_auto;
-	int allow_empty;
-	int keep_redundant_commits;
 
 	int mainline;
 
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index 92f00cd..c10b28c 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -18,12 +18,7 @@ test_expect_success setup '
 	echo third >> file1 &&
 	git add file1 &&
 	test_tick &&
-	git commit --allow-empty-message -m "" &&
-
-	git checkout master &&
-	git checkout -b empty-branch2 &&
-	test_tick &&
-	git commit --allow-empty -m "empty"
+	git commit --allow-empty-message -m ""
 
 '
 
@@ -53,22 +48,4 @@ test_expect_success 'index lockfile was removed' '
 
 '
 
-test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
-	git checkout master &&
-	echo fourth >>file2 &&
-	git add file2 &&
-	git commit -m "fourth" &&
-	test_must_fail git cherry-pick empty-branch2
-'
-
-test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
-	git checkout master &&
-	git cherry-pick --allow-empty empty-branch2
-'
-
-test_expect_success 'cherry pick with --keep-redundant-commits' '
-	git checkout master &&
-	git cherry-pick --keep-redundant-commits HEAD^
-'
-
 test_done
-- 
1.7.10.2.627.g7c93d77
