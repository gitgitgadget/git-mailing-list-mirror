From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] cogito: replace "git-* $(tree-id)" with "git-* HEAD"
Date: Wed, 4 May 2005 19:48:07 +0200
Message-ID: <20050504174807.GA21145@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 19:45:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTNvE-0001C8-N9
	for gcvg-git@gmane.org; Wed, 04 May 2005 19:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVEDRtz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 13:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVEDRtz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 13:49:55 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:47794 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261251AbVEDRsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 13:48:09 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 828C9543; Wed,  4 May 2005 19:48:07 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree-id, when called without parameters, prints the tree ID in the
commit object whose ID is in .git/HEAD.  Both git-diff-cache and
git-read-tree (in general all GIT tools that use get_sha1()) can get
this ID from .git/HEAD themselves when they are called with "HEAD" as
ID parameter.  So this patch replaces occurences of "git-* $(tree-id)"
with "git-* HEAD".  This speeds things up a bit and also makes the
intent of the git-* calls a bit more clear.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Index: cg-cancel
===================================================================
--- aa6233be6d1b8bf42797c409a7c23b50593afc99/cg-cancel  (mode:100755 sha1:4d1e6d9d112f050b402a454a4c04de4d4e379524)
+++ 0ff2b865104800b6a0dbbe17093bfca6e8b52898/cg-cancel  (mode:100755 sha1:dab527132a33922901bc184a8e7dad57b757b991)
@@ -26,7 +26,7 @@
 fi
 
 rm -f .git/blocked .git/merging .git/merging-sym .git/merge-base
-git-read-tree -m $(tree-id) || git-read-tree $(tree-id)
+git-read-tree -m HEAD || git-read-tree HEAD
 
 git-checkout-cache -f -a
 git-update-cache --refresh
Index: cg-commit
===================================================================
--- aa6233be6d1b8bf42797c409a7c23b50593afc99/cg-commit  (mode:100755 sha1:e80567a50e297d2a060773b5f10e193243ac340e)
+++ 0ff2b865104800b6a0dbbe17093bfca6e8b52898/cg-commit  (mode:100755 sha1:8f2514eac77fb9a23d6eba4e2f748914162da3d8)
@@ -37,7 +37,7 @@
 	# be committed along automagically as well.
 
 	if [ ! "$ignorecache" ]; then
-		changedfiles=$(git-diff-cache $(tree-id) | cut -f 4-)
+		changedfiles=$(git-diff-cache HEAD | cut -f 4-)
 		commitfiles="$addedfiles $remfiles $changedfiles"
 	fi
 
@@ -79,7 +79,7 @@
 		echo $commitfiles | xargs git-update-cache --add --remove \
 			|| die "update-cache failed"
 		export GIT_INDEX_FILE=$(mktemp -t gitci.XXXXXX)
-		git-read-tree $(tree-id)
+		git-read-tree HEAD
 	fi
 	# TODO: Do the proper separation of adds, removes, and changes.
 	echo $commitfiles | xargs git-update-cache --add --remove \
Index: cg-init
===================================================================
--- aa6233be6d1b8bf42797c409a7c23b50593afc99/cg-init  (mode:100755 sha1:229b64901d7d8e67d900b9c8e558f18ceb3b8a5f)
+++ 0ff2b865104800b6a0dbbe17093bfca6e8b52898/cg-init  (mode:100755 sha1:90a9d5497a0a70830094d2ee552d974819858ec4)
@@ -22,7 +22,7 @@
 	cg-pull origin || die "pull failed"
 
 	cp .git/refs/heads/origin .git/refs/heads/master
-	git-read-tree $(tree-id)
+	git-read-tree HEAD
 	git-checkout-cache -a
 	git-update-cache --refresh
 
Index: cg-merge
===================================================================
--- aa6233be6d1b8bf42797c409a7c23b50593afc99/cg-merge  (mode:100755 sha1:8c3f68b26346ad02474f595b651be77fc8958aa5)
+++ 0ff2b865104800b6a0dbbe17093bfca6e8b52898/cg-merge  (mode:100755 sha1:13b4dcf70dfa7f878c9599276c0d77908190b834)
@@ -79,7 +79,7 @@
 
 
 [ "$(git-diff-files -s)" ] && git-update-cache --refresh
-if [ "$(git-diff-files -s)" ] || [ "$(git-diff-cache $(tree-id))" ]; then
+if [ "$(git-diff-files -s)" ] || [ "$(git-diff-cache HEAD)" ]; then
 	die "merge blocked: local changes"
 fi
 
@@ -139,5 +139,5 @@
 readtree=
 cg-commit -C || { readtree=1 ; echo "cg-merge: COMMIT FAILED, retry manually" >&2; }
 
-[ "$readtree" ] && git-read-tree -m $(tree-id)
+[ "$readtree" ] && git-read-tree -m HEAD
 git-update-cache --refresh
Index: cg-seek
===================================================================
--- aa6233be6d1b8bf42797c409a7c23b50593afc99/cg-seek  (mode:100755 sha1:111f7842e5ec20a1e0714e162ca221da5e06ce33)
+++ 0ff2b865104800b6a0dbbe17093bfca6e8b52898/cg-seek  (mode:100755 sha1:648c2b0db6e935d4768ca4820c91e7863e8487f4)
@@ -45,7 +45,7 @@
 fi
 
 if [ "$curcommit" != "$dstcommit" ]; then
-	git-read-tree -m $(tree-id)
+	git-read-tree -m HEAD
 	cg-diff -r $curcommit:$dstcommit | cg-patch
 	git-update-cache --refresh
 fi
