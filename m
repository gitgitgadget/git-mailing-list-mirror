From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 2/10] Separate handling of tree and parent in commit headers
Date: Sat, 4 Jun 2005 16:39:37 +0200
Message-ID: <20050604143937.GF12615@diku.dk>
References: <20050604143831.GD12615@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:37:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeZlB-0005QQ-TQ
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 16:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVFDOjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 10:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFDOjp
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 10:39:45 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:3327 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261352AbVFDOji (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 10:39:38 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 0582E6E2414; Sat,  4 Jun 2005 16:38:58 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id BECCD6E23FC; Sat,  4 Jun 2005 16:38:57 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id DB2B561FE0; Sat,  4 Jun 2005 16:39:37 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050604143831.GD12615@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Parse tree and parent commit header entries separately so the logic for
deciding where to save the IDs can be removed. Save all parents in an array.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-log |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -162,8 +162,8 @@ fi
 
 $revls | $revsort | while read time commit parents; do
 	trap exit SIGPIPE
-	tree1=
-	tree2=
+	tree=
+	parents=()
 	[ "$revfmt" = "git-rev-list" ] && commit="$time"
 	if [ $# -ne 0 ]; then
 		parent=$(git-cat-file commit $commit | sed -n '2s/parent //p;2Q')
@@ -191,17 +191,17 @@ $revls | $revsort | while read time comm
 				[ "$pdate" ] && rest="${rest%> *}> $pdate"
 				echo $color$key $rest $coldefault
 				;;
-			"tree"|"parent")
-				if [ -z $tree1 ]; then
-					tree1=$rest
-				elif [ -z $tree2 ]; then
-					tree2=$rest
-				fi
+			"tree")
+				tree="$rest"
+				echo $colheader$key $tree $coldefault
+				;;
+			"parent")
+				parents[${#parents[@]}]="$rest"
 				echo $colheader$key $rest $coldefault
 				;;
 			"")
 				if [ -n "$list_files" ]; then
-					list_commit_files "$tree1" "$tree2"
+					list_commit_files "$tree" "${parents[0]}"
 				fi
 				echo; sed -re '
 					/ *Signed-off-by:.*/Is//'$colsignoff'&'$coldefault'/

-- 
Jonas Fonseca
