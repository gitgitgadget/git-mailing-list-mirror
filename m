From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 3/10] Separate handling of author and committer in commit headers
Date: Sat, 4 Jun 2005 16:40:02 +0200
Message-ID: <20050604144002.GG12615@diku.dk>
References: <20050604143831.GD12615@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:37:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeZli-0005RZ-3v
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 16:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVFDOkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 10:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFDOkN
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 10:40:13 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:6655 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261355AbVFDOkD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 10:40:03 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id A83186E1DC1; Sat,  4 Jun 2005 16:39:22 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 6D9D26E19BA; Sat,  4 Jun 2005 16:39:22 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8A32461FE0; Sat,  4 Jun 2005 16:40:02 +0200 (CEST)
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

Parse and print the author and committer header entries so the color logic
can be removed.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-log |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -162,6 +162,8 @@ fi
 
 $revls | $revsort | while read time commit parents; do
 	trap exit SIGPIPE
+	author=
+	committer=
 	tree=
 	parents=()
 	[ "$revfmt" = "git-rev-list" ] && commit="$time"
@@ -179,17 +181,19 @@ $revls | $revsort | while read time comm
 		while read key rest; do
 			trap exit SIGPIPE
 			case "$key" in
-			"author"|"committer")
-				if [ "$key" = "author" ]; then
-					color="$colauthor"
-				else
-					color="$colcommitter"
-				fi
-
-				date=(${rest#*> })
+			"author")
+				author="$rest"
+				date=(${author#*> })
+				pdate="$(showdate $date)"
+				[ "$pdate" ] && author="${author%> *}> $pdate"
+				echo $colauthor$key $author $coldefault
+				;;
+			"committer")
+				committer="$rest"
+				date=(${committer#*> })
 				pdate="$(showdate $date)"
-				[ "$pdate" ] && rest="${rest%> *}> $pdate"
-				echo $color$key $rest $coldefault
+				[ "$pdate" ] && committer="${committer%> *}> $pdate"
+				echo $colcommitter$key $committer $coldefault
 				;;
 			"tree")
 				tree="$rest"

-- 
Jonas Fonseca
