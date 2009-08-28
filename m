From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 15/15] rebase -i: use "git sequencer--helper --cherry-pick"
Date: Fri, 28 Aug 2009 06:47:45 +0200
Message-ID: <20090828044746.4307.98469.chriscool@tuxfamily.org>
References: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 07:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgtZj-0006Ec-GK
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 07:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbZH1E7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 00:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbZH1E7V
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 00:59:21 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49762 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833AbZH1E7R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 00:59:17 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E98D6818093;
	Fri, 28 Aug 2009 06:59:06 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D8EAD8180F2;
	Fri, 28 Aug 2009 06:59:03 +0200 (CEST)
X-git-sha1: 0148640fdae478654ba13ba9b8768ba06ae355b0 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127260>

instead of "git cherry-pick", as this will make it easier to
port "git-rebase--interactive.sh" to C.

This is because we will be able to use the "do_cherry_pick()" added
by a previous patch.

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
