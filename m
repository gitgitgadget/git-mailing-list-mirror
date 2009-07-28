From: James Pickens <james.e.pickens@intel.com>
Subject: [PATCH 1/2] Demonstrate bugs when a directory is replaced with a symlink.
Date: Tue, 28 Jul 2009 15:13:17 -0700
Message-ID: <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
Cc: barvik@broadpark.no, James Pickens <james.e.pickens@intel.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 29 00:13:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVuvN-0004JS-4m
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 00:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755752AbZG1WNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 18:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755648AbZG1WNW
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 18:13:22 -0400
Received: from mga07.intel.com ([143.182.124.22]:50323 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755568AbZG1WNV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 18:13:21 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 28 Jul 2009 15:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.43,284,1246863600"; 
   d="scan'208";a="169887136"
Received: from sedona.ch.intel.com ([143.182.201.200])
  by azsmga001.ch.intel.com with ESMTP; 28 Jul 2009 15:13:20 -0700
Received: from chlr11231.ch.intel.com (chlr11231.ch.intel.com [143.182.208.231])
	by sedona.ch.intel.com (8.12.11.20060308/8.14.3/Standard MailSET/Hub) with ESMTP id n6SMDJYs004414;
	Tue, 28 Jul 2009 15:13:19 -0700
Received: from chlr11231.ch.intel.com (localhost [127.0.0.1])
	by chlr11231.ch.intel.com (8.13.6/MailSET/client) with ESMTP id n6SMDJDp014110;
	Tue, 28 Jul 2009 15:13:19 -0700
Received: (from jepicken@localhost)
	by chlr11231.ch.intel.com (8.13.6/8.13.6/Submit) id n6SMDJoZ014106;
	Tue, 28 Jul 2009 15:13:19 -0700
X-Mailer: git-send-email 1.6.2.5.1
In-Reply-To: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124286>

This test creates two directories, a/b and a/b-2, then replaces a/b with
a symlink to a/b-2, then merges that change into another branch that
contains an unrelated change.

There are two bugs:
1. 'git checkout' wrongly deletes work tree file a/b-2/d.
2. 'git merge' wrongly deletes work tree file a/b-2/d.

Signed-off-by: James Pickens <james.e.pickens@intel.com>
---
 t/t6035-merge-dir-to-symlink.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100755 t/t6035-merge-dir-to-symlink.sh

diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
new file mode 100755
index 0000000..926c8ed
--- /dev/null
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -0,0 +1,32 @@
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
+	rm -rf a/b &&
+	ln -s b-2 a/b &&
+	git add -A &&
+	git commit -m "dir to symlink"
+'
+
+test_expect_failure 'checkout should not delete a/b-2/c/d' '
+	git checkout -b temp HEAD^ &&
+	test -f a/b-2/c/d
+'
+
+test_expect_failure 'merge should not delete a/b-2/c/d' '
+	echo x > a/x &&
+	git add a/x &&
+	git commit -m x &&
+	git merge master &&
+	test -f a/b-2/c/d
+'
+
+test_done
-- 
1.6.2.5.1
