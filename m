From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] filter-branch: also don't fail in map() if a commit cannot be mapped
Date: Wed,  6 Jun 2007 17:36:31 +0200
Message-ID: <1181144191777-git-send-email-johannes.sixt@telecom.at>
References: <Pine.LNX.4.64.0706051537360.4046@racer.site>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org, johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Wed Jun 06 17:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvxYt-0003JZ-8q
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 17:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbXFFPgg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 11:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765728AbXFFPgg
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 11:36:36 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:51468 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765455AbXFFPgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 11:36:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1HvxYn-0001Oo-LM; Wed, 06 Jun 2007 17:36:33 +0200
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5C65C54D; Wed,  6 Jun 2007 17:36:33 +0200 (CEST)
Received: by srv.linz.eudaptics (Postfix, from userid 503)
	id DDBE1103; Wed,  6 Jun 2007 17:36:32 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1.120.gd732
In-Reply-To: <Pine.LNX.4.64.0706051537360.4046@racer.site>
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49294>

The map() function can be used by filters to map a commit id to its
rewritten id. Such a mapping may not exist, in which case the identity
mapping is used (the commit is returned unchanged).

In the rewrite loop, this mapping is also needed, but was done
explicitly in the same way. Use the map() function instead.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-filter-branch.sh |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index fbbb044..9e12a6c 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -189,7 +189,8 @@ USAGE="git-filter-branch [-d TEMPDIR] [-r STARTREV]... [-k KEEPREV]... [-s SRCBR
 
 map()
 {
-	[ -r "$workdir/../map/$1" ] || return 1
+	# if it was not rewritten, take the original
+	[ -r "$workdir/../map/$1" ] || echo "$1"
 	cat "$workdir/../map/$1"
 }
 
@@ -362,14 +363,9 @@ while read commit; do
 
 	parentstr=
 	for parent in $(get_parents $commit); do
-		if [ -r "../map/$parent" ]; then
-			for reparent in $(cat "../map/$parent"); do
-				parentstr="$parentstr -p $reparent"
-			done
-		else
-			# if it was not rewritten, take the original
-			parentstr="$parentstr -p $parent"
-		fi
+		for reparent in $(map "$parent"); do
+			parentstr="$parentstr -p $reparent"
+		done
 	done
 	if [ "$filter_parent" ]; then
 		parentstr="$(echo "$parentstr" | eval "$filter_parent")"
-- 
1.5.2.1.120.gd732
