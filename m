From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 2/2] post-receive-email example hook: detect rewind-only updates and output sensible message
Date: Thu, 26 Apr 2007 22:36:24 +0100
Message-ID: <200704262236.24764.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 23:36:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhBdv-0004zT-HW
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 23:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbXDZVgo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 17:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbXDZVgo
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 17:36:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:64686 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbXDZVgn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 17:36:43 -0400
Received: by ug-out-1314.google.com with SMTP id 44so702519uga
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 14:36:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=ZzkgDTYuOa9qcLeUzkbva8FyZJCO6o4n7wSn4OyLCWKP0zrpOkjdJsQFjC1yZ8HK5L/gxTvtzMbQcaSOEWSfKoEEhyxzqOiyWN5brzDOgk1lzQM738yuc53nQbFAVunlqyW5pwjbdUEG2yPhUD9jQTV2j5DinQk/BQdqoadyUPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=nPZTtq/3zYypmztsndFoug7E5QPwKLTKOcCrEF1y4b8CUlWIK+Cq0g9e5+1JfBcuGcxDNHNsMzwPw++Qoq9Df6gBZL+bUb/G/1lX3GyIL0sEqtMe3vqzfcWLNm0rD9e17S2RabKNxOgzVzkH5u6ftmlyuV/5a/w03bHh3MQHNqk=
Received: by 10.66.255.7 with SMTP id c7mr2501687ugi.1177623401824;
        Thu, 26 Apr 2007 14:36:41 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 39sm4512255ugb.2007.04.26.14.36.37;
        Thu, 26 Apr 2007 14:36:40 -0700 (PDT)
X-TUID: 2033b586cb58a540
X-UID: 305
X-Length: 4703
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45665>

Sometimes a non-fast-forward update doesn't add new commits, it merely
removes old commits.  This patch adds support for detecting that and
outputting a more correct message.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 contrib/hooks/post-receive-email |   77 ++++++++++++++++++++++++++-----------
 1 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index edb30f6..e175b42 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -327,36 +327,67 @@ generate_update_branch_email()
 	if [ -z "$fastforward" ]; then
 		echo "      from  $oldrev ($oldrev_type)"
 	else
+		#  1. Existing revisions were removed.  In this case newrev is a
+		#     subset of oldrev - this is the reverse of a fast-forward,
+		#     a rewind
+		#  2. New revisions were added on top of an old revision, this is
+		#     a rewind and addition.
+
+		# (1) certainly happened, (2) possibly.  When (2) hasn't happened,
+		# we set a flag to indicate that no log printout is required.
+
 		echo ""
-		echo "This update added new revisions after undoing old revisions.  That is to"
-		echo "say, the old revision is not a strict subset of the new revision.  This"
-		echo "situation occurs when you --force push a change and generate a"
-		echo "repository containing something like this:"
-		echo ""
-		echo " * -- * -- B -- O -- O -- O ($oldrev)"
-		echo "            \\"
-		echo "             N -- N -- N ($newrev)"
-		echo ""
-		echo "When this happens we assume that you've already had alert emails for all"
-		echo "of the O revisions, and so we here report only the revisions in the N"
-		echo "branch from the common base, B."
+
+		# Find the common ancestor of the old and new revisions and compare
+		# it with newrev
+		baserev=$(git merge-base $oldrev $newrev)
+		rewind_only=""
+		if [ "$baserev" = "$newrev" ]; then
+			echo "This update discarded existing revisions and left the branch pointing at"
+			echo "a previous point in the repository history."
+			echo ""
+			echo " * -- * -- N ($newrev)"
+			echo "            \\"
+			echo "             O -- O -- O ($oldrev)"
+			echo ""
+			echo "The removed revisions are not necessarilly gone - if another reference"
+			echo "still refers to them they will stay in the repository."
+			rewind_only=1
+		else
+			echo "This update added new revisions after undoing existing revisions.  That is"
+			echo "to say, the old revision is not a strict subset of the new revision.  This"
+			echo "situation occurs when you --force push a change and generate a repository"
+			echo "containing something like this:"
+			echo ""
+			echo " * -- * -- B -- O -- O -- O ($oldrev)"
+			echo "            \\"
+			echo "             N -- N -- N ($newrev)"
+			echo ""
+			echo "When this happens we assume that you've already had alert emails for all"
+			echo "of the O revisions, and so we here report only the revisions in the N"
+			echo "branch from the common base, B."
+		fi
 	fi
 
 	echo ""
-	echo "Those revisions listed above that are new to this repository have"
-	echo "not appeared on any other notification email; so we list those"
-	echo "revisions in full, below."
+	if [ -z "$rewind_only" ]; then
+		echo "Those revisions listed above that are new to this repository have"
+		echo "not appeared on any other notification email; so we list those"
+		echo "revisions in full, below."
 
-	echo ""
-	echo $LOGBEGIN
-	git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
-	git rev-list --pretty --stdin $oldrev..$newrev
+		echo ""
+		echo $LOGBEGIN
+		git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
+		git rev-list --pretty --stdin $oldrev..$newrev
 
-	# XXX: Need a way of detecting whether git rev-list actually outputted
-	# anything, so that we can issue a "no new revisions added by this
-	# update" message
+		# XXX: Need a way of detecting whether git rev-list actually outputted
+		# anything, so that we can issue a "no new revisions added by this
+		# update" message
 
-	echo $LOGEND
+		echo $LOGEND
+	else
+		echo "No new revisions were added by this update."
+	fi
 
 	# The diffstat is shown from the old revision to the new revision.  This
 	# is to show the truth of what happened in this change.  There's no point
-- 
1.5.2.rc0.704.gfe85
