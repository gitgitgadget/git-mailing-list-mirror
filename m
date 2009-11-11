From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH v5 2/2] filter-branch: nearest-ancestor rewriting outside
 subdir filter
Date: Wed, 11 Nov 2009 09:55:58 +0100
Message-ID: <4AFA7C1E.1050606@viscovery.net>
References: <4AE945D0.5030403@viscovery.net> <0280836a32983c848bbb0e3b441be256d3c8f4fa.1257885121.git.trast@student.ethz.ch> <4AFA7624.5040400@viscovery.net> <4AFA7B9A.4090005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Nov 11 09:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N88zs-0004aj-EV
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 09:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbZKKI4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 03:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbZKKI4A
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 03:56:00 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64677 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbZKKI4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 03:56:00 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N88ze-00011b-Uj; Wed, 11 Nov 2009 09:56:05 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BD08C6D9; Wed, 11 Nov 2009 09:55:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AFA7B9A.4090005@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132625>

From: Thomas Rast <trast@student.ethz.ch>
Date: Tue, 10 Nov 2009 22:04:51 +0100

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
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---

Only resent for Junio's convenience. It is identical to your v4, but
with my SOB added.

-- Hannes

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
index ed3db7d..6b8b6a4 100755
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
1.6.5.rc2.47.g49402
