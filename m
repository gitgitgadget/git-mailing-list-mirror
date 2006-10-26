X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Show [xxxx] suffix after non-"heads" branches in git-branch output
Date: Thu, 26 Oct 2006 09:18:05 +0100
Message-ID: <200610260918.05952.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 08:18:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: 07ecfb4d3ad46374
X-UID: 132
X-Length: 1209
Content-Disposition: inline
X-OriginalArrivalTime: 26 Oct 2006 08:21:08.0161 (UTC) FILETIME=[B0080310:01C6F8D7]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30149>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd0RK-0006i6-2K for gcvg-git@gmane.org; Thu, 26 Oct
 2006 10:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751724AbWJZISK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 04:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWJZISK
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 04:18:10 -0400
Received: from mail.360visiontechnology.com ([194.70.53.226]:52306 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1751730AbWJZISJ
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 04:18:09 -0400
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 26 Oct 2006 09:21:08 +0100
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1Gd0RD-00061M-00 for <git@vger.kernel.org>; Thu, 26 Oct
 2006 09:18:07 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This patch changes from showing only those refs in "heads/" to all non-"tags/"
refs.

For any ref that isn't a "heads/" ref (like "remotes/") a suffix of "[xxx]" is
added to the line.
Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
This patch is in preference to my earlier "Use "up/" prefix for all the 
upstream branches" patch.  Junio pointed out that that patch wasn't necessary 
because git already supports the "--use-separate-remote" option.  This patch 
makes git-branch always show all the branches that are useable as references 
in tree-ish, but highlights the remote branches.

 git-branch.sh |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index f823c78..bddd189 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -87,17 +87,28 @@ done
 
 case "$#" in
 0)
-	git-rev-parse --symbolic --branches |
+	git-rev-parse --symbolic --all |
 	sort |
-	while read ref
+	grep -v "^refs/tags" |
+	sed -ne 's|^refs/\([^/]*\)/\(.*\)|\1 \2|p' |
+	while read type ref
 	do
+		case "$type" in
+		heads)
+			type=""
+			;;
+		*)
+			type=" [$type]"
+			;;
+		esac
+
 		if test "$headref" = "$ref"
 		then
 			pfx='*'
 		else
 			pfx=' '
 		fi
-		echo "$pfx $ref"
+		echo "$pfx $ref$type"
 	done
 	exit 0 ;;
 1)
-- 
1.4.2.3
