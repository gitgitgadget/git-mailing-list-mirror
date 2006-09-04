From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] git-repack: create new packs inside $PACKDIR, not cwd
Date: Mon,  4 Sep 2006 17:42:32 +1200
Message-ID: <11573485523752-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Sep 04 10:41:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKA0d-0002gU-0m
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 10:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWIDIk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 04:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWIDIkH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 04:40:07 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:24797 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932315AbWIDFmb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 01:42:31 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1GK7E5-0005VT-NL; Mon, 04 Sep 2006 17:42:30 +1200
To: git@vger.kernel.org, junkio@cox.net
X-Mailer: git-send-email 1.4.2.gdfe7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26407>

Avoid failing when cwd is !writable by writing the
packfiles directly in the $PACKDIR.

Without this, git-repack was failing when run from crontab
by non-root user accounts. For large repositories, this
also makes the mv operation a lot cheaper, and avoids leaving
temp packfiles around the fs upon failure.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
 git-repack.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 584a732..ccc8e43 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -42,11 +42,13 @@ case ",$all_into_one," in
 	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
 	;;
 esac
+
+mkdir -p "$PACKDIR" || exit
 pack_objects="$pack_objects $local $quiet $no_reuse_delta$extra"
 name=$( { git-rev-list --objects --all $rev_list ||
 	  echo "git-rev-list died with exit code $?"
 	} |
-	git-pack-objects --non-empty $pack_objects .tmp-pack) ||
+	git-pack-objects --non-empty $pack_objects "$PACKDIR/.tmp-pack") ||
 	exit 1
 if [ -z "$name" ]; then
 	echo Nothing new to pack.
@@ -54,7 +56,6 @@ else
 	if test "$quiet" != '-q'; then
 	    echo "Pack pack-$name created."
 	fi
-	mkdir -p "$PACKDIR" || exit
 
 	for sfx in pack idx
 	do
@@ -64,8 +65,8 @@ else
 				"$PACKDIR/old-pack-$name.$sfx"
 		fi
 	done &&
-	mv -f .tmp-pack-$name.pack "$PACKDIR/pack-$name.pack" &&
-	mv -f .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" &&
+	mv -f "$PACKDIR/.tmp-pack-$name.pack" "$PACKDIR/pack-$name.pack" &&
+	mv -f "$PACKDIR/.tmp-pack-$name.idx"  "$PACKDIR/pack-$name.idx" &&
 	test -f "$PACKDIR/pack-$name.pack" &&
 	test -f "$PACKDIR/pack-$name.idx" || {
 		echo >&2 "Couldn't replace the existing pack with updated one."
-- 
1.4.2.gdfe7


-- 
VGER BF report: S 1
