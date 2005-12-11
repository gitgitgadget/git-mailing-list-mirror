From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Offload most of cg-object-id to git-rev-parse
Date: Sun, 11 Dec 2005 19:19:01 +0100
Message-ID: <20051211181901.GA2960@diku.dk>
References: <20051207213905.GA25890@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 11 19:19:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElVmu-0006GX-Vt
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 19:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVLKSTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 13:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVLKSTE
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 13:19:04 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:38648 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750766AbVLKSTD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 13:19:03 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 5F8466DFE7E; Sun, 11 Dec 2005 19:18:02 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 15B4A6DFE34; Sun, 11 Dec 2005 19:18:02 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 6F6ED615B3; Sun, 11 Dec 2005 19:19:01 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051207213905.GA25890@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13499>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
 
---

 Forget the other 4 patches. Here's one that fixes the thing we
 discussed on IRC, i.e. ambiguous ID's are handled correctly
 (unfortunately without giving a proper warning message).
 
 This one also assumes that there is no reason for checking revs
 returned by git-rev-list with git-rev-parse --revs-only.

 TODO         |    2 --
 cg-object-id |   58 ++++++++++++++++------------------------------------------
 2 files changed, 16 insertions(+), 44 deletions(-)

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
index 1628e93..49d6d99 100755
--- a/cg-object-id
+++ b/cg-object-id
@@ -40,54 +40,29 @@ deprecated_alias cg-object-id commit-id 
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
-
-	elif [ -r "$_git/refs/$id" ]; then
-		read id < "$_git/refs/$id"
-
-	# Short id's must be lower case and at least 4 digits.
-	elif [[ "$id" == [0-9a-f][0-9a-f][0-9a-f][0-9a-f]* ]]; then
-		idpref=${id:0:2}
-		idpost=${id:2}
-
-		# Assign array elements to matching names
-		idmatch=($_git_objects/$idpref/$idpost*)
-
-		if [ ${#idmatch[*]} -eq 1 ] && [ -r "$idmatch" ]; then
-			exid=$idpref${idmatch#$_git_objects/$idpref/}
-			[ ${#exid} -eq 40 ] && [ "$(git-rev-parse --revs-only "$exid")" ] && id="$exid"
-		elif [ ${#idmatch[*]} -gt 1 ]; then
-			echo "Ambiguous id: $id" >&2
-			echo "${idmatch[@]}" >&2
-			exit 1
-		fi
+	if [ ! "$id" ] || [ "$id" = "this" ]; then
+		id=HEAD;
+	fi
+
+ 	revid="$(git-rev-parse --verify "$id^0" 2>/dev/null)"
+ 	if [ "$revid" ]; then
+ 		id="$revid"
+		valid=1
 	fi
 
-	valid=; [ ${#id} -eq 40 ] && [ "$(git-rev-parse --revs-only "$id")" ] && valid=1
 	# date does the wrong thing for empty and single-letter ids
 	if [ ${#id} -gt 1 ] && [ ! "$valid" ]; then
 		reqsecs=$(date --date="$id" +'%s' 2>/dev/null)
 
 		if [ "$reqsecs" ]; then
-			id=$(git-rev-list --min-age=$reqsecs --max-count=1 HEAD)
-			valid=; [ ${#id} -eq 40 ] && [ "$(git-rev-parse --revs-only "$id")" ] && valid=1
+			revid=$(git-rev-list --min-age=$reqsecs --max-count=1 HEAD)
+			if [ ${#revid} -eq 40 ]; then
+				id="$revid"
+				valid=1
+			fi
 		fi
 	fi
 
@@ -147,7 +122,7 @@ fi
 
 
 if [ "$show_parent" ]; then
-	git-cat-file commit "$normid" | awk '/^parent/{print $2};/^$/{exit}'
+	git-rev-parse "$normid^"
 	exit 0
 fi
 
@@ -170,4 +145,3 @@ else
 fi
 
 echo $normid
-
-- 
Jonas Fonseca
