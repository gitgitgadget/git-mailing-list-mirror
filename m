From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] Add a demonstration/test of customized merge.
Date: Tue, 17 Apr 2007 01:08:38 -0700
Message-ID: <11767973192181-git-send-email-junkio@cox.net>
References: <11767973183627-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 10:09:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdikK-0001eI-Lo
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 10:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbXDQIIr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 04:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbXDQIIr
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 04:08:47 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44605 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbXDQIIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 04:08:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417080839.TZNZ1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Tue, 17 Apr 2007 04:08:39 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id o88e1W01q1kojtg0000300; Tue, 17 Apr 2007 04:08:39 -0400
X-Mailer: git-send-email 1.5.1.1.125.g402f-dirty
In-Reply-To: <11767973183627-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44741>

This demonstrates how the new low-level per-path merge backends,
union and ours, and shows how they are controlled by the
gitattribute mechanism.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 t/t6026-merge-attr.sh |   72 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)
 create mode 100755 t/t6026-merge-attr.sh

diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
new file mode 100755
index 0000000..5daa223
--- /dev/null
+++ b/t/t6026-merge-attr.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Junio C Hamano
+#
+
+test_description='per path merge controlled by merge attribute'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	for f in text binary union
+	do
+		echo Initial >$f && git add $f || break
+	done &&
+	test_tick &&
+	git commit -m Initial &&
+
+	git branch side &&
+	for f in text binary union
+	do
+		echo Master >>$f && git add $f || break
+	done &&
+	test_tick &&
+	git commit -m Master &&
+
+	git checkout side &&
+	for f in text binary union
+	do
+		echo Side >>$f && git add $f || break
+	done &&
+	test_tick &&
+	git commit -m Side
+
+'
+
+test_expect_success merge '
+
+	{
+		echo "binary -merge"
+		echo "union merge=union"
+	} >.gitattributes &&
+
+	if git merge master
+	then
+		echo Gaah, should have conflicted
+		false
+	else
+		echo Ok, conflicted.
+	fi
+'
+
+test_expect_success 'check merge result in index' '
+
+	git ls-files -u | grep binary &&
+	git ls-files -u | grep text &&
+	! (git ls-files -u | grep union)
+
+'
+
+test_expect_success 'check merge result in working tree' '
+
+	git cat-file -p HEAD:binary >binary-orig &&
+	grep "<<<<<<<" text &&
+	cmp binary-orig binary &&
+	! grep "<<<<<<<" union &&
+	grep Master union &&
+	grep Side union
+
+'
+
+test_done
-- 
1.5.1.1.821.g88bdb
