From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v4 4/5] checkout: implement "-" abbreviation, add docs and tests
Date: Sat, 17 Jan 2009 17:09:56 +0100
Message-ID: <1232208597-29249-5-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <1232208597-29249-1-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-2-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-3-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-4-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:11:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODld-0001Pe-6i
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762422AbZAQQKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761813AbZAQQKA
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:10:00 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:39223 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757213AbZAQQJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:09:54 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:09:52 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:09:52 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232208597-29249-4-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 16:09:52.0222 (UTC) FILETIME=[0787A7E0:01C978BE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106073>

Have '-' mean the same as '@{-1}', i.e., the last branch we were on.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-checkout.txt |    4 +++
 builtin-checkout.c             |    3 ++
 t/t2012-checkout-last.sh       |   50 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100755 t/t2012-checkout-last.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9cd5151..3bccffa 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -133,6 +133,10 @@ the conflicted merge in the specified paths.
 +
 When this parameter names a non-branch (but still a valid commit object),
 your HEAD becomes 'detached'.
++
+As a special case, the "`@\{-N\}`" syntax for the N-th last branch
+checks out the branch (instead of detaching).  You may also specify
+"`-`" which is synonymous with "`@\{-1\}`".
 
 
 Detached HEAD
diff --git a/builtin-checkout.c b/builtin-checkout.c
index dc1de06..b0a101b 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -679,6 +679,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		arg = argv[0];
 		has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
 
+		if (!strcmp(arg, "-"))
+			arg = "@{-1}";
+
 		if (get_sha1(arg, rev)) {
 			if (has_dash_dash)          /* case (1) */
 				die("invalid reference: %s", arg);
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
new file mode 100755
index 0000000..320f6eb
--- /dev/null
+++ b/t/t2012-checkout-last.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='checkout can switch to last branch'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello >world &&
+	git add world &&
+	git commit -m initial &&
+	git branch other &&
+	echo "hello again" >>world &&
+	git add world &&
+	git commit -m second
+'
+
+test_expect_success '"checkout -" does not work initially' '
+	test_must_fail git checkout -
+'
+
+test_expect_success 'first branch switch' '
+	git checkout other
+'
+
+test_expect_success '"checkout -" switches back' '
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
+test_expect_success '"checkout -" switches forth' '
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/other"
+'
+
+test_expect_success 'detach HEAD' '
+	git checkout $(git rev-parse HEAD)
+'
+
+test_expect_success '"checkout -" attaches again' '
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/other"
+'
+
+test_expect_success '"checkout -" detaches again' '
+	git checkout - &&
+	test "z$(git rev-parse HEAD)" = "z$(git rev-parse other)" &&
+	test_must_fail git symbolic-ref HEAD
+'
+
+test_done
-- 
1.6.1.315.g92577
