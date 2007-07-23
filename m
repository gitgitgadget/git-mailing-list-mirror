From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] filter-branch: Big syntax change; support rewriting multiple
 refs
Date: Mon, 23 Jul 2007 18:34:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707231829210.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 23 19:34:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID1nm-0002Xr-P0
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 19:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498AbXGWRea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 13:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758833AbXGWRea
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 13:34:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:33575 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756439AbXGWRe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 13:34:28 -0400
Received: (qmail invoked by alias); 23 Jul 2007 17:34:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 23 Jul 2007 19:34:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UAHtcaTAUUJuJDAvIMIiv7jNMUCGjl79BQ/EJym
	EGds19w5bQaP7Q
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53449>


We used to take the first non-option argument as the name for the new 
branch.  This syntax is not extensible to support rewriting more than just 
HEAD.

Instead, we now have the following syntax:

	git filter-branch [<filter options>...] [<rev-list options>]

All positive refs given in <rev-list options> are rewritten.  Yes, 
in-place.  If a ref was changed, the original head is stored in 
refs/original/$ref now, for your inspecting pleasure, in addition to the 
reflogs (since it is easier to inspect "git show-ref | grep original" than 
to inspect all the reflogs).

This commit also adds the --force option to remove .git-rewrite/ and all 
refs from refs/original/ before filtering.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Junio, I know that this comes quite late in the game, but I really
	think that the "first arg is new branch name" was a bad syntax.

	Could you please consider taking this patch (or whatever version
	comes out after review ;-) or keeping filter-branch of 1.5.3?  I 
	do not want people to get used to the borked syntax...

	BTW I considered "git log -g --all" as an alternative to 
	inspecting refs/original/, but ATM this die()s if just _one_ of 
	the refs has no logs.  Probably should fix that, too.

 Documentation/git-filter-branch.txt |   51 +++++++------
 git-filter-branch.sh                |  150 +++++++++++++++++++++++++++++-----
 t/t7003-filter-branch.sh            |   41 ++++++----
 3 files changed, 182 insertions(+), 60 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index eaea82d..915258f 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[--index-filter <command>] [--parent-filter <command>]
 	[--msg-filter <command>] [--commit-filter <command>]
 	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
-	[-d <directory>] <new-branch-name> [<rev-list options>...]
+	[-d <directory>] [-f | --force] [<rev-list options>...]
 
 DESCRIPTION
 -----------
@@ -26,10 +26,9 @@ information) will be preserved.
 The command takes the new branch name as a mandatory argument and
 the filters as optional arguments.  If you specify no filters, the
 commits will be recommitted without any changes, which would normally
-have no effect and result in the new branch pointing to the same
-branch as your current branch.  Nevertheless, this may be useful in
-the future for compensating for some git bugs or such, therefore
-such a usage is permitted.
+have no effect.  Nevertheless, this may be useful in the future for
+compensating for some git bugs or such, therefore such a usage is
+permitted.
 
 *WARNING*! The rewritten history will have different object names for all
 the objects and will not converge with the original branch.  You will not
@@ -38,8 +37,9 @@ original branch.  Please do not use this command if you do not know the
 full implications, and avoid using it anyway, if a simple single commit
 would suffice to fix your problem.
 
-Always verify that the rewritten version is correct before disposing
-the original branch.
+Always verify that the rewritten version is correct: The original refs,
+if different from the rewritten ones, will be stored in the namespace
+'refs/original/'.
 
 Note that since this operation is extensively I/O expensive, it might
 be a good idea to redirect the temporary directory off-disk, e.g. on
@@ -142,6 +142,11 @@ definition impossible to preserve signatures at any rate.)
 	does this in the '.git-rewrite/' directory but you can override
 	that choice by this parameter.
 
+-f\|--force::
+	`git filter-branch` refuses to start with an existing temporary
+	directory or when there are already refs starting with
+	'refs/original/', unless forced.
+
 <rev-list-options>::
 	When options are given after the new branch name, they will
 	be passed to gitlink:git-rev-list[1].  Only commits in the resulting
@@ -156,14 +161,14 @@ Suppose you want to remove a file (containing confidential information
 or copyright violation) from all commits:
 
 -------------------------------------------------------
-git filter-branch --tree-filter 'rm filename' newbranch
+git filter-branch --tree-filter 'rm filename' HEAD
 -------------------------------------------------------
 
 A significantly faster version:
 
--------------------------------------------------------------------------------
-git filter-branch --index-filter 'git update-index --remove filename' newbranch
--------------------------------------------------------------------------------
+--------------------------------------------------------------------------
+git filter-branch --index-filter 'git update-index --remove filename' HEAD
+--------------------------------------------------------------------------
 
 Now, you will get the rewritten history saved in the branch 'newbranch'
 (your current branch is left untouched).
@@ -172,25 +177,25 @@ To set a commit (which typically is at the tip of another
 history) to be the parent of the current initial commit, in
 order to paste the other history behind the current history:
 
-------------------------------------------------------------------------
-git filter-branch --parent-filter 'sed "s/^\$/-p <graft-id>/"' newbranch
-------------------------------------------------------------------------
+-------------------------------------------------------------------
+git filter-branch --parent-filter 'sed "s/^\$/-p <graft-id>/"' HEAD
+-------------------------------------------------------------------
 
 (if the parent string is empty - therefore we are dealing with the
 initial commit - add graftcommit as a parent).  Note that this assumes
 history with a single root (that is, no merge without common ancestors
 happened).  If this is not the case, use:
 
--------------------------------------------------------------------------------
+--------------------------------------------------------------------------
 git filter-branch --parent-filter \
-	'cat; test $GIT_COMMIT = <commit-id> && echo "-p <graft-id>"' newbranch
--------------------------------------------------------------------------------
+	'cat; test $GIT_COMMIT = <commit-id> && echo "-p <graft-id>"' HEAD
+--------------------------------------------------------------------------
 
 or even simpler:
 
 -----------------------------------------------
 echo "$commit-id $graft-id" >> .git/info/grafts
-git filter-branch newbranch $graft-id..
+git filter-branch $graft-id..HEAD
 -----------------------------------------------
 
 To remove commits authored by "Darl McBribe" from the history:
@@ -208,7 +213,7 @@ git filter-branch --commit-filter '
 		done;
 	else
 		git commit-tree "$@";
-	fi' newbranch
+	fi' HEAD
 ------------------------------------------------------------------------------
 
 The shift magic first throws away the tree id and then the -p
@@ -238,14 +243,14 @@ A--B-----C
 To rewrite only commits D,E,F,G,H, but leave A, B and C alone, use:
 
 --------------------------------
-git filter-branch ... new-H C..H
+git filter-branch ... C..H
 --------------------------------
 
 To rewrite commits E,F,G,H, use one of these:
 
 ----------------------------------------
-git filter-branch ... new-H C..H --not D
-git filter-branch ... new-H D..H --not C
+git filter-branch ... C..H --not D
+git filter-branch ... D..H --not C
 ----------------------------------------
 
 To move the whole tree into a subdirectory, or remove it from there:
@@ -255,7 +260,7 @@ git filter-branch --index-filter \
 	'git ls-files -s | sed "s-\t-&newsubdir/-" |
 		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
-	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' directorymoved
+	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
 ---------------------------------------------------------------
 
 
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 0d000ed..0ff3475 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -78,6 +78,8 @@ filter_msg=cat
 filter_commit='git commit-tree "$@"'
 filter_tag_name=
 filter_subdir=
+orig_namespace=refs/original/
+force=
 while case "$#" in 0) usage;; esac
 do
 	case "$1" in
@@ -85,6 +87,11 @@ do
 		shift
 		break
 		;;
+	--force|-f)
+		shift
+		force=t
+		continue
+		;;
 	-*)
 		;;
 	*)
@@ -126,24 +133,43 @@ do
 	--subdirectory-filter)
 		filter_subdir="$OPTARG"
 		;;
+	--original)
+		orig_namespace="$OPTARG"
+		;;
 	*)
 		usage
 		;;
 	esac
 done
 
-dstbranch="$1"
-shift
-test -n "$dstbranch" || die "missing branch name"
-git show-ref "refs/heads/$dstbranch" 2> /dev/null &&
-	die "branch $dstbranch already exists"
-
-test ! -e "$tempdir" || die "$tempdir already exists, please remove it"
+case "$force" in
+t)
+	rm -rf "$tempdir"
+;;
+'')
+	test -d "$tempdir" &&
+		die "$tempdir already exists, please remove it"
+esac
 mkdir -p "$tempdir/t" &&
+tempdir="$(cd "$tempdir"; pwd)" &&
 cd "$tempdir/t" &&
 workdir="$(pwd)" ||
 die ""
 
+# Make sure refs/original is empty
+git for-each-ref > "$tempdir"/backup-refs
+while read sha1 type name
+do
+	case "$force,$name" in
+	,$orig_namespace*)
+		die "Namespace $orig_namespace not empty"
+	;;
+	t,$orig_namespace*)
+		git update-ref -d "$name" $sha1
+	;;
+	esac
+done < "$tempdir"/backup-refs
+
 case "$GIT_DIR" in
 /*)
 	;;
@@ -153,6 +179,29 @@ case "$GIT_DIR" in
 esac
 export GIT_DIR GIT_WORK_TREE=.
 
+# These refs should be updated if their heads were rewritten
+
+git rev-parse --revs-only --symbolic "$@" |
+while read ref
+do
+	# normalize ref
+	case "$ref" in
+	HEAD)
+		ref="$(git symbolic-ref "$ref")"
+	;;
+	refs/*)
+	;;
+	*)
+		ref="$(git for-each-ref --format='%(refname)' |
+			grep /"$ref")"
+	esac
+
+	git check-ref-format "$ref" && echo "$ref"
+done > "$tempdir"/heads
+
+test -s "$tempdir"/heads ||
+	die "Which ref do you want to rewrite?"
+
 export GIT_INDEX_FILE="$(pwd)/../index"
 git read-tree || die "Could not seed the index"
 
@@ -174,6 +223,8 @@ commits=$(wc -l <../revs | tr -d " ")
 
 test $commits -eq 0 && die "Found nothing to rewrite"
 
+# Rewrite the commits
+
 i=0
 while read commit parents; do
 	i=$(($i+1))
@@ -234,22 +285,75 @@ while read commit parents; do
 		$(git write-tree) $parentstr < ../message > ../map/$commit
 done <../revs
 
-src_head=$(tail -n 1 ../revs | sed -e 's/ .*//')
-target_head=$(head -n 1 ../map/$src_head)
-case "$target_head" in
-'')
-	echo Nothing rewritten
+# In case of a subdirectory filter, it is possible that a specified head
+# is not in the set of rewritten commits, because it was pruned by the
+# revision walker.  Fix it by mapping these heads to the next rewritten
+# ancestor(s), i.e. the boundaries in the set of rewritten commits.
+
+# NEEDSWORK: we should sort the unmapped refs topologically first
+while read ref
+do
+	sha1=$(git rev-parse "$ref"^0)
+	test -f "$workdir"/../map/$sha1 && continue
+	# Assign the boundarie(s) in the set of rewritten commits
+	# as the replacement commit(s).
+	# (This would look a bit nicer if --not --stdin worked.)
+	for p in $((cd "$workdir"/../map; ls | sed "s/^/^/") |
+		git rev-list $ref --boundary --stdin |
+		sed -n "s/^-//p")
+	do
+		map $p >> "$workdir"/../map/$sha1
+	done
+done < "$tempdir"/heads
+
+# Finally update the refs
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+count=0
+echo
+while read ref
+do
+	# avoid rewriting a ref twice
+	test -f "$orig_namespace$ref" && continue
+
+	sha1=$(git rev-parse "$ref"^0)
+	rewritten=$(map $sha1)
+
+	test $sha1 = "$rewritten" &&
+		warn "WARNING: Ref '$ref' is unchanged" &&
+		continue
+
+	case "$rewritten" in
+	'')
+		echo "Ref '$ref' was deleted"
+		git update-ref -m "filter-branch: delete" -d "$ref" $sha1 ||
+			die "Could not delete $ref"
 	;;
-*)
-	git update-ref refs/heads/"$dstbranch" $target_head ||
-		die "Could not update $dstbranch with $target_head"
-	if [ $(wc -l <../map/$src_head) -gt 1 ]; then
-		echo "WARNING: Your commit filter caused the head commit to expand to several rewritten commits. Only the first such commit was recorded as the current $dstbranch head but you will need to resolve the situation now (probably by manually merging the other commits). These are all the commits:" >&2
-		sed 's/^/	/' ../map/$src_head >&2
-		ret=1
-	fi
+	$_x40)
+		echo "Ref '$ref' was rewritten"
+		git update-ref -m "filter-branch: rewrite" \
+				"$ref" $rewritten $sha1 ||
+			die "Could not rewrite $ref"
 	;;
-esac
+	*)
+		# NEEDSWORK: possibly add -Werror, making this an error
+		warn "WARNING: '$ref' was rewritten into multiple commits:"
+		warn "$rewritten"
+		warn "WARNING: Ref '$ref' points to the first one now."
+		rewritten=$(echo "$rewritten" | head -n 1)
+		git update-ref -m "filter-branch: rewrite to first" \
+				"$ref" $rewritten $sha1 ||
+			die "Could not rewrite $ref"
+	;;
+	esac
+	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1
+	count=$(($count+1))
+done < "$tempdir"/heads
+
+# TODO: This should possibly go, with the semantics that all positive given
+#       refs are updated, and their original heads stored in refs/original/
+# Filter tags
 
 if [ "$filter_tag_name" ]; then
 	git for-each-ref --format='%(objectname) %(objecttype) %(refname)' refs/tags |
@@ -286,6 +390,8 @@ fi
 
 cd ../..
 rm -rf "$tempdir"
-printf "\nRewritten history saved to the $dstbranch branch\n"
+echo
+test $count -gt 0 && echo "These refs were rewritten:"
+git show-ref | grep ^"$orig_namespace"
 
 exit $ret
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 4ddd656..bc6e2dd 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -30,24 +30,24 @@ test_expect_success 'setup' '
 H=$(git rev-parse H)
 
 test_expect_success 'rewrite identically' '
-	git-filter-branch H2
+	git-filter-branch branch
 '
-
 test_expect_success 'result is really identical' '
-	test $H = $(git rev-parse H2)
+	test $H = $(git rev-parse HEAD)
 '
 
 test_expect_success 'rewrite, renaming a specific file' '
-	git-filter-branch --tree-filter "mv d doh || :" H3
+	git-filter-branch -f --tree-filter "mv d doh || :" HEAD
 '
 
 test_expect_success 'test that the file was renamed' '
-	test d = $(git show H3:doh)
+	test d = $(git show HEAD:doh)
 '
 
-git tag oldD H3~4
+git tag oldD HEAD~4
 test_expect_success 'rewrite one branch, keeping a side branch' '
-	git-filter-branch --tree-filter "mv b boh || :" modD D..oldD
+	git branch modD oldD &&
+	git-filter-branch -f --tree-filter "mv b boh || :" D..modD
 '
 
 test_expect_success 'common ancestor is still common (unchanged)' '
@@ -69,7 +69,8 @@ test_expect_success 'filter subdirectory only' '
 	git rm a &&
 	test_tick &&
 	git commit -m "again not subdir" &&
-	git-filter-branch --subdirectory-filter subdir sub
+	git branch sub &&
+	git-filter-branch -f --subdirectory-filter subdir refs/heads/sub
 '
 
 test_expect_success 'subdirectory filter result looks okay' '
@@ -89,7 +90,8 @@ test_expect_success 'setup and filter history that requires --full-history' '
 	test_tick &&
 	git commit -m "again subdir on master" &&
 	git merge branch &&
-	git-filter-branch --subdirectory-filter subdir sub-master
+	git branch sub-master &&
+	git-filter-branch -f --subdirectory-filter subdir sub-master
 '
 
 test_expect_success 'subdirectory filter result looks okay' '
@@ -100,7 +102,8 @@ test_expect_success 'subdirectory filter result looks okay' '
 '
 
 test_expect_success 'use index-filter to move into a subdirectory' '
-	git-filter-branch --index-filter \
+	git branch directorymoved &&
+	git-filter-branch -f --index-filter \
 		 "git ls-files -s | sed \"s-\\t-&newsubdir/-\" |
 	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
@@ -108,9 +111,10 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 	test -z "$(git diff HEAD directorymoved:newsubdir)"'
 
 test_expect_success 'stops when msg filter fails' '
-	! git-filter-branch --msg-filter false nonono &&
-	rm -rf .git-rewrite &&
-	! git rev-parse nonono
+	old=$(git rev-parse HEAD) &&
+	! git-filter-branch -f --msg-filter false &&
+	test $old = $(git rev-parse HEAD) &&
+	rm -rf .git-rewrite
 '
 
 test_expect_success 'author information is preserved' '
@@ -118,7 +122,8 @@ test_expect_success 'author information is preserved' '
 	git add i &&
 	test_tick &&
 	GIT_AUTHOR_NAME="B V Uips" git commit -m bvuips &&
-	git-filter-branch --msg-filter "cat; \
+	git branch preserved-author &&
+	git-filter-branch -f --msg-filter "cat; \
 			test \$GIT_COMMIT != $(git rev-parse master) || \
 			echo Hallo" \
 		preserved-author &&
@@ -129,7 +134,8 @@ test_expect_success "remove a certain author's commits" '
 	echo i > i &&
 	test_tick &&
 	git commit -m i i &&
-	git-filter-branch --commit-filter "\
+	git branch removed-author &&
+	git-filter-branch -f --commit-filter "\
 		if [ \"\$GIT_AUTHOR_NAME\" = \"B V Uips\" ];\
 		then\
 			shift;\
@@ -148,4 +154,9 @@ test_expect_success "remove a certain author's commits" '
 	test 0 = $(git rev-list --author="B V Uips" removed-author | wc -l)
 '
 
+test_expect_success 'barf on invalid name' '
+	! git filter-branch -f master xy-problem &&
+	! git filter-branch -f HEAD^
+'
+
 test_done
-- 
1.5.3.rc2.32.g35c5b
