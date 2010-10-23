From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] rebase-autosquash: add testcase for fixup occuring before its fixed commit.
Date: Sat, 23 Oct 2010 15:33:33 +0200
Message-ID: <1287840813-6454-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 23 15:33:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9eEG-0003k5-TQ
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 15:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916Ab0JWNdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 09:33:43 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:47114 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755579Ab0JWNdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 09:33:42 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 063C6D480D6;
	Sat, 23 Oct 2010 15:33:36 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P9eE3-0001gc-MJ; Sat, 23 Oct 2010 15:33:35 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159782>

Can easily occur when one has started splitting a patch in two, and
subsequently wants to migrate more contents from the bottom patch to the
top one: extracting a fixup using an interactive rebase, committing it
between the two.

Currently, the generated instructions do add the "fixup" directive at the
correct place, but the "pick" is also left where it was, making the "fixup"
a noop.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 t/t3415-rebase-autosquash.sh |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index fd2184c..226394d 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -50,6 +50,31 @@ test_expect_success 'auto fixup (config)' '
 	test_must_fail test_auto_fixup final-fixup-config-false
 '
 
+test_auto_fixup_reversed() {
+	git reset --hard base &&
+
+	echo 3 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "fixup! first" &&
+
+	echo 3 >file2 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "first" &&
+
+	git tag $1 &&
+	test_tick &&
+	git rebase --autosquash -i base &&
+	git log --oneline base..HEAD >actual &&
+	test 1 = $(wc -l <actual) &&
+	git diff --exit-code $1
+}
+
+test_expect_failure 'auto reversed fixup (option)' '
+	test_auto_fixup_reversed final-revfixup-option
+'
+
 test_auto_squash() {
 	git reset --hard base &&
 	echo 1 >file1 &&
-- 
1.7.2.3
