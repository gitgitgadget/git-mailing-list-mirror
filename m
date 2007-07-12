From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix git-rebase -i to allow squashing of fast-forwardable commits
Date: Fri, 13 Jul 2007 00:30:35 +0200
Message-ID: <20070712223035.GB30532@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 00:30:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I97BJ-0000Xh-CL
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 00:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772AbXGLWai (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 18:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758793AbXGLWai
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 18:30:38 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:44283 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758349AbXGLWah (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 18:30:37 -0400
Received: from tigra.home (Fc891.f.strato-dslnet.de [195.4.200.145])
	by post.webmailer.de (mrclete mo14) (RZmta 8.3)
	with ESMTP id d001d9j6CIF7Zx ; Fri, 13 Jul 2007 00:30:36 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 100DC277BD;
	Fri, 13 Jul 2007 00:30:36 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E3F36C164; Fri, 13 Jul 2007 00:30:35 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+bxu8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52341>

Without this change the commits will be left standalone, with
duplicated commit message.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Noticed when trying to blend the second commit in a branch into the
first. Squash didn't work at all (apart from commit message
duplication).

 git-rebase--interactive.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d9563ec..f395076 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -84,6 +84,7 @@ pick_one () {
 	current_sha1=$(git rev-parse --verify HEAD)
 	if [ $current_sha1 = $parent_sha1 ]; then
 		git reset --hard $sha1
+		test "a$1" = a-n && git reset --soft $current_sha1
 		sha1=$(git rev-parse --short $sha1)
 		warn Fast forward to $sha1
 	else
@@ -193,14 +194,14 @@ do_next () {
 			die "Cannot 'squash' without a previous commit"
 
 		mark_action_done
-		failed=f
-		pick_one -n $sha1 || failed=t
 		MSG="$DOTEST"/message
 		echo "# This is a combination of two commits." > "$MSG"
 		echo "# The first commit's message is:" >> "$MSG"
 		echo >> "$MSG"
 		git cat-file commit HEAD | sed -e '1,/^$/d' >> "$MSG"
 		echo >> "$MSG"
+		failed=f
+		pick_one -n $sha1 || failed=t
 		echo "# And this is the 2nd commit message:" >> "$MSG"
 		echo >> "$MSG"
 		git cat-file commit $sha1 | sed -e '1,/^$/d' >> "$MSG"
-- 
1.5.3.rc0.116.gc35c1-dirty
