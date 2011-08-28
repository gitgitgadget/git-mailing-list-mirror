From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t3005: do not assume a particular order of stdout and stderr
 of git-ls-files
Date: Sun, 28 Aug 2011 09:34:56 +0200
Message-ID: <4E59EFA0.7020209@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 09:35:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxZti-0005Zh-Ul
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 09:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222Ab1H1HfC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 03:35:02 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:52189 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750951Ab1H1HfA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 03:35:00 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C64B013004A;
	Sun, 28 Aug 2011 09:34:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2466519F380;
	Sun, 28 Aug 2011 09:34:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180261>

There is no guarantee that stderr is flushed before stdout when both
channels are redirected to a file. Check the channels using independent
files.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3005-ls-files-relative.sh |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
index a2b63e2..3778694 100755
--- a/t/t3005-ls-files-relative.sh
+++ b/t/t3005-ls-files-relative.sh
@@ -45,11 +45,12 @@ test_expect_success 'ls-files -c' '
 		for f in ../y*
 		do
 			echo "error: pathspec $sq$f$sq did not match any file(s) known to git."
-		done >expect &&
-		echo "Did you forget to ${sq}git add${sq}?" >>expect &&
-		ls ../x* >>expect &&
-		test_must_fail git ls-files -c --error-unmatch ../[xy]* >actual 2>&1 &&
-		test_cmp expect actual
+		done >expect.err &&
+		echo "Did you forget to ${sq}git add${sq}?" >>expect.err &&
+		ls ../x* >expect.out &&
+		test_must_fail git ls-files -c --error-unmatch ../[xy]* >actual.out 2>actual.err &&
+		test_cmp expect.out actual.out &&
+		test_cmp expect.err actual.err
 	)
 '
 
@@ -59,11 +60,12 @@ test_expect_success 'ls-files -o' '
 		for f in ../x*
 		do
 			echo "error: pathspec $sq$f$sq did not match any file(s) known to git."
-		done >expect &&
-		echo "Did you forget to ${sq}git add${sq}?" >>expect &&
-		ls ../y* >>expect &&
-		test_must_fail git ls-files -o --error-unmatch ../[xy]* >actual 2>&1 &&
-		test_cmp expect actual
+		done >expect.err &&
+		echo "Did you forget to ${sq}git add${sq}?" >>expect.err &&
+		ls ../y* >expect.out &&
+		test_must_fail git ls-files -o --error-unmatch ../[xy]* >actual.out 2>actual.err &&
+		test_cmp expect.out actual.out &&
+		test_cmp expect.err actual.err
 	)
 '
 
-- 
1.7.7.rc0.92.g0cd2b
