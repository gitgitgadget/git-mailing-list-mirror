X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-merge: preserve and merge local changes when doing fast forward
Date: Wed, 29 Nov 2006 19:02:33 -0800
Message-ID: <7v1wnlmyba.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 03:02:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32699>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpcCO-0002FK-JM for gcvg-git@gmane.org; Thu, 30 Nov
 2006 04:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936176AbWK3DCf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 22:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936174AbWK3DCf
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 22:02:35 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:56479 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S936176AbWK3DCe
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 22:02:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130030234.GVYW9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Wed, 29
 Nov 2006 22:02:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id sr211V0051kojtg0000000; Wed, 29 Nov 2006
 22:02:01 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The idea and the logic are identical to what "checkout -m" does
when switching the branches.  Instead of refusing the two-way
merge, perform the three-way merge between the old head, the
working tree and the new head, and leave the (potentially
conflicted) merge result in the working tree.

If this turns out to be a sane thing to do, we probably should
make the common logic between "checkout -m" and this into a
built-in command.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I am not sure if this is worth doing in general; it can leave
   a huge mess if the conflict with the merge and the local
   change is too extensive and does not give a good way to
   recover from it, and that is why we require an explicit "-m"
   to "git checkout" for this behaviour.  Perhaps we would want
   a new option to git-merge to allow preserving the local
   changes, but the obvious candidate -m is taken for something
   else per recent popular request X-<...

 git-merge.sh |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 75af10d..324991f 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -91,6 +91,46 @@ finish () {
 	esac
 }
 
+merge_local_changes () {
+	merge_error=$(git-read-tree -m -u $1 $2 2>&1) || (
+		# Match the index to the working tree, and do a three-way.
+		git diff-files --name-only |
+		git update-index --remove --stdin &&
+		work=`git write-tree` &&
+		git read-tree --reset -u $2 &&
+		git read-tree -m -u --aggressive $1 $2 $work || exit
+
+		echo >&2 "Carrying local changes forward."
+		if result=`git write-tree 2>/dev/null`
+		then
+			echo >&2 "Trivially automerged."
+		else
+			git merge-index -o git-merge-one-file -a
+		fi
+
+		# Do not register the cleanly merged paths in the index
+		# yet; this is not a real merge before committing, but
+		# just carrying the working tree changes along.
+		unmerged=`git ls-files -u`
+		git read-tree --reset $2
+		case "$unmerged" in
+		'')	;;
+		*)
+			(
+				z40=0000000000000000000000000000000000000000
+				echo "$unmerged" |
+				sed -e 's/^[0-7]* [0-9a-f]* /'"0 $z40 /"
+				echo "$unmerged"
+			) | git update-index --index-info
+
+			echo >&2 "Conflicts in locally modified files:"
+			git diff --name-only --diff-filter=U >&2
+			;;
+		esac
+		exit 0
+	)
+}
+
 case "$#" in 0) usage ;; esac
 
 rloga= have_message=
@@ -264,7 +304,7 @@ f,*)
 	echo "Updating $(git-rev-parse --short $head)..$(git-rev-parse --short $1)"
 	git-update-index --refresh 2>/dev/null
 	new_head=$(git-rev-parse --verify "$1^0") &&
-	git-read-tree -u -v -m $head "$new_head" &&
+	merge_local_changes $head $new_head &&
 	finish "$new_head" "Fast forward"
 	dropsave
 	exit 0
-- 
1.4.4.1.gc419

