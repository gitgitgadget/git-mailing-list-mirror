From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] git-stash apply --index: optimize postprocessing
Date: Sat, 28 Jul 2007 00:02:39 -0700
Message-ID: <7vy7h1t3hs.fsf@assigned-by-dhcp.cox.net>
References: <7vbqdxui72.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 09:02:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEgK8-0004hT-9V
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 09:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293AbXG1HCm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 03:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757066AbXG1HCm
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 03:02:42 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:38023 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457AbXG1HCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 03:02:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728070241.PDZP8237.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 03:02:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Uv2g1X0091kojtg0000000; Sat, 28 Jul 2007 03:02:40 -0400
In-Reply-To: <7vbqdxui72.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 27 Jul 2007 23:59:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53999>

Originally, "apply --index" codepath was bolted on to the
"update working tree files and index, but then revert the
changes we make to the index except for added files so that we
do not forget about them" codepath, almost as an afterthought.
Because "apply --index" first prepares the final index state
upfront, "revert except the added paths" postprocessing does not
have to be done.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 873e7be..30425ce 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -157,15 +157,16 @@ apply_stash () {
 	if git-merge-recursive $b_tree -- $c_tree $w_tree
 	then
 		# No conflict
-		a="$TMP-added" &&
-		git diff --cached --name-only --diff-filter=A $c_tree >"$a" &&
-		git read-tree --reset $c_tree &&
-		git update-index --add --stdin <"$a" ||
-			die "Cannot unstage modified files"
-		rm -f "$a"
 		if test -n "$unstashed_index_tree"
 		then
 			git read-tree "$unstashed_index_tree"
+		else
+			a="$TMP-added" &&
+			git diff --cached --name-only --diff-filter=A $c_tree >"$a" &&
+			git read-tree --reset $c_tree &&
+			git update-index --add --stdin <"$a" ||
+				die "Cannot unstage modified files"
+			rm -f "$a"
 		fi
 		git status || :
 	else
-- 
1.5.3.rc3.16.g9f04-dirty
