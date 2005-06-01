From: =?utf-8?q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [COGITO PATCH] Heads and tags in subdirectories
Date: Wed, 01 Jun 2005 18:17:40 +0200
Message-ID: <87ekbmqcez.fsf@gmail.com>
References: <87is0zginw.fsf@ifae.es> <87is0yi66t.fsf@ifae.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 01 18:16:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdVsC-0002Su-KU
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 18:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVFAQSF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 12:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVFAQSF
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 12:18:05 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:25491 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S261446AbVFAQRi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 12:17:38 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j51GHaZ27011
	for <git@vger.kernel.org>; Wed, 1 Jun 2005 18:17:36 +0200
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <87is0yi66t.fsf@ifae.es> (
 =?utf-8?q?Santi_B=C3=A9jar's_message_of?= "Wed, 01 Jun 2005 14:59:22
 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Here it is un updated version, fixing some bugs.

 cg-Xnormid |   14 +++++++++-
 cg-commit  |    7 ++++-
 cg-init    |    5 ++-
 cg-pull    |   78 ++++++++++++++++++++++++++++++++++++-------------------------
 4 files changed, 68 insertions(+), 36 deletions(-)

diff --git a/cg-Xnormid b/cg-Xnormid
--- a/cg-Xnormid
+++ b/cg-Xnormid
@@ -16,15 +16,25 @@
 
 id="$1"
 
+repo=$(echo $id | cut -d '#' -f 1)
+(echo $repo | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
+	die "name contains invalid characters"
+id=$(echo $id | sed 's@#@/@')
+
 if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
 	read id < "$_git/HEAD"
 
-elif [ -r "$_git/refs/tags/$id" ]; then
+elif [ -r "$_git/refs/tags/$id" ] && [ ! -d "$_git/refs/tags/$id" ]; then
 	read id < "$_git/refs/tags/$id"
 
-elif [ -r "$_git/refs/heads/$id" ]; then
+elif [ -r "$_git/refs/heads/$id" ] && [ ! -d "$_git/refs/heads/$id" ]; then
 	read id < "$_git/refs/heads/$id"
 
+elif [ -r "$_git/branches/$id" ]; then
+	repobranch=$(cat "$_git/branches/$id" | cut -d '#' -f 2 -s)
+	repobranch=${repobranch:-master}
+	read id < "$_git/refs/heads/$id/$repobranch"
+
 # Short id's must be lower case and at least 4 digits.
 elif [[ "$id" == [0-9a-z][0-9a-z][0-9a-z][0-9a-z]* ]]; then
 	idpref=${id:0:2}
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -141,7 +141,12 @@ if [ "$merging" ]; then
 	[ "$msgs" ] && echo -n 'Merge with '
 	[ -s $_git/merging-sym ] || cp $_git/merging $_git/merging-sym
 	for sym in $(cat $_git/merging-sym); do
-		uri=$(cat $_git/branches/$sym)
+		repo=$(echo $sym | cut -d '#' -f 1)
+		branch=$(echo $sym | cut -d '#' -f 2 -s)
+		uri=$(cat $_git/branches/$repo)
+		uribranch=$(echo $uri | cut -d '#' -f 2 -s)
+		[ -z "$uribranch" ] && [ -n "$branch" ] &&
+		[ "$branch" != master ] && uri=${uri}#$branch
 		[ "$uri" ] || uri="$sym"
 		echo "$uri" >>$LOGMSG
 		[ "$msgs" ] && echo "$uri"
diff --git a/cg-init b/cg-init
--- a/cg-init
+++ b/cg-init
@@ -29,8 +29,9 @@ ln -s refs/heads/master $_git/HEAD
 if [ "$uri" ]; then
 	echo "$uri" >$_git/branches/origin
 	cg-pull origin || die "pull failed"
-
-	cp $_git/refs/heads/origin $_git/refs/heads/master
+	uribranch=$(echo $uri | cut -d '#' -f 2 -s)
+	uribranch=${uribranch:-master}
+	cp $_git/refs/heads/origin/$uribranch $_git/refs/heads/master
 	git-read-tree HEAD
 	git-checkout-cache -a
 	git-update-cache --refresh
diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -6,23 +6,41 @@
 # Takes the branch name as an argument, defaulting to "origin".
 #
 # See `cg-branch-add` for some description.
+#
+# OPTIONS
+# -------
+# -a::
+#       Pull all the heads from repositori.
 
-USAGE="cg-pull [BRANCH_NAME]"
+USAGE="cg-pull [-a] [BRANCH_NAME]"
 
 . ${COGITO_LIB}cg-Xlib
 
-name=$1
-
+[ "$1" == "-a" ] && all=yes && shift
+name=$1 && shift
 
 [ "$name" ] || { [ -s $_git/refs/heads/origin ] && name=origin; }
 [ "$name" ] || die "where to pull from?"
-uri=$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch: $name"
 
-rembranch=master
+repo=$(echo $name | cut -d '#' -f 1)
+repobranch=$(echo $name | cut -s -d '#' -f 2)
+
+uri=$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch: $name"
 if echo "$uri" | grep -q '#'; then
+	[ -z "$repobranch" ] && repobranch=$(echo $uri | cut -d '#' -f 2)
 	rembranch=$(echo $uri | cut -d '#' -f 2)
 	uri=$(echo $uri | cut -d '#' -f 1)
 fi
+repobranch=${repobranch:-master}
+branch=$repo/$repobranch
+[ "$all" ] && repobranch=
+
+# So long we have:
+# $repo       = name of the repositori
+# $uri        = uri of the repositori
+# $repobranch = name of the branch in the repositori
+#               empty if we want all the branches
+# $branch     = name of the local branch in refs/heads/
 
 pull_progress() {
 	percentage=""
@@ -197,15 +215,15 @@ fetch_local () {
 		shift
 	fi
 
-	cut_last=
+	dirs=
 	if [ "$1" = "-d" ]; then
-		cut_last=1
+		dirs=1
 		shift
 	fi
 
 	src="$1"
 	dest="$2"
-	[ "$cut_last" ] && dest=${dest%/*}
+	[ "$dirs" ] && src="${src%/}/."
 
 	cp $cp_flags_l "$src" "$dest"
 }
@@ -232,39 +250,37 @@ fi
 
 
 orig_head=
-[ -s "$_git/refs/heads/$name" ] && orig_head=$(cat "$_git/refs/heads/$name")
-
+[ -s "$_git/refs/heads/$branch" ] && orig_head=$(cat "$_git/refs/heads/$branch")
 
-mkdir -p $_git/refs/heads
-rsyncerr=
-$fetch -i "$uri/refs/heads/$rembranch" "$_git/refs/heads/$name" || rsyncerr=1
-if [ "$rsyncerr" ]; then
-	rsyncerr=
-	$fetch -s "$uri/heads/$rembranch" "$_git/refs/heads/$name" || rsyncerr=1
-fi
-if [ "$rsyncerr" ] && [ "$rembranch" = "master" ]; then
-	rsyncerr=
-	$fetch -s "$uri/HEAD" "$_git/refs/heads/$name" || rsyncerr=1
+# 2005/05 Convert old layout
+[ -f $_git/refs/heads/$repo ] && orig_head=$(cat $_git/refs/heads/$repo) &&
+rm -f $_git/refs/heads/$repo
+
+mkdir -p $_git/refs/heads/$repo
+if [ "$repobranch" ] ; then
+    $fetch -i "$uri/refs/heads/$repobranch" "$_git/refs/heads/$branch" ||
+    $fetch -s "$uri/heads/$repobranch" "$_git/refs/heads/$branch" ||
+    { [ "$repobranch" = "master" ] && $fetch -s "$uri/HEAD" "$_git/refs/heads/$branch"; } ||
+    rsyncerr=1
+else
+    $fetch -i -d "$uri/refs/heads" "$_git/refs/heads/$repo" ||
+    $fetch -s -d "$uri/heads" "$_git/refs/heads/$repo" ||
+    rsyncerr=1
 fi
-[ "$rsyncerr" ] && die "unable to get the head pointer of branch $rembranch"
+[ "$rsyncerr" ] && die "unable to get the head pointer of branch $repobranch"
 
 [ -d $_git_objects ] || mkdir -p $_git_objects
-$pull "$name" "$uri" || die "objects pull failed"
+$pull "$branch" "$uri" || die "objects pull failed"
 
-# FIXME: Warn about conflicting tag names?
 # XXX: We now throw stderr to /dev/null since not all repositories
 # may have tags/ and users were confused by the harmless errors.
-[ -d $_git/refs/tags ] || mkdir -p $_git/refs/tags
+[ -d $_git/refs/tags/$repo ] || mkdir -p $_git/refs/tags/$repo
 rsyncerr=
-$fetch -i -s -u -d "$uri/refs/tags" "$_git/refs/tags" || rsyncerr=1
-if [ "$rsyncerr" ]; then
-	rsyncerr=
-	$fetch -i -s -u -d "$uri/tags" "$_git/refs/tags" || rsyncerr=1
-fi
+$fetch -i -s -u -d "$uri/refs/tags" "$_git/refs/tags/$repo" ||
+$fetch -i -s -u -d "$uri/tags" "$_git/refs/tags/$repo" || rsyncerr=1
 [ "$rsyncerr" ] && echo "unable to get tags list (non-fatal)" >&2
 
-
-new_head=$(cat "$_git/refs/heads/$name")
+new_head=$(cat "$_git/refs/heads/$branch")
 
 if [ ! "$orig_head" ]; then
 	echo "New branch: $new_head"

