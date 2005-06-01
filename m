From: =?utf-8?q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [COGITO PATCH] cg-branch-switch and local branches
Date: Wed, 01 Jun 2005 15:03:42 +0200
Message-ID: <87ekbmi5zl.fsf@ifae.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jun 01 15:11:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdSy7-0005xq-Jj
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 15:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVFANIv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 1 Jun 2005 09:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFANGb
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 09:06:31 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:58505 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S261277AbVFANDp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 09:03:45 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j51D3eZ11656
	for <git@vger.kernel.org>; Wed, 1 Jun 2005 15:03:40 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Make origin a symbolic link to the origin branch.
Make master a symbolic link to the local branch or
            a file for an unnamed branch.
Add cg-branch-switch to switch branches.

Signed-off-by: "Santi B=C3=A9jar" <sbejar@gmail.com>

---
 Makefile         |    3 +
 cg-Xnormid       |    2 +
 cg-branch-add    |   19 +++++++++
 cg-branch-switch |  107 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
 cg-clone         |   32 ++++++++++++----
 cg-commit        |   11 ++++-
 cg-merge         |    3 +
 cg-pull          |   14 +++++--
 8 files changed, 177 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -55,7 +55,8 @@ PROG=3D   git-update-cache git-diff-files=20
 SCRIPT=3D	commit-id tree-id parent-id cg-add cg-admin-lsobj cg-admin-u=
ncommit \
 	cg-branch-add cg-branch-ls cg-cancel cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-ls cg-merge cg-mkpatch cg-patch \
-	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update
+	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update=
 \
+	cg-branch-switch
=20
 LIB_SCRIPT=3Dcg-Xlib cg-Xmergefile cg-Xnormid
=20
diff --git a/cg-Xnormid b/cg-Xnormid
--- a/cg-Xnormid
+++ b/cg-Xnormid
@@ -16,6 +16,8 @@
=20
 id=3D"$1"
=20
+[ -L $_git/refs/heads/$id ] &&
+id=3D$(readlink $_git/refs/heads/$id | sed 's@/@#@')
 repo=3D$(echo $id | cut -d '#' -f 1)
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
+# After you create a local branch, you can `cg-branch-switch` it whene=
ver you
+# want and you will be able to work on your local branch. Its {latest,=
origin}
+# commit is accessible as `.git/refs/heads/{master,origin}` (or - more
+# conveniently - as `$(commit-id {master,origin})`).
+# For example, to make a diff between your origin and your current tre=
e, do:
+#
+#	$ cg-diff -r origin
+#
+# The origin specifier is a name of a branch added with cg-branch-add,
+# followed with an optional fragment part, which identifies a alternat=
ive
+# branch inside of the repository.
=20
 USAGE=3D"cg-branch-add BRANCH_NAME LOCATION"
=20
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
+# The content of $_git/branches/${localbranch} is the original branch =
of
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
+# The master file is a regula file and the origin link only has the ca=
ses
+# 1a and 1b where the $name is the parameter to the script.
+
+USAGE=3D"cg-switch-tree [BRANCH]"
+
+. ${COGITO_LIB}cg-Xlib
+
+name=3D$1
+
+[ -e $_git/refs/heads/origin ] && [ ! -L $_git/refs/heads/origin ] &&
+die "$_git/refs/heads/origin must be a symbolic link"
+
+[ -e $_git/blocked ] && die "switch blocked: $(cat $_git/blocked)"
+
+oldmaster=3D$(readlink $_git/refs/heads/master)
+oldorigin=3D$(readlink $_git/refs/heads/origin)
+
+[ -z "$name" ] && echo "master $(echo $oldmaster | sed 's@/@#@' )" &&
+echo "origin $(echo $oldorigin | sed 's@/@#@' )" && exit 0
+
+oldmaster=3D${oldmaster:-master}
+
+namerepo=3D$(echo $name | cut -d '#' -f 1)
+namebranch=3D$(echo $name | cut -d '#' -f 2 -s)
+[ -e "$_git/branches/$namerepo" ] || die "unknown branch: $name"
+origuri=3D$(cat "$_git/branches/$namerepo")
+origrepo=3D$(echo $origuri | cut -d '#' -f 1)
+origbranch=3D$(echo $origuri | cut -d '#' -f 2 -s)
+
+if [ -e "$_git/branches/$origrepo" ] ; then
+    # $name is a local branch
+    switch=3Dlocal
+    master=3D$namerepo
+    [ -e "$_git/branches/$origrepo" ] || die "do not exist local branc=
h: $name"
+    uri=3D$(cat $_git/branches/$origrepo)
+    if [ -e "$_git/branches/$(echo $uri| cut -d '#' -f 1)" ] ; then
+    # Origin is a local branch
+	origlink=3D$origuri
+	[ "$namebranch" ] && die "local branches cannot have branches"
+    else
+    # Origin is a external branch
+	extbranch=3D${namebranch:-$origbranch}
+	extbranch=3D${extbranch:-master}
+	origlink=3D$origrepo/$extbranch
+    fi
+else
+    # Origin is an external unnamed branch
+    switch=3Dunnnamed
+    extbranch=3D${namebranch:-$origbranch}
+    extbranch=3D${extbranch:-master}
+    origlink=3D$namerepo/$extbranch
+    master=3D$namerepo/$extbranch
+fi
+
+[ ! -r $_git/refs/heads/$origlink ] && die "unknown branch: $origlink"
+
+if [ "$(git-diff-files -s)" ] || [ "$(git-diff-cache HEAD 2>/dev/null)=
" ]; then
+	die "switch blocked: local changes"
+fi
+
+[ ! -r $_git/refs/heads/$master -o ! -s $_git/refs/heads/$master ] &&
+[ "$switch" =3D "local" ] && cp $_git/refs/heads/$origlink $_git/refs/=
heads/$master
+
+( cd $_git/refs/heads/ &&
+    [ -f master ] && [ ! -L master ] &&
+    [ "$(cat master)" !=3D "$(cat origin)" ] &&
+    cp master master_$(date +%Y%m%d%H%M%S)
+    rm -f master
+    if [ "$switch" =3D "local" ] ; then
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
 # This is like cg-init, but it will create a new directory where it wi=
ll do
 # the checkout.
 #
-# Takes a parameter specifying the location of the source repository a=
nd an
-# optional second parameter specifying the destination. If the second
-# parameter is omitted, the basename of the source repository is used =
as the
-# destination.
+# Takes two parameter specifying the name and location of the source
+# repository, an optional third parameter specifying name of the local=
 branch
+# (defaults to an unnamed branch) and an optional fourth parameter spe=
cifying
+# the destination (defaults to the basename of the source repository).
 #
 # OPTIONS
 # -------
@@ -17,7 +17,7 @@
 #	Clone in the current directory instead of creating a new one.
 #	Specifying both -s and a desination directory makes no sense .
=20
-USAGE=3D"cg-clone [-s] LOCATION [DESTDIR]"
+USAGE=3D"cg-clone [-s] NAME LOCATION [LOCALNAME [DESTDIR]]"
=20
 . ${COGITO_LIB}cg-Xlib
=20
@@ -27,9 +27,16 @@ if [ "$1" =3D "-s" ]; then
 	same_dir=3D1
 fi
=20
+name=3D$1 && shift
 location=3D$1
 [ "$location" ] || usage
 location=3D${location%/}
+if [ $location =3D $1 ] ; then
+    branch=3D$(echo $location | cut -d '#' -f 2 -s)
+    location=3D$(echo $location | cut -d '#' -f 1)
+fi
+shift
+localbranch=3D$1
=20
 destdir=3D$2
 if [ "$destdir" ]; then
@@ -45,6 +52,8 @@ else
 	location=3D"$location"
 fi
=20
+[ "$branch" ] && location=3D$location#$branch
+
 if [ ! "$same_dir" ]; then
 	[ -e "$dir" ] && die "$dir/ already exists"
 	mkdir "$dir" || exit $?
@@ -54,6 +63,15 @@ else
 fi
=20
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
-echo "Cloned to $dir/ (origin $location available as branch \"origin\"=
)"
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -144,9 +144,16 @@ if [ "$merging" ]; then
 		repo=3D$(echo $sym | cut -d '#' -f 1)
 		branch=3D$(echo $sym | cut -d '#' -f 2 -s)
 		uri=3D$(cat $_git/branches/$repo)
+		urirepo=3D$(echo $uri | cut -d '#' -f 1)
 		uribranch=3D$(echo $uri | cut -d '#' -f 2 -s)
-		[ -z "$uribranch" ] && [ -n "$branch" ] &&
-		[ "$branch" !=3D master ] && uri=3D${uri}#$branch
+		if [ -e $_git/branches/$urirepo ]; then
+		    # local branch
+		    uri=3D"$sym"
+		else
+ 		    # remote branch
+		    [ -z "$uribranch" ] && [ -n "$branch" ] &&
+		    [ "$branch" !=3D master ] && uri=3D${uri}#$branch
+		fi
 		[ "$uri" ] || uri=3D"$sym"
 		echo "$uri" >>$LOGMSG
 		[ "$msgs" ] && echo "$uri"
diff --git a/cg-merge b/cg-merge
--- a/cg-merge
+++ b/cg-merge
@@ -42,7 +42,8 @@ fi
 [ "$1" ] || usage
 branchname=3D"$1"
 branch=3D$(commit-id "$branchname") || exit 1
-
+[ -L $_git/refs/heads/$branchname ] &&
+branchname=3D$(readlink $_git/refs/heads/$branchname| sed 's@/@#@')
 [ "$base" ] || base=3D$(git-merge-base "$head" "$branch")
 [ "$base" ] || die "unable to automatically determine merge base"
=20
diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -19,16 +19,24 @@ USAGE=3D"cg-pull [-a] [BRANCH_NAME]"
 [ "$1" =3D=3D "-a" ] && all=3Dyes && shift
 name=3D$1 && shift
=20
-[ "$name" ] || { [ -s $_git/refs/heads/origin ] && name=3Dorigin; }
+if [ -z "$name" ] && [ -f $_git/branches/origin ]; then
+	#Convert the old layout 2005/06
+	mv $_git/branches/origin $_git/branches/original
+	branch=3D$(cat $_git/branches/original | cut -s -d '#' -f 2)
+	branch=3D${branch:-master}
+	[ -f $_git/refs/heads/origin -o -d $_git/refs/heads/origin ] &&
+	rm -rf $_git/refs/heads/origin &&
+	ln -s original/$branch $_git/refs/heads/origin
+fi
+[ "$name" ] || name=3D$(readlink $_git/refs/heads/origin | sed 's@/@#@=
')
 [ "$name" ] || die "where to pull from?"
=20
 repo=3D$(echo $name | cut -d '#' -f 1)
 repobranch=3D$(echo $name | cut -s -d '#' -f 2)
=20
-uri=3D$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch=
: $name"
+uri=3D$(cat "$_git/branches/$repo" 2>/dev/null) || die "unknown branch=
: $name"
 if echo "$uri" | grep -q '#'; then
 	[ -z "$repobranch" ] && repobranch=3D$(echo $uri | cut -d '#' -f 2)
-	rembranch=3D$(echo $uri | cut -d '#' -f 2)
 	uri=3D$(echo $uri | cut -d '#' -f 1)
 fi
 repobranch=3D${repobranch:-master}

