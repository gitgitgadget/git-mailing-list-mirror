From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] rebase-autosquash: add testcase for fixup occuring before its fixed commit.
Date: Fri,  1 Oct 2010 23:19:20 +0200
Message-ID: <1285967960-17691-3-git-send-email-ydirson@altern.org>
References: <1285967960-17691-1-git-send-email-ydirson@altern.org>
 <1285967960-17691-2-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 01 23:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1mry-0003dV-R2
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 23:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504Ab0JAVJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 17:09:54 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:47324 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756414Ab0JAVJw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 17:09:52 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id AA4B5D480FB;
	Fri,  1 Oct 2010 23:09:46 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P1n0n-0004cV-T6; Fri, 01 Oct 2010 23:19:25 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1285967960-17691-2-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157782>

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
