From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] tests: git push mirror mode tests V2 -- add tag tests
Date: Fri, 9 Nov 2007 14:45:55 -0000
Message-ID: <1194619555.0@pinky>
References: <1194603673.0@pinky>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 15:46:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqV7S-0005yq-0d
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 15:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760458AbXKIOpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 09:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760650AbXKIOpq
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 09:45:46 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:1853 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760432AbXKIOpp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 09:45:45 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IqV7A-0001Gs-Ge
	for git@vger.kernel.org; Fri, 09 Nov 2007 14:45:44 +0000
InReply-To: <1194603673.0@pinky>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64194>


Add additional tests to the the V2 tests testing the handling of
tags in --mirror mode.  We expect these to be tracked in line with
the master.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
	Note that this patch is cumulative on top of the following
	patch:
		tests: git push mirror mode tests V2

	These two patches together replace the 4/4 from the original
	series.
---
 t/t5517-push-mirror.sh |  105 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 104 insertions(+), 1 deletions(-)
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index a65d2f5..ec87ce5 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -30,6 +30,7 @@ mk_repo_pair () {
 }
 
 
+# BRANCH tests
 test_expect_success 'push mirror does not create new branches' '
 
 	mk_repo_pair &&
@@ -96,7 +97,7 @@ test_expect_success 'push mirror does not remove branches' '
 
 '
 
-test_expect_success 'push mirror does not add, update and remove together' '
+test_expect_success 'push mirror does not add, update and remove branches together' '
 
 	mk_repo_pair &&
 	(
@@ -122,4 +123,106 @@ test_expect_success 'push mirror does not add, update and remove together' '
 
 '
 
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
 test_done
