From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Catch and handle git-commit failures in git-rebase --interactive
Date: Wed, 19 Dec 2007 01:45:00 -0500
Message-ID: <20071219064500.GB8915@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 07:45:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4sgP-00040R-AE
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 07:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbXLSGpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 01:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbXLSGpJ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 01:45:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39120 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbXLSGpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 01:45:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J4sfu-0000KO-NP; Wed, 19 Dec 2007 01:45:03 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AD91B20FBAE; Wed, 19 Dec 2007 01:45:00 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68857>

If git-commit fails for any reason then git-rebase needs to stop
and not plow through the rest of the series.  Its unlikely that
a future git-commit will succeed if the current attempt failed.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Comments welcome.  This is on top of my 1/2 patch but we could
 drop my 1/2 and rewrite this to not use --no-verify, but handle
 the git-commit error correctly.

 However that would force users to fix whitespace errors in later
 patches in a series if they use -i, even though non-i wouldn't
 require that sort of fix-up.  So I think we should do both patches
 in the series.

 This has also bitten me a few times. :-\

 git-rebase--interactive.sh |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b846ea8..0f7d939 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -289,22 +289,22 @@ do_next () {
 		output git reset --soft HEAD^
 		pick_one -n $sha1 || failed=t
 		echo "$author_script" > "$DOTEST"/author-script
-		case $failed in
-		f)
+		if test $failed = f
+		then
 			# This is like --amend, but with a different message
 			eval "$author_script"
 			GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
 			GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
 			GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-			$USE_OUTPUT git commit --no-verify -F "$MSG" $EDIT_COMMIT
-			;;
-		t)
+			$USE_OUTPUT git commit --no-verify -F "$MSG" $EDIT_COMMIT || failed=t
+		fi
+		if test $failed = t
+		then
 			cp "$MSG" "$GIT_DIR"/MERGE_MSG
 			warn
 			warn "Could not apply $sha1... $rest"
 			die_with_patch $sha1 ""
-			;;
-		esac
+		fi
 		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
@@ -372,7 +372,8 @@ do
 			test ! -f "$DOTEST"/amend || git reset --soft HEAD^
 		} &&
 		export GIT_AUTHOR_NAME GIT_AUTHOR_NAME GIT_AUTHOR_DATE &&
-		git commit --no-verify -F "$DOTEST"/message -e
+		git commit --no-verify -F "$DOTEST"/message -e ||
+			die "Could not commit staged changes."
 
 		require_clean_work_tree
 		do_rest
-- 
1.5.4.rc0.1155.g12ed9
