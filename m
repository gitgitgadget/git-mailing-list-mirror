From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/2] completion: Use parse-options raw output for simple long options
Date: Wed, 11 Apr 2012 03:29:25 -0700
Message-ID: <1334140165-24958-3-git-send-email-bebarino@gmail.com>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
Cc: spearce@spearce.org, szeder@ira.uka.de, felipe.contreras@gmail.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 12:29:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHuo1-0003xq-GL
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 12:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756529Ab2DKK3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 06:29:35 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39952 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448Ab2DKK3d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 06:29:33 -0400
Received: by mail-ob0-f174.google.com with SMTP id tb18so1037432obb.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 03:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=d9pLTWB9f3qGQBkJilDE61OWFQLRQyer1w/yEim3Fuk=;
        b=CTFIN1XdjUM0QqU5hV88vhm7pKkhxnG3wV4za+ZDIbLGCYisK2uv6Eto4O36yhzB5y
         qC3+afbBBgOJQBViiB5OZ3PpDduGs1UgDOSlbXk2qNhKY96rv9sA+L6ueysmcfzfrUYw
         juHIIs77zjWh+F/1ucb/N6Kl9YzvW1Uye/jwH7ywJD4mw4sunoyua7TiWM2xH/Q1upVF
         vZXK/54Ziq+n3YUy9aHbAPkiB/RmJVguwEZulBBPXkJ3SeH/KUIcej/TR8tOeBaJJEj/
         nKjKF6lm9BuKl9rDl7hBmOJr7jFoJOyEFWPtnbiOJmkCcOTp6Os7hR5tVBKopJR2mZaq
         eqoQ==
Received: by 10.60.169.174 with SMTP id af14mr20645248oec.13.1334140173218;
        Wed, 11 Apr 2012 03:29:33 -0700 (PDT)
Received: from earth (ip68-105-100-241.sd.sd.cox.net. [68.105.100.241])
        by mx.google.com with ESMTPS id m2sm2418842obk.9.2012.04.11.03.29.30
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 03:29:32 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 11 Apr 2012 03:29:32 -0700
X-Mailer: git-send-email 1.7.10.128.g7945c.dirty
In-Reply-To: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195159>

Now that parse-options supports generating lists of long options for any
parse-optified git program we can remove the hand-coded lists in the
completion script. Replace these lists with code to generate the lists
lazily when a user tab completes that specific command. Unforunately,
doing lazy evalution takes more lines than before, but the benefit is we
reduce the amount of trivial patches to update the script for new and/or
removed options. It also mildly encourages the migration of git commands
to the parse-options API.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Is there some way to compute these lists with some magical function instead
of duplicating that logic over and over?

 contrib/completion/git-completion.bash |  298 +++++++++++++++++++-------------
 1 file changed, 176 insertions(+), 122 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 31f714d..69abbe5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -917,6 +917,11 @@ __git_list_porcelain_commands ()
 	done
 }
 
+__git_list_command_options ()
+{
+	git $@ --dump-raw-long-options
+}
+
 __git_porcelain_commands=
 __git_compute_porcelain_commands ()
 {
@@ -1027,43 +1032,45 @@ _git_am ()
 	COMPREPLY=()
 }
 
+__git_apply_options=
 _git_apply ()
 {
+	test -n "$__git_apply_options" ||
+	__git_apply_options=$(__git_list_command_options apply)
+
 	case "$cur" in
 	--whitespace=*)
 		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=}"
 		return
 		;;
 	--*)
-		__gitcomp "
-			--stat --numstat --summary --check --index
-			--cached --index-info --reverse --reject --unidiff-zero
-			--apply --no-add --exclude=
-			--ignore-whitespace --ignore-space-change
-			--whitespace= --inaccurate-eof --verbose
-			"
+		__gitcomp "$__git_apply_options"
 		return
 	esac
 	COMPREPLY=()
 }
 
+__git_add_options=
 _git_add ()
 {
 	__git_has_doubledash && return
+	test -n "$__git_add_options" ||
+	__git_add_options=$(__git_list_command_options add)
 
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--interactive --refresh --patch --update --dry-run
-			--ignore-errors --intent-to-add
-			"
+		__gitcomp "$__git_add_options"
 		return
 	esac
 	COMPREPLY=()
 }
 
+__git_archive_options=
 _git_archive ()
 {
+	test -n "$__git_archive_options" ||
+	__git_archive_options=$(__git_list_command_options archive)
+
 	case "$cur" in
 	--format=*)
 		__gitcomp "$(git archive --list)" "" "${cur##--format=}"
@@ -1074,10 +1081,7 @@ _git_archive ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--format= --list --verbose
-			--prefix= --remote= --exec=
-			"
+		__gitcomp "$__git_archive_options"
 		return
 		;;
 	esac
@@ -1109,6 +1113,7 @@ _git_bisect ()
 	esac
 }
 
+__git_branch_options=
 _git_branch ()
 {
 	local i c=1 only_local_ref="n" has_r="n"
@@ -1122,13 +1127,12 @@ _git_branch ()
 		((c++))
 	done
 
+	test -n "$__git_branch_options" ||
+	__git_branch_options=$(__git_list_command_options branch)
+
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--color --no-color --verbose --abbrev= --no-abbrev
-			--track --no-track --contains --merged --no-merged
-			--set-upstream --edit-description --list
-			"
+		__gitcomp "$__git_branch_options"
 		;;
 	*)
 		if [ $only_local_ref = "y" -a $has_r = "n" ]; then
@@ -1160,19 +1164,19 @@ _git_bundle ()
 	esac
 }
 
+__git_checkout_options=
 _git_checkout ()
 {
 	__git_has_doubledash && return
+	test -n "$__git_checkout_options" ||
+	__git_checkout_options=$(__git_list_command_options checkout)
 
 	case "$cur" in
 	--conflict=*)
 		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
 		;;
 	--*)
-		__gitcomp "
-			--quiet --ours --theirs --track --no-track --merge
-			--conflict= --orphan --patch
-			"
+		__gitcomp "$__git_checkout_options"
 		;;
 	*)
 		# check if --track, --no-track, or --no-guess was specified
@@ -1191,11 +1195,15 @@ _git_cherry ()
 	__gitcomp "$(__git_refs)"
 }
 
+__git_cherry_pick_options=
 _git_cherry_pick ()
 {
+	test -n "$__git_cherry_pick_options" ||
+	__git_cherry_pick_options=$(__git_list_command_options cherry-pick)
+
 	case "$cur" in
 	--*)
-		__gitcomp "--edit --no-commit"
+		__gitcomp "$__git_cherry_pick_options"
 		;;
 	*)
 		__gitcomp_nl "$(__git_refs)"
@@ -1203,46 +1211,44 @@ _git_cherry_pick ()
 	esac
 }
 
+__git_clean_options=
 _git_clean ()
 {
 	__git_has_doubledash && return
 
+	test -n "$__git_clean_options" ||
+	__git_clean_options=$(__git_list_command_options clean)
+
 	case "$cur" in
 	--*)
-		__gitcomp "--dry-run --quiet"
+		__gitcomp "$__git_clean_options"
 		return
 		;;
 	esac
 	COMPREPLY=()
 }
 
+__git_clone_options=
 _git_clone ()
 {
+	test -n "$__git_clone_options" ||
+	__git_clone_options=$(__git_list_command_options clone)
+
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--local
-			--no-hardlinks
-			--shared
-			--reference
-			--quiet
-			--no-checkout
-			--bare
-			--mirror
-			--origin
-			--upload-pack
-			--template=
-			--depth
-			"
+		__gitcomp "$__git_clone_options"
 		return
 		;;
 	esac
 	COMPREPLY=()
 }
 
+__git_commit_options=
 _git_commit ()
 {
 	__git_has_doubledash && return
+	test -n "$__git_commit_options" ||
+	__git_commit_options=$(__git_list_command_options commit)
 
 	case "$cur" in
 	--cleanup=*)
@@ -1260,27 +1266,21 @@ _git_commit ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--all --author= --signoff --verify --no-verify
-			--edit --amend --include --only --interactive
-			--dry-run --reuse-message= --reedit-message=
-			--reset-author --file= --message= --template=
-			--cleanup= --untracked-files --untracked-files=
-			--verbose --quiet --fixup= --squash=
-			"
+		__gitcomp "$__git_commit_options"
 		return
 	esac
 	COMPREPLY=()
 }
 
+__git_describe_options=
 _git_describe ()
 {
+	test -n "$__git_describe_options" ||
+	__git_describe_options=$(__git_list_command_options describe)
+
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--all --tags --contains --abbrev= --candidates=
-			--exact-match --debug --long --match --always
-			"
+		__gitcomp "$__git_describe_options"
 		return
 	esac
 	__gitcomp_nl "$(__git_refs)"
@@ -1343,13 +1343,16 @@ _git_difftool ()
 	__git_complete_file
 }
 
-__git_fetch_options="
-	--quiet --verbose --append --upload-pack --force --keep --depth=
-	--tags --no-tags --all --prune --dry-run
-"
+__git_fetch_options=
+__git_compute_fetch_options ()
+{
+	test -n "$__git_fetch_options" ||
+	__git_fetch_options=$(__git_list_command_options fetch)
+}
 
 _git_fetch ()
 {
+	__git_compute_fetch_options
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_fetch_options"
@@ -1359,8 +1362,12 @@ _git_fetch ()
 	__git_complete_remote_or_refspec
 }
 
+__git_format_patch_options=
 _git_format_patch ()
 {
+	test -n "$__git_format_patch_options" ||
+	__git_format_patch_options=$(__git_list_command_options format-patch)
+
 	case "$cur" in
 	--thread=*)
 		__gitcomp "
@@ -1369,46 +1376,37 @@ _git_format_patch ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--stdout --attach --no-attach --thread --thread=
-			--output-directory
-			--numbered --start-number
-			--numbered-files
-			--keep-subject
-			--signoff --signature --no-signature
-			--in-reply-to= --cc=
-			--full-index --binary
-			--not --all
-			--cover-letter
-			--no-prefix --src-prefix= --dst-prefix=
-			--inline --suffix= --ignore-if-in-upstream
-			--subject-prefix=
-			"
+		__gitcomp "$__git_format_patch_options"
 		return
 		;;
 	esac
 	__git_complete_revlist
 }
 
+__git_fsck_options=
 _git_fsck ()
 {
+	test -n "$__git_fsck_options" ||
+	__git_fsck_options=$(__git_list_command_options fsck)
+
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--tags --root --unreachable --cache --no-reflogs --full
-			--strict --verbose --lost-found
-			"
+		__gitcomp "$__git_fsck_options"
 		return
 		;;
 	esac
 	COMPREPLY=()
 }
 
+__git_gc_options=
 _git_gc ()
 {
+	test -n "$__git_gc_options" ||
+	__git_gc_options=$(__git_list_command_options gc)
+
 	case "$cur" in
 	--*)
-		__gitcomp "--prune --aggressive"
+		__gitcomp "$__git_gc_options"
 		return
 		;;
 	esac
@@ -1424,24 +1422,17 @@ __git_match_ctag() {
 	awk "/^${1////\\/}/ { print \$1 }" "$2"
 }
 
+__git_grep_options=
 _git_grep ()
 {
 	__git_has_doubledash && return
 
+	test -n "$__git_grep_options" ||
+	__git_grep_options=$(__git_list_command_options grep)
+
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--cached
-			--text --ignore-case --word-regexp --invert-match
-			--full-name --line-number
-			--extended-regexp --basic-regexp --fixed-strings
-			--perl-regexp
-			--files-with-matches --name-only
-			--files-without-match
-			--max-depth
-			--count
-			--and --or --not --all-match
-			"
+		__gitcomp "$__git_grep_options"
 		return
 		;;
 	esac
@@ -1458,11 +1449,15 @@ _git_grep ()
 	__gitcomp_nl "$(__git_refs)"
 }
 
+__git_help_options=
 _git_help ()
 {
+	test -n "$__git_help_options" ||
+	__git_help_options=$(__git_list_command_options help)
+
 	case "$cur" in
 	--*)
-		__gitcomp "--all --info --man --web"
+		__gitcomp "$__git_help_options"
 		return
 		;;
 	esac
@@ -1475,8 +1470,12 @@ _git_help ()
 		"
 }
 
+__git_init_options=
 _git_init ()
 {
+	test -n "$__git_init_options" ||
+	__git_init_options=$(__git_list_command_options init)
+
 	case "$cur" in
 	--shared=*)
 		__gitcomp "
@@ -1485,26 +1484,24 @@ _git_init ()
 		return
 		;;
 	--*)
-		__gitcomp "--quiet --bare --template= --shared --shared="
+		__gitcomp "$__git_init_options"
 		return
 		;;
 	esac
 	COMPREPLY=()
 }
 
+__git_ls_files_options=
 _git_ls_files ()
 {
 	__git_has_doubledash && return
 
+	test -n "$__git_ls_files_options" ||
+	__git_ls_files_options=$(__git_list_command_options ls-files)
+
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --deleted --modified --others --ignored
-			--stage --directory --no-empty-directory --unmerged
-			--killed --exclude= --exclude-from=
-			--exclude-per-directory= --exclude-standard
-			--error-unmatch --with-tree= --full-name
-			--abbrev --ignored --exclude-per-directory
-			"
+		__gitcomp "$__git_ls_files_options"
 		return
 		;;
 	esac
@@ -1516,8 +1513,18 @@ _git_ls_remote ()
 	__gitcomp_nl "$(__git_remotes)"
 }
 
+__git_ls_tree_options=
 _git_ls_tree ()
 {
+	test -n "$__git_ls_tree_options" ||
+	__git_ls_tree_options=$(__git_list_command_options ls-tree)
+
+	case "$cur" in
+	--*)
+		__gitcomp "$__git_ls_tree_options"
+		return
+		;;
+	esac
 	__git_complete_file
 }
 
@@ -1595,14 +1602,17 @@ _git_log ()
 	__git_complete_revlist
 }
 
-__git_merge_options="
-	--no-commit --no-stat --log --no-log --squash --strategy
-	--commit --stat --no-squash --ff --no-ff --ff-only --edit --no-edit
-"
+__git_merge_options=
+__git_compute_merge_options ()
+{
+	test -n "$__git_merge_options" ||
+	__git_merge_options=$(__git_list_command_options merge)
+}
 
 _git_merge ()
 {
 	__git_complete_strategy && return
+	__git_compute_merge_options
 
 	case "$cur" in
 	--*)
@@ -1632,30 +1642,50 @@ _git_merge_base ()
 	__gitcomp_nl "$(__git_refs)"
 }
 
+__git_mv_options=
 _git_mv ()
 {
+	test -n "$__git_mv_options" ||
+	__git_mv_options=$(__git_list_command_options mv)
+
 	case "$cur" in
 	--*)
-		__gitcomp "--dry-run"
+		__gitcomp "$__git_mv_options"
 		return
 		;;
 	esac
 	COMPREPLY=()
 }
 
+__git_name_rev_options=
 _git_name_rev ()
 {
-	__gitcomp "--tags --all --stdin"
+	test -n "$__git_name_rev_options" ||
+	__git_name_rev_options=$(__git_list_command_options name-rev)
+
+	case "$cur" in
+	--*)
+		__gitcomp "$__git_name_rev_options"
+		return
+		;;
+	esac
 }
 
+__git_notes_options=
+__git_notes_add_options=
+__git_notes_copy_options=
+__git_notes_prune_options=
 _git_notes ()
 {
 	local subcommands='add append copy edit list prune remove show'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 
+	test -n "$__git_notes_options" ||
+	__git_notes_options=$(__git_list_command_options notes)
+
 	case "$subcommand,$cur" in
 	,--*)
-		__gitcomp '--ref'
+		__gitcomp "$__git_notes_options"
 		;;
 	,*)
 		case "${words[cword-1]}" in
@@ -1672,14 +1702,19 @@ _git_notes ()
 		__gitcomp_nl "$(__git_refs)" "" "${cur#*=}"
 		;;
 	add,--*|append,--*)
-		__gitcomp '--file= --message= --reedit-message=
-				--reuse-message='
+		test -n "$__git_notes_add_options" ||
+		__git_notes_add_options=$(__git_list_command_options notes add)
+		__gitcomp "$__git_notes_add_options"
 		;;
 	copy,--*)
-		__gitcomp '--stdin'
+		test -n "$__git_notes_copy_options" ||
+		__git_notes_copy_options=$(__git_list_command_options notes copy)
+		__gitcomp "$__git_notes_copy_options"
 		;;
 	prune,--*)
-		__gitcomp '--dry-run --verbose'
+		test -n "$__git_notes_prune_options" ||
+		__git_notes_prune_options=$(__git_list_command_options notes prune)
+		__gitcomp "$__git_notes_prune_options"
 		;;
 	prune,*)
 		;;
@@ -1699,6 +1734,9 @@ _git_pull ()
 {
 	__git_complete_strategy && return
 
+	__git_compute_merge_options
+	__git_compute_fetch_options
+
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1712,8 +1750,12 @@ _git_pull ()
 	__git_complete_remote_or_refspec
 }
 
+__git_push_options=
 _git_push ()
 {
+	test -n "$__git_push_options" ||
+	__git_push_options=$(__git_list_command_options push)
+
 	case "$prev" in
 	--repo)
 		__gitcomp_nl "$(__git_remotes)"
@@ -1725,10 +1767,7 @@ _git_push ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--all --mirror --tags --dry-run --force --verbose
-			--receive-pack= --repo= --set-upstream
-		"
+		__gitcomp "$__git_push_options"
 		return
 		;;
 	esac
@@ -2313,37 +2352,49 @@ _git_replace ()
 	__gitcomp_nl "$(__git_refs)"
 }
 
+__git_reset_options=
 _git_reset ()
 {
 	__git_has_doubledash && return
 
+	test -n "$__git_reset_options" ||
+	__git_reset_options=$(__git_list_command_options reset)
+
 	case "$cur" in
 	--*)
-		__gitcomp "--merge --mixed --hard --soft --patch"
+		__gitcomp "$__git_reset_options"
 		return
 		;;
 	esac
 	__gitcomp_nl "$(__git_refs)"
 }
 
+__git_revert_options=
 _git_revert ()
 {
+	test -n "$__git_revert_options" ||
+	__git_revert_options=$(__git_list_command_options revert)
+
 	case "$cur" in
 	--*)
-		__gitcomp "--edit --mainline --no-edit --no-commit --signoff"
+		__gitcomp "$__git_revert_options"
 		return
 		;;
 	esac
 	__gitcomp_nl "$(__git_refs)"
 }
 
+__git_rm_options=
 _git_rm ()
 {
 	__git_has_doubledash && return
 
+	test -n "$__git_rm_options" ||
+	__git_rm_options=$(__git_list_command_options rm)
+
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+		__gitcomp "$__git_rm_options"
 		return
 		;;
 	esac
@@ -2367,10 +2418,14 @@ _git_shortlog ()
 	__git_complete_revlist
 }
 
+__git_show_options=
 _git_show ()
 {
 	__git_has_doubledash && return
 
+	test -n "$__git_show_options" ||
+	__git_show_options=$(__git_list_command_options show)
+
 	case "$cur" in
 	--pretty=*|--format=*)
 		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
@@ -2378,7 +2433,7 @@ _git_show ()
 		return
 		;;
 	--*)
-		__gitcomp "--pretty= --format= --abbrev-commit --oneline
+		__gitcomp "$__git_show_options
 			$__git_diff_common_options
 			"
 		return
@@ -2387,16 +2442,15 @@ _git_show ()
 	__git_complete_file
 }
 
+__git_show_branch_options=
 _git_show_branch ()
 {
+	test -n "$__git_show_branch_options" ||
+	__git_show_branch_options=$(__git_list_command_options show-branch)
+
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--all --remotes --topo-order --current --more=
-			--list --independent --merge-base --no-name
-			--color --no-color
-			--sha1-name --sparse --topics --reflog
-			"
+		__gitcomp "$__git_show_branch_options"
 		return
 		;;
 	esac
-- 
1.7.10.128.g7945c.dirty
