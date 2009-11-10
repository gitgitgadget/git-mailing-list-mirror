From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 2/2] filter-branch: nearest-ancestor rewriting outside subdir filter
Date: Tue, 10 Nov 2009 22:04:51 +0100
Message-ID: <89074b84e9b4f8c0c064cb39693d936f2e931786.1257885121.git.trast@student.ethz.ch>
References: <0280836a32983c848bbb0e3b441be256d3c8f4fa.1257885121.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 22:06:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7xug-0008LQ-Ik
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 22:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169AbZKJVF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 16:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758165AbZKJVF4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 16:05:56 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:38572 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758139AbZKJVFx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 16:05:53 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 10 Nov
 2009 22:05:57 +0100
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 10 Nov
 2009 22:05:36 +0100
X-Mailer: git-send-email 1.6.5.2.365.ge9237
In-Reply-To: <0280836a32983c848bbb0e3b441be256d3c8f4fa.1257885121.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132598>

Since a0e4639 (filter-branch: fix ref rewriting with
--subdirectory-filter, 2008-08-12) git-filter-branch has done
nearest-ancestor rewriting when using a --subdirectory-filter.

However, that rewriting strategy is also a useful building block in
other tasks.  For example, if you want to split out a subset of files
from your history, you would typically call

  git filter-branch -- <refs> -- <files>

But this fails for all refs that do not point directly to a commit
that affects <files>, because their referenced commit will not be
rewritten and the ref remains untouched.

The code was already there for the --subdirectory-filter case, so just
introduce an option that enables it independently.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Compared to v3 this only changes the comment, as suggested by Johannes
Sixt.


 Documentation/git-filter-branch.txt |   13 ++++++++++++-
 git-filter-branch.sh                |   18 +++++++++++++-----
 t/t7003-filter-branch.sh            |   18 ++++++++++++++++++
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 2b40bab..394a77a 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -159,7 +159,18 @@ to other tags will be rewritten to point to the underlying commit.
 --subdirectory-filter <directory>::
 	Only look at the history which touches the given subdirectory.
 	The result will contain that directory (and only that) as its
-	project root.
+	project root.  Implies --remap-to-ancestor.
+
+--remap-to-ancestor::
+	Rewrite refs to the nearest rewritten ancestor instead of
+	ignoring them.
++
+Normally, positive refs on the command line are only changed if the
+commit they point to was rewritten.  However, you can limit the extent
+of this rewriting by using linkgit:rev-list[1] arguments, e.g., path
+limiters.  Refs pointing to such excluded commits would then normally
+be ignored.  With this option, they are instead rewritten to point at
+the nearest ancestor that was not excluded.
 
 --prune-empty::
 	Some kind of filters will generate empty commits, that left the tree
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 96b2182..a5a0352 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -125,6 +125,7 @@ filter_subdir=
 orig_namespace=refs/original/
 force=
 prune_empty=
+remap_to_ancestor=
 while :
 do
 	case "$1" in
@@ -137,6 +138,11 @@ do
 		force=t
 		continue
 		;;
+	--remap-to-ancestor)
+		shift
+		remap_to_ancestor=t
+		continue
+		;;
 	--prune-empty)
 		shift
 		prune_empty=t
@@ -182,6 +188,7 @@ do
 		;;
 	--subdirectory-filter)
 		filter_subdir="$OPTARG"
+		remap_to_ancestor=t
 		;;
 	--original)
 		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
@@ -354,12 +361,13 @@ while read commit parents; do
 			die "could not write rewritten commit"
 done <../revs
 
-# In case of a subdirectory filter, it is possible that a specified head
-# is not in the set of rewritten commits, because it was pruned by the
-# revision walker.  Fix it by mapping these heads to the unique nearest
-# ancestor that survived the pruning.
+# If we are filtering for paths, as in the case of a subdirectory
+# filter, it is possible that a specified head is not in the set of
+# rewritten commits, because it was pruned by the revision walker.
+# Ancestor remapping fixes this by mapping these heads to the unique
+# nearest ancestor that survived the pruning.
 
-if test "$filter_subdir"
+if test "$remap_to_ancestor" = t
 then
 	while read ref
 	do
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 329c851..9503875 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -288,4 +288,22 @@ test_expect_success 'Prune empty commits' '
 	test_cmp expect actual
 '
 
+test_expect_success '--remap-to-ancestor with filename filters' '
+	git checkout master &&
+	git reset --hard A &&
+	test_commit add-foo foo 1 &&
+	git branch moved-foo &&
+	test_commit add-bar bar a &&
+	git branch invariant &&
+	orig_invariant=$(git rev-parse invariant) &&
+	git branch moved-bar &&
+	test_commit change-foo foo 2 &&
+	git filter-branch -f --remap-to-ancestor \
+		moved-foo moved-bar A..master \
+		-- -- foo &&
+	test $(git rev-parse moved-foo) = $(git rev-parse moved-bar) &&
+	test $(git rev-parse moved-foo) = $(git rev-parse master^) &&
+	test $orig_invariant = $(git rev-parse invariant)
+'
+
 test_done
-- 
1.6.5.2.365.ge9237
