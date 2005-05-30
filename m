From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: cg-update with local uncommitted changes
Date: Tue, 31 May 2005 00:31:28 +0200
Message-ID: <d7g430$1cq$1@sea.gmane.org>
References: <1117463114.7072.185.camel@pegasus>	 <20050530183932.GB10439@pasky.ji.cz> <1117480796.7072.204.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060300060206030302010101"
X-From: git-owner@vger.kernel.org Tue May 31 00:31:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcsmR-0006vI-Oe
	for gcvg-git@gmane.org; Tue, 31 May 2005 00:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVE3WdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 18:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVE3WdK
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 18:33:10 -0400
Received: from main.gmane.org ([80.91.229.2]:14763 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261791AbVE3Wca (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 18:32:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Dcsl3-0006oS-45
	for git@vger.kernel.org; Tue, 31 May 2005 00:29:17 +0200
Received: from c80-217-52-214.cm-upc.chello.se ([80.217.52.214])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 31 May 2005 00:29:17 +0200
Received: from holmsand by c80-217-52-214.cm-upc.chello.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 31 May 2005 00:29:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c80-217-52-214.cm-upc.chello.se
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <1117480796.7072.204.camel@pegasus>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------060300060206030302010101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
> I also think that it would be great if we cancel the merge if the local
> changes conflict with the files in the merge. This is how Bitkeeper does
> it and I think it is the only safe way, because if something fails or
> rejects we may destroy the local changes.

I definitely agree (been bitten by patching gone wild a couple of times...).

This patch would make cg-merge and cg-admin-uncommit refuse to do 
anything if there are conflicting uncommitted changes. Note: this only 
applies to fast-forward merging, as cg-merge otherwise bails out if 
there are *any* uncommitted changes (which is perhaps going to far).

/dan

[PATCH] Make tree_timewarp safe, by refusing to handle conflicts.

Signed-off-by: Dan Holmsand <holmsand@gmail.com>


--------------060300060206030302010101
Content-Type: text/plain;
 name="merge.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="merge.patch.txt"

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -50,47 +50,22 @@ showdate () {
 }
 
 
-# Usage: tree_timewarp DIRECTION_STR ROLLBACK_BOOL BASE BRANCH
+# Usage: tree_timewarp BASE BRANCH
 tree_timewarp () {
-	dirstr=$1; shift
-	rollback=$1; shift
-	base=$1; shift
-	branch=$1; shift
-
-	patchfile=$(mktemp -t gituncommit.XXXXXX)
-	if [ "$rollback" ]; then
-		cg-diff >$patchfile
-		[ -s "$patchfile" ] &&
-			echo "Warning: uncommitted local changes, trying to bring them $dirstr" >&2
-	else
-		# XXX: This may be suboptimal, but it is also non-trivial to keep
-		# the adds/removes properly.  So this is just a quick hack to get it
-		# working without much fuss.
-		cg-diff -r $branch >$patchfile
-	fi
-
-	git-read-tree -m "$branch" || die "$branch: bad commit"
-	echo "$branch" > $_git/HEAD
-
-	# Kill gone files
-	git-diff-tree -z -r $base $branch | xargs -0 bash -c '
-		while [ "$1" ]; do
-			header="$1"; shift
-			file="$1"; shift
-
-			# match ":100755 000000 14d43b1abf... 000000000... D"
-			if echo "$header" | egrep "^:([^ ][^ ]* ){4}D" >/dev/null; then
-				rm -- "$file"
-			fi
-		done
-	' padding
-	git-checkout-cache -f -a
-
-	# FIXME: Can produce bogus "contains only garbage" messages.
-	cat $patchfile | cg-patch
-	rm $patchfile
+	local conflicts base=$1 branch=$2
 
 	git-update-cache --refresh >/dev/null
+	conflicts=$( (git-diff-tree -r $base $branch; 
+		git-diff-cache -r HEAD) | cut -f2- | sort | uniq -d )
+	[ -z "$conflicts" ] || 
+		die "conflicting uncommitted changes: $conflicts"
+
+	git-read-tree -m $branch || die "read-tree failed"
+	git-diff-tree -r $base $branch | cut -f5- -d' ' | grep '^[NM]' | 
+	cut -f2- | tr \\n \\0 | xargs -0 git-checkout-cache -u -f --
+	git-diff-tree -r $base $branch | cut -f5- -d' ' | grep '^[D]' | 
+	cut -f2- | tr \\n \\0 | xargs -0 rm -f --
+	echo "$branch" > $_git/HEAD
 }
 
 
diff --git a/cg-admin-uncommit b/cg-admin-uncommit
--- a/cg-admin-uncommit
+++ b/cg-admin-uncommit
@@ -39,10 +39,15 @@ commit=$(commit-id "$1") || exit 1
 git-rev-list $base | grep -q $commit || \
 	die "$commit: not an ancestor of HEAD"
 
-parent=$(parent-id "$commit") || exit 1
+parent=$(parent-id "$commit" | head -n 1) || exit 1
 [ "$parent" ] || die "cannot rewind behind the initial commit"
 
 
 echo "Rewinding $base (HEAD) -> $parent" >&2
 
-tree_timewarp "backwards" "$rollback_tree" $base $parent
+if [ "$rollback_tree" ]; then
+	tree_timewarp $base $parent
+else
+	git-read-tree -m $parent || die "git-read-tree failed"
+	echo "$parent" > $_git/HEAD
+fi
diff --git a/cg-merge b/cg-merge
--- a/cg-merge
+++ b/cg-merge
@@ -65,7 +65,7 @@ if [ "$head" = "$base" ]; then
 	echo "Fast-forwarding $base -> $branch" >&2
 	echo -e "\ton top of $head..." >&2
 
-	tree_timewarp "forward" "yes, rollback (or rather rollforth) the tree!" $base $branch
+	tree_timewarp $base $branch
 
 	exit 0
 fi

--------------060300060206030302010101--

