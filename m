From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] filter-branch: fix ref rewriting with --subdirectory-filter
Date: Fri,  8 Aug 2008 20:39:09 +0200
Message-ID: <1218220749-8469-1-git-send-email-trast@student.ethz.ch>
References: <200808082037.49918.trast@student.ethz.ch>
Cc: gitster@pobox.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 20:40:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRWsx-0006GX-2m
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 20:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758882AbYHHSjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 14:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759224AbYHHSjF
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 14:39:05 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:12192 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbYHHSjE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 14:39:04 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 20:39:01 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 20:39:01 +0200
X-Mailer: git-send-email 1.6.0.rc2.23.g1e07
In-Reply-To: <200808082037.49918.trast@student.ethz.ch>
X-OriginalArrivalTime: 08 Aug 2008 18:39:01.0659 (UTC) FILETIME=[06E3DEB0:01C8F986]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91706>

The previous ancestor discovery code failed on any refs that are
(pre-rewrite) ancestors of commits marked for rewriting.  This means
that in a situation

   A -- B(topic) -- C(master)

where B is dropped by --subdirectory-filter pruning, the 'topic' was
not moved up to A as intended, but left unrewritten because we asked
about 'git rev-list ^master topic', which does not return anything.

Instead, we use the straightforward

   git rev-list -1 $ref -- $filter_subdir

to find the right ancestor.  To justify this, note that the nearest
ancestor is unique: We use the output of

  git rev-list --parents -- $filter_subdir

to rewrite commits in the first pass, before any ref rewriting.  If B
is a non-merge commit, the only candidate is its parent.  If it is a
merge, there are two cases:

- All sides of the merge bring the same subdirectory contents.  Then
  rev-list already pruned away the merge in favour for just one of its
  parents, so there is only one candidate.

- Some merge sides, or the merge outcome, differ.  Then the merge is
  not pruned and can be rewritten directly.

So it is always safe to use rev-list -1.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Only comments and commit message changed since v1, to update the
justification.

 git-filter-branch.sh |   27 +++++++++++----------------
 1 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a324cf0..a140337 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -317,24 +317,19 @@ done <../revs
 
 # In case of a subdirectory filter, it is possible that a specified head
 # is not in the set of rewritten commits, because it was pruned by the
-# revision walker.  Fix it by mapping these heads to the next rewritten
-# ancestor(s), i.e. the boundaries in the set of rewritten commits.
+# revision walker.  Fix it by mapping these heads to the unique nearest
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
1.6.0.rc2.23.ge69de8
