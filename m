From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 3/4] subtree: add --edit option
Date: Sat,  7 Dec 2013 11:21:24 -0700
Message-ID: <1386440485-3092-3-git-send-email-mmogilvi_git@miniinfo.net>
References: <1386440485-3092-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: greened@obbligato.org, amdmi3@amdmi3.ru, john@keeping.me.uk,
	techlivezheng@gmail.com, apenwarr@gmail.com,
	Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 19:24:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpMYY-0006KW-3r
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 19:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773Ab3LGSYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 13:24:38 -0500
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:44080 "EHLO
	qmta09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755618Ab3LGSY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Dec 2013 13:24:27 -0500
Received: from omta06.emeryville.ca.mail.comcast.net ([76.96.30.51])
	by qmta09.emeryville.ca.mail.comcast.net with comcast
	id yhlG1m00116AWCUA9iQTeq; Sat, 07 Dec 2013 18:24:27 +0000
Received: from mmogilvi.dynu.net ([50.183.100.68])
	by omta06.emeryville.ca.mail.comcast.net with comcast
	id yiQR1m00j1UYGSS8SiQSHG; Sat, 07 Dec 2013 18:24:27 +0000
Received: from rand.mmogilvi.local (rand.mmogilvi.local [192.168.30.68])
	by mmogilvi.dynu.net (Postfix) with ESMTP id C3E001E9601A;
	Sat,  7 Dec 2013 11:24:25 -0700 (MST)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1386440485-3092-1-git-send-email-mmogilvi_git@miniinfo.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1386440667;
	bh=Mz/kRMEMy7HDHOSJc6tAuv0qpzhad+W2tBVWFCrDsGs=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=Z98tEWVG8gbL/71sDo5p6QdALU4ApZGzZB1Mo79yDNxTU6oN3rd2FrOz5u/WU9vRx
	 PujJ3SfVmNRKN7MxmjPXKbtXHYN9+E0ap/SIylCU/p0oltU1epIETC+VKMyOJQFlmd
	 aEiafE3WQvSW8pDp21TAIMaxGS0J7gZu6WP6gFbT7Xgl/CMmG1vIF7uX0mMfOmZH5V
	 DPD6zvy5JvzEw8/xtKhMPkpW//7XBLDBLizrrxppgXxxoEBt3q8sbsCjAJJFQ9OHnL
	 KLGXF2JP6od9CbpXKCPer9K4z+hPGTPPx30u1aCrA1fsY6wRr/G4k3xMlOp1OQe6nv
	 fZYNLSZotk8KA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239011>

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 contrib/subtree/git-subtree.sh  | 37 +++++++++++++++++++++++++++++--------
 contrib/subtree/git-subtree.txt |  4 ++++
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 56d915f..ac82b4d 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -21,6 +21,7 @@ d             show debug messages
 P,prefix=     the name of the subdir to split out
 m,message=    use the given message as the commit message for the merge commit
 squash        merge subtree changes as a single commit
+edit          allow user to edit squash commit message interactively
  options for 'split'
 annotate=     add a prefix to commit message of new commits
 b,branch=     create a new branch from the split subtree
@@ -45,6 +46,7 @@ ignore_joins=
 annotate=
 squash=
 message=
+edit=
 
 debug()
 {
@@ -91,6 +93,7 @@ while [ $# -gt 0 ]; do
 		--ignore-joins) ignore_joins=1 ;;
 		--no-ignore-joins) ignore_joins= ;;
 		--squash) squash=1 ;;
+		--edit) edit=1 ;;
 		--no-squash) squash= ;;
 		--) break ;;
 		*) die "Unexpected option: $opt" ;;
@@ -434,13 +437,12 @@ new_squash_commit()
 	old="$1"
 	oldsub="$2"
 	newsub="$3"
+	msg_file="$4"
 	tree=$(toptree_for_commit $newsub) || exit $?
 	if [ -n "$old" ]; then
-		squash_msg "$dir" "$oldsub" "$newsub" | 
-			git commit-tree "$tree" -p "$old" || exit $?
+		git commit-tree "$tree" -p "$old" -F "$msg_file" || exit $?
 	else
-		squash_msg "$dir" "" "$newsub" |
-			git commit-tree "$tree" || exit $?
+		git commit-tree "$tree" -F "$msg_file" || exit $?
 	fi
 }
 
@@ -556,7 +558,13 @@ cmd_add_commit()
 	fi
 	
 	if [ -n "$squash" ]; then
-		rev=$(new_squash_commit "" "" "$rev") || exit $?
+		msg_file="$GIT_DIR/COMMIT_EDITMSG"
+		squash_msg "$dir" "" "$rev" >"$msg_file"
+		if [ -n "$edit" ]; then
+			git_editor "$msg_file"
+		fi
+		rev=$(new_squash_commit "" "" "$rev" "$msg_file") || exit $?
+		rm -f "$msg_file"
 		commit=$(add_squashed_msg "$rev" "$dir" |
 			 git commit-tree $tree $headp -p "$rev") || exit $?
 	else
@@ -672,8 +680,14 @@ cmd_split()
 				say "Subtree is already at commit $latest_new."
 				exit 0
 			fi
-			new=$(new_squash_commit "$old" "$sub" "$latest_new") \
-				|| exit $?
+			msg_file="$GIT_DIR/COMMIT_EDITMSG"
+			squash_msg "$dir" "$sub" "$latest_new" >"$msg_file"
+			if [ -n "$edit" ]; then
+				git_editor "$msg_file"
+			fi
+			new=$(new_squash_commit "$old" "$sub" "$latest_new" \
+						"$msg_file") || exit $?
+			rm -f "$msg_file"
 			debug "New squash commit: $new"
 		fi
 
@@ -708,7 +722,13 @@ cmd_merge()
 			say "Subtree is already at commit $rev."
 			exit 0
 		fi
-		new=$(new_squash_commit "$old" "$sub" "$rev") || exit $?
+		msg_file="$GIT_DIR/COMMIT_EDITMSG"
+		squash_msg "$dir" "$sub" "$rev" >"$msg_file"
+		if [ -n "$edit" ]; then
+			git_editor "$msg_file"
+		fi
+		new=$(new_squash_commit "$old" "$sub" "$rev" "$msg_file") || exit $?
+		rm -f "$msg_file"
 		debug "New squash commit: $new"
 		rev="$new"
 	fi
@@ -748,6 +768,7 @@ cmd_push()
 	if [ -n "$squash" ]; then
 		opts="-squash"
 	fi
+	# Can't easily pass on --edit because of stdout capture redirection
 
 	if [ -e "$dir" ]; then
 	    repository=$1
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 03092bc..16525d4 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -177,6 +177,10 @@ OPTIONS
 	the merge back to the mainline, not the synthetic subtree
 	history.
 
+--edit::
+	When used with '--squash', bring up an editor on the squash
+	commit message, to allow customizing it.
+
 
 OPTIONS FOR split
 -----------------
-- 
1.8.3.2
