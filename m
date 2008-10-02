From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] tests: add a testcase for "git submodule sync"
Date: Thu,  2 Oct 2008 01:55:12 -0700
Message-ID: <5ec2a738cfc257358c29ea08ceb37b01cf4fe4a0.1222937671.git.davvid@gmail.com>
Cc: git@vger.kernel.org, mlevedahl@gmail.com, gitster@pobox.com,
	David Aguilar <davvid@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Oct 02 11:02:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlK4b-0001KF-HY
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 11:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbYJBJA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 05:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbYJBJA5
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 05:00:57 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:7598 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbYJBJA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 05:00:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so478725wah.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=m/LXzVND3ziQp054WsiDKWoopeng546+xg9Us6A1HR0=;
        b=cRZNY+aPfvJRpQelP23S5jTB5f1vZT95zyjxEhMabCqjx7pLGU906OX6QWI0XGMlRo
         vW32lOIBpArsqeDPHFf71fUrRHPFzrbh6FpzlzrUtRtcgM61H11S1fQHHyckCCx13Rke
         eIyJVgzeMcEGJmf23uRfL7Rhuxlh7OTOwgiws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hBQJk980ohfKdFNAEy6TuKHH5P2jJ6OHjHCuyFVXjwRd7vilpZM5JEX8oKAdGDInkP
         AAEW2e3gMPR5h5UmiHaxqgXOePNy/y65iwuK3gHvpripQ+BKQCMpbA9H9vMuBrn2BaD6
         bff9vH01Bv9AZV2QS3M5T1Iw5KKdYCFuMF6bo=
Received: by 10.114.124.1 with SMTP id w1mr10473134wac.73.1222938055733;
        Thu, 02 Oct 2008 02:00:55 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l37sm4349421waf.23.2008.10.02.02.00.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 02:00:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.428.g5e22e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97298>

This testcase ensures that upstream changes to submodule properties
can be updated using the sync subcommand.  This particular test
changes the submodule URL upstream and uses the sync command to update
an existing checkout.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7403-submodule-sync.sh |   71 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
new file mode 100755
index 0000000..c034c9e
--- /dev/null
+++ b/t/t7403-submodule-sync.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 David Aguilar
+#
+
+test_description='git submodule sync
+
+These tests exercise the "git submodule sync" subcommand.
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir upstream &&
+	(cd upstream &&
+	 git init &&
+	 echo file > file &&
+	 git add file &&
+	 test_tick &&
+	 git commit -m upstream
+	) &&
+	git clone upstream super &&
+	git clone super submodule &&
+	(cd super &&
+	 git submodule add ../submodule submodule &&
+	 git commit -m "submodule"
+	) &&
+	git clone super super-clone &&
+	(cd super-clone && git submodule update --init)
+'
+
+test_expect_success 'change submodule' '
+	(cd submodule &&
+	 echo second line >> file &&
+	 test_tick &&
+	 git commit -a -m "change submodule"
+	)
+'
+
+test_expect_success 'change submodule url' '
+	(cd super &&
+	 cd submodule &&
+	 git checkout master && 
+	 test_tick &&
+	 git pull
+	) &&
+	mv submodule moved-submodule &&
+	(cd super &&
+	 git config -f .gitmodules submodule.submodule.url ../moved-submodule
+	 test_tick &&
+	 git commit -a -m moved-submodule
+	)
+'
+
+test_expect_success '"git submodule sync" should update submodule URLs' '
+	(cd super-clone &&
+	 git pull &&
+	 test_tick &&
+	 git submodule sync
+	) &&
+	test_tick &&
+	test -d "$(git config -f super-clone/submodule/.git/config \
+	                        remote.origin.url)" &&
+	(cd super-clone/submodule &&
+	 git checkout master &&
+	 test_tick &&
+	 git pull
+	)
+'
+
+test_done
-- 
1.6.0.2.428.g5e22e
