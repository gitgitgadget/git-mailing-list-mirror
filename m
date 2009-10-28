From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 2/2] filter-branch: nearest-ancestor rewriting outside subdir filter
Date: Wed, 28 Oct 2009 23:59:17 +0100
Message-ID: <a11809cee976bb42102dbd9b2afb06b9e5b587bf.1256770377.git.trast@student.ethz.ch>
References: <6e01558f719f4bfcd12f3c6dc5657790e86c874d.1256770377.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 00:00:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3HVI-00050L-In
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 00:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbZJ1XAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 19:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbZJ1XAT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 19:00:19 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:40134 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbZJ1XAR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 19:00:17 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 29 Oct
 2009 00:00:22 +0100
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 28 Oct
 2009 23:59:58 +0100
X-Mailer: git-send-email 1.6.5.1.161.g3b9c0
In-Reply-To: <6e01558f719f4bfcd12f3c6dc5657790e86c874d.1256770377.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131508>

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

Same as v2.

 Documentation/git-filter-branch.txt |   13 ++++++++++++-
 git-filter-branch.sh                |    9 ++++++++-
 t/t7003-filter-branch.sh            |   18 ++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

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
index da23b99..ad2bc6f 100755
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
@@ -358,7 +365,7 @@ done <../revs
 # revision walker.  Fix it by mapping these heads to the unique nearest
 # ancestor that survived the pruning.
 
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
1.6.5.1.161.g3b9c0
