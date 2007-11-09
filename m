From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 3/4] Add tests for git push'es mirror mode
Date: Fri, 9 Nov 2007 23:32:41 -0000
Message-ID: <1194651161.0@pinky>
References: <20071109233041.GC301@shadowen.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 00:33:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqdLB-0003DW-NT
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156AbXKIXcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 18:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758828AbXKIXcc
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:32:32 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3510 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756959AbXKIXcb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 18:32:31 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IqdKv-0006cg-MF
	for git@vger.kernel.org; Fri, 09 Nov 2007 23:32:29 +0000
InReply-To: <20071109233041.GC301@shadowen.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64279>


Add some tests for git push --mirror mode.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 t/t5517-push-mirror.sh |  228 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 228 insertions(+), 0 deletions(-)
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
new file mode 100755
index 0000000..0fc6778
--- /dev/null
+++ b/t/t5517-push-mirror.sh
@@ -0,0 +1,228 @@
+#!/bin/sh
+
+test_description='pushing to a mirror repository'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+invert () {
+	if "$@"; then
+		return 1
+	else
+		return 0
+	fi
+}
+
+mk_repo_pair () {
+	rm -rf master mirror &&
+	mkdir mirror &&
+	(
+		cd mirror &&
+		git init
+	) &&
+	mkdir master &&
+	(
+		cd master &&
+		git init &&
+		git config remote.up.url ../mirror
+	)
+}
+
+
+# BRANCH tests
+test_expect_success 'push mirror does not create new branches' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master"
+
+'
+
+test_expect_success 'push mirror does not update existing branches' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git push --mirror up &&
+		echo two >foo && git add foo && git commit -m two &&
+		git push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master"
+
+'
+
+test_expect_success 'push mirror does not force update existing branches' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git push --mirror up &&
+		echo two >foo && git add foo && git commit -m two &&
+		git push --mirror up &&
+		git reset --hard HEAD^
+		git push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master"
+
+'
+
+test_expect_success 'push mirror does not remove branches' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch remove master &&
+		git push --mirror up &&
+		git branch -D remove
+		git push --mirror up
+	) &&
+	(
+		cd mirror &&
+		invert git show-ref -s --verify refs/heads/remove
+	)
+
+'
+
+test_expect_success 'push mirror does not add, update and remove branches together' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch remove master &&
+		git push --mirror up &&
+		git branch -D remove &&
+		git branch add master &&
+		echo two >foo && git add foo && git commit -m two &&
+		git push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	master_add=$(cd master && git show-ref -s --verify refs/heads/add) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	mirror_add=$(cd mirror && git show-ref -s --verify refs/heads/add) &&
+	test "$master_master" = "$mirror_master" &&
+	test "$master_add" = "$mirror_add" &&
+	(
+		cd mirror &&
+		invert git show-ref -s --verify refs/heads/remove
+	)
+
+'
+
+
+# TAG tests
+test_expect_success 'push mirror does not create new tags' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git tag -f tmaster master &&
+		git push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/tags/tmaster) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/tags/tmaster) &&
+	test "$master_master" = "$mirror_master"
+
+'
+
+test_expect_success 'push mirror does not update existing tags' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git tag -f tmaster master &&
+		git push --mirror up &&
+		echo two >foo && git add foo && git commit -m two &&
+		git tag -f tmaster master &&
+		git push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/tags/tmaster) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/tags/tmaster) &&
+	test "$master_master" = "$mirror_master"
+
+'
+
+test_expect_success 'push mirror does not force update existing tags' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git tag -f tmaster master &&
+		git push --mirror up &&
+		echo two >foo && git add foo && git commit -m two &&
+		git tag -f tmaster master &&
+		git push --mirror up &&
+		git reset --hard HEAD^
+		git tag -f tmaster master &&
+		git push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/tags/tmaster) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/tags/tmaster) &&
+	test "$master_master" = "$mirror_master"
+
+'
+
+test_expect_success 'push mirror does not remove tags' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git tag -f tremove master &&
+		git push --mirror up &&
+		git tag -d tremove
+		git push --mirror up
+	) &&
+	(
+		cd mirror &&
+		invert git show-ref -s --verify refs/tags/tremove
+	)
+
+'
+
+test_expect_success 'push mirror does not add, update and remove tags together' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git tag -f tmaster master &&
+		git tag -f tremove master &&
+		git push --mirror up &&
+		git tag -d tremove &&
+		git tag tadd master &&
+		echo two >foo && git add foo && git commit -m two &&
+		git tag -f tmaster master &&
+		git push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/tags/tmaster) &&
+	master_add=$(cd master && git show-ref -s --verify refs/tags/tadd) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/tags/tmaster) &&
+	mirror_add=$(cd mirror && git show-ref -s --verify refs/tags/tadd) &&
+	test "$master_master" = "$mirror_master" &&
+	test "$master_add" = "$mirror_add" &&
+	(
+		cd mirror &&
+		invert git show-ref -s --verify refs/tags/tremove
+	)
+
+'
+
+test_done
