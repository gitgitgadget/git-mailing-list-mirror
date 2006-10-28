X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Sat, 28 Oct 2006 04:40:01 -0400
Message-ID: <20061028084001.GC14607@spearce.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org> <7v3b99e87c.fsf@assigned-by-dhcp.cox.net> <20061028034206.GA14044@spearce.org> <Pine.LNX.4.64.0610272109500.3849@g5.osdl.org> <7vwt6l9etn.fsf@assigned-by-dhcp.cox.net> <20061028072146.GB14607@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 08:40:33 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061028072146.GB14607@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30370>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdjjp-0007go-Ua for gcvg-git@gmane.org; Sat, 28 Oct
 2006 10:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752000AbWJ1IkP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 04:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbWJ1IkP
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 04:40:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44184 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1752000AbWJ1IkN
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 04:40:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gdjja-0007Os-St; Sat, 28 Oct 2006 04:40:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6BA3120E45B; Sat, 28 Oct 2006 04:40:04 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> wrote:
> Why not just use create a new flag file?
> 
> Lets say that a pack X is NOT eligible to be repacked if
> "$GIT_DIR/objects/pack/pack-X.keep" exists.

Here's the `git repack -a -d` portion of that.
Thoughts?

-- >8 --
[PATCH] Only repack active packs by skipping over kept packs.

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
 git-repack.sh |   48 +++++++++++++++++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 17e2452..fe1e2ef 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -43,13 +43,30 @@ trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
 case ",$all_into_one," in
 ,,)
 	args='--unpacked --incremental'
+	active=
 	;;
 ,t,)
-	args=
-
-	# Redundancy check in all-into-one case is trivial.
-	existing=`test -d "$PACKDIR" && cd "$PACKDIR" && \
-	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
+	args=--unpacked
+	active=
+	if test -d "$PACKDIR"
+	then
+		for p in `find "$PACKDIR" -type f -name '*.pack' -print`
+		do
+			n=`basename "$p" .pack`
+			d=`dirname "$p"`
+			if test -e "$d/$n.keep"
+			then
+				: keep
+			else
+				args="$args --unpacked=$p"
+				active="$active $n"
+			fi
+		done
+	fi
+	if test "X$args" = X--unpacked
+	then
+		args='--unpacked --incremental'
+	fi
 	;;
 esac
 
@@ -86,20 +103,17 @@ fi
 
 if test "$remove_redundant" = t
 then
-	# We know $existing are all redundant only when
-	# all-into-one is used.
-	if test "$all_into_one" != '' && test "$existing" != ''
+	# We know $active are all redundant.
+	if test "$active" != ''
 	then
 		sync
-		( cd "$PACKDIR" &&
-		  for e in $existing
-		  do
-			case "$e" in
-			./pack-$name.pack | ./pack-$name.idx) ;;
-			*)	rm -f $e ;;
-			esac
-		  done
-		)
+		for n in $active
+		do
+			if test "$n" != "pack-$name"
+			then
+				rm -f "$PACKDIR/$n.pack" "$PACKDIR/$n.idx"
+			fi
+		done
 	fi
 	git-prune-packed
 fi
-- 
1.4.3.3.g7d63
