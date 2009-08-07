From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] rebase -i: use "git sequencer--helper --fast-forward"
Date: Fri, 07 Aug 2009 22:40:53 +0200
Message-ID: <20090807204054.6280.39494.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 22:49:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZWNa-0007QS-TR
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 22:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbZHGUtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 16:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbZHGUtU
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 16:49:20 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:55743 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460AbZHGUtS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 16:49:18 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 07183818120;
	Fri,  7 Aug 2009 22:49:10 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B82408180D1;
	Fri,  7 Aug 2009 22:49:07 +0200 (CEST)
X-git-sha1: 16b77e8584bb3814c3c073c27bc0ff4a1183a669 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125223>

when fast forwarding.

Note that in the first hunk of this patch, there was this line:

test "a$1" = a-n && output git reset --soft $current_sha1

but the test always failed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

	The test "a$1" = a-n fails because if "$1" is set to "-n"
	then "$no_ff" is set to "t" above by:

	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac

	and that means that:

	test "$no_ff$current_sha1" = "$parent_sha1"

	will fail.

	But maybe I missed something. Otherwise I can send a patch
	for master to remove the dead code. 

 git-rebase--interactive.sh |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0041994..7651fd6 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -154,11 +154,8 @@ pick_one () {
 		die "Could not get the parent of $sha1"
 	current_sha1=$(git rev-parse --verify HEAD)
 	if test "$no_ff$current_sha1" = "$parent_sha1"; then
-		git sequencer--helper --reset-hard $sha1 \
+		git sequencer--helper --fast-forward $sha1 \
 			"$GIT_REFLOG_ACTION" "$VERBOSE"
-		test "a$1" = a-n && output git reset --soft $current_sha1
-		sha1=$(git rev-parse --short $sha1)
-		output warn Fast forward to $sha1
 	else
 		output git cherry-pick "$@"
 	fi
@@ -238,10 +235,8 @@ pick_one_preserving_merges () {
 	done
 	case $fast_forward in
 	t)
-		output warn "Fast forward to $sha1"
-		git sequencer--helper --reset-hard $sha1 \
-			"$GIT_REFLOG_ACTION" "$VERBOSE" ||
-			die "Cannot fast forward to $sha1"
+		git sequencer--helper --fast-forward $sha1 \
+			"$GIT_REFLOG_ACTION" "$VERBOSE" || exit
 		;;
 	f)
 		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
-- 
1.6.4.209.g16b77
