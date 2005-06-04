From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 8/10] Move the username matching inside the loop
Date: Sat, 4 Jun 2005 16:42:42 +0200
Message-ID: <20050604144242.GL12615@diku.dk>
References: <20050604143831.GD12615@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:39:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeZo5-0005hL-3u
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 16:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVFDOmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 10:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVFDOmq
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 10:42:46 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:30463 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261362AbVFDOmn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 10:42:43 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 721CF6E256F; Sat,  4 Jun 2005 16:42:02 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 357266E256A; Sat,  4 Jun 2005 16:42:02 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 536B461FE0; Sat,  4 Jun 2005 16:42:42 +0200 (CEST)
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

By handling -u in the commit parsing loop no extra git-cat-file call is
necessary. Keep the line-based matching scheme so that it is still possible
to restrict searches by using prefixing the search string with either
'author' or 'committer' (e.g. -u'author.*miciah').

This change also magically removes trailing empty lines from commit logs.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-log |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -184,6 +184,10 @@ print_commit_log() {
 				parents[${#parents[@]}]="$rest"
 				;;
 			"")
+				if [ "$user" ]; then
+					echo -e "author $author\ncommitter $committer" \
+						| grep -qi "$user" || return
+				fi
 				echo ${colheader}commit ${commit%:*} $coldefault
 				echo ${colheader}tree $tree $coldefault
 
@@ -223,9 +227,9 @@ $revls | $revsort | while read time comm
 		[ "$parent" ] || diff_ops=--root
 		[ "$(git-diff-tree -r $diff_ops $commit $parent "$@")" ] || continue
 	fi
-	if [ "$user" ]; then
-		git-cat-file commit $commit | grep -e '^author ' -e '^committer ' | grep -qi "$user" || continue
+	log="$(print_commit_log $commit)"
+	if [ "$log" ]; then
+		echo "$log"
+		echo
 	fi
-	print_commit_log $commit
-	echo
 done | pager
-- 
Jonas Fonseca
