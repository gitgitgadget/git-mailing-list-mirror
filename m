From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 1/3] Prepare for non-interactive merge-preserving rebase
Date: Tue, 23 Sep 2008 22:57:26 +0200
Message-ID: <48D95836.6040200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:58:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiEy7-00081W-F2
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 22:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbYIWU5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 16:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbYIWU5f
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 16:57:35 -0400
Received: from mail.op5.se ([193.201.96.20]:55920 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972AbYIWU5e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 16:57:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5CD9D24B0013;
	Tue, 23 Sep 2008 22:48:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.281
X-Spam-Level: 
X-Spam-Status: No, score=-3.281 tagged_above=-10 required=6.6
	tests=[AWL=-0.782, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w15WE93N4onq; Tue, 23 Sep 2008 22:48:02 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 75AB21B8004D;
	Tue, 23 Sep 2008 22:48:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96593>

This patch adds two tests (really three, but one of
them just handles setup) which we currently expect
to fail.

One of them tests "git rebase -p", without the -i flag,
to make sure it works without phony editors and suchlike.

The other tests "git pull --rebase --preserve-merges"
to make sure that the same functionality exists there.

The test was originally written by Stephen Habermann
<stephen@exigencecorp.com> but has been significantly
modified since its creation.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---

Stephen, I had to modify the tests a bit to get them to work with
how I implemented the merge-preserving rebase, and also to remove
a lot of the cruft that was previously in there. Hope you're ok
with the attribution in the commit message.

 t/t3409-rebase-preserve-merges.sh |   68 +++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 t/t3409-rebase-preserve-merges.sh

diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
new file mode 100644
index 0000000..532b220
--- /dev/null
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+#
+# Copyright(C) 2008 Stephen Habermann & Andreas Ericsson
+#
+test_description='git rebase -p should preserve merges
+
+This test runs various incantations of "git rebase -p" and checks
+that merges are properly carried along
+'
+. ./test-lib.sh
+
+GIT_AUTHOR_EMAIL=bogus_email_address
+export GIT_AUTHOR_EMAIL
+
+#echo 'Setting up:
+#
+#A1--A2  <-- origin/master
+# \   \
+#  B1--M  <-- topic
+#   \
+#    B2  <-- origin/topic
+#
+#'
+
+test_expect_success 'setup for merge-preserving rebase' \
+	'echo First > A &&
+	git add A &&
+	git-commit -m "Add A1" &&
+	git checkout -b topic &&
+	echo Second > B &&
+	git add B &&
+	git-commit -m "Add B1" &&
+	git checkout -f master &&
+	echo Third >> A &&
+	git-commit -a -m "Modify A2" &&
+
+	git clone ./. clone1 &&
+	cd clone1 &&
+	git checkout -b topic origin/topic &&
+	git merge origin/master &&
+	cd ..
+
+	git clone ./. clone2
+	cd clone2 &&
+	git checkout -b topic origin/topic &&
+	git merge origin/master &&
+	cd .. &&
+
+	git checkout topic &&
+	echo Fourth >> B &&
+	git commit -a -m "Modify B2"
+'
+
+test_expect_failure 'git pull --rebase -p on moved topic' '
+	cd clone1 &&
+	git pull --rebase --preserve-merges &&
+	test $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) = 1
+'
+
+test_expect_failure 'rebase -p merge on moved topic' '
+	cd ../clone2 &&
+	git fetch &&
+	git rebase -p origin/topic &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge commit" | wc -l)
+'
+
+test_done
-- 
1.6.0.2.307.gc4275.dirty
