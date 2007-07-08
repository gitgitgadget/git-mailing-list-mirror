From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-stash: try reusing cached stat info as much as possible
Date: Sun, 08 Jul 2007 11:43:04 -0700
Message-ID: <7vvecu20uf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 08 20:43:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7biy-0001WB-Ho
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 20:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371AbXGHSnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 14:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756339AbXGHSnI
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 14:43:08 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41126 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965AbXGHSnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 14:43:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708184305.VEJB17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 14:43:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id M6j41X00G1kojtg0000000; Sun, 08 Jul 2007 14:43:05 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51905>

Earlier when we read a tree into a temporary index, we read it
from scratch.  Start from the current index and use read-tree -m
to preserve cached stat information as much as possible, in
order to speed up "git add -u".  This makes "git stash" usable
in a source tree of nontrivial size.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index eac5551..de13dd1 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -58,11 +58,11 @@ save_stash () {
 
 	# state of the working tree
 	w_tree=$( (
+		rm -f "$TMP-index" &&
+		cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
 		GIT_INDEX_FILE="$TMP-index" &&
 		export GIT_INDEX_FILE &&
-
-		rm -f "$TMP-index" &&
-		git read-tree $i_tree &&
+		git read-tree -m $i_tree &&
 		git add -u &&
 		git write-tree &&
 		rm -f "$TMP-index"
-- 
1.5.3.rc0.858.gd08b
