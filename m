From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect reset: do nothing when not bisecting.
Date: Tue, 20 Nov 2007 06:39:53 +0100
Message-ID: <20071120063953.06a3d47e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 06:33:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuLjo-0003LK-JX
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 06:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbXKTFdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 00:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754769AbXKTFdO
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 00:33:14 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:48478 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755338AbXKTFdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 00:33:14 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id EA99A1AB2C4;
	Tue, 20 Nov 2007 06:33:12 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id BB51D1AB2BB;
	Tue, 20 Nov 2007 06:33:12 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65526>

Before this patch, using "git bisect reset" when not bisecting
did a "git checkout master" for no good reason.

This also happened using "git bisect replay" when not bisecting
because "bisect_replay" starts by calling "bisect_reset".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |    4 ++++
 t/t6030-bisect-porcelain.sh |   27 ++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 01593eb..7a6521e 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -329,6 +329,10 @@ bisect_visualize() {
 }
 
 bisect_reset() {
+	test -f "$GIT_DIR/BISECT_NAMES" || {
+		echo "We are not bisecting."
+		return
+	}
 	case "$#" in
 	0) if [ -s "$GIT_DIR/head-name" ]; then
 	       branch=`cat "$GIT_DIR/head-name"`
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index f09db62..2ba4b00 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -71,6 +71,31 @@ test_expect_success 'bisect start with one bad and good' '
 	git bisect next
 '
 
+test_expect_success 'bisect reset: back in the master branch' '
+	git bisect reset &&
+	echo "* master" > branch.expect &&
+	git branch > branch.output &&
+	cmp branch.expect branch.output
+'
+
+test_expect_success 'bisect reset: back in another branch' '
+	git checkout -b other &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH3 &&
+	git bisect reset &&
+	echo "  master" > branch.expect &&
+	echo "* other" >> branch.expect &&
+	git branch > branch.output &&
+	cmp branch.expect branch.output
+'
+
+test_expect_success 'bisect reset when not bisecting' '
+	git bisect reset &&
+	git branch > branch.output &&
+	cmp branch.expect branch.output
+'
+
 test_expect_success 'bisect reset removes packed refs' '
 	git bisect reset &&
 	git bisect start &&
@@ -179,7 +204,7 @@ test_expect_success 'bisect skip: add line and then a new test' '
 	git bisect skip &&
 	git bisect good > my_bisect_log.txt &&
 	grep "$HASH5 is first bad commit" my_bisect_log.txt &&
-	git bisect log > log_to_replay.txt
+	git bisect log > log_to_replay.txt &&
 	git bisect reset
 '
 
-- 
1.5.3.5.1816.g0b82e-dirty
