From: Tom Clarke <tom@u2i.com>
Subject: [PATCH] Adding rebase merge strategy
Date: Fri, 28 Sep 2007 18:15:21 +0200
Message-ID: <11909961212172-git-send-email-tom@u2i.com>
Cc: git@vger.kernel.org, Tom Clarke <tom@u2i.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 28 18:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbIyH-0005tS-9E
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 18:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbXI1Qpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 12:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbXI1Qpf
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 12:45:35 -0400
Received: from web.u2i.com ([72.32.63.146]:50714 "EHLO smtp.u2i.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751904AbXI1Qpe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 12:45:34 -0400
X-Greylist: delayed 1805 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Sep 2007 12:45:34 EDT
Received: from localhost.localdomain (dub130.internetdsl.tpnet.pl [83.19.213.130])
	by smtp.u2i.com (Postfix) with ESMTP id D1F1328E43;
	Fri, 28 Sep 2007 11:15:27 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.rc7.3.g850f-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59408>

In addition to adding git-merge-rebase.sh, git-merge.sh is modified
to handle the rebase strategy specially and avoids running update-ref
as rebase won't generate a merge commit.

Signed-off-by: Tom Clarke <tom@u2i.com>
---

Re-submitting this patch as we were in a pre-release freeze last time I submitted

 .gitignore                         |    1 +
 Documentation/merge-strategies.txt |    6 ++++++
 Makefile                           |    2 +-
 git-merge-rebase.sh                |   34 ++++++++++++++++++++++++++++++++++
 git-merge.sh                       |   14 +++++++++++---
 t/t3031-merge-rebase.sh            |   34 ++++++++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+), 4 deletions(-)
 create mode 100755 git-merge-rebase.sh
 create mode 100755 t/t3031-merge-rebase.sh

diff --git a/.gitignore b/.gitignore
index e0b91be..fe5cdc4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -73,6 +73,7 @@ git-merge-tree
 git-merge-octopus
 git-merge-one-file
 git-merge-ours
+git-merge-rebase
 git-merge-recursive
 git-merge-resolve
 git-merge-stupid
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 7df0266..dff1909 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -33,3 +33,9 @@ ours::
 	merge is always the current branch head.  It is meant to
 	be used to supersede old development history of side
 	branches.
+
+rebase::
+	This rebases the current branch based on a single head.
+	Commits are rewritten as with git-rebase. This doesn't
+	produce a merge. The procedure for dealing with conflicts 
+	is the same as with git-rebase.
diff --git a/Makefile b/Makefile
index 8db4dbe..e6d3812 100644
--- a/Makefile
+++ b/Makefile
@@ -215,7 +215,7 @@ SCRIPT_SH = \
 	git-sh-setup.sh \
 	git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
-	git-merge-resolve.sh git-merge-ours.sh \
+	git-merge-resolve.sh git-merge-ours.sh git-merge-rebase.sh \
 	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
 	git-filter-branch.sh \
 	git-stash.sh
diff --git a/git-merge-rebase.sh b/git-merge-rebase.sh
new file mode 100755
index 0000000..fc07331
--- /dev/null
+++ b/git-merge-rebase.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Linus Torvalds
+# Copyright (c) 2007 Tom Clarke
+#
+# Resolve two trees with rebase
+
+# The first parameters up to -- are merge bases; the rest are heads.
+bases= head= remotes= sep_seen=
+for arg
+do
+	case ",$sep_seen,$head,$arg," in
+	*,--,)
+		sep_seen=yes
+		;;
+	,yes,,*)
+		head=$arg
+		;;
+	,yes,*)
+		remotes="$remotes$arg "
+		;;
+	*)
+		bases="$bases$arg "
+		;;
+	esac
+done
+
+# Give up if we are given two or more remotes -- not handling octopus.
+case "$remotes" in
+?*' '?*)
+	exit 2 ;;
+esac
+
+git rebase $remotes || exit 2
diff --git a/git-merge.sh b/git-merge.sh
index 6c513dc..ea3cc16 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -16,11 +16,12 @@ test -z "$(git ls-files -u)" ||
 LF='
 '
 
-all_strategies='recur recursive octopus resolve stupid ours subtree'
+all_strategies='recur recursive octopus resolve stupid ours subtree rebase'
 default_twohead_strategies='recursive'
 default_octopus_strategies='octopus'
 no_fast_forward_strategies='subtree ours'
-no_trivial_strategies='recursive recur subtree ours'
+no_trivial_strategies='recursive recur subtree ours rebase'
+no_update_ref='rebase'
 use_strategies=
 
 allow_fast_forward=t
@@ -81,11 +82,18 @@ finish () {
 			echo "No merge message -- not updating HEAD"
 			;;
 		*)
-			git update-ref -m "$rlogm" HEAD "$1" "$head" || exit 1
+			case " $wt_strategy " in
+			*" $no_update_ref "*)
+				;;
+			*)
+				git update-ref -m "$rlogm" HEAD "$1" "$head" || exit 1
+				;;
+			esac
 			;;
 		esac
 		;;
 	esac
+
 	case "$1" in
 	'')
 		;;
diff --git a/t/t3031-merge-rebase.sh b/t/t3031-merge-rebase.sh
new file mode 100755
index 0000000..8e3641d
--- /dev/null
+++ b/t/t3031-merge-rebase.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='merge-rebase backend test'
+
+. ./test-lib.sh
+
+test_expect_success 'merging using rebase does not create merge commit' '
+	echo hello >a &&
+	git add a &&
+	test_tick && git commit -m initial &&
+
+	git checkout -b branch &&
+	echo hello >b &&
+	git add b &&
+	test_tick && git commit -m onbranch &&
+
+	git checkout master &&
+	echo update >a &&
+	git add a &&
+	test_tick && git commit -m update &&
+
+	git checkout branch &&
+	git merge -s rebase master >expect &&
+
+       	( git log --pretty=oneline ) >actual &&
+	(
+		echo "4db7a5a013e67aa623d1fd294e8d46e89b3ace8f onbranch"
+		echo "893371811dbd13e85c098b72d1ab42bcfd24c2db update"
+		echo "0e960b10429bf3f1e168ee2cc7d531ac7c622580 initial"
+	) >expected &&
+	git diff -w -u expected actual
+'
+
+test_done
-- 
1.5.3.rc7.3.g850f-dirty
