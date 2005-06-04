From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 4/10] First parse all commit header entries then print them
Date: Sat, 4 Jun 2005 16:40:35 +0200
Message-ID: <20050604144035.GH12615@diku.dk>
References: <20050604143831.GD12615@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:37:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeZmG-0005Vm-Cf
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 16:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVFDOks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 10:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVFDOks
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 10:40:48 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:13567 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261356AbVFDOkh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 10:40:37 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 1D1866E1C09; Sat,  4 Jun 2005 16:39:56 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D69F66E18CB; Sat,  4 Jun 2005 16:39:55 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id F36C761FE0; Sat,  4 Jun 2005 16:40:35 +0200 (CEST)
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

Change the main loop to first parse all header entries before printing
them. Makes the cg-log output more independent of the order of the git
commit header.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-log |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -183,27 +183,33 @@ $revls | $revsort | while read time comm
 			case "$key" in
 			"author")
 				author="$rest"
-				date=(${author#*> })
-				pdate="$(showdate $date)"
-				[ "$pdate" ] && author="${author%> *}> $pdate"
-				echo $colauthor$key $author $coldefault
 				;;
 			"committer")
 				committer="$rest"
-				date=(${committer#*> })
-				pdate="$(showdate $date)"
-				[ "$pdate" ] && committer="${committer%> *}> $pdate"
-				echo $colcommitter$key $committer $coldefault
 				;;
 			"tree")
 				tree="$rest"
-				echo $colheader$key $tree $coldefault
 				;;
 			"parent")
 				parents[${#parents[@]}]="$rest"
-				echo $colheader$key $rest $coldefault
 				;;
 			"")
+				echo ${colheader}tree $tree $coldefault
+
+				for parent in "${parents[@]}"; do
+					echo ${colheader}parent $parent $coldefault
+				done
+
+				date=(${author#*> })
+				pdate="$(showdate $date)"
+				[ "$pdate" ] && author="${author%> *}> $pdate"
+				echo ${colauthor}author $author $coldefault
+
+				date=(${committer#*> })
+				pdate="$(showdate $date)"
+				[ "$pdate" ] && committer="${committer%> *}> $pdate"
+				echo ${colcommitter}committer $committer $coldefault
+
 				if [ -n "$list_files" ]; then
 					list_commit_files "$tree" "${parents[0]}"
 				fi

-- 
Jonas Fonseca
