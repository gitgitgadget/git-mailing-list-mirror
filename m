From: Simon Sasburg <simon.sasburg@gmail.com>
Subject: [PATCH 1/3] Introduce --dirty option to git-rebase, allowing you to start from a dirty state.
Date: Thu,  1 Nov 2007 22:30:22 +0100
Message-ID: <1193952624-608-2-git-send-email-Simon.Sasburg@gmail.com>
References: <1193952624-608-1-git-send-email-Simon.Sasburg@gmail.com>
Cc: git@vger.kernel.org, Simon Sasburg <Simon.Sasburg@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 01 22:33:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InhfA-0001oX-1E
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbXKAVcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753621AbXKAVcd
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:32:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23844 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbXKAVcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:32:32 -0400
Received: by ug-out-1314.google.com with SMTP id z38so551264ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=Ll1suMghnuQ+Z7BRiPP7hLOO4xF1jsIuouCXbgmbkO8=;
        b=sxbguX4/xJA0BPW1fhFX4YVmziaYD/LCIVU6rQBl2BG63VgpYGvGQhkuvMdekFwzRZatX/n5K7m379HSGiP0dQBH34JXqKw1Frzffv7xzOZ2ZQc6rJqBoj8uS7oAXWhBRru7+BgKAswOIP7TzJ+Cx4Dh1xmfQ7CPBpthDtvNjDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=Jdos+pBlZhF6VKZ5+Nw2XUOaWpSGpMo7AaGvbIN3tJBA7oMoa55/B5VLE7ME7XjUhcJJ0eRjvDTql7KpeRZ4EpavvHswz0zH5bTIOKhsKl3PgzC9aPO7CdvgwFNhXjNAXImvO1sMw6toGASsw01hW1pvh2wZub13flh88vsmOIs=
Received: by 10.78.201.15 with SMTP id y15mr857135huf.1193952749826;
        Thu, 01 Nov 2007 14:32:29 -0700 (PDT)
Received: from localhost ( [86.85.232.104])
        by mx.google.com with ESMTPS id f3sm2302439nfh.2007.11.01.14.32.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 14:32:29 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.503.gbcee6f4
In-Reply-To: <1193952624-608-1-git-send-email-Simon.Sasburg@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63009>

This will store the difference between HEAD and the index into a commit,
and the difference between the index and the working tree into a commit.

When the rebase is done, it restores the index and the working tree
by undoing these commits with git-reset.

Signed-off-by: Simon Sasburg <Simon.Sasburg@gmail.com>
---
 git-rebase.sh |   63 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 224cca9..c923c3b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -42,6 +42,7 @@ To restore the original branch and stop rebasing run \"git rebase --abort\".
 unset newbase
 strategy=recursive
 do_merge=
+fix_dirty=
 dotest=$GIT_DIR/.dotest-merge
 prec=4
 verbose=
@@ -117,9 +118,39 @@ call_merge () {
 
 finish_rb_merge () {
 	rm -r "$dotest"
+	restore_dirty_state
 	echo "All done."
 }
 
+store_dirty_state () {
+	echo "Storing dirty index/working tree"
+	diff=$(git diff --cached)
+	case "$diff" in
+	?*)	git commit -m "REBASE--dirty: store HEAD..index diff"
+		;;
+	esac
+	diff=$(git diff)
+	case "$diff" in
+	?*)	git commit -a -m "REBASE--dirty: store index..workingtree diff"
+		;;
+	esac
+}
+
+restore_dirty_state () {
+	lastmsg=$(git-rev-list HEAD^..HEAD --pretty=oneline | sed "s:[^ ]* ::")
+	if test "$lastmsg" = "REBASE--dirty: store index..workingtree diff"
+	then
+		echo "Restoring dirty index state"
+		git reset --mixed HEAD^
+	fi
+	lastmsg=$(git-rev-list HEAD^..HEAD --pretty=oneline | sed "s:[^ ]* ::")
+	if test "$lastmsg" = "REBASE--dirty: store HEAD..index diff"
+	then
+		echo "Restoring dirty working dir state"
+		git reset --soft HEAD^
+	fi
+}
+
 is_interactive () {
 	test -f "$dotest"/interactive ||
 	while :; do case $#,"$1" in 0,|*,-i|*,--interactive) break ;; esac
@@ -156,6 +187,10 @@ do
 		git am --resolved --3way --resolvemsg="$RESOLVEMSG"
 		exit
 		;;
+	--dirty)
+		do_merge=t
+		fix_dirty=t
+		;;
 	--skip)
 		if test -d "$dotest"
 		then
@@ -188,6 +223,7 @@ do
 			die "No rebase in progress?"
 		fi
 		git reset --hard ORIG_HEAD
+		restore_dirty_state
 		exit
 		;;
 	--onto)
@@ -253,15 +289,19 @@ else
 	fi
 fi
 
-# The tree must be really really clean.
-git update-index --refresh || exit
-diff=$(git diff-index --cached --name-status -r HEAD)
-case "$diff" in
-?*)	echo "cannot rebase: your index is not up-to-date"
-	echo "$diff"
-	exit 1
-	;;
-esac
+# The tree must be really really clean, unless --dirty is given.
+if test "$fix_dirty" = ""
+then
+	git update-index --refresh || exit
+	diff=$(git diff-index --cached --name-status -r HEAD)
+	case "$diff" in
+	?*)	echo "cannot rebase: your index is not up-to-date"
+		echo "$diff"
+		exit 1
+		;;
+	esac
+	
+fi
 
 # The upstream head must be given.  Make sure it is valid.
 upstream_name="$1"
@@ -318,6 +358,11 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
+if test "$fix_dirty" = "t"
+then
+	store_dirty_state
+fi
+
 # Rewind the head to "$onto"; this saves our current head in ORIG_HEAD.
 echo "First, rewinding head to replay your work on top of it..."
 git-reset --hard "$onto"
-- 
1.5.3.4.502.g37c97
