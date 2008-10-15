From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] rebase-i-p: fix 'no squashing merges' tripping up non-merges
Date: Wed, 15 Oct 2008 02:44:37 -0500
Message-ID: <ab80b829ebfa597dc4aaac6e49f9907e505adf59.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
 <79b3f186dc599ebb5e251d5c0ca93c233263974c.1224055978.git.stephen@exigencecorp.com>
 <ef8c08551dca1ddfea0017fd4026ac9ae60fbfec.1224055978.git.stephen@exigencecorp.com>
 <759654ef1f1781cd2b102e21c6f972b065560398.1224055978.git.stephen@exigencecorp.com>
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 15 09:46:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq151-00012V-IL
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbYJOHow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbYJOHov
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:44:51 -0400
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:49879 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYJOHor (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:44:47 -0400
Received: from relay6.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id B1DB01E06B3;
	Wed, 15 Oct 2008 03:44:46 -0400 (EDT)
Received: by relay6.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 3212E1E0660;
	Wed, 15 Oct 2008 03:44:46 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <759654ef1f1781cd2b102e21c6f972b065560398.1224055978.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98250>

Also only check out the first parent if this commit if not a squash--if it is a
squash, we want to explicitly ignore the parent and leave the wc as is, as
cherry-pick will apply the squash on top of it.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-rebase--interactive.sh |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 23cf7a5..274251f 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -219,15 +219,19 @@ pick_one_preserving_merges () {
 			die "Cannot fast forward to $sha1"
 		;;
 	f)
-		test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
-
 		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
-		# detach HEAD to current parent
-		output git checkout $first_parent 2> /dev/null ||
-			die "Cannot move HEAD to $first_parent"
+
+		if [ "$1" != "-n" ]
+		then
+			# detach HEAD to current parent
+			output git checkout $first_parent 2> /dev/null ||
+				die "Cannot move HEAD to $first_parent"
+		fi
 
 		case "$new_parents" in
 		' '*' '*)
+			test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
+
 			# redo merge
 			author_script=$(get_author_ident_from_commit $sha1)
 			eval "$author_script"
-- 
1.6.0.2
