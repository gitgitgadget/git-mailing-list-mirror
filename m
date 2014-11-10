From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t1410: Fix for case insensitive filesystems
Date: Sun,  9 Nov 2014 20:48:06 -0500
Message-ID: <1415584086-41637-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 02:56:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XneD3-00088X-UF
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 02:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbaKJBz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 20:55:57 -0500
Received: from silverinsanity.com ([173.255.236.87]:54807 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbaKJBz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 20:55:56 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Nov 2014 20:55:56 EST
Received: by silverinsanity.com (Postfix, from userid 110)
	id 6C8D21A72B; Mon, 10 Nov 2014 01:48:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on silverinsanity.com
X-Spam-Status: No, score=-2.9 required=3.5 tests=ALL_TRUSTED,BAYES_00,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Level: 
Received: from localhost.localdomain (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	by silverinsanity.com (Postfix) with ESMTPSA id 7EADA1A726;
	Mon, 10 Nov 2014 01:48:17 +0000 (UTC)
X-Mailer: git-send-email 2.2.0.rc0.209.g31b9a22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A pair of recently added tests used branches a and a/b, but earlier
tests created files A and A/B.  On case insensitive filesystems (such
as HFS+), that causes git to complain about the name being ambiguous
between branch and file.  Resolve by renaming the branches to aa and
aa/bb.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t1410-reflog.sh | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 976c1d4..ac31e19 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -254,36 +254,36 @@ test_expect_success 'checkout should not delete log for packed ref' '
 '
 
 test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
-	test_when_finished "git branch -d a || git branch -d a/b" &&
+	test_when_finished "git branch -d aa || git branch -d aa/bb" &&
 
-	git branch a/b master &&
-	echo "a/b@{0} branch: Created from master" >expect &&
-	git log -g --format="%gd %gs" a/b >actual &&
+	git branch aa/bb master &&
+	echo "aa/bb@{0} branch: Created from master" >expect &&
+	git log -g --format="%gd %gs" aa/bb >actual &&
 	test_cmp expect actual &&
-	git branch -d a/b &&
+	git branch -d aa/bb &&
 
-	# now logs/refs/heads/a is a stale directory, but
-	# we should move it out of the way to create "a" reflog
-	git branch a master &&
-	echo "a@{0} branch: Created from master" >expect &&
-	git log -g --format="%gd %gs" a >actual &&
+	# now logs/refs/heads/aa is a stale directory, but
+	# we should move it out of the way to create "aa" reflog
+	git branch aa master &&
+	echo "aa@{0} branch: Created from master" >expect &&
+	git log -g --format="%gd %gs" aa >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
-	test_when_finished "git branch -d a || git branch -d a/b" &&
+	test_when_finished "git branch -d aa || git branch -d aa/bb" &&
 
-	git branch a/b master &&
-	echo "a/b@{0} branch: Created from master" >expect &&
-	git log -g --format="%gd %gs" a/b >actual &&
+	git branch aa/bb master &&
+	echo "aa/bb@{0} branch: Created from master" >expect &&
+	git log -g --format="%gd %gs" aa/bb >actual &&
 	test_cmp expect actual &&
-	git branch -d a/b &&
+	git branch -d aa/bb &&
 
-	# same as before, but we only create a reflog for "a" if
+	# same as before, but we only create a reflog for "aa" if
 	# it already exists, which it does not
-	git -c core.logallrefupdates=false branch a master &&
+	git -c core.logallrefupdates=false branch aa master &&
 	: >expect &&
-	git log -g --format="%gd %gs" a >actual &&
+	git log -g --format="%gd %gs" aa >actual &&
 	test_cmp expect actual
 '
 
-- 
2.2.0.rc0.209.g31b9a22
