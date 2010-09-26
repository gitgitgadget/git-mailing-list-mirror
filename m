From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] t6050 (replace): fix bogus "fetch branch with replacement"
	test
Date: Sun, 26 Sep 2010 07:20:18 +0200
Message-ID: <20100926052019.13598.5764.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 07:25:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozjk8-0002DO-SB
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 07:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902Ab0IZFYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 01:24:01 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47910 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857Ab0IZFYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 01:24:01 -0400
Received: from style.boubyland (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 188DFA61E3;
	Sun, 26 Sep 2010 07:23:54 +0200 (CEST)
X-git-sha1: f9dcb29c9eb8e3f391113d4b5b649a8a651fa7ca 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157211>

The test was missing some "&&" at the end of some lines and it
was wrong because, as the replacement refs were not fetched,
the commits from the parallel branch should not show up. This
was found by Elijah Newren.

This is fixed by checking that after the branch from HASH6 is
fetched, the commits from the parallel branch don't show up,
and then by fetching the replacement refs and checking that
they do show up afterwards.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c907523..95b180f 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -205,9 +205,16 @@ test_expect_success 'fetch branch with replacement' '
      git branch tofetch $HASH6 &&
      (
 	  cd clone_dir &&
-	  git fetch origin refs/heads/tofetch:refs/heads/parallel3
-	  git log --pretty=oneline parallel3 | grep $PARA3
-	  git show $PARA3 | grep "A U Thor"
+	  git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
+	  git log --pretty=oneline parallel3 > output.txt &&
+	  ! grep $PARA3 output.txt &&
+	  git show $PARA3 > para3.txt &&
+	  grep "A U Thor" para3.txt &&
+	  git fetch origin "refs/replace/*:refs/replace/*" &&
+	  git log --pretty=oneline parallel3 > output.txt &&
+	  grep $PARA3 output.txt &&
+	  git show $PARA3 > para3.txt &&
+	  grep "O Thor" para3.txt
      )
 '
 
-- 
1.7.3.256.g00e8a
