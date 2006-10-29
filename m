X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Sun, 29 Oct 2006 04:37:54 -0500
Message-ID: <20061029093754.GD3847@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 09:38:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30421>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge77B-00081R-6b for gcvg-git@gmane.org; Sun, 29 Oct
 2006 10:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932134AbWJ2Jh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 04:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWJ2Jh6
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 04:37:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45962 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932134AbWJ2Jh5
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 04:37:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ge77M-0002wE-Aw; Sun, 29 Oct 2006 04:38:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 4E67120E45B; Sun, 29 Oct 2006 04:37:54 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

During `git repack -a -d` only repack objects which are loose or
which reside in an active (a non-kept) pack.  This allows the user
to keep large packs as-is without continuous repacking and can be
very helpful on large repositories.  It should also help us resolve
a race condition between `git repack -a -d` and the new pack store
functionality in `git-receive-pack`.

Kept packs are those which have a corresponding .keep file in
$GIT_OBJECT_DIRECTORY/pack.  That is pack-X.pack will be kept
(not repacked and not deleted) if pack-X.keep exists in the same
directory when `git repack -a -d` starts.

Currently this feature is not documented and there is no user
interface to keep an existing pack.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-repack.sh |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 17e2452..f150a55 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -45,11 +45,19 @@ case ",$all_into_one," in
 	args='--unpacked --incremental'
 	;;
 ,t,)
-	args=
-
-	# Redundancy check in all-into-one case is trivial.
-	existing=`test -d "$PACKDIR" && cd "$PACKDIR" && \
-	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
+	if [ -d "$PACKDIR" ]; then
+		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
+			| sed -e 's/^\.\///' -e 's/\.pack$//'`
+		do
+			if [ -e "$PACKDIR/$e.keep" ]; then
+				: keep
+			else
+				args="$args --unpacked=$e.pack"
+				existing="$existing $e"
+			fi
+		done
+	fi
+	[ -z "$args" ] && args='--unpacked --incremental'
 	;;
 esac
 
@@ -86,17 +94,16 @@ fi
 
 if test "$remove_redundant" = t
 then
-	# We know $existing are all redundant only when
-	# all-into-one is used.
-	if test "$all_into_one" != '' && test "$existing" != ''
+	# We know $existing are all redundant.
+	if [ -n "$existing" ]
 	then
 		sync
 		( cd "$PACKDIR" &&
 		  for e in $existing
 		  do
 			case "$e" in
-			./pack-$name.pack | ./pack-$name.idx) ;;
-			*)	rm -f $e ;;
+			pack-$name) ;;
+			*)	rm -f "$e.pack" "$e.idx" "$e.keep" ;;
 			esac
 		  done
 		)
-- 
1.4.3.3.g7d63
