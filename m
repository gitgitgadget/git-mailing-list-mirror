From: =?utf-8?q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [COGITO PATCH] cg-branch-switch and local branches
Date: Wed, 01 Jun 2005 18:20:22 +0200
Message-ID: <877jheqcah.fsf@gmail.com>
References: <87ekbmi5zl.fsf@ifae.es> <87mzqaqgv1.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 01 18:22:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdVw5-00035v-92
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 18:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVFAQWB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 12:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVFAQWB
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 12:22:01 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:35987 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S261445AbVFAQUV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 12:20:21 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j51GKHZ27230
	for <git@vger.kernel.org>; Wed, 1 Jun 2005 18:20:17 +0200
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <87mzqaqgv1.fsf@gmail.com> (
 =?utf-8?q?Santi_B=C3=A9jar's_message_of?= "Wed, 01 Jun 2005 16:41:38
 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Here it is un update version fixing some bugs. It depends on my update
version of the "[COGITO PATCH] Heads and tags in subdirectories" patch.

        Santi

 Makefile         |    3 +
 cg-Xnormid       |    2 +
 cg-branch-add    |   19 +++++++++
 cg-branch-switch |  107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cg-clone         |   32 ++++++++++++----
 cg-commit        |   17 +++++++-
 cg-merge         |    3 +
 cg-pull          |   24 ++++++++----
 8 files changed, 189 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -55,7 +55,8 @@ PROG=   git-update-cache git-diff-files 
 SCRIPT=	commit-id tree-id parent-id cg-add cg-admin-lsobj cg-admin-uncommit \
 	cg-branch-add cg-branch-ls cg-cancel cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-ls cg-merge cg-mkpatch cg-patch \
-	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update
+	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update \
+	cg-branch-switch
 
 LIB_SCRIPT=cg-Xlib cg-Xmergefile cg-Xnormid
 
diff --git a/cg-Xnormid b/cg-Xnormid
--- a/cg-Xnormid
+++ b/cg-Xnormid
@@ -16,6 +16,8 @@
 
 id="$1"
 
+[ -L $_git/refs/heads/$id ] &&
+id=$(readlink $_git/refs/heads/$id | sed 's@/@#@')
 repo=$(echo $id | cut -d '#' -f 1)
 (echo $repo | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
 	die "name contains invalid characters"
diff --git a/cg-branch-add b/cg-branch-add
--- a/cg-branch-add
+++ b/cg-branch-add
@@ -1,8 +1,11 @@
 #!/usr/bin/env bash
 #
 # Add new branch to the GIT repository.
+# Or create local branch in the GIT repository.
 # Copyright (c) Petr Baudis, 2005
 #
+# Adding a new branch
+# -------------------
 # Takes the branch name and source location as parameters.
 # After you add a branch, you can `cg-pull` it whenever you want and
 # it will keep your objects database in sync with it. Its latest
@@ -29,6 +32,22 @@
 #	$ cg-branch-add repo-testing rsync://host/path/repo.git#testing
 #
 # and refer to it as 'repo-testing' anytime later.
+#
+# Creating a local branch
+# -----------------------
+# Takes the local branch name and origin branch as parameters.
+#
+# After you create a local branch, you can `cg-branch-switch` it whenever you
+# want and you will be able to work on your local branch. Its {latest,origin}
+# commit is accessible as `.git/refs/heads/{master,origin}` (or - more
+# conveniently - as `$(commit-id {master,origin})`).
+# For example, to make a diff between your origin and your current tree, do:
+#
+#	$ cg-diff -r origin
+#
+# The origin specifier is a name of a branch added with cg-branch-add,
+# followed with an optional fragment part, which identifies a alternative
+# branch inside of the repository.
 
 USAGE="cg-branch-add BRANCH_NAME LOCATION"
 
diff --git a/cg-branch-switch b/cg-branch-switch
new file mode 100644
--- /dev/null
+++ b/cg-branch-switch
@@ -0,0 +1,107 @@
+#!/usr/bin/env bash
+#
+# Switch to a local branch.
+# Without arguments prints the branch.
+#
+# Takes the branch name as an argument.
+# If the argument is an external branch switch to an unnamed branch.
+#
+# Local branches
+# --------------
+#
+# The master file is always a link:
+#
+# master -> ${localbranch}
+#
+# The content of $_git/branches/${localbranch} is the original branch of
+# local branch. The cases and the corresponding origin links are:
+#
+# 1a.- name         : a name of an external repository
+#                     $branch corresponding to the definition
+#                     origin -> $name/$branch
+# 1b.- name#branch : optionally with a branch
+#                     origin -> $name/$branch
+# 2 .- name         : a name of another local branch
+#                     $branch corresponding to the definition
+#                     origin -> $name/$branch
+#
+# Local unnamed branches
+# ----------------------
+#
+# The master file is a regula file and the origin link only has the cases
+# 1a and 1b where the $name is the parameter to the script.
+
+USAGE="cg-switch-tree [BRANCH]"
+
+. ${COGITO_LIB}cg-Xlib
+
+name=$1
+
+[ -e $_git/refs/heads/origin ] && [ ! -L $_git/refs/heads/origin ] &&
+die "$_git/refs/heads/origin must be a symbolic link"
+
+[ -e $_git/blocked ] && die "switch blocked: $(cat $_git/blocked)"
+
+oldmaster=$(readlink $_git/refs/heads/master)
+oldorigin=$(readlink $_git/refs/heads/origin)
+
+[ -z "$name" ] && echo "master $(echo $oldmaster | sed 's@/@#@' )" &&
+echo "origin $(echo $oldorigin | sed 's@/@#@' )" && exit 0
+
+oldmaster=${oldmaster:-master}
+
+namerepo=$(echo $name | cut -d '#' -f 1)
+namebranch=$(echo $name | cut -d '#' -f 2 -s)
+[ -e "$_git/branches/$namerepo" ] || die "unknown branch: $name"
+origuri=$(cat "$_git/branches/$namerepo")
+origrepo=$(echo $origuri | cut -d '#' -f 1)
+origbranch=$(echo $origuri | cut -d '#' -f 2 -s)
+
+if [ -e "$_git/branches/$origrepo" ] ; then
+    # $name is a local branch
+    switch=local
+    master=$namerepo
+    [ -e "$_git/branches/$origrepo" ] || die "do not exist local branch: $name"
+    uri=$(cat $_git/branches/$origrepo)
+    if [ -e "$_git/branches/$(echo $uri| cut -d '#' -f 1)" ] ; then
+    # Origin is a local branch
+	origlink=$origuri
+	[ "$namebranch" ] && die "local branches cannot have branches"
+    else
+    # Origin is a external branch
+	extbranch=${namebranch:-$origbranch}
+	extbranch=${extbranch:-master}
+	origlink=$origrepo/$extbranch
+    fi
+else
+    # Origin is an external unnamed branch
+    switch=unnnamed
+    extbranch=${namebranch:-$origbranch}
+    extbranch=${extbranch:-master}
+    origlink=$namerepo/$extbranch
+    master=$namerepo/$extbranch
+fi
+
+[ ! -r $_git/refs/heads/$origlink ] && die "unknown branch: $origlink"
+
+if [ "$(git-diff-files -s)" ] || [ "$(git-diff-cache HEAD 2>/dev/null)" ]; then
+	die "switch blocked: local changes"
+fi
+
+[ ! -r $_git/refs/heads/$master -o ! -s $_git/refs/heads/$master ] &&
+[ "$switch" = "local" ] && cp $_git/refs/heads/$origlink $_git/refs/heads/$master
+
+( cd $_git/refs/heads/ &&
+    [ -f master ] && [ ! -L master ] &&
+    [ "$(cat master)" != "$(cat origin)" ] &&
+    cp master master_$(date +%Y%m%d%H%M%S)
+    rm -f master
+    if [ "$switch" = "local" ] ; then
+	ln -s $master master
+    else
+	cp $master master
+    fi
+    ln -fs $origlink origin )
+
+git-read-tree -m HEAD && git-checkout-cache -q -f -u -a
+
diff --git a/cg-clone b/cg-clone
--- a/cg-clone
+++ b/cg-clone
@@ -6,10 +6,10 @@
 # This is like cg-init, but it will create a new directory where it will do
 # the checkout.
 #
-# Takes a parameter specifying the location of the source repository and an
-# optional second parameter specifying the destination. If the second
-# parameter is omitted, the basename of the source repository is used as the
-# destination.
+# Takes two parameter specifying the name and location of the source
+# repository, an optional third parameter specifying name of the local branch
+# (defaults to an unnamed branch) and an optional fourth parameter specifying
+# the destination (defaults to the basename of the source repository).
 #
 # OPTIONS
 # -------
@@ -17,7 +17,7 @@
 #	Clone in the current directory instead of creating a new one.
 #	Specifying both -s and a desination directory makes no sense .
 
-USAGE="cg-clone [-s] LOCATION [DESTDIR]"
+USAGE="cg-clone [-s] NAME LOCATION [LOCALNAME [DESTDIR]]"
 
 . ${COGITO_LIB}cg-Xlib
 
@@ -27,9 +27,16 @@ if [ "$1" = "-s" ]; then
 	same_dir=1
 fi
 
+name=$1 && shift
 location=$1
 [ "$location" ] || usage
 location=${location%/}
+if [ $location = $1 ] ; then
+    branch=$(echo $location | cut -d '#' -f 2 -s)
+    location=$(echo $location | cut -d '#' -f 1)
+fi
+shift
+localbranch=$1
 
 destdir=$2
 if [ "$destdir" ]; then
@@ -45,6 +52,8 @@ else
 	location="$location"
 fi
 
+[ "$branch" ] && location=$location#$branch
+
 if [ ! "$same_dir" ]; then
 	[ -e "$dir" ] && die "$dir/ already exists"
 	mkdir "$dir" || exit $?
@@ -54,6 +63,15 @@ else
 fi
 
 trap "rm -rf $dir" SIGTERM EXIT
-cg-init $location || exit $?
+git-init-db
+cg-branch-add $name $location
+cg-pull $name || die "pull failed"
+if [ "$localbranch" ] ; then
+    cg-branch-add $localbranch $name
+    cg-branch-switch $localbranch
+else
+    cg-branch-switch $name
+fi
+echo "Master and origin branches are:"
+cg-branch-switch
 trap "" SIGTERM EXIT
-echo "Cloned to $dir/ (origin $location available as branch \"origin\")"
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -143,10 +143,23 @@ if [ "$merging" ]; then
 	for sym in $(cat $_git/merging-sym); do
 		repo=$(echo $sym | cut -d '#' -f 1)
 		branch=$(echo $sym | cut -d '#' -f 2 -s)
+		if [ -L $_git/refs/heads/$sym ]; then
+			uri=$(readlink $_git/refs/heads/$sym)
+			repo=$(echo $uri | cut -d '#' -f 1)
+			[ -z "$branch" ] &&
+			branch=$(echo $uri | cut -d '#' -f 2 -s)
+		fi
 		uri=$(cat $_git/branches/$repo)
+		urirepo=$(echo $uri | cut -d '#' -f 1)
 		uribranch=$(echo $uri | cut -d '#' -f 2 -s)
-		[ -z "$uribranch" ] && [ -n "$branch" ] &&
-		[ "$branch" != master ] && uri=${uri}#$branch
+		if [ -e $_git/branches/$urirepo ]; then
+		    # local branch
+		    uri="$repo"
+		else
+ 		    # remote branch
+		    [ -z "$uribranch" ] && [ -n "$branch" ] &&
+		    [ "$branch" != master ] && uri=${uri}#$branch
+		fi
 		[ "$uri" ] || uri="$sym"
 		echo "$uri" >>$LOGMSG
 		[ "$msgs" ] && echo "$uri"
diff --git a/cg-merge b/cg-merge
--- a/cg-merge
+++ b/cg-merge
@@ -42,7 +42,8 @@ fi
 [ "$1" ] || usage
 branchname="$1"
 branch=$(commit-id "$branchname") || exit 1
-
+[ -L $_git/refs/heads/$branchname ] &&
+branchname=$(readlink $_git/refs/heads/$branchname| sed 's@/@#@')
 [ "$base" ] || base=$(git-merge-base "$head" "$branch")
 [ "$base" ] || die "unable to automatically determine merge base"
 
diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -19,18 +19,28 @@ USAGE="cg-pull [-a] [BRANCH_NAME]"
 [ "$1" == "-a" ] && all=yes && shift
 name=$1 && shift
 
-[ "$name" ] || { [ -s $_git/refs/heads/origin ] && name=origin; }
+if [ -z "$name" ] && [ -f $_git/branches/origin ]; then
+	#Convert the old layout 2005/06
+	mv $_git/branches/origin $_git/branches/original
+	branch=$(cat $_git/branches/original | cut -s -d '#' -f 2)
+	branch=${branch:-master}
+	[ -f $_git/refs/heads/origin -o -d $_git/refs/heads/origin ] &&
+	rm -rf $_git/refs/heads/origin &&
+	ln -s original/$branch $_git/refs/heads/origin
+fi
+[ "$name" ] || name=$(readlink $_git/refs/heads/origin | sed 's@/@#@')
 [ "$name" ] || die "where to pull from?"
 
 repo=$(echo $name | cut -d '#' -f 1)
 repobranch=$(echo $name | cut -s -d '#' -f 2)
 
-uri=$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch: $name"
-if echo "$uri" | grep -q '#'; then
-	[ -z "$repobranch" ] && repobranch=$(echo $uri | cut -d '#' -f 2)
-	rembranch=$(echo $uri | cut -d '#' -f 2)
-	uri=$(echo $uri | cut -d '#' -f 1)
-fi
+uri=$(cat "$_git/branches/$repo" 2>/dev/null) || die "unknown branch: $name"
+urirepo=$(echo $uri | cut -d '#' -f 1)
+uribranch=$(echo $uri | cut -d '#' -f 2 -s)
+
+[ -e $_git/branches/$urirepo ] && die "Local branches are already pulled"
+
+repobranch=${repobranch:-$uribranch}
 repobranch=${repobranch:-master}
 branch=$repo/$repobranch
 [ "$all" ] && repobranch=

