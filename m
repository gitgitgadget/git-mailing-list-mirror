From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] tests: add a testcase for "git submodule sync"
Date: Thu,  2 Oct 2008 01:29:25 -0700
Message-ID: <7531595ee46ce7a772cd34857019bcd7d9ce6dc1.1222936021.git.davvid@gmail.com>
Cc: git@vger.kernel.org, mlevedahl@gmail.com, gitster@pobox.com,
	David Aguilar <davvid@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Oct 02 10:36:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlJfd-00020g-NT
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 10:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbYJBIfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 04:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbYJBIfM
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 04:35:12 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:5298 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbYJBIfL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 04:35:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so475052wah.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 01:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=m/LXzVND3ziQp054WsiDKWoopeng546+xg9Us6A1HR0=;
        b=YWCRiIB0uWhNEkFErhz7Vs/QX0hlnr7kXXfS6mLziF6VDVvLvaGP45TMT84pQp7V9e
         Vs/Ziduke4wITajFbsM0S0F5jjAIi2ji3sOoy928tqXjeVZCdzY6SHHyvq1uLV8IaPVR
         kRcuUBsj0s1y87MiN1JUlOhVUnioVn7hIzF+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=coMhu2t2zSCP9KHs8mRBp/Wq+AR26O+XZwaIigpcZcfkDLdgH0D6fTnz47cVIt3jWT
         NbbatEoCjgoLyQ8EbICBdtyO73Vuntwws5HLBaOdYS6oAj/7AJ310ZQy6TB6KDULDuRk
         AdqdeDKXAgXNi4d8j7zWlMEugqFFgV6sbw5NU=
Received: by 10.114.89.1 with SMTP id m1mr10437417wab.126.1222936509008;
        Thu, 02 Oct 2008 01:35:09 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l30sm4278634waf.25.2008.10.02.01.35.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 01:35:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.428.g5e22e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97292>

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
