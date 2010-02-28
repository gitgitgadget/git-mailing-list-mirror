From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: error out when passing bad path parameters
Date: Sun, 28 Feb 2010 23:19:09 +0100
Message-ID: <20100228221910.2217.70167.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:20:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlrUX-0004qI-0Z
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032115Ab0B1WTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 17:19:55 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47054 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032112Ab0B1WTy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 17:19:54 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DC032818073;
	Sun, 28 Feb 2010 23:19:47 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BEDEB8180E2;
	Sun, 28 Feb 2010 23:19:44 +0100 (CET)
X-git-sha1: 192eb18ddbe114777b052805173d33cadbbdc9aa 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141276>

As reported by Mark Lodato, "git bisect", when it was started with
path parameters that match no commit was kind of working without
taking account of path parameters and was reporting something like:

Bisecting: -1 revisions left to test after this (roughly 0 steps)

It is more correct and safer to just error out in this case, before
displaying the revisions left, so this patch does just that.

Note that this bug is very old, it exists at least since v1.5.5.
And it is possible to detect that case earlier in the bisect
algorithm, but it is not clear that it would be an improvement to
error out earlier, on the contrary it may change the behavior of
"git rev-list --bisect-all" for example, which is currently correct.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c                    |    6 ++++++
 t/t6030-bisect-porcelain.sh |    5 +++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6dc27ee..b556b11 100644
--- a/bisect.c
+++ b/bisect.c
@@ -986,6 +986,12 @@ int bisect_next_all(const char *prefix)
 		exit(1);
 	}
 
+	if (!all) {
+		fprintf(stderr, "No testable commit found.\n"
+			"Maybe you started with bad path parameters?\n");
+		exit(4);
+	}
+
 	bisect_rev = revs.commits->item->object.sha1;
 	memcpy(bisect_rev_hex, sha1_to_hex(bisect_rev), 41);
 
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index c51865f..3b042aa 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -567,6 +567,11 @@ test_expect_success 'skipping away from skipped commit' '
 	test "$para3" = "$PARA_HASH3"
 '
 
+test_expect_success 'erroring out when using bad path parameters' '
+	test_must_fail git bisect start $PARA_HASH7 $HASH1 -- foobar 2> error.txt &&
+	grep "bad path parameters" error.txt
+'
+
 #
 #
 test_done
-- 
1.7.0.321.g2d270
