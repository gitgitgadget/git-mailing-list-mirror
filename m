From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 7/10] Move log printing to separate function
Date: Sat, 4 Jun 2005 16:42:03 +0200
Message-ID: <20050604144203.GK12615@diku.dk>
References: <20050604143831.GD12615@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:39:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeZna-0005c7-Qj
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 16:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVFDOmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 10:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVFDOmN
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 10:42:13 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:26879 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261361AbVFDOmF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 10:42:05 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id CA1366E152A; Sat,  4 Jun 2005 16:41:24 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 4CD5A6E1C09; Sat,  4 Jun 2005 16:41:23 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 6AE4661FE0; Sat,  4 Jun 2005 16:42:03 +0200 (CEST)
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

Each commit log is now handled in the new print_commit_log() function.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-log |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -160,22 +160,13 @@ else
 	revfmt="git-rev-list"
 fi
 
-$revls | $revsort | while read time commit parents; do
-	trap exit SIGPIPE
+print_commit_log() {
+	commit="$1"
 	author=
 	committer=
 	tree=
 	parents=()
-	[ "$revfmt" = "git-rev-list" ] && commit="$time"
-	if [ $# -ne 0 ]; then
-		parent=$(git-cat-file commit $commit | sed -n '2s/parent //p;2Q')
-		diff_ops=
-		[ "$parent" ] || diff_ops=--root
-		[ "$(git-diff-tree -r $diff_ops $commit $parent "$@")" ] || continue
-	fi
-	if [ "$user" ]; then
-		git-cat-file commit $commit | grep -e '^author ' -e '^committer ' | grep -qi "$user" || continue
-	fi
+
 	git-cat-file commit $commit | \
 		while read key rest; do
 			trap exit SIGPIPE
@@ -221,5 +212,20 @@ $revls | $revsort | while read time comm
 				;;
 			esac
 		done
+}
+
+$revls | $revsort | while read time commit parents; do
+	trap exit SIGPIPE
+	[ "$revfmt" = "git-rev-list" ] && commit="$time"
+	if [ $# -ne 0 ]; then
+		parent=$(git-cat-file commit $commit | sed -n '2s/parent //p;2Q')
+		diff_ops=
+		[ "$parent" ] || diff_ops=--root
+		[ "$(git-diff-tree -r $diff_ops $commit $parent "$@")" ] || continue
+	fi
+	if [ "$user" ]; then
+		git-cat-file commit $commit | grep -e '^author ' -e '^committer ' | grep -qi "$user" || continue
+	fi
+	print_commit_log $commit
 	echo
 done | pager
-- 
Jonas Fonseca
