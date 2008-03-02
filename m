From: drafnel@gmail.com
Subject: [PATCH 4/4] t3903-stash.sh: Add tests for new stash commands drop and pop
Date: Sun,  2 Mar 2008 14:58:51 -0600
Message-ID: <4655498.1204491512711.JavaMail.teamon@b308.teamon.com>
References: <1204491531-29758-1-git-send-email-drafnel@gmail.com>
 <1204491531-29758-2-git-send-email-drafnel@gmail.com>
 <1204491531-29758-3-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 02 22:13:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVvVH-0004De-3b
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 22:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442AbYCBVMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 16:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756663AbYCBVMy
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 16:12:54 -0500
Received: from www.teamon.com ([216.34.91.250]:39862 "EHLO b308.teamon.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756442AbYCBVMv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 16:12:51 -0500
X-Greylist: delayed 822 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Mar 2008 16:12:47 EST
Received: from b308.teamon.com (localhost [127.0.0.1])
	by b308.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m22KwW022457;
	Sun, 2 Mar 2008 20:58:32 GMT
X-Mailer: git-send-email 1.5.4.3.412.gcd100
In-Reply-To: <1204491531-29758-3-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75841>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t3903-stash.sh |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2418f47..90a68a1 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -70,7 +70,51 @@ test_expect_success 'unstashing in a subdirectory' '
 	git reset --hard HEAD &&
 	mkdir subdir &&
 	cd subdir &&
-	git stash apply
+	git stash apply &&
+	cd ..
+'
+
+test_expect_success 'drop top stash' '
+	git reset --hard &&
+	git stash list > stashlist1 &&
+	echo 7 > file &&
+	git stash &&
+	git stash drop &&
+	git stash list > stashlist2 &&
+	diff stashlist1 stashlist2 &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
+test_expect_success 'drop middle stash' '
+	git reset --hard &&
+	echo 8 > file &&
+	git stash &&
+	echo 9 > file &&
+	git stash &&
+	git stash drop stash@{1} &&
+	test 2 = $(git stash list | wc -l) &&
+	git stash apply &&
+	test 9 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file) &&
+	git reset --hard &&
+	git stash drop &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
+test_expect_success 'stash pop' '
+	git reset --hard &&
+	git stash pop &&
+	test 3 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file) &&
+	test 0 = $(git stash list | wc -l)
 '
 
 test_done
-- 
1.5.4.3.412.gcd100

