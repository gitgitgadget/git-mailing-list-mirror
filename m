From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-bisect: do not get confused by packed-ref
Date: Thu, 26 Jul 2007 23:50:06 -0700
Message-ID: <7v1weu49y9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 08:50:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEJeh-0005Fx-RP
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 08:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbXG0GuJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 02:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758276AbXG0GuJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 02:50:09 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:56683 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756591AbXG0GuI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 02:50:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727065005.IPK1358.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Jul 2007 02:50:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UWq61X00Q1kojtg0000000; Fri, 27 Jul 2007 02:50:07 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53902>

If an unfortunate user runs a pack-ref while a git-bisect is
active, refs/bisect/* references will stay behind even after the
git-bisect finishes, because the clean-up code only paid
attention to loose refs.  This has a potential to confuse later
bisect runs greatly.

Ideally we should further fix parts that manually creates the
good references refs/bisect/good-*, and updates bad reference
refs/bisect/bad, but that is a cleanliness not correctness
issue.  For 1.5.3, this minimum fix should do.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-bisect.sh |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 388887a..77dad51 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -265,8 +265,16 @@ bisect_reset() {
 }
 
 bisect_clean_state() {
+	git for-each-ref --format='%(objectname) %(refname)' refs/bisect |
+	while read sha1 ref
+	do
+		git update-ref -d "$ref" "$sha1"
+	done
+	if current=$(git rev-parse --verify refs/heads/bisect 2>/dev/null)
+	then
+		git update-ref -d refs/heads/bisect "$current"
+	fi
 	rm -fr "$GIT_DIR/refs/bisect"
-	rm -f "$GIT_DIR/refs/heads/bisect"
 	rm -f "$GIT_DIR/BISECT_LOG"
 	rm -f "$GIT_DIR/BISECT_NAMES"
 	rm -f "$GIT_DIR/BISECT_RUN"
