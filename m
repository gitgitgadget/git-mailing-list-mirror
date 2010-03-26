From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t0005: add test for trap handling from deeply nested function calls
Date: Fri, 26 Mar 2010 11:34:05 -0500
Message-ID: <vm2zHZjrZOha7LnIM_9fAEAvwVZrJtZlAI9f2XI_VUsdqr51ihAMW68a5BT9tvMdRDSqk6GYlSE@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 26 17:44:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvCdp-0001zA-Qv
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 17:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664Ab0CZQoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 12:44:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54945 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab0CZQoH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 12:44:07 -0400
Received: by mail.nrlssc.navy.mil id o2QGYGVB028751; Fri, 26 Mar 2010 11:34:16 -0500
X-OriginalArrivalTime: 26 Mar 2010 16:34:15.0967 (UTC) FILETIME=[2CDB2AF0:01CACD02]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143259>

From: Brandon Casey <drafnel@gmail.com>

The /usr/xpg4/bin/sh shell on Solaris only executes a trap handler set
within a function from the first-level function call made from within the
function that set the trap.  In other words, if func1 sets a trap, then
calls func2 which triggers the trap, then the trap handler will be executed
correctly.  If instead of exiting, func2 calls func3, and func3 satisfies
the conditions for triggering the trap, the trap handler will NOT be
executed.

This trap sequence exists in git-bisect.sh and is exercised by tests
t6030.12 and t6030.13 which fail when the /usr/xpg4/bin/sh shell is used.

Add a test that will fail sooner and more precisely than the t6030 tests.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Improvements to the commit message are welcome.

-brandon


 t/t0005-signals.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 09f855a..cb68d1f 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -19,4 +19,12 @@ test_expect_success 'sigchain works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'trap triggered in deeply nested function works correctly' '
+	(atrap () { exit 0; }
+	 func3 () { exit 1; }
+	 func2 () { func3; }
+	 func1 () { trap atrap EXIT; func2; }
+	 func1)
+'
+
 test_done
-- 
1.6.6.2
