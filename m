From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-pull: summarize the number of pulled objects
Date: Mon, 30 May 2005 03:56:50 +0200
Message-ID: <20050530015650.GB10715@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 03:54:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcZU4-0005bn-Rs
	for gcvg-git@gmane.org; Mon, 30 May 2005 03:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVE3B44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 21:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVE3B44
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 21:56:56 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:28875 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261495AbVE3B4w (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 21:56:52 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 80E826E2644; Mon, 30 May 2005 03:56:19 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 3FF926E2608; Mon, 30 May 2005 03:56:19 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0A07E61FE0; Mon, 30 May 2005 03:56:50 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Show cg-pull progress by summarizing the very verbose output of the pull
backends into a continously updated line specifying the number of
objects which have already been pulled.
		     
Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

Straight from the bloat department, perhaps, but it is nice to not have
the terminal backlog ruined and the object count is quite nice too. :)

Interesting, it counts 4950 objects when pulling over rsync and 4454
objects when pulling locally. Didn't test HTTP pulling other than to see
if the "got <sha>" lines was matched correctly.

 cg-pull |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -29,6 +29,29 @@ if echo "$uri" | grep -q '#'; then
 	uri=$(echo $uri | cut -d '#' -f 1)
 fi
 
+pull_progress() {
+	objects=0
+	last_objects=0
+
+	while read line; do
+		case "$line" in
+		link*| symlink*| \
+		[a-f0-9][a-f0-9]/[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]*| \
+		"got "[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]*)
+			objects=$(($objects + 1));
+			echo -ne "Pulling objects: $objects\r"
+			;;
+		*)
+			if [ "$last_objects" != "$objecst" ]; then
+				last_objects=$objects
+				echo;
+			fi
+			echo "$line"
+			;;
+		esac 
+	done;
+	[ "$last_objects" != "$objecst" ] && echo
+}
 
 fetch_rsync () {
 	redir=
@@ -62,7 +85,7 @@ fetch_rsync () {
 }
 
 pull_rsync () {
-	fetch_rsync -s -u -d "$2/objects" "$_git_objects"
+	fetch_rsync -s -u -d "$2/objects" "$_git_objects" | pull_progress
 }
 
 
@@ -107,7 +130,7 @@ fetch_http () {
 }
 
 pull_http () {
-	git-http-pull -a -v "$(cat "$_git/refs/heads/$1")" "$2/"
+	(git-http-pull -a -v "$(cat "$_git/refs/heads/$1")" "$2/" 2>&1 /dev/null) | pull_progress
 }
 
 
@@ -170,7 +193,7 @@ fetch_local () {
 }
 
 pull_local () {
-	git-local-pull -a -l -v "$(cat "$_git/refs/heads/$1")" "$2"
+	(git-local-pull -a -l -v "$(cat "$_git/refs/heads/$1")" "$2" 2>&1 /dev/null) | pull_progress
 }
 
 if echo "$uri" | grep -q "^http://"; then
-- 
Jonas Fonseca
