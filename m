From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] cg-admin-rewritehist: Seed the commit map with the parents specified with -r.
Date: Sat, 29 Apr 2006 23:45:38 +0200 (CEST)
Message-ID: <20060429214538.4E2D54A54D@dx.sixt.local>
X-From: git-owner@vger.kernel.org Sat Apr 29 23:45:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZxG5-0003gl-Dy
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 23:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWD2Vpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 17:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWD2Vpm
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 17:45:42 -0400
Received: from mail.nextra.at ([195.170.70.86]:56717 "EHLO mail.nextra.at")
	by vger.kernel.org with ESMTP id S1750813AbWD2Vpm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 17:45:42 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by mail.nextra.at (8.13.6/8.13.6) with ESMTP id k3TLjdtP010239
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 23:45:40 +0200 (MEST)
X-Abuse-Info: Please report abuse to abuse@eunet.co.at, see http://www.eunet.at/support/service
Received: by dx.sixt.local (Postfix, from userid 1000)
	id 4E2D54A54D; Sat, 29 Apr 2006 23:45:38 +0200 (CEST)
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19320>

When the first commit is manufactured, its parents are looked up in the
commit map. However, without this patch the map is always empty at that time.
If the entire history is rewritten, this is no problem because the first
commit does not have any parents anyway. However, if -r is used to constrain
rewriting to only part of the history, this first commit is manufactured
incorrectly without parents because 'cat' fails.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>

---

 cg-admin-rewritehist |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

977fc81815877a1e72040355b221fe8d62593eb7
diff --git a/cg-admin-rewritehist b/cg-admin-rewritehist
index 9fa4c2a..7dd83cf 100755
--- a/cg-admin-rewritehist
+++ b/cg-admin-rewritehist
@@ -141,6 +141,7 @@ _git_requires_root=1
 
 tempdir=.git-rewrite
 startrev=
+startrevparents=
 filter_env=
 filter_tree=
 filter_index=
@@ -152,6 +153,7 @@ while optparse; do
 		tempdir="$OPTARG"
 	elif optparse -r=; then
 		startrev="^$OPTARG^ $OPTARG $startrev"
+		startrevparents="$OPTARG^ $startrevparents"
 	elif optparse --env-filter=; then
 		filter_env="$OPTARG"
 	elif optparse --tree-filter=; then
@@ -186,6 +188,12 @@ ret=0
 
 mkdir ../map # map old->new commit ids for rewriting parents
 
+# seed with identity mappings for the parents where we start off
+for commit in $startrevparents; do
+	commit="$(git-rev-parse $commit)"
+	echo $commit > ../map/$commit
+done
+
 git-rev-list --topo-order HEAD $startrev | tac >../revs
 commits=$(cat ../revs | wc -l)
 
-- 
1.3.1.gaa6b
