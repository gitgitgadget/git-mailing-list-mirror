From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] Add test for blame corner cases.
Date: Sat,  5 May 2007 23:02:43 -0700
Message-ID: <11784313642623-git-send-email-junkio@cox.net>
References: <11784313631165-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 08:03:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkZpj-00008i-Kn
	for gcvg-git@gmane.org; Sun, 06 May 2007 08:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbXEFGCs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 02:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbXEFGCr
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 02:02:47 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52405 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636AbXEFGCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 02:02:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506060244.YJOT24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Sun, 6 May 2007 02:02:44 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vi2j1W00X1kojtg0000200; Sun, 06 May 2007 02:02:44 -0400
X-Mailer: git-send-email 1.5.2.rc1.709.g9462
In-Reply-To: <11784313631165-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46297>

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 t/t8003-blame.sh |  132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 132 insertions(+), 0 deletions(-)
 create mode 100755 t/t8003-blame.sh

diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
new file mode 100755
index 0000000..db51b3a
--- /dev/null
+++ b/t/t8003-blame.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+
+test_description='git blame corner cases'
+. ./test-lib.sh
+
+pick_fc='s/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
+
+test_expect_success setup '
+
+	echo A A A A A >one &&
+	echo B B B B B >two &&
+	echo C C C C C >tres &&
+	echo ABC >mouse &&
+	git add one two tres mouse &&
+	test_tick &&
+	GIT_AUTHOR_NAME=Initial git commit -m Initial &&
+
+	cat one >uno &&
+	mv two dos &&
+	cat one >>tres &&
+	echo DEF >>mouse
+	git add uno dos tres mouse &&
+	test_tick &&
+	GIT_AUTHOR_NAME=Second git commit -a -m Second &&
+
+	echo GHIJK >>mouse &&
+	git add mouse &&
+	test_tick &&
+	GIT_AUTHOR_NAME=Third git commit -m Third &&
+
+	cat mouse >cow &&
+	git add cow &&
+	test_tick &&
+	GIT_AUTHOR_NAME=Fourth git commit -m Fourth &&
+
+	{
+		echo ABC
+		echo DEF
+		echo XXXX
+		echo GHIJK
+	} >cow &&
+	git add cow &&
+	test_tick &&
+	GIT_AUTHOR_NAME=Fifth git commit -m Fifth
+'
+
+test_expect_success 'straight copy without -C' '
+
+	git blame uno | grep Second
+
+'
+
+test_expect_success 'straight move without -C' '
+
+	git blame dos | grep Initial
+
+'
+
+test_expect_success 'straight copy with -C' '
+
+	git blame -C1 uno | grep Second
+
+'
+
+test_expect_success 'straight move with -C' '
+
+	git blame -C1 dos | grep Initial
+
+'
+
+test_expect_success 'straight copy with -C -C' '
+
+	git blame -C -C1 uno | grep Initial
+
+'
+
+test_expect_success 'straight move with -C -C' '
+
+	git blame -C -C1 dos | grep Initial
+
+'
+
+test_expect_success 'append without -C' '
+
+	git blame -L2 tres | grep Second
+
+'
+
+test_expect_success 'append with -C' '
+
+	git blame -L2 -C1 tres | grep Second
+
+'
+
+test_expect_success 'append with -C -C' '
+
+	git blame -L2 -C -C1 tres | grep Second
+
+'
+
+test_expect_success 'append with -C -C -C' '
+
+	git blame -L2 -C -C -C1 tres | grep Initial
+
+'
+
+test_expect_success 'blame wholesale copy' '
+
+	git blame -f -C -C1 HEAD^ -- cow | sed -e "$pick_fc" >current &&
+	{
+		echo mouse-Initial
+		echo mouse-Second
+		echo mouse-Third
+	} >expected &&
+	diff -u expected current
+
+'
+
+test_expect_success 'blame wholesale copy and more' '
+
+	git blame -f -C -C1 HEAD -- cow | sed -e "$pick_fc" >current &&
+	{
+		echo mouse-Initial
+		echo mouse-Second
+		echo cow-Fifth
+		echo mouse-Third
+	} >expected &&
+	diff -u expected current
+
+'
+
+test_done
-- 
1.5.2.rc1.709.g9462
