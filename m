From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] git-submodule.sh: Don't use $path variable in eval_gettext
 string
Date: Tue, 17 Apr 2012 19:00:58 +0100
Message-ID: <4F8DAFDA.1020108@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bwalton@artsci.utoronto.ca, Johannes Sixt <j6t@kdbg.org>,
	Jens.Lehmann@web.de, avarab@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:51:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKDV6-0005xl-Gk
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104Ab2DQSvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 14:51:31 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:37844 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752881Ab2DQSv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 14:51:29 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SKDUs-0007Xf-gR; Tue, 17 Apr 2012 18:51:28 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195791>


The eval_gettext (and eval_gettextln) i18n shell functions call
git-sh-i18n--envsubst to process the variable references in the
string parameter. Unfortunately, environment variables are case
insensitive on windows, which leads to failure on cygwin when
eval_gettext exports $path.

Commit df599e9 (Windows: teach getenv to do a case-sensitive search,
06-06-2011) attempts to solve this problem on MinGW by overriding
the system getenv() function to allow git-sh-i18n--envsubst to read
$path rather than $PATH from the environment. However, this commit
does not address cygwin at all and, furthermore, does not fix all
problems on MinGW.

In particular, when executing test #38 in t7400-submodule-basic.sh,
an 'git-sh-i18n-envsubst.exe - Unable To Locate Component' dialog
pops up saying that the application "failed to start because
libiconv2.dll was not found." After studying the voluminous trace
output from the process monitor, it is clear that the system is
attempting to use $path, rather than $PATH, to search for the DLL
file. (Note that, after dismissing the dialog, the test passes
anyway!)

As an alternative, we finesse the problem by renaming the $path
variable to $sm_path (submodule path). This fixes the problem on
MinGW along with all test failures on cygwin (t7400.{7,32,34},
t7406.3 and t7407.{2,6}). We note that the foreach subcommand
provides $path to user scripts (ie it is part of the API), so we
can't simply rename it to $sm_path.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

This patch is based on the next branch, since there is a (simple)
conflict with Ben's commit c5bc42b9 ("Avoid bug in Solaris xpg4/sed
as used in submodule", 09-04-2012).

ATB,
Ramsay Jones

 git-submodule.sh |  161 +++++++++++++++++++++++++++---------------------------
 1 file changed, 82 insertions(+), 79 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3d94a14..64a70d6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -101,11 +101,12 @@ module_list()
 module_name()
 {
 	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
+	sm_path="$1"
 	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
 	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
 	test -z "$name" &&
-	die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$path'")"
+	die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$sm_path'")"
 	echo "$name"
 }
 
@@ -119,7 +120,7 @@ module_name()
 #
 module_clone()
 {
-	path=$1
+	sm_path=$1
 	url=$2
 	reference="$3"
 	quiet=
@@ -130,8 +131,8 @@ module_clone()
 
 	gitdir=
 	gitdir_base=
-	name=$(module_name "$path" 2>/dev/null)
-	test -n "$name" || name="$path"
+	name=$(module_name "$sm_path" 2>/dev/null)
+	test -n "$name" || name="$sm_path"
 	base_name=$(dirname "$name")
 
 	gitdir=$(git rev-parse --git-dir)
@@ -140,17 +141,17 @@ module_clone()
 
 	if test -d "$gitdir"
 	then
-		mkdir -p "$path"
+		mkdir -p "$sm_path"
 		rm -f "$gitdir/index"
 	else
 		mkdir -p "$gitdir_base"
 		git clone $quiet -n ${reference:+"$reference"} \
-			--separate-git-dir "$gitdir" "$url" "$path" ||
-		die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
+			--separate-git-dir "$gitdir" "$url" "$sm_path" ||
+		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
 	fi
 
 	a=$(cd "$gitdir" && pwd)/
-	b=$(cd "$path" && pwd)/
+	b=$(cd "$sm_path" && pwd)/
 	# normalize Windows-style absolute paths to POSIX-style absolute paths
 	case $a in [a-zA-Z]:/*) a=/${a%%:*}${a#*:} ;; esac
 	case $b in [a-zA-Z]:/*) b=/${b%%:*}${b#*:} ;; esac
@@ -169,10 +170,10 @@ module_clone()
 
 	# Turn each leading "*/" component into "../"
 	rel=$(echo $b | sed -e 's|[^/][^/]*|..|g')
-	echo "gitdir: $rel/$a" >"$path/.git"
+	echo "gitdir: $rel/$a" >"$sm_path/.git"
 
 	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
-	(clear_local_git_env; cd "$path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
+	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
 }
 
 #
@@ -223,14 +224,14 @@ cmd_add()
 	done
 
 	repo=$1
-	path=$2
+	sm_path=$2
 
-	if test -z "$path"; then
-		path=$(echo "$repo" |
+	if test -z "$sm_path"; then
+		sm_path=$(echo "$repo" |
 			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
 	fi
 
-	if test -z "$repo" -o -z "$path"; then
+	if test -z "$repo" -o -z "$sm_path"; then
 		usage
 	fi
 
@@ -251,7 +252,7 @@ cmd_add()
 
 	# normalize path:
 	# multiple //; leading ./; /./; /../; trailing /
-	path=$(printf '%s/\n' "$path" |
+	sm_path=$(printf '%s/\n' "$sm_path" |
 		sed -e '
 			s|//*|/|g
 			s|^\(\./\)*||
@@ -261,49 +262,49 @@ cmd_add()
 			tstart
 			s|/*$||
 		')
-	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
-	die "$(eval_gettext "'\$path' already exists in the index")"
+	git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
+	die "$(eval_gettext "'\$sm_path' already exists in the index")"
 
-	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" > /dev/null 2>&1
+	if test -z "$force" && ! git add --dry-run --ignore-missing "$sm_path" > /dev/null 2>&1
 	then
 		eval_gettextln "The following path is ignored by one of your .gitignore files:
-\$path
+\$sm_path
 Use -f if you really want to add it." >&2
 		exit 1
 	fi
 
 	# perhaps the path exists and is already a git repo, else clone it
-	if test -e "$path"
+	if test -e "$sm_path"
 	then
-		if test -d "$path"/.git -o -f "$path"/.git
+		if test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			eval_gettextln "Adding existing repo at '\$path' to the index"
+			eval_gettextln "Adding existing repo at '\$sm_path' to the index"
 		else
-			die "$(eval_gettext "'\$path' already exists and is not a valid git repo")"
+			die "$(eval_gettext "'\$sm_path' already exists and is not a valid git repo")"
 		fi
 
 	else
 
-		module_clone "$path" "$realrepo" "$reference" || exit
+		module_clone "$sm_path" "$realrepo" "$reference" || exit
 		(
 			clear_local_git_env
-			cd "$path" &&
+			cd "$sm_path" &&
 			# ash fails to wordsplit ${branch:+-b "$branch"...}
 			case "$branch" in
 			'') git checkout -f -q ;;
 			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
 			esac
-		) || die "$(eval_gettext "Unable to checkout submodule '\$path'")"
+		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
 	fi
-	git config submodule."$path".url "$realrepo"
+	git config submodule."$sm_path".url "$realrepo"
 
-	git add $force "$path" ||
-	die "$(eval_gettext "Failed to add submodule '\$path'")"
+	git add $force "$sm_path" ||
+	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"
 
-	git config -f .gitmodules submodule."$path".path "$path" &&
-	git config -f .gitmodules submodule."$path".url "$repo" &&
+	git config -f .gitmodules submodule."$sm_path".path "$sm_path" &&
+	git config -f .gitmodules submodule."$sm_path".url "$repo" &&
 	git add --force .gitmodules ||
-	die "$(eval_gettext "Failed to register submodule '\$path'")"
+	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
 }
 
 #
@@ -341,23 +342,25 @@ cmd_foreach()
 	exec 3<&0
 
 	module_list |
-	while read mode sha1 stage path
+	while read mode sha1 stage sm_path
 	do
-		if test -e "$path"/.git
+		if test -e "$sm_path"/.git
 		then
-			say "$(eval_gettext "Entering '\$prefix\$path'")"
-			name=$(module_name "$path")
+			say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
+			name=$(module_name "$sm_path")
 			(
-				prefix="$prefix$path/"
+				prefix="$prefix$sm_path/"
 				clear_local_git_env
-				cd "$path" &&
+				# we make $path available to scripts ...
+				path=$sm_path
+				cd "$sm_path" &&
 				eval "$@" &&
 				if test -n "$recursive"
 				then
 					cmd_foreach "--recursive" "$@"
 				fi
 			) <&3 3<&- ||
-			die "$(eval_gettext "Stopping at '\$path'; script returned non-zero status.")"
+			die "$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"
 		fi
 	done
 }
@@ -391,15 +394,15 @@ cmd_init()
 	done
 
 	module_list "$@" |
-	while read mode sha1 stage path
+	while read mode sha1 stage sm_path
 	do
 		# Skip already registered paths
-		name=$(module_name "$path") || exit
+		name=$(module_name "$sm_path") || exit
 		if test -z "$(git config "submodule.$name.url")"
 		then
 			url=$(git config -f .gitmodules submodule."$name".url)
 			test -z "$url" &&
-			die "$(eval_gettext "No url found for submodule path '\$path' in .gitmodules")"
+			die "$(eval_gettext "No url found for submodule path '\$sm_path' in .gitmodules")"
 
 			# Possibly a url relative to parent
 			case "$url" in
@@ -408,7 +411,7 @@ cmd_init()
 				;;
 			esac
 			git config submodule."$name".url "$url" ||
-			die "$(eval_gettext "Failed to register url for submodule path '\$path'")"
+			die "$(eval_gettext "Failed to register url for submodule path '\$sm_path'")"
 		fi
 
 		# Copy "update" setting when it is not set yet
@@ -416,9 +419,9 @@ cmd_init()
 		test -z "$upd" ||
 		test -n "$(git config submodule."$name".update)" ||
 		git config submodule."$name".update "$upd" ||
-		die "$(eval_gettext "Failed to register update mode for submodule path '\$path'")"
+		die "$(eval_gettext "Failed to register update mode for submodule path '\$sm_path'")"
 
-		say "$(eval_gettext "Submodule '\$name' (\$url) registered for path '\$path'")"
+		say "$(eval_gettext "Submodule '\$name' (\$url) registered for path '\$sm_path'")"
 	done
 }
 
@@ -490,14 +493,14 @@ cmd_update()
 	cloned_modules=
 	module_list "$@" | {
 	err=
-	while read mode sha1 stage path
+	while read mode sha1 stage sm_path
 	do
 		if test "$stage" = U
 		then
-			echo >&2 "Skipping unmerged submodule $path"
+			echo >&2 "Skipping unmerged submodule $sm_path"
 			continue
 		fi
-		name=$(module_name "$path") || exit
+		name=$(module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		if ! test -z "$update"
 		then
@@ -508,7 +511,7 @@ cmd_update()
 
 		if test "$update_module" = "none"
 		then
-			echo "Skipping submodule '$path'"
+			echo "Skipping submodule '$sm_path'"
 			continue
 		fi
 
@@ -517,20 +520,20 @@ cmd_update()
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" != "0" &&
-			say "$(eval_gettext "Submodule path '\$path' not initialized
+			say "$(eval_gettext "Submodule path '\$sm_path' not initialized
 Maybe you want to use 'update --init'?")"
 			continue
 		fi
 
-		if ! test -d "$path"/.git -o -f "$path"/.git
+		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			module_clone "$path" "$url" "$reference"|| exit
+			module_clone "$sm_path" "$url" "$reference"|| exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
-			subsha1=$(clear_local_git_env; cd "$path" &&
+			subsha1=$(clear_local_git_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
-			die "$(eval_gettext "Unable to find current revision in submodule path '\$path'")"
+			die "$(eval_gettext "Unable to find current revision in submodule path '\$sm_path'")"
 		fi
 
 		if test "$subsha1" != "$sha1"
@@ -546,10 +549,10 @@ Maybe you want to use 'update --init'?")"
 			then
 				# Run fetch only if $sha1 isn't present or it
 				# is not reachable from a ref.
-				(clear_local_git_env; cd "$path" &&
+				(clear_local_git_env; cd "$sm_path" &&
 					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
 					 test -z "$rev") || git-fetch)) ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$path'")"
+				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
 			fi
 
 			# Is this something we just cloned?
@@ -563,24 +566,24 @@ Maybe you want to use 'update --init'?")"
 			case "$update_module" in
 			rebase)
 				command="git rebase"
-				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$path'")"
-				say_msg="$(eval_gettext "Submodule path '\$path': rebased into '\$sha1'")"
+				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$sm_path'")"
+				say_msg="$(eval_gettext "Submodule path '\$sm_path': rebased into '\$sha1'")"
 				must_die_on_failure=yes
 				;;
 			merge)
 				command="git merge"
-				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$path'")"
-				say_msg="$(eval_gettext "Submodule path '\$path': merged in '\$sha1'")"
+				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$sm_path'")"
+				say_msg="$(eval_gettext "Submodule path '\$sm_path': merged in '\$sha1'")"
 				must_die_on_failure=yes
 				;;
 			*)
 				command="git checkout $subforce -q"
-				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$path'")"
-				say_msg="$(eval_gettext "Submodule path '\$path': checked out '\$sha1'")"
+				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$sm_path'")"
+				say_msg="$(eval_gettext "Submodule path '\$sm_path': checked out '\$sha1'")"
 				;;
 			esac
 
-			if (clear_local_git_env; cd "$path" && $command "$sha1")
+			if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
 			then
 				say "$say_msg"
 			elif test -n "$must_die_on_failure"
@@ -594,11 +597,11 @@ Maybe you want to use 'update --init'?")"
 
 		if test -n "$recursive"
 		then
-			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_flags")
+			(clear_local_git_env; cd "$sm_path" && eval cmd_update "$orig_flags")
 			res=$?
 			if test $res -gt 0
 			then
-				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$path'")"
+				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
 				if test $res -eq 1
 				then
 					err="${err};$die_msg"
@@ -885,30 +888,30 @@ cmd_status()
 	done
 
 	module_list "$@" |
-	while read mode sha1 stage path
+	while read mode sha1 stage sm_path
 	do
-		name=$(module_name "$path") || exit
+		name=$(module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
-		displaypath="$prefix$path"
+		displaypath="$prefix$sm_path"
 		if test "$stage" = U
 		then
 			say "U$sha1 $displaypath"
 			continue
 		fi
-		if test -z "$url" || ! test -d "$path"/.git -o -f "$path"/.git
+		if test -z "$url" || ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
 			say "-$sha1 $displaypath"
 			continue;
 		fi
-		set_name_rev "$path" "$sha1"
-		if git diff-files --ignore-submodules=dirty --quiet -- "$path"
+		set_name_rev "$sm_path" "$sha1"
+		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
 		then
 			say " $sha1 $displaypath$revname"
 		else
 			if test -z "$cached"
 			then
-				sha1=$(clear_local_git_env; cd "$path" && git rev-parse --verify HEAD)
-				set_name_rev "$path" "$sha1"
+				sha1=$(clear_local_git_env; cd "$sm_path" && git rev-parse --verify HEAD)
+				set_name_rev "$sm_path" "$sha1"
 			fi
 			say "+$sha1 $displaypath$revname"
 		fi
@@ -918,10 +921,10 @@ cmd_status()
 			(
 				prefix="$displaypath/"
 				clear_local_git_env
-				cd "$path" &&
+				cd "$sm_path" &&
 				eval cmd_status "$orig_args"
 			) ||
-			die "$(eval_gettext "Failed to recurse into submodule path '\$path'")"
+			die "$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
 		fi
 	done
 }
@@ -953,9 +956,9 @@ cmd_sync()
 	done
 	cd_to_toplevel
 	module_list "$@" |
-	while read mode sha1 stage path
+	while read mode sha1 stage sm_path
 	do
-		name=$(module_name "$path")
+		name=$(module_name "$sm_path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
 
 		# Possibly a url relative to parent
@@ -970,11 +973,11 @@ cmd_sync()
 			say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
 			git config submodule."$name".url "$url"
 
-			if test -e "$path"/.git
+			if test -e "$sm_path"/.git
 			then
 			(
 				clear_local_git_env
-				cd "$path"
+				cd "$sm_path"
 				remote=$(get_default_remote)
 				git config remote."$remote".url "$url"
 			)
-- 
1.7.10
