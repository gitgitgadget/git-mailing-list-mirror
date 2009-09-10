From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] reset: add a few tests for "git reset --merge"
Date: Thu, 10 Sep 2009 22:23:29 +0200
Message-ID: <20090910202333.3722.45063.chriscool@tuxfamily.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 22:24:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlqC7-0001fl-7e
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 22:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbZIJUX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 16:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979AbZIJUX6
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 16:23:58 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49943 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134AbZIJUX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 16:23:57 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B4532818057;
	Thu, 10 Sep 2009 22:23:52 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AB314818034;
	Thu, 10 Sep 2009 22:23:49 +0200 (CEST)
X-git-sha1: d42e3b4e511067c0f897de7ec15322ff6d350361 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090910200334.3722.20140.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128143>

Commit 9e8eceab ("Add 'merge' mode to 'git reset'", 2008-12-01),
added the --merge option to git reset, but there were no test cases
for it.

This was not a big problem because "git reset" was just forking and
execing "git read-tree", but this will change in a following patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7110-reset-merge.sh |   70 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100755 t/t7110-reset-merge.sh

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
new file mode 100755
index 0000000..45714ae
--- /dev/null
+++ b/t/t7110-reset-merge.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Christian Couder
+#
+
+test_description='Tests for "git reset --merge"'
+
+exec </dev/null
+
+. ./test-lib.sh
+
+test_expect_success 'creating initial files' '
+     echo "line 1" >> file1 &&
+     echo "line 2" >> file1 &&
+     echo "line 3" >> file1 &&
+     cp file1 file2 &&
+     git add file1 file2 &&
+     test_tick &&
+     git commit -m "Initial commit"
+'
+
+test_expect_success 'ok with changes in file not changed by reset' '
+     echo "line 4" >> file1 &&
+     echo "line 4" >> file2 &&
+     test_tick &&
+     git commit -m "add line 4" file1 &&
+     git reset --merge HEAD^ &&
+     ! grep 4 file1 &&
+     grep 4 file2 &&
+     git reset --merge HEAD@{1} &&
+     grep 4 file1 &&
+     grep 4 file2
+'
+
+test_expect_success 'discard changes added to index 1' '
+     echo "line 5" >> file1 &&
+     git add file1 &&
+     git reset --merge HEAD^ &&
+     ! grep 4 file1 &&
+     ! grep 5 file1 &&
+     grep 4 file2 &&
+     echo "line 5" >> file2 &&
+     git add file2 &&
+     git reset --merge HEAD@{1} &&
+     ! grep 4 file2 &&
+     ! grep 5 file1 &&
+     grep 4 file1
+'
+
+test_expect_success 'discard changes added to index 2' '
+     echo "line 4" >> file2 &&
+     git add file2 &&
+     git reset --merge HEAD^ &&
+     ! grep 4 file2 &&
+     git reset --merge HEAD@{1} &&
+     ! grep 4 file2 &&
+     grep 4 file1
+'
+
+test_expect_success 'not ok with changes in file changed by reset' '
+     echo "line 6" >> file1 &&
+     test_tick &&
+     git commit -m "add line 6" file1 &&
+     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
+     mv file3 file1 &&
+     test_must_fail git reset --merge HEAD^ 2>err.log &&
+     grep file1 err.log | grep "not uptodate"
+'
+
+test_done
-- 
1.6.4.271.ge010d
