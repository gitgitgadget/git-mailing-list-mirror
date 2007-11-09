From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] tests: git push mirror mode tests V2
Date: Fri, 9 Nov 2007 10:21:13 -0000
Message-ID: <1194603673.0@pinky>
References: <1194541305.0@pinky>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 11:22:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqQzs-00018h-69
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 11:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbXKIKVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 05:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbXKIKVH
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 05:21:07 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:1485 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbXKIKVG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 05:21:06 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1IqQyz-0007D7-PO
	for git@vger.kernel.org; Fri, 09 Nov 2007 10:21:01 +0000
InReply-To: <1194541305.0@pinky>
Received-SPF: pass
X-SPF-Guess: pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64150>


Add some basic tests for git push --mirror mode.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
	Following the discussion on how tests which change directory
	should use subshells to prevent loss of CWD and of how
	! is not something we can rely on, here is an updates to
	the tests.
---
 t/t5517-push-mirror.sh |  125 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 125 insertions(+), 0 deletions(-)
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
new file mode 100755
index 0000000..a65d2f5
--- /dev/null
+++ b/t/t5517-push-mirror.sh
@@ -0,0 +1,125 @@
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
+test_expect_success 'push mirror does not add, update and remove together' '
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
+test_done
