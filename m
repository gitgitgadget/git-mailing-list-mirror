From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3] tests: add a testcase for "git submodule sync"
Date: Thu,  2 Oct 2008 02:11:55 -0700
Message-ID: <4383bf658ddce38cedd33bf388039cb10c004940.1222938595.git.davvid@gmail.com>
Cc: git@vger.kernel.org, mlevedahl@gmail.com, gitster@pobox.com,
	David Aguilar <davvid@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Oct 02 11:18:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlKKg-0006OG-UW
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 11:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbYJBJRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 05:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbYJBJRk
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 05:17:40 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:4491 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbYJBJRj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 05:17:39 -0400
Received: by wa-out-1112.google.com with SMTP id v27so480973wah.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=0qgNf+Q4TudfUQiG/WnGF6nOy0hSuIn5TS6ammwrud0=;
        b=FXOyRbg5koovU+DG6JIm7bOSvZwM84S0B3l4gskpJjsoRE7SdDNL/C9u3UuJPu0KqR
         0NU+dZIztgUmN/LdkD2+95+uWJGtV+SpZIaSXxX+ZX35z0c+Ua5OOvdUpA1G2cBcSoi1
         Abb4Gx3PZPEaCsyrc8CVTRJlyN0msIGUBsCK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kNBgzAtUs1jZ2KiCwD3FCuFuVSoVVMZthmo6LEXXMmcr3ZPDzlB3HJB+G6IZkS+YP5
         aDPD/yjv5r5kuXDIPT0k5ZIVFlW1/JNem8TomXLvLmLEMHSdnhZCjw0+qEN8EX6iBKZT
         97+iDAv9hsxi6tbdF4QvompyWYxvc6u7gIrYo=
Received: by 10.115.32.8 with SMTP id k8mr10480366waj.89.1222939058712;
        Thu, 02 Oct 2008 02:17:38 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m34sm4439688waf.20.2008.10.02.02.17.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 02:17:38 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.428.g5e22e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97299>

This testcase ensures that upstream changes to submodule properties
can be updated using the sync subcommand.  This particular test
changes the submodule URL upstream and uses the sync command to update
an existing checkout.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

 sorry for the noise, :-/ please disregard the last two emails

 t/t7403-submodule-sync.sh |   64 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
new file mode 100755
index 0000000..d9e04d4
--- /dev/null
+++ b/t/t7403-submodule-sync.sh
@@ -0,0 +1,64 @@
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
+	echo file > file &&
+	git add file &&
+	test_tick &&
+	git commit -m upstream
+	git clone . super &&
+	git clone super submodule &&
+	(cd super &&
+	 git submodule add ../submodule submodule &&
+	 test_tick &&
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
+	 git submodule sync
+	) &&
+	test -d "$(git config -f super-clone/submodule/.git/config \
+	                        remote.origin.url)" &&
+	(cd super-clone/submodule &&
+	 git checkout master &&
+	 git pull
+	)
+'
+
+test_done
-- 
1.6.0.2.428.g5e22e
