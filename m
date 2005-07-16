From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] git-revover-tags-script
Date: Sat, 16 Jul 2005 14:20:49 -0600
Message-ID: <m1u0iuo63i.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 16 22:21:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtt9v-00035n-6J
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 22:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVGPUVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 16:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVGPUVI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 16:21:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34008 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261632AbVGPUVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 16:21:07 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6GKKnru020696;
	Sat, 16 Jul 2005 14:20:49 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6GKKnPY020695;
	Sat, 16 Jul 2005 14:20:49 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


First pass at a script to dig through .git/objects and find dangling
tags.  It likely has a lot of weird limitations, I don't know if it
will work with packs, and the policy it implments is pretty stupid,
but it is a sane start and should keep people from needing to
rsync anything except the .git/objects part of the tree.

The current policy is if a tag's gpg signature can be verified
and if the tag name does not conflict with an existing tag
place it in .git/refs/tags/.   So far this only works with
dangling tags so I don't know if these tags will even be pulled
with the pack methods.  But since we aren't quite going at
full speed on those yet we should be good.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 Makefile                |    3 ++-
 git-recover-tags-script |   27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletions(-)
 create mode 100755 git-recover-tags-script

4b171e71fd6b5de56dd4a93ea203e49115c2caee
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -36,7 +36,8 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-reset-script git-add-script git-checkout-script git-clone-script \
 	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
 	git-format-patch-script git-sh-setup-script git-push-script \
-	git-branch-script git-parse-remote git-verify-tag-script
+	git-branch-script git-parse-remote git-verify-tag-script \
+	git-recover-tags-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-recover-tags-script b/git-recover-tags-script
new file mode 100755
--- /dev/null
+++ b/git-recover-tags-script
@@ -0,0 +1,27 @@
+#!/bin/sh
+# Copyright (c) 2005 Eric Biederman
+
+. git-sh-setup-script || die "Not a git archive"
+
+TMP_TAG=".tmp-tag.$$"
+git-fsck-cache |
+while read status type sha1 rest ; do
+	if [ '(' "$status" == "dangling" ')' -a '(' "$type" == "tag" ')' ] ; then
+		if ! git-verify-tag-script $sha1 ; then
+			echo "Could not verify tag $sha1"
+		else
+			tag=$(git-cat-file tag $sha1 | sed -ne 's/^tag //p')
+			tagger=$(git-cat-file tag $sha1 | sed -ne 's/^tagger //p')
+			if [ ! -e $GIT_DIR/refs/tags/$tag ]; then
+				echo "installing tag $tag tagger $tagger"
+				mkdir -p $GIT_DIR/refs/tags
+				echo "$sha1" > $GIT_DIR/refs/tags/$tag
+			fi
+		fi
+	else
+		if [ "$status" != "dangling" ] ; then
+			echo "$status $type $sha1 $rest";
+		fi
+	fi
+done
+rm -f $TMP_TAG
