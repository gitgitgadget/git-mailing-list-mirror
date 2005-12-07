From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Offload most of cg-object-id to git-rev-parse
Date: Wed, 7 Dec 2005 22:39:06 +0100
Message-ID: <20051207213905.GA25890@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 07 22:41:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek70L-0004gp-3c
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 22:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbVLGVjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 16:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVLGVjI
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 16:39:08 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:8903 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1030359AbVLGVjH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 16:39:07 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 00C7E6DFE8B; Wed,  7 Dec 2005 22:38:11 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id B4E036DFE34; Wed,  7 Dec 2005 22:38:11 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 174AD61556; Wed,  7 Dec 2005 22:39:06 +0100 (CET)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13343>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 964e5ec2dd0ff3b073fbb9f3ad6f11c640a96a04
tree 97f861c24303936f012523a54f3d53f4939ebf52
parent 554014e31b92c98b35f77b80b19f5b21e8a76cfc
author Jonas Fonseca <fonseca@diku.dk> Wed, 07 Dec 2005 07:44:26 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Wed, 07 Dec 2005 07:44:26 +0100

 TODO         |    2 --
 cg-object-id |   29 +++++++++--------------------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/TODO b/TODO
index 0658b39..26bb4d0 100644
--- a/TODO
+++ b/TODO
@@ -27,8 +27,6 @@ cg-*patch should be pre-1.0.)
 
 	Includes merge-order cg-log and cg-diff checking for renames.
 
-* Offload most of cg-object-id to git-rev-parse
-
 * Show only first 12 (or so) nibbles of the hashes everywhere
 	Even this might be too much, but more than this is really useless
 	for anyone remotely human. And it's less scary, too.
diff --git a/cg-object-id b/cg-object-id
index ec0362a..c7efa8a 100755
--- a/cg-object-id
+++ b/cg-object-id
@@ -40,27 +40,16 @@ deprecated_alias cg-object-id commit-id 
 normalize_id()
 {
 	local id="$1"
+	local revid=
+	local valid=
 
-	if [ "${id:(-1):1}" = "^" ]; then
-		# find first parent
-		normalize_id "${id%^}"
-		normid=$(git-cat-file commit "$normid" | \
-			 awk '/^parent/{print $2; exit};/^$/{exit}') || exit 1
-		type="commit"
-		return
-	fi
-
-	if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
-		read id < "$_git/$(git-symbolic-ref HEAD)"
-
-	elif [ -r "$_git/refs/tags/$id" ]; then
-		read id < "$_git/refs/tags/$id"
-
-	elif [ -r "$_git/refs/heads/$id" ]; then
-		read id < "$_git/refs/heads/$id"
+	if [ ! "$id" ] || [ "$id" = "this" ]; then
+		id=HEAD;
+	fi
 
-	elif [ -r "$_git/refs/$id" ]; then
-		read id < "$_git/refs/$id"
+	revid="$(git-rev-parse --verify "$id^0" 2>/dev/null)"
+	if [ "$revid" ]; then
+		id="$revid"
 
 	# Short id's must be lower case and at least 4 digits.
 	elif [[ "$id" == [0-9a-f][0-9a-f][0-9a-f][0-9a-f]* ]]; then
@@ -146,7 +135,7 @@ fi
 
 
 if [ "$show_parent" ]; then
-	git-cat-file commit "$normid" | awk '/^parent/{print $2};/^$/{exit}'
+	git-rev-parse "$normid^"
 	exit 0
 fi
 

-- 
Jonas Fonseca
