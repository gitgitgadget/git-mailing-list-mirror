From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add git-filter-branch
Date: Sun, 3 Jun 2007 01:31:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706030129110.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net, pasky@suse.cz
X-From: git-owner@vger.kernel.org Sun Jun 03 02:33:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hue2L-0001nf-GR
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 02:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760064AbXFCAd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 20:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762774AbXFCAd3
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 20:33:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:34741 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760064AbXFCAd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 20:33:28 -0400
Received: (qmail invoked by alias); 03 Jun 2007 00:33:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 03 Jun 2007 02:33:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mIPVj+Evm8LBFBoh7chCTefYQodkpyY0QiFRu9U
	zw45gTDvSsyzgk
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48964>


This script is derived from Pasky's cg-admin-rewritehist.

In fact, it _is_ the same script, minimally adapted to work without cogito.
It _should_ be able to perform the same tasks, even if only relying on
core-git programs.

All the work is Pasky's, just the adaption is mine.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Hopefully-signed-off-by: Petr "cogito master" Baudis <pasky@suse.cz>
---

	I will not have time to work on this for at least 24 hours. So, if 
	people want to go wild with enhancing the test case (and fixing the 
	script), go wild!

	IMHO this should go into core-git, as one of the many, many, many 
	enhancements that cogito brought to us.

	So really, this is a way of thanks to Pasky, rather than just 
	saying good-bye to cogito.

	Thanks, Pasky.

 Makefile                 |    3 +-
 git-filter-branch.sh     |  430 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t7003-filter-branch.sh |   47 +++++
 3 files changed, 479 insertions(+), 1 deletions(-)
 create mode 100644 git-filter-branch.sh
 create mode 100755 t/t7003-filter-branch.sh

diff --git a/Makefile b/Makefile
index 7ecd8f0..da271ec 100644
--- a/Makefile
+++ b/Makefile
@@ -213,7 +213,8 @@ SCRIPT_SH = \
 	git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
-	git-lost-found.sh git-quiltimport.sh git-submodule.sh
+	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
+	git-filter-branch.sh
 
 SCRIPT_PERL = \
 	git-add--interactive.perl \
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
new file mode 100644
index 0000000..c0a7680
--- /dev/null
+++ b/git-filter-branch.sh
@@ -0,0 +1,430 @@
+#!/bin/sh
+#
+# Rewrite revision history
+# Copyright (c) Petr Baudis, 2006
+# Minimal changes to "port" it to core-git (c) Johannes Schindelin, 2007
+#
+# Lets you rewrite GIT revision history by creating a new branch from
+# your current branch by applying custom filters on each revision.
+# Those filters can modify each tree (e.g. removing a file or running
+# a perl rewrite on all files) or information about each commit.
+# Otherwise, all information (including original commit times or merge
+# information) will be preserved.
+#
+# The command takes the new branch name as a mandatory argument and
+# the filters as optional arguments. If you specify no filters, the
+# commits will be recommitted without any changes, which would normally
+# have no effect and result with the new branch pointing to the same
+# branch as your current branch. (Nevertheless, this may be useful in
+# the future for compensating for some Git bugs or such, therefore
+# such a usage is permitted.)
+#
+# WARNING! The rewritten history will have different ids for all the
+# objects and will not converge with the original branch. You will not
+# be able to easily push and distribute the rewritten branch. Please do
+# not use this command if you do not know the full implications, and
+# avoid using it anyway - do not do what a simple single commit on top
+# of the current version would fix.
+#
+# Always verify that the rewritten version is correct before disposing
+# the original branch.
+#
+# Note that since this operation is extensively I/O expensive, it might
+# be a good idea to do it off-disk, e.g. on tmpfs. Reportedly the speedup
+# is very noticeable.
+#
+# OPTIONS
+# -------
+# -d TEMPDIR:: The path to the temporary tree used for rewriting
+#	When applying a tree filter, the command needs to temporary
+#	checkout the tree to some directory, which may consume
+#	considerable space in case of large projects. By default it
+#	does this in the '.git-rewrite/' directory but you can override
+#	that choice by this parameter.
+#
+# -r STARTREV:: The commit id to start the rewrite at
+#	Normally, the command will rewrite the entire history. If you
+#	pass this argument, though, this will be the first commit it
+#	will rewrite and keep the previous commits intact.
+#
+# -k KEEPREV:: A commit id until which _not_ to rewrite history
+#	If you pass this argument, this commit and all of its
+#	predecessors are kept intact.
+#
+# Filters
+# ~~~~~~~
+# The filters are applied in the order as listed below. The COMMAND
+# argument is always evaluated in shell using the 'eval' command.
+# The $GIT_COMMIT environment variable is permanently set to contain
+# the id of the commit being rewritten. The author/committer environment
+# variables are set before the first filter is run.
+#
+# A 'map' function is available that takes an "original sha1 id" argument
+# and outputs a "rewritten sha1 id" if the commit has been already
+# rewritten, fails otherwise; the 'map' function can return several
+# ids on separate lines if your commit filter emitted multiple commits
+# (see below).
+#
+# --env-filter COMMAND:: The filter for modifying environment
+#	This is the filter for modifying the environment in which
+#	the commit will be performed. Specifically, you might want
+#	to rewrite the author/committer name/email/time environment
+#	variables (see `git-commit` for details). Do not forget to
+#	re-export the variables.
+#
+# --tree-filter COMMAND:: The filter for rewriting tree (and its contents)
+#	This is the filter for rewriting the tree and its contents.
+#	The COMMAND argument is evaluated in shell with the working
+#	directory set to the root of the checked out tree. The new tree
+#	is then used as-is (new files are auto-added, disappeared files
+#	are auto-removed - .gitignore files nor any other ignore rules
+#	HAVE NO EFFECT!).
+#
+# --index-filter COMMAND:: The filter for rewriting index
+#	This is the filter for rewriting the Git's directory index.
+#	It is similar to the tree filter but does not check out the
+#	tree, which makes it much faster. However, you must use the
+#	lowlevel Git index manipulation commands to do your work.
+#
+# --parent-filter COMMAND:: The filter for rewriting parents
+#	This is the filter for rewriting the commit's parent list.
+#	It will receive the parent string on stdin and shall output
+#	the new parent string on stdout. The parent string is in
+#	format accepted by `git-commit-tree`: empty for initial
+#	commit, "-p parent" for a normal commit and "-p parent1
+#	-p parent2 -p parent3 ..." for a merge commit.
+#
+# --msg-filter COMMAND:: The filter for rewriting commit message
+#	This is the filter for rewriting the commit messages.
+#	The COMMAND argument is evaluated in shell with the original
+#	commit message on standard input; its standard output is
+#	is used as the new commit message.
+#
+# --commit-filter COMMAND:: The filter for performing the commit
+#	If this filter is passed, it will be called instead of the
+#	`git-commit-tree` command, with those arguments:
+#
+#		TREE_ID [-p PARENT_COMMIT_ID]...
+#
+#	and the log message on stdin. The commit id is expected on
+#	stdout. As a special extension, the commit filter may emit
+#	multiple commit ids; in that case, all of them will be used
+#	as parents instead of the original commit in further commits.
+#
+# --tag-name-filter COMMAND:: The filter for rewriting tag names.
+#	If this filter is passed, it will be called for every tag ref
+#	that points to a rewritten object (or to a tag object which
+#	points to a rewritten object). The original tag name is passed
+#	via standard input, and the new tag name is expected on standard
+#	output.
+#	
+#	The original tags are not deleted, but can be overwritten;
+#	use "--tag-name-filter=cat" to simply update the tags. In this
+#	case, be very careful and make sure you have the old tags
+#	backed up in case the conversion has run afoul.
+#
+#	Note that there is currently no support for proper rewriting of
+#	tag objects; in layman terms, if the tag has a message or signature
+#	attached, the rewritten tag won't have it. Sorry. (It is by
+#	definition impossible to preserve signatures at any rate, though.)
+#
+# EXAMPLE USAGE
+# -------------
+# Suppose you want to remove a file (containing confidential information
+# or copyright violation) from all commits:
+#
+#	git-filter-branch --tree-filter 'rm filename' newbranch
+#
+# A significantly faster version:
+#
+#	git-filter-branch --index-filter 'git-update-index --remove filename' newbranch
+#
+# Now, you will get the rewritten history saved in the branch 'newbranch'
+# (your current branch is left untouched).
+#
+# To "etch-graft" a commit to the revision history (set a commit to be
+# the parent of the current initial commit and propagate that):
+#
+#	git-filter-branch --parent-filter sed\ 's/^$/-p graftcommitid/' newbranch
+#
+# (if the parent string is empty - therefore we are dealing with the
+# initial commit - add graftcommit as a parent). Note that this assumes
+# history with a single root (that is, no git-merge without common ancestors
+# happened). If this is not the case, use:
+#
+#	git-filter-branch --parent-filter 'cat; [ "$GIT_COMMIT" = "COMMIT" ] && echo "-p GRAFTCOMMIT"' newbranch
+#
+# To remove commits authored by "Darl McBribe" from the history:
+#
+#	git-filter-branch --commit-filter 'if [ "$GIT_AUTHOR_NAME" = "Darl McBribe" ]; then shift; while [ -n "$1" ]; do shift; echo "$1"; shift; done; else git-commit-tree "$@"; fi' newbranch
+#
+# (the shift magic first throws away the tree id and then the -p
+# parameters). Note that this handles merges properly! In case Darl
+# committed a merge between P1 and P2, it will be propagated properly
+# and all children of the merge will become merge commits with P1,P2
+# as their parents instead of the merge commit.
+#
+# To restrict rewriting to only part of the history, use -r or -k or both.
+# Consider this history:
+#
+#	     D--E--F--G--H
+#	    /     /
+#	A--B-----C
+#
+# To rewrite only commits F,G,H, use:
+#
+#	git-filter-branch -r F ...
+#
+# To rewrite commits E,F,G,H, use one of these:
+#
+#	git-filter-branch -r E -k C ...
+#	git-filter-branch -k D -k C ...
+
+# Testsuite: TODO
+
+set -e
+
+USAGE="git-filter-branch [-d TEMPDIR] [-r STARTREV]... [-k KEEPREV]... [-s SRCBRANCH] [FILTERS] DESTBRANCH"
+. git-sh-setup
+
+map()
+{
+	[ -r "$workdir/../map/$1" ] || return 1
+	cat "$workdir/../map/$1"
+}
+
+# When piped a commit, output a script to set the ident of either
+# "author" or "committer
+
+set_ident () {
+	lid="$(echo "$1" | tr "A-Z" "a-z")"
+	uid="$(echo "$1" | tr "a-z" "A-Z")"
+	pick_id_script='
+		/^'$lid' /{
+			s/'\''/'\''\\'\'\''/g
+			h
+			s/^'$lid' \([^<]*\) <[^>]*> .*$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/export GIT_'$uid'_NAME='\''&'\''/p
+
+			g
+			s/^'$lid' [^<]* <\([^>]*\)> .*$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/export GIT_'$uid'_EMAIL='\''&'\''/p
+
+			g
+			s/^'$lid' [^<]* <[^>]*> \(.*\)$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/export GIT_'$uid'_DATE='\''&'\''/p
+
+			q
+		}
+	'
+
+	LANG=C LC_ALL=C sed -ne "$pick_id_script"
+	# Ensure non-empty id name.
+	echo "[ -n \"\$GIT_${uid}_NAME\" ] || export GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\""
+}
+
+# list all parent's object names for a given commit
+get_parents () {
+	git-rev-list -1 --parents "$1" | sed "s/^[0-9a-f]*//"
+}
+
+tempdir=.git-rewrite
+unchanged=" "
+filter_env=
+filter_tree=
+filter_index=
+filter_parent=
+filter_msg=cat
+filter_commit='git-commit-tree "$@"'
+filter_tag_name=
+srcbranch=HEAD
+while case "$#" in 0) usage;; esac
+do
+	case "$1" in
+	--)
+		shift
+		break
+		;;
+	-*)
+		;;
+	*)
+		break;
+	esac
+
+	# all switches take one argument
+	ARG="$1"
+	case "$#" in 1) usage ;; esac
+	shift
+	OPTARG="$1"
+	shift
+
+	case "$ARG" in
+	-d)
+		tempdir="$OPTARG"
+		;;
+	-r)
+		unchanged="$(get_parents "$OPTARG") $unchanged"
+		;;
+	-k)
+		unchanged="$(git-rev-parse "$OPTARG"^{commit}) $unchanged"
+		;;
+	--env-filter)
+		filter_env="$OPTARG"
+		;;
+	--tree-filter)
+		filter_tree="$OPTARG"
+		;;
+	--index-filter)
+		filter_index="$OPTARG"
+		;;
+	--parent-filter)
+		filter_parent="$OPTARG"
+		;;
+	--msg-filter)
+		filter_msg="$OPTARG"
+		;;
+	--commit-filter)
+		filter_commit="$OPTARG"
+		;;
+	--tag-name-filter)
+		filter_tag_name="$OPTARG"
+		;;
+	-s)
+		srcbranch="$OPTARG"
+		;;
+	*)
+		usage
+		;;
+	esac
+done
+
+dstbranch="$1"
+test -n "$dstbranch" || die "missing branch name"
+git-show-ref "refs/heads/$dstbranch" 2> /dev/null &&
+	die "branch $dstbranch already exists"
+
+test ! -e "$tempdir" || die "$tempdir already exists, please remove it"
+mkdir -p "$tempdir/t"
+cd "$tempdir/t"
+workdir="$(pwd)"
+
+case "$GIT_DIR" in
+/*)
+	;;
+*)
+	export GIT_DIR="$(pwd)/../../$GIT_DIR"
+	;;
+esac
+
+export GIT_INDEX_FILE="$(pwd)/../index"
+git-read-tree # seed the index file
+
+ret=0
+
+
+mkdir ../map # map old->new commit ids for rewriting parents
+
+# seed with identity mappings for the parents where we start off
+for commit in $unchanged; do
+	echo $commit > ../map/$commit
+done
+
+git-rev-list --reverse --topo-order $srcbranch --not $unchanged >../revs
+commits=$(cat ../revs | wc -l | tr -d " ")
+
+test $commits -eq 0 && die "Found nothing to rewrite"
+
+i=0
+while read commit; do
+	i=$((i+1))
+	printf "$commit ($i/$commits) "
+
+	git-read-tree -i -m $commit
+
+	export GIT_COMMIT=$commit
+	git-cat-file commit "$commit" >../commit
+
+	eval "$(set_ident AUTHOR <../commit)"
+	eval "$(set_ident COMMITTER <../commit)"
+	eval "$filter_env"
+
+	if [ "$filter_tree" ]; then
+		git-checkout-index -f -u -a
+		# files that $commit removed are now still in the working tree;
+		# remove them, else they would be added again
+		git-ls-files -z --others | xargs -0 rm -f
+		eval "$filter_tree"
+		git-diff-index -r $commit | cut -f 2- | tr '\n' '\0' | \
+			xargs -0 git-update-index --add --replace --remove
+		git-ls-files -z --others | \
+			xargs -0 git-update-index --add --replace --remove
+	fi
+
+	eval "$filter_index"
+
+	parentstr=
+	for parent in $(get_parents $commit); do
+		if [ -r "../map/$parent" ]; then
+			for reparent in $(cat "../map/$parent"); do
+				parentstr="$parentstr -p $reparent"
+			done
+		else
+			die "assertion failed: parent $parent for commit $commit not found in rewritten ones"
+		fi
+	done
+	if [ "$filter_parent" ]; then
+		parentstr="$(echo "$parentstr" | eval "$filter_parent")"
+	fi
+
+	sed -e '1,/^$/d' <../commit | \
+		eval "$filter_msg" | \
+		sh -c "$filter_commit" git-commit-tree $(git-write-tree) $parentstr | \
+		tee ../map/$commit
+done <../revs
+
+git-update-ref refs/heads/"$dstbranch" $(head -n 1 ../map/$(tail -n 1 ../revs))
+if [ "$(cat ../map/$(tail -n 1 ../revs) | wc -l)" -gt 1 ]; then
+	echo "WARNING: Your commit filter caused the head commit to expand to several rewritten commits. Only the first such commit was recorded as the current $dstbranch head but you will need to resolve the situation now (probably by manually merging the other commits). These are all the commits:" >&2
+	sed 's/^/	/' ../map/$(tail -n 1 ../revs) >&2
+	ret=1
+fi
+
+if [ "$filter_tag_name" ]; then
+	git-for-each-ref --format='%(objectname) %(objecttype) %(refname)' refs/tags |
+	while read sha1 type ref; do
+		ref="${ref#refs/tags/}"
+		# XXX: Rewrite tagged trees as well?
+		if [ "$type" != "commit" -a "$type" != "tag" ]; then
+			continue;
+		fi
+
+		if [ "$type" = "tag" ]; then
+			# Dereference to a commit
+			sha1t="$sha1"
+			sha1="$(git-rev-parse "$sha1"^{commit} 2>/dev/null)" || continue
+		fi
+
+		[ -f "../map/$sha1" ] || continue
+		new_sha1="$(cat "../map/$sha1")"
+		export GIT_COMMIT="$sha1"
+		new_ref="$(echo "$ref" | eval "$filter_tag_name")"
+
+		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
+
+		if [ "$type" = "tag" ]; then
+			# Warn that we are not rewriting the tag object itself.
+			warn "unreferencing tag object $sha1t"
+		fi
+
+		git-update-ref "refs/tags/$new_ref" "$new_sha1"
+	done
+fi
+
+cd ../..
+rm -rf "$tempdir"
+echo "Rewritten history saved to the $dstbranch branch"
+
+exit $ret
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
new file mode 100755
index 0000000..9a4dae4
--- /dev/null
+++ b/t/t7003-filter-branch.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='git-filter-branch'
+. ./test-lib.sh
+
+make_commit () {
+	lower=$(echo $1 | tr A-Z a-z)
+	echo $lower > $lower
+	git add $lower
+	git commit -m $1
+	git tag $1
+}
+
+test_expect_success 'setup' '
+	make_commit A
+	make_commit B
+	git checkout -b branch B
+	make_commit D
+	make_commit E
+	git checkout master
+	make_commit C
+	git checkout branch
+	git merge C
+	git tag F
+	make_commit G
+	make_commit H
+'
+
+H=$(git-rev-parse H)
+
+test_expect_success 'rewrite identically' '
+	git-filter-branch H2
+'
+
+test_expect_success 'result is really identical' '
+	test $H = $(git-rev-parse H2)
+'
+
+test_expect_success 'rewrite, renaming a specific file' '
+	git-filter-branch --tree-filter "mv d doh || :" H3
+'
+
+test_expect_success 'test that the file was renamed' '
+	test d = $(git show H3:doh)
+'
+
+test_done
-- 
1.5.2.2663.gd77e7-dirty
