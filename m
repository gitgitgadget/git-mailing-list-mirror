From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 9/9] rebase -i: use "git sequencer--helper --cherry-pick"
Date: Fri, 21 Aug 2009 07:50:00 +0200
Message-ID: <20090821055001.3726.52566.chriscool@tuxfamily.org>
References: <20090821054729.3726.5078.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 07:56:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeN6d-0001bm-61
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 07:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbZHUFz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 01:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbZHUFzz
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 01:55:55 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56410 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225AbZHUFzt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 01:55:49 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 59DCF818122;
	Fri, 21 Aug 2009 07:55:39 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 24566818120;
	Fri, 21 Aug 2009 07:55:37 +0200 (CEST)
X-git-sha1: 769c526b07e06c984603bb1aecdffbbbd1165c6b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090821054729.3726.5078.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126686>

instead of "git cherry-pick", as this will make it easier to
port "git-rebase--interactive.sh" to C.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-rebase--interactive.sh |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7651fd6..349ca50 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -147,7 +147,8 @@ pick_one () {
 		pick_one_preserving_merges "$@" && return
 	if test ! -z "$REBASE_ROOT"
 	then
-		output git cherry-pick "$@"
+		git sequencer--helper --cherry-pick $sha1 \
+			"$GIT_REFLOG_ACTION" "$VERBOSE" $no_ff
 		return
 	fi
 	parent_sha1=$(git rev-parse --verify $sha1^) ||
@@ -157,7 +158,8 @@ pick_one () {
 		git sequencer--helper --fast-forward $sha1 \
 			"$GIT_REFLOG_ACTION" "$VERBOSE"
 	else
-		output git cherry-pick "$@"
+		git sequencer--helper --cherry-pick $sha1 \
+			"$GIT_REFLOG_ACTION" "$VERBOSE" $no_ff
 	fi
 }
 
@@ -269,7 +271,10 @@ pick_one_preserving_merges () {
 			fi
 			;;
 		*)
-			output git cherry-pick "$@" ||
+			no_commit=
+			test "a$1" = "a-n" && no_commit=t
+			git sequencer--helper --cherry-pick $sha1 \
+				"$GIT_REFLOG_ACTION" "$VERBOSE" $no_commit ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
 		esac
-- 
1.6.4.271.ge010d
