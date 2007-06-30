From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Correct usages of sed in git-tag for Mac OS X
Date: Sat, 30 Jun 2007 02:42:47 -0400
Message-ID: <20070630064247.GA18041@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 08:43:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Wfb-0006X8-GE
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 08:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbXF3Gmw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 02:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbXF3Gmw
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 02:42:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51264 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbXF3Gmv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 02:42:51 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I4WfQ-000658-0J; Sat, 30 Jun 2007 02:42:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E2EA620FBAE; Sat, 30 Jun 2007 02:42:47 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51196>

Both `git-tag -l` and `git tag -v` fail on Mac OS X due to their
non-standard uses of sed.  Actually `git tag -v` fails because the
underlying git-tag-verify uses a non-standard sed command.

We now stick to only standard sed, which does make our sed scripts
slightly more complicated, but we can actually list tags with more
than 0 lines of additional context and we can verify signed tags
with gpg.  These major Git functions are much more important than
saving two or three lines of a simple sed script.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Boy, it would sure be nice if git-tag was written in a more portable
 programming language, such as C.  No more worries about sed working
 on one platform and not another.  ;-)

 t7004-tag.sh now passes all 65 tests here.

 git-tag.sh        |   16 ++++++++++------
 git-verify-tag.sh |    7 ++++---
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/git-tag.sh b/git-tag.sh
index c840439..3917cd8 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -51,12 +51,16 @@ do
 		[ "$LINES" -le 0 ] && { echo "$TAG"; continue ;}
 		OBJTYPE=$(git cat-file -t "$TAG")
 		case $OBJTYPE in
-		tag)	ANNOTATION=$(git cat-file tag "$TAG" |
-				       sed -e '1,/^$/d' \
-					   -e '/^-----BEGIN PGP SIGNATURE-----$/Q' )
-			printf "%-15s %s\n" "$TAG" "$ANNOTATION" |
-			  sed -e '2,$s/^/    /' \
-			      -e "${LINES}q"
+		tag)
+			ANNOTATION=$(git cat-file tag "$TAG" |
+				sed -e '1,/^$/d' |
+				sed -n -e "
+					/^-----BEGIN PGP SIGNATURE-----\$/q
+					2,\$s/^/    /
+					p
+					${LINES}q
+				")
+			printf "%-15s %s\n" "$TAG" "$ANNOTATION"
 			;;
 		*)      echo "$TAG"
 			;;
diff --git a/git-verify-tag.sh b/git-verify-tag.sh
index f2d5597..a54fd48 100755
--- a/git-verify-tag.sh
+++ b/git-verify-tag.sh
@@ -37,8 +37,9 @@ esac
 trap 'rm -f "$GIT_DIR/.tmp-vtag"' 0
 
 git-cat-file tag "$1" >"$GIT_DIR/.tmp-vtag" || exit 1
-
-cat "$GIT_DIR/.tmp-vtag" |
-sed '/-----BEGIN PGP/Q' |
+sed -n -e '
+	/^-----BEGIN PGP SIGNATURE-----$/q
+	p
+	' <"$GIT_DIR/.tmp-vtag" |
 gpg --verify "$GIT_DIR/.tmp-vtag" - || exit 1
 rm -f "$GIT_DIR/.tmp-vtag"
-- 
1.5.2.2.1414.g1e7d-dirty
