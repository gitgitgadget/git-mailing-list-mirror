From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-status: handle subdirs when listing heads
Date: Sun, 11 Dec 2005 20:03:05 +0100
Message-ID: <20051211190305.GD2960@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 11 20:05:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElWUC-0005YR-Bx
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 20:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVLKTDI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 14:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLKTDI
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 14:03:08 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:63737 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750798AbVLKTDH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 14:03:07 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id C9DFD6DFD1E; Sun, 11 Dec 2005 20:02:06 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 8C1D56DFD14; Sun, 11 Dec 2005 20:02:06 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id F0EF3615B3; Sun, 11 Dec 2005 20:03:05 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13502>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 fonseca@antimatter:~/src/cogito/cogito > cg switch -r master tmp/work
 Creating new branch tmp/work: 218ee732bee381746890bf5ffb9bfc4672795954
 Switching to branch tmp/work...
 fonseca@antimatter:~/src/cogito/cogito > cg status
 Heads:
     cg-object-id        c10cc1d2a99b01ed3bf45d5f2ad6157940a22365
     cg-Xedit    41447107236a7d23daa6ab0f40a0829935485bc8
     master      218ee732bee381746890bf5ffb9bfc4672795954
   R origin      218ee732bee381746890bf5ffb9bfc4672795954
 cat: .git/refs/heads/tmp: Is a directory
     tmp

commit 2e7be765ca86117dc7af8aa0cd0f090269fee428
tree 0154d7f35e6ae7c357ff18e7b1f46e2ee4d25309
parent 218ee732bee381746890bf5ffb9bfc4672795954
author Jonas Fonseca <fonseca@diku.dk> Sun, 11 Dec 2005 19:57:31 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Sun, 11 Dec 2005 19:57:31 +0100

 cg-status |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/cg-status b/cg-status
index a4c5e7a..629c796 100755
--- a/cg-status
+++ b/cg-status
@@ -106,6 +106,24 @@ if [ ! "$gitstatus" ] && [ ! "$workstatu
 fi
 
 
+list_heads()
+{
+	local path="$1"
+
+	if [ -d "$path" ]; then
+		for head in "$path"/*; do
+			list_heads "$head"
+		done
+	else
+		headsha1=$(cat "$path")
+		headname=${path#$_git/refs/heads/}
+		[ "$headname" = "cg-seek-point" ] && continue
+		cf=" "; rf=" "
+		[ "$headname" = "$_git_head" ] && cf=">"
+		[ -s "$_git/branches/$headname" ] && rf="R"
+		echo -e "  $rf$cf$headname\t$headsha1"
+	fi
+}
 
 if [ "$gitstatus" ]; then
 	mkdir -p $_git/refs/heads
@@ -123,15 +141,7 @@ if [ "$gitstatus" ]; then
 	fi
 
 	echo "Heads:"
-	for head in $_git/refs/heads/*; do
-		headsha1=$(cat "$head")
-		headname=$(basename "$head")
-		[ "$headname" = "cg-seek-point" ] && continue
-		cf=" "; rf=" "
-		[ "$headname" = "$_git_head" ] && cf=">"
-		[ -s "$_git/branches/$headname" ] && rf="R"
-		echo -e "  $rf$cf$headname\t$headsha1"
-	done
+	list_heads "$_git/refs/heads"
 
 	if [ -s "$_git/merging" ]; then
 		tmp=$(cat "$_git/merging")



!-------------------------------------------------------------flip-

-- 
Jonas Fonseca
