From: Steffen Prohaska <prohaska@zib.de>
Subject: Add case-challenged file system tests
Date: Fri,  8 Feb 2008 08:09:35 +0100
Message-ID: <12024545763364-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 11:08:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNQA8-00060d-Uw
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 11:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933398AbYBHKIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 05:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934433AbYBHKIO
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 05:08:14 -0500
Received: from mailer.zib.de ([130.73.108.11]:36720 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934415AbYBHKIM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 05:08:12 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m1879imQ016368
	for <git@vger.kernel.org>; Fri, 8 Feb 2008 08:09:44 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m1879aYX024894;
	Fri, 8 Feb 2008 08:09:44 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73066>

There have been discussions lately on case-challenging file
systems and UTF normalization on Mac OS X.  I like to see
these problems fixed and would like to start working on a
resolution.  But I did not follow the recent discussions closely.

Is anyone actively orking on these issues?
What is the current status?

The patch below adds two simple tests that currently fail on Mac
and Windows.  I also collected Mitch's test on utf-8 and will
send it as a reply to this mail.  These two patches contain test
cases that should pass, but do currently fail.

    Steffen

-- >8 --
Git behaves strangely (from a user's point of view) on
filesystems that preserve case but do not distinguish filenames
that only differ by case.  The two major examples are Windows and
Mac OS X.  Simple operations such as "git mv" or "git merge" can
fail unexpectedly.

This commit adds two simple tests.  Both tests currently fail on
Windows and Mac, although they pass on Linux.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t0050-filesystems.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100755 t/t0050-filesystems.sh

diff --git a/t/t0050-filesystems.sh b/t/t0050-filesystems.sh
new file mode 100755
index 0000000..953b02b
--- /dev/null
+++ b/t/t0050-filesystems.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='Various filesystems issues'
+
+. ./test-lib.sh
+
+test_expect_success setup '
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
+test_expect_success 'rename (case change)' '
+
+	git mv camelcase CamelCase &&
+	git commit -m "rename"
+
+'
+
+test_expect_success 'merge (case change)' '
+
+	git reset --hard initial &&
+	git merge topic
+
+'
+
+
+test_done
-- 
1.5.4.40.g4a680
