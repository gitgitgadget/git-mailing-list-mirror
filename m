From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Make repack less likely to corrupt repository
Date: Mon,  9 Feb 2009 01:44:59 +0100
Message-ID: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	spearce@spearce.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 09 01:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWKIG-00061n-Ii
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 01:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbZBIApJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 19:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbZBIApI
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 19:45:08 -0500
Received: from mail.dewire.com ([83.140.172.130]:22086 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023AbZBIApH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 19:45:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B19B1A149A4;
	Mon,  9 Feb 2009 01:45:03 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id av+dAILyq3RZ; Mon,  9 Feb 2009 01:45:02 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id D9DB68026F9;
	Mon,  9 Feb 2009 01:45:01 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109029>

Repack could easily leave a repo in bad state after a failed
repack on Windows if a pack file that repack wanted to replace
was locked by a reader. A second attempt at running repack
would then destroy the repo by removing the pack file. This
attempts to make repack leave the repo in a good state, although
not optimal, in order to avoid disasters.

If renaming an old pack fails we will try to restore halfway renames
before exiting repack.

For severe situations we encourage the user to seek advice.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 git-repack.sh |   43 ++++++++++++++++++++++++++++++++-----------
 1 files changed, 32 insertions(+), 11 deletions(-)

Here is an attempt at fixing this It was tested by making sure the
idx or pack file was opened by some process and verifying that repo
was ok after git repack -a -d. That was a manual test. We should
probably add an automatic one too of some sort but I submit this 
for reading  and ad-hoc testing by interested parties.

-- robin

diff --git a/git-repack.sh b/git-repack.sh
index 458a497..6a7ba90 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -93,22 +93,43 @@ for name in $names ; do
 	chmod a-w "$PACKTMP-$name.pack"
 	chmod a-w "$PACKTMP-$name.idx"
 	mkdir -p "$PACKDIR" || exit
-
-	for sfx in pack idx
-	do
-		if test -f "$PACKDIR/pack-$name.$sfx"
-		then
-			mv -f "$PACKDIR/pack-$name.$sfx" \
-				"$PACKDIR/old-pack-$name.$sfx"
-		fi
-	done &&
+	ok=t
+	if test -f "$PACKDIR/pack-$name.pack"
+	then
+		mv -f "$PACKDIR/pack-$name.pack" \
+			"$PACKDIR/old-pack-$name.pack"
+	fi &&
+	if test -f "$PACKDIR/pack-$name.idx"
+	then
+		mv -f "$PACKDIR/pack-$name.idx" \
+			"$PACKDIR/old-pack-$name.idx" ||
+		(
+			mv -f "$PACKDIR/old-pack-$name.pack" \
+			"$PACKDIR/pack-$name.pack" || (
+				echo >&2 "Failed to restore after a failure to rename"\
+					"pack-$name{pack,idx} to old-$pack{pack,idx} in $PACKDIR"
+				echo >&2 "Please acquire advice on how to recover from this"\
+					"situation before you proceed."
+				exit 1
+			) || false
+		) || (
+			echo >&2 "Failed to replace the existing pack with updated one."
+			echo >&2 "We recovered from the situation, but cannot continue".
+			echo >&2 "repacking."
+			exit 0
+		)
+	fi &&
 	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
 	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
 	test -f "$PACKDIR/pack-$name.pack" &&
 	test -f "$PACKDIR/pack-$name.idx" || {
 		echo >&2 "Couldn't replace the existing pack with updated one."
-		echo >&2 "The original set of packs have been saved as"
-		echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
+		if (test -f "$PACKDIR/old-pack-$name.pack" ||
+			test -f "$PACKDIR/old-pack-$name.idx")
+		then
+			echo >&2 "The original set of packs have been saved as"
+			echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
+		fi
 		exit 1
 	}
 	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
-- 
1.6.1.285.g35d8b
