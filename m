From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t3505: fix abuse of test_expect_code
Date: Sun, 21 Jun 2009 02:14:17 -0700
Message-ID: <7v7hz6t0d2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 11:55:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIJld-0003HI-Jy
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 11:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbZFUJzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 05:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753203AbZFUJy7
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 05:54:59 -0400
Received: from fed1rmmtai106.cox.net ([68.230.241.54]:54680 "EHLO
	fed1rmmtai106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbZFUJy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 05:54:58 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090621091421.IJUN2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Sun, 21 Jun 2009 05:14:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 6ZEJ1c0014aMwMQ04ZEMzS; Sun, 21 Jun 2009 05:14:21 -0400
X-VR-Score: -20.00
X-Authority-Analysis: v=1.0 c=1 a=e4e2083Et84A:10 a=ybZZDoGAAAAA:8
 a=8dtxDd-mniZWJeb_h6YA:9 a=Z3SfWXGswb4F4Qkv9bIA:7
 a=D0r62N36KXccEmeku5B3u-BPALAA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121981>

The test wanted to make sure that cherry-pick exits with status 1,
but with the way it was placed after "git checkout master &&" meant
that it could have misjudged success if checkout barfed with the
same failure status.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Besides, /bin/sh (but not bash) on FreeBSD 7.2 does not seem to
   evaluate "a && b" fed to test_expect_code correctly for me (eval_ret=0
   for some reason, even though cherry-pick was failing), and this patch
   incidentally fixes that issue.

 t/t3505-cherry-pick-empty.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index 9aaeabd..e51e505 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -17,11 +17,11 @@ test_expect_success setup '
 
 '
 
-test_expect_code 1 'cherry-pick an empty commit' '
-
-	git checkout master &&
-	git cherry-pick empty-branch
-
+test_expect_success 'cherry-pick an empty commit' '
+	git checkout master && {
+		git cherry-pick empty-branch
+		test "$?" = 1
+	}
 '
 
 test_expect_success 'index lockfile was removed' '
