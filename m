From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 4/4] tests: git push mirror mode tests
Date: Thu, 8 Nov 2007 17:01:45 -0000
Message-ID: <1194541305.0@pinky>
References: <20071108165801.GM9736@shadowen.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 18:02:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqAlX-0005gQ-Gr
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 18:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760842AbXKHRBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 12:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760833AbXKHRBh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 12:01:37 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4171 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652AbXKHRBg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 12:01:36 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1IqAl5-0003ur-B7
	for git@vger.kernel.org; Thu, 08 Nov 2007 17:01:35 +0000
InReply-To: <20071108165801.GM9736@shadowen.org>
Received-SPF: pass
X-SPF-Guess: pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64054>


Add some basic tests for git push --mirror mode.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 t/t5517-push-mirror.sh |  101 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
new file mode 100755
index 0000000..1a285d4
--- /dev/null
+++ b/t/t5517-push-mirror.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='pushing to a mirror repository'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+mk_repo_pair () {
+	rm -rf master mirror &&
+	mkdir mirror && cd mirror &&
+		git init &&
+	cd .. &&
+	mkdir master && cd master &&
+		git init &&
+		git config remote.up.url ../mirror &&
+	cd ..
+}
+
+test_expect_success 'push mirror does not create new branches' '
+
+	mk_repo_pair &&
+	cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		master_master=$(git show-ref -s --verify refs/heads/master) &&
+		git push --mirror up &&
+	cd ../mirror &&
+		mirror_master=$(git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master"
+
+'
+
+test_expect_success 'push mirror does not update existing branches' '
+
+	mk_repo_pair &&
+	cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git push --mirror up &&
+		echo two >foo && git add foo && git commit -m two &&
+		master_master=$(git show-ref -s --verify refs/heads/master) &&
+		git push --mirror up &&
+	cd ../mirror &&
+		mirror_master=$(git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master"
+
+'
+
+test_expect_success 'push mirror does not force update existing branches' '
+
+	mk_repo_pair &&
+	cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git push --mirror up &&
+		echo two >foo && git add foo && git commit -m two &&
+		git push --mirror up &&
+		git reset --hard HEAD^
+		master_master=$(git show-ref -s --verify refs/heads/master) &&
+		git push --mirror up &&
+	cd ../mirror &&
+		mirror_master=$(git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master"
+
+'
+
+test_expect_failure 'push mirror does not remove branches' '
+
+	mk_repo_pair &&
+	cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch remove master &&
+		git push --mirror up &&
+		git branch -D remove
+		git push --mirror up &&
+	cd ../mirror &&
+		git show-ref -s --verify refs/heads/remove
+
+'
+
+test_expect_success 'push mirror does not add, update and remove together' '
+
+	mk_repo_pair &&
+	cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch remove master &&
+		git push --mirror up &&
+		git branch -D remove &&
+		git branch add master &&
+		echo two >foo && git add foo && git commit -m two &&
+		master_master=$(git show-ref -s --verify refs/heads/master) &&
+		master_add=$(git show-ref -s --verify refs/heads/add) &&
+		git push --mirror up &&
+	cd ../mirror &&
+		mirror_master=$(git show-ref -s --verify refs/heads/master) &&
+		mirror_add=$(git show-ref -s --verify refs/heads/add) &&
+		test "$master_master" = "$mirror_master" &&
+		test "$master_add" = "$mirror_add" &&
+		! git show-ref -s --verify refs/heads/remove
+
+'
+
+test_done
