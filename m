From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH v2 RFC] rebase-i-p: fix 'no squashing merges' tripping up non-merges
Date: Wed,  8 Oct 2008 01:41:54 -0500
Message-ID: <0d4d2cf9388866fe033f3545790fba6062fb1e1e.1223445353.git.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
 <e5ababa1de420b6460fd856679990c9dd2caf1d1.1223445353.git.stephen@exigencecorp.com>
 <e1cac64070f53f4f217a3b8e8c0f855f23691725.1223445353.git.stephen@exigencecorp.com>
 <90b5c351699999b5b4e4aa33475993661c26ee4c.1223445353.git.stephen@exigencecorp.com>
Cc: spearce@spearce.org, Stephen Haberman <stephen@exigencecorp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 08:44:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnSlw-0006wy-I1
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 08:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630AbYJHGmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 02:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbYJHGmM
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 02:42:12 -0400
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:32776 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbYJHGmD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 02:42:03 -0400
Received: from relay3.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 69881253461;
	Wed,  8 Oct 2008 02:42:02 -0400 (EDT)
Received: by relay3.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id D18A2253018;
	Wed,  8 Oct 2008 02:42:01 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <90b5c351699999b5b4e4aa33475993661c26ee4c.1223445353.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1223445353.git.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97772>

Also only check out the first parent if this commit if not a squash--if it is a
squash, we want to explicitly ignore the parent and leave the wc as is, as
cherry-pick will apply the squash on top of it.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-rebase--interactive.sh |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8af425d..0464bfb 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -198,15 +198,19 @@ pick_one_preserving_merges () {
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
