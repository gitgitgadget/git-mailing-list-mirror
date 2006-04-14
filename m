From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] cg-admin-rewritehist: Seed the commit map with the parents specified with -r.
Date: Fri, 14 Apr 2006 20:54:35 +0200
Message-ID: <200604142054.36501.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Apr 14 20:55:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUTRa-0001le-Sm
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 20:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWDNSy4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 14:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWDNSy4
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 14:54:56 -0400
Received: from mail.nextra.at ([195.170.70.100]:44071 "EHLO mail.nextra.at")
	by vger.kernel.org with ESMTP id S1751410AbWDNSyz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 14:54:55 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by mail.nextra.at (8.13.6/8.13.6) with ESMTP id k3EIsd53009919
	for <git@vger.kernel.org>; Fri, 14 Apr 2006 20:54:43 +0200 (MEST)
X-Abuse-Info: Please report abuse to abuse@eunet.co.at, see http://www.eunet.at/support/service
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 32FE449CA1
	for <git@vger.kernel.org>; Fri, 14 Apr 2006 20:54:37 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18695>

When the first commit is manufactured, its parents are looked up in the
commit map. However, without this patch the map is always empty at that time.
If the entire history is rewritten, this is no problem because the first
commit does not have any parents anyway. However, if -r is used to constrain
rewriting to only part of the history, this first commit is manufactured
incorrectly without parents because 'cat' fails.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>

---

 cg-admin-rewritehist |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

ec09427d1fb4097c15fd6df4f07049a536bb7d2c
diff --git a/cg-admin-rewritehist b/cg-admin-rewritehist
index 9c49d80..b72c641 100755
--- a/cg-admin-rewritehist
+++ b/cg-admin-rewritehist
@@ -138,6 +138,7 @@ _git_requires_root=1
 
 tempdir=.git-rewrite
 startrev=
+startrevparents=
 filter_env=
 filter_tree=
 filter_index=
@@ -149,6 +150,7 @@ while optparse; do
 		tempdir="$OPTARG"
 	elif optparse -r=; then
 		startrev="^$OPTARG $OPTARG $startrev"
+		startrevparents="$OPTARG $startrevparents"
 	elif optparse --env-filter=; then
 		filter_env="$OPTARG"
 	elif optparse --tree-filter=; then
@@ -182,6 +184,11 @@ ret=0
 
 
 mkdir ../map # map old->new commit ids for rewriting parents
+
+# seed with identity mappings for the parents where we start off
+for commit in $startrevparents; do
+	echo $commit > ../map/$commit
+done
 
 git-rev-list --topo-order HEAD $startrev | tac >../revs
 commits=$(cat ../revs | wc -l)
-- 
1.3.0.rc2
