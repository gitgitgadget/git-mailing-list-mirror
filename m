From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] Bisect reset: remove bisect refs that may have been
 packed.
Date: Thu, 15 Nov 2007 08:18:07 +0100
Message-ID: <20071115081807.06fe092b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 08:12:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsYtg-0000zT-P2
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 08:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764967AbXKOHL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 02:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933897AbXKOHL0
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 02:11:26 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:49355 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933940AbXKOHLY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 02:11:24 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3A26E1AB2E4;
	Thu, 15 Nov 2007 08:11:23 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 0266F1AB2C8;
	Thu, 15 Nov 2007 08:11:22 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65074>

If refs were ever packed in the middle of bisection, the bisect
refs were not removed from the "packed-refs" file.

This patch fixes this problem by using "git update-ref -d $ref $hash"
in "bisect_clean_state".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |   11 ++++++++++-
 t/t6030-bisect-porcelain.sh |   12 ++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)

	Ooops, there was a problem with the previous patch
	if "git bisect reset" was used when not bisecting.

	Sorry.

diff --git a/git-bisect.sh b/git-bisect.sh
index 1ed44e5..584906f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -351,7 +351,16 @@ bisect_reset() {
 
 bisect_clean_state() {
 	rm -fr "$GIT_DIR/refs/bisect"
-	rm -f "$GIT_DIR/refs/heads/bisect"
+
+	# There may be some refs packed during bisection.
+	git for-each-ref --format='%(refname) %(objectname)' \
+		"refs/bisect/*" | while read ref hash
+	do
+		git update-ref -d $ref $hash
+	done
+
+	hash=$(git show-ref --hash refs/heads/bisect)
+	test -n "$hash" && git update-ref -d refs/heads/bisect $hash
 	rm -f "$GIT_DIR/BISECT_LOG"
 	rm -f "$GIT_DIR/BISECT_NAMES"
 	rm -f "$GIT_DIR/BISECT_RUN"
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 53956c0..f09db62 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -71,6 +71,18 @@ test_expect_success 'bisect start with one bad and good' '
 	git bisect next
 '
 
+test_expect_success 'bisect reset removes packed refs' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH3 &&
+	git pack-refs --all --prune &&
+	git bisect next &&
+	git bisect reset &&
+	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	test -z "$(git for-each-ref "refs/heads/bisect")"
+'
+
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3
 # but $HASH2 is bad,
 # so we should find $HASH2 as the first bad commit
-- 
1.5.3.5.722.g789fd-dirty
