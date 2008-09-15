From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Add test that checks octopus merge cleanup
Date: Tue, 16 Sep 2008 00:49:53 +0200
Message-ID: <1221518994-26111-1-git-send-email-trast@student.ethz.ch>
References: <200809160048.31443.trast@student.ethz.ch>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:51:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfMuS-0005PV-SB
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 00:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbYIOWuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 18:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbYIOWuB
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 18:50:01 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:21538 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbYIOWuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 18:50:00 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Sep 2008 00:49:59 +0200
Received: from localhost.localdomain ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Sep 2008 00:49:59 +0200
X-Mailer: git-send-email 1.6.0.2.469.g5ab27
In-Reply-To: <200809160048.31443.trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Sep 2008 22:49:59.0144 (UTC) FILETIME=[618C3E80:01C91785]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95953>

Currently, a conflicted octopus merge leaves the repository in a
"halfway into the merge state", where .git/MERGE_HEAD is missing but
the files are listed as conflicted in the index and have conflict
markers in them.  It should either clean up everything, or add a
MERGE_HEAD.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---
 t/t7607-merge-octopus-cleanup.sh |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/t/t7607-merge-octopus-cleanup.sh b/t/t7607-merge-octopus-cleanup.sh
new file mode 100755
index 0000000..4d82867
--- /dev/null
+++ b/t/t7607-merge-octopus-cleanup.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description='git merge
+
+Testing that conflicting octopus merge fails cleanly.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo initial > foo &&
+	git add foo &&
+	git commit -m initial &&
+	echo a > foo &&
+	git commit -m a foo &&
+	git checkout -b b HEAD^ &&
+	echo b > foo &&
+	git commit -m b foo &&
+	git checkout -b c HEAD^ &&
+	echo c > foo &&
+	git commit -m c foo &&
+	git checkout master
+'
+
+test_expect_failure 'conflicted octopus merge' '
+	test_must_fail git merge b c &&
+	test -z "$(git ls-files --unmerged)" &&
+	test "$(cat foo)" == a &&
+	test ! -f .git/MERGE_HEAD
+'
+
+test_done
-- 
tg: (1293c95..) t/test-octopus-cleanup (depends on: origin/master)
