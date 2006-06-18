From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add renaming-rebase test.
Date: Sun, 18 Jun 2006 04:48:26 -0700
Message-ID: <7vslm21y7p.fsf@assigned-by-dhcp.cox.net>
References: <1150599735483-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 13:48:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrvlW-0004mf-3V
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 13:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWFRLs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 07:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWFRLs1
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 07:48:27 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:16861 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932179AbWFRLs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 07:48:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618114826.TTON18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Jun 2006 07:48:26 -0400
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22074>

This tests Eric's "renaming rebase" patch.  It tests only very
basic cases and most of the tests except the last one passes.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 t/t3402-rebase-merge.sh |   96 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
new file mode 100755
index 0000000..8c7a519
--- /dev/null
+++ b/t/t3402-rebase-merge.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Junio C Hamano
+#
+
+test_description='git rebase --merge test'
+
+. ./test-lib.sh
+
+T="A quick brown fox
+jumps over the lazy dog."
+for i in 1 2 3 4 5 6 7 8 9 10
+do
+	echo "$i $T"
+done >original
+
+test_expect_success setup '
+	git add original &&
+	git commit -m"initial" &&
+	git branch side &&
+	echo "11 $T" >>original &&
+	git commit -a -m"master updates a bit." &&
+
+	echo "12 $T" >>original &&
+	git commit -a -m"master updates a bit more." &&
+
+	git checkout side &&
+	(echo "0 $T" ; cat original) >renamed &&
+	git add renamed &&
+	git update-index --force-remove original &&
+	git commit -a -m"side renames and edits." &&
+
+	tr "[a-z]" "[A-Z]" <original >newfile &&
+	git add newfile &&
+	git commit -a -m"side edits further." &&
+
+	tr "[a-m]" "[A-M]" <original >newfile &&
+	rm -f original &&
+	git commit -a -m"side edits once again." &&
+
+	git branch test-rebase side &&
+	git branch test-rebase-pick side &&
+	git branch test-reference-pick side &&
+	git checkout -b test-merge side
+'
+
+test_expect_success 'reference merge' '
+	git merge -s recursive "reference merge" HEAD master
+'
+
+test_expect_success rebase '
+	git checkout test-rebase &&
+	git rebase --merge master
+'
+
+test_expect_success 'merge and rebase should match' '
+	git diff-tree -r test-rebase test-merge >difference &&
+	if test -s difference
+	then
+		cat difference
+		(exit 1)
+	else
+		echo happy
+	fi
+'
+
+test_expect_success 'rebase the other way' '
+	git reset --hard master &&
+	git rebase --merge side
+'
+
+test_expect_success 'merge and rebase should match' '
+	git diff-tree -r test-rebase test-merge >difference &&
+	if test -s difference
+	then
+		cat difference
+		(exit 1)
+	else
+		echo happy
+	fi
+'
+
+test_expect_success 'picking rebase' '
+	git reset --hard side &&
+	git rebase --merge --onto master side^^ &&
+	mb=$(git merge-base master HEAD) &&
+	if test "$mb" = "$(git rev-parse master)"
+	then
+		echo happy
+	else
+		git show-branch
+		(exit 1)
+	fi
+'
+
+test_done
-- 
1.4.0.g1910f
