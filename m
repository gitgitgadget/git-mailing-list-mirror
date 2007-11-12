From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add a test checking if send-pack updated local tracking
	branches correctly
Date: Mon, 12 Nov 2007 22:38:23 +0100
Message-ID: <20071112213823.GB2918@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 22:38:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrgzT-0007gK-S5
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 22:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbXKLVi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 16:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbXKLVi2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 16:38:28 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:45789 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbXKLVi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 16:38:26 -0500
Received: from tigra.home (Faf31.f.strato-dslnet.de [195.4.175.49])
	by post.webmailer.de (mrclete mo51) (RZmta 14.0)
	with ESMTP id a0273bjACH5OMn ; Mon, 12 Nov 2007 22:38:23 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A3105277AE;
	Mon, 12 Nov 2007 22:38:23 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 4AF6856D22; Mon, 12 Nov 2007 22:38:23 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOR49Q==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64714>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t5404-tracking-branches.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100755 t/t5404-tracking-branches.sh

diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
new file mode 100755
index 0000000..20718d4
--- /dev/null
+++ b/t/t5404-tracking-branches.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='tracking branch update checks for git push'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo 1 >file &&
+	git add file &&
+	git commit -m 1 &&
+	git branch b1 &&
+	git branch b2 &&
+	git clone . aa &&
+	git checkout b1 &&
+	echo b1 >>file &&
+	git commit -a -m b1 &&
+	git checkout b2 &&
+	echo b2 >>file &&
+	git commit -a -m b2
+'
+
+test_expect_success 'check tracking branches updated correctly after push' '
+	cd aa &&
+	b1=$(git rev-parse origin/b1) &&
+	b2=$(git rev-parse origin/b2) &&
+	git checkout -b b1 origin/b1 &&
+	echo aa-b1 >>file &&
+	git commit -a -m aa-b1 &&
+	git checkout -b b2 origin/b2 &&
+	echo aa-b2 >>file &&
+	git commit -a -m aa-b2 &&
+	git checkout master &&
+	echo aa-master >>file &&
+	git commit -a -m aa-master &&
+	git push &&
+	test "$(git rev-parse origin/b1)" = "$b1" &&
+	test "$(git rev-parse origin/b2)" = "$b2"
+'
+
+test_done
-- 
1.5.3.5.648.g1e92c
