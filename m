From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH/RFC] filter-branch: support skipping of commits more easily
Date: Fri, 8 Jun 2007 00:59:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706080058160.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@postbox.com
X-From: git-owner@vger.kernel.org Fri Jun 08 02:02:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwRvY-0004FT-NB
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 02:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966470AbXFHACB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 20:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966465AbXFHACB
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 20:02:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:58952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966406AbXFHACA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 20:02:00 -0400
Received: (qmail invoked by alias); 08 Jun 2007 00:01:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 08 Jun 2007 02:01:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/P6Y3TW9/p9h6jUhhQBP8H8QKQP2iYa4We4NM2o
	thJOw6Fz4VGALn
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49416>


When commit-filter echoes just "skip", just skip that commit by mapping 
its object name to the same (possibly rewritten) object name(s) its 
parent(s) are mapped to.

IOW, given A-B-C, if commit-filter says "skip" upon B, the rewritten 
branch will look like this: A'-C'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Of course, if you think of "patchsets", this behaviour might
	be unexpected, since the children will still contain everything
	which was changed in the skipped revisions, and not changed in
	_them_.

 git-filter-branch.sh |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 9d61b7f..e6ed7b9 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -102,6 +102,9 @@
 #	multiple commit ids; in that case, all of them will be used
 #	as parents instead of the original commit in further commits.
 #
+#	For the common case, that this commit should be skipped, just
+#	output a single "skip".
+#
 # --tag-name-filter COMMAND:: The filter for rewriting tag names.
 #	If this filter is passed, it will be called for every tag ref
 #	that points to a rewritten object (or to a tag object which
@@ -321,7 +324,7 @@ test $commits -eq 0 && die "Found nothing to rewrite"
 i=0
 while read commit; do
 	i=$(($i+1))
-	printf "$commit ($i/$commits) "
+	printf "\rRewriting commits... ($i/$commits)"
 
 	git-read-tree -i -m $commit
 
@@ -358,8 +361,14 @@ while read commit; do
 
 	sed -e '1,/^$/d' <../commit | \
 		eval "$filter_msg" | \
-		sh -c "$filter_commit" git-commit-tree $(git-write-tree) $parentstr | \
-		tee ../map/$commit
+		sh -c "$filter_commit" \
+			git-commit-tree $(git-write-tree) $parentstr \
+		> ../map/$commit
+
+	test skip = "$(cat ../map/$commit)" &&
+		for parent in $(get_parents $commit); do
+			map "$parent"
+		done > ../map/$commit
 done <../revs
 
 src_head=$(tail -n 1 ../revs)
-- 
1.5.2.1.2689.gaf768-dirty
