From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-checkout -m: fix merge case
Date: Tue, 23 Jan 2007 17:42:07 -0800
Message-ID: <7vtzyhkxow.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 24 02:42:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9X9S-0000KC-TJ
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 02:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100AbXAXBmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 20:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933129AbXAXBmJ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 20:42:09 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:58267 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933100AbXAXBmI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 20:42:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124014208.CMLT15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Tue, 23 Jan 2007 20:42:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id EpiS1W0011kojtg0000000; Tue, 23 Jan 2007 20:42:26 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37589>

Commit c1a4278e switched the "merging checkout" implementation
from 3-way read-tree to merge-recursive, but forgot that
merge-recursive will signal an unmerged state with its own exit
status code.  This prevented the clean-up phase (paths cleanly
merged should not be updated in the index) from running.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-checkout.sh |   15 +++++----------
 t/t7201-co.sh   |   28 +++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index e02d4d8..c52f352 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -200,17 +200,12 @@ else
 	# Match the index to the working tree, and do a three-way.
     	git diff-files --name-only | git update-index --remove --stdin &&
 	work=`git write-tree` &&
-	git read-tree --reset -u $new &&
-	eval GITHEAD_$new=${new_name:-${branch:-$new}} GITHEAD_$work=local &&
-	export GITHEAD_$new GITHEAD_$work &&
-	git merge-recursive $old -- $new $work || exit
+	git read-tree --reset -u $new || exit
 
-	if result=`git write-tree 2>/dev/null`
-	then
-	    echo >&2 "Trivially automerged."
-	else
-	    git merge-index -o git-merge-one-file -a
-	fi
+	eval GITHEAD_$new=${new_name:-${branch:-$new}} &&
+	eval GITHEAD_$work=local &&
+	export GITHEAD_$new GITHEAD_$work &&
+	git merge-recursive $old -- $new $work
 
 	# Do not register the cleanly merged paths in the index yet.
 	# this is not a real merge before committing, but just carrying
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 315fa35..867bbd2 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -100,7 +100,33 @@ test_expect_success "checkout -m with dirty tree, renamed" '
 	git checkout -m renamer &&
 	fill 1 3 4 5 7 8 >expect &&
 	diff expect uno &&
-	! test -f one
+	! test -f one &&
+	git diff --cached >current &&
+	! test -s current
+
+'
+
+test_expect_success 'checkout -m with merge conflict' '
+
+	git checkout -f master && git clean &&
+
+	fill 1 T 3 4 5 6 S 8 >one &&
+	if git checkout renamer
+	then
+		echo Not happy
+		false
+	else
+		echo "happy - failed correctly"
+	fi &&
+
+	git checkout -m renamer &&
+
+	git diff master:one :3:uno |
+	sed -e "1,/^@@/d" -e "/^ /d" -e "s/^-/d/" -e "s/^+/a/" >current &&
+	fill d2 aT d7 aS >expect &&
+	diff current expect &&
+	git diff --cached two >current &&
+	! test -s current
 '
 
 test_done
-- 
1.5.0.rc2.gd7eb
