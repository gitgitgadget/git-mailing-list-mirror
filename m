From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Add test for git rebase --abort
Date: Fri, 29 Feb 2008 23:08:47 +0100
Message-ID: <1204322927-22407-1-git-send-email-mh@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 29 23:06:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVDN7-00072c-Fj
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 23:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758328AbYB2WFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 17:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758318AbYB2WFd
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 17:05:33 -0500
Received: from vuizook.err.no ([194.24.252.247]:35559 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755397AbYB2WFc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 17:05:32 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVDLz-0005bI-8E; Fri, 29 Feb 2008 23:05:25 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVDPL-0005pm-Qg; Fri, 29 Feb 2008 23:08:47 +0100
X-Mailer: git-send-email 1.5.4.3.340.g97b97.dirty
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75576>

We expect git rebase --abort to come back to the original (pre-rebase)
head, independently from when it's run during a rebase.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

 I wrote this test because I spotted a problem with git rebase --abort, and
 expanded the test to other cases that work, but that it is still better to
 have a test for.

 The failing test is the third. I don't have enough knowledge in git-rebase
 to write an appropriate fix, but the problem seems to be in
 move_to_original_branch, where testing head_name doesn't seem appropriate.

 t/t3407-rebase-abort.sh |   59 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100755 t/t3407-rebase-abort.sh

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
new file mode 100755
index 0000000..abdecc9
--- /dev/null
+++ b/t/t3407-rebase-abort.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='git rebase --abort tests'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo a > a &&
+	git add a &&
+	git commit -m a &&
+	git branch to-rebase &&
+
+	echo b > a &&
+	git commit -a -m b &&
+	echo c > a &&
+	git commit -a -m c &&
+
+	git checkout to-rebase &&
+	echo d > a &&
+	git commit -a -m "merge should fail on this" &&
+	echo e > a &&
+	git commit -a -m "merge should fail on this, too" &&
+	git branch pre-rebase
+'
+
+test_expect_success 'rebase --abort' '
+	! git rebase master &&
+	git rebase --abort &&
+	test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase)
+'
+
+# In case previous test failed
+git reset --hard pre-rebase >&3 2>&4
+rm -rf .dotest # Should be changed whenever rebase stop using .dotest
+
+test_expect_success 'rebase --abort after --skip' '
+	! git rebase master &&
+	! git rebase --skip &&
+	test $(git rev-parse HEAD) = $(git rev-parse master) &&
+	sh -x ../../git-rebase --abort &&
+	test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase)
+'
+
+# In case previous test failed
+git reset --hard pre-rebase >&3 2>&4
+rm -rf .dotest # Should be changed whenever rebase stop using .dotest
+
+test_expect_success 'rebase --abort after --continue' '
+	! git rebase master &&
+	echo c > a &&
+	echo d >> a &&
+	git add a &&
+	! git rebase --continue &&
+	test $(git rev-parse HEAD) != $(git rev-parse master) &&
+	git rebase --abort &&
+	test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase)
+'
+
+test_done
-- 
1.5.4.3.340.g97b97.dirty

