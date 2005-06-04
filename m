From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 9/10] Move file matching inside the loop.
Date: Sat, 4 Jun 2005 16:43:06 +0200
Message-ID: <20050604144306.GM12615@diku.dk>
References: <20050604143831.GD12615@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:40:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeZoa-0005my-2p
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 16:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVFDOnO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 10:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVFDOnO
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 10:43:14 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:34559 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261364AbVFDOnH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 10:43:07 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 6806E6E2530; Sat,  4 Jun 2005 16:42:26 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 2D2656E2499; Sat,  4 Jun 2005 16:42:26 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 4970361FE0; Sat,  4 Jun 2005 16:43:06 +0200 (CEST)
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

Handling of -f is done inide the loop so no extra git-cat-file call is
necessary. Store file arguments to cg-log in an array to make them easier
to access from print_commit_log().

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-log |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -73,6 +73,7 @@ log_start=
 log_end=
 user=
 mergebase=
+files=()
 
 while [ "$1" ]; do
 	case "$1" in
@@ -107,6 +108,7 @@ while [ "$1" ]; do
 		mergebase=1
 		;;
 	*)
+		files=("$@")
 		break
 		;;
 	esac
@@ -184,6 +186,12 @@ print_commit_log() {
 				parents[${#parents[@]}]="$rest"
 				;;
 			"")
+				if [ "$files" ]; then
+					parent="${parents[0]}"
+					diff_ops=
+					[ "$parent" ] || diff_ops=--root
+					[ "$(git-diff-tree -r $diff_ops $commit $parent "${files[@]}")" ] || return 1
+				fi
 				if [ "$user" ]; then
 					echo -e "author $author\ncommitter $committer" \
 						| grep -qi "$user" || return
@@ -221,12 +229,6 @@ print_commit_log() {
 $revls | $revsort | while read time commit parents; do
 	trap exit SIGPIPE
 	[ "$revfmt" = "git-rev-list" ] && commit="$time"
-	if [ $# -ne 0 ]; then
-		parent=$(git-cat-file commit $commit | sed -n '2s/parent //p;2Q')
-		diff_ops=
-		[ "$parent" ] || diff_ops=--root
-		[ "$(git-diff-tree -r $diff_ops $commit $parent "$@")" ] || continue
-	fi
 	log="$(print_commit_log $commit)"
 	if [ "$log" ]; then
 		echo "$log"
-- 
Jonas Fonseca
