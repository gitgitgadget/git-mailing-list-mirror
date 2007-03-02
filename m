From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Remove use of git-rev-parse and replace git-rev-list --pretty with git-log
Date: Fri, 2 Mar 2007 19:29:20 +0000
Message-ID: <200703021929.20969.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0703020839350.3953@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 20:32:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNDUH-0002gR-LE
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 20:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbXCBTcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 14:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbXCBTcM
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 14:32:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:43000 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965217AbXCBTcK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 14:32:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so793852uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 11:32:08 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=i9f3A2xx95NZvHkfunPVloT/eZcDwZN8WQFSU/bpT/DT5iMtkGsDAFHqHhF1Y7/sIT/MmjDDcp0RXynBBDFrkBRNhKS7htr3AFVxaALfOIigwYxnRFwJ8GuOd8iL0T3ZF0c/mjjePMQSK/72x02uakwPpJANYsjjtS81iHTffkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=qDyoOUUFLI4oMNEj/TPNNFUpAR3ZBkJQ1qDtfg0+bvI6JnXiRWIzryOVK48DyKFE0BkggX/n/L6n6KMuLNG7A2ySxHWoLuUrPUBPUyrhjKnvvTO0NJy3Q2xcwvNektoN0OmS+HPabliXpyJuzpmY6Q//DM0hgVEkE6YZwAAnnuM=
Received: by 10.67.96.14 with SMTP id y14mr3837560ugl.1172863928784;
        Fri, 02 Mar 2007 11:32:08 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id j34sm2818224ugc.2007.03.02.11.32.06;
        Fri, 02 Mar 2007 11:32:06 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0703020839350.3953@woody.linux-foundation.org>
X-TUID: 2184829c0ae518e5
X-UID: 282
X-Length: 2035
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41239>

Linus noticed:

--- >8 ---
it should just avoid git-rev-parse these days and do

  git rev-list --pretty $newrev --not --all

instead. And quite frankly, rather than "git rev-list --pretty", there's
no real reason not to do

  git log $newrev --not --all
--- 8< ---

This patch makes those changes.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--update |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 2a707e5..f580360 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -148,7 +148,7 @@ case "$refname_type" in
 			# This shows all log entries that are not already covered by
 			# another ref - i.e. commits that are now accessible from this
 			# ref that were previously not accessible
-			git-rev-parse --not --all | git-rev-list --stdin --pretty $newrev
+			git log $newrev --not --all
 			echo $LOGEND
 		else
 			# oldrev is valid
@@ -165,7 +165,7 @@ case "$refname_type" in
 			baserev=$(git-merge-base $oldrev $newrev)
 
 			# Commit with a parent
-			for rev in $(git-rev-parse --not --all | git-rev-list --stdin $newrev ^$baserev)
+			for rev in $(git-rev-list $newrev ^$baserev --not --all)
 			do
 				revtype=$(git-cat-file -t "$rev")
 				echo "       via  $rev ($revtype)"
@@ -190,8 +190,7 @@ case "$refname_type" in
 			fi
 			echo ""
 			echo $LOGBEGIN
-			git-rev-parse --not --all |
-			git-rev-list --stdin --pretty $newrev ^$baserev
+			git log $newrev ^$baserev --not --all
 			echo $LOGEND
 			echo ""
 			echo "Diffstat:"
-- 
1.5.0.rc4.gb4d2
