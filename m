From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 2/2] submodule: drop the top-level requirement
Date: Thu, 18 Apr 2013 20:50:42 +0100
Message-ID: <6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk>
References: <cover.1365539059.git.john@keeping.me.uk>
 <cover.1366314439.git.john@keeping.me.uk>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 21:51:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USurq-0007Ch-F0
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 21:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355Ab3DRTve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 15:51:34 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:35341 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627Ab3DRTvd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 15:51:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A85D1CDA5BF;
	Thu, 18 Apr 2013 20:51:32 +0100 (BST)
X-Quarantine-ID: <s1z4oXoM5BKD>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s1z4oXoM5BKD; Thu, 18 Apr 2013 20:51:26 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 906F1CDA618;
	Thu, 18 Apr 2013 20:51:14 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.424.g1899e5e.dirty
In-Reply-To: <cover.1366314439.git.john@keeping.me.uk>
In-Reply-To: <cover.1366314439.git.john@keeping.me.uk>
References: <cover.1366314439.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221688>

Use the new rev-parse --prefix option to process all paths given to the
submodule command, dropping the requirement that it be run from the
top-level of the repository.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
Changes since v2:
    - Handle relative paths given to "submodule add --reference=./..."
    - Check for absolute path before prepending $wt_prefix in cmd_add
    - Export relative sm_path in cmd_foreach
    - Change displayed sm_path to be relative
    - Move a mkdir out of a subshell in t7400

I'm not sure if the relative_path function here is sufficient on
Windows.  We should be okay with the "target" argument since that comes
from git-ls-files but I think we're in trouble if "git rev-parse
--show-prefix" output the prefix with '\' instead of '/'.

 git-submodule.sh             | 113 ++++++++++++++++++++++++++++++++-----------
 t/t7400-submodule-basic.sh   |  27 +++++++++++
 t/t7401-submodule-summary.sh |  14 ++++++
 3 files changed, 127 insertions(+), 27 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..0eee703 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -14,10 +14,13 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
 OPTIONS_SPEC=
+SUBDIRECTORY_OK=Yes
 . git-sh-setup
 . git-sh-i18n
 . git-parse-remote
 require_work_tree
+wt_prefix=$(git rev-parse --show-prefix)
+cd_to_toplevel
 
 command=
 branch=
@@ -106,12 +109,48 @@ resolve_relative_url ()
 	echo "${is_relative:+${up_path}}${remoteurl#./}"
 }
 
+# Resolve a path to be relative to another path.  This is intended for
+# converting submodule paths when git-submodule is run in a subdirectory
+# and only handles paths where the directory separator is '/'.
+#
+# The output is the first argument as a path relative to the second argument,
+# which defaults to $wt_prefix if it is omitted.
+relative_path ()
+{
+	local target curdir result
+	target=$1
+	curdir=${2-$wt_prefix}
+	curdir=${curdir%/}
+	result=
+
+	while test -n "$curdir"
+	do
+		case "$target" in
+		"$curdir/"*)
+			target=${target#$curdir/}
+			break
+			;;
+		esac
+
+		result="${result}../"
+		if test "$curdir" = "${curdir%/*}"
+		then
+			curdir=
+		else
+			curdir="${curdir%/*}"
+		fi
+	done
+
+	echo "$result$target"
+}
+
 #
 # Get submodule info for registered submodules
 # $@ = path to limit submodule list
 #
 module_list()
 {
+	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
 	(
 		git ls-files --error-unmatch --stage -- "$@" ||
 		echo "unmatched pathspec exists"
@@ -282,6 +321,7 @@ isnumber()
 cmd_add()
 {
 	# parse $args after "submodule ... add".
+	reference_path=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -298,11 +338,11 @@ cmd_add()
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
-			reference="--reference=$2"
+			reference_path=$2
 			shift
 			;;
 		--reference=*)
-			reference="$1"
+			reference_path="${1#--reference=}"
 			;;
 		--name)
 			case "$2" in '') usage ;; esac
@@ -323,6 +363,14 @@ cmd_add()
 		shift
 	done
 
+	if test -n "$reference_path"
+	then
+		is_absolute_path "$reference_path" ||
+		reference_path="$wt_prefix$reference_path"
+
+		reference="--reference=$reference_path"
+	fi
+
 	repo=$1
 	sm_path=$2
 
@@ -335,6 +383,8 @@ cmd_add()
 		usage
 	fi
 
+	is_absolute_path "$sm_path" || sm_path="$wt_prefix$sm_path"
+
 	# assure repo is absolute or relative to parent
 	case "$repo" in
 	./*|../*)
@@ -479,6 +529,7 @@ cmd_foreach()
 				# we make $path available to scripts ...
 				path=$sm_path
 				cd "$sm_path" &&
+				sm_path=$(relative_path "$sm_path") &&
 				eval "$@" &&
 				if test -n "$recursive"
 				then
@@ -594,27 +645,29 @@ cmd_deinit()
 		die_if_unmatched "$mode"
 		name=$(module_name "$sm_path") || exit
 
+		displaypath=$(relative_path "$sm_path")
+
 		# Remove the submodule work tree (unless the user already did it)
 		if test -d "$sm_path"
 		then
 			# Protect submodules containing a .git directory
 			if test -d "$sm_path/.git"
 			then
-				echo >&2 "$(eval_gettext "Submodule work tree '\$sm_path' contains a .git directory")"
+				echo >&2 "$(eval_gettext "Submodule work tree '\$displaypath' contains a .git directory")"
 				die "$(eval_gettext "(use 'rm -rf' if you really want to remove it including all of its history)")"
 			fi
 
 			if test -z "$force"
 			then
 				git rm -qn "$sm_path" ||
-				die "$(eval_gettext "Submodule work tree '\$sm_path' contains local modifications; use '-f' to discard them")"
+				die "$(eval_gettext "Submodule work tree '\$displaypath' contains local modifications; use '-f' to discard them")"
 			fi
 			rm -rf "$sm_path" &&
-			say "$(eval_gettext "Cleared directory '\$sm_path'")" ||
-			say "$(eval_gettext "Could not remove submodule work tree '\$sm_path'")"
+			say "$(eval_gettext "Cleared directory '\$displaypath'")" ||
+			say "$(eval_gettext "Could not remove submodule work tree '\$displaypath'")"
 		fi
 
-		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$sm_path'")"
+		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$displaypath'")"
 
 		# Remove the .git/config entries (unless the user already did it)
 		if test -n "$(git config --get-regexp submodule."$name\.")"
@@ -623,7 +676,7 @@ cmd_deinit()
 			# the user later decides to init this submodule again
 			url=$(git config submodule."$name".url)
 			git config --remove-section submodule."$name" 2>/dev/null &&
-			say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$sm_path'")"
+			say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
 		fi
 	done
 }
@@ -717,9 +770,11 @@ cmd_update()
 			update_module=$(git config submodule."$name".update)
 		fi
 
+		displaypath=$(relative_path "$prefix$sm_path")
+
 		if test "$update_module" = "none"
 		then
-			echo "Skipping submodule '$prefix$sm_path'"
+			echo "Skipping submodule '$displaypath'"
 			continue
 		fi
 
@@ -728,7 +783,7 @@ cmd_update()
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" != "0" &&
-			say "$(eval_gettext "Submodule path '\$prefix\$sm_path' not initialized
+			say "$(eval_gettext "Submodule path '\$displaypath' not initialized
 Maybe you want to use 'update --init'?")"
 			continue
 		fi
@@ -741,7 +796,7 @@ Maybe you want to use 'update --init'?")"
 		else
 			subsha1=$(clear_local_git_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
-			die "$(eval_gettext "Unable to find current revision in submodule path '\$prefix\$sm_path'")"
+			die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
 		fi
 
 		if test -n "$remote"
@@ -774,7 +829,7 @@ Maybe you want to use 'update --init'?")"
 				(clear_local_git_env; cd "$sm_path" &&
 					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
 					 test -z "$rev") || git-fetch)) ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$prefix\$sm_path'")"
+				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
 			fi
 
 			# Is this something we just cloned?
@@ -788,20 +843,20 @@ Maybe you want to use 'update --init'?")"
 			case "$update_module" in
 			rebase)
 				command="git rebase"
-				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$prefix\$sm_path'")"
-				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': rebased into '\$sha1'")"
+				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
+				say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
 				must_die_on_failure=yes
 				;;
 			merge)
 				command="git merge"
-				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$prefix\$sm_path'")"
-				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged in '\$sha1'")"
+				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
+				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
 				must_die_on_failure=yes
 				;;
 			*)
 				command="git checkout $subforce -q"
-				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$prefix\$sm_path'")"
-				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': checked out '\$sha1'")"
+				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
+				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
 				;;
 			esac
 
@@ -828,7 +883,7 @@ Maybe you want to use 'update --init'?")"
 			res=$?
 			if test $res -gt 0
 			then
-				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$prefix\$sm_path'")"
+				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$displaypath'")"
 				if test $res -eq 1
 				then
 					err="${err};$die_msg"
@@ -942,6 +997,7 @@ cmd_summary() {
 	fi
 
 	cd_to_toplevel
+	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
 	# Get modified modules cared by user
 	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
 		sane_egrep '^:([0-7]* )?160000' |
@@ -991,16 +1047,18 @@ cmd_summary() {
 		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_dst^0 >/dev/null &&
 		missing_dst=t
 
+		display_name=$(relative_path "$name")
+
 		total_commits=
 		case "$missing_src,$missing_dst" in
 		t,)
-			errmsg="$(eval_gettext "  Warn: \$name doesn't contain commit \$sha1_src")"
+			errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commit \$sha1_src")"
 			;;
 		,t)
-			errmsg="$(eval_gettext "  Warn: \$name doesn't contain commit \$sha1_dst")"
+			errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commit \$sha1_dst")"
 			;;
 		t,t)
-			errmsg="$(eval_gettext "  Warn: \$name doesn't contain commits \$sha1_src and \$sha1_dst")"
+			errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commits \$sha1_src and \$sha1_dst")"
 			;;
 		*)
 			errmsg=
@@ -1029,12 +1087,12 @@ cmd_summary() {
 			submodule="$(gettext "submodule")"
 			if test $mod_dst = 160000
 			then
-				echo "* $name $sha1_abbr_src($blob)->$sha1_abbr_dst($submodule)$total_commits:"
+				echo "* $display_name $sha1_abbr_src($blob)->$sha1_abbr_dst($submodule)$total_commits:"
 			else
-				echo "* $name $sha1_abbr_src($submodule)->$sha1_abbr_dst($blob)$total_commits:"
+				echo "* $display_name $sha1_abbr_src($submodule)->$sha1_abbr_dst($blob)$total_commits:"
 			fi
 		else
-			echo "* $name $sha1_abbr_src...$sha1_abbr_dst$total_commits:"
+			echo "* $display_name $sha1_abbr_src...$sha1_abbr_dst$total_commits:"
 		fi
 		if test -n "$errmsg"
 		then
@@ -1118,7 +1176,7 @@ cmd_status()
 		die_if_unmatched "$mode"
 		name=$(module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
-		displaypath="$prefix$sm_path"
+		displaypath=$(relative_path "$prefix$sm_path")
 		if test "$stage" = U
 		then
 			say "U$sha1 $displaypath"
@@ -1213,7 +1271,8 @@ cmd_sync()
 
 		if git config "submodule.$name.url" >/dev/null 2>/dev/null
 		then
-			say "$(eval_gettext "Synchronizing submodule url for '\$prefix\$sm_path'")"
+			displaypath=$(relative_path "$prefix$sm_path")
+			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
 			git config submodule."$name".url "$super_config_url"
 
 			if test -e "$sm_path"/.git
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index ff26535..ca0a6ab 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -212,6 +212,24 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	test_cmp empty untracked
 '
 
+test_expect_success 'submodule add in subdir' '
+	echo "refs/heads/master" >expect &&
+	>empty &&
+
+	mkdir addtest/sub &&
+	(
+		cd addtest/sub &&
+		git submodule add "$submodurl" ../realsubmod3 &&
+		git submodule init
+	) &&
+
+	rm -f heads head untracked &&
+	inspect addtest/realsubmod3 ../.. &&
+	test_cmp expect heads &&
+	test_cmp expect head &&
+	test_cmp empty untracked
+'
+
 test_expect_success 'setup - add an example entry to .gitmodules' '
 	GIT_CONFIG=.gitmodules \
 	git config submodule.example.url git://example.com/init.git
@@ -319,6 +337,15 @@ test_expect_success 'status should be "up-to-date" after update' '
 	grep "^ $rev1" list
 '
 
+test_expect_success 'status works correctly from a subdirectory' '
+	mkdir sub &&
+	(
+		cd sub &&
+		git submodule status >../list
+	) &&
+	grep "^ $rev1" list
+'
+
 test_expect_success 'status should be "modified" after submodule commit' '
 	(
 		cd init &&
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 30b429e..992b66b 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -45,6 +45,20 @@ EOF
 	test_cmp expected actual
 "
 
+test_expect_success 'run summary from subdir' '
+	mkdir sub &&
+	(
+		cd sub &&
+		git submodule summary >../actual
+	) &&
+	cat >expected <<-EOF &&
+* ../sm1 0000000...$head1 (2):
+  > Add foo2
+
+EOF
+	test_cmp expected actual
+'
+
 commit_file sm1 &&
 head2=$(add_file sm1 foo3)
 
-- 
1.8.2.1.424.g1899e5e.dirty
