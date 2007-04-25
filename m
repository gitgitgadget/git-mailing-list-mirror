From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add a test for merging changed and rename-changed branches
Date: Wed, 25 Apr 2007 22:07:45 +0200
Message-ID: <20070425200745.GC30061@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 22:07:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgnmJ-0001lh-Us
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 22:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993051AbXDYUHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 16:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993050AbXDYUHs
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 16:07:48 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:12488 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993049AbXDYUHr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 16:07:47 -0400
Received: from tigra.home (Fac4b.f.strato-dslnet.de [195.4.172.75])
	by post.webmailer.de (klopstock mo27) (RZmta 5.6)
	with ESMTP id F07492j3PJ8Q9N ; Wed, 25 Apr 2007 22:07:45 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B38A7277BD;
	Wed, 25 Apr 2007 22:07:45 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id AB8A5BDDE; Wed, 25 Apr 2007 22:07:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFqtlg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45560>

Also leave a warning for future merge-recursive explorers.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 merge-recursive.c       |    5 +++++
 t/t6022-merge-rename.sh |   23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 37f1ba9..094ac59 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1345,6 +1345,11 @@ static int process_renames(struct path_list *a_renames,
 				if (mfi.merge && mfi.clean &&
 				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
 				    mfi.mode == ren1->pair->two->mode)
+					/*
+					 * This messaged is part of
+					 * t6022 test. If you change
+					 * it update the test too.
+					 */
 					output(3, "Skipped %s (merged same as existing)", ren1_dst);
 				else {
 					if (mfi.merge || !mfi.clean)
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 99817de..200d9fe 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -47,6 +47,8 @@ git branch white &&
 git branch red &&
 git branch blue &&
 git branch yellow &&
+git branch change &&
+git branch change+rename &&
 
 sed -e "/^g /s/.*/g : master changes a line/" <A >A+ &&
 mv A+ A &&
@@ -77,6 +79,17 @@ rm -f A M &&
 git update-index --add --remove A C M N &&
 git commit -m "blue renames A->C, M->N" &&
 
+git checkout change &&
+sed -e "/^g /s/.*/g : changed line/" <A >A+ &&
+mv A+ A &&
+git commit -q -a -m "changed" &&
+
+git checkout change+rename &&
+sed -e "/^g /s/.*/g : changed line/" <A >B &&
+rm A &&
+git update-index --add B &&
+git commit -q -a -m "changed and renamed" &&
+
 git checkout master'
 
 test_expect_success 'merge renaming branch into unrenaming one' \
@@ -318,4 +331,14 @@ test_expect_success 'interference with untracked working tree file' '
 	git reset --hard anchor
 '
 
+test_expect_success 'merge of identical changes in a renamed file' '
+	rm -f A M N
+	git reset --hard &&
+	git checkout change+rename &&
+	GIT_MERGE_VERBOSITY=3 git merge change | grep "^Skipped B" &&
+	git reset --hard HEAD^ &&
+	git checkout change &&
+	GIT_MERGE_VERBOSITY=3 git merge change+rename | grep "^Skipped B"
+'
+
 test_done
-- 
1.5.2.rc0.63.gdfc8-dirty
