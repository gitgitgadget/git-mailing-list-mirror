From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] bisect: add test cases to check that "git bisect start"
 is atomic
Date: Fri, 23 May 2008 00:38:46 +0200
Message-ID: <20080523003846.0cd787b1.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 23 00:35:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzJNJ-0007UX-ME
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 00:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759268AbYEVWeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 18:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758926AbYEVWeO
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 18:34:14 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:52949 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758919AbYEVWeN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 18:34:13 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 941741AB2CC;
	Fri, 23 May 2008 00:34:11 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 5724C1AB2C3;
	Fri, 23 May 2008 00:34:11 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82663>

This patch add some test cases to check that "git bisect start"
doesn't leave us in a bad state, especially when it fails.

These test cases show that "git bisect start" is not atomic when it
fails and leave some files like ".git/BISECT_START, and in some
cases some refs, over.

The test failures should be fixed in latter commits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6030-bisect-porcelain.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 933f567..7557fa1 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -126,6 +126,49 @@ test_expect_success 'bisect reset removes packed refs' '
 	test -z "$(git for-each-ref "refs/heads/bisect")"
 '
 
+test_expect_success 'bisect start: back in good branch' '
+	git branch > branch.output &&
+	grep "* other" branch.output > /dev/null &&
+	git bisect start $HASH4 $HASH1 -- &&
+	git bisect good &&
+	git bisect start $HASH4 $HASH1 -- &&
+	git bisect bad &&
+	git bisect reset &&
+	git branch > branch.output &&
+	grep "* other" branch.output > /dev/null
+'
+
+test_expect_failure 'bisect start: no ".git/BISECT_START" if junk rev' '
+	git bisect start $HASH4 $HASH1 -- &&
+	git bisect good &&
+	test_must_fail git bisect start $HASH4 foo -- &&
+	git branch > branch.output &&
+	grep "* other" branch.output > /dev/null &&
+	test_must_fail test -e .git/BISECT_START
+'
+
+test_expect_failure 'bisect start: no ".git/BISECT_START" if mistaken rev' '
+	git bisect start $HASH4 $HASH1 -- &&
+	git bisect good &&
+	test_must_fail git bisect start $HASH1 $HASH4 -- &&
+	git branch > branch.output &&
+	grep "* other" branch.output > /dev/null &&
+	test_must_fail test -e .git/BISECT_START
+'
+
+test_expect_failure 'bisect start: no ".git/BISECT_START" if checkout error' '
+	echo "temp stuff" > hello &&
+	test_must_fail git bisect start $HASH4 $HASH1 -- &&
+	git branch &&
+	git branch > branch.output &&
+	grep "* other" branch.output > /dev/null &&
+	test_must_fail test -e .git/BISECT_START &&
+	test -z "$(git for-each-ref "refs/bisect/*")"
+'
+
+# This cleanup is needed whatever the result of the above test.
+git checkout HEAD hello
+
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3
 # but $HASH2 is bad,
 # so we should find $HASH2 as the first bad commit
-- 
1.5.5.1.501.g204d8.dirty
