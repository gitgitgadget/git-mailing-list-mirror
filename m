From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] Add tests for filesystem challenges (case and unicode normalization)
Date: Sun, 24 Feb 2008 18:19:09 +0100
Message-ID: <1203873549507-git-send-email-prohaska@zib.de>
References: <7vlk5vjpi4.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, mitcht.git@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 18:21:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTKXx-00073V-R0
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 18:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbYBXRVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 12:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbYBXRVR
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 12:21:17 -0500
Received: from mailer.zib.de ([130.73.108.11]:33768 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbYBXRVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 12:21:17 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m1OHJAC3018351;
	Sun, 24 Feb 2008 18:19:10 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m1OHJ9x1024736;
	Sun, 24 Feb 2008 18:19:09 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <7vlk5vjpi4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74945>

Unfortunately, I had no time to start the real work of fixing the
issues that are tested below.  But at least the tests should be in
good shape now and could be applied.

    Steffen

-- 8< --
Git has difficulties on file systems that do not properly
distinguish case or modify filenames in unexpected ways.  The two
major examples are Windows and Mac OS X.  Both systems preserve
case of file names but do not distinguish between filenames that
differ only by case.  Simple operations such as "git mv" or
"git merge" can fail unexpectedly.  In addition, Mac OS X normalizes
unicode, which make git's life even harder.

This commit adds tests that currently fail but should pass if
file system as decribed above are fully supported.  The test need
to be run on Windows and Mac X as they already pass on Linux.

Mitch Tishmack is the original author of the tests for unicode
normalization.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t0050-filesystem.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100755 t/t0050-filesystem.sh

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
new file mode 100755
index 0000000..a0ab02e
--- /dev/null
+++ b/t/t0050-filesystem.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description='Various filesystem issues'
+
+. ./test-lib.sh
+
+test_expect_success "setup case tests" '
+
+	touch camelcase &&
+	git add camelcase &&
+	git commit -m "initial" &&
+	git tag initial &&
+	git checkout -b topic &&
+	git mv camelcase tmp &&
+	git mv tmp CamelCase &&
+	git commit -m "rename" &&
+	git checkout -f master
+
+'
+
+test_expect_failure 'rename (case change)' '
+
+	git mv camelcase CamelCase &&
+	git commit -m "rename"
+
+'
+
+test_expect_failure 'merge (case change)' '
+
+	git reset --hard initial &&
+	git merge topic
+
+'
+
+auml=`perl -CO -e 'print pack("U",0x00E4)'`
+aumlcdiar=`perl -CO -e 'print pack("U",0x0061).pack("U",0x0308)'`
+test_expect_success "setup unicode normalization tests" "
+
+  test_create_repo unicode &&
+  cd unicode &&
+  touch $aumlcdiar &&
+  git add $aumlcdiar &&
+  git commit -m \"initial\"
+  git tag initial &&
+  git checkout -b topic &&
+  git mv $aumlcdiar tmp &&
+  git mv tmp $auml &&
+  git commit -m \"rename\" &&
+  git checkout -f master
+
+"
+
+test_expect_failure 'rename (silent unicode normalization)' "
+
+ git mv $aumlcdiar $auml &&
+ git commit -m \"rename\"
+
+"
+
+test_expect_failure 'merge (silent unicode normalization)' '
+
+ git reset --hard initial &&
+ git merge topic
+
+'
+
+test_done
-- 
1.5.4.3.310.g78af
