From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] t6050: check pushing something based on a replaced commit
Date: Wed, 27 May 2009 07:14:09 +0200
Message-ID: <20090527051410.3789.1705.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 07:19:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9BY4-0004Qv-2e
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 07:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758364AbZE0FTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 01:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757880AbZE0FTX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 01:19:23 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56538 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112AbZE0FTW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 01:19:22 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6AEB48180A6;
	Wed, 27 May 2009 07:19:17 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 730AA818078;
	Wed, 27 May 2009 07:19:15 +0200 (CEST)
X-git-sha1: 5d76b1b10c8b276ad9fca6d395bfcbeca71ec650 
X-Mailer: git-mail-commits v0.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120032>

When using something like:

$ git push $there 04a8c^2:master

we need to parse 04a8c to find its second parent and then start
discussing what object to send with the other end.  "04a8c^2" is a direct
user input and should mean the same commit as git show "04a8c^2" would
give the user, so it obviously needs to obey the replace rules (making
04a8c parsed), but the object transfer should not look at replace at all.

This patch adds some tests to check that the above is working well.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

	Maybe I am missing something but it looks like replacing
	an object directly listed on the command line works.
	And this means that we don't need to unparse commits.

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 448a19a..8b8bd81 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -127,6 +127,74 @@ test_expect_success '"git replace" replacing' '
      test "$HASH2" = "$(git replace)"
 '
 
+# This creates a side branch where the bug in H2
+# does not appear because P2 is created by applying
+# H2 and squashing H5 into it.
+# P3, P4 and P6 are created by cherry-picking H3, H4
+# and H6 respectively.
+#
+# At this point, we should have the following:
+#
+#    P2--P3--P4--P6
+#   /
+# H1-H2-H3-H4-H5-H6-H7
+#
+# Then we replace H6 with P6.
+#
+test_expect_success 'create parallel branch without the bug' '
+     git replace -d $HASH2 &&
+     git show $HASH2 | grep "A U Thor" &&
+     git checkout $HASH1 &&
+     git cherry-pick $HASH2 &&
+     git show $HASH5 | git apply &&
+     git commit --amend -m "hello: 4 more lines WITHOUT the bug" hello &&
+     PARA2=$(git rev-parse --verify HEAD) &&
+     git cherry-pick $HASH3 &&
+     PARA3=$(git rev-parse --verify HEAD) &&
+     git cherry-pick $HASH4 &&
+     PARA4=$(git rev-parse --verify HEAD) &&
+     git cherry-pick $HASH6 &&
+     PARA6=$(git rev-parse --verify HEAD) &&
+     git replace $HASH6 $PARA6 &&
+     git checkout master &&
+     cur=$(git rev-parse --verify HEAD) &&
+     test "$cur" = "$HASH7" &&
+     git log --pretty=oneline | grep $PARA2 &&
+     git remote add cloned ./clone_dir
+'
+
+test_expect_success 'push to cloned repo' '
+     git push cloned $HASH6^:refs/heads/parallel &&
+     cd clone_dir &&
+     git checkout parallel &&
+     git log --pretty=oneline | grep $PARA2 &&
+     cd ..
+'
+
+test_expect_success 'push branch with replacement' '
+     git cat-file commit $PARA3 | grep "author A U Thor" &&
+     S=$(git cat-file commit $PARA3 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
+     git cat-file commit $S | grep "author O Thor" &&
+     git replace $PARA3 $S &&
+     git show $HASH6~2 | grep "O Thor" &&
+     git show $PARA3 | grep "O Thor" &&
+     git push cloned $HASH6^:refs/heads/parallel2 &&
+     cd clone_dir &&
+     git checkout parallel2 &&
+     git log --pretty=oneline | grep $PARA3 &&
+     git show $PARA3 | grep "A U Thor" &&
+     cd ..
+'
+
+test_expect_success 'fetch branch with replacement' '
+     git branch tofetch $HASH6 &&
+     cd clone_dir &&
+     git fetch origin refs/heads/tofetch:refs/heads/parallel3
+     git log --pretty=oneline parallel3 | grep $PARA3
+     git show $PARA3 | grep "A U Thor"
+     cd ..
+'
+
 #
 #
 test_done
-- 
1.6.3.GIT
