From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH v2] filter-branch: also don't fail in map() if a commit cannot be mapped
Date: Wed, 6 Jun 2007 20:38:35 +0200
Message-ID: <200706062038.36093.johannes.sixt@telecom.at>
References: <Pine.LNX.4.64.0706051537360.4046@racer.site> <1181144191777-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0706061850220.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 20:38:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw0PA-0005g4-6K
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 20:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758122AbXFFSij (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 14:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758571AbXFFSii
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 14:38:38 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:53200 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758122AbXFFSii (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 14:38:38 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id A0E37BEEC7;
	Wed,  6 Jun 2007 20:38:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6888857CD7;
	Wed,  6 Jun 2007 20:38:36 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0706061850220.4046@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49304>

The map() function can be used by filters to map a commit id to its
rewritten id. Such a mapping may not exist, in which case the identity
mapping is used (the commit is returned unchanged).

In the rewrite loop, this mapping is also needed, but was done
explicitly in the same way. Use the map() function instead.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
On Wednesday 06 June 2007 19:50, Johannes Schindelin wrote:
> On Wed, 6 Jun 2007, Johannes Sixt wrote:
> > -	[ -r "$workdir/../map/$1" ] || return 1
> > +	# if it was not rewritten, take the original
> > +	[ -r "$workdir/../map/$1" ] || echo "$1"
>
> Maybe "test" instead of "["? Otherwise, ACK from me.

Right!

 git-filter-branch.sh |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index fbbb044..15e9b46 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -189,7 +189,8 @@ USAGE="git-filter-branch [-d TEMPDIR] [-r STARTREV]... [-k KEEPREV]... [-s SRCBR
 
 map()
 {
-	[ -r "$workdir/../map/$1" ] || return 1
+	# if it was not rewritten, take the original
+	test -r "$workdir/../map/$1" || echo "$1"
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
1.5.2
