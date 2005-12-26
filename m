From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC] t5500 considered dangerous
Date: Tue, 27 Dec 2005 00:35:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512270018310.3067@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Dec 27 00:35:30 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Er1sE-0002iI-47
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 00:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVLZXfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 18:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbVLZXfX
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 18:35:23 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:32930 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932157AbVLZXfW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 18:35:22 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP id AA403E1024
	for <git@vger.kernel.org>; Tue, 27 Dec 2005 00:35:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 9D626158F
	for <git@vger.kernel.org>; Tue, 27 Dec 2005 00:35:21 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 7D2618E7
	for <git@vger.kernel.org>; Tue, 27 Dec 2005 00:35:21 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 6D77313943E
	for <git@vger.kernel.org>; Tue, 27 Dec 2005 00:35:21 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14064>


'corrupt a pack and see if verify catches' is bound to fail sometimes for 
non-obvious reasons:

The test case corrupts a pack, and then also the index of that pack, by 
writing "0" at certain offsets, and then tests if git-verify-pack fails.

However, said pack contains a commit, which is variable by virtue of 
storing two dates. Therefore, the deflated objects are no longer 
deterministic, and neither the pack. What happens is that in roughly every 
256th run, there *is* a 0 at one of these offsets, and the test fails.

This patch makes the test deterministic by skipping the commit.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I just hunted down a bug which showed up very rarely, and it did 
	not make the hunting easier.

 t/t5300-pack-object.sh |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index df6549c..d6b6697 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -20,12 +20,11 @@ test_expect_success \
      done &&
      cat c >d && echo foo >>d && git-update-index --add d &&
      tree=`git-write-tree` &&
-     commit=`git-commit-tree $tree </dev/null` && {
+     {
 	 echo $tree &&
-	 echo $commit &&
 	 git-ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
      } >obj-list && {
-	 git-diff-tree --root -p $commit &&
+	 git-diff-tree --root -p $tree &&
 	 while read object
 	 do
 	    t=`git-cat-file -t $object` &&
@@ -99,7 +98,7 @@ test_expect_success \
      GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      cp test-1-${packname_1}.pack test-1-${packname_1}.idx .git2/objects/pack && {
-	 git-diff-tree --root -p $commit &&
+	 git-diff-tree --root -p $tree &&
 	 while read object
 	 do
 	    t=`git-cat-file -t $object` &&
@@ -114,7 +113,7 @@ test_expect_success \
      export GIT_OBJECT_DIRECTORY &&
      rm -f .git2/objects/pack/test-?.idx &&
      cp test-2-${packname_2}.pack test-2-${packname_2}.idx .git2/objects/pack && {
-	 git-diff-tree --root -p $commit &&
+	 git-diff-tree --root -p $tree &&
 	 while read object
 	 do
 	    t=`git-cat-file -t $object` &&
