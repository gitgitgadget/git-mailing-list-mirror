From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 9/9] git-status: adjust tests
Date: Sat, 15 Aug 2009 15:39:57 -0700
Message-ID: <1250375997-10657-10-git-send-email-gitster@pobox.com>
References: <1250375997-10657-1-git-send-email-gitster@pobox.com>
 <1250375997-10657-2-git-send-email-gitster@pobox.com>
 <1250375997-10657-3-git-send-email-gitster@pobox.com>
 <1250375997-10657-4-git-send-email-gitster@pobox.com>
 <1250375997-10657-5-git-send-email-gitster@pobox.com>
 <1250375997-10657-6-git-send-email-gitster@pobox.com>
 <1250375997-10657-7-git-send-email-gitster@pobox.com>
 <1250375997-10657-8-git-send-email-gitster@pobox.com>
 <1250375997-10657-9-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 00:40:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McRve-0003is-Oo
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 00:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbZHOWkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 18:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbZHOWkV
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 18:40:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbZHOWkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 18:40:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 846772AA8E
	for <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C7F442AA8D for
 <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:18 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.227.g1d720
In-Reply-To: <1250375997-10657-9-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9C4A4DC0-89EC-11DE-9724-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126042>

There are some tests that expect "git status" to exit with non-zero status
when there is something staged.  Some tests expect "git status path..." to
show the status for a partial commit.

For these, replace "git status" with "git commit --dry-run".  For the
ones that do not attempt a dry-run of a partial commit that check the
output from the command, check the output from "git status" as well, as
they should be identical.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Kept separate for easier review; shows the extent of damage from the
   change in semantics rather well.

 t/t6040-tracking-info.sh    |    2 +-
 t/t7060-wtstatus.sh         |    8 +++++---
 t/t7506-status-submodule.sh |    6 +++---
 t/t7508-status.sh           |   12 +++++++-----
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 00e1de9..664b0f8 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -69,7 +69,7 @@ test_expect_success 'status' '
 		cd test &&
 		git checkout b1 >/dev/null &&
 		# reports nothing to commit
-		test_must_fail git status
+		test_must_fail git commit --dry-run
 	) >actual &&
 	grep "have 1 and 1 different" actual
 '
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 1044aa6..7b5db80 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -50,9 +50,11 @@ test_expect_success 'M/D conflict does not segfault' '
 		git rm foo &&
 		git commit -m delete &&
 		test_must_fail git merge master &&
-		test_must_fail git status > ../actual
-	) &&
-	test_cmp expect actual
+		test_must_fail git commit --dry-run >../actual &&
+		test_cmp ../expect ../actual &&
+		git status >../actual &&
+		test_cmp ../expect ../actual
+	)
 '
 
 test_done
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d9a08aa..3ca17ab 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -19,8 +19,8 @@ test_expect_success 'status clean' '
 	git status |
 	grep "nothing to commit"
 '
-test_expect_success 'status -a clean' '
-	git status -a |
+test_expect_success 'commit --dry-run -a clean' '
+	git commit --dry-run -a |
 	grep "nothing to commit"
 '
 test_expect_success 'rm submodule contents' '
@@ -31,7 +31,7 @@ test_expect_success 'status clean (empty submodule dir)' '
 	grep "nothing to commit"
 '
 test_expect_success 'status -a clean (empty submodule dir)' '
-	git status -a |
+	git commit --dry-run -a |
 	grep "nothing to commit"
 '
 
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 93f875f..1173dbb 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -248,8 +248,8 @@ cat <<EOF >expect
 #	output
 #	untracked
 EOF
-test_expect_success 'status of partial commit excluding new file in index' '
-	git status dir1/modified >output &&
+test_expect_success 'dry-run of partial commit excluding new file in index' '
+	git commit --dry-run dir1/modified >output &&
 	test_cmp expect output
 '
 
@@ -358,7 +358,9 @@ EOF
 test_expect_success 'status submodule summary (clean submodule)' '
 	git commit -m "commit submodule" &&
 	git config status.submodulesummary 10 &&
-	test_must_fail git status >output &&
+	test_must_fail git commit --dry-run >output &&
+	test_cmp expect output &&
+	git status >output &&
 	test_cmp expect output
 '
 
@@ -391,9 +393,9 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success 'status submodule summary (--amend)' '
+test_expect_success 'commit --dry-run submodule summary (--amend)' '
 	git config status.submodulesummary 10 &&
-	git status --amend >output &&
+	git commit --dry-run --amend >output &&
 	test_cmp expect output
 '
 
-- 
1.6.4.224.g3be84
