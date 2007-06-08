From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 2/2] filter-branch: subdirectory filter needs --full-history
Date: Fri, 8 Jun 2007 23:28:50 +0200
Message-ID: <200706082328.50923.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 23:28:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwm0s-0002jb-NW
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 23:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbXFHV2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 17:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbXFHV2x
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 17:28:53 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:45818 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbXFHV2w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 17:28:52 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 51BAD10A955;
	Fri,  8 Jun 2007 23:28:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1CAC456E1C;
	Fri,  8 Jun 2007 23:28:51 +0200 (CEST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49503>

When two branches are merged that modify a subdirectory (possibly in
different intermediate steps) such that both end up identical, then
rev-list chooses only one branch. But when we filter history, we want to
keep both branches. Therefore, we must use --full-history.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-filter-branch.sh     |    2 +-
 t/t7003-filter-branch.sh |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 4ef4570..2e4ccec 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -326,7 +326,7 @@ case "$filter_subdir" in
 	;;
 *)
 	git-rev-list --reverse --topo-order --default HEAD \
-		--parents "$@" -- "$filter_subdir"
+		--parents --full-history "$@" -- "$filter_subdir"
 esac > ../revs
 commits=$(cat ../revs | wc -l | tr -d " ")
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 292b837..0fabe49 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -78,4 +78,25 @@ test_expect_success 'subdirectory filter result looks 
okay' '
 	! git show sub:subdir
 '
 
+test_expect_success 'setup and filter history that requires --full-history' '
+	git checkout master &&
+	mkdir subdir &&
+	echo A > subdir/new &&
+	git add subdir/new &&
+	test_tick &&
+	git commit -m "subdir on master" subdir/new &&
+	git rm a &&
+	test_tick &&
+	git commit -m "again subdir on master" &&
+	git merge branch &&
+	git-filter-branch --subdirectory-filter subdir sub-master
+'
+
+test_expect_success 'subdirectory filter result looks okay' '
+	test 3 = $(git-rev-list -1 --parents sub-master | wc -w) &&
+	git show sub-master^:new &&
+	git show sub-master^2:new &&
+	! git show sub:subdir
+'
+
 test_done
-- 
1.5.2
