From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/7] t5528-push-default.sh: add helper functions
Date: Mon, 23 Apr 2012 10:38:00 +0200
Message-ID: <1335170284-30768-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 23 10:38:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMEnF-00034n-6q
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 10:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334Ab2DWIif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 04:38:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58261 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754321Ab2DWIie (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 04:38:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3N8Vf0A025762
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2012 10:31:42 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMEmd-0004ms-P6; Mon, 23 Apr 2012 10:38:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMEmd-00081V-NT; Mon, 23 Apr 2012 10:38:07 +0200
X-Mailer: git-send-email 1.7.10.234.ge65dd.dirty
In-Reply-To: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 23 Apr 2012 10:31:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3N8Vf0A025762
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335774707.4547@Q8NwXP1vmFitAiQlyK8kEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196101>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t5528-push-default.sh |   45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index c334c51..da7d3d8 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -13,16 +13,47 @@ test_expect_success 'setup bare remotes' '
 	git push parent2 HEAD
 '
 
+# $1 = local revision
+# $2 = remote revision (tested to be equal to the local one)
+check_pushed_commit () {
+	git log -1 --format='%h %s' >expect &&
+	git --git-dir=repo1 log -1 --format='%h %s' "$2" >actual &&
+	test_cmp expect actual
+}
+
+# $1 = push.default value
+# $2 = expected target branch for the push
+test_push_success () {
+	git -c push.default="$1" push &&
+	check_pushed_commit HEAD "$2"
+}
+
+# $1 = push.default value
+# other arguments = target branches that should not be touched
+test_push_failure () {
+	push_default=$1 &&
+	shift &&
+	if test $# -gt 0
+	then
+		# branch may not exist
+		test_might_fail git --git-dir=repo1 \
+			log --no-walk --format='%h %s' "$@" >expect
+	fi &&
+	test_must_fail git -c push.default="$1" &&
+	if test $# -gt 0
+	then
+		test_might_fail git --git-dir=repo1 \
+			log -1 --format='%h %s' "$@" >actual
+	fi &&
+	test_cmp expect actual
+}
+
 test_expect_success '"upstream" pushes to configured upstream' '
 	git checkout master &&
 	test_config branch.master.remote parent1 &&
 	test_config branch.master.merge refs/heads/foo &&
-	test_config push.default upstream &&
 	test_commit two &&
-	git push &&
-	echo two >expect &&
-	git --git-dir=repo1 log -1 --format=%s foo >actual &&
-	test_cmp expect actual
+	test_push_success upstream foo
 '
 
 test_expect_success '"upstream" does not push on unconfigured remote' '
@@ -30,7 +61,7 @@ test_expect_success '"upstream" does not push on unconfigured remote' '
 	test_unconfig branch.master.remote &&
 	test_config push.default upstream &&
 	test_commit three &&
-	test_must_fail git push
+	test_push_failure upstream master
 '
 
 test_expect_success '"upstream" does not push on unconfigured branch' '
@@ -39,7 +70,7 @@ test_expect_success '"upstream" does not push on unconfigured branch' '
 	test_unconfig branch.master.merge &&
 	test_config push.default upstream
 	test_commit four &&
-	test_must_fail git push
+	test_push_failure upstream master
 '
 
 test_expect_success '"upstream" does not push when remotes do not match' '
-- 
1.7.10.234.ge65dd.dirty
