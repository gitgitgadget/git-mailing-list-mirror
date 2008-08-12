From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/3] filter-branch: fix ref rewriting with --subdirectory-filter
Date: Tue, 12 Aug 2008 10:45:58 +0200
Message-ID: <2c31171ea3181f9dfe7c96a2af98e1a5bcf1358a.1218529494.git.trast@student.ethz.ch>
References: <cover.1218529494.git.trast@student.ethz.ch>
 <b6bda5e5028aea161e5d18e0c70c45d5a94dac82.1218529494.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 10:47:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSpXB-0002oq-7I
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 10:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbYHLIqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 04:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbYHLIqA
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 04:46:00 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:33951 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbYHLIp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 04:45:58 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 10:45:54 +0200
Received: from localhost.localdomain ([129.132.149.43]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 10:45:53 +0200
X-Mailer: git-send-email 1.6.0.rc2.30.gb6bda
In-Reply-To: <b6bda5e5028aea161e5d18e0c70c45d5a94dac82.1218529494.git.trast@student.ethz.ch>
In-Reply-To: <7vsktara5n.fsf@gitster.siamese.dyndns.org>
References: <7vsktara5n.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Aug 2008 08:45:53.0567 (UTC) FILETIME=[D462FAF0:01C8FC57]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92080>

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
 git-filter-branch.sh     |   27 +++++++++++----------------
 t/t7003-filter-branch.sh |    2 +-
 2 files changed, 12 insertions(+), 17 deletions(-)

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
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 4382baa..233254f 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -101,7 +101,7 @@ test_expect_success 'filter subdirectory only' '
 		refs/heads/sub refs/heads/sub-earlier
 '
 
-test_expect_failure 'subdirectory filter result looks okay' '
+test_expect_success 'subdirectory filter result looks okay' '
 	test 2 = $(git rev-list sub | wc -l) &&
 	git show sub:new &&
 	test_must_fail git show sub:subdir &&
-- 
1.6.0.rc2.30.gb6bda
