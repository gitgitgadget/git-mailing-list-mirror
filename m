From: James Pickens <james.e.pickens@intel.com>
Subject: [PATCH 2/2] Demonstrate merge failure when a directory is replaced with a symlink.
Date: Tue, 28 Jul 2009 15:13:18 -0700
Message-ID: <1248819198-13921-3-git-send-email-james.e.pickens@intel.com>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
 <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
Cc: barvik@broadpark.no, James Pickens <james.e.pickens@intel.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 29 00:13:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVuvM-0004JS-De
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 00:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736AbZG1WNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 18:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755574AbZG1WNV
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 18:13:21 -0400
Received: from mga07.intel.com ([143.182.124.22]:50323 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755530AbZG1WNV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 18:13:21 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 28 Jul 2009 15:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.43,284,1246863600"; 
   d="scan'208";a="169887135"
Received: from sedona.ch.intel.com ([143.182.201.200])
  by azsmga001.ch.intel.com with ESMTP; 28 Jul 2009 15:13:20 -0700
Received: from chlr11231.ch.intel.com (chlr11231.ch.intel.com [143.182.208.231])
	by sedona.ch.intel.com (8.12.11.20060308/8.14.3/Standard MailSET/Hub) with ESMTP id n6SMDKeE004417;
	Tue, 28 Jul 2009 15:13:20 -0700
Received: from chlr11231.ch.intel.com (localhost [127.0.0.1])
	by chlr11231.ch.intel.com (8.13.6/MailSET/client) with ESMTP id n6SMDJdM014117;
	Tue, 28 Jul 2009 15:13:19 -0700
Received: (from jepicken@localhost)
	by chlr11231.ch.intel.com (8.13.6/8.13.6/Submit) id n6SMDJdL014113;
	Tue, 28 Jul 2009 15:13:19 -0700
X-Mailer: git-send-email 1.6.2.5.1
In-Reply-To: <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124285>

This test creates two directories, a/b and a/b-2, replaces a/b-2 with a
symlink to a/b, then merges that change into another branch that
contains unrelated changes.  Since the changes are unrelated, the merge
should be free of conflicts, but 'git merge' gives a file/directory
conflict.

Note that this test is almost identical to t6035, except that instead of
replacing a/b with a symlink, it replaces a/b-2 with a symlink.  This
test results in a merge conflict, whereas t6035 does not.

Signed-off-by: James Pickens <james.e.pickens@intel.com>
---
 t/t6036-merge-dir-to-symlink.sh |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100755 t/t6036-merge-dir-to-symlink.sh

diff --git a/t/t6036-merge-dir-to-symlink.sh b/t/t6036-merge-dir-to-symlink.sh
new file mode 100755
index 0000000..020db7c
--- /dev/null
+++ b/t/t6036-merge-dir-to-symlink.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='merging when a directory was replaced with a symlink'
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir -p a/b/c a/b-2/c &&
+	> a/b/c/d &&
+	> a/b-2/c/d &&
+	> a/x &&
+	git add -A &&
+	git commit -m base &&
+	rm -rf a/b-2 &&
+	ln -s b a/b-2 &&
+	git add -A &&
+	git commit -m "dir to symlink"
+'
+
+test_expect_failure 'checkout should not delete a/b/c/d' '
+	git checkout -b temp HEAD^ &&
+	test -f a/b/c/d
+'
+
+test_expect_failure 'merge should not have conflicts' '
+	echo x > a/x &&
+	git add a/x &&
+	git commit -m x &&
+	git merge master'
+
+test_done
-- 
1.6.2.5.1
