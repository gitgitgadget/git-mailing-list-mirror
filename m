From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2 1/3] add test cases for "git mv -k"
Date: Wed, 14 Jan 2009 18:03:21 +0100
Message-ID: <1231952603-32527-2-git-send-email-git@drmicha.warpmail.net>
References: <alpine.DEB.1.00.0901141653540.3586@pacific.mpi-cbg.de>
 <1231952603-32527-1-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 18:06:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN9Be-0006nq-P1
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 18:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761163AbZANRDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 12:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760545AbZANRDx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 12:03:53 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56452 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757289AbZANRDw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 12:03:52 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 5E39D210F4E;
	Wed, 14 Jan 2009 12:03:51 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 14 Jan 2009 12:03:51 -0500
X-Sasl-enc: cA1VbyNaObMwSXPRxPJlLTzAUlLAMWL4TxBGF0+EuT8W 1231952630
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C35901C116;
	Wed, 14 Jan 2009 12:03:50 -0500 (EST)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1231952603-32527-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105663>

Add test cases for ignoring nonexisting and untracked files using the -k
option to "git mv". There is one known breakage related to multiple
untracked files specfied as consecutive arguments.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7001-mv.sh |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 575ef5b..5c1485d 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -39,6 +39,31 @@ test_expect_success \
     grep "^R100..*path1/COPYING..*path0/COPYING"'
 
 test_expect_success \
+    'checking -k on non-existing file' \
+    'git mv -k idontexist path0'
+
+test_expect_success \
+    'checking -k on untracked file' \
+    'touch untracked1 &&
+     git mv -k untracked1 path0 &&
+     test -f untracked1 &&
+     test ! -f path0/untracked1'
+
+test_expect_failure \
+    'checking -k on multiple untracked files' \
+    'touch untracked2 &&
+     git mv -k untracked1 untracked2 path0 &&
+     test -f untracked1 &&
+     test -f untracked2 &&
+     test ! -f path0/untracked1
+     test ! -f path0/untracked2'
+
+# clean up the mess in case bad things happen
+rm -f idontexist untracked1 untracked2 \
+     path0/idontexist path0/untracked1 path0/untracked2 \
+     .git/index.lock
+
+test_expect_success \
     'adding another file' \
     'cp "$TEST_DIRECTORY"/../README path0/README &&
      git add path0/README &&
-- 
1.6.0.6
