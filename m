From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] filter-branch: fix ancestor discovery for --subdirectory-filter
Date: Fri,  8 Aug 2008 16:16:02 +0200
Message-ID: <1218204962-17900-1-git-send-email-trast@student.ethz.ch>
References: <200808081614.44422.trast@student.ethz.ch>
Cc: gitster@pobox.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 16:17:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRSmV-0003sL-Ol
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 16:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbYHHOP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 10:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbYHHOP5
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 10:15:57 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:42988 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbYHHOP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 10:15:56 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 16:15:54 +0200
Received: from localhost.localdomain ([129.132.149.43]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 16:15:54 +0200
X-Mailer: git-send-email 1.6.0.rc2.22.g7d28.dirty
In-Reply-To: <200808081614.44422.trast@student.ethz.ch>
X-OriginalArrivalTime: 08 Aug 2008 14:15:54.0629 (UTC) FILETIME=[45164350:01C8F961]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91668>

The previous code failed on any refs that are (pre-rewrite) ancestors
of commits marked for rewriting.  This means that in a situation

   A -- B(topic) -- C(master)

where B is dropped by --subdirectory-filter pruning, the 'topic' is
not moved up to A as intended, but left unrewritten.

Fix this by using a more stupid approach: we let 'rev-list -1' figure
out a nearby ancestor, which handles the pruning automatically.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I guarded it with a $filter_subdir check to not cause any unintended
harm.  It might be useful in some border cases of rev-list arguments
given to filter-branch too, but I can't figure out a safe way to
handle that.

Either way, this fixes the problem.

- Thomas

 git-filter-branch.sh |   27 +++++++++++----------------
 1 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a324cf0..7924aa1 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -317,24 +317,19 @@ done <../revs
 
 # In case of a subdirectory filter, it is possible that a specified head
 # is not in the set of rewritten commits, because it was pruned by the
-# revision walker.  Fix it by mapping these heads to the next rewritten
-# ancestor(s), i.e. the boundaries in the set of rewritten commits.
+# revision walker.  Fix it by mapping these heads to a (random!) nearby
+# ancestor that survived the pruning.
 
-# NEEDSWORK: we should sort the unmapped refs topologically first
-while read ref
-do
-	sha1=$(git rev-parse "$ref"^0)
-	test -f "$workdir"/../map/$sha1 && continue
-	# Assign the boundarie(s) in the set of rewritten commits
-	# as the replacement commit(s).
-	# (This would look a bit nicer if --not --stdin worked.)
-	for p in $( (cd "$workdir"/../map; ls | sed "s/^/^/") |
-		git rev-list $ref --boundary --stdin |
-		sed -n "s/^-//p")
+if test "$filter_subdir"
+then
+	while read ref
 	do
-		map $p >> "$workdir"/../map/$sha1
-	done
-done < "$tempdir"/heads
+		sha1=$(git rev-parse "$ref"^0)
+		test -f "$workdir"/../map/$sha1 && continue
+		ancestor=$(git rev-list -1 $ref -- "$filter_subdir")
+		test "$ancestor" && echo $(map $ancestor) >> "$workdir"/../map/$sha1
+	done < "$tempdir"/heads
+fi
 
 # Finally update the refs
 
-- 
1.6.0.rc2.22.g7d28.dirty
