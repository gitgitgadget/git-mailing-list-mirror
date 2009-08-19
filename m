From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 2/6] Add selftest for 'git submodule foreach'
Date: Wed, 19 Aug 2009 03:45:20 +0200
Message-ID: <1250646324-961-3-git-send-email-johan@herland.net>
References: <1250646324-961-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	mlevedahl@gmail.com, hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 03:46:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdaFx-00074r-2q
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 03:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbZHSBp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 21:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbZHSBpq
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 21:45:46 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64229 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751199AbZHSBpo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 21:45:44 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL00MJTOW9EU70@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:45 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL00EC4OW53WE0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:45 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.19.13316
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1250646324-961-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126495>

The selftest verifies that:
- only checked out submodules are visited by 'git submodule foreach'
- the $path, and $sha1 variables are set correctly for each submodule

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t7407-submodule-foreach.sh |   79 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100755 t/t7407-submodule-foreach.sh

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
new file mode 100755
index 0000000..76e0734
--- /dev/null
+++ b/t/t7407-submodule-foreach.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Johan Herland
+#
+
+test_description='Test "git submodule foreach"
+
+This test verifies that "git submodule foreach" correctly visits all submodules
+that are currently checked out.
+'
+
+. ./test-lib.sh
+
+
+test_expect_success 'setup a submodule tree' '
+	echo file > file &&
+	git add file &&
+	test_tick &&
+	git commit -m upstream
+	git clone . super &&
+	git clone super submodule &&
+	(
+		cd super &&
+		git submodule add ../submodule sub1 &&
+		git submodule add ../submodule sub2 &&
+		git submodule add ../submodule sub3 &&
+		git config -f .gitmodules --rename-section \
+			submodule.sub1 submodule.foo1 &&
+		git config -f .gitmodules --rename-section \
+			submodule.sub2 submodule.foo2 &&
+		git config -f .gitmodules --rename-section \
+			submodule.sub3 submodule.foo3 &&
+		git add .gitmodules
+		test_tick &&
+		git commit -m "submodules" &&
+		git submodule init sub1 &&
+		git submodule init sub2 &&
+		git submodule init sub3
+	) &&
+	(
+		cd submodule &&
+		echo different > file &&
+		git add file &&
+		test_tick &&
+		git commit -m "different"
+	) &&
+	(
+		cd super &&
+		(
+			cd sub3 &&
+			git pull
+		) &&
+		git add sub3 &&
+		test_tick &&
+		git commit -m "update sub3"
+	)
+'
+
+sub1sha1=$(cd super/sub1 && git rev-parse HEAD)
+sub3sha1=$(cd super/sub3 && git rev-parse HEAD)
+
+cat > expect <<EOF
+Entering 'sub1'
+sub1-$sub1sha1
+Entering 'sub3'
+sub3-$sub3sha1
+EOF
+
+test_expect_success 'test basic "submodule foreach" usage' '
+	git clone super clone &&
+	(
+		cd clone &&
+		git submodule update --init -- sub1 sub3 &&
+		git submodule foreach "echo \$path-\$sha1" > ../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.6.4.304.g1365c.dirty
