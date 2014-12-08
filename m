From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 11/18] Add a simple test for receive.fsck.*
Date: Mon, 8 Dec 2014 17:15:11 +0100 (CET)
Message-ID: <243e5190b58d0cceeb1e98735253d6506f18ba45.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:15:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0yB-0006Hi-3W
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912AbaLHQPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:15:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:54478 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755907AbaLHQPW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:15:22 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MCcE2-1Y7OdJ3mEM-009QzU;
 Mon, 08 Dec 2014 17:15:11 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:xLVXdx+dAdq3hrDttDmOHQHZlvOI4sVA4RICuwu9l6fyWLJr8ud
 1APIOiWRC8GZiSjQvxLHlKWnYu5rtMYynl81/j77wHdNcU1SH7eQEQun7hy20oqjdetN3Gv
 F2hwwLmLP1avamMUF12hS4WSS7GA/EBg99n+pyjiyUgMA4lGk1nfGi8bni2kJ6TLfZ9FmJk
 F7GWKYTp234FqRX4jWNgQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261065>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5504-fetch-receive-strict.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 69ee13c..db79e56 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -115,4 +115,24 @@ test_expect_success 'push with transfer.fsckobjects' '
 	test_cmp exp act
 '
 
+cat >bogus-commit << EOF
+tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+author Bugs Bunny 1234567890 +0000
+committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+This commit object intentionally broken
+EOF
+
+test_expect_success 'push with receive.fsck.missing-mail = warn' '
+	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	test_must_fail git push --porcelain dst bogus &&
+	git --git-dir=dst/.git config receive.fsck.missing-email warn &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	grep "missing-email" act
+'
+
 test_done
-- 
2.0.0.rc3.9669.g840d1f9
