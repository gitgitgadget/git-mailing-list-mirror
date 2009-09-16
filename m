From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/4] reset: add a few tests for "git reset --merge"
Date: Wed, 16 Sep 2009 06:14:39 +0200
Message-ID: <20090916041443.3737.86878.chriscool@tuxfamily.org>
References: <20090916035131.3737.33020.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paolo Bonzini <bonzini@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 06:20:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnm0W-0007HV-Uc
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 06:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbZIPEUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 00:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbZIPEUa
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 00:20:30 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:54679 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbZIPEU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 00:20:28 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9219E8180E5;
	Wed, 16 Sep 2009 06:20:22 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 83F668180D3;
	Wed, 16 Sep 2009 06:20:20 +0200 (CEST)
X-git-sha1: a262c25d56fb5b41bbda1c403517f593e8c76863 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090916035131.3737.33020.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128604>

Commit 9e8eceab ("Add 'merge' mode to 'git reset'", 2008-12-01),
added the --merge option to git reset, but there were no test cases
for it.

This was not a big problem because "git reset" was just forking and
execing "git read-tree", but this will change in a following patch.

So let's add a few test cases to make sure that there will be no
regression.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7110-reset-merge.sh |   68 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100755 t/t7110-reset-merge.sh

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
new file mode 100755
index 0000000..1ec32f9
--- /dev/null
+++ b/t/t7110-reset-merge.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Christian Couder
+#
+
+test_description='Tests for "git reset --merge"'
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
+test_expect_success 'reset --merge is ok with changes in file it does not touch' '
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
+test_expect_success 'reset --merge discards changes added to index (1)' '
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
+test_expect_success 'reset --merge discards changes added to index (2)' '
+     echo "line 4" >> file2 &&
+     git add file2 &&
+     git reset --merge HEAD^ &&
+     ! grep 4 file2 &&
+     git reset --merge HEAD@{1} &&
+     ! grep 4 file2 &&
+     grep 4 file1
+'
+
+test_expect_success 'reset --merge fails with changes in file it touches' '
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
1.6.5.rc0.150.g38fe6
