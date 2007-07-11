From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-merge: run commit hooks when making merge commits
Date: Wed, 11 Jul 2007 22:32:00 +1200
Message-ID: <11841499201242-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 12:32:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ZUZ-0001TK-OK
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 12:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759647AbXGKKcG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 06:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759485AbXGKKcF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 06:32:05 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:40371 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759129AbXGKKcE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 06:32:04 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I8ZUG-0006fR-7f; Wed, 11 Jul 2007 22:32:00 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 3165A5CF6F; Wed, 11 Jul 2007 22:32:00 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52148>

git-merge.sh was not running the commit hooks, so run them in the two
places where we go to commit.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
   Not sure if it should call these or some specialist hooks, like
   git-am does.

 git-merge.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 981d69d..ef4f51b 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -117,6 +117,29 @@ merge_name () {
 	fi
 }
 
+call_pre_hooks () {
+	message="$1"
+	if test -x "$GIT_DIR"/hooks/pre-commit
+	then
+		"$GIT_DIR"/hooks/pre-commit || exit 1
+	fi
+	if test -x "$GIT_DIR"/hooks/commit-msg
+	then
+		printf '%s\n' "$message" > "$GIT_DIR"/MERGE_MSG
+		"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/MERGE_MSG || exit 1
+		cat "$GIT_DIR"/MERGE_MSG
+	else
+		echo "$message"
+	fi
+}
+
+call_post_hook () {
+	if test -x "$GIT_DIR"/hooks/post-commit
+	then
+		"$GIT_DIR"/hooks/post-commit
+	fi
+}
+
 case "$#" in 0) usage ;; esac
 
 have_message=
@@ -334,11 +357,13 @@ f,*)
 		   result_tree=$(git-write-tree)
 		then
 			echo "Wonderful."
+			merge_msg=$(call_pre_hooks "$merge_msg")
 			result_commit=$(
 				printf '%s\n' "$merge_msg" |
 				git-commit-tree $result_tree -p HEAD -p "$1"
 			) || exit
 			finish "$result_commit" "In-index merge"
+			call_post_hook
 			dropsave
 			exit 0
 		fi
@@ -440,8 +465,10 @@ done
 if test '' != "$result_tree"
 then
     parents=$(git-show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
+    merge_msg=$(call_pre_hooks "$merge_msg")
     result_commit=$(printf '%s\n' "$merge_msg" | git-commit-tree $result_tree $parents) || exit
     finish "$result_commit" "Merge made by $wt_strategy."
+    call_post_hook
     dropsave
     exit 0
 fi
-- 
1.5.2.1.1131.g3b90
