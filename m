From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v4 6/6] submodule: drop the top-level requirement
Date: Sun, 16 Jun 2013 15:18:18 +0100
Message-ID: <ff294bec3e56e2337353af3c78208f47cb42fb04.1371391740.git.john@keeping.me.uk>
References: <cover.1371391740.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 16:19:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoDo9-0002Ir-OO
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 16:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271Ab3FPOTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 10:19:49 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:43943 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3FPOTs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 10:19:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 7D2C6CDA583;
	Sun, 16 Jun 2013 15:19:48 +0100 (BST)
X-Quarantine-ID: <h0s2lfHV5y2Y>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h0s2lfHV5y2Y; Sun, 16 Jun 2013 15:19:46 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 4CC23CDA599;
	Sun, 16 Jun 2013 15:19:46 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3FE5B161E2F4;
	Sun, 16 Jun 2013 15:19:46 +0100 (BST)
X-Quarantine-ID: <p3BUCqCdD6Ot>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p3BUCqCdD6Ot; Sun, 16 Jun 2013 15:19:44 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 8AEB5161E03F;
	Sun, 16 Jun 2013 15:19:34 +0100 (BST)
X-Mailer: git-send-email 1.8.3.779.g691e267
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
References: <cover.1371391740.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228014>

Use the new rev-parse --prefix option to process all paths given to the
submodule command, dropping the requirement that it be run from the
top-level of the repository.

Since the interpretation of a relative submodule URL depends on whether
or not "remote.origin.url" is configured, explicitly block relative URLs
in "git submodule add" when not at the top level of the working tree.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-submodule.sh             | 135 ++++++++++++++++++++++++++++++++-----------
 t/t7400-submodule-basic.sh   |  80 +++++++++++++++++++++++++
 t/t7401-submodule-summary.sh |  36 ++++++++++++
 t/t7403-submodule-sync.sh    |  72 +++++++++++++++++++++++
 t/t7406-submodule-update.sh  |  15 +++++
 t/t7407-submodule-foreach.sh |  16 +++++
 6 files changed, 319 insertions(+), 35 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bdb438b..7756d81 100755
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
+			target=${target#"$curdir"/}
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
 
@@ -335,9 +383,14 @@ cmd_add()
 		usage
 	fi
 
+	is_absolute_path "$sm_path" || sm_path="$wt_prefix$sm_path"
+
 	# assure repo is absolute or relative to parent
 	case "$repo" in
 	./*|../*)
+		test -z "$wt_prefix" ||
+		die "$(gettext "Relative path can only be used from the toplevel of the working tree")"
+
 		# dereference source url relative to parent's url
 		realrepo=$(resolve_relative_url "$repo") || exit
 		;;
@@ -471,21 +524,23 @@ cmd_foreach()
 		die_if_unmatched "$mode"
 		if test -e "$sm_path"/.git
 		then
-			say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
+			displaypath=$(relative_path "$sm_path")
+			say "$(eval_gettext "Entering '\$prefix\$displaypath'")"
 			name=$(module_name "$sm_path")
 			(
 				prefix="$prefix$sm_path/"
 				clear_local_git_env
-				# we make $path available to scripts ...
-				path=$sm_path
 				cd "$sm_path" &&
+				sm_path=$(relative_path "$sm_path") &&
+				# we make $path available to scripts ...
+				path=$sm_path &&
 				eval "$@" &&
 				if test -n "$recursive"
 				then
 					cmd_foreach "--recursive" "$@"
 				fi
 			) <&3 3<&- ||
-			die "$(eval_gettext "Stopping at '\$prefix\$sm_path'; script returned non-zero status.")"
+			die "$(eval_gettext "Stopping at '\$prefix\$displaypath'; script returned non-zero status.")"
 		fi
 	done
 }
@@ -524,12 +579,14 @@ cmd_init()
 		die_if_unmatched "$mode"
 		name=$(module_name "$sm_path") || exit
 
+		displaypath=$(relative_path "$sm_path")
+
 		# Copy url setting when it is not set yet
 		if test -z "$(git config "submodule.$name.url")"
 		then
 			url=$(git config -f .gitmodules submodule."$name".url)
 			test -z "$url" &&
-			die "$(eval_gettext "No url found for submodule path '\$sm_path' in .gitmodules")"
+			die "$(eval_gettext "No url found for submodule path '\$displaypath' in .gitmodules")"
 
 			# Possibly a url relative to parent
 			case "$url" in
@@ -538,9 +595,9 @@ cmd_init()
 				;;
 			esac
 			git config submodule."$name".url "$url" ||
-			die "$(eval_gettext "Failed to register url for submodule path '\$sm_path'")"
+			die "$(eval_gettext "Failed to register url for submodule path '\$displaypath'")"
 
-			say "$(eval_gettext "Submodule '\$name' (\$url) registered for path '\$sm_path'")"
+			say "$(eval_gettext "Submodule '\$name' (\$url) registered for path '\$displaypath'")"
 		fi
 
 		# Copy "update" setting when it is not set yet
@@ -548,7 +605,7 @@ cmd_init()
 		test -z "$upd" ||
 		test -n "$(git config submodule."$name".update)" ||
 		git config submodule."$name".update "$upd" ||
-		die "$(eval_gettext "Failed to register update mode for submodule path '\$sm_path'")"
+		die "$(eval_gettext "Failed to register update mode for submodule path '\$displaypath'")"
 	done
 }
 
@@ -594,27 +651,29 @@ cmd_deinit()
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
@@ -623,7 +682,7 @@ cmd_deinit()
 			# the user later decides to init this submodule again
 			url=$(git config submodule."$name".url)
 			git config --remove-section submodule."$name" 2>/dev/null &&
-			say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$sm_path'")"
+			say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
 		fi
 	done
 }
@@ -717,9 +776,11 @@ cmd_update()
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
 
@@ -728,7 +789,7 @@ cmd_update()
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" != "0" &&
-			say "$(eval_gettext "Submodule path '\$prefix\$sm_path' not initialized
+			say "$(eval_gettext "Submodule path '\$displaypath' not initialized
 Maybe you want to use 'update --init'?")"
 			continue
 		fi
@@ -741,7 +802,7 @@ Maybe you want to use 'update --init'?")"
 		else
 			subsha1=$(clear_local_git_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
-			die "$(eval_gettext "Unable to find current revision in submodule path '\$prefix\$sm_path'")"
+			die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
 		fi
 
 		if test -n "$remote"
@@ -774,7 +835,7 @@ Maybe you want to use 'update --init'?")"
 				(clear_local_git_env; cd "$sm_path" &&
 					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
 					 test -z "$rev") || git-fetch)) ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$prefix\$sm_path'")"
+				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
 			fi
 
 			# Is this something we just cloned?
@@ -788,20 +849,20 @@ Maybe you want to use 'update --init'?")"
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
 
@@ -828,7 +889,7 @@ Maybe you want to use 'update --init'?")"
 			res=$?
 			if test $res -gt 0
 			then
-				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$prefix\$sm_path'")"
+				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$displaypath'")"
 				if test $res -eq 1
 				then
 					err="${err};$die_msg"
@@ -942,6 +1003,7 @@ cmd_summary() {
 	fi
 
 	cd_to_toplevel
+	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
 	# Get modified modules cared by user
 	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
 		sane_egrep '^:([0-7]* )?160000' |
@@ -991,16 +1053,18 @@ cmd_summary() {
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
@@ -1029,12 +1093,12 @@ cmd_summary() {
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
@@ -1118,7 +1182,7 @@ cmd_status()
 		die_if_unmatched "$mode"
 		name=$(module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
-		displaypath="$prefix$sm_path"
+		displaypath=$(relative_path "$prefix$sm_path")
 		if test "$stage" = U
 		then
 			say "U$sha1 $displaypath"
@@ -1213,7 +1277,8 @@ cmd_sync()
 
 		if git config "submodule.$name.url" >/dev/null 2>/dev/null
 		then
-			say "$(eval_gettext "Synchronizing submodule url for '\$prefix\$sm_path'")"
+			displaypath=$(relative_path "$prefix$sm_path")
+			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
 			git config submodule."$name".url "$super_config_url"
 
 			if test -e "$sm_path"/.git
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index ff26535..a38fd92 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -212,6 +212,32 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	test_cmp empty untracked
 '
 
+test_expect_success 'submodule add in subdirectory' '
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
+test_expect_success 'submodule add in subdirectory with relative path should fail' '
+	(
+		cd addtest/sub &&
+		test_must_fail git submodule add ../../ submod3 2>../../output.err
+	) &&
+	test_i18ngrep toplevel output.err
+'
+
 test_expect_success 'setup - add an example entry to .gitmodules' '
 	GIT_CONFIG=.gitmodules \
 	git config submodule.example.url git://example.com/init.git
@@ -319,6 +345,26 @@ test_expect_success 'status should be "up-to-date" after update' '
 	grep "^ $rev1" list
 '
 
+test_expect_success 'status "up-to-date" from subdirectory' '
+	mkdir -p sub &&
+	(
+		cd sub &&
+		git submodule status >../list
+	) &&
+	grep "^ $rev1" list &&
+	grep "\\.\\./init" list
+'
+
+test_expect_success 'status "up-to-date" from subdirectory with path' '
+	mkdir -p sub &&
+	(
+		cd sub &&
+		git submodule status ../init >../list
+	) &&
+	grep "^ $rev1" list &&
+	grep "\\.\\./init" list
+'
+
 test_expect_success 'status should be "modified" after submodule commit' '
 	(
 		cd init &&
@@ -399,6 +445,25 @@ test_expect_success 'update --init' '
 	git rev-parse --resolve-git-dir init/.git
 '
 
+test_expect_success 'update --init from subdirectory' '
+	mv init init2 &&
+	git config -f .gitmodules submodule.example.url "$(pwd)/init2" &&
+	git config --remove-section submodule.example &&
+	test_must_fail git config submodule.example.url &&
+
+	mkdir -p sub &&
+	(
+		cd sub &&
+		git submodule update ../init >update.out &&
+		cat update.out &&
+		test_i18ngrep "not initialized" update.out &&
+		test_must_fail git rev-parse --resolve-git-dir ../init/.git &&
+
+		git submodule update --init ../init
+	) &&
+	git rev-parse --resolve-git-dir init/.git
+'
+
 test_expect_success 'do not add files from a submodule' '
 
 	git reset --hard &&
@@ -772,6 +837,21 @@ test_expect_success 'submodule deinit should remove the whole submodule section
 	rmdir init
 '
 
+test_expect_success 'submodule deinit from subdirectory' '
+	git submodule update --init &&
+	git config submodule.example.foo bar &&
+	mkdir -p sub &&
+	(
+		cd sub &&
+		git submodule deinit ../init >../output
+	) &&
+	grep "\\.\\./init" output &&
+	test -z "$(git config --get-regexp "submodule\.example\.")" &&
+	test -n "$(git config --get-regexp "submodule\.example2\.")" &&
+	test -f example2/.git &&
+	rmdir init
+'
+
 test_expect_success 'submodule deinit . deinits all initialized submodules' '
 	git submodule update --init &&
 	git config submodule.example.foo bar &&
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index c328726..ac2434c 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -45,6 +45,42 @@ EOF
 	test_cmp expected actual
 "
 
+test_expect_success 'added submodule (subdirectory)' "
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
+"
+
+test_expect_success 'added submodule (subdirectory only)' "
+	(
+		cd sub &&
+		git submodule summary . >../actual
+	) &&
+	>expected &&
+	test_cmp expected actual
+"
+
+test_expect_success 'added submodule (subdirectory with explicit path)' "
+	(
+		cd sub &&
+		git submodule summary ../sm1 >../actual
+	) &&
+	cat >expected <<-EOF &&
+* ../sm1 0000000...$head1 (2):
+  > Add foo2
+
+EOF
+	test_cmp expected actual
+"
+
 commit_file sm1 &&
 head2=$(add_file sm1 foo3)
 
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index bf90098..79bc135 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -61,6 +61,19 @@ test_expect_success 'change submodule' '
 	)
 '
 
+reset_submodule_urls () {
+	local root
+	root=$(pwd) &&
+	(
+		cd super-clone/submodule &&
+		git config remote.origin.url "$root/submodule"
+	) &&
+	(
+		cd super-clone/submodule/sub-submodule &&
+		git config remote.origin.url "$root/submodule"
+	)
+}
+
 test_expect_success 'change submodule url' '
 	(
 		cd super &&
@@ -132,6 +145,65 @@ test_expect_success '"git submodule sync --recursive" should update all submodul
 	)
 '
 
+test_expect_success 'reset submodule URLs' '
+	reset_submodule_urls super-clone
+'
+
+test_expect_success '"git submodule sync" should update submodule URLs - subdirectory' '
+	(
+		cd super-clone &&
+		git pull --no-recurse-submodules &&
+		mkdir -p sub &&
+		cd sub &&
+		git submodule sync >../../output
+	) &&
+	grep "\\.\\./submodule" output &&
+	test -d "$(
+		cd super-clone/submodule &&
+		git config remote.origin.url
+	)" &&
+	test ! -d "$(
+		cd super-clone/submodule/sub-submodule &&
+		git config remote.origin.url
+	)" &&
+	(
+		cd super-clone/submodule &&
+		git checkout master &&
+		git pull
+	) &&
+	(
+		cd super-clone &&
+		test -d "$(git config submodule.submodule.url)"
+	)
+'
+
+test_expect_success '"git submodule sync --recursive" should update all submodule URLs - subdirectory' '
+	(
+		cd super-clone &&
+		(
+			cd submodule &&
+			git pull --no-recurse-submodules
+		) &&
+		mkdir -p sub &&
+		cd sub &&
+		git submodule sync --recursive >../../output
+	) &&
+	grep "\\.\\./submodule/sub-submodule" output &&
+	test -d "$(
+		cd super-clone/submodule &&
+		git config remote.origin.url
+	)" &&
+	test -d "$(
+		cd super-clone/submodule/sub-submodule &&
+		git config remote.origin.url
+	)" &&
+	(
+		cd super-clone/submodule/sub-submodule &&
+		git checkout master &&
+		git pull
+	)
+'
+
 test_expect_success '"git submodule sync" should update known submodule URLs' '
 	(
 		cd empty-clone &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index a4ffea0..cdb0538 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -80,6 +80,21 @@ test_expect_success 'submodule update detaching the HEAD ' '
 	)
 '
 
+test_expect_success 'submodule update from subdirectory' '
+	(cd super/submodule &&
+	 git reset --hard HEAD~1
+	) &&
+	mkdir super/sub &&
+	(cd super/sub &&
+	 (cd ../submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update ../submodule &&
+	 cd ../submodule &&
+	 ! compare_head
+	)
+'
+
 apos="'";
 test_expect_success 'submodule update does not fetch already present commits' '
 	(cd submodule &&
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 107b4b7..91d4fd1 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -80,6 +80,22 @@ test_expect_success 'test basic "submodule foreach" usage' '
 	test_i18ncmp expect actual
 '
 
+cat >expect <<EOF
+Entering '../sub1'
+$pwd/clone-foo1-../sub1-$sub1sha1
+Entering '../sub3'
+$pwd/clone-foo3-../sub3-$sub3sha1
+EOF
+
+test_expect_success 'test "submodule foreach" from subdirectory' '
+	mkdir clone/sub &&
+	(
+		cd clone/sub &&
+		git submodule foreach "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'setup nested submodules' '
 	git clone submodule nested1 &&
 	git clone submodule nested2 &&
-- 
1.8.3.779.g691e267
