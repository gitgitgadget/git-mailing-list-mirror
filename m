From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] rebase-i-p: only list commits that require rewriting in todo
Date: Wed, 15 Oct 2008 02:44:38 -0500
Message-ID: <0977b23f6c709d4aea76de7a88e9fe17272b31ea.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
 <79b3f186dc599ebb5e251d5c0ca93c233263974c.1224055978.git.stephen@exigencecorp.com>
 <ef8c08551dca1ddfea0017fd4026ac9ae60fbfec.1224055978.git.stephen@exigencecorp.com>
 <759654ef1f1781cd2b102e21c6f972b065560398.1224055978.git.stephen@exigencecorp.com>
 <ab80b829ebfa597dc4aaac6e49f9907e505adf59.1224055978.git.stephen@exigencecorp.com>
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 15 09:46:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq153-00012V-41
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbYJOHoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbYJOHoy
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:44:54 -0400
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:49884 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbYJOHor (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:44:47 -0400
Received: from relay6.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 7B1F61E06B4;
	Wed, 15 Oct 2008 03:44:47 -0400 (EDT)
Received: by relay6.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id E20F01E0660;
	Wed, 15 Oct 2008 03:44:46 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <ab80b829ebfa597dc4aaac6e49f9907e505adf59.1224055978.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98249>

This is heavily based on Stephan Beyer's git sequencer rewrite of rebase-i-p.

Each commit is still found by rev-list UPSTREAM..HEAD, but a commit is only
included in todo if at least one its parents has been marked for rewriting.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-rebase--interactive.sh |   77 +++++++++++++++++++++++++++++--------------
 1 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 274251f..331cb18 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -579,18 +579,67 @@ first and then run 'git rebase --continue' again."
 				echo $ONTO > "$REWRITTEN"/$c ||
 					die "Could not init rewritten commits"
 			done
+			# No cherry-pick because our first pass is to determine
+			# parents to rewrite and skipping dropped commits would
+			# prematurely end our probe
 			MERGES_OPTION=
 		else
-			MERGES_OPTION=--no-merges
+			MERGES_OPTION="--no-merges --cherry-pick"
 		fi
 
 		SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
 		SHORTHEAD=$(git rev-parse --short $HEAD)
 		SHORTONTO=$(git rev-parse --short $ONTO)
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
-			--abbrev=7 --reverse --left-right --cherry-pick \
+			--abbrev=7 --reverse --left-right --topo-order \
 			$UPSTREAM...$HEAD | \
-			sed -n "s/^>/pick /p" > "$TODO"
+			sed -n "s/^>//p" | while read shortsha1 rest
+		do
+			if test t != "$PRESERVE_MERGES"
+			then
+				echo "pick $shortsha1 $rest" >> "$TODO"
+			else
+				sha1=$(git rev-parse $shortsha1)
+				preserve=t
+				for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
+				do
+					if test -f "$REWRITTEN"/$p
+					then
+						preserve=f
+					fi
+				done
+				if test f = "$preserve"
+				then
+					touch "$REWRITTEN"/$sha1
+					echo "pick $shortsha1 $rest" >> "$TODO"
+				fi
+			fi
+		done
+
+		# Watch for commits that been dropped by --cherry-pick
+		if test t = "$PRESERVE_MERGES"
+		then
+			mkdir "$DROPPED"
+			# Save all non-cherry-picked changes
+			git rev-list $UPSTREAM...$HEAD --left-right --cherry-pick | \
+				sed -n "s/^>//p" > "$DOTEST"/not-cherry-picks
+			# Now all commits and note which ones are missing in
+			# not-cherry-picks and hence being dropped
+			git rev-list $UPSTREAM...$HEAD --left-right | \
+ 				sed -n "s/^>//p" | while read rev
+			do
+				if test -f "$REWRITTEN"/$rev -a "$(grep "$rev" "$DOTEST"/not-cherry-picks)" = ""
+				then
+					# Use -f2 because if rev-list is telling us this commit is
+					# not worthwhile, we don't want to track its multiple heads,
+					# just the history of its first-parent for others that will
+					# be rebasing on top of it
+					git rev-list --parents -1 $rev | cut -d' ' -f2 > "$DROPPED"/$rev
+					cat "$TODO" | grep -v "${rev:0:7}" > "${TODO}2" ; mv "${TODO}2" "$TODO"
+					rm "$REWRITTEN"/$rev
+				fi
+			done
+		fi
 		test -s "$TODO" || echo noop >> "$TODO"
 		cat >> "$TODO" << EOF
 
@@ -606,28 +655,6 @@ first and then run 'git rebase --continue' again."
 #
 EOF
 
-		# Watch for commits that been dropped by --cherry-pick
-		if test t = "$PRESERVE_MERGES"
-		then
-			mkdir "$DROPPED"
-			# drop the --cherry-pick parameter this time
-			git rev-list $MERGES_OPTION --abbrev-commit \
-				--abbrev=7 $UPSTREAM...$HEAD --left-right | \
-				sed -n "s/^>//p" | while read rev
-			do
-				grep --quiet "$rev" "$TODO"
-				if [ $? -ne 0 ]
-				then
-					# Use -f2 because if rev-list is telling this commit is not
-					# worthwhile, we don't want to track its multiple heads,
-					# just the history of its first-parent for others that will
-					# be rebasing on top of us
-					full=$(git rev-parse $rev)
-					git rev-list --parents -1 $rev | cut -d' ' -f2 > "$DROPPED"/$full
-				fi
-			done
-		fi
-
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
-- 
1.6.0.2
