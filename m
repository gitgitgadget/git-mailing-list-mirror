From: Greg Price <price@ksplice.com>
Subject: [PATCH RFC 4/4] rebase -i: add --refs option to rewrite heads
	within branch
Date: Tue, 22 Dec 2009 17:23:16 -0500
Message-ID: <20091222222316.GY30538@dr-wily.mit.edu>
References: <20091222222032.GU30538@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 23:23:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NND8b-0003q5-Bq
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 23:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223AbZLVWXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 17:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755217AbZLVWXV
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 17:23:21 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:42109 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755213AbZLVWXU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 17:23:20 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id nBMMMgWM007793;
	Tue, 22 Dec 2009 17:22:43 -0500 (EST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id nBMMNTI5028943;
	Tue, 22 Dec 2009 17:23:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20091222222032.GU30538@dr-wily.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135605>

The new option --refs causes the TODO file to contain a "ref" command
for each head pointing to a selected commit, other than the one we are
already rebasing.  The effect of this is that when a branch contains
intermediate branches, like so:

      part1 part2 topic
        |     |     |
        v     v     v
  A--*--*--*--*--*--*
   \
    B <--master

a single command like "git rebase -i --refs master topic" suffices to
rewrite all the heads that are part of the topic, like so:

        part1 part2 topic
  A       |     |     |
   \      v     v     v
    B--*--*--*--*--*--*
    ^
    |
    master

Signed-off-by: Greg Price <price@ksplice.com>
---
 git-rebase--interactive.sh |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 25ac3e3..cccb031 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -18,6 +18,7 @@ git-rebase [-i] (--continue | --abort | --skip)
  Available options are
 v,verbose          display a diffstat of what changed upstream
 onto=              rebase onto given branch instead of upstream
+refs               rewrite intermediate heads on branch
 p,preserve-merges  try to recreate merges instead of ignoring them
 s,strategy=        use the given merge strategy
 m,merge            always used (no-op)
@@ -42,6 +43,7 @@ REWRITTEN="$DOTEST"/rewritten
 DROPPED="$DOTEST"/dropped
 PRESERVE_MERGES=
 STRATEGY=
+REWRITE_REFS=
 ONTO=
 VERBOSE=
 OK_TO_SKIP_PRE_REBASE=
@@ -578,6 +580,9 @@ first and then run 'git rebase --continue' again."
 
 		output git reset --hard && do_rest
 		;;
+	--refs)
+		REWRITE_REFS=t
+		;;
 	-s)
 		case "$#,$1" in
 		*,*=*)
@@ -705,11 +710,14 @@ first and then run 'git rebase --continue' again."
 			REVISIONS=$ONTO...$HEAD
 			SHORTREVISIONS=$SHORTHEAD
 		fi
-		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
-			--abbrev=7 --reverse --left-right --topo-order \
+		git rev-list $MERGES_OPTION --abbrev-commit --abbrev=7 \
+			--reverse --left-right --topo-order \
+			--pretty=format:"$(printf '%%m%%h %%s\n%%m%%D')" \
 			$REVISIONS | \
 			sed -n "s/^>//p" | while read shortsha1 rest
 		do
+			read refs
+
 			if test t != "$PRESERVE_MERGES"
 			then
 				echo "pick $shortsha1 $rest" >> "$TODO"
@@ -734,6 +742,16 @@ first and then run 'git rebase --continue' again."
 					echo "pick $shortsha1 $rest" >> "$TODO"
 				fi
 			fi
+
+			if test t = "$REWRITE_REFS"
+			then
+				for ref in $refs
+				do
+					test ${ref#refs/heads/} != $ref &&
+					test $ref != $(cat "$DOTEST"/head-name) &&
+					echo "ref $ref" >> "$TODO"
+				done
+			fi
 		done
 
 		# Watch for commits that been dropped by --cherry-pick
-- 
1.6.6.rc1.9.g2ad41.dirty
